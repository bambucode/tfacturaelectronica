{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.Administrador;

interface

uses Facturacion.Comprobante,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.GeneradorSello,
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
;

type

  /// <summary>
  ///   Evento lanzado una vez que se genera la cadena original durante el
  ///   proceso de sellado.
  /// </summary>
  TOnCadenaOriginalGeneradaEvent = procedure(Sender: TObject; const aCadenaOriginal: TCadenaUTF8) of Object;
  /// <summary>
  ///   Evento lanzado una vez que se genera el sello exitosamente
  /// </summary>
  TOnSelloGeneradoEvent = procedure(Sender: TObject; const aSello: TCadenaUTF8) of Object;

  EVersionDeCFDINoSoportadaException = class(Exception);
  EXMLNoEsUnCFDIException = class(Exception);

  /// <summary>
  ///   Instancia encargada de crear, sellar y guardar los comprobantes
  ///   fiscales.
  /// </summary>
  IAdministradorFacturas = Interface
    ['{F1F6F19F-E988-4F23-99D7-98935BEDEE6D}']
    function GetOnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent;
    function GetOnSelloGenerado: TOnSelloGeneradoEvent;
    /// <summary>
    ///   Se encarga de crear una nueva instancia del CFDI seg�n el par�metro
    ///   versi�n especificado
    /// </summary>
    /// <param name="aVersion">
    ///   Versi�n del CFDI, ejem: 3.3
    /// </param>
    /// <exception cref="EVersionDeCFDINoSoportadaException">
    ///   Excepcion lazanda cuando la versi�n especificada no est� soportada o
    ///   implementada.
    /// </exception>
    function Nueva(const aVersion: String) : IComprobanteFiscal;
    /// <summary>
    ///   Se encarga de sellar el comprobante solicitado con las respectivas
    ///   instancias del generador de cadena y sellador que se desee usar.
    /// </summary>
    /// <param name="aComprobante">
    ///   Instancia del CFDI a sellar
    /// </param>
    /// <param name="aGeneradorCadenaOriginal">
    ///   Instancia del generador de la cadena original, debe ser espec�fico
    ///   para la versi�n del CFDI
    /// </param>
    /// <param name="aGeneradorSello">
    ///   Sellador del comprobante, debe ser espec�fico para la versi�n del
    ///   CFDI
    /// </param>
    procedure Sellar(const aComprobante: IComprobanteFiscal; const
        aGeneradorCadenaOriginal: IGeneradorCadenaOriginal; const aGeneradorSello:
        IGeneradorSello);
    /// <summary>
    ///   M�todo encargado de guardar el CFDI como archivo XML con su encoding
    ///   respectivo en UTF8.
    /// </summary>
    /// <param name="aComprobante">
    ///   Instancia del comprobante
    /// </param>
    /// <param name="aArchivoDestino">
    ///   Ruta completa con nombre incluido del archivo XML donde se guardar�
    ///   el comprobante
    /// </param>
    procedure GuardarArchivo(const aComprobante: IComprobanteFiscal;
                             const aArchivoDestino: TFileName);

    function LeerDesdeArchivo(const aRutaComprobante: TFileName) : IComprobanteFiscal;
    function LeerDesdeXML(const aContenidoXML: UnicodeString) : IComprobanteFiscal;
    procedure SetOnCadenaOriginalGenerada(const Value:
        TOnCadenaOriginalGeneradaEvent);
    procedure SetOnSelloGenerado(const Value: TOnSelloGeneradoEvent);
    property OnSelloGenerado: TOnSelloGeneradoEvent read GetOnSelloGenerado write
        SetOnSelloGenerado;
    property OnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent read
        GetOnCadenaOriginalGenerada write SetOnCadenaOriginalGenerada;
  End;



  // Implementaci�n de la instancia
  TAdministradorFacturas = class(TInterfacedObject, IAdministradorFacturas)
  private
    fOnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent;
    fOnSelloGenerado: TOnSelloGeneradoEvent;
    function GetOnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent;
    function GetOnSelloGenerado: TOnSelloGeneradoEvent;
    procedure SetOnCadenaOriginalGenerada(const Value:TOnCadenaOriginalGeneradaEvent);
    procedure SetOnSelloGenerado(const Value: TOnSelloGeneradoEvent);
  public
    function Nueva(const aVersion: String) : IComprobanteFiscal;
    procedure Sellar(const aComprobante: IComprobanteFiscal;
                     const aGeneradorCadenaOriginal: IGeneradorCadenaOriginal;
                     const aGeneradorSello: IGeneradorSello);
    procedure GuardarArchivo(const aComprobante: IComprobanteFiscal;
                             const aArchivoDestino: TFileName);
    function LeerDesdeArchivo(const aRutaComprobante: TFileName) : IComprobanteFiscal;
    function LeerDesdeXML(const aContenidoXML: UnicodeString) : IComprobanteFiscal;
    property OnSelloGenerado: TOnSelloGeneradoEvent read GetOnSelloGenerado
                                                    write SetOnSelloGenerado;
    property OnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent read GetOnCadenaOriginalGenerada
                                                                      write SetOnCadenaOriginalGenerada;
  end;

implementation

uses
{$IF CompilerVersion >= 23}
     System.Classes,
     Xml.XMLDoc,
     Xml.XMLIntf,
{$ELSE}
     Classes,
     XMLDoc,
     XMLIntf,
{$IFEND}
     Facturacion.ComprobanteV32,
     Facturacion.ComprobanteV33,
     Facturacion.ComprobanteV40
     {$IFDEF CODESITE}
     , CodeSiteLogging
     {$ENDIF}
     ;

{ TAdministradorFacturas }

function TAdministradorFacturas.Nueva(const aVersion: String): IComprobanteFiscal;
begin
  Result := nil;

  if aVersion = '3.2' then
    Result := NewComprobanteFiscalV32;

  if aVersion = '3.3' then
    Result := NewComprobanteFiscalV33;

  if aVersion = '4.0' then
    Result := NewComprobanteFiscalV40;

  if Result = nil then
    raise EVersionDeCFDINoSoportadaException.Create('La versi�n solicitada : ' + aVersion + ', no tiene implementaci�n actual');
end;

procedure TAdministradorFacturas.Sellar(const aComprobante: IComprobanteFiscal;
    const aGeneradorCadenaOriginal: IGeneradorCadenaOriginal; const
    aGeneradorSello: IGeneradorSello);
var
  cadenaOriginal, selloDeFactura: TCadenaUTF8;
begin
  Assert(aGeneradorCadenaOriginal <> nil, 'La instancia aGeneradorCadenaOriginal no debio ser nula');
  Assert(aGeneradorSello <> nil, 'La instancia aGeneradorSello no debio ser nula');

  // 1. Intentamos obtener la cadena Original del comprobante
  cadenaOriginal := aGeneradorCadenaOriginal.ObtenerCadenaOriginal(aComprobante);

  // Si tenemos asignado el evento de notificacion de cadena original, lo lanzamos...
  if Assigned(fOnCadenaOriginalGenerada) then
    fOnCadenaOriginalGenerada(Self, cadenaOriginal);

  // 2. Al tener la cadena original mandamos sellar la factura
  selloDeFactura := aGeneradorSello.GenerarSelloDeFactura(cadenaOriginal);

  // Si tenemos asignado el evento de notificacion de sello, lo lanzamos
  if Assigned(fOnSelloGenerado) then
    fOnSelloGenerado(Self, selloDeFactura);

  // 3. Anexamos el sello al comprobante
  aComprobante.Sello := selloDeFactura;
end;

procedure TAdministradorFacturas.GuardarArchivo(const aComprobante: IComprobanteFiscal;
                                                 const aArchivoDestino: TFileName);
var
  {$IF CompilerVersion >= 20}
   Writer: TStreamWriter;
  {$ELSE}
   XML: IXMLDocument;
  {$IFEND}

const
  _ENCABEZADO_XML = '<?xml version="1.0" encoding="utf-8"?>' + #13#10;
begin
  {$IF CompilerVersion >= 20}
   Writer := TStreamWriter.Create(aArchivoDestino, false, TEncoding.UTF8);
  {$ELSE}
   XML := NewXMLDocument;
  {$IFEND}

   try
     // Forzamos a que siempre se incluya el encabezado del XML
    {$IF CompilerVersion >= 20}
     Writer.Write(_ENCABEZADO_XML + aComprobante.XML);
    {$ELSE}

     XML.LoadFromXML( _ENCABEZADO_XML + aComprobante.XML );

     //Esto es necesario para que el Encoding UTF-8 se guarde en el archivo
     Xml.Options := Xml.Options + [doNodeAutoIndent];
     Xml.ParseOptions := Xml.ParseOptions + [poPreserveWhiteSpace];
     Xml.Encoding := 'UTF-8';

     XML.SaveToFile(aArchivoDestino);
    {$IFEND}


   finally
    {$IF CompilerVersion >= 20}
      Writer.Free();
    {$ELSE}
    {$IFEND}
   end;
end;

function TAdministradorFacturas.LeerDesdeArchivo(const aRutaComprobante: TFileName): IComprobanteFiscal;
var
  documentoXML: IXMLDocument;
begin
  documentoXML :=  LoadXMLDocument(aRutaComprobante);
 {$IF CompilerVersion >= 20}
  Result := LeerDesdeXML( documentoXML.XML.Text );
 {$ELSE}
  documentoXML.Options := documentoXML.Options + [doNodeAutoIndent];
  documentoXML.Encoding := 'UTF-8';
  Result := LeerDesdeXML( UTF8Decode( documentoXML.XML.Text ) );
 {$IFEND}
end;

function TAdministradorFacturas.LeerDesdeXML(const aContenidoXML: UnicodeString): IComprobanteFiscal;
var
  documentoXML: IXMLDocument;
  nodoComprobante, nodoVersion: IXMLNode;
  versionCFDI: TCadenaUTF8;
const
  _NOMBRE_NODO_COMPROBANTE = 'Comprobante';
  _NOMBRE_NODO_VERSION     = 'Version';
begin
  documentoXML := TXMLDocument.Create(nil);

  // Pasamos el XML para poder usarlo en la clase
  documentoXML.LoadFromXML(aContenidoXML);

  // Checamos la version del CFDI y dependiendo de ello, usamos el m�todo
  // de lectura correcto
  nodoComprobante := documentoXML.ChildNodes.FindNode(_NOMBRE_NODO_COMPROBANTE);
  if (nodoComprobante <> nil) then
  begin
    // Intentamos obtener el nodo Version en el "case correcto"
    nodoVersion := nodoComprobante.AttributeNodes.FindNode(_NOMBRE_NODO_VERSION);

    // Intentamos con el atributo en minusculas solamente...
    if nodoVersion = nil then
      nodoVersion := nodoComprobante.AttributeNodes.FindNode(LowerCase(_NOMBRE_NODO_VERSION));

    if (nodoVersion <> nil) then
    begin
      versionCFDI := Trim(nodoVersion.Text);

      // Mandamos leer el XML usando la implementaci�n correspondiente
      if (versionCFDI = '3.2') then
        Result := GetComprobanteFiscalV32(documentoXML);

      if (versionCFDI = '3.3') then
        Result := GetComprobanteFiscalV33(documentoXML);

      if (versionCFDI = '4.0') then
        Result := GetComprobanteFiscalV40(documentoXML);
    end;

    if Result = nil then
      raise EVersionDeCFDINoSoportadaException.Create('No es posible leer un CFDI ver. ' + versionCFDI);
  end else
    raise EXMLNoEsUnCFDIException.Create('El XML no parece ser un CFDI, no contiene nodo Comprobante');

end;

function TAdministradorFacturas.GetOnCadenaOriginalGenerada:
    TOnCadenaOriginalGeneradaEvent;
begin
  Result := fOnCadenaOriginalGenerada;
end;

procedure TAdministradorFacturas.SetOnCadenaOriginalGenerada(const Value:
    TOnCadenaOriginalGeneradaEvent);
begin
  fOnCadenaOriginalGenerada := Value;
end;

function TAdministradorFacturas.GetOnSelloGenerado: TOnSelloGeneradoEvent;
begin
  Result := fOnSelloGenerado;
end;

procedure TAdministradorFacturas.SetOnSelloGenerado(const Value:
    TOnSelloGeneradoEvent);
begin
  fOnSelloGenerado := Value;
end;

end.
