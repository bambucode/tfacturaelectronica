(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit TestPrueba;

interface

uses
  TestFramework,
  FacturaTipos;

type

  TTestPrueba = class(TTestCase)
  strict private

  protected
     fRutaFixtures: String;
     fDirTemporal: String;
     fRutaEXE: String;
     fOpenSSL: String;
     function leerContenidoDeFixture(sNombreFixture: String): WideString;
     function leerContenidoDeArchivo(sNombreArchivo: String): WideString;
     procedure guardarContenido(sContenido: Widestring; sArchivo: String);
     procedure guardarArchivoTemporal(sContenido: Widestring; sArchivo: String);
     procedure EjecutarComandoOpenSSL(sComando: String);
     procedure SetUp; override;
     procedure guardarArchivoEnUTF8(sContenido: TStringCadenaOriginal; sArchivo: String);
     procedure BorrarArchivoTempSiExiste(sNombre: String);
     function QuitarRetornos(sCad: WideString): WideString;
  end;

const
  _CERTIFICADO_PRUEBAS_SAT          = 'comprobante_fiscal\aaa010101aaa_csd_01.cer';
  _LLAVE_PRIVADA_PRUEBAS_SAT        = 'comprobante_fiscal\aaa010101aaa_csd_01.key';
  _CLAVE_LLAVE_PRIVADA_PRUEBAS_SAT  = '12345678a';

implementation

uses
  Windows, SysUtils, Classes, Forms,
  Math,
  ShellApi;

procedure TTestPrueba.SetUp;
begin
   inherited;
   Randomize;

   fDirTemporal:=GetEnvironmentVariable('TEMP') + '\' + IntToStr(RandomRange(1111,9999)) + '\';
   if Not DirectoryExists(fDirTemporal) then
    CreateDir(fDirTemporal);

   fRutaEXE := ExtractFilePath(Application.ExeName);
   fOpenSSL := ExtractFilePath(Application.ExeName) + 'openssl.exe';

   // Asumimos que se va a ejecutar en subdirectorio Release\Win32 de la carpeta
   // donde se guarda el proyecto
   fRutaFixtures:=fRutaEXE + '\fixtures\';
end;

function TTestPrueba.QuitarRetornos(sCad: WideString): WideString;
begin
    Result := StringReplace(sCad, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TTestPrueba.EjecutarComandoOpenSSL(sComando: String);
var
  ComandoUsado : String;
begin
  Assert(FileExists(fOpenSSL), 'No existe el ejecutable OpenSSL.exe necesario para las pruebas en:' + fRutaEXE);

  ComandoUsado := '/c ' + fOpenSSL + ' ' + sComando;
  //CodeSite.Send('Comando', ComandoUsado);

  {$IF CompilerVersion >= 20}
      ShellExecute(Application.Handle,nil,PChar('cmd.exe'),
               PWideChar(ComandoUsado),nil,SW_HIDE);
  {$ELSE}
      ShellExecute(Application.Handle,nil,PChar('cmd.exe'),
               PChar(ComandoUsado),nil,SW_HIDE);
  {$IFEND}

  // Hacemos esperar 1 segundo para que termine openssl.exe.
  Sleep(1000);
end;

procedure TTestPrueba.guardarArchivoEnUTF8(sContenido: TStringCadenaOriginal; sArchivo: String);
var
  txt : TextFile;
begin
  AssignFile(txt, fDirTemporal + sArchivo);
  Rewrite(txt);
  Write(txt, sContenido);
  CloseFile(txt);
end;

procedure TTestPrueba.BorrarArchivoTempSiExiste(sNombre: String);
begin
    if FileExists(fDirTemporal + sNombre) then
      DeleteFile(fDirTemporal + sNombre);
end;

function TTestPrueba.leerContenidoDeArchivo(sNombreArchivo: String): WideString;
var
  slArchivo: TStrings;
begin
  Assert(FileExists(sNombreArchivo), 'No existe el archivo a leer');
  slArchivo := TStringList.Create;
  slArchivo.LoadFromFile(sNombreArchivo);
  {$IF Compilerversion >= 20}
  Result:=Trim(slArchivo.Text);
  {$ELSE}
  Result:=Trim(UTF8Encode(slArchivo.Text));
  {$IFEND}
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