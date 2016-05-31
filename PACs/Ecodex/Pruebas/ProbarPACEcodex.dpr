(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA

 Copyright (C) 2011-2012 - Bambu Code SA de CV - Ing. Luis Carrasco

 Proyecto que concentra todas las pruebas de unidad de la libreria.

 Este archivo pertenece al proyecto de abierto fuente de BambuCode:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
{$DEFINE VERSION_DE_PRUEBA}

program ProbarPACEcodex;
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
  {$IFDEF XMLOUTPUT}
  // Soporte para Vsoft.DUnit.Xml el cual permite que las pruebas generen un archivo XML para los reportes
  // Ref: https://github.com/VSoftTechnologies/DUnit-XML
  // Solo se debe agregar la carpeta de dicho proyecto al "Library Path"
   VSoft.DUnit.XMLTestRunner in '..\..\..\Pruebas\DUnit-XML\VSoft.DUnit.XMLTestRunner.pas',
  VSoft.MSXML6 in '..\..\..\Pruebas\DUnit-XML\VSoft.MSXML6.pas',
  {$ENDIF}
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  System.SysUtils,
  FacturaTipos in '..\..\..\FacturaTipos.pas',
  FacturaReglamentacion in '..\..\..\FacturaReglamentacion.pas',
  TestManejadorDeSesion in 'TestManejadorDeSesion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsSeguridad in '..\EcodexWsSeguridad.pas',
  ProveedorAutorizadoCertificacion in '..\..\ProveedorAutorizadoCertificacion.pas',
  EcodexWsTimbrado in '..\EcodexWsTimbrado.pas',
  TestPACEcodex in 'TestPACEcodex.pas',
  TestPrueba in '..\..\..\Pruebas\TestPrueba.pas',
  PACEcodex in '..\PACEcodex.pas',
  FacturacionHashes in '..\..\..\FacturacionHashes.pas',
  FETimbreFiscalDigital in '..\..\..\CFD\FETimbreFiscalDigital.pas',
  FeCFDv32 in '..\..\..\CFD\FeCFDv32.pas',
  FeCFD in '..\..\..\CFD\FeCFD.pas',
  FeCFDv2 in '..\..\..\CFD\FeCFDv2.pas',
  FeCFDv22 in '..\..\..\CFD\FeCFDv22.pas',
  FacturaElectronica in '..\..\..\FacturaElectronica.pas',
  DocComprobanteFiscal in '..\..\..\DocComprobanteFiscal.pas',
  ClaseOpenSSL in '..\..\..\ClaseOpenSSL.pas',
  libeay32 in '..\..\..\libeay32.pas',
  LibEay32Plus in '..\..\..\LibEay32Plus.pas',
  OpenSSLUtils in '..\..\..\OpenSSLUtils.pas',
  SelloDigital in '..\..\..\SelloDigital.pas',
  CadenaOriginal in '..\..\..\CadenaOriginal.pas',
  ComprobanteFiscal in '..\..\..\ComprobanteFiscal.pas',
  EcodexWsClientes in '..\EcodexWsClientes.pas',
  EcodexWsComun in '..\EcodexWsComun.pas',
  ManejadorDeErroresComunes in '..\..\ManejadorDeErroresComunes.pas',
  EcodexWsCancelacion in '..\EcodexWsCancelacion.pas';


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

