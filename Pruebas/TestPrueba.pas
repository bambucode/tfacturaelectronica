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
   fRutaFixtures:='C:\Delphi\Otros\bc_facturacionelectronica\Pruebas\fixtures\';
   fRutaEXE := ExtractFilePath(Application.ExeName);
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
  slArchivo.SaveToFile('C:\Delphi\Otros\bc_facturacionelectronica\Pruebas/fixtures/' + sArchivo);
  FreeAndNil(slArchivo);
end;

procedure TTestPrueba.guardarArchivoTemporal(sContenido: Widestring; sArchivo: String);
var
  txt : TextFile;
  buf : String;
begin
  AssignFile(txt, fDirTemporal + sArchivo);
  Rewrite(txt);
  Write(txt, sContenido);
  CloseFile(txt);
end;


end.
