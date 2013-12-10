(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestPACEcodex;

interface

uses
  TestFramework,
  FacturaTipos,
  TestPrueba,
  PACEcodex;

type

  TestTPACEcodex = class(TTestPrueba)
  strict private
    fDirectorioFixtures: string;
    fDocumentoDePrueba: WideString;
    fCredencialesDePrueba : TFEPACCredenciales;
    cutPACEcodex: TPACEcodex;
  private
    function ObtenerNuevaFacturaATimbrar(const aFechaGeneracion: TDateTime = 0):
        WideString;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure AgregaCliente_NuevoEmisor_GuardeClienteCorrectamente;
    procedure CancelarDocumento_Documento_CanceleCorrectamente;
    procedure TimbrarDocumento_ConRFCIncorrecto_CauseExcepcionDeRFC;
    procedure TimbrarDocumento_ConXMLMalformado_CauseExcepcion;
    procedure TimbrarDocumento_DePrueba_RegreseDatosDeTimbre;
    procedure TimbrarDocumento_GeneradoHaceMasDe72Horas_CauseExcepcion;
    procedure TimbrarDocumento_PreviamenteTimbrado_CauseExcepcionDeTimbrePrevio;
  end;

implementation

uses
  Windows, SysUtils, Classes, Forms,
  System.DateUtils,
  FacturaElectronica;


procedure TestTPACEcodex.SetUp;
begin
  inherited;
  cutPACEcodex := TPACEcodex.Create('https://pruebas.ecodex.com.mx:2045');

  // Definimos el directorio donde estan los archivos de prueba
  fDirectorioFixtures := ExtractFilePath(Application.ExeName) + '..\..\Fixtures\';

  // Asignamos las credenciales de prueba
  // tomadas del documento "Guia de integracion ECODEX_v2.0.1.pdf" Página 28
  fCredencialesDePrueba.RFC            := 'AAA010101AAA';
  fCredencialesDePrueba.Clave          := 'prueba';
  fCredencialesDePrueba.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';

  // Asignamos las credenciales a Ecodex
  cutPACEcodex.AsignarCredenciales(fCredencialesDePrueba);
end;

procedure TestTPACEcodex.TearDown;
begin
  FreeAndNil(cutPACEcodex);
end;

function TestTPACEcodex.ObtenerNuevaFacturaATimbrar(const aFechaGeneracion:
    TDateTime = 0): WideString;
var
  Emisor, Receptor: TFEContribuyente;
  Certificado: TFECertificado;
  Factura: TFacturaElectronica;
  Concepto: TFEConcepto;
  impuestoIVA: TFEImpuestoTrasladado;
begin
  // 1. Definimos los datos del emisor y receptor
  Emisor.RFC:='AAA010101AAA';
  Emisor.Nombre:='Mi Empresa SA de CV';
  Emisor.Direccion.Pais:='México';

   // 2. Agregamos los régimenes fiscales (requerido en CFD >= 2.2)
  SetLength(Emisor.Regimenes, 1);
  Emisor.Regimenes[0] := 'Regimen General de Ley';

  Receptor.RFC:='PWD090210DR5';
  Receptor.Nombre:='Mi Cliente SA de CV';
  Receptor.Direccion.Pais:='México';

  // 4. Definimos el certificado junto con su llave privada
  Certificado.Ruta:=fDirectorioFixtures + '\aaa010101aaa_CSD_01.cer';
  Certificado.LlavePrivada.Ruta:=fDirectorioFixtures + '\aaa010101aaa_CSD_01.key';
  Certificado.LlavePrivada.Clave:='12345678a';

  // 5. Creamos la clase Factura con los parametros minimos.
  Factura:=TFacturaElectronica.Create(Emisor, Receptor, Certificado, tcIngreso);
  Factura.MetodoDePago:='Tarjeta de credito';

  // Asignamos el lugar de expedición (requerido en  CFD >= 2.2)
  Factura.LugarDeExpedicion:='Queretaro, Qro';

  // Definimos todos los conceptos que incluyo la factura
  Concepto.Cantidad:=10.25;
  Concepto.Unidad:='Kilo';
  Concepto.Descripcion:='Arroz blanco precocido';
  Concepto.ValorUnitario:=12.23;
  Factura.AgregarConcepto(Concepto);

  // Agregamos el impuesto del concepto 1
  impuestoIVA.Nombre:='IVA';
  impuestoIVA.Tasa:=16;
  impuestoIVA.Importe:=(concepto.ValorUnitario * concepto.Cantidad) * (impuestoIVA.Tasa/100);
  Factura.AgregarImpuestoTrasladado(impuestoIVA);

  // Mandamos generar el CFD en memoria antes de timbrarlo
  Randomize;

  // Checamos si queremos emular una fecha especifica en la que fue "generado" el CFD
  if aFechaGeneracion <> 0 then
  begin
    Factura.AutoAsignarFechaGeneracion := False;
    Factura.FechaGeneracion := aFechaGeneracion;
  end;

  // Generamos la factura
  Factura.Generar(Random(999999), fpUnaSolaExhibicion);

  Result := Factura.XML;
end;

procedure TestTPACEcodex.AgregaCliente_NuevoEmisor_GuardeClienteCorrectamente;
var
  nuevoEmisor: TFEContribuyente;
  respuestaAltaEmisor: Boolean;
begin
  nuevoEmisor.Nombre := 'Mi empresa de prueba SA de CV';
  nuevoEmisor.RFC := 'SUL010720JN8';
  nuevoEmisor.CorreoElectronico := 'test@test.com';

  respuestaAltaEmisor := cutPACEcodex.AgregaCliente(nuevoEmisor, fCredencialesDePrueba.RFC);

  CheckEquals(True,
              respuestaAltaEmisor,
              'No se dio de alta al nuevo emisor correctamente');
end;

procedure TestTPACEcodex.CancelarDocumento_Documento_CanceleCorrectamente;
var
  resultadoCancelacion: Boolean;
begin
   fDocumentoDePrueba := Self.leerContenidoDeArchivo(fDirectorioFixtures + '\comprobante_previamente_timbrado.xml');

   resultadoCancelacion := cutPACEcodex.CancelarDocumento(fDocumentoDePrueba);

   CheckEquals(True,
               resultadoCancelacion,
               'Se debio haber regresado verdadero tras el proceso de cancelación del CFDI');
end;

procedure TestTPACEcodex.TimbrarDocumento_ConRFCIncorrecto_CauseExcepcionDeRFC;
var
  excepcionLanzada: Boolean;
  credencialesDiferentes: TFEPACCredenciales;
begin
  excepcionLanzada := False;

  // Leemos el XML de un documento previamente timbrado
  fDocumentoDePrueba := Self.leerContenidoDeArchivo(fDirectorioFixtures + '\comprobante_previamente_timbrado.xml');

  credencialesDiferentes.RFC            := 'SUL010720JN8';
  credencialesDiferentes.Clave          := 'prueba';
  credencialesDiferentes.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';

  // Asignamos las nuevas credenciales a Ecodex con un RFC diferente al del documento a timbrar
  cutPACEcodex.AsignarCredenciales(credencialesDiferentes);

  try
    // Mandamos timbrar
    cutPACEcodex.TimbrarDocumento(fDocumentoDePrueba);
  except
    On E:EPACTimbradoRFCNoCorrespondeException do
    begin
       excepcionLanzada := True;
    end;
  end;

  CheckTrue(excepcionLanzada, 'Se debio haber lanzado la excepcion de ETimbradoRFCNoCorrespondeException al ' +
                              'enviar un XML a timbrar donde el RFC del emisor es diferente al de las credenciales del PAC');
end;

procedure TestTPACEcodex.TimbrarDocumento_ConXMLMalformado_CauseExcepcion;
var
  excepcionLanzada : Boolean;
  documentoXMLInvalido : WideString;
begin
   documentoXMLInvalido := leerContenidoDeArchivo(fDirectorioFixtures + '\comprobante_malformado.xml');

   try
    // Mandamos timbrar
    cutPACEcodex.TimbrarDocumento(documentoXMLInvalido);
  except
    On E:ETimbradoXMLInvalidoException do
    begin
       excepcionLanzada := True;
    end;
  end;


  CheckTrue(excepcionLanzada, 'Se debio haber lanzado la excepcion de ETimbradoPreviamenteException al ' +
                              'enviar un documento previamente timbrado');
end;

procedure TestTPACEcodex.TimbrarDocumento_DePrueba_RegreseDatosDeTimbre;
var
  nuevoDocumentoATimbrar : WideString;
  resultadoTimbre: TFETimbre;
begin
  // Creamos un comprobante nuevo para mandarlo timbrar
  nuevoDocumentoATimbrar := ObtenerNuevaFacturaATimbrar();

  // ** Mandamos realizar el timbre **
  resultadoTimbre := cutPACEcodex.TimbrarDocumento(nuevoDocumentoATimbrar);

  CheckEquals('1.0',
              resultadoTimbre.Version,
              'La version del timbre fue diferente a la esperada');
  CheckTrue(resultadoTimbre.UUID <> '',
            'El UUID del timbre no se asignó correctamente');
  CheckTrue(resultadoTimbre.SelloCFD <> '',
            'El Sello CFD del timbre no se asignó correctamente');
  CheckTrue(resultadoTimbre.NoCertificadoSAT <> '',
            'El NoCertificadoSAT del timbre no se asignó correctamente');
  CheckTrue(resultadoTimbre.SelloSAT <> '',
            'El SelloSAT del timbre no se asignó correctamente');
  CheckTrue(resultadoTimbre.XML <> '',
          'El XML del timbre no se asignó correctamente');
end;

procedure
    TestTPACEcodex.TimbrarDocumento_GeneradoHaceMasDe72Horas_CauseExcepcion;
var
  documentoATimbrarGeneradoHace73Horas : WideString;
  excepcionLanzada: Boolean;
  fechaGeneracion: TDateTime;
begin
  // Calculamos una fecha en el pasado en donde el CFD se genero hace 72 horas.
  fechaGeneracion := IncHour(Now, -72);
  // Creamos un comprobante nuevo para mandarlo timbrar con fecha de generacion en el pasado
  documentoATimbrarGeneradoHace73Horas := ObtenerNuevaFacturaATimbrar(fechaGeneracion);

  // ** Mandamos realizar el timbre **
  try
    cutPACEcodex.TimbrarDocumento(documentoATimbrarGeneradoHace73Horas);
  except
    On E:ETimbradoFechaGeneracionMasDe72HorasException do
       excepcionLanzada := True;
  end;

  CheckTrue(excepcionLanzada, 'Se debio haber lanzado la excepcion de ETimbradoFechaGeneracionMasDe72HorasException al ' +
                              'intentar timbrar un documento generado hace 72 horas o más');
end;

procedure
    TestTPACEcodex.TimbrarDocumento_PreviamenteTimbrado_CauseExcepcionDeTimbrePrevio;
var
  excepcionLanzada: Boolean;
begin
  excepcionLanzada := False;
  // Leemos el XML de un documento previamente timbrado
  fDocumentoDePrueba := Self.leerContenidoDeArchivo(fDirectorioFixtures + '\comprobante_previamente_timbrado.xml');

  try
    // Mandamos timbrar
    cutPACEcodex.TimbrarDocumento(fDocumentoDePrueba);
  except
    On E:ETimbradoPreviamenteException do
    begin
       excepcionLanzada := True;
    end;
  end;

  CheckTrue(excepcionLanzada, 'Se debio haber lanzado la excepcion de ETimbradoPreviamenteException al ' +
                              'enviar un documento previamente timbrado');
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTPACEcodex.Suite);

end.
