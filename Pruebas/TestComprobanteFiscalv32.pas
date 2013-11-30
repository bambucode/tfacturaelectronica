(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
unit TestComprobanteFiscalv32;

interface

uses
  TestFramework, ComprobanteFiscal, FacturaTipos, TestPrueba;

type

  TestTFEComprobanteFiscalV32 = class(TTestPrueba)
  strict private
    fComprobanteFiscalv32: TFEComprobanteFiscal;
  private
    procedure ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Create_NuevoComprobantev32_GenereEstructuraXMLBasica;
    procedure SelloDigital_DeMilConceptos_SeaCorrecto;
    procedure setBloqueFolios_Bloque_LoGuardeEnXML;
    procedure setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
    procedure CadenaOriginal_DeComprobanteV32_SeaCorrecta;
    procedure SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
    procedure SelloDigital_DeComprobante_SeaCorrecto;
    procedure getXML_DeComprobanteV32_GenereXMLCorrectamente;
    procedure setXML_DeComprobanteV32_EstablezcaLasPropiedadesCorrectamente;
  end;

implementation

uses
  Windows, SysUtils, Classes, ConstantesFixtures, dialogs,
  DateUtils, XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd, FeCFD, FeCFDv22, FeCFDv32, FeCFDv2,
  UtileriasPruebas;

procedure TestTFEComprobanteFiscalV32.SetUp;
begin
  inherited;
  fComprobanteFiscalv32 := TFEComprobanteFiscal.Create(fev32);
end;

procedure TestTFEComprobanteFiscalV32.TearDown;
begin
  FreeAndNil(fComprobanteFiscalv32);
end;

procedure TestTFEComprobanteFiscalV32.setBloqueFolios_Bloque_LoGuardeEnXML;
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
  fComprobanteFiscalv32.Folio:=1;
  fComprobanteFiscalv32.BloqueFolios := Bloque;
  fComprobanteFiscalv32.AsignarDatosFolios;

  // guardarContenido(fComprobanteFiscalv32.fXmlComprobante.XML, 'comprobante_fiscal/bloque_folios.xml');
  CheckEquals(sXMLFixture, fComprobanteFiscalv32.fXmlComprobante.XML,
    'No se guardo el numero de aprobacion, serie y año de aprobacion en la estructura del XML');
end;

procedure TestTFEComprobanteFiscalV32.setBloqueFolios_FolioFueraDeRango_CauseExcepcion;
var
  Bloque: TFEBloqueFolios;
  bHuboError: Boolean;
begin
  Bloque.FolioInicial := 1000;
  Bloque.FolioFinal := 2000;
  bHuboError := False;

  // Asignamos primero un Numero de Folio fuera del rango
  fComprobanteFiscalv32.Folio := Bloque.FolioInicial - 5;

  // Ahora, Asignamos el bloque de folios
  try
    fComprobanteFiscalv32.BloqueFolios := Bloque;
  except
    On EFEFolioFueraDeRango do
      bHuboError := True;
  end;

  CheckEquals(True, bHuboError,
    'No se lanzo la excepcion al asignar un folio fuera del rango especificado en la propiedad BloqueFolios');
end;

procedure TestTFEComprobanteFiscalV32.ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
const
  _MICROE_ARCHIVO_CERTIFICADO = 'comprobante_fiscal\aaa010101aaa_csd_01.cer';
  _MICROE_ARCHIVO_LLAVE_PRIVADA = 'comprobante_fiscal\aaa010101aaa_csd_01.key';
  _MICROE_CLAVE_LLAVE_PRIVADA = '12345678a';
begin
  Certificado.Ruta := fRutaFixtures + _MICROE_ARCHIVO_CERTIFICADO;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _MICROE_ARCHIVO_LLAVE_PRIVADA;
  Certificado.LlavePrivada.Clave := _MICROE_CLAVE_LLAVE_PRIVADA;
end;

procedure
    TestTFEComprobanteFiscalV32.CadenaOriginal_DeComprobanteV32_SeaCorrecta;
var
  sCadenaOriginalCorrecta: TStringCadenaOriginal;
  Certificado: TFECertificado;

  // Creamos una rutina especial para leer el archivo de cadena original de ejemplo
  // ya que viene en UTF8 y tiene que ser leida como tal para poder compararla
  function leerArchivoEnUTF8(sNombreFixture: String): WideString;
  var
    slArchivo: TStrings;
  begin
    Assert(FileExists(fRutaFixtures + sNombreFixture), 'No existe el archivo a leer');
    slArchivo := TStringList.Create;
    slArchivo.LoadFromFile(fRutaFixtures + sNombreFixture);
    {$IF Compilerversion >= 20}
    Result:=Trim((slArchivo.Text));
    {$ELSE}
    Result:=Trim(UTF8Encode(slArchivo.Text));
    {$IFEND}
    FreeAndNil(slArchivo);
  end;

begin
  // Leemos la cadena original generada de ejemplo generada previamente con otra aplicacion
  sCadenaOriginalCorrecta := leerArchivoEnUTF8('comprobante_fiscal/v32/factura_cadena_original_utf8.txt');
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_cadena_original.xml',
                       Certificado,
                       fComprobanteFiscalv32);

  // Quitamos la cadena original y sellos del XML para re-calcularlos
  fComprobanteFiscalv32.FacturaGenerada:=False;
  fComprobanteFiscalv32.fCadenaOriginalCalculada:='';
  fComprobanteFiscalv32.fSelloDigitalCalculado:='';

  // Comparamos el resultado del metodo de la clase con el del archivo codificado con la funcion
  CheckEquals(sCadenaOriginalCorrecta,
              fComprobanteFiscalv32.CadenaOriginal,
              'La cadena original no fue generada correctamente');
end;


procedure TestTFEComprobanteFiscalV32.SelloDigital_DeMilConceptos_SeaCorrecto;
var
     sSelloDigitalDelXML, sSelloCalculado: String;
     Certificado: TFECertificado;
begin
      ConfigurarCertificadoDePrueba(Certificado);

      // Leemos el comprobante del XML (que no tiene conceptos)
      sSelloDigitalDelXML := LeerXMLDePruebaEnComprobante(fRutaFixtures +
                              'comprobante_fiscal/comprobante_para_sello_digital_con_mil_conceptos.xml',
                              Certificado,
                              fComprobanteFiscalv32);

     // Quitamos la cadena original y sellos del XML para re-calcularlos
     fComprobanteFiscalv32.FacturaGenerada:=False;
     fComprobanteFiscalv32.fCadenaOriginalCalculada:='';
     fComprobanteFiscalv32.fSelloDigitalCalculado:='';

     // Mandamos calcular el sello digital del XML el cual ya tiene mil artículos
     sSelloCalculado:=fComprobanteFiscalv32.SelloDigital;

     // Verificamos que el sello sea correcto
     CheckEquals(sSelloDigitalDelXML,
                 sSelloCalculado,
                 'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscalV32.SelloDigital_DeComprobante_SeaCorrecto;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  sSelloDigitalCorrecto := LeerXMLDePruebaEnComprobante
    (fRutaFixtures + 'comprobante_fiscal/comprobante_para_sello_digital.xml',
    Certificado, fComprobanteFiscalv32);

  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscalv32.SelloDigital,
              'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscalV32.SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/comprobante_para_sello_digital.xml',
                           Certificado, fComprobanteFiscalv32);

  // Establecemos la propiedad de DEBUG solamente para que use la fecha/hora actual
  // para la generacion del comprobante y corroborar este funcionamiento
  fComprobanteFiscalv32._USAR_HORA_REAL := True;

  // Obtenemos el sello por primera vez...
  sSelloDigitalCorrecto:=fComprobanteFiscalv32.SelloDigital;

  // Nos esperamos 2 segundos (para forzar que la fecha de generacion sea diferente)
  Sleep(2500);

  // Verificamos obtener el sello digital de nuevo y que sea el mismo
  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscalv32.SelloDigital,
              'El sello digital no fue calculado correctamente la segunda ocasion');
end;

procedure
    TestTFEComprobanteFiscalV32.setXML_DeComprobanteV32_EstablezcaLasPropiedadesCorrectamente;
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
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/v32/comprobante_correcto.xml');
    Assert(AnsiPos('version="3.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 3.2 para poder ejecutar la prueba');

    fComprobanteFiscalv32.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create(fev22);
    LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_correcto.xml',
                           Certificado, fComprobanteComparacion);

    // Comparamos algunas de sus propiedades las cuales deben de ser las mismas
    CheckEquals(fComprobanteComparacion.Folio, fComprobanteFiscalv32.Folio, 'Los folios no fueron los mismos');
    CheckEquals(fComprobanteComparacion.Serie, fComprobanteFiscalv32.Serie, 'La serie no fue la misma');
    CheckTrue(CompareDate(fComprobanteComparacion.FechaGeneracion,
                          fComprobanteFiscalv32.FechaGeneracion) = 0, 'Las fechas de generacion no fueron las mismas');

    CheckTrue(fComprobanteComparacion.Tipo = fComprobanteFiscalv32.Tipo, 'El tipo no fue el mismo');
    CheckTrue(fComprobanteComparacion.FormaDePago = fComprobanteFiscalv32.FormaDePago, 'La forma de pago no fue la misma');
    CheckEquals(fComprobanteComparacion.CondicionesDePago, fComprobanteFiscalv32.CondicionesDePago, 'Las condiciones de pago no fueron las mismas');
    CheckEquals(fComprobanteComparacion.Subtotal, fComprobanteFiscalv32.Subtotal, 'El subtotal no fue el mismo');
    CheckEquals(fComprobanteComparacion.Total, fComprobanteFiscalv32.Total, 'El total no fue el mismo');

    CheckEquals(fComprobanteComparacion.Emisor.RFC, fComprobanteFiscalv32.Emisor.RFC, 'El RFC del Emisor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Emisor.Nombre, fComprobanteFiscalv32.Emisor.Nombre, 'El Nombre del Emisor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Emisor.Direccion,
                                    fComprobanteFiscalv32.Emisor.Direccion, 'Emisor');

    CheckEquals(fComprobanteComparacion.Receptor.RFC, fComprobanteFiscalv32.Receptor.RFC, 'El RFC del Receptor no fue el mismo');
    CheckEquals(fComprobanteComparacion.Receptor.Nombre, fComprobanteFiscalv32.Receptor.Nombre, 'El Nombre del Receptor no fue el mismo');
    CompararDireccionContribuyente(fComprobanteComparacion.Receptor.Direccion,
                                    fComprobanteFiscalv32.Receptor.Direccion, 'Receptor');

    //Check(False,'Comparar lugar de expedicion');
    //Check(False,'Comparar metodo de pago');
    //Check(False,'Comparar regimenes');

    FreeAndNil(fComprobanteComparacion);
end;


procedure
    TestTFEComprobanteFiscalV32.getXML_DeComprobanteV32_GenereXMLCorrectamente;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  Check(False, 'Prueba vacia');
end;

procedure
    TestTFEComprobanteFiscalV32.Create_NuevoComprobantev32_GenereEstructuraXMLBasica;
var
  sXMLEncabezadoBasico: WideString;
  NuevoComprobante: TFEComprobanteFiscal;
begin
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLEncabezadoBasico := leerContenidoDeFixture('comprobante_fiscal/v32/nuevo.xml');
  NuevoComprobante := TFEComprobanteFiscal.Create(fev32);

  // Checamos que sea igual que nuestro Fixture...
  CheckEquals(sXMLEncabezadoBasico, fComprobanteFiscalv32.fXmlComprobante.XML,
    'El encabezado del XML basico para un comprobante no fue el correcto');

  FreeAndNil(NuevoComprobante);
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTFEComprobanteFiscalV32.Suite);

end.
