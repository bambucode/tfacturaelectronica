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
    fFechaEntradaVigenciaCatalogo : TDate;
  private
    procedure ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure CadenaOriginalDeTimbre_DeComprobanteV32_SeaCorrecta;
    procedure Create_NuevoComprobantev32_GenereEstructuraXMLBasica;
    procedure SelloDigital_DeMilConceptos_SeaCorrecto;
    procedure CadenaOriginal_DeComprobanteV32_SeaCorrecta;
    procedure SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
    procedure SelloDigital_DeComprobante_SeaCorrecto;
    procedure GuardarEnArchivo_DeComprobanteTimbrado_GenereXMLIgualAlLeido;
    procedure setXML_DeComprobanteTimbrado_AsignePropiedadesDelTimbre;
    procedure setXML_DeComprobanteV32_EstablezcaLasPropiedadesCorrectamente;
    procedure setXML_DeComprobanteConImpuestosLocales_EstablezcaImpuestosCorrectamente;
    procedure AgregarImpuestoLocal_Retenido_LoGuardeEnXML;
    procedure AgregarImpuestoLocal_Trasladado_LoGuardeEnXML;
    procedure Importe_DeCantidadesConMuchosDecimales_SeaElCorrecto;
    procedure MetodoDePago_CadenaEfectivo_ConviertaANumero;
    procedure MetodoDePago_CadenaEfectivo_FechaMenorACambioCatalogoLaDejeIgual;
    procedure MetodoDePago_EspecificandoNumero_LoDejeIgual;
    procedure MetodoDePago_Inexistente_GenereExcepcion;
    procedure MetodoDePago_MenorADiez_AgregueCeroAlPrincipio;
    procedure MetodoDePago_VariosMetodosNumericos_LosDejeIntactos;
    procedure MetodoDePago_VariosMetodos_ConviertaAlCatalogoCorrectamente;
    procedure SelloDigital_ConConfiguracionDecimalIncorrecta_NoFalle;
    procedure setSerie_Serie_LaGuardeEnXML;
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
  {$IFDEF CODESITE}
  CodeSiteLogging,
  {$ENDIF}
  FacturaReglamentacion,
  UtileriasPruebas,
  System.Math;

procedure
    TestTFEComprobanteFiscalV32.CadenaOriginalDeTimbre_DeComprobanteV32_SeaCorrecta;
var
  Certificado: TFECertificado;
  cadenaOriginalDeTimbreEsperada: TStringCadenaOriginal;
begin
  ConfigurarCertificadoDePrueba(Certificado);
  cadenaOriginalDeTimbreEsperada := leerArchivoEnUTF8(fRutaFixtures + 'comprobante_fiscal/v32/factura_cadena_original_de_timbre.txt');

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_timbrado.xml',
                               Certificado,
                               fComprobanteFiscalv32);

  // Quitamos la cadena original y sellos del XML para re-calcularlos
  fComprobanteFiscalv32.FacturaGenerada:=False;
  fComprobanteFiscalv32.fCadenaOriginalCalculada:='';
  fComprobanteFiscalv32.fSelloDigitalCalculado:='';

  // Comparamos el resultado del metodo de la clase con el del archivo codificado con la funcion
  CheckEquals(cadenaOriginalDeTimbreEsperada,
             fComprobanteFiscalv32.CadenaOriginalTimbre,
             'La cadena original del timbre no fue generada correctamente');
end;

procedure TestTFEComprobanteFiscalV32.SetUp;
begin
  inherited;
  fComprobanteFiscalv32 := TFEComprobanteFiscal.Create(fev32);

    // Especificamos la cadena de efectivo
  fFechaEntradaVigenciaCatalogo := EncodeDate(_ANO_CAMBIO_METODO_PAGO,
                                              _MES_CAMBIO_METODO_PAGO,
                                              _DIA_CAMBIO_METODO_PAGO);

end;

procedure TestTFEComprobanteFiscalV32.TearDown;
begin
  FreeAndNil(fComprobanteFiscalv32);
end;

procedure TestTFEComprobanteFiscalV32.ConfigurarCertificadoDePrueba(var Certificado: TFECertificado);
begin
  Certificado.Ruta := fRutaFixtures + _CERTIFICADO_PRUEBAS_SAT;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _LLAVE_PRIVADA_PRUEBAS_SAT;
  Certificado.LlavePrivada.Clave := _CLAVE_LLAVE_PRIVADA_PRUEBAS_SAT;
end;

procedure
    TestTFEComprobanteFiscalV32.CadenaOriginal_DeComprobanteV32_SeaCorrecta;
var
  sCadenaOriginalCorrecta: TStringCadenaOriginal;
  Certificado: TFECertificado;

begin
  // Leemos la cadena original generada de ejemplo generada previamente con otra aplicacion
  sCadenaOriginalCorrecta := leerArchivoEnUTF8(fRutaFixtures + 'comprobante_fiscal/v32/factura_cadena_original_utf8.txt');
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

procedure TestTFEComprobanteFiscalV32.AgregarImpuestoLocal_Retenido_LoGuardeEnXML;
var
  xmlFixture: WideString;
  totalImpuestosLocalesRetenidosAnterior: Currency;
  nuevoImpuestoLocal: TFEImpuestoLocal;
begin
  xmlFixture := leerContenidoDeFixture('comprobante_fiscal/v32/agregarimpuestolocal_retenido.xml');

  totalImpuestosLocalesRetenidosAnterior := fComprobanteFiscalv32.TotalImpuestosLocalesRetenidos;

  nuevoImpuestoLocal.Nombre := 'ISH';
  nuevoImpuestoLocal.Tasa := 3;
  nuevoImpuestoLocal.Importe := 100;
  nuevoImpuestoLocal.Tipo := tiRetenido;

  //**********************************************
  fComprobanteFiscalv32.AgregarImpuestoLocal(nuevoImpuestoLocal);
  fComprobanteFiscalv32.AsignarImpuestosLocales;

  {$IFDEF CODESITE}
  Codesite.Send('XML', fComprobanteFiscalv32.fXmlComprobante.XML);
  {$ENDIF}

  CheckEquals(xmlFixture,
              fComprobanteFiscalv32.fXmlComprobante.XML,
              'El contenido XML del comprobante no incluyo los impuestos retenidos locales correctamente');

  CheckEquals(totalImpuestosLocalesRetenidosAnterior + nuevoImpuestoLocal.Importe,
              fComprobanteFiscalv32.TotalImpuestosLocalesRetenidos,
              'El total de los impuestos locales retenidos no se le sumo el total del nuevo impuesto local');
end;

procedure
    TestTFEComprobanteFiscalV32.AgregarImpuestoLocal_Trasladado_LoGuardeEnXML;
var
  xmlFixture: WideString;
  totalImpuestosLocalesTrasladadosAnterior: Currency;
  nuevoImpuestoLocal: TFEImpuestoLocal;
begin
  xmlFixture := leerContenidoDeFixture('comprobante_fiscal/v32/agregarimpuestolocal_trasladado.xml');

  totalImpuestosLocalesTrasladadosAnterior := fComprobanteFiscalv32.TotalImpuestosLocalesTrasladados;

  nuevoImpuestoLocal.Nombre := 'IVA';
  nuevoImpuestoLocal.Tasa := 16;
  nuevoImpuestoLocal.Importe := 100;
  nuevoImpuestoLocal.Tipo := tiTrasladado;

  //**********************************************
  fComprobanteFiscalv32.AgregarImpuestoLocal(nuevoImpuestoLocal);
  fComprobanteFiscalv32.AsignarImpuestosLocales;

  {$IFDEF CODESITE}
  Codesite.Send('XML', fComprobanteFiscalv32.fXmlComprobante.XML);
  {$ENDIF}

  CheckEquals(xmlFixture,
              fComprobanteFiscalv32.fXmlComprobante.XML,
              'El contenido XML del comprobante no incluyo los impuestos trasladados locales correctamente');

  CheckEquals(totalImpuestosLocalesTrasladadosAnterior + nuevoImpuestoLocal.Importe,
              fComprobanteFiscalv32.TotalImpuestosLocalesTrasladados,
              'El total de los impuestos locales trasladados no se le sumo el total del nuevo impuesto local');
end;

procedure TestTFEComprobanteFiscalV32.SelloDigital_DeMilConceptos_SeaCorrecto;
var
     sSelloDigitalDelXML, sSelloCalculado: String;
     Certificado: TFECertificado;
begin
      ConfigurarCertificadoDePrueba(Certificado);

      // Leemos el comprobante del XML (que no tiene conceptos)
      sSelloDigitalDelXML := LeerXMLDePruebaEnComprobante(fRutaFixtures +
                              'comprobante_fiscal/v32/comprobante_para_sello_digital_con_mil_conceptos.xml',
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
    (fRutaFixtures + 'comprobante_fiscal/v32/comprobante_para_sello_digital.xml',
    Certificado, fComprobanteFiscalv32);

  CheckEquals(sSelloDigitalCorrecto, fComprobanteFiscalv32.SelloDigital,
              'El sello digital no fue calculado correctamente');
end;

procedure TestTFEComprobanteFiscalV32.SelloDigital_ConConfiguracionDecimalIncorrecta_NoFalle;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
  textoFalla: String;
  separadorDecimalAnterior: Char;
  xmlFacturaGenerada: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  {$IFDEF VER300}
  // A partir de Delphi Seattle es necesario usar esta constante
  formatSettings : TFormatSettings;
  {$ENDIF}
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Intentamos generar el sello
  {$IFDEF VER300}
  with formatSettings do
  begin
  {$ENDIF}
    try
      // Llenamos el comprobante fiscal con datos usados para generar la factura
      LeerXMLDePruebaEnComprobante(fRutaFixtures +
                                  'comprobante_fiscal/v32/comprobante_con_impuestos_locales.xml',
                                  Certificado, fComprobanteFiscalv32);

      textoFalla := '';
      // Creamos un comprobante para leer el XML generado con el decimal incorrecto
      comprobanteNuevo := TFEComprobanteFiscal.Create();
      try
        // Leemos el XML generado con la configuracion de "DecimalSeparator" incorrecta
        // Configuramos el decimal para que sea incorrecto forzosamente
        separadorDecimalAnterior := DecimalSeparator;
        DecimalSeparator := ',';
        xmlFacturaGenerada := fComprobanteFiscalv32.XML;
        DecimalSeparator := '.';
        xmlFacturaGenerada := fComprobanteFiscalv32.XML;
        // Lo intemos leer en un nuevo comprobante
        comprobanteNuevo.XML := xmlFacturaGenerada;
      except
        on E:Exception do
          textoFalla := E.Message;
      end;
    finally
      DecimalSeparator := separadorDecimalAnterior;
      comprobanteNuevo.Free;
    end;

  {$IFDEF VER300}
  end;
  {$ENDIF}

  CheckEquals('',
              textoFalla,
             'No debio haber fallado al usar una configuracion decimal incorrecta');
end;

procedure TestTFEComprobanteFiscalV32.SelloDigital_DespuesDeVariosSegundos_SeaElMismo;
var
  sSelloDigitalCorrecto: String;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Llenamos el comprobante fiscal con datos usados para generar la factura
  LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_para_sello_digital.xml',
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
    TestTFEComprobanteFiscalV32.setXML_DeComprobanteTimbrado_AsignePropiedadesDelTimbre;
var
  contenidoXML: WideString;
  Certificado: TFECertificado;
const
  // ToDo: Leer estas propiedades de forma alternativa desde el XML de prueba para no tenerlas fijas
  // y pode cambiar el XML de prueba facilmente
  _TIMBRE_VERSION = '1.0';
  _TIMBRE_SELLO_SAT = 'JFZQYjO+ta+R/gH+w7lqunZLzHNeqYWGQvcvJ+Dbvuk6KTCQgvkTP5tIKzqS7v4tXu1o1Rs6u+8p1Uo4jg4LZqvjZUbT14ZYzgE78wlVwz1aJFohHFRB9L4Fh1bcgqgYaJW+62npRq5Lt8EZanKnAdlxAdOHgTgyIzP/6jFtosM=';
  _TIMBRE_NOCERTIFICADO_SAT = '20001000000100005868';
  _TIMBRE_UUID = '64A89088-CFD7-42C1-8ABE-F0BDCFA85EB8';
  _TIMBRE_FECHA = '2016-03-14T12:14:20';
begin
    ConfigurarCertificadoDePrueba(Certificado);

    // Leemos un CFDI ya timbrado
    contenidoXML := leerContenidoDeFixture('comprobante_fiscal/v32/comprobante_timbrado.xml');

    //*** Asignamos el XML al comprobante **
    fComprobanteFiscalv32.XML:=UTF8ToString(contenidoXML);

    // Verificamos que se haya asignado la propiedad del XML correctamente
    CheckEquals(_TIMBRE_VERSION,
                 fComprobanteFiscalv32.Timbre.Version,
                'La version del timbrado del CFDI fue diferente!');

     CheckEquals(_TIMBRE_SELLO_SAT,
                 fComprobanteFiscalv32.Timbre.SelloSAT,
                'El sello del SAT del timbre no fue el correcto');

     CheckEquals(_TIMBRE_NOCERTIFICADO_SAT,
                 fComprobanteFiscalv32.Timbre.NoCertificadoSAT,
                'El No Certificado del SAT no fue el correcto');

     CheckEquals(_TIMBRE_UUID,
                 fComprobanteFiscalv32.Timbre.UUID,
                'El UUID del timbre no fue el correcto');

     CheckEquals(_TIMBRE_FECHA,
                 TFeReglamentacion.ComoFechaHora(fComprobanteFiscalv32.Timbre.FechaTimbrado),
                'La fecha del timbrado no fue correcta');

     CheckNotEquals('',
                  fComprobanteFiscalv32.Timbre.XML,
                  'El XML del timbre fue vacio!');
end;

procedure TestTFEComprobanteFiscalV32.setXML_DeComprobanteConImpuestosLocales_EstablezcaImpuestosCorrectamente;
var
  contenidoXML: WideString;
  Certificado: TFECertificado;
  fComprobanteComparacion:  TFEComprobanteFiscal;
begin
  ConfigurarCertificadoDePrueba(Certificado);

  // Leemos el XML de nuestro Fixture en memoria
  contenidoXML := leerContenidoDeFixture('comprobante_fiscal/v32/comprobante_con_impuestos_locales.xml');

  // Leemos el XML en nuestro comprobante
  fComprobanteFiscalv32.XML:=UTF8ToString(contenidoXML);

  // Corroboramos tener los impuestos configurados correctamente
  CheckTrue(Length(fComprobanteFiscalv32.ImpuestosLocales) > 0,
            'Se debio de haber tenido al menos 1 impuesto local');
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
    sContenidoXML := leerContenidoDeFixture('comprobante_fiscal/v32/comprobante_timbrado.xml');
    Assert(AnsiPos('version="3.2"', sContenidoXML) > 0,
          'El XML de pruebas tiene que ser un CFD 3.2 para poder ejecutar la prueba');

    fComprobanteFiscalv32.XML:=UTF8ToString(sContenidoXML);

    // Leemos el comprobante de ejemplo con el metodo alternativo usado en las pruebas
    fComprobanteComparacion:=TFEComprobanteFiscal.Create(fev32);
    LeerXMLDePruebaEnComprobante(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_timbrado.xml',
                           Certificado, fComprobanteComparacion);

    // Comparamos algunas de sus propiedades las cuales deben de ser las mismas
    CheckEquals(fComprobanteComparacion.Folio, fComprobanteFiscalv32.Folio, 'Los folios no fueron los mismos');
    CheckEquals(fComprobanteComparacion.Serie, fComprobanteFiscalv32.Serie, 'La serie no fue la misma');
    CheckTrue(CompareDate(fComprobanteComparacion.FechaGeneracion,
                          fComprobanteFiscalv32.FechaGeneracion) = 0, 'Las fechas de generacion no fueron las mismas');

    CheckTrue(fComprobanteComparacion.Tipo = fComprobanteFiscalv32.Tipo, 'El tipo no fue el mismo');
    CheckTrue(fComprobanteComparacion.FormaDePago = fComprobanteFiscalv32.FormaDePago, 'La forma de pago no fue la misma');
    CheckEquals(fComprobanteComparacion.CondicionesDePago, fComprobanteFiscalv32.CondicionesDePago, 'Las condiciones de pago no fueron las mismas');

    CheckEquals( RoundTo(fComprobanteComparacion.Subtotal, -2),
          fComprobanteFiscalv32.Subtotal, 'El subtotal no fue el mismo');
    CheckEquals( RoundTo(fComprobanteComparacion.Total, -2),
          fComprobanteFiscalv32.Total, 'El total no fue el mismo');

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
    TestTFEComprobanteFiscalV32.GuardarEnArchivo_DeComprobanteTimbrado_GenereXMLIgualAlLeido;
var
  sSelloDigitalCorrecto, archivoComprobanteGuardado, hashComprobanteOriginal, hashComprobanteGuardado: String;
  archivoComprobantePrueba : string;
  Certificado: TFECertificado;
begin
  ConfigurarCertificadoDePrueba(Certificado);
  archivoComprobantePrueba := fRutaFixtures + 'comprobante_fiscal/v32/comprobante_timbrado.xml';

  // Leemos el CFDI de pruebas ya timbrado
  sSelloDigitalCorrecto := LeerXMLDePruebaEnComprobante(archivoComprobantePrueba,
                                                        Certificado, fComprobanteFiscalV32);

  // Calculamos el MD5 del comprobante original
  hashComprobanteOriginal := TFacturacionHashing.CalcularHashArchivo(archivoComprobantePrueba, haMD5);

  // ****** Guardamos de nuevo el XML *********
  Randomize;
  archivoComprobanteGuardado := fDirTemporal + 'comprobante_prueba_v32_' + IntToStr(Random(9999999999)) + '.xml';
  fComprobanteFiscalV32.GuardarEnArchivo(archivoComprobanteGuardado);
  hashComprobanteGuardado := TFacturacionHashing.CalcularHashArchivo(archivoComprobanteGuardado, haMD5);

  // Comprobamos el MD5 de ambos archivos para corroborar que tengan exactamente el mismo contenido
  CheckEquals(hashComprobanteOriginal,
              hashComprobanteGuardado,
              'El contenido del comprobante v3.2 guardado fue difernete al original. Sus hashes MD5 fueron diferentes!');
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

procedure TestTFEComprobanteFiscalV32.Importe_DeCantidadesConMuchosDecimales_SeaElCorrecto;
var
  xmlDeComprobante: WideString;
  comprobanteNuevo, comprobanteGuardado: TFEComprobanteFiscal;
  importeEsperado, importeCalculado : Currency;
  archivoComprobanteGuardado: String;
  conceptoConCantidadesConMuchosDecimales : TFEConcepto;
  Certificado: TFECertificado;
begin
  xmlDeComprobante := leerContenidoDeFixture('comprobante_fiscal/v32/comprobante_timbrado.xml');

  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  comprobanteNuevo.XML:=UTF8ToString(xmlDeComprobante);

  // Configuramos el certificado de prueba
  Certificado.Ruta := fRutaFixtures + _RUTA_CERTIFICADO;
  Certificado.LlavePrivada.Ruta := fRutaFixtures + _LLAVE_PRIVADA_PRUEBAS_SAT;
  Certificado.LlavePrivada.Clave := _CLAVE_LLAVE_PRIVADA_PRUEBAS_SAT;
  comprobanteNuevo.Certificado := Certificado;
  comprobanteNuevo.ValidarCertificadoYLlavePrivada := False;

  // Eliminamos los conceptos del comprobante leido
  comprobanteNuevo.BorrarConceptos;

  try
    // Agregamos un concepto con cantidad y precio a granel para forzar que se calcule un importe con mas de 6 decimales de exactitud
    conceptoConCantidadesConMuchosDecimales.Cantidad := 0.12;
    conceptoConCantidadesConMuchosDecimales.Unidad := 'PZA';
    conceptoConCantidadesConMuchosDecimales.Descripcion := 'Articulo de Prueba';
    conceptoConCantidadesConMuchosDecimales.ValorUnitario := 129.9876;
    conceptoConCantidadesConMuchosDecimales.NoIdentificacion := '1';

    importeEsperado := conceptoConCantidadesConMuchosDecimales.Cantidad * conceptoConCantidadesConMuchosDecimales.ValorUnitario;

    comprobanteNuevo.AgregarConcepto(conceptoConCantidadesConMuchosDecimales);

    // Generamos el archivo
    Randomize;
    archivoComprobanteGuardado := fDirTemporal + 'comprobante_cantidad_v32_' + IntToStr(Random(9999999999)) + '.xml';
    comprobanteNuevo.GuardarEnArchivo(archivoComprobanteGuardado);

    // Leemos el XML recien generado para leer la cantidad y precio directo de los conceptos XML
    xmlDeComprobante := leerContenidoDeArchivo(archivoComprobanteGuardado);
    comprobanteGuardado := TFEComprobanteFiscal.Create(fev32);
    comprobanteGuardado.XML:=UTF8ToString(xmlDeComprobante);

    // Calculamos el importe segun la cantidad y valor unitario leidos del nodo concepto del XML
    importeCalculado := comprobanteGuardado.Conceptos[0].Cantidad * comprobanteGuardado.Conceptos[0].ValorUnitario;

    CheckTrue(Length(comprobanteGuardado.Conceptos) > 0,
              'El comprobante recien guardado debio haber tenido conceptos');

    // Checamos que el importe esperado sea el correcto
    CheckEquals(importeEsperado,
                importeCalculado,
                'El importe del concepto no fue calculado correctamente. Verificar que CANTIDAD y PRECIO se guardaran correctamente en XML');
  finally
     FreeAndNil(comprobanteNuevo);
  end;
end;

procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_CadenaEfectivo_ConviertaANumero;
var
  xmlGenerado, cadenaEsperada: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  fechaGeneracionComprobante: TDate;
const
  _CADENA_EFECTIVO = 'EfeCtivO';
  _NUMERO_METODO_EFECTIVO = '01';
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);

  comprobanteNuevo.FechaGeneracion := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;
  comprobanteNuevo.MetodoDePago := _CADENA_EFECTIVO;
  comprobanteNuevo.AsignarMetodoDePago;

  // Checamos que se haya incluido el numero de catalogo de "Efectivo" y no dicha cadena
  xmlGenerado := comprobanteNuevo.fXmlComprobante.XML;

  cadenaEsperada := 'metodoDePago="' + _NUMERO_METODO_EFECTIVO + '"';
  CheckTrue(AnsiPos(cadenaEsperada, xmlGenerado) > 0,
            'No se incluyo el número de método de pago para Efectivo:' + _NUMERO_METODO_EFECTIVO);
end;


procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_VariosMetodos_ConviertaAlCatalogoCorrectamente;
var
  xmlGenerado, cadenaEsperada, cadenaObtenida: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  fechaGeneracionComprobante: TDate;
const
  _CADENA_XML_METODO_PAGO       = 'metodoDePago="';
  _CADENA_VARIOS                = 'Efectivo,    Tarjeta de credito, Vales, Otros';
  _NUMERO_METODO_PAGO_ESPERADOS = '01,04,08,99';
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);

  comprobanteNuevo.FechaGeneracion            := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;
  comprobanteNuevo.MetodoDePago               := _CADENA_VARIOS;
  comprobanteNuevo.AsignarMetodoDePago;

  // Checamos que se haya incluido el numero de catalogo de "Efectivo" y no dicha cadena
  xmlGenerado := comprobanteNuevo.fXmlComprobante.XML;

  cadenaEsperada := _CADENA_XML_METODO_PAGO + _NUMERO_METODO_PAGO_ESPERADOS + '"';
  cadenaObtenida := _CADENA_XML_METODO_PAGO + Copy(xmlGenerado,
                                                   AnsiPos(_CADENA_XML_METODO_PAGO, string(xmlGenerado)) + Length(_CADENA_XML_METODO_PAGO),
                                                   Length(_NUMERO_METODO_PAGO_ESPERADOS) + 1);

  CheckEquals(cadenaEsperada,
              cadenaObtenida,
              'No se convirtió la cadena de metodos de pago a sus equivalentes del catálogo:' + _NUMERO_METODO_PAGO_ESPERADOS);
end;

procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_CadenaEfectivo_FechaMenorACambioCatalogoLaDejeIgual;
var
  comprobanteNuevo: TFEComprobanteFiscal;
  fechaPreviaAEntradaCatalogo : TDate;
  cadenaEsperada: String;
const
  _CADENA_INVENTADA_METODO_PAGO = 'Efectivo y Cheque';
begin
  fechaPreviaAEntradaCatalogo := EncodeDate(_ANO_CAMBIO_METODO_PAGO,
                                            _MES_CAMBIO_METODO_PAGO,
                                            _DIA_CAMBIO_METODO_PAGO - 1);

  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  comprobanteNuevo.FechaGeneracion := fechaPreviaAEntradaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;
  try
    comprobanteNuevo.MetodoDePago := _CADENA_INVENTADA_METODO_PAGO;

    comprobanteNuevo.AsignarMetodoDePago;

    cadenaEsperada := 'metodoDePago="' + _CADENA_INVENTADA_METODO_PAGO + '"';
    CheckTrue(AnsiPos(cadenaEsperada, comprobanteNuevo.fXmlComprobante.XML) > 0,
              'No se respeto la cadena de metodo de pago previo a catalogo: ' + _CADENA_INVENTADA_METODO_PAGO);
  finally
    comprobanteNuevo.Free;
  end;
end;

procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_EspecificandoNumero_LoDejeIgual;
var
  xmlGenerado, cadenaEsperada: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  numeroInventado: Integer;
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  comprobanteNuevo.FechaGeneracion := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;

  Randomize;

  // Generamos un numero aleatorio mayor a 10 ya que los menores a 10
  // les agregamos un cero al principio y se prueban en otro método
  numeroInventado := 0;
  while numeroInventado < 10 do
    numeroInventado := Random(999);

  comprobanteNuevo.MetodoDePago := IntToStr(numeroInventado);
  comprobanteNuevo.AsignarMetodoDePago;

  xmlGenerado := comprobanteNuevo.fXmlComprobante.XML;

  cadenaEsperada := 'metodoDePago="' + IntToStr(numeroInventado) + '"';
  CheckTrue(AnsiPos(cadenaEsperada, xmlGenerado) > 0,
            'No se incluyo el número de método de pago que se asigno manualmente');
end;

procedure TestTFEComprobanteFiscalV32.MetodoDePago_Inexistente_GenereExcepcion;
var
  comprobanteNuevo: TFEComprobanteFiscal;
const
  _CADENA_INEXISTENTE = 'METODO INVALIDO';
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  comprobanteNuevo.FechaGeneracion := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;
  try
    comprobanteNuevo.MetodoDePago := _CADENA_INEXISTENTE;

    StartExpectingException(EFECadenaMetodoDePagoNoEnCatalogoException);
    comprobanteNuevo.AsignarMetodoDePago;
    StopExpectingException('No se lanzo la excepcion EFECadenaMetodoDePagoNoEnCatalogoException con un metodo de pago inválido');
  finally
    comprobanteNuevo.Free;
  end;
end;

procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_MenorADiez_AgregueCeroAlPrincipio;
var
  xmlGenerado, cadenaEsperada: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  numeroInventado: Integer;
const
  _NUMERO_METODO_PAGO_SIN_CERO = '3';
  _NUMERO_METODO_PAGO_CON_CERO = '03'; // El SAT espera que tengan cero al principio los menores a 10
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  comprobanteNuevo.FechaGeneracion := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;

  comprobanteNuevo.MetodoDePago := _NUMERO_METODO_PAGO_SIN_CERO;
  comprobanteNuevo.AsignarMetodoDePago;

  xmlGenerado := comprobanteNuevo.fXmlComprobante.XML;

  cadenaEsperada := 'metodoDePago="' + _NUMERO_METODO_PAGO_CON_CERO + '"';
  CheckTrue(AnsiPos(cadenaEsperada, xmlGenerado) > 0,
            'No se agrego el cero al principio del numero de pago menor a 10');
end;

procedure
    TestTFEComprobanteFiscalV32.MetodoDePago_VariosMetodosNumericos_LosDejeIntactos;
var
  xmlGenerado, cadenaEsperada, cadenaObtenida: WideString;
  comprobanteNuevo: TFEComprobanteFiscal;
  fechaGeneracionComprobante: TDate;
const
  _CADENA_XML_METODO_PAGO       = 'metodoDePago="';
  _NUMERO_METODO_PAGO_INGRESADOS = '01,04,   8, 99';
  _NUMERO_METODO_PAGO_ESPERADOS  = '01,04,08,99';
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);

  comprobanteNuevo.FechaGeneracion            := fFechaEntradaVigenciaCatalogo;
  comprobanteNuevo.AutoAsignarFechaGeneracion := False;
  comprobanteNuevo.MetodoDePago               := _NUMERO_METODO_PAGO_INGRESADOS;
  comprobanteNuevo.AsignarMetodoDePago;

  // Checamos que se haya incluido el numero de catalogo de "Efectivo" y no dicha cadena
  xmlGenerado := comprobanteNuevo.fXmlComprobante.XML;

  cadenaEsperada := _CADENA_XML_METODO_PAGO + _NUMERO_METODO_PAGO_ESPERADOS + '"';
  cadenaObtenida := _CADENA_XML_METODO_PAGO + Copy(xmlGenerado,
                                                   AnsiPos(_CADENA_XML_METODO_PAGO, string(xmlGenerado)) + Length(_CADENA_XML_METODO_PAGO),
                                                   Length(_NUMERO_METODO_PAGO_ESPERADOS) + 1);

  CheckEquals(cadenaEsperada,
              cadenaObtenida,
              'No se dejó intacta la cadena de metodos de pago ya numéricos: ' + _NUMERO_METODO_PAGO_ESPERADOS);
end;



procedure TestTFEComprobanteFiscalV32.setSerie_Serie_LaGuardeEnXML;
var
  sXMLFixture: WideString;
  Serie: TFESerie;
  comprobanteNuevo, comprobanteGuardado: TFEComprobanteFiscal;
begin
  comprobanteNuevo := TFEComprobanteFiscal.Create(fev32);
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLFixture := leerContenidoDeFixture('comprobante_fiscal/v32/serie.xml');

  Serie := 'ABC';
  comprobanteNuevo.Serie := Serie;
  comprobanteNuevo.AsignarDatosFolios;

  CheckEquals(sXMLFixture, comprobanteNuevo.fXmlComprobante.XML,
              'No se guardo la serie en la estructura del XML');
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTFEComprobanteFiscalV32.Suite);

end.
