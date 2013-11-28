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
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  FacturaTipos in '..\..\..\FacturaTipos.pas',
  FacturaReglamentacion in '..\..\..\FacturaReglamentacion.pas',
  TestManejadorDeSesion in 'TestManejadorDeSesion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsSeguridad in '..\EcodexWsSeguridad.pas',
  ProveedorAutorizadoCertificacion in '..\..\ProveedorAutorizadoCertificacion.pas',
  EcodexWsTimbrado in '..\EcodexWsTimbrado.pas',
  TestPACEcodex in 'TestPACEcodex.pas',
  TestPrueba in '..\..\..\Pruebas\TestPrueba.pas',
  PACEcodex in '..\PACEcodex.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.
