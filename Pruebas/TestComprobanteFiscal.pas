(* *****************************************************************************
  Copyright (C) 2010-2012 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
unit TestComprobanteFiscal;

interface

uses
  TestFramework, ComprobanteFiscal, FacturaTipos, TestPrueba;

type

  TestTFEComprobanteFiscal = class(TTestPrueba)
  strict private
    fComprobanteFiscal: TFEComprobanteFiscal;
  private
    procedure ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
  public
    procedure SetUp; override;
    procedure TearDown; override;
    function LeerXMLEnComprobante(DeArchivoXML: String; Certificado:
        TFECertificado; var ComprobanteDestino: TFEComprobanteFiscal): String;
  published
    procedure Create_NuevoComprobante_GenereEstructuraXMLBasica;
    procedure setReceptor_Receptor_LoGuardeEnXML;
    procedure setEmisor_Emisor_LoGuardeEnXML;
    procedure AgregarConcepto_Concepto_LoGuardeEnXML;
    procedure SelloDigital_DeMilConceptos_SeaCorrecto;
    procedure setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
    procedure setCertificado_IncluyendoEnXML_GuardeCertificadoBase64EnXML;
    procedure setFolio_Folio_LoGuardeEnXML;
    procedure setBloqueFolios_Bloque_LoGuardeEnXML;
    procedure setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
    //procedure setTotal_Monto_LoGuardeEnXML;
    procedure setSubtotal_Monto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoTrasladado_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Varios_SumeSuTotal;
    procedure AgregarImpuestoTrasladado_Varios_SumeSuTotal;
    procedure CadenaOriginal_DeComprobante_SeaCorrecta;
    procedure SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
    procedure SelloDigital_DeComprobante_SeaCorrecto;
    procedure XML_DeComprobanteHecho_GenereXMLCorrectamente;
    procedure setXML_DeComprobanteExistente_EstablezcaLasPropiedadesCorrectamente;
    procedure GuardarEnArchivo_ComprobanteDeXML_LoGuarde;
    procedure setXML_DeComprobanteV2_EstablezcaLasPropiedadesCorrectamente;
  end;

implementation

uses
  Windows, SysUtils, Classes, ConstantesFixtures, dialogs,
  DateUtils, XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd, FeCFD, FeCFDv22, FeCFDv32, FeCFDv2;

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
  fComprobanteFiscal.AsignarConceptos;

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
  Bloque.FolioInicial:=1;
  Bloque.FolioFinal:=10000;

  // Asignamos el bloque de folios
  fComprobanteFiscal.Folio:=1;
  fComprobanteFiscal.BloqueFolios := Bloque;
  fComprobanteFiscal.AsignarDatosFolios;

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
    On EFEFolioFueraDeRango do
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
  fComprobanteFiscal.AsignarFolio;

  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'No se guardo el Folio en la estructura del XML');
end;

{
procedure TestTFEComprobanteFiscal.setTotal_Monto_LoGuardeEnXML;
var
  sXMLFixture: WideString;
const
  _TOTAL_COMPROBANTE = 1000;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/total.xml');

  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.SubTotal := _TOTAL_COMPROBANTE;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el monto total o este es incorrecto.');
end;   }

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
  fComprobanteFiscal.AsignarSubtotal;

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
  fComprobanteFiscal.AsignarImpuestosRetenidos;

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
  fComprobanteFiscal.AsignarImpuestosTrasladados;

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

  fComprobanteFiscal.AsignarImpuestosRetenidos;

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

  fComprobanteFiscal.AsignarImpuestosTrasladados;

  CheckEquals(dTotalImpuestos, fComprobanteFiscal.TotalImpuestosTrasladados,
    'El total de impuestos trasladados no fue la suma de todos los impuestos agregados');
end;

// Funcion comun para generar el comprobante fiscal con los mismos datos
// que el XML especificado como parametro, regresa el Sello
function TestTFEComprobanteFiscal.LeerXMLEnComprobante(DeArchivoXML: String;
    Certificado: TFECertificado; var ComprobanteDestino: TFEComprobanteFiscal):
    String;
var
  Bloque: TFEBloqueFolios;
  I: Integer;
  Concepto: TFEConcepto;
  Emisor, Receptor: TFEContribuyente;
  ExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
  dSubtotal: Double;
  sSello: String;

  fXMLPrueba: TXMLDocument;
  fXMLComprobantePrueba: IFEXMLComprobante;
  VersionCFD: TFEVersionComprobante;

  procedure leerComprobanteXML();
  begin
    fXMLPrueba := TXMLDocument.Create(nil);
    fXMLPrueba.LoadFromFile(DeArchivoXML);

    // Que version de CFD estamos leyendo?
    if AnsiPos('version="2.0"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobante(fXMLPrueba);
      VersionCFD:=fev20;
    end;

    if AnsiPos('version="2.2"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobanteV22(fXMLPrueba);
      VersionCFD:=fev22;
    end;

    if AnsiPos('version="3.2"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobanteV32(fXMLPrueba);
      VersionCFD:=fev22;
    end;
  end;

  function ConvertirFechaComprobanteADateTime(sFechaHora: String): TDateTime;
  var
    sAno, sMes, sDia, sHora, sMin, sMs: String;
  begin
    // Ejemplo: 2009-08-16T16:30:00
    sAno := Copy(sFechaHora, 1, 4);
    sMes := Copy(sFechaHora, 6, 2);
    sDia := Copy(sFechaHora, 9, 2);
    sHora := Copy(sFechaHora, 12, 2);
    sMin := Copy(sFechaHora, 15, 2);
    sMs := Copy(sFechaHora, 18, 2);
    Result := EncodeDateTime(StrToInt(sAno), StrToInt(sMes), StrToInt(sDia), StrToInt(sHora),
      StrToInt(sMin), StrToInt(sMs), 0);
  end;

  // Se encarga de recalcular el sello basado en el archivo de llave privada
  // especificado
  function RecalcularSello(aArchivoLlavePrivada, aClaveLlavePrivada, aCadenaOriginal: String) : String;
  var
    _ARCHIVO_CADENA_TEMPORAL : String;
    _ARCHIVO_LLAVE_PEM : String;
    _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL : String;
  begin
      _ARCHIVO_CADENA_TEMPORAL := 'cadena.txt';
      _ARCHIVO_LLAVE_PEM := 'x.pem';
      _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL := 'res.txt';

      // Convertimos la llave privada a archivo PEM
      EjecutarComandoOpenSSL('pkcs8 -inform DER -in ' + aArchivoLlavePrivada +
                         ' -passin pass:' + aClaveLlavePrivada +
                         ' -out ' + fDirTemporal + _ARCHIVO_LLAVE_PEM);

      // Guardamos la cadena original en un archivo
      guardarArchivoEnUTF8(UTF8Encode(aCadenaOriginal), _ARCHIVO_CADENA_TEMPORAL);

      // Mandamos generar el sello usando OpenSSL
      EjecutarComandoOpenSSL('dgst -md5 -sign "' + fDirTemporal + _ARCHIVO_LLAVE_PEM +
        '" -out "' + fDirTemporal +
        'md5_cadena_de_prueba.bin" "' + fDirTemporal + _ARCHIVO_CADENA_TEMPORAL + '"');

      // Convertimos el resultado (archivo binario) a base64
      EjecutarComandoOpenSSL(' enc -base64 -in "' + fDirTemporal +
        'md5_cadena_de_prueba.bin" -out "' + fDirTemporal +
        _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL + '"');

      Result := QuitarRetornos(leerContenidoDeArchivo(fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL));
  end;

begin
  // Leemos el fixture de comprobante XML para obtener sus propiedades y asignarlas al comprobante
  leerComprobanteXML();
  // 1. Definimos los datos de los folios
  ComprobanteDestino.Folio := StrToInt(fXMLComprobantePrueba.Folio);
  // Si es la version de prueba, establecemos la fecha/hora para que coincida
  // con la fecha/hora en que se genero el comprobante usando MicroE
  ComprobanteDestino.FechaGeneracion := ConvertirFechaComprobanteADateTime
    (fXMLComprobantePrueba.Fecha);

  //Bloque.NumeroAprobacion := ((IFEXMLComprobanteV32(fXMLComprobantePrueba).NoAprobacion);
  //Bloque.AnoAprobacion := ((fXMLComprobantePrueba As IFEXMLComprobanteV22).AnoAprobacion);
  Bloque.Serie := fXMLComprobantePrueba.Serie;
  Bloque.FolioInicial := 1;
  // Indicamos que el folio final es el folio del comprobante + 1 para que siempre este "en reango"
  Bloque.FolioFinal := StrToInt(fXMLComprobantePrueba.Folio) + 1;
  ComprobanteDestino.BloqueFolios := Bloque;

  // 2. Establecemos el certificado a usar
  ComprobanteDestino.Certificado := Certificado;

  // Leemos el metodo de pago
  ComprobanteDestino.MetodoDePago := fXMLComprobantePrueba.MetodoDePago;

  // Solo si es la v2.2 leemos el lugar de expedicion
  if VersionCFD = fev22 then
  begin
    ComprobanteDestino.LugarDeExpedicion := IFEXMLComprobanteV22(fXMLComprobantePrueba).LugarExpedicion;
    Assert(Trim(ComprobanteDestino.MetodoDePago) <> '', 'El CFD debe tener un metodo de pago');
    Assert(Trim(ComprobanteDestino.LugarDeExpedicion) <> '', 'El CFD debe tener un lugar de expedicion');
  end;

  // 3. Establecemos el Emisor y Receptor
  case VersionCFD of
    fev20:
    begin
        with IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor do
        begin
          Emisor.Nombre := Nombre;
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
        end;
    end;
    fev22:
    begin
        with IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor do
        begin
          Emisor.Nombre := Nombre;
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

          // Leemos los régimenes que contiene el CFD del XML
          SetLength(Emisor.Regimenes, RegimenFiscal.Count);
          for I := 0 to RegimenFiscal.Count - 1 do
            Emisor.Regimenes[I] := RegimenFiscal[I].Regimen;
        end;
    end;
  end;
  ComprobanteDestino.Emisor := Emisor;

  with fXMLComprobantePrueba.Receptor do
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
    ComprobanteDestino.Receptor := Receptor;
  end;

  // Tiene direccion de "Expedido En" ??
  case VersionCFD of
    fev20:
    begin
        if IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor.ExpedidoEn.Calle <> '' then
        begin
          with IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor.ExpedidoEn do
          begin
            ExpedidoEn.Calle := Calle;
            ExpedidoEn.NoExterior := NoExterior;
            ExpedidoEn.CodigoPostal := CodigoPostal;
            ExpedidoEn.Localidad := Localidad;
            ExpedidoEn.Municipio := Municipio;
            ExpedidoEn.Colonia := Colonia;
            ExpedidoEn.Estado := Estado;
            ExpedidoEn.Pais := Pais;
          end;
          ComprobanteDestino.ExpedidoEn := ExpedidoEn;
        end;
    end;
    fev22:
    begin
        if IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor.ExpedidoEn.Calle <> '' then
        begin
          with IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor.ExpedidoEn do
          begin
            ExpedidoEn.Calle := Calle;
            ExpedidoEn.NoExterior := NoExterior;
            ExpedidoEn.CodigoPostal := CodigoPostal;
            ExpedidoEn.Localidad := Localidad;
            ExpedidoEn.Municipio := Municipio;
            ExpedidoEn.Colonia := Colonia;
            ExpedidoEn.Estado := Estado;
            ExpedidoEn.Pais := Pais;
          end;
          ComprobanteDestino.ExpedidoEn := ExpedidoEn;
        end;
    end;
  end;

  // 4. Agregamos los conceptos
  dSubtotal := 0;

  for I := 0 to fXMLComprobantePrueba.Conceptos.Count - 1 do
  begin
    with fXMLComprobantePrueba.Conceptos.Concepto[I] do
    begin
      Concepto.Cantidad := StrToFloat(Cantidad);
      Concepto.NoIdentificacion := NoIdentificacion;
      Concepto.Unidad := Unidad;
      Concepto.Descripcion := Descripcion;
      Concepto.ValorUnitario := StrToFloat(ValorUnitario);
      Concepto.CuentaPredial := CuentaPredial.Numero;
      dSubtotal := dSubtotal + (Concepto.ValorUnitario * Concepto.Cantidad);
      // TODO: Leer datos de aduana si acaso los tiene
    end;
    ComprobanteDestino.AgregarConcepto(Concepto);
  end;

  // Agregamos las reteneciones
  for I := 0 to fXMLComprobantePrueba.Impuestos.Retenciones.Count - 1 do
  begin
    with fXMLComprobantePrueba.Impuestos.Retenciones do
    begin
      ImpuestoRetenido.Nombre := Retencion[I].Impuesto;
      ImpuestoRetenido.Importe := StrToFloat(Retencion[I].Importe);

      ComprobanteDestino.AgregarImpuestoRetenido(ImpuestoRetenido);
    end;
  end;

  // Agregamos los impuestos trasladados
  for I := 0 to fXMLComprobantePrueba.Impuestos.Traslados.Count - 1 do
  begin
    with fXMLComprobantePrueba.Impuestos.Traslados do
    begin
      ImpuestoTrasladado.Nombre := Traslado[I].Impuesto;
      ImpuestoTrasladado.Tasa := StrToFloat(Traslado[I].Tasa);
      ImpuestoTrasladado.Importe := StrToFloat(Traslado[I].Importe);

      ComprobanteDestino.AgregarImpuestoTrasladado(ImpuestoTrasladado);
    end;
  end;

  // Checamos si el XML proveido tiene los totales de impuestos desglosados...
  if fXMLComprobantePrueba.Impuestos.TotalImpuestosTrasladados <> '' then
    ComprobanteDestino.DesglosarTotalesImpuestos := True
  else
    ComprobanteDestino.DesglosarTotalesImpuestos := False;

  // Que forma de pago tuvo??
  // Asignamos el mismo texto de la forma de pago ya que unos usan mayusculas otros minusculas, etc.
  if AnsiPos('UNA', Uppercase(fXMLComprobantePrueba.FormaDePago)) > 0 then
  begin
    ComprobanteDestino._CADENA_PAGO_UNA_EXHIBICION := fXMLComprobantePrueba.FormaDePago;
    ComprobanteDestino.FormaDePago := fpUnaSolaExhibicion;
  end
  else
  begin
    ComprobanteDestino._CADENA_PAGO_PARCIALIDADES := fXMLComprobantePrueba.FormaDePago;
    ComprobanteDestino.FormaDePago := fpParcialidades;
  end;

  // Tipo de comprobante
  if fXMLComprobantePrueba.TipoDeComprobante = 'ingreso' then
    ComprobanteDestino.Tipo := tcIngreso;

  if fXMLComprobantePrueba.TipoDeComprobante = 'egreso' then
    ComprobanteDestino.Tipo := tcEgreso;

  if fXMLComprobantePrueba.TipoDeComprobante = 'traslado' then
    ComprobanteDestino.Tipo := tcTraslado;

  sSello := fXMLComprobantePrueba.Sello;

  // Asignamos el descuento
  if fXMLComprobantePrueba.Descuento <> '' then
    ComprobanteDestino.AsignarDescuento(StrToFloat(fXMLComprobantePrueba.Descuento), '');

  // Asignamos el subtotal de la factura
  ComprobanteDestino.SubTotal := dSubtotal;

  // Regresamos el sello re-calculado usando OpenSSL y el certificado indicado.
  {Result := RecalcularSello(Certificado.LlavePrivada.Ruta,
                            Certificado.LlavePrivada.Clave,
                            ComprobanteDestino.CadenaOriginal);    }


  Result:=sSello;
end;

procedure TestTFEComprobanteFiscal.ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
const
  _MICROE_ARCHIVO_CERTIFICADO = 'comprobante_fiscal\aaa010101aaa_csd_01.cer';
  _MICROE_ARCHIVO_LLAVE_PRIVADA = 'comprobante_fiscal\aaa010101aaa_csd_01.key';
  _MICROE_CLAVE_LLAVE_PRIVADA = 'a0123456789';
begin
  Certificado.Ruta := fRutaFixtures + _MICROE_ARCHIVO_CERTIFICADO;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _MICROE_ARCHIVO_LLAVE_PRIVADA;
  Certificado.LlavePrivada.Clave := _MICROE_CLAVE_LLAVE_PRIVADA;
end;

procedure TestTFEComprobanteFiscal.CadenaOriginal_DeComprobante_SeaCorrecta;
var
  sCadenaOriginalCorrecta: TStringCadenaOriginal;
  Certificado: TFECertificado;

  // Creamos una rutina especial para leer el archivo de cadena original de ejemplo
  // ya que viene en UTF8 y tiene que ser leida como tal para poder compararla
  function leerArchivoEnUTF8(sNombreFixture: String): TStringCadenaOriginal;
  var
    fArchivo : TextFile;
    buffer : TStringCadenaOriginal;
 begin
     AssignFile(fArchivo, fRutaFixtures + sNombreFixture);
     Reset(fArchivo) ;
     ReadLn(fArchivo, buffer);
     CloseFile(fArchivo);
     Result:=Buffer;
  end;

begin
  // Leemos la cadena original generada de ejemplo generada previamente con otra aplicacion
  sCadenaOriginalCorrecta := leerArchivoEnUTF8('comprobante_fiscal/factura_cadena_original_utf8.txt');
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLEnComprobante(fRutaFixtures + 'comprobante_fiscal/comprobante_cadena_original.xml',
                       Certificado,
                       fComprobanteFiscal);

  // Quitamos la cadena original y sellos del XML para re-calcularlos
  fComprobanteFiscal.FacturaGenerada:=False;
  fComprobanteFiscal.fCadenaOriginalCalculada:='';
  fComprobanteFiscal.fSelloDigitalCalculado:='';

  // Comparamos el resultado del metodo de la clase con el del archivo codificado con la funcion
  CheckEquals(sCadenaOriginalCorrecta,
              fComprobanteFiscal.CadenaOriginal,
              'La cadena original no fue generada correctamente');
end;


procedure TestTFEComprobanteFiscal.SelloDigital_DeMilConceptos_SeaCorrecto;
var
     sSelloDigitalDelXML, sSelloCalculado: String;
     Certificado: TFECertificado;
begin
      ConfigurarCertificadoDePrueba(Certificado);

      // Leemos el comprobante del XML (que no tiene conceptos)
      sSelloDigitalDelXML := LeerXMLEnComprobante(fRutaFixtures +
                              'comprobante_fiscal/comprobante_para_sello_digital_con_mil_conceptos.xml',
                              Certificado,
                              fComprobanteFiscal);

     // Quitamos la cadena original y sellos del XML para re-calcularlos
     fComprobanteFiscal.FacturaGenerada:=False;
     fComprobanteFiscal.fCadenaOriginalCalculada:='';
     fComprobanteFiscal.fSelloDigitalCalculado:='';

     // Mandamos calcular el sello digital del XML el cual ya tiene mil artículos
     sSelloCalculado:=fComprobanteFiscal.SelloDigital;

     // Verificamos que el sello sea correcto
     CheckEquals(sSelloDigitalDelXML,
                 sSelloCalculado,
                 'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscal.SelloDigital_DeComprobante_SeaCorrecto;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := LeerXMLEnComprobante
    (fRutaFixtures + 'comprobante_fiscal/comprobante_para_sello_digital.xml',
    Certificado, fComprobanteFiscal);
  
  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscal.SelloDigital,
              'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscal.SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLEnComprobante(fRutaFixtures + 'comprobante_fiscal/comprobante_para_sello_digital.xml',
                           Certificado, fComprobanteFiscal);

  // Establecemos la propiedad de DEBUG solamente para que use la fecha/hora actual
  // para la generacion del comprobante y corroborar este funcionamiento
  fComprobanteFiscal._USAR_HORA_REAL := True;

  // Obtenemos el sello por primera vez...
  sSelloDigitalCorrecto:=fComprobanteFiscal.SelloDigital;

  // Nos esperamos 2 segundos (para forzar que la fecha de generacion sea diferente)
  Sleep(2500);

  // Verificamos obtener el sello digital de nuevo y que sea el mismo
  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscal.SelloDigital,
              'El sello digital no fue calculado correctamente la segunda ocasion');
end;

procedure TestTFEComprobanteFiscal.GuardarEnArchivo_ComprobanteDeXML_LoGuarde;
var
  sContenidoXML: UnicodeString;
  sArchivo: String;
begin
   // Leemos el XML de nuestro Fixture en memoria
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/comprobante_correcto.xml');
    Assert(AnsiPos('version="2.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 2.2 para poder ejecutar la prueba');
    fComprobanteFiscal.XML:=sContenidoXML;

    // Ahora guardamos el archivo
    Randomize;
    sArchivo:=fDirTemporal + '/' + IntToStr(Random(9999999)) + '.xml';
    fComprobanteFiscal.GuardarEnArchivo(sArchivo);

    CheckTrue(FileExists(sArchivo), 'No se guardo el archivo XML del comprobante leido de una cadena XML');
end;

procedure TestTFEComprobanteFiscal.setXML_DeComprobanteExistente_EstablezcaLasPropiedadesCorrectamente;
var
    sContenidoXML: WideString;
    Certificado: TFECertificado;
    fComprobanteComparacion:  TFEComprobanteFiscal;

    procedure CompararDireccionContribuyente(Direccion1, Direccion2 : TFEDireccion; Nombre: String);
    begin
         CheckEquals(Direccion1.Calle,
                     Direccion2.Calle, 'La Calle del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.NoExterior ,
                     Direccion2.NoExterior, 'El No Ext del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.NoInterior ,
                     Direccion2.NoInterior, 'El No Interior del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.CodigoPostal ,
                     Direccion2.CodigoPostal, 'El CP de ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Colonia ,
                     Direccion2.Colonia, 'La Colonia del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Municipio ,
                     Direccion2.Municipio, 'El Municipio del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Estado ,
                     Direccion2.Estado, 'El Estado del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Pais ,
                     Direccion2.Pais, 'El Pais del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Localidad ,
                     Direccion2.Localidad, 'La Localidad del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Referencia ,
                     Direccion2.Referencia, 'La Referencia del ' + Nombre + 'no fue el mismo');
    end;

begin
    ConfigurarCertificadoDePrueba(Certificado);

    // Leemos el XML de nuestro Fixture en memoria
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/comprobante_correcto.xml');
    Assert(AnsiPos('version="2.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 2.2 para poder ejecutar la prueba');

    fComprobanteFiscal.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create;
    LeerXMLEnComprobante(fRutaFixtures + 'comprobante_fiscal/comprobante_correcto.xml',
                           Certificado, fComprobanteComparacion);

    // Comparamos algunas de sus propiedades las cuales deben de ser las mismas
    CheckEquals(fComprobanteComparacion.Folio, fComprobanteFiscal.Folio, 'Los folios no fueron los mismos');
    CheckEquals(fComprobanteComparacion.Serie, fComprobanteFiscal.Serie, 'La serie no fue la misma');
    CheckTrue(CompareDate(fComprobanteComparacion.FechaGeneracion,
                          fComprobanteFiscal.FechaGeneracion) = 0, 'Las fechas de generacion no fueron las mismas');

    CheckEquals(fComprobanteComparacion.BloqueFolios.NumeroAprobacion,
                fComprobanteFiscal.BloqueFolios.NumeroAprobacion, 'El num de aprobacion del certificado no fue el mismo');

    CheckEquals(fComprobanteComparacion.BloqueFolios.AnoAprobacion,
                fComprobanteFiscal.BloqueFolios.AnoAprobacion, 'El año de aprobacion no fue el mismo');

    CheckTrue(fComprobanteComparacion.Tipo = fComprobanteFiscal.Tipo, 'El tipo no fue el mismo');
    CheckTrue(fComprobanteComparacion.FormaDePago = fComprobanteFiscal.FormaDePago, 'La forma de pago no fue la misma');
    CheckEquals(fComprobanteComparacion.CondicionesDePago, fComprobanteFiscal.CondicionesDePago, 'Las condiciones de pago no fueron las mismas');
    CheckEquals(fComprobanteComparacion.Subtotal, fComprobanteFiscal.Subtotal, 'El subtotal no fue el mismo');
    CheckEquals(fComprobanteComparacion.Total, fComprobanteFiscal.Total, 'El total no fue el mismo');

    CheckEquals(fComprobanteComparacion.Emisor.RFC, fComprobanteFiscal.Emisor.RFC, 'El RFC del Emisor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Emisor.Nombre, fComprobanteFiscal.Emisor.Nombre, 'El Nombre del Emisor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Emisor.Direccion,
                                    fComprobanteFiscal.Emisor.Direccion, 'Emisor');

    CheckEquals(fComprobanteComparacion.Receptor.RFC, fComprobanteFiscal.Receptor.RFC, 'El RFC del Receptor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Receptor.Nombre, fComprobanteFiscal.Receptor.Nombre, 'El Nombre del Receptor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Receptor.Direccion,
                                    fComprobanteFiscal.Receptor.Direccion, 'Receptor');

    //Check(False,'Comparar lugar de expedicion');
    //Check(False,'Comparar metodo de pago');
    //Check(False,'Comparar regimenes');

    FreeAndNil(fComprobanteComparacion);
end;


procedure TestTFEComprobanteFiscal.XML_DeComprobanteHecho_GenereXMLCorrectamente;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := LeerXMLEnComprobante
    (fRutaFixtures + 'comprobante_fiscal/comprobante_correcto.xml',
    Certificado, fComprobanteFiscal);

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

  // Especificamos que NO incluya el certificado en el XML (esa es otra prueba independiente)
  fComprobanteFiscal.IncluirCertificadoEnXml:=False;
  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Certificado := Certificado;
  fComprobanteFiscal.AsignarContenidoCertificado;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLConNumSerieCertificado, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el numero de serie del certificado o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscal.setCertificado_IncluyendoEnXML_GuardeCertificadoBase64EnXML;
var
  Certificado: TFECertificado;
  sXMLConCertificado: WideString;
begin
  Certificado.Ruta := fRutaFixtures + _RUTA_CERTIFICADO;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConCertificado := leerContenidoDeFixture('comprobante_fiscal/con_certificado.xml');

  // Especificamos que Si incluya el certificado en el XML
  fComprobanteFiscal.IncluirCertificadoEnXml:=True;
  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Certificado := Certificado;
  fComprobanteFiscal.AsignarContenidoCertificado;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLConCertificado, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no incluyo el contenido del certificado o este es incorrecto.');
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

  // Establecemos el regimen fiscal (requerido) desde el CFD 2.2
  SetLength(Emisor.Regimenes, 1);
  Emisor.Regimenes[0]:='Persona Fisica con Actividades Empresariales';

  // Establecemos el emisor
  fComprobanteFiscal.Emisor := Emisor;
  fComprobanteFiscal.AsignarEmisor;

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
  fComprobanteFiscal.AsignarReceptor;

  // guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'comprobante_fiscal/receptor.xml');
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConReceptor := leerContenidoDeFixture('comprobante_fiscal/receptor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

procedure
    TestTFEComprobanteFiscal.setXML_DeComprobanteV2_EstablezcaLasPropiedadesCorrectamente;
var
    sContenidoXML: WideString;
    Certificado: TFECertificado;
    fComprobanteComparacion:  TFEComprobanteFiscal;

    procedure CompararDireccionContribuyente(Direccion1, Direccion2 : TFEDireccion; Nombre: String);
    begin
         CheckEquals(Direccion1.Calle,
                     Direccion2.Calle, 'La Calle del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.NoExterior ,
                     Direccion2.NoExterior, 'El No Ext del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.NoInterior ,
                     Direccion2.NoInterior, 'El No Interior del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.CodigoPostal ,
                     Direccion2.CodigoPostal, 'El CP de ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Colonia ,
                     Direccion2.Colonia, 'La Colonia del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Municipio ,
                     Direccion2.Municipio, 'El Municipio del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Estado ,
                     Direccion2.Estado, 'El Estado del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Pais ,
                     Direccion2.Pais, 'El Pais del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Localidad ,
                     Direccion2.Localidad, 'La Localidad del ' + Nombre + 'no fue el mismo');
         CheckEquals(Direccion1.Referencia ,
                     Direccion2.Referencia, 'La Referencia del ' + Nombre + 'no fue el mismo');
    end;

begin
    ConfigurarCertificadoDePrueba(Certificado);

    // Leemos el XML de nuestro Fixture en memoria
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/comprobante_ver2.0.xml');
    Assert(AnsiPos('version="2.0"', sContenidoXML) > 0,
          'El XML de la prueba tiene que ser un CFD 2.0');

    fComprobanteFiscal.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create;
    LeerXMLEnComprobante(fRutaFixtures + 'comprobante_fiscal/comprobante_ver2.0.xml',
                           Certificado, fComprobanteComparacion);

    // Comparamos algunas de sus propiedades las cuales deben de ser las mismas
    CheckTrue(fev20 = fComprobanteFiscal.fVersion, 'La version del CFD debio haber sido 2.0');
    CheckEquals(fComprobanteComparacion.Folio, fComprobanteFiscal.Folio, 'Los folios no fueron los mismos');
    CheckEquals(fComprobanteComparacion.Serie, fComprobanteFiscal.Serie, 'La serie no fue la misma');
    CheckTrue(CompareDate(fComprobanteComparacion.FechaGeneracion,
                          fComprobanteFiscal.FechaGeneracion) = 0, 'Las fechas de generacion no fueron las mismas');

    CheckEquals(fComprobanteComparacion.BloqueFolios.NumeroAprobacion,
                fComprobanteFiscal.BloqueFolios.NumeroAprobacion, 'El num de aprobacion del certificado no fue el mismo');

    CheckEquals(fComprobanteComparacion.BloqueFolios.AnoAprobacion,
                fComprobanteFiscal.BloqueFolios.AnoAprobacion, 'El año de aprobacion no fue el mismo');

    CheckTrue(fComprobanteComparacion.Tipo = fComprobanteFiscal.Tipo, 'El tipo no fue el mismo');
    CheckTrue(fComprobanteComparacion.FormaDePago = fComprobanteFiscal.FormaDePago, 'La forma de pago no fue la misma');
    CheckEquals(fComprobanteComparacion.CondicionesDePago, fComprobanteFiscal.CondicionesDePago, 'Las condiciones de pago no fueron las mismas');
    CheckEquals(fComprobanteComparacion.Subtotal, fComprobanteFiscal.Subtotal, 'El subtotal no fue el mismo');
    CheckEquals(fComprobanteComparacion.Total, fComprobanteFiscal.Total, 'El total no fue el mismo');

    CheckEquals(fComprobanteComparacion.Emisor.RFC, fComprobanteFiscal.Emisor.RFC, 'El RFC del Emisor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Emisor.Nombre, fComprobanteFiscal.Emisor.Nombre, 'El Nombre del Emisor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Emisor.Direccion,
                                    fComprobanteFiscal.Emisor.Direccion, 'Emisor');

    CheckEquals(fComprobanteComparacion.Receptor.RFC, fComprobanteFiscal.Receptor.RFC, 'El RFC del Receptor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Receptor.Nombre, fComprobanteFiscal.Receptor.Nombre, 'El Nombre del Receptor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Receptor.Direccion,
                                    fComprobanteFiscal.Receptor.Direccion, 'Receptor');

    FreeAndNil(fComprobanteComparacion);
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTFEComprobanteFiscal.Suite);

end.
