(* *****************************************************************************
  Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
unit TestComprobanteFiscal;

interface

uses
  TestFramework, ComprobanteFiscal, FacturaTipos, TestPrueba;

type

  TestTFEComprobanteFiscal = class(TTestPrueba)
  strict private
    fComprobanteFiscal: TFEComprobanteFiscal;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    function GenerarComprobanteFiscal(DeArchivoXML: String; Certificado: TFECertificado) : String;
  published
    procedure Create_NuevoComprobante_GenereEstructuraXMLBasica;
    procedure setReceptor_Receptor_LoGuardeEnXML;
    procedure setEmisor_Emisor_LoGuardeEnXML;
    procedure AgregarConcepto_Concepto_LoGuardeEnXML;
    procedure setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
    procedure setFolio_Folio_LoGuardeEnXML;
    procedure setBloqueFolios_Bloque_LoGuardeEnXML;
    procedure setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
    procedure setTotal_Monto_LoGuardeEnXML;
    procedure setSubtotal_Monto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoTrasladado_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Varios_SumeSuTotal;
    procedure AgregarImpuestoTrasladado_Varios_SumeSuTotal;
    procedure CadenaOriginal_DeComprobante_SeaCorrecta;
    procedure SelloDigital_DeComprobante_SeaCorrecto;
    procedure XML_DeComprobanteHecho_GenereXMLCorrectamente;
  end;

implementation

uses
  Windows, SysUtils, Classes, ConstantesFixtures, DateUtils, XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd, FeCFDv2;

procedure TestTFEComprobanteFiscal.SetUp;
begin
  inherited;
  fComprobanteFiscal := TFEComprobanteFiscal.Create;
end;

procedure TestTFEComprobanteFiscal.TearDown;
begin
  FreeAndNil(fComprobanteFiscal);
end;

procedure TestTFEComprobanteFiscal.AgregarConcepto_Concepto_LoGuardeEnXML;
var
  Concepto: TFEConcepto;
  sXMLConcepto: WideString;
begin
  sXMLConcepto := leerContenidoDeFixture('comprobante_fiscal/concepto.xml');

  Concepto.Cantidad := 12.55;
  Concepto.Unidad := 'pz';
  // Incluimos algunos caracteres invalidos para el XML para verificar
  // que se estén "escapando" correctamente
  Concepto.Descripcion := 'Jabón & Jabón Modelo <ABC>';
  Concepto.ValorUnitario := 30.50;

  fComprobanteFiscal.AgregarConcepto(Concepto);

  CheckEquals(sXMLConcepto, fComprobanteFiscal.fXmlComprobante.XML,
    'El concepto no fue almacenado correctamente en la estrucutr XML');
end;

procedure TestTFEComprobanteFiscal.setBloqueFolios_Bloque_LoGuardeEnXML;
var
  sXMLFixture: WideString;
  Bloque: TFEBloqueFolios;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/bloque_folios.xml');

  Bloque.NumeroAprobacion := 12345;
  Bloque.AnoAprobacion := 2010;
  Bloque.Serie := 'ABC';

  // Asignamos el bloque de folios
  fComprobanteFiscal.BloqueFolios := Bloque;
  // guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'comprobante_fiscal/bloque_folios.xml');
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'No se guardo el numero de aprobacion, serie y año de aprobacion en la estructura del XML');
end;

procedure TestTFEComprobanteFiscal.setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
var
  Bloque: TFEBloqueFolios;
  bHuboError: Boolean;
begin
  Bloque.FolioInicial := 1000;
  Bloque.FolioFinal := 2000;
  bHuboError := False;

  // Asignamos primero un Numero de Folio fuera del rango
  fComprobanteFiscal.Folio := Bloque.FolioInicial - 5;

  // Ahora, Asignamos el bloque de folios
  try
    fComprobanteFiscal.BloqueFolios := Bloque;
  except
    On TFEFolioFueraDeRango do
      bHuboError := True;
  end;

  CheckEquals(True, bHuboError,
    'No se lanzo la excepcion al asignar un folio fuera del rango especificado en la propiedad BloqueFolios');
end;

procedure TestTFEComprobanteFiscal.setFolio_Folio_LoGuardeEnXML;
var
  sXMLFixture: WideString;
  Folio: TFEFolio;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/folio.xml');

  Folio := 12345678;
  fComprobanteFiscal.Folio := Folio;

  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'No se guardo el Folio en la estructura del XML');
end;

procedure TestTFEComprobanteFiscal.setTotal_Monto_LoGuardeEnXML;
var
  sXMLFixture: WideString;
const
  _TOTAL_COMPROBANTE = 1000;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/total.xml');

  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Total := _TOTAL_COMPROBANTE;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el monto total o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscal.setSubtotal_Monto_LoGuardeEnXML;
var
  sXMLFixture: WideString;
const
  _SUBTOTAL_COMPROBANTE = 1000;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/subtotal.xml');

  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.SubTotal := _SUBTOTAL_COMPROBANTE;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el monto de subtotal o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscal.AgregarImpuestoRetenido_Impuesto_LoGuardeEnXML;
var
  ImpuestoRetenido: TFEImpuestoRetenido;
  TotalImpuestosAnterior: Currency;
  sXMLFixture: WideString;
begin
  ImpuestoRetenido.Nombre := 'ISR';
  ImpuestoRetenido.Importe := 1000;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/agregarimpuesto_retencion.xml');
  TotalImpuestosAnterior := fComprobanteFiscal.TotalImpuestosRetenidos;

  // Agregamos el impuesto en cuestion
  fComprobanteFiscal.AgregarImpuestoRetenido(ImpuestoRetenido);

  // Comprobamos el XML y el total de impuestos retenidos
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el impuesto retenido o este es incorrecto.');

  CheckEquals(TotalImpuestosAnterior + ImpuestoRetenido.Importe,
    fComprobanteFiscal.TotalImpuestosRetenidos,
    'No se sumo correctamente el importe del impuesto al total de impuestos retenidos');
end;

procedure TestTFEComprobanteFiscal.AgregarImpuestoTrasladado_Impuesto_LoGuardeEnXML;
var
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  TotalImpuestosAnterior: Currency;
  sXMLFixture: WideString;
begin
  ImpuestoTrasladado.Nombre := 'IVA';
  ImpuestoTrasladado.Tasa := 16;
  ImpuestoTrasladado.Importe := 1000;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/agregarimpuesto_trasladado.xml');
  TotalImpuestosAnterior := fComprobanteFiscal.TotalImpuestosTrasladados;

  // Agregamos el impuesto en cuestion
  fComprobanteFiscal.AgregarImpuestoTrasladado(ImpuestoTrasladado);
  // guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'comprobante_fiscal/agregarimpuesto_trasladado.xml');

  // Comprobamos el XML y el total de impuestos retenidos
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el impuesto trasladado o este es incorrecto.');

  CheckEquals(TotalImpuestosAnterior + ImpuestoTrasladado.Importe,
    fComprobanteFiscal.TotalImpuestosTrasladados,
    'No se sumo correctamente el importe del impuesto al total de impuestos trasladados');
end;

procedure TestTFEComprobanteFiscal.AgregarImpuestoRetenido_Varios_SumeSuTotal;
var
  iCuantos, I: Integer;
  aImpuestos: Array of TFEImpuestoRetenido;
  dTotalImpuestos: Double;
begin
  // Agregamos una cantidad aleatoria de impuestos
  Randomize;
  iCuantos := Random(9);
  SetLength(aImpuestos, iCuantos);
  dTotalImpuestos := 0;

  // Creamos los impuestos
  for I := 0 to Length(aImpuestos) - 1 do
  begin
    aImpuestos[I].Nombre := IntToStr(I);
    aImpuestos[I].Importe := Random(999);
    dTotalImpuestos := dTotalImpuestos + aImpuestos[I].Importe;
  end;

  // Los agregamos al comprobante
  for I := 0 to Length(aImpuestos) - 1 do
    fComprobanteFiscal.AgregarImpuestoRetenido(aImpuestos[I]);

  CheckEquals(dTotalImpuestos, fComprobanteFiscal.TotalImpuestosRetenidos,
    'El total de impuestos retenidos no fue la suma de todos los impuestos agregados');

end;

procedure TestTFEComprobanteFiscal.AgregarImpuestoTrasladado_Varios_SumeSuTotal;
var
  iCuantos, I: Integer;
  aImpuestos: Array of TFEImpuestoTrasladado;
  dTotalImpuestos: Double;
begin
  // Agregamos una cantidad aleatoria de impuestos
  Randomize;
  iCuantos := Random(9);
  SetLength(aImpuestos, iCuantos);
  dTotalImpuestos := 0;

  // Creamos los impuestos
  for I := 0 to Length(aImpuestos) - 1 do
  begin
    aImpuestos[I].Nombre := IntToStr(I);
    aImpuestos[I].Tasa := Random(9);
    aImpuestos[I].Importe := Random(999);
    dTotalImpuestos := dTotalImpuestos + aImpuestos[I].Importe;
  end;

  // Los agregamos al comprobante
  for I := 0 to Length(aImpuestos) - 1 do
    fComprobanteFiscal.AgregarImpuestoTrasladado(aImpuestos[I]);

  CheckEquals(dTotalImpuestos, fComprobanteFiscal.TotalImpuestosTrasladados,
    'El total de impuestos trasladados no fue la suma de todos los impuestos agregados');
end;

// Funcion comun para generar el comprobante fiscal con los mismos datos
// que el XML especificado como parametro, regresa el Sello
function TestTFEComprobanteFiscal.GenerarComprobanteFiscal(DeArchivoXML: String; Certificado: TFECertificado): String;
var
  Bloque: TFEBloqueFolios;
  I: Integer;
  Concepto: TFEConcepto;
  Emisor, Receptor: TFEContribuyente;
  ExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
  dSubtotal, dTotal: Double;

  fXMLPrueba : TXMLDocument;
  fXMLComprobantePrueba: IFEXMLComprobante;

  procedure leerComprobanteXML();
  begin
       fXMLPrueba := TXMLDocument.Create(nil);
       fXMLPrueba.LoadFromFile(DeArchivoXML);
       fXmlComprobantePrueba := GetComprobante(fXMLPrueba);
  end;

  function ConvertirFechaComprobanteADateTime(sFechaHora: String) : TDateTime;
  var
     sAno, sMes, sDia, sHora, sMin, sMs: String;
  begin
     // Ejemplo: 2009-08-16T16:30:00
     sAno:=Copy(sFechaHora,1,4);
     sMes:=Copy(sFechaHora,6,2);
     sDia:=Copy(sFechaHora,9,2);
     sHora:=Copy(sFechaHora,12,2);
     sMin:=Copy(sFechaHora,15,2);
     sMs:=Copy(sFechaHora,18,2);
     Result:=EncodeDateTime(StrToInt(sAno),StrToInt(sMes),StrToInt(sDia),StrToInt(sHora),StrToInt(sMin),StrToInt(sMs),0);
  end;

begin
  // Leemos el fixture de comprobante XML para obtener sus propiedades y asignarlas al comprobante
  leerComprobanteXML();
  // 1. Definimos los datos de los folios
  fComprobanteFiscal.Folio:=StrToInt(fXmlComprobantePrueba.Folio);
  // Si es la version de prueba, establecemos la fecha/hora para que coincida
  // con la fecha/hora en que se genero el comprobante usando MicroE
  fComprobanteFiscal.fFechaGeneracion := ConvertirFechaComprobanteADateTime(fXmlComprobantePrueba.Fecha);

  Bloque.NumeroAprobacion := fXmlComprobantePrueba.NoAprobacion;
  Bloque.AnoAprobacion := fXmlComprobantePrueba.AnoAprobacion;
  Bloque.Serie := fXmlComprobantePrueba.Serie;
  Bloque.FolioInicial := 1;
  // Indicamos que el folio final es el folio del comprobante + 1 para que siempre este "en reango"
  Bloque.FolioFinal := StrToInt(fXmlComprobantePrueba.Folio) + 1;
  fComprobanteFiscal.BloqueFolios := Bloque;

  // 2. Establecemos el certificado a usar
  fComprobanteFiscal.Certificado := Certificado;

  // 3. Establecemos el Emisor y Receptor
  with  fXmlComprobantePrueba.Emisor do
  begin
      Emisor.Nombre :=Nombre;
      Emisor.RFC := RFC;
      Emisor.Direccion.Calle := DomicilioFiscal.Calle;
      Emisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
      Emisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
      Emisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
      Emisor.Direccion.Colonia := DomicilioFiscal.Colonia;
      Emisor.Direccion.Localidad := DomicilioFiscal.Localidad;
      Emisor.Direccion.Municipio := DomicilioFiscal.Municipio;
      Emisor.Direccion.Estado := DomicilioFiscal.Estado;
      Emisor.Direccion.Pais := DomicilioFiscal.Pais;
      fComprobanteFiscal.Emisor := Emisor;
  end;

  with  fXmlComprobantePrueba.Receptor do
  begin
      Receptor.Nombre := Nombre;
      Receptor.RFC := RFC;
      Receptor.Direccion.Calle := Domicilio.Calle;
      Receptor.Direccion.NoExterior := Domicilio.NoExterior;
      Receptor.Direccion.CodigoPostal := Domicilio.CodigoPostal;
      Receptor.Direccion.Colonia := Domicilio.Colonia;
      Receptor.Direccion.Estado := Domicilio.Estado;
      Receptor.Direccion.Localidad := Domicilio.Localidad;
      Receptor.Direccion.Municipio := Domicilio.Municipio;
      Receptor.Direccion.Pais := Domicilio.Pais;
      fComprobanteFiscal.Receptor := Receptor;
  end;

  // Tiene direccion de "Expedido En" ??
  if fXmlComprobantePrueba.Emisor.ExpedidoEn.Calle <> '' then
  begin
      with fXmlComprobantePrueba.Emisor.ExpedidoEn do
      begin
          ExpedidoEn.Calle := Calle;
          ExpedidoEn.NoExterior := NoExterior;
          ExpedidoEn.CodigoPostal := CodigoPostal;
          ExpedidoEn.Localidad:= Localidad;
          ExpedidoEn.Municipio:=Municipio;
          ExpedidoEn.Colonia := Colonia;
          ExpedidoEn.Estado := Estado;
          ExpedidoEn.Pais := Pais;
      end;
      fComprobanteFiscal.ExpedidoEn:=ExpedidoEn;
  end;

  // 4. Agregamos los conceptos
  dSubtotal:=0;
  dTotal:=0;

  for I := 0 to fXmlComprobantePrueba.Conceptos.Count - 1 do
  begin
      with fXmlComprobantePrueba.Conceptos.Concepto[I] do
      begin
          Concepto.Cantidad := StrToFloat(Cantidad);
          Concepto.NoIdentificacion := NoIdentificacion;
          Concepto.Unidad := Unidad;
          Concepto.Descripcion := Descripcion;
          Concepto.ValorUnitario := StrToFloat(ValorUnitario);
          Concepto.CuentaPredial:=CuentaPredial.Numero;
          dSubtotal:=dSubtotal + Concepto.Importe;
          // TODO: Leer datos de aduana si acaso los tiene
      end;
      fComprobanteFiscal.AgregarConcepto(Concepto);
  end;

  // Agregamos las reteneciones
  for I := 0 to fXmlComprobantePrueba.Impuestos.Retenciones.Count - 1 do
    begin
      with fXmlComprobantePrueba.Impuestos.Retenciones do
      begin
        ImpuestoRetenido.Nombre:=Retencion[I].Impuesto;
        ImpuestoRetenido.Importe:=StrToFloat(Retencion[I].Importe);

        fComprobanteFiscal.AgregarImpuestoRetenido(Impuestoretenido);
      end;
    end;

    // Agregamos los impuestos trasladados
    for I := 0 to fXmlComprobantePrueba.Impuestos.Traslados.Count - 1 do
    begin
      with fXmlComprobantePrueba.Impuestos.Traslados do
      begin
        ImpuestoTrasladado.Nombre:=Traslado[I].Impuesto;
        ImpuestoTrasladado.Tasa:=StrToFloat(Traslado[I].Tasa);
        ImpuestoTrasladado.Importe:=StrToFloat(Traslado[I].Importe);

        fComprobanteFiscal.AgregarImpuestoTrasladado(ImpuestoTrasladado);
      end;
    end;

    // Checamos si el XML proveido tiene los totales de impuestos desglosados...
    if fXmlComprobantePrueba.Impuestos.TotalImpuestosTrasladados <> '' then
       fComprobanteFiscal.DesglosarTotalesImpuestos:=True
    else
       fComprobanteFiscal.DesglosarTotalesImpuestos:=False;

    // Que forma de pago tuvo??
    // Asignamos el mismo texto de la forma de pago ya que unos usan mayusculas otros minusculas, etc.
    if AnsiPos('UNA',Uppercase(fXmlComprobantePrueba.FormaDePago)) > 0 then
    begin
       fComprobanteFiscal._CADENA_PAGO_UNA_EXHIBICION := fXmlComprobantePrueba.FormaDePago;
       fComprobanteFiscal.FormaDePago:=fpUnaSolaExhibicion;
    end else
    begin
       fComprobanteFiscal._CADENA_PAGO_PARCIALIDADES:= fXmlComprobantePrueba.FormaDePago;
       fComprobanteFiscal.FormaDePago:=fpParcialidades;
    end;

    // Tipo de comprobante
    if fXmlComprobantePrueba.TipoDeComprobante = 'ingreso' then
       fComprobanteFiscal.Tipo:=tcIngreso;

    if fXmlComprobantePrueba.TipoDeComprobante = 'egreso' then
       fComprobanteFiscal.Tipo:=tcEgreso;

    if fXmlComprobantePrueba.TipoDeComprobante = 'traslado' then
       fComprobanteFiscal.Tipo:=tcTraslado;

    // Asignamos el descuento
    if fXmlComprobantePrueba.Descuento <> '' then
       fComprobanteFiscal.AsignarDescuento(StrToFloat(fXmlComprobantePrueba.Descuento),'');

    // Asignamos el subtotal de la factura
    fComprobanteFiscal.SubTotal := dSubTotal;

    // Asignamos el total de la factura (subtotal + impuestos)
    fComprobanteFiscal.Total := fComprobanteFiscal.SubTotal +
                                fComprobanteFiscal.TotalImpuestosRetenidos +
                                fComprobanteFiscal.TotalImpuestosTrasladados;

    // Regresamos el sello del XML leido
    Result:=fXmlComprobantePrueba.Sello;
end;

procedure TestTFEComprobanteFiscal.CadenaOriginal_DeComprobante_SeaCorrecta;
var
  sCadenaOriginalCorrecta: WideString;
  Certificado: TFECertificado;
const
  // Archivos de ejemplo del SAT usados por la aplicacion MicroE del SAT
  // Ref: http://www.sat.gob.mx/sitio_internet/servicios/20_16360.html
  _MICROE_ARCHIVO_CERTIFICADO = 'comprobante_fiscal\FIFC000101AM1.cer';
  _MICROE_ARCHIVO_LLAVE_PRIVADA = 'comprobante_fiscal\FIFC000101AM1.key';
  _MICROE_CLAVE_LLAVE_PRIVADA = '12345678a';
begin
  // Leemos la cadena original generada por el programa de MicroE del SAT. (que
  // copiamos y pegamos del PDF que genero)
  sCadenaOriginalCorrecta := leerContenidoDeFixture('comprobante_fiscal/factura_cadena_original.txt');

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  Certificado.Ruta := fRutaFixtures + _MICROE_ARCHIVO_CERTIFICADO;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _MICROE_ARCHIVO_LLAVE_PRIVADA;
  Certificado.LlavePrivada.Clave := _MICROE_CLAVE_LLAVE_PRIVADA;

  GenerarComprobanteFiscal(fRutaFixtures + 'comprobante_fiscal/comprobante_cadena_original.xml',
                           Certificado);

  guardarArchivoTemporal(fComprobanteFiscal.CadenaOriginal, 'test_cadena_original.txt');
  // Comparamos el resultado del metodo de la clase con el del archivo codificado con la funcion
  // UTF8Encode
  CheckEquals(sCadenaOriginalCorrecta, fComprobanteFiscal.CadenaOriginal,
             'La cadena original no fue generada correctamente');
end;

procedure TestTFEComprobanteFiscal.SelloDigital_DeComprobante_SeaCorrecto;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  // Llenamos los datos que fueron usados para generar dicho comprobante
  Certificado.Ruta := fRutaFixtures + 'comprobante_fiscal/FIFC000101AM1.cer';
  Certificado.LlavePrivada.Ruta := fRutaFixtures + 'comprobante_fiscal/FIFC000101AM1.key';
  Certificado.LlavePrivada.Clave := '12345678a';

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := GenerarComprobanteFiscal(fRutaFixtures +  'comprobante_fiscal/comprobante_para_sello_digital.xml',
                           Certificado);

  // TEMPORAL:
  guardarArchivoTemporal(fComprobanteFiscal.CadenaOriginal, 'cad_orig.txt');

  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscal.SelloDigital,
              'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscal.XML_DeComprobanteHecho_GenereXMLCorrectamente;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
  fDocXML: TXMLDocument;
begin
  // Llenamos los datos que fueron usados para generar dicho comprobante
  Certificado.Ruta := fRutaFixtures + 'comprobante_fiscal/FIFC000101AM1.cer';
  Certificado.LlavePrivada.Ruta := fRutaFixtures + 'comprobante_fiscal/FIFC000101AM1.key';
  Certificado.LlavePrivada.Clave := '12345678a';

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := GenerarComprobanteFiscal(fRutaFixtures +  'comprobante_fiscal/comprobante_correcto.xml',
                           Certificado);

   // TEMPORAL:
  guardarArchivoTemporal(fComprobanteFiscal.CadenaOriginal, 'mycadena.txt');
  fComprobanteFiscal.GuardarEnArchivo(fDirTemporal + 'myxml.xml');

  CheckEquals(True, True, '');
end;

procedure TestTFEComprobanteFiscal.Create_NuevoComprobante_GenereEstructuraXMLBasica;
var
  sXMLEncabezadoBasico: WideString;
  NuevoComprobante: TFEComprobanteFiscal;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLEncabezadoBasico := leerContenidoDeFixture('comprobante_fiscal/nuevo.xml');
  NuevoComprobante := TFEComprobanteFiscal.Create;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLEncabezadoBasico, fComprobanteFiscal.fXmlComprobante.XML,
    'El encabezado del XML basico para un comprobante no fue el correcto');
  FreeAndNil(NuevoComprobante);
end;

procedure TestTFEComprobanteFiscal.setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
var
  Certificado: TFECertificado;
  sXMLConNumSerieCertificado: WideString;
begin
  Certificado.Ruta := fRutaFixtures + _RUTA_CERTIFICADO;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConNumSerieCertificado := leerContenidoDeFixture('comprobante_fiscal/numeroserie.xml');

  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Certificado := Certificado;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLConNumSerieCertificado, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el numero de serie del certificado o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscal.setEmisor_Emisor_LoGuardeEnXML;
var
  Emisor: TFEContribuyente;
  sXMLConReceptor: WideString;
begin
  Emisor.Nombre := 'Industrias del Sur Poniente, S.A. de C.V.';
  Emisor.RFC := 'ISP900909Q88';
  with Emisor.Direccion do
  begin
    Calle := 'Alvaro Obregón';
    NoExterior := '37';
    NoInterior := '';
    CodigoPostal := '31000';
    Colonia := 'Col. Roma Norte';
    Municipio := 'Cuauhtémoc';
    Estado := 'Distrito Federal';
    Pais := 'México';
    Localidad := '';
    Referencia := '';
  end;

  // Establecemos el receptor
  fComprobanteFiscal.Emisor := Emisor;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConReceptor := leerContenidoDeFixture('comprobante_fiscal/emisor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

procedure TestTFEComprobanteFiscal.setReceptor_Receptor_LoGuardeEnXML;
var
  Receptor: TFEContribuyente;
  sXMLConReceptor: WideString;
begin
  Receptor.Nombre := 'Rosa María Calderón Uriegas';
  Receptor.RFC := 'CAUR390312S87';
  with Receptor.Direccion do
  begin
    Calle := 'Jardines del Valle';
    NoExterior := '06700';
    NoInterior := '';
    CodigoPostal := '95465';
    Colonia := 'Cienegas';
    Municipio := 'Monterrey';
    Estado := 'Nuevo León';
    Pais := 'México';
    Localidad := 'Monterrey';
    Referencia := '';
  end;

  // Establecemos el receptor
  fComprobanteFiscal.Receptor := Receptor;
  // guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'comprobante_fiscal/receptor.xml');
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConReceptor := leerContenidoDeFixture('comprobante_fiscal/receptor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTFEComprobanteFiscal.Suite);

end.
