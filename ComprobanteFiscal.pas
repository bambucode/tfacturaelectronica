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

uses FacturaTipos, FeCFDv22, SysUtils, dialogs,
  // Unidades especificas de manejo de XML:
  XmlDom, XMLIntf, MsXmlDom, XMLDoc, DocComprobanteFiscal,
  {$IFDEF VER220}
    CodeSiteLogging,
  {$ENDIF}
  XSLProd;

type

  // Excepciones que pueden ser generadas
  EFECertificadoNoExisteException = class(Exception);
  EFECertificadoNoVigente =  class(Exception);
  EFEFolioFueraDeRango = class(Exception);
  EXMLVacio = class(Exception);

  /// <summary>Representa la estructura de comprobante fiscal digital (ver2.0) y sus elementos
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
    fXmlComprobante: IFEXMLComprobante;

    // Propiedades exclusivas del comprobante digital:
    fCadenaOriginalCalculada: TStringCadenaOriginal;
    fSelloDigitalCalculado: String;
    fCertificado: TFECertificado;
    fCertificadoTexto: WideString;
    fBloqueFolios: TFEBloqueFolios;

    // Opciones de configuracion
    _CADENA_PAGO_UNA_EXHIBICION: String;
    _CADENA_PAGO_PARCIALIDADES: String;
    fDesglosarTotalesImpuestos: Boolean;
    bIncluirCertificadoEnXML: Boolean;
    fAutoAsignarFechaGeneracion: Boolean;
    
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
  protected
    function getXML(): WideString; virtual;
    procedure setXML(Valor: WideString); virtual;
{$IFDEF VERSION_DE_PRUEBA}
  public
    _USAR_HORA_REAL : Boolean;
{$ELSE}
  protected
{$ENDIF}
  public
    const VERSION = '2.2'; // Version del CFD que implementa este código

    constructor Create();
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
    /// <summary>Guarda una copia del XML en el archivo indicado</summary>
    /// <param name="ArchivoFacturaXML">Ruta completa con nombre de archivo en el que se
    /// almacenara el XML del comprobante</param>
    procedure GuardarEnArchivo(sArchivoDestino: String);
  end;
  
implementation

uses FacturaReglamentacion, ClaseOpenSSL, StrUtils, SelloDigital,
  OpenSSLUtils, Classes, CadenaOriginal;

// Al crear el objeto, comenzamos a "llenar" el XML interno
constructor TFEComprobanteFiscal.Create();
begin
  inherited Create;
  _CADENA_PAGO_UNA_EXHIBICION := 'Pago en una sola exhibición';
  _CADENA_PAGO_PARCIALIDADES := 'En parcialidades';

  {$IFDEF VERSION_DE_PRUEBA}
    _USAR_HORA_REAL := False;
  {$ENDIF}

  // Establecemos como default que SI queremos incluir el certificado en el XML
  // ya que presenta la ventaja de poder validar el comprobante con solo el archivo
  // XML.
  fAutoAsignarFechaGeneracion:=True;
  bIncluirCertificadoEnXML := True;
  fDesglosarTotalesImpuestos := True;
  fCadenaOriginalCalculada:='';
  fSelloDigitalCalculado:='';

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
  //fXmlComprobante := nil;
  inherited;
end;


procedure TFEComprobanteFiscal.AsignarCondicionesDePago;
begin
    if Trim(inherited CondicionesDePago) <> '' then
      fXmlComprobante.CondicionesDePago := TFEReglamentacion.ComoCadena(inherited CondicionesDePago);
end;

procedure TFEComprobanteFiscal.AsignarDescuentos;
begin
  fXmlComprobante.Descuento := TFEReglamentacion.ComoMoneda(inherited DescuentoMonto);
  if Trim(inherited DescuentoMotivo) <> '' then
    fXmlComprobante.MotivoDescuento := TFEReglamentacion.ComoCadena(inherited DescuentoMotivo);
end;

function TFEComprobanteFiscal.getCadenaOriginal(): TStringCadenaOriginal;
var
  CadenaOriginal : TCadenaOriginal;
begin
    if FacturaGenerada = True then
    begin
        Result:=fCadenaOriginalCalculada;
    end else
    begin
        try
            // Si aun no ha sido generada la factura la "llenamos"
            LlenarComprobante;
            CadenaOriginal := TCadenaOriginal.Create(fXmlComprobante, fDesglosarTotalesImpuestos);
            fCadenaOriginalCalculada:=CadenaOriginal.Calcular;
            Result:=fCadenaOriginalCalculada;
        finally
            FreeAndNil(CadenaOriginal);
        end;
    end;
end;

// 1. Datos de quien la expide (Emisor) (Art. 29-A, Fraccion I)
procedure TFEComprobanteFiscal.AsignarEmisor;
begin

  with fXmlComprobante.Emisor do
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

// 2. Lugar y fecha de expedicion (29-A, Fraccion III) - En caso de ser sucursal
procedure TFEComprobanteFiscal.AsignarExpedidoEn;
begin
    // Checamos si tiene direccion de expedicion...
    if (inherited ExpedidoEn.Calle <> '') then
    begin
        with fXmlComprobante.Emisor.ExpedidoEn do
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

// 3. Clave del RFC de la persona a favor de quien se expida la factura (29-A, Fraccion IV)
procedure TFEComprobanteFiscal.AsignarReceptor;
begin
  with fXmlComprobante.Receptor do
  begin
    RFC := Trim((inherited Receptor).RFC);
    
    // Si es un CFD de venta al publico en general o extranjeros no incluimos nombre ni direccion
    if ((Rfc <> _RFC_VENTA_PUBLICO_EN_GENERAL) And (Rfc <> _RFC_VENTA_EXTRANJEROS)) then
    begin
        Nombre := TFEReglamentacion.ComoCadena((inherited Receptor).Nombre);

        with Domicilio do
        begin
          Calle := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Calle);

          if Trim((inherited Receptor).Direccion.NoExterior) <> '' then
            NoExterior := (inherited Receptor).Direccion.NoExterior; // Opcional

          if Trim((inherited Receptor).Direccion.NoInterior) <> '' then
            NoInterior := (inherited Receptor).Direccion.NoInterior; // Opcional

          if Trim((inherited Receptor).Direccion.Colonia) <> '' then
            Colonia := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Colonia); // Opcional
          if Trim((inherited Receptor).Direccion.Localidad) <> '' then
            Localidad := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Localidad); // Opcional
          if Trim((inherited Receptor).Direccion.Referencia) <> '' then
            Referencia := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Referencia); // Opcional
          Municipio := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Municipio);
          Estado := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Estado);
          Pais := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Pais);
          CodigoPostal := (inherited Receptor).Direccion.CodigoPostal;
        end; { with CFD.Receptor.Domicilio }
    end else
        // Si es Publico en General solo agregamos el pais al nodo Direccion
        // cualquier otra cosa generara un CFD invalido.
        if (Rfc = _RFC_VENTA_PUBLICO_EN_GENERAL) then
          Domicilio.Pais:='México'
        else // Si es el RFC de extranjero ahi si obtenemos el pais del que se nos haya asignado...
          fXmlComprobante.Receptor.Domicilio.Pais := TFEReglamentacion.ComoCadena((inherited Receptor).Direccion.Pais);
        
  end; { with CFD.Receptor }
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

     {$IFDEF VER220} CodeSite.EnterMethod('AsignarConceptos'); {$ENDIF}
     // Obtenemos los conceptos agregados al documento previamente
     for I := 0 to Length(inherited Conceptos) - 1 do
     begin
          Concepto:=(inherited Conceptos)[I];

          // Agregamos el concepto al XML
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
     {$IFDEF VER220} CodeSite.ExitMethod('AsignarConceptos'); {$ENDIF}
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

procedure TFEComprobanteFiscal.setCertificado(Certificado: TFECertificado);
const
    _CADENA_INICIO_CERTIFICADO = '-----BEGIN CERTIFICATE-----';
    _CADENA_FIN_CERTIFICADO    = '-----END CERTIFICATE-----';
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
        raise Exception.Create(E.Message);
     end;
  end;
  FreeAndNil(x509Certificado);
end;

// Asignamos la serie, el no y año de aprobacion al XML...
procedure TFEComprobanteFiscal.AsignarDatosFolios;
begin
   if Trim(fBloqueFolios.Serie) <> '' then
    fXmlComprobante.Serie := fBloqueFolios.Serie;

  fXmlComprobante.NoAprobacion := fBloqueFolios.NumeroAprobacion;
  fXmlComprobante.AnoAprobacion := fBloqueFolios.AnoAprobacion;
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
  if (Trim(inherited MetodoDePago) <> '') then
     fXmlComprobante.MetodoDePago:=TFEReglamentacion.ComoCadena(inherited MetodoDePago);
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

// Funcion encargada de llenar el comprobante fiscal EN EL ORDEN que se especifica en el XSD
// ya que si no es asi, el XML se va llenando en el orden en que se establecen las propiedades de la clase
// haciendo que el comprobante no pase las validaciones del SAT.
procedure TFEComprobanteFiscal.LlenarComprobante;
begin
    if (FacturaGenerada = False) then
    begin
        {$IFDEF VER220} CodeSite.EnterMethod('LlenarComprobante'); {$ENDIF}
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

        // Atributo Emisor
        AsignarEmisor;
        AsignarExpedidoEn;
        // Atributo Receptor
        AsignarReceptor;
        // Atributo conceptos
        //if Trim(fCadenaOriginalCalculada) = '' then
        AsignarConceptos;

        // Atributo Impuestos
        AsignarImpuestosTrasladados;
        AsignarImpuestosRetenidos;

        if (fDesglosarTotalesImpuestos = True) then
           AsignarTotalesImpuestos;

        {$IFDEF VER220} CodeSite.ExitMethod('LlenarComprobante'); {$ENDIF}
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
  fXmlComprobante.Sello:=Self.SelloDigital;
  fDocumentoXML.SaveToFile(sArchivoDestino);
  // TODO: Implementar las diversas fallas que pueden ocurrir
end;

// Calculamos el sello digital para la cadena original de la factura
function TFEComprobanteFiscal.getSelloDigital(): String;
var
  TipoDigestion: TTipoDigestionOpenSSL;
  SelloDigital: TSelloDigital;
begin
  // Si la factura ya fue generada regresamos el sello previamente calculado
  if (FacturaGenerada = True) then
  begin
      Result:=fSelloDigitalCalculado;
  end else
  begin
      fSelloDigitalCalculado:='';

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
      FacturaGenerada:=True;
      result := fSelloDigitalCalculado;
  end;
end;

// Permite establecer el XML del comprobante (por si se esta leyendo de la BD, etc)
// y almacena todo en la estructura interna de datos y XML
procedure TFEComprobanteFiscal.setXML(Valor: WideString);
var
  I: Integer;
  ValorEmisor, ValorReceptor: TFEContribuyente;
  feConcepto: TFEConcepto;
  iXmlDoc: IXMLDocument;
  ValorExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
  sMotivoDescuento: String;

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
        iXmlDoc:=LoadXMLData(UTF8ToString(Valor));
        {$ELSE}
        iXmlDoc:=LoadXMLData(UTF8Decode(Valor));
        {$IFEND}
        // Creamos el documento "dueño" del comprobante
        fDocumentoXML:=TXmlDocument.Create(nil);
        // Pasamos el XML para poder usarlo en la clase
        fDocumentoXML.XML:=iXmlDoc.XML;
        // Asignamos el XML a la variable interna del componnente
        fXmlComprobante := GetComprobante(fDocumentoXML);

        Assert(fXmlComprobante.Version <> '', 'El comprobante no fue leido correctamente.');
        
        // Ahora, actualizamos todas las variables internas (de la clase) con los valores del XML
        with fXmlComprobante do
        begin
            inherited Folio:=StrToInt(Folio);
            // Datos del certificado
            fCertificado.NumeroSerie:=NoCertificado;
            fCertificadoTexto := Certificado;
            fBloqueFolios.NumeroAprobacion:=NoAprobacion;
            fBloqueFolios.AnoAprobacion:=AnoAprobacion;
            fBloqueFolios.Serie:=Serie;
            inherited Serie:=Serie;
            fBloqueFolios.FolioInicial:=inherited Folio;
            fBloqueFolios.FolioFinal:=inherited Folio;

            FechaGeneracion:=TFEReglamentacion.ComoDateTime(fXmlComprobante.Fecha);

            if TieneAtributo(fXmlComprobante, 'condicionesDePago') then
              inherited CondicionesDePago:=CondicionesDePago;

            if TieneAtributo(fXmlComprobante, 'metodoDePago') then
              inherited MetodoDePago:=MetodoDePago;

            // Leemos los datos del emisor
            if TieneAtributo(Emisor, 'nombre') then
              ValorEmisor.Nombre:=Emisor.Nombre;
              
            if TieneAtributo(Emisor, 'rfc') then
              ValorEmisor.RFC:=Emisor.RFC;
              
            with Emisor do
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

            // Tiene emisor??
            if TieneAtributo(Emisor, 'ExpedidoEn') then
            begin
                  with Emisor.ExpedidoEn do
                  begin
                      if TieneAtributo(Emisor.ExpedidoEn, 'calle') then
                        ValorExpedidoEn.Calle := Calle;
                      if TieneAtributo(Emisor.ExpedidoEn, 'NoExterior') then
                        ValorExpedidoEn.NoExterior := NoExterior;
                      if TieneAtributo(Emisor.ExpedidoEn, 'codigoPostal') then
                        ValorExpedidoEn.CodigoPostal := CodigoPostal;
                      if TieneAtributo(Emisor.ExpedidoEn, 'localidad') then
                        ValorExpedidoEn.Localidad := Localidad;
                      if TieneAtributo(Emisor.ExpedidoEn, 'municipio') then
                        ValorExpedidoEn.Municipio := Municipio;
                      if TieneAtributo(Emisor.ExpedidoEn, 'colonia') then
                        ValorExpedidoEn.Colonia := Colonia;
                      if TieneAtributo(Emisor.ExpedidoEn, 'estado') then
                        ValorExpedidoEn.Estado := Estado;
                      if TieneAtributo(Emisor.ExpedidoEn, 'pais') then
                        ValorExpedidoEn.Pais := Pais;
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

            // Asignamos el sello que trae el XML
            fSelloDigitalCalculado:=Sello;

            // Ahora hacemos que se calcule la cadena original de nuevo
            fCadenaOriginalCalculada:=getCadenaOriginal;
            
            // Finalmente indicamos que la factura ya fue generada
            FacturaGenerada:=True;

            Assert(Self.Total = StrToCurr(Total), 'El total del comprobante no fue igual que el total del XML');
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
function TFEComprobanteFiscal.getXML(): WideString;
begin
    // Checamos si ya fue generada previamente la factura
    if FacturaGenerada = True then
        Result:=fDocumentoXML.XML.Text
    else
        Raise Exception.Create('No se puede obtener el XML cuando aún no se ha generado el archivo CFD');
end;

end.
