(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA

 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Este archivo pertenece al proyecto de codigo fuente de BambuCode:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
 unit TestSelloDigital;

interface

uses
  TestFramework, SelloDigital, TestPrueba, FacturaTipos;

type

  TestTSelloDigital = class(TTestPrueba)
  strict private
    fSelloDigital: TSelloDigital;
    fCadenaOriginalAProbar : WideString;
    fCertificado: TFECertificado;
  public
    procedure SetUp; override;
  published
      procedure SelloCalcualado_DeCadenaOriginalConMD5_SeaCorrecto;
  end;

implementation

uses
  Windows, SysUtils, Classes, ClaseOpenSSL;

procedure TestTSelloDigital.SetUp;
begin
   inherited;
   // Leemos la cadena original que vamos a usar en las pruebas
   fCadenaOriginalAProbar:=leerContenidoDeFixture('sello_digital/cadena_original_validada_en_utf8.txt');
   // Especificamos la llave privada de pruebas del SAT usadas en las pruebas
   fCertificado.LlavePrivada.Ruta:=fRutaFixtures + 'openssl\aaa010101aaa_CSD_02.key';
   fCertificado.LlavePrivada.Clave:=leerContenidoDeFixture('openssl\aaa010101aaa_CSD_02_clave.txt');
end;

procedure TestTSelloDigital.SelloCalcualado_DeCadenaOriginalConMD5_SeaCorrecto;
var
  SelloDigitalCorrecto, ResultadoSelloCalculado: WideString;
const
  _LONGITUD_SELLO_DIGITAL = 172;
begin
    // Ahora la calculada previamente con el programa MicroE del SAT
    SelloDigitalCorrecto:=leerContenidoDeFixture('sello_digital/sello_digital_correcto.txt');

    // Creamos el objeto de Sello Digital
    fSelloDigital := TSelloDigital.Create(fCadenaOriginalAProbar,fCertificado, tdMD5);

    // Hacemos que calcule el Sello Digital para la cadena original proveida
    ResultadoSelloCalculado:=fSelloDigital.SelloCalculado;

    CheckEquals(SelloDigitalCorrecto, ResultadoSelloCalculado, 'El procedimiento para calcular el sello digital fallo, el resultado no fue el mismo que el ejemplo del SAT');
    CheckEquals(_LONGITUD_SELLO_DIGITAL, Length(ResultadoSelloCalculado), 'La longitud del sello digital no fue la correcta, debe de ser siempre de  ' + IntToStr(_LONGITUD_SELLO_DIGITAL));
    FreeAndNil(fSelloDigital);
end;

initialization
  // Registra la prueba de esta unidad en la suite de pruebas
  RegisterTest(TestTSelloDigital.Suite);
end.
