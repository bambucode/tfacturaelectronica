(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit TestPrueba;

interface

uses
  TestFramework;

type

  TTestPrueba = class(TTestCase)
  strict private

  protected
     fRutaFixtures: String;
     fDirTemporal: String;
     fRutaEXE: String;
     function leerContenidoDeFixture(sNombreFixture: String): WideString;
     function leerContenidoDeArchivo(sNombreArchivo: String): WideString;
     procedure guardarContenido(sContenido: Widestring; sArchivo: String);
     procedure guardarArchivoTemporal(sContenido: Widestring; sArchivo: String);
     procedure SetUp; override;
  end;

implementation

uses
  Windows, SysUtils, Classes, Forms;

procedure TTestPrueba.SetUp;
begin
   inherited;
   fDirTemporal:=GetEnvironmentVariable('TEMP') + '\';
   fRutaEXE := ExtractFilePath(Application.ExeName);
   fRutaFixtures:=fRutaEXE + 'fixtures\';
end;

function TTestPrueba.leerContenidoDeArchivo(sNombreArchivo: String): WideString;
var
  slArchivo: TStrings;
begin
  slArchivo := TStringList.Create;
  slArchivo.LoadFromFile(sNombreArchivo);
  Result:=Trim(slArchivo.Text);
  FreeAndNil(slArchivo);
end;

function TTestPrueba.leerContenidoDeFixture(sNombreFixture: String): WideString;
begin
  Result:=leerContenidoDeArchivo(fRutaFixtures + sNombreFixture);
end;

procedure TTestPrueba.guardarContenido(sContenido: Widestring; sArchivo: String);
var
  slArchivo: TStrings;
begin
  slArchivo := TStringList.Create;
  slArchivo.Text:=sContenido;
  slArchivo.SaveToFile(fRutaEXE + 'fixtures/' + sArchivo);
  FreeAndNil(slArchivo);
end;

procedure TTestPrueba.guardarArchivoTemporal(sContenido: Widestring; sArchivo: String);
var
  txt : TextFile;
begin
  AssignFile(txt, fDirTemporal + sArchivo);
  Rewrite(txt);
  Write(txt, sContenido);
  CloseFile(txt);
end;


end.