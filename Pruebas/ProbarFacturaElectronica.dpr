(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA

 Copyright (C) 2011-2014 - Bambu Code SA de CV

 Proyecto que concentra las pruebas de unidad especificas de la generación
 del XML del CFD/I y su sellado

 Este archivo pertenece al proyecto de abierto fuente de BambuCode:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
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
  SysUtils,
  {$IFDEF XMLOUTPUT}
  // Soporte para Vsoft.DUnit.Xml el cual permite que las pruebas generen un archivo XML para los reportes
  // Ref: https://github.com/VSoftTechnologies/DUnit-XML
  // Solo se debe agregar la carpeta de dicho proyecto al "Library Path"
  VSoft.DUnit.XMLTestRunner in 'DUnit-XML\VSoft.DUnit.XMLTestRunner.pas',
  VSoft.MSXML6 in 'DUnit-XML\VSoft.MSXML6.pas',
  {$ENDIF}
  TextTestRunner,
  TestFramework,
  GUITestRunner,
  Forms,
  CodeSiteLogging,
  TestSelloDigital in 'TestSelloDigital.pas',
  TestCadenaOriginalDeTimbre in 'TestCadenaOriginalDeTimbre.pas',
  FacturaTipos in '..\FacturaTipos.pas',
  FacturaReglamentacion in '..\FacturaReglamentacion.pas',
  SelloDigital in '..\SelloDigital.pas',
  FacturaElectronica in '..\FacturaElectronica.pas',
  TestPrueba in 'TestPrueba.pas',
  libeay32 in '..\libeay32.pas',
  OpenSSLUtils in '..\OpenSSLUtils.pas',
  ClaseOpenSSL in '..\ClaseOpenSSL.pas',
  LibEay32Plus in '..\LibEay32Plus.pas',
  ConstantesFixtures in 'ConstantesFixtures.pas',
  DocComprobanteFiscal in '..\DocComprobanteFiscal.pas',
  CadenaOriginal in '..\CadenaOriginal.pas',
  FeCFDv22 in '..\CFD\FeCFDv22.pas',
  FeCFDv32 in '..\CFD\FeCFDv32.pas',
  TestClaseOpenSSL in 'TestClaseOpenSSL.pas',
  TestComprobanteFiscalv22 in 'TestComprobanteFiscalv22.pas',
  ComprobanteFiscal in '..\ComprobanteFiscal.pas',
  TestComprobanteFiscalv32 in 'TestComprobanteFiscalv32.pas',
  UtileriasPruebas in 'UtileriasPruebas.pas',
  FacturacionHashes in '..\FacturacionHashes.pas',
  FeTimbreFiscalDigital in '..\CFD\FeTimbreFiscalDigital.pas',
  CadenaOriginalTimbre in '..\CadenaOriginalTimbre.pas',
  ClaseCertificadoSellos in '..\ClaseCertificadoSellos.pas',
  TestCertificadoSellos in 'TestCertificadoSellos.pas';


{$R *.RES}

{$IfDef XMLOUTPUT}
var
  OutputFile : string = DEFAULT_FILENAME;

var
  ConfigFile : string;
{$EndIf}

{$IFDEF ISCONSOLE}
var
  ExitBehavior: TRunnerExitBehavior;
{$EndIf}

begin
  CodeSite.Clear;

  {$IfDef ISCONSOLE}
    {$IfDef XMLOUTPUT}
      {$Message Hint 'Compilando version generadora de XML'}
      if ConfigFile <> '' then
      begin
        RegisteredTests.LoadConfiguration(ConfigFile, False, True);
        WriteLn('Loaded config file ' + ConfigFile);
      end;
      if ParamCount > 0 then
        OutputFile := ParamStr(1);
      WriteLn('Writing output to ' + OutputFile);
      WriteLn('Running ' + IntToStr(RegisteredTests.CountEnabledTestCases) + ' of ' + IntToStr(RegisteredTests.CountTestCases) + ' test cases');
      TXMLTestListener.RunRegisteredTests(OutputFile);
    {$else}
      WriteLn('To run with rxbPause, use -p switch');
      WriteLn('To run with rxbHaltOnFailures, use -h switch');
      WriteLn('No switch runs as rxbContinue');

      if FindCmdLineSwitch('p', ['-', '/'], true) then
        ExitBehavior := rxbPause
      else if FindCmdLineSwitch('h', ['-', '/'], true) then
        ExitBehavior := rxbHaltOnFailures
      else
        ExitBehavior := rxbContinue;

      TextTestRunner.RunRegisteredTests(ExitBehavior);
    {$endif}
  {$Else}
    {$Message Hint 'Generando version GUI de pruebas'}
    Application.Initialize;
    TGUITestRunner.RunRegisteredTests;
  {$EndIf}
end.

