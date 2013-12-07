{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
  los metodos para generarla.

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  Cambios para CFDI v3.2 Por Ing. Pablo Torres TecSisNet.net Cd. Juarez Chihuahua
  el 11-24-2013
  ***************************************************************************** *}
unit ComprobanteFiscal;

interface

uses FacturaTipos, SysUtils,
  // Unidades especificas de manejo de XML:
  XmlDom, XMLIntf, MsXmlDom, XMLDoc, DocComprobanteFiscal,
  FeCFDv22,FeCFDv32, FeCFDv2, feCFD;

type

  // Excepciones que pueden ser generadas
  EFECertificadoNoExisteException = class(Exception);
  EFECertificadoNoVigente =  class(Exception);
  EFECertificadoNoFueLeidoException = class(Exception);
  EFEFolioFueraDeRango = class(Exception);
  EXMLVacio = class(Exception);

  /// <summary>Representa la estructura de comprobante fiscal digital (ver2.2) y sus elementos
  /// definidos de acuerdo al XSD del SAT. Esta pensado para ser extendido en las versiones
  /// posteriores que el SAT publique (ver3.0, ver4.0, etc.).
  /// Se encarga de validar y formatear todos los datos de la factura que le sean proporcionados
  /// </summary>
  TFEComprobanteFiscal = class(TDocumentoComprobanteFiscal)
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  private
{$ENDIF}
    // Variables internas
    fDocumentoXML: TXMLDocument;

    // Referencia a un comprobante "comun" que puede ser v2.0 o v2.2  o v3.2
    fXmlComprobante: IFEXMLComprobante;

    // Propiedades exclusivas del comprobante digital:
    fCadenaOriginalCalculada: TStringCadenaOriginal;
    fSelloDigitalCalculado: String;
    fCertificado: TFECertificado;
    fCertificadoTexto: WideString;
    fBloqueFolios: TFEBloqueFolios;
    fTimbre : TFETimbre;
    fVersion : TFEVersionComprobante;
    fComprobanteLleno: Boolean;

    // Opciones de configuracion
    _CADENA_PAGO_UNA_EXHIBICION: String;
    _CADENA_PAGO_PARCIALIDADES: String;
    fDesglosarTotalesImpuestos: Boolean;
    bIncluirCertificadoEnXML: Boolean;
    fAutoAsignarFechaGeneracion: Boolean;


    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Este metodo es llamado cuando estamos generando el XML del
    ///	  comprobante y se encarga de asignar el XML del timbre del nodo
    ///	  "Complemento".
    ///	</summary>
    {$ENDREGION}
    procedure AgregarTimbreFiscalAlXML;
    procedure LlenarComprobante;
    procedure setCertificado(Certificado: TFECertificado);
    function getCadenaOriginal(): TStringCadenaOriginal;
    function getSelloDigital(): String;
    procedure setBloqueFolios(Bloque: TFEBloqueFolios);
    procedure ValidarQueFolioEsteEnRango;
    procedure AsignarCondicionesDePago;
    procedure AsignarEmisor;
    procedure AsignarReceptor;
    procedure AsignarContenidoCertificado;
    procedure AsignarConceptos;
    procedure AsignarImpuestosRetenidos;
    procedure AsignarImpuestosTrasladados;
    procedure AsignarDatosFolios;
    procedure AsignarFolio;
    procedure AsignarFormaDePago;
    procedure AsignarSubtotal;
    procedure AsignarTotal;
    procedure AsignarDescuentos;
    procedure AsignarMetodoDePago;
    procedure AsignarTipoComprobante;
    procedure AsignarExpedidoEn;
    procedure AsignarTotalesImpuestos;
    procedure AsignarFechaGeneracion;
    procedure AsignarLugarExpedicion;
    procedure AsignarNumeroDeCuenta;
    procedure AgregarAtributoOpcionalSiNoEstaVacio(const nodoXML: IXMLNode; const aPropiedad: string;
                                                  const aValorAsignar : String);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Agrega un Domicilio Fiscal de acuerdo a las leyes de validacion de
    ///	  CFDI 3.2
    ///	</summary>
    {$ENDREGION}
    procedure AgregarDireccionFiscalv32(const aNodoContribuyente: IXMLNode; const
        aDireccionContribuyente: TFEDireccion);
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Este metodo es llamado cuando leemos un XML (a través del metodo
    ///	  setXML) para leer las propiedades del TimbreFiscalDigital
    ///	</summary>
    {$ENDREGION}
    procedure LeerPropiedadesDeTimbre;
    procedure EstablecerVersionDelComprobante;
    function GetCadenaOriginalTimbre: TStringCadenaOriginal;
    function GetTimbre: TFETimbre;
    procedure ValidarCamposEmisor;
    procedure ValidarCamposReceptor;
  protected
    fFueTimbrado: Boolean;
    procedure GenerarComprobante;
    function getXML: WideString; virtual;
    procedure setXML(const Valor: WideString); virtual;
{$IFDEF VERSION_DE_PRUEBA}
  public
    _USAR_HORA_REAL : Boolean;
{$ELSE}
  protected
{$ENDIF}
  public
    const VERSION_ACTUAL = '3.2'; // Version del CFD que implementa este código

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Se encarga de crear un nuevo CFD, por default crea el CFD con la
    ///	  versión mas reciente o que debe ser de acuerdo a la vigencia
    ///	</summary>
    ///	<param name="aVersionComprobante">
    ///	  Version del comprobante a crear
    ///	</param>
    {$ENDREGION}
    constructor Create(const aVersionComprobante: TFEVersionComprobante = fev32);
    destructor Destroy(); override;
    procedure Cancelar();

    // Propiedades especificas al comprobante electronico
    property BloqueFolios: TFEBloqueFolios read fBloqueFolios write setBloqueFolios;
    property XML: WideString read getXML write setXML;
    property CadenaOriginal: TStringCadenaOriginal read getCadenaOriginal;
    property SelloDigital: String read getSelloDigital;
    property CertificadoTexto : WideString read fCertificadoTexto write fCertificadoTexto;
    property Certificado: TFECertificado read fCertificado write setCertificado;
    property DesglosarTotalesImpuestos: Boolean read fDesglosarTotalesImpuestos write fDesglosarTotalesImpuestos;
    property IncluirCertificadoEnXml: Boolean read bIncluirCertificadoEnXML write bIncluirCertificadoEnXML default true;
    property AutoAsignarFechaGeneracion : Boolean read fAutoAsignarFechaGeneracion write fAutoAsignarFechaGeneracion default true;
    property CadenaOriginalTimbre: TStringCadenaOriginal read
        GetCadenaOriginalTimbre;
    property Timbre: TFETimbre read GetTimbre;
    property Version : TFEVersionComprobante read fVersion;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Evento llamado cuando hemos recibido el timbre de parte del PAC para
    ///	  asignarle el mismo al CFD de forma interna así como al XML.
    ///	</summary>
    {$ENDREGION}
    procedure AsignarTimbreFiscal(const aTimbre: TFETimbre);
    /// <summary>Guarda una copia del XML en el archivo indicado</summary>
    /// <param name="ArchivoFacturaXML">Ruta completa con nombre de archivo en el que se
    /// almacenara el XML del comprobante</param>
    procedure GuardarEnArchivo(sArchivoDestino: String);
  end;

const
   _CADENA_METODO_PAGO_NO_DISPONIBLE = 'No identificado';

implementation

uses FacturaReglamentacion, ClaseOpenSSL, StrUtils, SelloDigital,
  OpenSSLUtils, Classes, CadenaOriginal,
  CadenaOriginalTimbre,
  {$IFDEF DEBUG} Dialogs, {$ENDIF}
  FeTimbreFiscalDigital,
  {$IFDEF CODESITE}
  CodeSiteLogging,
  {$ENDIF}
  DateUtils;

// Al crear el objeto, comenzamos a "llenar" el XML interno
constructor TFEComprobanteFiscal.Create(const aVersionComprobante:
    TFEVersionComprobante = fev32);
begin
  inherited Create;
  _CADENA_PAGO_UNA_EXHIBICION := 'Pago en una sola exhibición';
  _CADENA_PAGO_PARCIALIDADES := 'En parcialidades';

  {$IFDEF VERSION_DE_PRUEBA}
    _USAR_HORA_REAL := False;
  {$ENDIF}

   // Ahora La decisión de que tipo de comprobante y su versión deberá de ser del programa y no de la clase
  fVersion:=aVersionComprobante;

  // Establecemos como default que SI queremos incluir el certificado en el XML
  // ya que presenta la ventaja de poder validar el comprobante con solo el archivo
  // XML.
  fAutoAsignarFechaGeneracion:=True;
  bIncluirCertificadoEnXML := True;
  fDesglosarTotalesImpuestos := True;
  fCadenaOriginalCalculada:='';
  fSelloDigitalCalculado:='';
  fFueTimbrado := False;

  // Creamos el objeto XML
  fDocumentoXML := TXMLDocument.Create(nil);
  fDocumentoXML.Active := True;

  // Obtenemos el elemento "Comprobante" para llenar sus datos...
  case fVersion of
    fev20: fXmlComprobante := GetComprobante(fDocumentoXML);
    fev22: fXmlComprobante := GetComprobanteV22(fDocumentoXML);
    fev32: fXmlComprobante := GetComprobanteV32(fDocumentoXML);
  end;

  // De acuerdo a los articulos 29 y 29-A del CFF
  EstablecerVersionDelComprobante;
end;

destructor TFEComprobanteFiscal.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  //fXmlComprobante := nil;
  inherited;
end;

procedure TFEComprobanteFiscal.AgregarAtributoOpcionalSiNoEstaVacio(const nodoXML: IXMLNode; const aPropiedad: string;
                                               const aValorAsignar : String);
begin
  // Checamos si el atributo opcional NO esta vacio
  if Trim(aValorAsignar) <> '' then
  begin
    nodoXML.Attributes[aPropiedad] := aValorAsignar;
  end;
end;

procedure TFEComprobanteFiscal.AgregarDireccionFiscalv32(const
    aNodoContribuyente: IXMLNode; const aDireccionContribuyente: TFEDireccion);
begin
  aNodoContribuyente.Attributes['calle'] := TFEReglamentacion.ComoCadena(aDireccionContribuyente.Calle);

  //AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'Calle', aDireccionContribuyente.Calle);
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'noExterior', aDireccionContribuyente.NoExterior);
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'noInterior', aDireccionContribuyente.NoInterior);
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'colonia',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.Colonia));
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'localidad',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.Localidad));
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'referencia',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.Referencia));
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'municipio',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.Municipio));
  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'estado',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.Estado));

  // Requerido
  aNodoContribuyente.Attributes['pais'] := TFEReglamentacion.ComoCadena(aDireccionContribuyente.Pais);

  AgregarAtributoOpcionalSiNoEstaVacio(aNodoContribuyente, 'codigoPostal',
                                       TFEReglamentacion.ComoCadena(aDireccionContribuyente.CodigoPostal));
end;

procedure TFEComprobanteFiscal.AgregarTimbreFiscalAlXML;
var
  xmlTimbrado: WideString;
const
  _CARACTER_RETORNO_DE_CARRO = #13#10;
begin
  Assert(fTimbre.XML <> '', 'El timbre interno fue nulo');

  // Debido a que el nodo XML trae retornos de carro al final, los removemos para no tener diferencias
  // en el XML (por si fue leido)
  xmlTimbrado := StringReplace(fTimbre.XML,
                               _CARACTER_RETORNO_DE_CARRO,
                               '',
                               [rfReplaceAll, rfIgnoreCase]);

  // Creamos un nuevo nodo complemento y le asignamos el XML del Timbre
  // Ref: http://stackoverflow.com/questions/16743380/string-to-xmlnode-delphi-or-how-to-add-an-xml-fragment-to-txmldocument
  IFEXmlComprobanteV32(fXmlComprobante).Complemento.ChildNodes.Add(LoadXMLData(xmlTimbrado).DocumentElement);

  fFueTimbrado := True;
end;

procedure TFEComprobanteFiscal.AsignarCondicionesDePago;
begin
    if Trim(inherited CondicionesDePago) <> '' then
      fXmlComprobante.CondicionesDePago := TFEReglamentacion.ComoCadena(inherited CondicionesDePago);
end;

procedure TFEComprobanteFiscal.AsignarDescuentos;
begin
  // Si el descuento es cero NO lo asignamos en v3.2 ya que se agregaria incorrectamente a la cadena original
  if fVersion = fev32 then
    if (inherited DescuentoMonto) = 0 then
      exit;

  fXmlComprobante.Descuento := TFEReglamentacion.ComoMoneda(inherited DescuentoMonto);
  if Trim(inherited DescuentoMotivo) <> '' then
    fXmlComprobante.MotivoDescuento := TFEReglamentacion.ComoCadena(inherited DescuentoMotivo);
end;

function TFEComprobanteFiscal.getCadenaOriginal(): TStringCadenaOriginal;
var
  CadenaOriginal: TCadenaOriginal;
begin
  if FacturaGenerada = True then
  begin
    Result:=fCadenaOriginalCalculada;
  end else
  begin
    // Si aun no ha sido generada la factura la "llenamos"
    LlenarComprobante;
    try
      CadenaOriginal:=TCadenaOriginal.Create(fXmlComprobante, fVersion);
      fCadenaOriginalCalculada:=CadenaOriginal.Calcular;

      Result:=fCadenaOriginalCalculada;
    finally
      FreeAndNil(CadenaOriginal);
    end;
  end;
end;


function TFEComprobanteFiscal.GetCadenaOriginalTimbre: TStringCadenaOriginal;
var
  generadorCadenaOriginalTimbre: TCadenaOriginalDeTimbre;
begin
  if fVersion <> fev32 then
    raise EComprobanteNoSoportaPropiedadException.Create('Esta version del CFD no soporta obtener la CadenaOriginal del Timbre');

  if fFueTimbrado then
  begin
    Assert(fTimbre.XML <> '', 'El contenido del timbre fue vacio');
    try
       {generadorCadenaOriginalTimbre := TCadenaOriginalDeTimbre.Create(fTimbre.XML, '');
       // Calculamos la cadena y la regresamos
       Result := generadorCadenaOriginalTimbre.Generar;  }
       Result := '||Cadena||'
    finally
       generadorCadenaOriginalTimbre.Free;
    end;
  end else
    Result := '';
end;

// 1. Datos de quien la expide (Emisor) (Art. 29-A, Fraccion I)
procedure TFEComprobanteFiscal.AsignarEmisor;

  procedure AsignarRegimenesFiscales;
  var
      I: Integer;
      NombreRegimenFiscal : String;
  begin
     // Agregamos cada regimen fiscal del emisor al comprobante
     for I := 0 to Length(inherited Emisor.Regimenes) - 1 do
     begin
        NombreRegimenFiscal:=(inherited Emisor.Regimenes)[I];
        case fVersion of
         fev22:
         begin
            with IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal.Add do
                Regimen:=NombreRegimenFiscal;
         end;
         fev32:
         begin
            with IFEXMLComprobanteV32(fXmlComprobante).Emisor.RegimenFiscal.Add do
                Regimen:=NombreRegimenFiscal;
         end;
        end;
     end;
  end;

begin
  // Realizamos las validaciones correspondientes
  ValidarCamposEmisor;

  // Segun la version del CFD asignamos el "Emisor" correspondiente
  case fVersion of
    fev20:
    begin
        with IFEXmlComprobanteV2(fXmlComprobante).Emisor do
        begin
          RFC :=(inherited Emisor).RFC;
          Nombre := TFEReglamentacion.ComoCadena((inherited Emisor).Nombre);
          with DomicilioFiscal do // Alias de UbicacionFiscal
          begin
            Calle := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Calle);

            if Trim((inherited Emisor).Direccion.NoExterior) <> '' then
              NoExterior := (inherited Emisor).Direccion.NoExterior; // Opcional

            if Trim((inherited Emisor).Direccion.NoInterior) <> '' then
              NoInterior := (inherited Emisor).Direccion.NoInterior; // Opcional

            if Trim((inherited Emisor).Direccion.Colonia) <> '' then
              Colonia := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Colonia); // Opcional

            if Trim((inherited Emisor).Direccion.Localidad) <> '' then
              Localidad := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Localidad); // Opcional

            if Trim((inherited Emisor).Direccion.Referencia) <> '' then
              Referencia := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Referencia); // Opcional

            Municipio := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Municipio);
            Estado := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Estado);
            Pais := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Pais);
            CodigoPostal := (inherited Emisor).Direccion.CodigoPostal;
          end;
        end;
    end;

    fev22:
    begin
       with IFEXmlComprobanteV22(fXmlComprobante).Emisor do
        begin
          RFC :=(inherited Emisor).RFC;
          Nombre := TFEReglamentacion.ComoCadena((inherited Emisor).Nombre);
          with DomicilioFiscal do // Alias de UbicacionFiscal
          begin
            Calle := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Calle);

            if Trim((inherited Emisor).Direccion.NoExterior) <> '' then
              NoExterior := (inherited Emisor).Direccion.NoExterior; // Opcional

            if Trim((inherited Emisor).Direccion.NoInterior) <> '' then
              NoInterior := (inherited Emisor).Direccion.NoInterior; // Opcional

            if Trim((inherited Emisor).Direccion.Colonia) <> '' then
              Colonia := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Colonia); // Opcional

            if Trim((inherited Emisor).Direccion.Localidad) <> '' then
              Localidad := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Localidad); // Opcional

            if Trim((inherited Emisor).Direccion.Referencia) <> '' then
              Referencia := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Referencia); // Opcional

            Municipio := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Municipio);
            Estado := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Estado);
            Pais := TFEReglamentacion.ComoCadena((inherited Emisor).Direccion.Pais);
            CodigoPostal := (inherited Emisor).Direccion.CodigoPostal;
          end;
          // Agregamos el nuevo campo requerido Regimen Fiscal (implementado en 2.2)
          Assert(Length(inherited Emisor.Regimenes) > 0,
             'Se debe especificar al menos un régimen del cliente');
          AsignarRegimenesFiscales;
        end;
    end;
    fev32:
    begin
       with IFEXmlComprobanteV32(fXmlComprobante).Emisor do
        begin
          RFC :=(inherited Emisor).RFC;
          Nombre := TFEReglamentacion.ComoCadena((inherited Emisor).Nombre);

          // Agregamos el domicilio fiscal del Emisor solo si tiene Calle
          if (inherited Emisor).Direccion.Calle <> '' then
            AgregarDireccionFiscalv32(DomicilioFiscal, (inherited Emisor).Direccion);

          // Agregamos el nuevo campo requerido Regimen Fiscal (implementado en 2.2)
          AsignarRegimenesFiscales;
        end;
    end;
  end;
end;

// 2. Lugar y fecha de expedicion (29-A, Fraccion III) - En caso de ser sucursal
procedure TFEComprobanteFiscal.AsignarExpedidoEn;
begin
    // Checamos si tiene direccion de expedicion...
    if (inherited ExpedidoEn.Calle <> '') then
    begin
        case fVersion of
          fev20:
          begin
              with IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn do
              begin
                  Calle := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Calle);
                  if Trim((inherited ExpedidoEn).NoExterior) <> '' then
                    NoExterior := (inherited ExpedidoEn).NoExterior; // Opcional

                  if Trim((inherited ExpedidoEn).NoInterior) <> '' then
                    NoInterior := (inherited ExpedidoEn).NoInterior; // Opcional

                  if Trim((inherited ExpedidoEn).Colonia) <> '' then
                    Colonia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Colonia); // Opcional
                  if Trim((inherited ExpedidoEn).Localidad) <> '' then
                    Localidad := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Localidad); // Opcional
                  if Trim((inherited ExpedidoEn).Referencia) <> '' then
                    Referencia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Referencia); // Opcional
                  Municipio := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Municipio);
                  Estado := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Estado);
                  Pais := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Pais);
                  CodigoPostal := (inherited ExpedidoEn).CodigoPostal;
              end;
          end;
          fev22:
          begin
                with IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn do
                begin
                    Calle := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Calle);
                    if Trim((inherited ExpedidoEn).NoExterior) <> '' then
                      NoExterior := (inherited ExpedidoEn).NoExterior; // Opcional

                    if Trim((inherited ExpedidoEn).NoInterior) <> '' then
                      NoInterior := (inherited ExpedidoEn).NoInterior; // Opcional

                    if Trim((inherited ExpedidoEn).Colonia) <> '' then
                      Colonia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Colonia); // Opcional
                    if Trim((inherited ExpedidoEn).Localidad) <> '' then
                      Localidad := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Localidad); // Opcional
                    if Trim((inherited ExpedidoEn).Referencia) <> '' then
                      Referencia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Referencia); // Opcional
                    Municipio := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Municipio);
                    Estado := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Estado);
                    Pais := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Pais);
                    CodigoPostal := (inherited ExpedidoEn).CodigoPostal;
                end;
          end;
          fev32:
          begin
                with IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn do
                begin
                    Calle := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Calle);
                    if Trim((inherited ExpedidoEn).NoExterior) <> '' then
                      NoExterior := (inherited ExpedidoEn).NoExterior; // Opcional

                    if Trim((inherited ExpedidoEn).NoInterior) <> '' then
                      NoInterior := (inherited ExpedidoEn).NoInterior; // Opcional

                    if Trim((inherited ExpedidoEn).Colonia) <> '' then
                      Colonia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Colonia); // Opcional
                    if Trim((inherited ExpedidoEn).Localidad) <> '' then
                      Localidad := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Localidad); // Opcional
                    if Trim((inherited ExpedidoEn).Referencia) <> '' then
                      Referencia := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Referencia); // Opcional
                    Municipio := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Municipio);
                    Estado := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Estado);
                    Pais := TFEReglamentacion.ComoCadena((inherited ExpedidoEn).Pais);
                    CodigoPostal := (inherited ExpedidoEn).CodigoPostal;
                end;
          end;
        end;
    end;
end;




// 3. Clave del RFC de la persona a favor de quien se expida la factura (29-A, Fraccion IV)
procedure TFEComprobanteFiscal.AsignarReceptor;
begin
  ValidarCamposReceptor;

  with fXmlComprobante.Receptor do
  begin
    RFC := Trim((inherited Receptor).RFC);

    // Si es un CFD de venta al publico en general o extranjeros no incluimos nombre ni direccion
    if ((Rfc <> _RFC_VENTA_PUBLICO_EN_GENERAL) And (Rfc <> _RFC_VENTA_EXTRANJEROS)) then
    begin
        Nombre := TFEReglamentacion.ComoCadena((inherited Receptor).Nombre);

        // Agregamos el domicilio fiscal del Receptor
        if (inherited Receptor).Direccion.Calle <> '' then
          AgregarDireccionFiscalv32(Domicilio, (inherited Receptor).Direccion);
    end else
        // Si es Publico en General solo agregamos el pais al nodo Direccion
        // cualquier otra cosa generara un CFD invalido.
        if (Rfc = _RFC_VENTA_PUBLICO_EN_GENERAL) then
          Domicilio.Pais:='México'
        else // Si es el RFC de extranjero ahi si obtenemos el pais del que se nos haya asignado...
          fXmlComprobante.Receptor.Domicilio.Pais := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Pais);

  end;
end;

procedure TFEComprobanteFiscal.AsignarContenidoCertificado;
begin
    if Trim(fCertificadoTexto) <> '' then
       fXmlComprobante.Certificado := TFEReglamentacion.ComoCadena(fCertificadoTexto);
end;

procedure TFEComprobanteFiscal.AsignarConceptos;
var
  I: Integer;
  Concepto: TFEConcepto;
begin
     // Obtenemos los conceptos agregados al documento previamente
     for I := 0 to Length(inherited Conceptos) - 1 do
     begin
          Concepto:=(inherited Conceptos)[I];

          // Agregamos el concepto al XML
          with fXmlComprobante.Conceptos.Add do
          begin
            Cantidad := TFEReglamentacion.ComoCantidad(Concepto.Cantidad);

            if Trim(Concepto.Unidad) <> '' then
              Unidad := Concepto.Unidad; // Requerido a partir de la v2.2

            if Trim(Concepto.NoIdentificacion) <> '' then
              NoIdentificacion := TFEReglamentacion.ComoCadena(Concepto.NoIdentificacion); // Opcional

            Descripcion := TFEReglamentacion.ComoCadena(Concepto.Descripcion);
            ValorUnitario := TFEReglamentacion.ComoMoneda(Concepto.ValorUnitario);
            Importe := TFEReglamentacion.ComoMoneda(Concepto.ValorUnitario * Concepto.Cantidad);

            // Le fue asignada informacion aduanera??
            if (Concepto.DatosAduana.NumeroDocumento <> '') then
              with InformacionAduanera.Add do
              begin
                Numero := Concepto.DatosAduana.NumeroDocumento;
                Fecha := TFEReglamentacion.ComoFechaAduanera(Concepto.DatosAduana.FechaExpedicion);
                Aduana := TFEReglamentacion.ComoCadena(Concepto.DatosAduana.Aduana);
              end;

            if Trim(Concepto.CuentaPredial) <> '' then
              CuentaPredial.Numero := TFEReglamentacion.ComoCadena(Concepto.CuentaPredial); // Opcional
          end;
     end;
end;

procedure TFEComprobanteFiscal.AsignarImpuestosRetenidos;
var
  NuevoImpuesto: TFEImpuestoRetenido;
  I: Integer;
begin
    for I := 0 to Length(inherited ImpuestosRetenidos) - 1 do
    begin
        NuevoImpuesto:=(inherited ImpuestosRetenidos)[I];

        with fXmlComprobante.Impuestos.Retenciones.Add do
        begin
          Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
          Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
        end;
    end;
end;

procedure TFEComprobanteFiscal.AsignarImpuestosTrasladados;
var
  NuevoImpuesto: TFEImpuestoTrasladado;
  I: Integer;
begin
    for I := 0 to Length(inherited ImpuestosTrasladados) - 1 do
    begin
        NuevoImpuesto:=(inherited ImpuestosTrasladados)[I];

        with fXmlComprobante.Impuestos.Traslados.Add do
        begin
          Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
          Tasa := TFEReglamentacion.ComoTasaImpuesto(NuevoImpuesto.Tasa);
          Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
        end;
    end;
end;

procedure TFEComprobanteFiscal.AsignarTimbreFiscal(const aTimbre: TFETimbre);
begin
  Assert(fVersion In [fev32], 'No es posible asignar un timbre a un CFD que no es v3.2');
  //Assert(FacturaGenerada, 'Se debio haber tenido generada la factura antes de asignarle el timbre');
  Assert(Not fFueTimbrado, 'No es posible asignar un timbre a una factura timbrada previamente');
  Assert(aTimbre.XML <> '', 'El contenido del timbre fue nulo');

  // Asignamos el timbre a la estructura interna del mismo
  fTimbre := aTimbre;

  // Mandamos llamar el evento de que se asigno el timbrado
  {if Assigned(fOnTimbradoAsignado) then
    fOnTimbradoAsignado(Self);  }
end;

procedure TFEComprobanteFiscal.setCertificado(Certificado: TFECertificado);
const
    _CADENA_INICIO_CERTIFICADO = '-----BEGIN CERTIFICATE-----';
    _CADENA_FIN_CERTIFICADO    = '-----END CERTIFICATE-----';
    _ERROR_LECTURA_CERTIFICADO = 'Unable to read certificate';
var
  x509Certificado: TX509Certificate;

  // Quita los encabezados, pie y retornos de carro del certificado
  function QuitarCaracteresNoUsadosEnCertificado(sCertificadoBase64: WideString) : WideString;
  begin
      sCertificadoBase64:=StringReplace(sCertificadoBase64, #13, '', [rfReplaceAll, rfIgnoreCase]);
      sCertificadoBase64:=StringReplace(sCertificadoBase64, #10, '', [rfReplaceAll, rfIgnoreCase]);
      // Quitamos encabezado del certificado
      sCertificadoBase64:=StringReplace(sCertificadoBase64, _CADENA_INICIO_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
      // Quitamos el pie del certificado
      Result:=StringReplace(sCertificadoBase64, _CADENA_FIN_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
  end;

begin
  // Ya que tenemos los datos del certificado, lo procesamos para obtener los datos
  // necesarios
  x509Certificado := TX509Certificate.Create;
  try
    if Not FileExists(Certificado.Ruta) then
      raise EFECertificadoNoExisteException.Create('No existe el archivo del certificado')
    else
      x509Certificado.LoadFromFile(Certificado.Ruta);

    fCertificado := Certificado;

    // Llenamos las propiedades
    fCertificado.VigenciaInicio := x509Certificado.NotBefore;
    fCertificado.VigenciaFin := x509Certificado.NotAfter;

    // Checamos que el certificado este dentro de la vigencia
    if Not((Now >= fCertificado.VigenciaInicio) and (Now <= fCertificado.VigenciaFin)) then
      raise EFECertificadoNoVigente.Create('El certificado no tiene vigencia actual');

    fCertificado.NumeroSerie := x509Certificado.SerialNumber;

    // Ya procesado llenamos su propiedad en el XML
    Assert(Assigned(fXmlComprobante), 'El Nodo comprobante no est asignado!');
    fXmlComprobante.NoCertificado := fCertificado.NumeroSerie;

    // Incluir el certificado en el XML?
    if bIncluirCertificadoEnXML = True then
    begin
       // Obtenemos el certificado codificado en Base64 para incluirlo en el comprobante
       fCertificadoTexto:=X509Certificado.AsBase64;
       fCertificadoTexto:=QuitarCaracteresNoUsadosEnCertificado(X509Certificado.AsBase64);
       //CodeSite.Send('Certificado Base64', CertificadoBase64);
       //CodeSite.Send('length', Length(CertificadoBase64));
    end;

  except
     // Pasamos la excepcion tal y como esta
     On E: Exception do
     begin
        FreeAndNil(x509Certificado);
        // Checamos los posibles errores
        if AnsiPos(_ERROR_LECTURA_CERTIFICADO, E.Message) > 0 then
            raise EFECertificadoNoFueLeidoException.Create('No fue posible leer el certificado: ' + E.Message)
        else
            raise Exception.Create(E.Message);
     end;
  end;
  FreeAndNil(x509Certificado);
end;

// Asignamos la serie, el no y año de aprobacion al XML...
procedure TFEComprobanteFiscal.AsignarDatosFolios;
var
  soportaFolios : IFESoportaBloqueFolios;
begin
   if Trim(fBloqueFolios.Serie) <> '' then
      fXmlComprobante.Serie := fBloqueFolios.Serie;

   // Los folios asignados solo se soportan en CFD 2.0, 2.2
   if fVersion In [fev20, fev22] then
   begin
      if Supports(fXmlComprobante, IFESoportaBloqueFolios, soportaFolios) then
      begin
        soportaFolios.NoAprobacion := fBloqueFolios.NumeroAprobacion;
        soportaFolios.AnoAprobacion := fBloqueFolios.AnoAprobacion;
      end;
   end;
end;

// 8. Numero de folio, el cual debe de ser asignado de manera automatica por el sistema
procedure TFEComprobanteFiscal.AsignarFolio;
begin
    fXmlComprobante.Folio := IntToStr(inherited Folio);
end;

// 9. Cumplir con las reglas de control de pagos (Art 29, fraccion V)
procedure TFEComprobanteFiscal.AsignarFormaDePago;
var
  sForma: String;
begin
  case (inherited FormaDePago) of
    fpUnaSolaExhibicion:
      sForma := _CADENA_PAGO_UNA_EXHIBICION;
    fpParcialidades:
      sForma := _CADENA_PAGO_PARCIALIDADES;
  end;
  fXmlComprobante.FormaDePago := sForma;
end;

procedure TFEComprobanteFiscal.AsignarSubtotal;
begin
   fXmlComprobante.SubTotal := TFEReglamentacion.ComoMoneda(inherited Subtotal);
end;

procedure TFEComprobanteFiscal.AsignarTotal;
begin
   fXmlComprobante.Total := TFEReglamentacion.ComoMoneda(inherited Total);
end;

procedure TFEComprobanteFiscal.AsignarMetodoDePago;
begin
  // Asignamos el metodo de pago
  if (Trim(inherited MetodoDePago) <> '') then
     fXmlComprobante.MetodoDePago:=TFEReglamentacion.ComoCadena(inherited MetodoDePago)
  else
     fXmlComprobante.MetodoDePago:=_CADENA_METODO_PAGO_NO_DISPONIBLE;
end;

procedure TFEComprobanteFiscal.AsignarTipoComprobante;
var
  sTipo: String;
begin
  case (inherited Tipo) of
    tcIngreso:
      sTipo := 'ingreso';
    tcEgreso:
      sTipo := 'egreso';
    tcTraslado:
      sTipo := 'traslado';
  end;

  // TODO: Que cambios deben hacerse cuando es un egreso o traslado???
  fXmlComprobante.TipoDeComprobante := sTipo;
end;

procedure TFEComprobanteFiscal.AsignarTotalesImpuestos;
begin
    // Agregamos al XML los totales de los diferentes tipos de impuestos usados
    // si asi se desea...
    with fXmlComprobante.Impuestos do
    begin
      if (inherited TotalImpuestosRetenidos > 0) then
        TotalImpuestosRetenidos := TFEReglamentacion.ComoMoneda(inherited TotalImpuestosRetenidos); // Opcional

      if (inherited TotalImpuestosTrasladados > 0) then
        TotalImpuestosTrasladados := TFEReglamentacion.ComoMoneda(inherited TotalImpuestosTrasladados); // Opcional
    end;
end;

procedure TFEComprobanteFiscal.AsignarFechaGeneracion;
  var
    d,m,a: Word;
begin
    // Especificamos la fecha exacta en la que se esta generando el comprobante
    {$IFDEF VERSION_DE_PRUEBA}
      // Si estamos en las pruebas de unidad, dejamos que la prueba
      // defina la fecha/hora en que se "genero" el comprobante
      // para que sea el mismo que se uso al haber sido generado con el MicroE
      if (_USAR_HORA_REAL = True) then
         FechaGeneracion:=Now;
    {$ELSE}
        // Si ya fue generada la factura (por ejemplo cuando se lee)
        if (fAutoAsignarFechaGeneracion = True) then
          FechaGeneracion := Now;
    {$ENDIF}

    // Verificamos que la fecha sea valida
    DecodeDate(FechaGeneracion, a, m, d);
    If (a <= 2004) then
      Raise Exception.Create('La fecha de generacion del comprobante no fue asignada correctamente. No es posible generar factura');

    // Almacenamos las propiedades del XML antes de generar la cadena original
    fXmlComprobante.Fecha := TFEReglamentacion.ComoFechaHora(FechaGeneracion);
end;

procedure TFEComprobanteFiscal.AsignarLugarExpedicion;
begin
  case fVersion of
    fev22:
     IFEXMLComprobanteV22(fXmlComprobante).LugarExpedicion := (inherited LugarDeExpedicion);
    fev32:
     IFEXMLComprobanteV32(fXmlComprobante).LugarExpedicion := (inherited LugarDeExpedicion);
  end;
end;

procedure TFEComprobanteFiscal.AsignarNumeroDeCuenta;
begin
  // En CFD 2.2 agregamos el Num Cta Pago (al menos los 4 ultimos digitos) el cual
  // es un nodo opcional
  case fVersion of
    fev22:
    begin
         if Trim(inherited NumeroDeCuenta) <> '' then
            IFEXMLComprobanteV22(fXmlComprobante).NumCtaPago:=inherited NumeroDeCuenta;
    end;
    fev32:
    begin
         if Trim(inherited NumeroDeCuenta) <> '' then
            IFEXMLComprobanteV32(fXmlComprobante).NumCtaPago:=inherited NumeroDeCuenta;
    end;
  end;
end;

procedure TFEComprobanteFiscal.LeerPropiedadesDeTimbre;
var
  complementoTimbre: IFEXMLtimbreFiscalDigital;
  documentoXMLTimbre: TXmlDocument;
begin
  Assert(fVersion = fev32, 'Solo es posible asignar el timbre de un CFD v3.2');

  if IFEXMLComprobanteV32(fXmlComprobante).Complemento.HasChildNodes then
  begin
    // Creamos el documento XML solamente del timbre
    documentoXMLTimbre := TXMLDocument.Create(nil);
    documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(fXmlComprobante).Complemento.ChildNodes.First.XML;
    documentoXMLTimbre.Active := True;

    try
      // Convertimos el XML del nodo a la interfase del Timbre v3.2
      complementoTimbre := GetTimbreFiscalDigital(documentoXMLTimbre);

      // Asignamos las propiedades del XMl del timbre a las internas
      fTimbre.Version := complementoTimbre.Version;
      fTimbre.UUID := complementoTimbre.UUID;
      fTimbre.FechaTimbrado := TFEReglamentacion.DeFechaHoraISO8601(complementoTimbre.FechaTimbrado);
      fTimbre.SelloCFD := complementoTimbre.SelloCFD;
      fTimbre.NoCertificadoSAT := complementoTimbre.NoCertificadoSAT;
      fTimbre.SelloSAT := complementoTimbre.SelloSAT;
      fTimbre.XML := documentoXMLTimbre.XML.Text;
    except
      On E:Exception do
        raise;
    end;
  end else
    fFueTimbrado := False;
end;


// Funcion encargada de llenar el comprobante fiscal EN EL ORDEN que se especifica en el XSD
// ya que si no es asi, el XML se va llenando en el orden en que se establecen las propiedades de la clase
// haciendo que el comprobante no pase las validaciones del SAT.
procedure TFEComprobanteFiscal.LlenarComprobante;
begin
    if (fComprobanteLleno = False) then
    begin
        // Atributos de comprobante
        AsignarDatosFolios;
        AsignarFechaGeneracion;
        AsignarFolio;
        AsignarFormaDePago;
        AsignarSubtotal;
        AsignarDescuentos;
        AsignarTotal;
        AsignarTipoComprobante;
        AsignarContenidoCertificado;
        AsignarCondicionesDePago;
        AsignarMetodoDePago;
        // Nuevas propiedades de CFD 2.2: y 3.2
        if (fVersion = fev22) or (fVersion = fev32) then
        begin
          AsignarLugarExpedicion;
          AsignarNumeroDeCuenta;
        end;
        // Por implementar: AsignarTipoDeCambioYMoneda;
        // Por implementar: AsignarMontoFolioFiscalOriginal;

        AsignarEmisor;
        AsignarExpedidoEn;
        // Atributo Receptor
        AsignarReceptor;

        // Atributo conceptos
        AsignarConceptos;

        // Atributo Impuestos
        AsignarImpuestosTrasladados;
        AsignarImpuestosRetenidos;

        if (fDesglosarTotalesImpuestos = True) then
           AsignarTotalesImpuestos;

        fComprobanteLleno:=True;
    end;
end;


procedure TFEComprobanteFiscal.Cancelar;
begin
  { http://www.validacfd.com/phpbb3/viewtopic.php?f=15&t=113&p=596&hilit=egreso#p596 - User: Carlos R
    Algunos detalles tecnicos-practicos que generalmente se omiten.
    * Al cancelar las facturas se deberá incorporar en los reportes mensuales con "|0|". pero no es tan simple.
    Si es en el mismo dia, tendrás que insertar la serie y el folio primermente en |1| y posteriormente la declaras en |0|,
    no de primera mano en |0|. (ojala me haya explicado)
    Variable1: Cancelas el mismo dia
    Variable2: Cancelas el mes
    Variable3: Cancelas otro mes

    en cualquiera de los casos el sistema tendrá que ser capaz de incorporarlo en el reporte como cancelado.

    Si además de la cancelación se realizó nota de crédito (por devolución o por descuento) el sistema deberá de
    generar el documento como un "egreso", recuerda que para el SAT solo existen: INGRESO, EGRESO, TRASLADO.
  }
end;

procedure TFEComprobanteFiscal.EstablecerVersionDelComprobante;
begin
  Assert(fXmlComprobante <> nil, 'El comprobante No debio haber sido NULO');
  fXmlComprobante.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
  case fVersion of
   fev22:
    begin
      fXmlComprobante.SetAttribute('xsi:schemaLocation',
                                   'http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv22.xsd');
      fXmlComprobante.Version := '2.2';
    end;
   fev32:
    begin
      fXmlComprobante.SetAttribute('xsi:schemaLocation',
                                   'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd');
      fXmlComprobante.Version := '3.2';
    end;
  end;

  fDocumentoXML.Version := '1.0';
  fDocumentoXML.Encoding := 'UTF-8';
end;

procedure TFEComprobanteFiscal.GenerarComprobante;
begin
  // Al mandar solicitar el sello se genera la cadena original y por lo tanto se llena el comprobante
  fXmlComprobante.Sello:=Self.SelloDigital;

  // Complementos - Timbre Fiscal
  if fVersion In [fev32] then
  begin
     // Si tenemos timbre y no lo hemos agregado al XML lo agregamos
     if ((fFueTimbrado = False) And (fTimbre.XML <> '')) then
      AgregarTimbreFiscalAlXML;
  end;
end;


procedure TFEComprobanteFiscal.ValidarQueFolioEsteEnRango;
begin
  // Validamos que el folio este dentro del rango definido si ya se nos fue proporcionado
  // el bloque de folios y el numero de folio
  if not FacturaGenerada then
    if ((fBloqueFolios.FolioInicial > -1) And (inherited Folio > -1)) then
    begin
      if Not((inherited Folio >= fBloqueFolios.FolioInicial) And (inherited Folio <= fBloqueFolios.FolioFinal)) then
        raise EFEFolioFueraDeRango.Create('El folio se encuentra fuera del rango autorizado');
    end;
end;

procedure TFEComprobanteFiscal.setBloqueFolios(Bloque: TFEBloqueFolios);
begin
  // Asignamos el bloque a la variable interna y validamos que este dentro del rango...
  fBloqueFolios := Bloque;
  // Establecemos la serie
  inherited Serie := fBloqueFolios.Serie;
  // Si esta asignado el folio
  if Folio > 0 then
    ValidarQueFolioEsteEnRango();
end;

// El metodo que genera el CFD al final...
procedure TFEComprobanteFiscal.GuardarEnArchivo(sArchivoDestino: String);
begin
  GenerarComprobante;
  fDocumentoXML.SaveToFile(sArchivoDestino);
  // TODO: Implementar las diversas fallas que pueden ocurrir
end;

// Calculamos el sello digital para la cadena original de la factura
function TFEComprobanteFiscal.getSelloDigital(): String;
var
  TipoDigestion: TTipoDigestionOpenSSL;
  SelloDigital: TSelloDigital;
  // Es importante que en cualquier variable que almacenemos la cadena original
  // sea del tipo TStringCadenaOriginal para no perder la codificacion UTF8
  CadenaOriginal: TStringCadenaOriginal;
begin
  // Si la factura ya fue generada regresamos el sello previamente calculado
  if (FacturaGenerada = True) then
      Result:=fSelloDigitalCalculado
  else
  begin
      fSelloDigitalCalculado:='';

      // Obtenemos la cadena Original del CFD primero
      CadenaOriginal := Self.CadenaOriginal;

      {$IFDEF VERSION_DE_PRUEBA}
              Assert(FechaGeneracion > EncodeDate(2009, 1, 1),
                     'La fecha de generacion debe ser en el 2010 o superior!! fue' + DateTimeToStr(FechaGeneracion));
      {$ENDIF}

      // Segun la leglislacion vigente si la factura se hace
      // antes del 1 de Enero del 2011, usamos MD5
      if (FechaGeneracion < EncodeDate(2011, 1, 1)) then
        TipoDigestion := tdMD5
      else // Si es 2011 usamos el algoritmo SHA-1
        TipoDigestion := tdSHA1;

      try
        // Creamos la clase SelloDigital que nos ayudara a "sellar" la factura en XML
        SelloDigital := TSelloDigital.Create(CadenaOriginal, fCertificado, TipoDigestion);

        // Finalmente regresamos la factura en XML con todas sus propiedades llenas
        fSelloDigitalCalculado := SelloDigital.SelloCalculado;

        result := fSelloDigitalCalculado;
        // Liberamos la clase de sello usada previamente
        FreeAndNil(SelloDigital);
        FacturaGenerada:=True;
      except
        // TODO: Manejar los diferentes tipos de excepciones...
        on E:Exception do
        begin
          {$IFDEF DEBUG}
            ShowMessage(E.Message);
          {$ENDIF}
          FacturaGenerada := False;
          raise;
        end;
      end;
  end;
end;

function TFEComprobanteFiscal.GetTimbre: TFETimbre;
begin
  if fVersion In [fev32] then
    Result := fTimbre
  else
    raise EComprobanteNoSoportaPropiedadException.Create('La version de este CFD no soporta timbrado');
end;

// Permite establecer el XML del comprobante (por si se esta leyendo de la BD, etc)
// y almacena todo en la estructura interna de datos y XML
procedure TFEComprobanteFiscal.setXML(const Valor: WideString);
var
  I: Integer;
  ValorEmisor, ValorReceptor: TFEContribuyente;
  feConcepto: TFEConcepto;
  feRegimen: String;
  iXmlDoc: IXMLDocument;
  ValorExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
  sMotivoDescuento: String;
  comprobanteConBloqueFolios:IFESoportaBloqueFolios;
  complementoTimbre: IFEXMLtimbreFiscalDigital;

  function TieneAtributo(NodoPadre: IXMLNode; NombreAtributo: String) : Boolean;
  begin
    // Checamos que el XML que estamos leyendo tenga dicho atributo ya que si esta vacio
    // y lo tratamos de "leer" se agregara al XML leido con valores nulos
    if Assigned(NodoPadre) then
      Result:=NodoPadre.HasAttribute(NombreAtributo)
    else
      Result:=False;
  end;

begin
    if (Trim(Valor) = '') then
    begin
        Raise EXMLVacio.Create('El valor proveido al XML esta vacio. Imposible crear comprobante.');
        Exit;
    end;

    try
        // Leemos el contenido XML en el Documento XML interno
        {$IF Compilerversion >= 20}
        // Usamos esta nueva funcion ya que UTF8Decode esta depreciada en Delphi XE2 y superiores
        iXmlDoc:=LoadXMLData(Valor); //UTF8ToString
        {$ELSE}
        iXmlDoc:=LoadXMLData(UTF8Decode(Valor));
        {$IFEND}
        // Creamos el documento "dueño" del comprobante
        fDocumentoXML:=TXmlDocument.Create(nil);
        // Pasamos el XML para poder usarlo en la clase
        fDocumentoXML.XML:=iXmlDoc.XML;
        //Assert(fDocumentoXML.Encoding = 'UTF-8', 'El Encoding del documento no fue correcto');

        // Asignamos el XML a la variable interna del componente
        if AnsiPos('version="2.0"', Valor) > 0 then
          fXmlComprobante := GetComprobante(fDocumentoXML);

        if AnsiPos('version="2.2"', Valor) > 0 then
          fXmlComprobante := GetComprobanteV22(fDocumentoXML);

        if AnsiPos('version="3.2"', Valor) > 0 then
          fXmlComprobante := GetComprobanteV32(fDocumentoXML);

        fDocumentoXML.Encoding := 'UTF-8';
        Assert(fXmlComprobante <> nil, 'No se obtuvo una instancia del comprobante ya que fue nula');
        Assert(fXmlComprobante.Version <> '', 'El comprobante no fue leido correctamente.');

        // Checamos que versión es
        if fXmlComprobante.Version = '2.0' then
          fVersion:=fev20;

        if fXmlComprobante.Version = '2.2' then
          fVersion:=fev22;

        if fXmlComprobante.Version = '3.2' then
          fVersion:=fev32;

        // Ahora, actualizamos todas las variables internas (de la clase) con los valores del XML
        with fXmlComprobante do
        begin
            inherited Folio:=StrToInt(Folio);
            // Datos del certificado
            fCertificado.NumeroSerie:=NoCertificado;
            fCertificadoTexto := Certificado;

            if fVersion In [fev20, fev22] then
            begin
              if Supports(fXmlComprobante, IFESoportaBloqueFolios, comprobanteConBloqueFolios) then
              begin
                fBloqueFolios.NumeroAprobacion:=comprobanteConBloqueFolios.NoAprobacion;
                fBloqueFolios.AnoAprobacion:=comprobanteConBloqueFolios.AnoAprobacion;
              end;
            end;

             if TieneAtributo(fXmlComprobante, 'serie') then
            begin
              fBloqueFolios.Serie:=Serie;
              inherited Serie:=Serie;
            end;

            fBloqueFolios.FolioInicial:=inherited Folio;
            fBloqueFolios.FolioFinal:=inherited Folio;

            // CFD 2.2 /CFD 3.2
            if (fVersion = fev22) then
            begin
                inherited LugarDeExpedicion:=IFEXMLComprobanteV22(fXmlComprobante).LugarExpedicion;

                if TieneAtributo(fXmlComprobante, 'NumCtaPago') then
                  inherited NumeroDeCuenta:=IFEXMLComprobanteV22(fXmlComprobante).NumCtaPago;
            end
           Else if (fVersion = fev32) then
            begin
                inherited LugarDeExpedicion:=IFEXMLComprobanteV32(fXmlComprobante).LugarExpedicion;

                if TieneAtributo(fXmlComprobante, 'NumCtaPago') then
                  inherited NumeroDeCuenta:=IFEXMLComprobanteV32(fXmlComprobante).NumCtaPago;
            end;

            FechaGeneracion:=TFEReglamentacion.ComoDateTime(fXmlComprobante.Fecha);

            if TieneAtributo(fXmlComprobante, 'condicionesDePago') then
              inherited CondicionesDePago:=CondicionesDePago;

            if TieneAtributo(fXmlComprobante, 'metodoDePago') then
              inherited MetodoDePago:=MetodoDePago;


            // Leemos los datos del emisor
            case fVersion of
              fev20:
              begin
                  if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor, 'nombre') then
                      ValorEmisor.Nombre:=IFEXmlComprobanteV2(fXmlComprobante).Emisor.Nombre;

                  if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor, 'rfc') then
                     ValorEmisor.RFC:=IFEXmlComprobanteV2(fXmlComprobante).Emisor.RFC;

                  with IFEXmlComprobanteV2(fXmlComprobante).Emisor do
                  begin
                      if TieneAtributo(DomicilioFiscal, 'calle') then
                        ValorEmisor.Direccion.Calle := DomicilioFiscal.Calle;
                      if TieneAtributo(DomicilioFiscal, 'noExterior') then
                        ValorEmisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
                      if TieneAtributo(DomicilioFiscal, 'noInterior') then
                        ValorEmisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
                      if TieneAtributo(DomicilioFiscal, 'codigoPostal') then
                        ValorEmisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
                      if TieneAtributo(DomicilioFiscal, 'colonia') then
                        ValorEmisor.Direccion.Colonia := DomicilioFiscal.Colonia;
                      if TieneAtributo(DomicilioFiscal, 'localidad') then
                        ValorEmisor.Direccion.Localidad := DomicilioFiscal.Localidad;
                      if TieneAtributo(DomicilioFiscal, 'municipio') then
                        ValorEmisor.Direccion.Municipio := DomicilioFiscal.Municipio;
                      if TieneAtributo(DomicilioFiscal, 'estado') then
                        ValorEmisor.Direccion.Estado := DomicilioFiscal.Estado;
                      if TieneAtributo(DomicilioFiscal, 'pais') then
                        ValorEmisor.Direccion.Pais := DomicilioFiscal.Pais;
                  end;
              end;
              fev22:
              begin
                  if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor, 'nombre') then
                      ValorEmisor.Nombre:=IFEXmlComprobanteV22(fXmlComprobante).Emisor.Nombre;

                  if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor, 'rfc') then
                     ValorEmisor.RFC:=IFEXmlComprobanteV22(fXmlComprobante).Emisor.RFC;

                  with IFEXmlComprobanteV22(fXmlComprobante).Emisor do
                  begin
                      if TieneAtributo(DomicilioFiscal, 'calle') then
                        ValorEmisor.Direccion.Calle := DomicilioFiscal.Calle;
                      if TieneAtributo(DomicilioFiscal, 'noExterior') then
                        ValorEmisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
                      if TieneAtributo(DomicilioFiscal, 'noInterior') then
                        ValorEmisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
                      if TieneAtributo(DomicilioFiscal, 'codigoPostal') then
                        ValorEmisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
                      if TieneAtributo(DomicilioFiscal, 'colonia') then
                        ValorEmisor.Direccion.Colonia := DomicilioFiscal.Colonia;
                      if TieneAtributo(DomicilioFiscal, 'localidad') then
                        ValorEmisor.Direccion.Localidad := DomicilioFiscal.Localidad;
                      if TieneAtributo(DomicilioFiscal, 'municipio') then
                        ValorEmisor.Direccion.Municipio := DomicilioFiscal.Municipio;
                      if TieneAtributo(DomicilioFiscal, 'estado') then
                        ValorEmisor.Direccion.Estado := DomicilioFiscal.Estado;
                      if TieneAtributo(DomicilioFiscal, 'pais') then
                        ValorEmisor.Direccion.Pais := DomicilioFiscal.Pais;
                  end;
              end;
              fev32:
              begin
                  if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor, 'nombre') then
                      ValorEmisor.Nombre:=IFEXmlComprobanteV32(fXmlComprobante).Emisor.Nombre;

                  if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor, 'rfc') then
                     ValorEmisor.RFC:=IFEXmlComprobanteV32(fXmlComprobante).Emisor.RFC;

                  with IFEXmlComprobanteV32(fXmlComprobante).Emisor do
                  begin
                      if TieneAtributo(DomicilioFiscal, 'calle') then
                        ValorEmisor.Direccion.Calle := DomicilioFiscal.Calle;
                      if TieneAtributo(DomicilioFiscal, 'noExterior') then
                        ValorEmisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
                      if TieneAtributo(DomicilioFiscal, 'noInterior') then
                        ValorEmisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
                      if TieneAtributo(DomicilioFiscal, 'codigoPostal') then
                        ValorEmisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
                      if TieneAtributo(DomicilioFiscal, 'colonia') then
                        ValorEmisor.Direccion.Colonia := DomicilioFiscal.Colonia;
                      if TieneAtributo(DomicilioFiscal, 'localidad') then
                        ValorEmisor.Direccion.Localidad := DomicilioFiscal.Localidad;
                      if TieneAtributo(DomicilioFiscal, 'municipio') then
                        ValorEmisor.Direccion.Municipio := DomicilioFiscal.Municipio;
                      if TieneAtributo(DomicilioFiscal, 'estado') then
                        ValorEmisor.Direccion.Estado := DomicilioFiscal.Estado;
                      if TieneAtributo(DomicilioFiscal, 'pais') then
                        ValorEmisor.Direccion.Pais := DomicilioFiscal.Pais;
                  end;
              end;
            end;

            // Copiamos los régimenes fiscales del emisor
            if (fVersion = fev22) then
            begin
                SetLength(ValorEmisor.Regimenes, IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal.Count);
                for I := 0 to IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal.Count - 1 do
                begin
                     feRegimen := IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal[I].Regimen;
                     ValorEmisor.Regimenes[I]:=feRegimen;
                end;
            end
            else if (fVersion = fev32) then
            begin
                SetLength(ValorEmisor.Regimenes, IFEXMLComprobanteV32(fXmlComprobante).Emisor.RegimenFiscal.Count);
                for I := 0 to IFEXMLComprobanteV32(fXmlComprobante).Emisor.RegimenFiscal.Count - 1 do
                begin
                     feRegimen := IFEXMLComprobanteV32(fXmlComprobante).Emisor.RegimenFiscal[I].Regimen;
                     ValorEmisor.Regimenes[I]:=feRegimen;
                end;
            end;

            inherited Emisor:=ValorEmisor;

            ValorReceptor.RFC:=Receptor.Rfc;

            // Leemos los datos del receptor solo si no es publico en general o extranjero
            if ((Uppercase(ValorReceptor.RFC) <> _RFC_VENTA_PUBLICO_EN_GENERAL) And
                (Uppercase(ValorReceptor.RFC) <> _RFC_VENTA_EXTRANJEROS)) then
            begin
                  if TieneAtributo(Receptor, 'nombre') then
                      ValorReceptor.Nombre:=Receptor.Nombre;

                  with Receptor do
                  begin
                      if TieneAtributo(Domicilio, 'calle') then
                        ValorReceptor.Direccion.Calle := Domicilio.Calle;
                      if TieneAtributo(Domicilio, 'noExterior') then
                        ValorReceptor.Direccion.NoExterior := Domicilio.NoExterior;
                      if TieneAtributo(Domicilio, 'noInterior') then
                        ValorReceptor.Direccion.NoInterior := Domicilio.NoInterior;
                      if TieneAtributo(Domicilio, 'codigoPostal') then
                       ValorReceptor.Direccion.CodigoPostal := Domicilio.CodigoPostal;
                      if TieneAtributo(Domicilio, 'colonia') then
                        ValorReceptor.Direccion.Colonia := Domicilio.Colonia;
                      if TieneAtributo(Domicilio, 'localidad') then
                        ValorReceptor.Direccion.Localidad := Domicilio.Localidad;
                      if TieneAtributo(Domicilio, 'municipio') then
                        ValorReceptor.Direccion.Municipio := Domicilio.Municipio;
                      if TieneAtributo(Domicilio, 'estado') then
                        ValorReceptor.Direccion.Estado := Domicilio.Estado;
                      if TieneAtributo(Domicilio, 'pais') then
                        ValorReceptor.Direccion.Pais := Domicilio.Pais;
                  end;
            end;
            inherited Receptor:=ValorReceptor;

            // Tiene lugar de expedicion
            case fVersion of
              fev20:
              begin
                    if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor, 'ExpedidoEn') then
                    begin
                          with IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn do
                          begin
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'calle') then
                                ValorExpedidoEn.Calle := Calle;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'NoExterior') then
                                ValorExpedidoEn.NoExterior := NoExterior;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'codigoPostal') then
                                ValorExpedidoEn.CodigoPostal := CodigoPostal;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'localidad') then
                                ValorExpedidoEn.Localidad := Localidad;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'municipio') then
                                ValorExpedidoEn.Municipio := Municipio;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'colonia') then
                                ValorExpedidoEn.Colonia := Colonia;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'estado') then
                                ValorExpedidoEn.Estado := Estado;
                              if TieneAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn, 'pais') then
                                ValorExpedidoEn.Pais := Pais;
                          end;
                    end;
              end;
              fev22:
              begin
                   if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor, 'ExpedidoEn') then
                    begin
                          with IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn do
                          begin
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'calle') then
                                ValorExpedidoEn.Calle := Calle;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'NoExterior') then
                                ValorExpedidoEn.NoExterior := NoExterior;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'codigoPostal') then
                                ValorExpedidoEn.CodigoPostal := CodigoPostal;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'localidad') then
                                ValorExpedidoEn.Localidad := Localidad;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'municipio') then
                                ValorExpedidoEn.Municipio := Municipio;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'colonia') then
                                ValorExpedidoEn.Colonia := Colonia;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'estado') then
                                ValorExpedidoEn.Estado := Estado;
                              if TieneAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn, 'pais') then
                                ValorExpedidoEn.Pais := Pais;
                          end;
                    end;
              end;
              fev32:
              begin
                   if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor, 'ExpedidoEn') then
                    begin
                          with IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn do
                          begin
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'calle') then
                                ValorExpedidoEn.Calle := Calle;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'NoExterior') then
                                ValorExpedidoEn.NoExterior := NoExterior;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'codigoPostal') then
                                ValorExpedidoEn.CodigoPostal := CodigoPostal;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'localidad') then
                                ValorExpedidoEn.Localidad := Localidad;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'municipio') then
                                ValorExpedidoEn.Municipio := Municipio;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'colonia') then
                                ValorExpedidoEn.Colonia := Colonia;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'estado') then
                                ValorExpedidoEn.Estado := Estado;
                              if TieneAtributo(IFEXmlComprobanteV32(fXmlComprobante).Emisor.ExpedidoEn, 'pais') then
                                ValorExpedidoEn.Pais := Pais;
                          end;
                    end;
              end;
            end;
            inherited ExpedidoEn:=ValorExpedidoEn;

            for I := 0 to Conceptos.Count - 1 do
            begin
                feConcepto.Cantidad:=StrToFloat(Conceptos[I].Cantidad);
                if TieneAtributo(Conceptos[I], 'unidad') then
                  feConcepto.Unidad:=Conceptos[I].Unidad;
                feConcepto.Descripcion:=Conceptos[I].Descripcion;
                feConcepto.ValorUnitario:=StrToFloat(Conceptos[I].ValorUnitario);
                if TieneAtributo(Conceptos[I], 'noIdentificacion') then
                  feConcepto.NoIdentificacion:=Conceptos[I].NoIdentificacion;

                inherited AgregarConcepto(feConcepto);
            end;

            // Agregamos las reteneciones
            if Assigned(ChildNodes.FindNode('Impuestos')) then
              if Assigned(ChildNodes.FindNode('Impuestos').ChildNodes.FindNode('Retenciones')) then
                for I := 0 to fXmlComprobante.Impuestos.Retenciones.Count - 1 do
                begin
                    ImpuestoRetenido.Nombre := fXmlComprobante.Impuestos.Retenciones.Retencion[I].Impuesto;
                    ImpuestoRetenido.Importe := StrToFloat(fXmlComprobante.Impuestos.Retenciones.Retencion[I].Importe);
                    inherited AgregarImpuestoRetenido(ImpuestoRetenido);
                end;

            // Agregamos los traslados
            if Assigned(ChildNodes.FindNode('Impuestos')) then
            begin
              if Assigned(ChildNodes.FindNode('Impuestos').ChildNodes.FindNode('Traslados')) then
                for I := 0 to Impuestos.Traslados.Count - 1 do
                begin
                  with Impuestos.Traslados do
                  begin
                    ImpuestoTrasladado.Nombre := Traslado[I].Impuesto;
                    ImpuestoTrasladado.Tasa:= StrToFloat(Traslado[I].Tasa);
                    ImpuestoTrasladado.Importe := StrToFloat(Traslado[I].Importe);
                    inherited AgregarImpuestoTrasladado(ImpuestoTrasladado);
                  end;
                end;
                //AsignarImpuestosTrasladados;
            end;


            if TieneAtributo(Impuestos, 'totalImpuestosTraslados') then
                Self.DesglosarTotalesImpuestos := True
            else
                Self.DesglosarTotalesImpuestos := False;

            // Que forma de pago tuvo??
            if AnsiPos('UNA', Uppercase(FormaDePago)) > 0 then
                inherited FormaDePago := fpUnaSolaExhibicion
            else
                inherited FormaDePago := fpParcialidades;

            // Tipo de comprobante
            if TipoDeComprobante = 'ingreso' then
              inherited Tipo := tcIngreso;

            if TipoDeComprobante = 'egreso' then
              inherited Tipo := tcEgreso;

            if TipoDeComprobante = 'traslado' then
              inherited Tipo := tcTraslado;

            // Asignamos el descuento
            if TieneAtributo(fXmlComprobante, 'descuento') then
            begin
              if TieneAtributo(fXmlComprobante, 'motivoDescuento') then
                sMotivoDescuento:=MotivoDescuento
              else
                sMotivoDescuento:='';

              Self.AsignarDescuento(StrToFloat(Descuento), sMotivoDescuento);
            end;

            // Asignamos el subtotal de la factura
            inherited SubTotal := StrToFloat(Subtotal);

            // Leemos el timbre del CFDI
            if fVersion In [fev32] then
            begin
              LeerPropiedadesDeTimbre;
            end;

            // Indicamos que el comprobante XML ya fue "llenado"
            fComprobanteLleno:=True;

            // Asignamos el sello que trae el XML
            fSelloDigitalCalculado:=Sello;

            // Ahora hacemos que se calcule la cadena original de nuevo
            fCadenaOriginalCalculada:=getCadenaOriginal;

            // Indicamos que la factura ya fue generada
            FacturaGenerada:=True;

            //Assert(CurrToStr(Self.Total) = Total, 'El total del comprobante no fue igual que el total del XML');
        end;
    except
        On E:Exception do
        begin
          {$IFDEF DEBUG}
              ShowMessage(E.Message);
          {$ENDIF}
          Raise Exception.Create(E.Message);
        end;
    end;
end;

// Regresa el XML final del comprobante ya lleno
function TFEComprobanteFiscal.getXML: WideString;
begin
    // Checamos si ya fue generada previamente la factura
    if FacturaGenerada = True then
        Result:=fDocumentoXML.XML.Text
    else
        Raise Exception.Create('No se puede obtener el XML cuando aún no se ha generado el archivo CFD');
end;

procedure TFEComprobanteFiscal.ValidarCamposEmisor;
begin
  case fVersion of
    fev22, fev32:
    begin
       if Trim((inherited Emisor).RFC) = '' then
        raise EFEAtributoRequeridoNoPresenteException.Create('El Atributo RFC de Emisor está vacio');

       if Length(inherited Emisor.Regimenes) = 0 then
        raise EFEAtributoRequeridoNoPresenteException.Create('Se debe especificar al menos 1 régimen fiscal');

       if Trim((inherited Emisor).Direccion.Pais) = '' then
        raise EFEAtributoRequeridoNoPresenteException.Create('Se debe especificar el pais del emisor');
    end;
  end;
end;

procedure TFEComprobanteFiscal.ValidarCamposReceptor;
begin
    case fVersion of
    fev22, fev32:
    begin
       if Trim((inherited Receptor).RFC) = '' then
        raise EFEAtributoRequeridoNoPresenteException.Create('El Atributo RFC de Receptor está vacio');

       if Trim((inherited Receptor).Direccion.Pais) = '' then
        raise EFEAtributoRequeridoNoPresenteException.Create('Se debe especificar el pais del Receptor');
    end;
  end;
end;

end.
