{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.Administrador;

interface

uses Facturacion.Comprobante,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.GeneradorSello,
     System.SysUtils,
     Facturacion.ComprobanteV33;

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

  /// <summary>
  ///   Instancia encargada de crear, sellar y guardar los comprobantes
  ///   fiscales.
  /// </summary>
  IAdministradorFacturas = Interface
    ['{F1F6F19F-E988-4F23-99D7-98935BEDEE6D}']
    function GetOnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent; stdcall;
    function GetOnSelloGenerado: TOnSelloGeneradoEvent; stdcall;
    /// <summary>
    ///   Se encarga de crear una nueva instancia del CFDI según el parámetro
    ///   versión especificado
    /// </summary>
    /// <param name="aVersion">
    ///   Versión del CFDI, ejem: 3.3
    /// </param>
    /// <exception cref="EVersionDeCFDINoSoportadaException">
    ///   Excepcion lazanda cuando la versión especificada no está soportada o
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
    ///   Instancia del generador de la cadena original, debe ser especfíco
    ///   para la versión del CFDI
    /// </param>
    /// <param name="aGeneradorSello">
    ///   Sellador del comprobante, debe ser específico para la versión del
    ///   CFDI
    /// </param>
    procedure Sellar(const aComprobante: IComprobanteFiscal; const
        aGeneradorCadenaOriginal: IGeneradorCadenaOriginal; const aGeneradorSello:
        IGeneradorSello);
    /// <summary>
    ///   Método encargado de guardar el CFDI como archivo XML con su encoding
    ///   respectivo en UTF8.
    /// </summary>
    /// <param name="aComprobante">
    ///   Instancia del comprobante
    /// </param>
    /// <param name="aArchivoDestino">
    ///   Ruta completa con nombre incluido del archivo XML donde se guardará
    ///   el comprobante
    /// </param>
    procedure GuardarArchivo(const aComprobante: IComprobanteFiscal;
                             const aArchivoDestino: TFileName);
    procedure SetOnCadenaOriginalGenerada(const Value:
        TOnCadenaOriginalGeneradaEvent); stdcall;
    procedure SetOnSelloGenerado(const Value: TOnSelloGeneradoEvent); stdcall;
    property OnSelloGenerado: TOnSelloGeneradoEvent read GetOnSelloGenerado write
        SetOnSelloGenerado;
    property OnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent read
        GetOnCadenaOriginalGenerada write SetOnCadenaOriginalGenerada;
  End;



  // Implementación de la instancia
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
    property OnSelloGenerado: TOnSelloGeneradoEvent read GetOnSelloGenerado
                                                    write SetOnSelloGenerado;
    property OnCadenaOriginalGenerada: TOnCadenaOriginalGeneradaEvent read GetOnCadenaOriginalGenerada
                                                                      write SetOnCadenaOriginalGenerada;
  end;

implementation

uses System.Classes,
     Xml.XMLDoc,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     Xml.XMLIntf;

{ TAdministradorFacturas }

function TAdministradorFacturas.Nueva(const aVersion: String): IComprobanteFiscal;
begin
  Result := nil;

  if aVersion = '3.3' then
    Result := NewComprobanteFiscalV33;

  if Result = nil then
    raise EVersionDeCFDINoSoportadaException.Create('La versión solicitada : ' + aVersion + ', no tiene implementación actual');
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
  cadenaOriginal := aGeneradorCadenaOriginal.obtenerCadenaOriginal(aComprobante);

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
  Writer: TStreamWriter;
begin
  try
    Writer := TStreamWriter.Create(aArchivoDestino, false, TEncoding.UTF8);
    Writer.Write(aComprobante.XML);
  finally
    Writer.Free();
  end;
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
