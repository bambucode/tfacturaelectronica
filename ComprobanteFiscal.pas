{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

  Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
  los metodos para generarla.

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *}
unit ComprobanteFiscal;

interface

uses FacturaTipos, FeCFDv2, SysUtils, dialogs,
  // Unidades especificas de manejo de XML:
  XmlDom, XMLIntf, MsXmlDom, XMLDoc,
  {$IFDEF VER220}
    CodeSiteLogging,
  {$ENDIF}
  XSLProd;

type

  // Excepciones que pueden ser generadas
  EFECertificadoNoExisteException = class(Exception);
  EFECertificadoNoVigente =  class(Exception);
  EFEFolioFueraDeRango = class(Exception);

  /// <summary>Representa la estructura de comprobante fiscal digital (ver2.0) y sus elementos
  /// definidos de acuerdo al XSD del SAT. Esta pensado para ser extendido en las versiones
  /// posteriores que el SAT publique (ver3.0, ver4.0, etc.).
  /// Se encarga de validar y formatear todos los datos de la factura que le sean proporcionados
  /// </summary>
  TFEComprobanteFiscal = class
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  private
{$ENDIF}
    // Variables internas
    bFacturaGenerada: Boolean;
    fDocumentoXML: TXMLDocument;
    fXmlComprobante: IFEXMLComprobante;

    // Propiedades del comprobante
    sCacheCadenaOriginal: TStringCadenaOriginal;
    fFolio: TFEFolio;
    fSelloDigitalCalculado: String;
    fCertificado: TFECertificado;
    fBloqueFolios: TFEBloqueFolios;
    fFormaDePago: TFEFormaDePago;
    fTipoComprobante: TFeTipoComprobante;
    fExpedidoEn: TFeExpedidoEn;
    fFechaGeneracion: TDateTime;
    fCondicionesDePago: String;
    fMetodoDePago: String;
    sForma: String;
    fDescuento: Currency;
    sMotivoDescuento: String;

    // Nuevas propiedades
    fArrConceptos: TFEConceptos;
    fArrImpuestosTrasladados: TFEImpuestosTrasladados;
    fArrImpuestosRetenidos: TFEImpuestosRetenidos;

    fTotal: Currency;
    fSubTotal: Currency;
    fTotalImpuestosRetenidos: Currency;
    fTotalImpuestosTrasladados: Currency;

    // Variables "cache"
    bHuboRetenciones: Boolean;
    bHuboTraslados: Boolean;

    // Opciones de configuracion
    _CADENA_PAGO_UNA_EXHIBICION: String;
    _CADENA_PAGO_PARCIALIDADES: String;
    fDesglosarTotalesImpuestos: Boolean;
    bIncluirCertificadoEnXML: Boolean;

    function ObtenerImporte(Concepto: TFEConcepto) : Currency;
    procedure LlenarComprobante(iFolio: Integer; fpFormaDePago: TFEFormaDePago);

    // Getters/Setters:
    procedure setSubTotal(dMonto: Currency);
    procedure setExpedidoEn(ExpedidoEn: TFeExpedidoEn);
    procedure setTipoComprobante(Tipo: TFeTipoComprobante);
    procedure setFormaDePago(FormaDePago: TFEFormaDePago);
    /// <summary>Establece la forma de pago, para expresar el método de pago de los bienes o servicios amparados por el
    /// comprobante. Se entiende como método de pago leyendas tales como: cheque, tarjeta de crédito o debito, depósito
    // en cuenta, etc.</summary>
    procedure setMetodoDePago(sFormaDePago: String);
    procedure setReceptor(Receptor: TFEContribuyente);
    procedure setEmisor(Emisor: TFEContribuyente);
    procedure setFolio(Folio: TFEFolio);
    procedure setCondicionesDePago(Condiciones: String);
    function obtenerSerie(): TFESerie;
    procedure setCertificado(Certificado: TFECertificado);

    /// <summary>Obtiene la 'Cadena Original' segun las reglas del Anexo 20</summary>
    function getCadenaOriginal(): TStringCadenaOriginal;
    function getSelloDigital(): String;
    procedure setBloqueFolios(Bloque: TFEBloqueFolios);
    function getTotal() : Currency;
    procedure ValidarQueFolioEsteEnRango;
    function getConceptos() : IFEXmlConceptos;
 {$IFDEF VERSION_DE_PRUEBA}
  public
    _USAR_HORA_REAL : Boolean;
{$ELSE}
  protected
{$ENDIF}
    fEmisor: TFEContribuyente;
    fReceptor: TFEContribuyente;
    function getXML(): WideString; virtual;
    procedure setXML(Valor: WideString); virtual;
    
    // Propiedades del comprobante normal
    property Folio: TFEFolio read fFolio write setFolio;
    property Receptor: TFEContribuyente read fReceptor write setReceptor;
    property Emisor: TFEContribuyente read fEmisor write setEmisor;
    property FormaDePago: TFEFormaDePago read fFormaDePago write setFormaDePago;
    property Tipo: TFeTipoComprobante read fTipoComprobante write setTipoComprobante;
    property ExpedidoEn: TFeDireccion read fExpedidoEn write setExpedidoEn;
    property SubTotal: Currency read fSubTotal write setSubTotal;
    property CondicionesDePago: String read fCondicionesDePago write setCondicionesDePago;
    property MetodoDePago: String read fMetodoDePago write setMetodoDePago;
    property FechaGeneracion : TDateTime read fFechaGeneracion;
    property Conceptos: TFEConceptos read fArrConceptos;
    property ImpuestosRetenidos: TFEImpuestosRetenidos read fArrImpuestosRetenidos;
    property ImpuestosTrasladados: TFEImpuestosTrasladados read fArrImpuestosTrasladados;

    /// <summary>Agrega un nuevo concepto a la factura, regresa la posicion de dicho concepto en
    /// el arreglo de 'Conceptos'</summary>
    /// <param name="NuevoConcepto">Este es el nuevo concepto a agregar a la factura
    ///   el parametro es un "record" del tipo TFEConcepto.</param>
    function AgregarConcepto(NuevoConcepto: TFeConcepto) : Integer;
    /// <summary>Agrega un nuevo impuesto de retención (ISR, IVA) al comprobante</summary>
    /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre e importe del mismo</param>
    function AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido) : Integer;
    /// <summary>Agrega un nuevo impuesto de traslado (IVA, IEPS)</summary>
    /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre, tasa e importe del mismo</param>
    function AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado) : Integer;

    /// <summary>Asigna el importe total de descuentos aplicados al comprobante asi como su motivo </summary>
    /// <param name="ImporteDescuento">El monto total de descuentos realizados al comprobante</param>
    /// <param name="Motivo">Atributo opcional para indicar el motivo del descuento</param>
    procedure AsignarDescuento(ImporteDescuento: Currency; Motivo: String);
    procedure GuardarEnArchivo(sArchivoDestino: String);
    property Certificado: TFECertificado read fCertificado write setCertificado;
    property BloqueFolios: TFEBloqueFolios read fBloqueFolios write setBloqueFolios;
  public
    // Version del CFD que implementa este código
    const
         Version = '2';

    constructor Create();
    destructor Destroy(); override;
    procedure Cancelar();
    property Serie: TFESerie read obtenerSerie;
    property TotalImpuestosRetenidos: Currency read fTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: Currency read fTotalImpuestosTrasladados;
    property Total: Currency read getTotal;
    property FacturaGenerada: Boolean read bFacturaGenerada;

    // Propiedades especificas al comprobante electronico
    property DesglosarTotalesImpuestos: Boolean read fDesglosarTotalesImpuestos write fDesglosarTotalesImpuestos;
    property IncluirCertificadoEnXml: Boolean read bIncluirCertificadoEnXML write bIncluirCertificadoEnXML;
    property XML: WideString read getXML write setXML;
    property CadenaOriginal: TStringCadenaOriginal read getCadenaOriginal;
    property SelloDigital: String read getSelloDigital;
  end;

const
    _CADENA_INICIO_CERTIFICADO = '-----BEGIN CERTIFICATE-----';
    _CADENA_FIN_CERTIFICADO    = '-----END CERTIFICATE-----';

implementation

// TODO:
// Incluimos los archivos XSLT como recursos (.RES) para no tener que distribuirlos
// manualmente en el EXE
// Mas Info en: http://delphi.about.com/od/objectpascalide/a/embed_resources.htm

uses FacturaReglamentacion, ClaseOpenSSL, StrUtils, SelloDigital,
  OpenSSLUtils, Classes, CadenaOriginal;

// Al crear el objeto, comenzamos a "llenar" el XML interno
constructor TFEComprobanteFiscal.Create();
begin
  _CADENA_PAGO_UNA_EXHIBICION := 'Pago en una sola exhibición';
  _CADENA_PAGO_PARCIALIDADES := 'En parcialidades';

  // Establecemos los defaults
  sCacheCadenaOriginal:='';
  bFacturaGenerada:=False;
  bHuboRetenciones:=False;
  bHuboTraslados:=False;

  {$IFDEF VERSION_DE_PRUEBA}
    _USAR_HORA_REAL := False;
  {$ENDIF}

  // Establecemos como default que SI queremos incluir el certificado en el XML
  // ya que presenta la ventaja de poder validar el comprobante con solo el archivo
  // XML.
  bIncluirCertificadoEnXML := True;

  // Incializamos los valores del comprobante con datos invalidos
  fBloqueFolios.FolioInicial := -1;
  fBloqueFolios.FolioFinal := -1;
  fFolio := -1;
  // Establecemos los totales en cero...
  fDescuento := 0;
  fSubTotal := 0;
  fTotalImpuestosRetenidos := 0;
  fTotalImpuestosTrasladados := 0;
  fDesglosarTotalesImpuestos := True;

  // Creamos el objeto XML
  fDocumentoXML := TXMLDocument.Create(nil);
  fDocumentoXML.Active := True;

  // Obtenemos el elemento "Comprobante" para llenar sus datos...
  fXmlComprobante := GetComprobante(fDocumentoXML);
  // De acuerdo a los articulos 29 y 29-A del CFF - Referencia: Revista "IDC Factura electronica" (Sept/2010) - Pag 49
  fXmlComprobante.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
  fXmlComprobante.SetAttribute('xsi:schemaLocation',
    'http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd');
  fXmlComprobante.Version := '2.0';

  fDocumentoXML.Version := '1.0';
  fDocumentoXML.Encoding := 'UTF-8';
end;

destructor TFEComprobanteFiscal.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  fXmlComprobante := nil;
  inherited;
end;


function TFEComprobanteFiscal.getCadenaOriginal(): TStringCadenaOriginal;
var
  CadenaOriginal : TCadenaOriginal;
begin
    if bFacturaGenerada = True then
    begin
        Result:=sCacheCadenaOriginal;
    end else
    begin
        // Especificamos la fecha exacta en la que se esta generando el comprobante
        {$IFDEF VERSION_DE_PRUEBA}
          // Si estamos en las pruebas de unidad, dejamos que la prueba
          // defina la fecha/hora en que se "genero" el comprobante
          // para que sea el mismo que se uso al haber sido generado con el MicroE
          if (_USAR_HORA_REAL = True) then
             fFechaGeneracion:=Now;
        {$ELSE}
            // Si ya fue generada la factura (por ejemplo cuando se lee)
            fFechaGeneracion := Now;
        {$ENDIF}

        // Almacenamos las propiedades del XML antes de generar la cadena original
        fXmlComprobante.Fecha := TFEReglamentacion.ComoFechaHora(fFechaGeneracion);

        // Agregamos al XML los totales de los diferentes tipos de impuestos usados
        // si asi se desea...
        if fDesglosarTotalesImpuestos = True then
          with fXmlComprobante.Impuestos do
          begin
            if (fTotalImpuestosRetenidos > 0) then
              TotalImpuestosRetenidos := TFEReglamentacion.ComoMoneda(fTotalImpuestosRetenidos); // Opcional

            if (fTotalImpuestosTrasladados > 0) then
              TotalImpuestosTrasladados := TFEReglamentacion.ComoMoneda(fTotalImpuestosTrasladados); // Opcional
          end;

        // Asignamos el total del comprobante
        fXmlComprobante.Total := TFEReglamentacion.ComoMoneda(Self.Total);

        try
            CadenaOriginal := TCadenaOriginal.Create(fXmlComprobante, fDesglosarTotalesImpuestos);
            sCacheCadenaOriginal:=CadenaOriginal.Calcular;
            Result:=sCacheCadenaOriginal;
        finally
            FreeAndNil(CadenaOriginal);
        end;
    end;
end;

// Regresamos la Cadena Original de este comprobante fiscal segun las reglas
// definidas previamente...
{
  function TFEComprobanteFiscal.getCadenaOriginalOld(): WideString;
  var
  XSLTransformador: TXSLPageProducer;
  begin
  // La cadena original tambien puede ser generada usando un componente de transformacion
  // XSLT y usando los archivos para dicho proposito, sin embargo se decidio
  // hacerlo manualmente para evitar multiples dependencias de librerias DLL para su funcionamiento

  // Primero, extraemos los archivos XSLT para realizar la transformacion de los archivos .RES
  // TODO: Extraer de los RES



  XSLTransformador := TXSLPageProducer.Create(nil);
  XSLTransformador.ParseOptions := [poResolveExternals, poValidateOnParse];
  // XMLDocument1.Active := False; // just in case
  XSLTransformador.FileName :='C:\Delphi\Otros\bc_facturacionelectronica\Resources\cadenaoriginal_2_0_l.xslt';
  XSLTransformador.XMLData := fDocumentoXML;
  // XMLDocument1.Active := True;
  // Al ejecutar la siguiente lienea, el transformador usa la plantilla XSLT del SAT
  // para convertir el XML en la CadenaOriginal usando precisamente, las reglas de validacion
  // y presentacion definidas en los documentos XSLT.
  try
  sCadenaOriginal := XSLTransformador.Content;
  // XMLDocument1.Active := False;
  // TODO: Codificar en UTF8??? o ya viene asi del XSLT????
  // NOTA: Al obtenerlo para desplegarlo hay que descodificarlo de UTF8, por ejemplo para un Memo edit.
  Result := sCadenaOriginal;
  except
  // Manejar los diversos errores de validacion que se pueden generar...
  On E: Exception do
  begin
  ShowMessage(E.Message);
  Result := '';
  end;
  end;

  FreeAndNil(XSLTransformador);
  end;
}

// Regresa el total con descuento si acaso se especifico
function TFEComprobanteFiscal.getTotal() : Currency;
begin
   // REWRITE: Obtener el total del XML si la factura ya fue generada
   Result:=fSubTotal + fTotalImpuestosRetenidos + fTotalImpuestosTrasladados - fDescuento;
end;

procedure TFEComprobanteFiscal.AsignarDescuento(ImporteDescuento: Currency; Motivo: String);
begin
  fDescuento := ImporteDescuento;

  sMotivoDescuento := Motivo;
  fXmlComprobante.Descuento := TFEReglamentacion.ComoMoneda(fDescuento);

  if Trim(sMotivoDescuento) <> '' then
    fXmlComprobante.MotivoDescuento := TFEReglamentacion.ComoCadena(sMotivoDescuento);
end;

procedure TFEComprobanteFiscal.setCondicionesDePago(Condiciones: String);
begin
  fCondicionesDePago := Condiciones;
  if Trim(Condiciones) <> '' then
    fXmlComprobante.CondicionesDePago := TFEReglamentacion.ComoCadena(fCondicionesDePago);
end;

// 1. Datos de quien la expide (Emisor) (Art. 29-A, Fraccion I)
procedure TFEComprobanteFiscal.setEmisor(Emisor: TFEContribuyente);
begin
  fEmisor:=Emisor;
  with fXmlComprobante.Emisor do
  begin
    RFC := Emisor.RFC;
    Nombre := TFEReglamentacion.ComoCadena(Emisor.Nombre);
    with DomicilioFiscal do // Alias de UbicacionFiscal
    begin
      Calle := TFEReglamentacion.ComoCadena(Emisor.Direccion.Calle);

      if Trim(Emisor.Direccion.NoExterior) <> '' then
        NoExterior := Emisor.Direccion.NoExterior; // Opcional

      if Trim(Emisor.Direccion.NoInterior) <> '' then
        NoInterior := Emisor.Direccion.NoInterior; // Opcional

      if Trim(Emisor.Direccion.Colonia) <> '' then
        Colonia := TFEReglamentacion.ComoCadena(Emisor.Direccion.Colonia); // Opcional

      if Trim(Emisor.Direccion.Localidad) <> '' then
        Localidad := TFEReglamentacion.ComoCadena(Emisor.Direccion.Localidad); // Opcional

      if Trim(Emisor.Direccion.Referencia) <> '' then
        Referencia := TFEReglamentacion.ComoCadena(Emisor.Direccion.Referencia); // Opcional

      Municipio := TFEReglamentacion.ComoCadena(Emisor.Direccion.Municipio);
      Estado := TFEReglamentacion.ComoCadena(Emisor.Direccion.Estado);
      Pais := TFEReglamentacion.ComoCadena(Emisor.Direccion.Pais);
      CodigoPostal := Emisor.Direccion.CodigoPostal;
    end;
  end;
end;

// 3. Clave del RFC de la persona a favor de quien se expida la factura (29-A, Fraccion IV)
procedure TFEComprobanteFiscal.setReceptor(Receptor: TFEContribuyente);
begin
  fReceptor:=Receptor;
  with fXmlComprobante.Receptor do
  begin
    RFC := Receptor.RFC;
    Nombre := TFEReglamentacion.ComoCadena(Receptor.Nombre);

    with Domicilio do
    begin
      Calle := TFEReglamentacion.ComoCadena(Receptor.Direccion.Calle);

      if Trim(Receptor.Direccion.NoExterior) <> '' then
        NoExterior := Receptor.Direccion.NoExterior; // Opcional

      if Trim(Receptor.Direccion.NoInterior) <> '' then
        NoInterior := Receptor.Direccion.NoInterior; // Opcional

      if Trim(Receptor.Direccion.Colonia) <> '' then
        Colonia := TFEReglamentacion.ComoCadena(Receptor.Direccion.Colonia); // Opcional
      if Trim(Receptor.Direccion.Localidad) <> '' then
        Localidad := TFEReglamentacion.ComoCadena(Receptor.Direccion.Localidad); // Opcional
      if Trim(Receptor.Direccion.Referencia) <> '' then
        Referencia := TFEReglamentacion.ComoCadena(Receptor.Direccion.Referencia); // Opcional
      Municipio := TFEReglamentacion.ComoCadena(Receptor.Direccion.Municipio);
      Estado := TFEReglamentacion.ComoCadena(Receptor.Direccion.Estado);
      Pais := TFEReglamentacion.ComoCadena(Receptor.Direccion.Pais);
      CodigoPostal := Receptor.Direccion.CodigoPostal;
    end; { with CFD.Receptor.Domicilio }
  end; { with CFD.Receptor }
end;

procedure TFEComprobanteFiscal.setCertificado(Certificado: TFECertificado);
var
  x509Certificado: TX509Certificate;
  CertificadoBase64: WideString;

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
  fCertificado := Certificado;
  x509Certificado := TX509Certificate.Create;
  try
    if Not FileExists(Certificado.Ruta) then
      raise EFECertificadoNoExisteException.Create('No existe el archivo del certificado')
    else
      x509Certificado.LoadFromFile(Certificado.Ruta);

    // Llenamos las propiedades
    fCertificado.VigenciaInicio := x509Certificado.NotBefore;
    fCertificado.VigenciaFin := x509Certificado.NotAfter;

    // Checamos que el certificado este dentro de la vigencia
    if Not((Now >= fCertificado.VigenciaInicio) and (Now <= fCertificado.VigenciaFin)) then
      raise EFECertificadoNoVigente.Create('El certificado no tiene vigencia actual');

    fCertificado.NumeroSerie := x509Certificado.SerialNumber;

    // Ya procesado llenamos su propiedad en el XML
    fXmlComprobante.NoCertificado := fCertificado.NumeroSerie;

    // Incluir el certificado en el XML?
    if bIncluirCertificadoEnXML = True then
    begin
       // Obtenemos el certificado codificado en Base64 para incluirlo en el comprobante
       CertificadoBase64:=X509Certificado.AsBase64;
       //ShowMessage(CertificadoBase64 + '<--');
       CertificadoBase64:=QuitarCaracteresNoUsadosEnCertificado(X509Certificado.AsBase64);
       //CodeSite.Send('Certificado Base64', CertificadoBase64);
       //CodeSite.Send('length', Length(CertificadoBase64));
       fXmlComprobante.Certificado := TFEReglamentacion.ComoCadena(CertificadoBase64);
    end;

  except
     // Pasamos la excepcion tal y como esta
     On E: Exception do
     begin
        FreeAndNil(x509Certificado);
        raise Exception.Create(E.Message);
     end;
  end;
  FreeAndNil(x509Certificado);
end;


{
}

function TFEComprobanteFiscal.ObtenerImporte(Concepto: TFEConcepto) : Currency;
begin
    Result:=Concepto.ValorUnitario * Concepto.Cantidad;
end;

function TFEComprobanteFiscal.AgregarConcepto(NuevoConcepto: TFEConcepto) : Integer;
begin
    SetLength(fArrConceptos, Length(fArrConceptos) + 1);
    fArrConceptos[Length(fArrConceptos) - 1] := NuevoConcepto;

    // Se Suma el total
    fSubtotal := fSubtotal + ObtenerImporte(NuevoConcepto);
    fTotal:=fTotal + ObtenerImporte(NuevoConcepto);

    Result:=Length(fArrConceptos) - 1;
end;

function TFEComprobanteFiscal.AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido) : Integer;
begin
    SetLength(fArrImpuestosRetenidos, Length(fArrImpuestosRetenidos) + 1);
    fArrImpuestosRetenidos[Length(fArrImpuestosRetenidos) - 1] := NuevoImpuesto;
    fTotalImpuestosRetenidos:=fTotalImpuestosRetenidos + NuevoImpuesto.Importe;
    Result:=Length(fArrImpuestosRetenidos) - 1;
end;

function TFEComprobanteFiscal.AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado) : Integer;
begin
    SetLength(fArrImpuestosTrasladados, Length(fArrImpuestosTrasladados) + 1);
    fArrImpuestosTrasladados[Length(fArrImpuestosTrasladados) - 1] := NuevoImpuesto;
    fTotalImpuestosTrasladados:=fTotalImpuestosTrasladados + NuevoImpuesto.Importe;
    Result:=Length(fArrImpuestosTrasladados) - 1;
end;

// Funcion encargada de llenar el comprobante fiscal EN EL ORDEN que se especifica en el XSD
// ya que si no es asi, el XML se va llenando en el orden en que se establecen las propiedades de la clase
// haciendo que el comprobante no pase las validaciones del SAT.
procedure TFEComprobanteFiscal.LlenarComprobante(iFolio: Integer; fpFormaDePago: TFEFormaDePago);
var
   I: Integer;

   procedure AgregarConceptoAlXML(Concepto: TFEConcepto);
   begin
        // Agregamos el concepto de la factura
        with fXmlComprobante.Conceptos.Add do
        begin
          Cantidad := TFEReglamentacion.ComoCantidad(Concepto.Cantidad);

          if Trim(Concepto.Unidad) <> '' then
            Unidad := Concepto.Unidad; // Opcional

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

   procedure AgregarImpuestoRetenidoAlXML(NuevoImpuesto: TFEImpuestoRetenido);
   begin
        with fXmlComprobante.Impuestos.Retenciones.Add do
        begin
          Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
          Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
        end;
   end;

   procedure AgregarImpuestoTrasladadoAlXML(NuevoImpuesto: TFEImpuestoTrasladado);
   begin
        with fXmlComprobante.Impuestos.Traslados.Add do
        begin
          Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
          Tasa := TFEReglamentacion.ComoTasaImpuesto(NuevoImpuesto.Tasa);
          Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
        end;
   end;

begin
    Self.Emisor:=fEmisor;
    Self.Receptor:=fReceptor;
    
    // Agregamos todos los conceptos que fueron agregados previamente al arreglo
    for I := 0 to Length(fArrConceptos) - 1 do
        AgregarConceptoAlXML(fArrConceptos[I]);
        
    for I := 0 to Length(fArrImpuestosRetenidos) - 1 do
         AgregarImpuestoRetenidoAlXML(fArrImpuestosRetenidos[I]);

    for I := 0 to Length(fArrImpuestosTrasladados) - 1 do
         AgregarImpuestoTrasladadoAlXML(fArrImpuestosTrasladados[I]);

    // TODO: Asignar aqui los complementos y adendas
    Self.BloqueFolios:=fBloqueFolios; // Serie, etc.
    Self.Folio:=iFolio;
    Self.FormaDePago:=fpFormaDePago;
    Self.Certificado:=fCertificado;
    Self.CondicionesDePago:=fCondicionesDePago;
    Self.Subtotal:=fSubtotal;
    Self.AsignarDescuento(fDescuento, sMotivoDescuento);
    Self.MetodoDePago:=fMetodoDePago;
    Self.Tipo:=fTipoComprobante;
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

procedure TFEComprobanteFiscal.ValidarQueFolioEsteEnRango;
begin
  // Validamos que el folio este dentro del rango definido si ya se nos fue proporcionado
  // el bloque de folios y el numero de folio
  if not bFacturaGenerada then
    if ((fBloqueFolios.FolioInicial > -1) And (fFolio > -1)) then
    begin
      if Not((Folio >= fBloqueFolios.FolioInicial) And (Folio <= fBloqueFolios.FolioFinal)) then
        raise EFEFolioFueraDeRango.Create('El folio se encuentra fuera del rango autorizado');
    end;
end;

// 8. Numero de folio, el cual debe de ser asignado de manera automatica por el sistema
procedure TFEComprobanteFiscal.setFolio(Folio: TFEFolio);
begin
  fFolio := Folio;
  ValidarQueFolioEsteEnRango();
  fXmlComprobante.Folio := IntToStr(Folio);
end;

// Acceso rapido a la serie de la factura
function TFEComprobanteFiscal.obtenerSerie(): TFESerie;
begin
  result := fBloqueFolios.Serie;
end;

procedure TFEComprobanteFiscal.setBloqueFolios(Bloque: TFEBloqueFolios);
begin
  // Asignamos el bloque a la variable interna y validamos que este dentro del rango...
  fBloqueFolios := Bloque;
  ValidarQueFolioEsteEnRango();

  if Trim(Serie) <> '' then
    fXmlComprobante.Serie := Bloque.Serie;

  fXmlComprobante.NoAprobacion := Bloque.NumeroAprobacion;
  fXmlComprobante.AnoAprobacion := Bloque.AnoAprobacion;
end;

// 2. Lugar y fecha de expedicion (29-A, Fraccion III) - En caso de ser sucursal
procedure TFEComprobanteFiscal.setExpedidoEn(ExpedidoEn: TFeExpedidoEn);
begin
  fExpedidoEn := ExpedidoEn;
  with fXmlComprobante.Emisor.ExpedidoEn do
  begin
    Calle := TFEReglamentacion.ComoCadena(fExpedidoEn.Calle);
    if Trim(fExpedidoEn.NoExterior) <> '' then
      NoExterior := fExpedidoEn.NoExterior; // Opcional

    if Trim(fExpedidoEn.NoInterior) <> '' then
      NoInterior := fExpedidoEn.NoInterior; // Opcional

    if Trim(fExpedidoEn.Colonia) <> '' then
      Colonia := TFEReglamentacion.ComoCadena(fExpedidoEn.Colonia); // Opcional
    if Trim(fExpedidoEn.Localidad) <> '' then
      Localidad := TFEReglamentacion.ComoCadena(fExpedidoEn.Localidad); // Opcional
    if Trim(fExpedidoEn.Referencia) <> '' then
      Referencia := TFEReglamentacion.ComoCadena(fExpedidoEn.Referencia); // Opcional
    Municipio := TFEReglamentacion.ComoCadena(fExpedidoEn.Municipio);
    Estado := TFEReglamentacion.ComoCadena(fExpedidoEn.Estado);
    Pais := TFEReglamentacion.ComoCadena(fExpedidoEn.Pais);
    CodigoPostal := fExpedidoEn.CodigoPostal;
  end;
end;

procedure TFEComprobanteFiscal.setTipoComprobante(Tipo: TFeTipoComprobante);
var
  sTipo: String;
begin
  fTipoComprobante := Tipo;
  case Tipo of
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

// 9. Cumplir con las reglas de control de pagos (Art 29, fraccion V)
procedure TFEComprobanteFiscal.setFormaDePago(FormaDePago: TFEFormaDePago);
begin
  fFormaDePago := FormaDePago;
  case fFormaDePago of
    fpUnaSolaExhibicion:
      sForma := _CADENA_PAGO_UNA_EXHIBICION;
    fpParcialidades:
      sForma := _CADENA_PAGO_PARCIALIDADES;
  end;

  fXmlComprobante.FormaDePago := sForma;
end;

procedure TFEComprobanteFiscal.setMetodoDePago(sFormaDePago: String);
begin
  if Trim(sFormaDePago) <> '' then
     fXmlComprobante.MetodoDePago:=TFEReglamentacion.ComoCadena(sFormaDePago);
end;

procedure TFEComprobanteFiscal.setSubTotal(dMonto: Currency);
begin
  fSubTotal := dMonto;
  fXmlComprobante.SubTotal := TFEReglamentacion.ComoMoneda(dMonto);
end;

// Calculamos el sello digital para la cadena original de la factura
function TFEComprobanteFiscal.getSelloDigital(): String;
var
  TipoDigestion: TTipoDigestionOpenSSL;
  SelloDigital: TSelloDigital;
begin
  // Si la factura ya fue generada regresamos el sello previamente calculado
  if (bFacturaGenerada = True) then
  begin
      Result:=fSelloDigitalCalculado;
  end else
  begin
      fSelloDigitalCalculado:='';
      // Segun la leglislacion vigente si la factura se hace antes del 1 de Enero del 2011, usamos MD5
      if Now < EncodeDate(2011, 1, 1) then
        TipoDigestion := tdMD5
      else // Si es 2011 usamos el algoritmo SHA-1
        TipoDigestion := tdSHA1;
      try
        // Creamos la clase SelloDigital que nos ayudara a "sellar" la factura en XML
        SelloDigital := TSelloDigital.Create(Self.CadenaOriginal, fCertificado, TipoDigestion);

        // Finalmente regresamos la factura en XML con todas sus propiedades llenas
        fSelloDigitalCalculado := SelloDigital.SelloCalculado;
      except
        // TODO: Manejar los diferentes tipos de excepciones...
        on E:Exception do
           raise E.Create(E.Message);
      end;
      // Liberamos la clase de sello usada previamente
      FreeAndNil(SelloDigital);
      result := fSelloDigitalCalculado;
  end;
end;

function TFEComprobanteFiscal.getConceptos() : IFEXmlConceptos;
begin
    Result:=fXmlComprobante.Conceptos;
end;

// Permite establecer el XML del comprobante (por si se esta leyendo de la BD, etc)
procedure TFEComprobanteFiscal.setXML(Valor: WideString);
var
  I: Integer;
  feConcepto: TFEConcepto;
  iXmlDoc: IXMLDocument;
  ExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
begin
    try
        // Leemos el contenido XML en el Documento XML interno
        iXmlDoc:=LoadXMLData(UTF8Decode(Valor));
        //fDocumentoXML
        // Actualizamos el nodo comprobante
        fXmlComprobante := GetComprobante(iXmlDoc);
        // Actualizamos todas las variables internas (de la clase) con los valores del XML
        bFacturaGenerada:=True;
        
        with fXmlComprobante do
        begin
            fFolio:=StrToInt(Folio);
            // Datos del certificado
            fCertificado.NumeroSerie:=Certificado;
            fBloqueFolios.NumeroAprobacion:=NoAprobacion;
            fBloqueFolios.AnoAprobacion:=AnoAprobacion;
            fBloqueFolios.Serie:=Serie;
            fBloqueFolios.FolioInicial:=fFolio;
            fBloqueFolios.FolioFinal:=fFolio;

            fFechaGeneracion:=TFEReglamentacion.ComoDateTime(fXmlComprobante.Fecha);

            fCondicionesDePago:=CondicionesDePago;
            fMetodoDePago:=MetodoDePago;

            // Leemos los datos del emisor
            fEmisor.Nombre:=Emisor.Nombre;
            fEmisor.RFC:=Emisor.RFC;
            with Emisor do
            begin
                fEmisor.Direccion.Calle := DomicilioFiscal.Calle;
                fEmisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
                fEmisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
                fEmisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
                fEmisor.Direccion.Colonia := DomicilioFiscal.Colonia;
                fEmisor.Direccion.Localidad := DomicilioFiscal.Localidad;
                fEmisor.Direccion.Municipio := DomicilioFiscal.Municipio;
                fEmisor.Direccion.Estado := DomicilioFiscal.Estado;
                fEmisor.Direccion.Pais := DomicilioFiscal.Pais;
            end;

            // Leemos los datos del receptor
            fReceptor.Nombre:=Receptor.Nombre;
            fReceptor.RFC:=Receptor.Rfc;
            with Receptor do
            begin
                fReceptor.Direccion.Calle := Domicilio.Calle;
                fReceptor.Direccion.NoExterior := Domicilio.NoExterior;
                fReceptor.Direccion.NoInterior := Domicilio.NoInterior;
                fReceptor.Direccion.CodigoPostal := Domicilio.CodigoPostal;
                fReceptor.Direccion.Colonia := Domicilio.Colonia;
                fReceptor.Direccion.Localidad := Domicilio.Localidad;
                fReceptor.Direccion.Municipio := Domicilio.Municipio;
                fReceptor.Direccion.Estado := Domicilio.Estado;
                fReceptor.Direccion.Pais := Domicilio.Pais;
            end;

            // Tiene emisor??
            if (Emisor.ExpedidoEn.Calle <> '') then
            begin
                with Emisor.ExpedidoEn do
                begin
                    fExpedidoEn.Calle := Calle;
                    fExpedidoEn.NoExterior := NoExterior;
                    fExpedidoEn.CodigoPostal := CodigoPostal;
                    fExpedidoEn.Localidad := Localidad;
                    fExpedidoEn.Municipio := Municipio;
                    fExpedidoEn.Colonia := Colonia;
                    fExpedidoEn.Estado := Estado;
                    fExpedidoEn.Pais := Pais;
                end;
            end;

            // NOTA: No agregamos los conceptos aqui ya que ya se encuentran en el XML
            // y no se manejan estructuras internas para almacenarlos...

            bHuboRetenciones:=False;
            // Agregamos las reteneciones
            for I := 0 to Impuestos.Retenciones.Count - 1 do
            begin
              with Impuestos.Retenciones do
              begin
                ImpuestoRetenido.Nombre := Retencion[I].Impuesto;
                ImpuestoRetenido.Importe := StrToFloat(Retencion[I].Importe);

                Self.AgregarImpuestoRetenido(ImpuestoRetenido);
              end;
            end;

            // NOTA: Como ya se tienen los impuestos en el XML
            // solo contamos los totales para tenerlos en las variables internas
            bHuboTraslados:=False;
            bHuboRetenciones:=False;
            fTotalImpuestosRetenidos := 0;
            fTotalImpuestosTrasladados := 0;
            
            // Agregamos los impuestos trasladados
            for I := 0 to Impuestos.Retenciones.Count - 1 do
            begin
              fTotalImpuestosRetenidos:=fTotalImpuestosRetenidos + StrToFloat(Impuestos.Retenciones[I].Importe);
              bHuboRetenciones:=True;
            end;

            // Checamos si el XML proveido tiene los totales de impuestos desglosados...
            for I := 0 to Impuestos.Traslados.Count - 1 do
            begin
              fTotalImpuestosTrasladados:=fTotalImpuestosTrasladados + StrToFloat(Impuestos.Traslados[I].Importe);
              bHuboTraslados:=True;
            end;

            if (Impuestos.TotalImpuestosTrasladados <> '') then
                Self.DesglosarTotalesImpuestos := True
            else
                Self.DesglosarTotalesImpuestos := False;

            // Que forma de pago tuvo??
            if AnsiPos('UNA', Uppercase(FormaDePago)) > 0 then
                fFormaDePago := fpUnaSolaExhibicion
            else
                fFormaDePago := fpParcialidades;

            // Tipo de comprobante
            if TipoDeComprobante = 'ingreso' then
              fTipoComprobante := tcIngreso;

            if TipoDeComprobante = 'egreso' then
              fTipoComprobante := tcEgreso;

            if TipoDeComprobante = 'traslado' then
              fTipoComprobante := tcTraslado;

            // Asignamos el descuento
            if (Descuento <> '') then
              Self.AsignarDescuento(StrToFloat(Descuento), '');

            // Asignamos el subtotal de la factura
            fSubTotal := StrToFloat(Subtotal);

            // Asignamos el sello que trae el XML
            fSelloDigitalCalculado:=Sello;

            Assert(Self.Total = StrToCurr(Total), 'El total del comprobante no fue igual que el total del XML');
        end;
    except
        On E:Exception do
          Raise E;
    end;
end;

// Regresa el XML final del comprobante ya lleno
function TFEComprobanteFiscal.getXML(): WideString;
begin
    // Checamos si ya fue generada previamente la factura
    if bFacturaGenerada = True then
        Result:=fDocumentoXML.XML.Text
    else
        Raise Exception.Create('No se puede obtener el XML cuando aún no se ha generado el archivo CFD');
end;

// El metodo que genera el CFD al final...
procedure TFEComprobanteFiscal.GuardarEnArchivo(sArchivoDestino: String);
begin
  // Forzamos que se calcule el sello
  fXmlComprobante.Sello := Self.SelloDigital;
  fDocumentoXML.SaveToFile(sArchivoDestino);
  bFacturaGenerada:=True;
  // TODO: Implementar las diversas fallas que pueden ocurrir
end;

end.
