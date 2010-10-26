program ProbarFacturaElectronica;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestFacturaElectronica in 'TestFacturaElectronica.pas',
  FacturaElectronica in '..\FacturaElectronica.pas',
  FeCFDv2 in '..\CFD\FeCFDv2.pas',
  FacturaTipos in '..\FacturaTipos.pas',
  FacturaReglamentacion in '..\FacturaReglamentacion.pas',
  ComprobanteFiscal in '..\CFD\ComprobanteFiscal.pas',
  TestComprobanteFiscal in 'TestComprobanteFiscal.pas',
  SelloDigital in '..\CFD\SelloDigital.pas',
  TestSelloDigital in 'TestSelloDigital.pas',
  TestPrueba in 'TestPrueba.pas',
  libeay32 in '..\libeay32.pas',
  OpenSSLUtils in '..\OpenSSLUtils.pas',
  ClaseOpenSSL in '..\ClaseOpenSSL.pas',
  LibEay32Plus in '..\LibEay32Plus.pas',
  TestClaseOpenSSL in 'TestClaseOpenSSL.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

