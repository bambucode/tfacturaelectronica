(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA

 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Proyecto que concentra todas las pruebas de unidad de la libreria.

 Este archivo pertenece al proyecto de abierto fuente de BambuCode:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
{$DEFINE VERSION_DE_PRUEBA}

program ProbarFacturaElectronica;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

// Creamos el define para que podamos acceder a las variables privadas de las clases
// para que sean probadas

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestClaseOpenSSL in 'TestClaseOpenSSL.pas',
  TestSelloDigital in 'TestSelloDigital.pas',
  FeCFDv2 in '..\CFD\FeCFDv2.pas',
  FacturaTipos in '..\FacturaTipos.pas',
  FacturaReglamentacion in '..\FacturaReglamentacion.pas',
  ComprobanteFiscal in '..\ComprobanteFiscal.pas',
  TestComprobanteFiscal in 'TestComprobanteFiscal.pas',
  SelloDigital in '..\SelloDigital.pas',
  TestFacturaElectronica in 'TestFacturaElectronica.pas',
  FacturaElectronica in '..\FacturaElectronica.pas',
  TestPrueba in 'TestPrueba.pas',
  libeay32 in '..\libeay32.pas',
  OpenSSLUtils in '..\OpenSSLUtils.pas',
  ClaseOpenSSL in '..\ClaseOpenSSL.pas',
  LibEay32Plus in '..\LibEay32Plus.pas',
  ConstantesFixtures in 'ConstantesFixtures.pas',
  DocComprobanteFiscal in '..\DocComprobanteFiscal.pas',
  CadenaOriginal in '..\CadenaOriginal.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.
