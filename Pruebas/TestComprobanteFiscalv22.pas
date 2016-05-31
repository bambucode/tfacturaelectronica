(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
unit TestComprobanteFiscalv22;

interface

uses
  TestFramework, ComprobanteFiscal, FacturaTipos, TestPrueba;

type

  TestTFEComprobanteFiscalV22 = class(TTestPrueba)
  strict private
    fComprobanteFiscal: TFEComprobanteFiscal;
  private
    procedure ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
  public
    procedure SetUp; override;
    procedure TearDown; override;
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
    procedure setSubtotal_Monto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoTrasladado_Impuesto_LoGuardeEnXML;
    procedure AgregarImpuestoRetenido_Varios_SumeSuTotal;
    procedure AgregarImpuestoTrasladado_Varios_SumeSuTotal;
    procedure CadenaOriginal_DeComprobante_SeaCorrecta;
    procedure SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
    procedure SelloDigital_DeComprobante_SeaCorrecto;
    procedure getXML_DeComprobanteHecho_GenereXMLCorrectamente;
    procedure setXML_DeComprobanteExistente_EstablezcaLasPropiedadesCorrectamente;
    procedure GuardarEnArchivo_ComprobanteDeXML_LoGuarde;
    procedure setSerie_Serie_LaGuardeEnXML;
    procedure setXML_DeComprobanteV2_EstablezcaLasPropiedadesCorrectamente;
  end;

implementation

uses
  Windows, SysUtils, Classes, ConstantesFixtures, dialogs,
  DateUtils, XmlDom, XMLIntf, Xml.win.MsXmlDom, XMLDoc,
  {$IFNDEF VER300}
  // Si estamos en Delphi 10 Seattle, este archivo ya no es necesario
  XSLProd,
  {$ENDIF}
  FeCFD, FeCFDv22, FeCFDv32, FeCFDv2,
  FacturacionHashes,
  UtileriasPruebas;

procedure TestTFEComprobanteFiscalV22.SetUp;
begin
  inherited;
  fComprobanteFiscal := TFEComprobanteFiscal.Create(fev22);
end;

procedure TestTFEComprobanteFiscalV22.TearDown;
begin
  FreeAndNil(fComprobanteFiscal);
end;

procedure TestTFEComprobanteFiscalV22.AgregarConcepto_Concepto_LoGuardeEnXML;
var
  Concepto: TFEConcepto;
  sXMLConcepto: WideString;
begin
  sXMLConcepto := leerContenidoDeFixture('comprobante_fiscal/v22/concepto.xml');

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

procedure TestTFEComprobanteFiscalV22.setBloqueFolios_Bloque_LoGuardeEnXML;
var
  sXMLFixture: WideString;
  Bloque: TFEBloqueFolios;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/bloque_folios.xml');

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

procedure TestTFEComprobanteFiscalV22.setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
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

procedure TestTFEComprobanteFiscalV22.setFolio_Folio_LoGuardeEnXML;
var
  sXMLFixture: WideString;
  Folio: TFEFolio;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/folio.xml');

  Folio := 12345678;
  fComprobanteFiscal.Folio := Folio;
  fComprobanteFiscal.AsignarFolio;

  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'No se guardo el Folio en la estructura del XML');
end;

procedure TestTFEComprobanteFiscalV22.setSerie_Serie_LaGuardeEnXML;
var
  sXMLFixture: WideString;
  Serie: TFESerie;
  bloqueFoliosPrueba: TFEBloqueFolios;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/serie.xml');

  bloqueFoliosPrueba.Serie := 'ABC';
  bloqueFoliosPrueba.NumeroAprobacion := 0;
  bloqueFoliosPrueba.AnoAprobacion := 0;

  fComprobanteFiscal.BloqueFolios := bloqueFoliosPrueba;
  fComprobanteFiscal.AsignarDatosFolios;

  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'No se guardo la serie en la estructura del XML');
end;

{
procedure TestTFEComprobanteFiscalV22.setTotal_Monto_LoGuardeEnXML;
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

procedure TestTFEComprobanteFiscalV22.setSubtotal_Monto_LoGuardeEnXML;
var
  sXMLFixture: WideString;
const
  _SUBTOTAL_COMPROBANTE = 1000;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/subtotal.xml');

  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.SubTotal := _SUBTOTAL_COMPROBANTE;
  fComprobanteFiscal.AsignarSubtotal;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLFixture, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el monto de subtotal o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscalV22.AgregarImpuestoRetenido_Impuesto_LoGuardeEnXML;
var
  ImpuestoRetenido: TFEImpuestoRetenido;
  TotalImpuestosAnterior: Currency;
  sXMLFixture: WideString;
begin
  ImpuestoRetenido.Nombre := 'ISR';
  ImpuestoRetenido.Importe := 1000;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/agregarimpuesto_retencion.xml');
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

procedure TestTFEComprobanteFiscalV22.AgregarImpuestoTrasladado_Impuesto_LoGuardeEnXML;
var
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  TotalImpuestosAnterior: Currency;
  sXMLFixture: WideString;
begin
  ImpuestoTrasladado.Nombre := 'IVA';
  ImpuestoTrasladado.Tasa := 16;
  ImpuestoTrasladado.Importe := 1000;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v22/agregarimpuesto_trasladado.xml');
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

procedure TestTFEComprobanteFiscalV22.AgregarImpuestoRetenido_Varios_SumeSuTotal;
var
  iCuantos, I: Integer;
  aImpuestos: Array of TFEImpuestoRetenido;
  dTotalImpuestos: Currency;
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

procedure TestTFEComprobanteFiscalV22.AgregarImpuestoTrasladado_Varios_SumeSuTotal;
var
  iCuantos, I: Integer;
  aImpuestos: Array of TFEImpuestoTrasladado;
  dTotalImpuestos: Currency;
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


procedure TestTFEComprobanteFiscalV22.ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
begin
  Certificado.Ruta := fRutaFixtures + _CERTIFICADO_PRUEBAS_SAT;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _LLAVE_PRIVADA_PRUEBAS_SAT;
  Certificado.LlavePrivada.Clave := _CLAVE_LLAVE_PRIVADA_PRUEBAS_SAT;
end;

procedure TestTFEComprobanteFiscalV22.CadenaOriginal_DeComprobante_SeaCorrecta;
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
  sCadenaOriginalCorrecta := leerArchivoEnUTF8('comprobante_fiscal/v22/factura_cadena_original_utf8.txt');
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v22/comprobante_cadena_original.xml',
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


procedure TestTFEComprobanteFiscalV22.SelloDigital_DeMilConceptos_SeaCorrecto;
var
     sSelloDigitalDelXML, sSelloCalculado: String;
     Certificado: TFECertificado;
begin
      ConfigurarCertificadoDePrueba(Certificado);

      // Leemos el comprobante del XML (que no tiene conceptos)
      sSelloDigitalDelXML := LeerXMLDePruebaEnComprobante(fRutaFixtures +
                              'comprobante_fiscal/v22/comprobante_para_sello_digital_con_mil_conceptos.xml',
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

procedure TestTFEComprobanteFiscalV22.SelloDigital_DeComprobante_SeaCorrecto;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := LeerXMLDePruebaEnComprobante
    (fRutaFixtures + 'comprobante_fiscal/v22/comprobante_para_sello_digital.xml',
    Certificado, fComprobanteFiscal);

  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscal.SelloDigital,
              'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscalV22.SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v22/comprobante_para_sello_digital.xml',
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

procedure TestTFEComprobanteFiscalV22.GuardarEnArchivo_ComprobanteDeXML_LoGuarde;
var
  sContenidoXML: UnicodeString;
  sArchivo: String;
begin
   // Leemos el XML de nuestro Fixture en memoria
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/v22/comprobante_correcto.xml');
    Assert(AnsiPos('version="2.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 2.2 para poder ejecutar la prueba');
    fComprobanteFiscal.XML:=sContenidoXML;

    // Ahora guardamos el archivo
    Randomize;
    sArchivo:=fDirTemporal + '/' + IntToStr(Random(9999999)) + '.xml';
    fComprobanteFiscal.GuardarEnArchivo(sArchivo);

    CheckTrue(FileExists(sArchivo), 'No se guardo el archivo XML del comprobante leido de una cadena XML');
end;

procedure TestTFEComprobanteFiscalV22.setXML_DeComprobanteExistente_EstablezcaLasPropiedadesCorrectamente;
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
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/v22/comprobante_correcto.xml');
    Assert(AnsiPos('version="2.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 2.2 para poder ejecutar la prueba');

    fComprobanteFiscal.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create(fev22);
    LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v22/comprobante_correcto.xml',
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


procedure
    TestTFEComprobanteFiscalV22.getXML_DeComprobanteHecho_GenereXMLCorrectamente;
var
  sSelloDigitalCorrecto, archivoComprobanteGuardado, hashComprobanteOriginal, hashComprobanteGuardado: String;
  archivoComprobantePrueba : string;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);
  archivoComprobantePrueba := fRutaFixtures + 'comprobante_fiscal/v22/comprobante_correcto.xml';

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := LeerXMLDePruebaEnComprobante(archivoComprobantePrueba,
                                                        Certificado, fComprobanteFiscal);

  // Calculamos el MD5 del comprobante original
  hashComprobanteOriginal := TFacturacionHashing.CalcularHashArchivo(archivoComprobantePrueba, haMD5);

  // Guardamos de nuevo el XML
  Randomize;
  archivoComprobanteGuardado := fDirTemporal + 'comprobante_prueba_' + IntToStr(Random(9999999999)) + '.xml';
  fComprobanteFiscal.GuardarEnArchivo(archivoComprobanteGuardado);
  hashComprobanteGuardado := TFacturacionHashing.CalcularHashArchivo(archivoComprobanteGuardado, haMD5);

  // Comprobamos el MD5 de ambos archivos para corroborar que tengan exactamente el mismo contenido
  CheckEquals(hashComprobanteOriginal,
              hashComprobanteGuardado,
              'El contenido del comprobante guardado fue difernete al original. Sus hashes MD5 fueron diferentes!');
end;

procedure TestTFEComprobanteFiscalV22.Create_NuevoComprobante_GenereEstructuraXMLBasica;
var
  sXMLEncabezadoBasico: WideString;
  NuevoComprobante: TFEComprobanteFiscal;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLEncabezadoBasico := leerContenidoDeFixture('comprobante_fiscal/v22/nuevo.xml');
  NuevoComprobante := TFEComprobanteFiscal.Create(fev22);

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLEncabezadoBasico, fComprobanteFiscal.fXmlComprobante.XML,
    'El encabezado del XML basico para un comprobante no fue el correcto');
  FreeAndNil(NuevoComprobante);
end;

procedure TestTFEComprobanteFiscalV22.setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
var
  Certificado: TFECertificado;
  sXMLConNumSerieCertificado: WideString;
begin
  Certificado.Ruta := fRutaFixtures + _RUTA_CERTIFICADO;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConNumSerieCertificado := leerContenidoDeFixture('comprobante_fiscal/v22/numeroserie.xml');

  // Indicamos que no queremos validar el certificado y la llave para que no falle por omision de la llave privada
  fComprobanteFiscal.ValidarCertificadoYLlavePrivada := False;

  // Especificamos que NO incluya el certificado en el XML (esa es otra prueba independiente)
  fComprobanteFiscal.IncluirCertificadoEnXml:=False;
  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Certificado := Certificado;
  fComprobanteFiscal.AsignarContenidoCertificado;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLConNumSerieCertificado, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no contiene el numero de serie del certificado o este es incorrecto.');
end;

procedure TestTFEComprobanteFiscalV22.setCertificado_IncluyendoEnXML_GuardeCertificadoBase64EnXML;
var
  Certificado: TFECertificado;
  sXMLConCertificado: WideString;
begin
  Certificado.Ruta := fRutaFixtures + _RUTA_CERTIFICADO;

  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConCertificado := leerContenidoDeFixture('comprobante_fiscal/v22/con_certificado.xml');

  // Indicamos que no queremos validar el certificado y la llave para que no falle por omision de la llave privada
  fComprobanteFiscal.ValidarCertificadoYLlavePrivada := False;

  // Especificamos que Si incluya el certificado en el XML
  fComprobanteFiscal.IncluirCertificadoEnXml:=True;
  // Especificamos el certificado que usaremos a la clase comprobante
  fComprobanteFiscal.Certificado := Certificado;
  fComprobanteFiscal.AsignarContenidoCertificado;

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLConCertificado, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML no incluyo el contenido del certificado o este es incorrecto.');
end;



procedure TestTFEComprobanteFiscalV22.setEmisor_Emisor_LoGuardeEnXML;
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
  sXMLConReceptor := leerContenidoDeFixture('comprobante_fiscal/v22/emisor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

procedure TestTFEComprobanteFiscalV22.setReceptor_Receptor_LoGuardeEnXML;
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
  sXMLConReceptor := leerContenidoDeFixture('comprobante_fiscal/v22/receptor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML,
    'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;



procedure
    TestTFEComprobanteFiscalV22.setXML_DeComprobanteV2_EstablezcaLasPropiedadesCorrectamente;
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
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/v22/comprobante_ver2.0.xml');
    Assert(AnsiPos('version="2.0"', sContenidoXML) > 0,
          'El XML de la prueba tiene que ser un CFD 2.0');

    fComprobanteFiscal.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create(fev20);
    LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v22/comprobante_ver2.0.xml',
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
RegisterTest(TestTFEComprobanteFiscalV22.Suite);

end.
