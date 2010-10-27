(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
 los metodos para generarla.

 Este archivo pertenece al proyecto de codigo fuente de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit ComprobanteFiscal;

interface

uses FacturaTipos, SelloDigital, FeCFDv2,
// Unidades especificas de manejo de XML:
XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd;

type

///<summary>Representa la estructura de comprobante fiscal digital (ver2.0) y sus elementos
/// definidos de acuerdo al XSD del SAT. Esta pensado para ser extendido en las versiones
/// posteriores que el SAT publique (ver3.0, ver4.0, etc.).
/// Se encarga de validar y formatear todos los datos de la factura que le sean proporcionados
///</summary>
TFEComprobanteFiscal = class
    fDocumentoXML: TXMLDocument;
    fXmlComprobante : IFEXMLComprobante;
    sCadenaOriginal: WideString;
    fSelloDigital : TSelloDigital;
    iFolio: TFEFolio;
    sSerie : TFESerie;
    fCertificado: TFECertificado;
    procedure setReceptor(Receptor: TFEContribuyente);
    procedure setEmisor(Emisor: TFEContribuyente);
    procedure setFolio(Folio: TFEFolio);
    procedure setSerie(Serie: TFESerie);
    //procedure setCertificado(sContenidoCertificado : WideString);
    procedure setCertificado(Certificado: TFECertificado);
    function getXML() : WideString;
    ///<summary>Obtiene la 'Cadena Original' segun las reglas del Anexo 20</summary>
    function getCadenaOriginal() : WideString;
public
    // Version del CFD que implementa este código
    const Version = '2';
    constructor Create();
    destructor Destroy();

    // Propiedades del comprobante normal
    property Folio: Integer write setFolio;
    property Serie: String write setSerie;
    property Receptor : TFEContribuyente write setReceptor;
    property Emisor: TFEContribuyente write setEmisor;
    procedure AgregarConcepto(Concepto: TFEConcepto);

    // Propiedades especificas al comprobante electronico
    property XML: WideString read getXML;
    property CadenaOriginal: WideString read getCadenaOriginal;
    property Certificado : TFECertificado write setCertificado;
    //property Certificado : WideString write setCertificado;
end;

implementation

// TODO:
// Incluimos los archivos XSLT como recursos (.RES) para no tener que distribuirlos
// manualmente en el EXE
// Mas Info en: http://delphi.about.com/od/objectpascalide/a/embed_resources.htm

uses SysUtils, FacturaReglamentacion, Dialogs, ClaseOpenSSL;

// Al crear el objeto, comenzamos a "llenar" el XML interno
constructor TFEComprobanteFiscal.Create();
begin
    sCadenaOriginal:='';

    // Creamos el objeto XML
    fDocumentoXML := TXMLDocument.Create(nil);
    fDocumentoXML.Active := True;
    fDocumentoXML.Version:= '1.0';
    fDocumentoXML.Encoding := 'UTF-8';

    // Obtenemos el elemento "Comprobante" para llenar sus datos...
    fXmlComprobante := GetComprobante(fDocumentoXML);
    // De acuerdo a los articulos 29 y 29-A del CFF - Referencia: Revista "IDC Factura electronica" (Sept/2010) - Pag 49
    fXmlComprobante.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    fXmlComprobante.SetAttribute('xsi:schemaLocation',
                                 'http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd');
    fXmlComprobante.Version:='2.0';
end;

destructor TFEComprobanteFiscal.Destroy();
begin
    FreeAndNil(fDocumentoXML);
end;

// Regresamos la Cadena Original de este comprobante fiscal segun las reglas
// definidas previamente...
function TFEComprobanteFiscal.getCadenaOriginal() : WideString;
var
    XSLTransformador: TXSLPageProducer;
begin
    // La cadena original tambien puede ser generada usando un componente de transformacion
    // XSLT y usando los archivos para dicho proposito, sin embargo se decidio
    // hacerlo manualmente para evitar multiples dependencias de librerias DLL para su funcionamiento

    // Primero, extraemos los archivos XSLT para realizar la transformacion de los archivos .RES
    // TODO: Extraer de los RES

    XSLTransformador := TXSLPageProducer.Create(nil);
    //XMLDocument1.Active := False; // just in case
    XSLTransformador.FileName := 'C:\Users\Luis\Documents\RAD Studio\Projects\cadenaoriginal_2_0_l.xslt';
    XSLTransformador.XMLData := fDocumentoXML;
    //XMLDocument1.Active := True;
    // Al ejecutar la siguiente lienea, el transformador usa la plantilla XSLT del SAT
    // para convertir el XML en la CadenaOriginal usando precisamente, las reglas de validacion
    // y presentacion definidas en los documentos XSLT.
    try
        sCadenaOriginal := XSLTransformador.Content;
        //XMLDocument1.Active := False;
        // TODO: Codificar en UTF8??? o ya viene asi del XSLT????
        // NOTA: Al obtenerlo para desplegarlo hay que descodificarlo de UTF8, por ejemplo para un Memo edit.
        Result:=sCadenaOriginal;
    except
        // Manejar los diversos errores de validacion que se pueden generar...
        On E:Exception do
        begin
            ShowMessage(E.Message);
            Result:='';
        end;
    end;

    FreeAndNil(XSLTransformador);
end;

// Regresa el XML final del comprobante ya lleno
function TFEComprobanteFiscal.getXML() : WideString;
var
  TipoDigestion: TTipoDigestionOpenSSL;
begin
    // Calculamos el sello digital para la cadena original de la factura
    if Assigned(fSelloDigital) then
        FreeAndNil(fSelloDigital);

    // Segun la leglislacion vigente si la factura se hace antes del 1 de Enero del 2011, usamos MD5
    if Now < EncodeDate(2011,1,1) then
		    TipoDigestion:=tdMD5
	  else // Si es 2011 usamos el algoritmo SHA-1
		    TipoDigestion:=tdSHA1;

    // Creamos la clase SelloDigital que nos ayudara a "sellar" la factura en XML
    fSelloDigital:=TSelloDigital.Create(Self.CadenaOriginal, fCertificado, tdMD5);

    // Finalmente regresamos la factura en XML con todas sus propiedades llenas
    fXmlComprobante.Sello:=fSelloDigital.SelloCalculado;
    FreeAndNil(fSelloDigital);
    Result:=fDocumentoXML.XML.Text;
end;

procedure TFEComprobanteFiscal.setEmisor(Emisor: TFEContribuyente);
begin
  with fXmlComprobante.Emisor do
		begin
        RFC := Emisor.RFC;
        Nombre := Emisor.Nombre;
        with DomicilioFiscal do // Alias de UbicacionFiscal
        begin
            Calle := Emisor.Direccion.Calle;
      			NoExterior := Emisor.Direccion.NoExterior; // Opcional
            NoInterior := Emisor.Direccion.NoInterior; // Opcional
      			Colonia := Emisor.Direccion.Colonia;       // Opcional
      			Localidad := Emisor.Direccion.Localidad;   // Opcional
      			Referencia := Emisor.Direccion.Referencia; // Opcional
            Municipio := Emisor.Direccion.Municipio;
            Estado :=Emisor.Direccion.Estado;
            Pais := Emisor.Direccion.Pais;
            CodigoPostal := Emisor.Direccion.CodigoPostal;
        end;
    end;
end;

procedure TFEComprobanteFiscal.setReceptor(Receptor: TFEContribuyente);
begin
  with fXmlComprobante.Receptor do
		begin
        RFC := Receptor.RFC;
        Nombre := Receptor.Nombre;

        with Domicilio do
        begin
            Calle := Receptor.Direccion.Calle;
      			NoExterior := Receptor.Direccion.NoExterior; // Opcional
            NoInterior := Receptor.Direccion.NoInterior; // Opcional
      			Colonia := Receptor.Direccion.Colonia;       // Opcional
      			Localidad := Receptor.Direccion.Localidad;   // Opcional
      			Referencia := Receptor.Direccion.Referencia; // Opcional
            Municipio := Receptor.Direccion.Municipio;
            Estado :=Receptor.Direccion.Estado;
            Pais := Receptor.Direccion.Pais;
            CodigoPostal := Receptor.Direccion.CodigoPostal;
        end; {with CFD.Receptor.Domicilio}
		end; {with CFD.Receptor}
end;

{procedure TFEComprobanteFiscal.setCertificado(sContenidoCertificado : WideString);
begin
    fXmlComprobante.Certificado:=sContenidoCertificado;
end;}

procedure TFEComprobanteFiscal.setCertificado(Certificado: TFECertificado);
begin
      // Ya que tenemos los datos del certificado, lo procesamos para obtener los datos
      // necesarios

      // Ya procesado llenamos su propiedad en el XML
      {fXmlComprobante.NoAprobacion := StrToIntDef(OpcC('FacturaE','FolioNoAprobacion'),0);
		  fXmlComprobante.AnoAprobacion := StrToIntDef(OpcC('FacturaE','FolioAnoAprobacion'),0);
		  fXmlComprobante.NoCertificado := OpcC('FacturaE','CertNo');}
end;

procedure TFEComprobanteFiscal.AgregarConcepto(Concepto: TFEConcepto);
begin
      // Agregamos el concepto de la factura
			with fXmlComprobante.Conceptos.Add do
			begin
				  Cantidad := TFEReglamentacion.ComoCantidad(Concepto.Cantidad);
    		  Unidad := Concepto.Unidad; // Opcional
    			NoIdentificacion := Concepto.NoIdentificacion; // Opcional
				  Descripcion := Concepto.Descripcion;
				  ValorUnitario := TFEReglamentacion.ComoMoneda(Concepto.ValorUnitario);
				  Importe := TFEReglamentacion.ComoMoneda(Concepto.Importe);
			end;
end;

procedure TFEComprobanteFiscal.setFolio(Folio: TFEFolio);
begin
    //
end;

procedure TFEComprobanteFiscal.setSerie(Serie: TFESerie);
begin
   //
end;

{
procedure TFEComprobanteFiscal.LlenarTotalesEImpuestos;
begin
    fNodoXmlCFD.SubTotal := CurrToStr(dSubtotal);
    fNodoXmlCFD.Total := CurrToStr(dTotal);
    fNodoXmlCFD.TipoDeComprobante := 'ingreso';

    with fNodoXmlCFD.Impuestos do
		begin
{opc		TotalImpuestosRetenidos := '';}

			//Si hay impuesto retenido se debe usar el siguiente bloque:
{			with Retenciones.Add do
			begin
				Impuesto := 'ISR o IVA';
				Importe := 'calculo de la retencion';
			end;}

{opc}	{	TotalImpuestosTrasladados := '10.96'; //<<<<<<<<<<<<<<<<<<<<<REQUIERE TRABAJO AQUI

			with Traslados.Add do
			begin
				Impuesto := 'IVA';
				Tasa := '16.00';
				Importe := '10.96'; //<<<<<<<<<<<<<<<<<<<<<REQUIERE TRABAJO AQUI
			end;

			//Si necesitan IEPS usen este bloque ::
{			with Traslados.Add do
			begin
				Impuesto := 'IEPS';
				Tasa := 'tasa del impuesto';
				Importe := 'valor calculado a partir del subtotal';
			end;}
	 //	end ; {CFD.Impuestos}
//end;

end.
