(* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

  Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
  los metodos para generarla.

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
unit ComprobanteFiscal;

interface

uses FacturaTipos, SelloDigital, FeCFDv2, SysUtils,
  // Unidades especificas de manejo de XML:
  XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd;

type

  // Excepciones que pueden ser generadas
  TFECertificadoNoExisteException = Exception;
  TFECertificadoNoVigente = Exception;
  TFEFolioFueraDeRango = Exception;

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
    fDocumentoXML: TXMLDocument;
    fXmlComprobante: IFEXMLComprobante;
    sCadenaOriginal: WideString;
    fSelloDigital: TSelloDigital;
    fFolio: TFEFolio;
    fCertificado: TFECertificado;
    fBloqueFolios: TFEBloqueFolios;
    fFormaDePago: TFEFormaDePago;
    fTipoComprobante: TFeTipoComprobante;
    fExpedidoEn: TFeDireccion;
    fFechaGeneracion: TDateTime;
    fCondicionesDePago: String;
    fEmisor : TFEContribuyente;
    fReceptor: TFEContribuyente;

    fTotal: Currency;
    fSubTotal: Currency;
    fTotalImpuestosRetenidos: Currency;
    fTotalImpuestosTrasladados: Currency;

    procedure setTotal(dMonto: Currency);
    procedure setSubTotal(dMonto: Currency);
    procedure setExpedidoEn(ExpedidoEn: TFeDireccion);
    procedure setTipoComprobante(Tipo: TFeTipoComprobante);
    procedure setFormaDePago(FormaDePago: TFEFormaDePago);
    procedure setReceptor(Receptor: TFEContribuyente);
    procedure setEmisor(Emisor: TFEContribuyente);
    procedure setFolio(Folio: TFEFolio);
    function obtenerSerie(): TFESerie;
    // procedure setCertificado(sContenidoCertificado : WideString);
    procedure setCertificado(Certificado: TFECertificado);
    function getXML(): WideString;
    /// <summary>Obtiene la 'Cadena Original' segun las reglas del Anexo 20</summary>
    function getCadenaOriginal(): WideString;
    procedure setBloqueFolios(Bloque: TFEBloqueFolios);
    procedure ValidarQueFolioEsteEnRango;

  public
  // Version del CFD que implementa este código
    const
    Version = '2';
    constructor Create();
    destructor Destroy(); override;

    // Propiedades del comprobante normal
    property Folio: TFEFolio read fFolio write setFolio;
    property Serie: TFESerie read obtenerSerie;
    property Receptor: TFEContribuyente read fReceptor write setReceptor;
    property Emisor: TFEContribuyente read fEmisor write setEmisor;
    property FormaDePago: TFEFormaDePago read fFormaDePago write setFormaDePago;
    property Tipo: TFeTipoComprobante read fTipoComprobante write setTipoComprobante;
    property ExpedidoEn: TFeDireccion read fExpedidoEn write setExpedidoEn;
    property Total: Currency read fTotal write setTotal;
    property SubTotal: Currency read fSubTotal write setSubtotal;
    property TotalImpuestosRetenidos : Currency read fTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados : Currency read fTotalImpuestosTrasladados;
    // property InformacionAduanera: TFEInformacionAduanera read fInfoAduanera write SetInformacionAduanera;
    // property Descuento
    // property MetodoDePago

    // Metoodos:
    procedure AgregarConcepto(Concepto: TFEConcepto);
    /// <summary>Agrega un nuevo impuesto de retención (ISR, IVA) al comprobante generando su XML
    /// y sumandolo al total de dicho impuesto. </summary>
    /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre e importe del mismo</param>
    procedure AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido);
    /// <summary>Agrega un nuevo impuesto de traslado (IVA, IEPS) al comprobante generando su XML y
    /// sumandolo al total de dicho impuesto. </summary>
    /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre, tasa e importe del mismo</param>
    procedure AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado);
    procedure Cancelar();

    // Propiedades especificas al comprobante electronico
    property XML: WideString read getXML;
    property CadenaOriginal: WideString read getCadenaOriginal;
    property Certificado: TFECertificado read fCertificado write setCertificado;
    property BloqueFolios: TFEBloqueFolios read fBloqueFolios write setBloqueFolios;
    // property Certificado : WideString write setCertificado;
  end;

implementation

// TODO:
// Incluimos los archivos XSLT como recursos (.RES) para no tener que distribuirlos
// manualmente en el EXE
// Mas Info en: http://delphi.about.com/od/objectpascalide/a/embed_resources.htm

uses FacturaReglamentacion, Dialogs, ClaseOpenSSL, OpenSSLUtils;

// Al crear el objeto, comenzamos a "llenar" el XML interno
constructor TFEComprobanteFiscal.Create();
begin
  sCadenaOriginal := '';

  // Incializamos los valores del comprobante con datos invalidos
  fBloqueFolios.FolioInicial := -1;
  fBloqueFolios.FolioFinal := -1;
  fFolio := -1;
  // Establecemos los totales en cero...
  fTotal := 0;
  fSubTotal := 0;
  fTotalImpuestosRetenidos := 0;
  fTotalImpuestosTrasladados := 0;

  // Creamos el objeto XML
  fDocumentoXML := TXMLDocument.Create(nil);
  fDocumentoXML.Active := True;
  fDocumentoXML.Version := '1.0';
  fDocumentoXML.Encoding := 'UTF-8';

  // Obtenemos el elemento "Comprobante" para llenar sus datos...
  fXmlComprobante := GetComprobante(fDocumentoXML);
  // De acuerdo a los articulos 29 y 29-A del CFF - Referencia: Revista "IDC Factura electronica" (Sept/2010) - Pag 49
  fXmlComprobante.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
  fXmlComprobante.SetAttribute('xsi:schemaLocation',
    'http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd');
  fXmlComprobante.Version := '2.0';
end;

destructor TFEComprobanteFiscal.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  fXmlComprobante := nil;
  inherited;
end;

// Generamos la estructura "Cadena Original" de acuerdo a las reglas del SAT
// definidas en: http://www.sat.gob.mx/sitio_internet/e_sat/comprobantes_fiscales/15_6543.html
function TFEComprobanteFiscal.getCadenaOriginal() : WideString;
const
   _PIPE = '|';

var
   sRes: WideString;
   I: Integer;

   function LimpiaCampo(sTexto: String) : String;
   begin
        // 1. Ninguno de los atributos que conforman al comprobante fiscal digital deberá contener el caracter | (“pipe”)
        // debido a que este será utilizado como caracter de control en la formación de la cadena original.
   end;

   procedure AgregarAtributo(sValor: String);
   begin
      // 5. Los datos opcionales no expresados, no aparecerán en la cadena original y no tendrán delimitador alguno.
      if Trim(sValor) <> '' then
         sRes:=sRes + LimpiaCampo(sValor) + _PIPE;
   end;

   procedure AgregarDireccion(Contribuyente: TFEContribuyente);
   begin
        with Contribuyente.Direccion do
        begin
           AgregarAtributo(Calle);
           AgregarAtributo(NoExterior);
           AgregarAtributo(NoInterior);
           AgregarAtributo(Colonia);
           AgregarAtributo(Localidad);
           AgregarAtributo(Referencia);
           AgregarAtributo(Municipio);
           AgregarAtributo(Estado);
           AgregarAtributo(Pais);
           AgregarAtributo(CodigoPostal);
        end;
   end;

begin
   // Especificamos la fecha exacta en la que se esta generando el comprobante
   fFechaGeneracion := TFEReglamentacion.ComoFechaHora(Now);
   fXmlComprobante.Fecha := fFechaGeneracion;

   // Agregamos al XML los totales de los diferentes tipos de impuestos usados
   with fXmlComprobante.Impuestos do
   begin
    if (fTotalImpuestosRetenidos > 0) then
       TotalImpuestosRetenidos := TFEReglamentacion.ComoMoneda(fTotalImpuestosRetenidos); // Opcional

    if (fTotalImpuestosTrasladados > 0) then
       TotalImpuestosTrasladados := TFEReglamentacion.ComoMoneda(fTotalImpuestosTrasladados); // Opcional
   end;

   // 2. El inicio de la cadena original se encuentra marcado mediante una secuencia de caracteres || (doble “pipe”).
   sRes:=_PIPE + _PIPE;
   // 1) Datos del comprobante
   AgregarAtributo(Version);
   AgregarAtributo(Certificado.NumeroSerie);
   AgregarAtributo(fFolio);
   AgregarAtributo(fFechaGeneracion);
   AgregarAtributo(fBloqueFolios.NumeroAprobacion);
   AgregarAtributo(fTipoComprobante);
   AgregarAtributo(fFormaDePago); // TODO: Convertir a String
   AgregarAtributo(fCondicionesDePago);
   AgregarAtributo(fSubtotal);
   if fDescuento > 0  then
      AgregarAtributo(fDescuento);
   AgregarAtributo(fTotal);
   // 2) Datos del emisor
   AgregarAtributo(fEmisor.RFC);
   AgregarAtributo(fEmisor.Nombre);
   // 3) Datos del domicilio fiscal del emisor
   AgregarDireccion(fEmisor);
   // 4) Datos del Domicilio de Expedición del Comprobante
   AgregarDireccion(fExpedidoEn);
   // 5) Datos del Receptor
   AgregarAtributo(fReceptor.RFC);
   AgregarAtributo(fReceptor.Nombre);
   // 6) Datos del domicilio fiscal del Receptor
   AgregarDireccion(fReceptor);
   // 7) Datos de Cada Concepto Relacionado en el Comprobante
   for I := 0 to fXmlComprobante.Conceptos.Count do
   begin
       with fXmlComprobante.Conceptos do
       begin
            AgregarAtributo(Concepto[I].Cantidad);
            AgregarAtributo(Concepto[I].Unidad);
            AgregarAtributo(Concepto[I].NoIdentificacion);
            AgregarAtributo(Concepto[I].Descripcion);
            AgregarAtributo(Concepto[I].ValorUnitario);
            AgregarAtributo(Concepto[I].Importe);
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['numero']);
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['fecha']);
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['aduana']);
            AgregarAtributo(Concepto[I].CuentaPredial);
       end;
   end;

   // 8) Datos de Cada Retención de Impuestos

   // 9) Datos de Cada Traslado de Impuestos

   // 6. El final de la cadena original será expresado mediante una cadena de caracteres || (doble “pipe”).
   // 7. Toda la cadena de original se encuentra expresada en el formato de codificación UTF-8.
   Result:=UTF8Encode(sRes + _PIPE + _PIPE);
end;

// Regresamos la Cadena Original de este comprobante fiscal segun las reglas
// definidas previamente...
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

// 1. Datos de quien la expide (Emisor) (Art. 29-A, Fraccion I)
procedure TFEComprobanteFiscal.setEmisor(Emisor: TFEContribuyente);
begin
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
begin
  // Ya que tenemos los datos del certificado, lo procesamos para obtener los datos
  // necesarios
  fCertificado := Certificado;
  x509Certificado := TX509Certificate.Create;
  try
    if Not FileExists(Certificado.Ruta) then
      raise TFECertificadoNoExisteException.Create('No existe el archivo del certificado')
    else
      x509Certificado.LoadFromFile(Certificado.Ruta);

    // Llenamos las propiedades
    fCertificado.VigenciaInicio := x509Certificado.NotBefore;
    fCertificado.VigenciaFin := x509Certificado.NotAfter;

    // Checamos que el certificado este dentro de la vigencia
    if Not((Now >= fCertificado.VigenciaInicio) and (Now <= fCertificado.VigenciaFin)) then
      raise TFECertificadoNoVigente.Create('El certificado no tiene vigencia actual');

    fCertificado.NumeroSerie := x509Certificado.SerialNumber;

    // Ya procesado llenamos su propiedad en el XML
    fXmlComprobante.NoCertificado := fCertificado.NumeroSerie;
  finally
    FreeAndNil(x509Certificado);
  end;
end;

procedure TFEComprobanteFiscal.AgregarConcepto(Concepto: TFEConcepto);
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
    Importe := TFEReglamentacion.ComoMoneda(Concepto.Importe);
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

procedure TFEComprobanteFiscal.ValidarQueFolioEsteEnRango;
begin
  // Validamos que el folio este dentro del rango definido si ya se nos fue proporcionado
  // el bloque de folios y el numero de folio
  if ((fBloqueFolios.FolioInicial > -1) And (fFolio > -1)) then
  begin
    if Not((Folio >= fBloqueFolios.FolioInicial) And (Folio <= fBloqueFolios.FolioFinal)) then
      raise TFEFolioFueraDeRango.Create('El folio se encuentra fuera del rango autorizado');
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
  Result := fBloqueFolios.Serie;
end;

procedure TFEComprobanteFiscal.setBloqueFolios(Bloque: TFEBloqueFolios);
begin
  // Asignamos el bloque a la variable interna y validamos que este dentro del rango...
  fBloqueFolios := Bloque;
  ValidarQueFolioEsteEnRango();

  fXmlComprobante.AnoAprobacion := Bloque.AnoAprobacion;
  fXmlComprobante.NoAprobacion := Bloque.NumeroAprobacion;

  if Trim(Serie) <> '' then
    fXmlComprobante.Serie := Bloque.Serie;
end;

// 2. Lugar y fecha de expedicion (29-A, Fraccion III) - En caso de ser sucursal
procedure TFEComprobanteFiscal.setExpedidoEn(ExpedidoEn: TFeDireccion);
begin
  // TODO: Implementar
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
      sForma := 'UNA SOLA EXHIBICIÓN';
    fpParcialidades:
      sForma := 'EN PARCIALIDADES';
  end;

  fXmlComprobante.FormaDePago := sForma;
end;

procedure TFEComprobanteFiscal.setTotal(dMonto: Currency);
begin
   fTotal:=dMonto;
   fXMLComprobante.Total:=TFEReglamentacion.ComoMoneda(dMonto);
end;

procedure TFEComprobanteFiscal.setSubTotal(dMonto: Currency);
begin
   fSubTotal:=dMonto;
   fXMLComprobante.SubTotal:=TFEReglamentacion.ComoMoneda(dMonto);
end;

procedure TFEComprobanteFiscal.AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido);
begin
     fTotalImpuestosRetenidos:= fTotalImpuestosRetenidos + NuevoImpuesto.Importe;
     with fXMLComprobante.Impuestos.Retenciones.Add do
     begin
         Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
         Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
     end;
end;

procedure TFEComprobanteFiscal.AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado);
begin
     fTotalImpuestosTrasladados:= fTotalImpuestosTrasladados + NuevoImpuesto.Importe;
     with fXMLComprobante.Impuestos.Traslados.Add do
     begin
         Impuesto := TFEReglamentacion.ComoCadena(NuevoImpuesto.Nombre);
         Tasa := TFEReglamentacion.ComoTasaImpuesto(NuevoImpuesto.Tasa);
         Importe := TFEReglamentacion.ComoMoneda(NuevoImpuesto.Importe);
     end;
end;

// Regresa el XML final del comprobante ya lleno
function TFEComprobanteFiscal.getXML(): WideString;
var
  TipoDigestion: TTipoDigestionOpenSSL;
begin
  // Calculamos el sello digital para la cadena original de la factura
  if Assigned(fSelloDigital) then
    FreeAndNil(fSelloDigital);

  // Segun la leglislacion vigente si la factura se hace antes del 1 de Enero del 2011, usamos MD5
  if Now < EncodeDate(2011, 1, 1) then
    TipoDigestion := tdMD5
  else // Si es 2011 usamos el algoritmo SHA-1
    TipoDigestion := tdSHA1;

  // Creamos la clase SelloDigital que nos ayudara a "sellar" la factura en XML
  fSelloDigital := TSelloDigital.Create(Self.CadenaOriginal, fCertificado, TipoDigestion);

  // Finalmente regresamos la factura en XML con todas sus propiedades llenas
  fXmlComprobante.Sello := fSelloDigital.SelloCalculado;
  FreeAndNil(fSelloDigital);
  Result := fDocumentoXML.XML.Text;
end;

end.
