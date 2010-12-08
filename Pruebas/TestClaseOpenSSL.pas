(* *****************************************************************************
  Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestClaseOpenSSL;

interface

uses
  TestFramework, TestPrueba, ClaseOpenSSL;

type

  TestTOpenSSL = class(TTestPrueba)
  strict private
    fOpenSSL: TOpenSSL;
    fArchivoLlavePrivada: String;
    fClaveLlavePrivada: String;
  private
    procedure BorrarArchivoTempSiExiste(sNombre: String);
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure EjecutarComandoOpenSSL(sComando: String);
  published
    procedure HacerDigestion_TipoMD5_FuncioneCorrectamente;
    procedure HacerDigestion_TipoSHA1_FuncioneCorrectamente;
    procedure HacerDigestion_ConClaveIncorrecta_CauseExcepcion;
    procedure ObtenerCertificado_CertificadoDePrueba_RegreseElCertificadoConPropiedades;
  end;

const
  // Configura tu propia ruta a OpenSSL.exe
  _RUTA_OPENSSL_EXE = 'C:\Debug\SAT\openssl.exe';

implementation

uses
  Windows, SysUtils, Classes, FacturaTipos, ShellApi, Forms, OpenSSLUtils, DateUtils,
  ConstantesFixtures;

procedure TestTOpenSSL.BorrarArchivoTempSiExiste(sNombre: String);
  begin
    if FileExists(fDirTemporal + sNombre) then
      DeleteFile(fDirTemporal + sNombre);
  end;

procedure TestTOpenSSL.SetUp;
begin
  inherited;
  fArchivoLlavePrivada := fRutaEXE + 'Fixtures\openssl\aaa010101aaa_CSD_02.key';
  fClaveLlavePrivada := leerContenidoDeFixture('openssl\aaa010101aaa_CSD_02_clave.txt');
  // Creamos el objeto OpenSSL
  fOpenSSL := TOpenSSL.Create();
end;

procedure TestTOpenSSL.TearDown;
begin
  FreeAndNil(fOpenSSL);
end;

procedure TestTOpenSSL.EjecutarComandoOpenSSL(sComando: String);
begin
  {$IF CompilerVersion >= 20}
      ShellExecute(Application.Handle,nil,PChar('cmd.exe'),
               PWideChar('/c ' + _RUTA_OPENSSL_EXE + ' ' + sComando),nil,SW_HIDE);
  {$ELSE}
      ShellExecute(Application.Handle,nil,PChar('cmd.exe'),
               PChar('/c ' + _RUTA_OPENSSL_EXE + ' ' + sComando),nil,SW_HIDE);
  {$IFEND}

  // Hacemos esperar 1 segundo para que termine openssl.exe.
  Sleep(1000);
end;

procedure TestTOpenSSL.HacerDigestion_TipoMD5_FuncioneCorrectamente;
var
  sResultadoMD5DeClase, sResultadoMD5OpenSSL: WideString;

  function QuitarRetornos(sCad: WideString): WideString;
  begin
    Result := StringReplace(sCad, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
  end;

const
  // Se puede probar la efectividad del metodo cambiando la siguiente cadena
  // la cual debe ser la misma entre el resultado de la clase y de comandos manuales de Openssl.exe
  _CADENA_DE_PRUEBA = '||2.0|AA|2|2010-11-03T13:36:23|35|2008|ingreso|UNA SOLA EXHIBICIÓN|13360.00|0.00|15497.60|FIFC000101AM1|CONTRIBUYENTE DE PRUEBA' +
               ' FICTICIO FICTICIO|1|99|CENTRO|SAN MIGUEL XOXTLA|SAN MIGUEL XOXTLA|PUEBLA|MÉXICO|72620|CPC400101CM9|CONTRIBUYENTE DE PRUEBA CUATRO' +
               ' SA DE CV|AV HIDALGO|77|GUERRERO|DISTRITO FEDERAL|México|06300|1.00|PZ|1|Mac Book Air|10000.00|10000.00|3.00|PZ|2|Magic Mouse|900.00' +
               '|2700.00|5.50|HRS|3|Servicio de soporte técnico|120.00|660.00|IVA|16.00|1600.00|IVA|16.00|432.00|IVA|16.00|105.60|2137.60||';

  _ARCHIVO_LLAVE_PEM = 'aaa010101aaa_CSD_02.pem';
  _ARCHIVO_CADENA_TEMPORAL = 'cadena_hacerdigestion.txt';
  _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL = 'md5_cadena_hacerdigestion.txt';

  procedure guardarArchivoEnUTF8(sContenido: TStringCadenaOriginal; sArchivo: String);
  var
    txt : TextFile;
  begin
    AssignFile(txt, fDirTemporal + sArchivo);
    Rewrite(txt);
    Write(txt, sContenido);
    CloseFile(txt);
  end;

begin
  // Borramos los archivos temporales que vamos a usar si acaso existen (de pruebas pasadas)
  BorrarArchivoTempSiExiste(_ARCHIVO_CADENA_TEMPORAL);
  BorrarArchivoTempSiExiste(_ARCHIVO_TEMPORAL_RESULTADO_OPENSSL);
  BorrarArchivoTempSiExiste('md5_cadena_de_prueba.bin');

  // Guardamos el contenido de la cadena de prueba a un archivo temporal
  guardarArchivoEnUTF8(UTF8Encode(_CADENA_DE_PRUEBA), _ARCHIVO_CADENA_TEMPORAL);

  // Primero hacemos la digestion usando openssl.exe y la linea de comandos
  EjecutarComandoOpenSSL('dgst -md5 -sign "' + fRutaFixtures + 'openssl\' +
    _ARCHIVO_LLAVE_PEM + '" -out "' + fDirTemporal +
    'md5_cadena_de_prueba.bin" "' + fDirTemporal +
    _ARCHIVO_CADENA_TEMPORAL + '"');

  // Convertimos el resultado (archivo binario) a base64
  EjecutarComandoOpenSSL(' enc -base64 -in "' + fDirTemporal +
    'md5_cadena_de_prueba.bin" -out "' + fDirTemporal +
    _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL + '"');
 
  // Quitamos los retornos de carro ya que la codificacion Base64 de OpenSSL la regresa con ENTERs
  sResultadoMD5OpenSSL := QuitarRetornos(leerContenidoDeArchivo(fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL));
  // Ahora, hacemos la digestion con la libreria
  sResultadoMD5DeClase := fOpenSSL.HacerDigestion(fArchivoLlavePrivada, fClaveLlavePrivada, UTF8Encode(_CADENA_DE_PRUEBA), tdMD5);

  // Comparamos los resultados (sin retornos de carro), los cuales deben de ser los mismos
  CheckEquals(sResultadoMD5OpenSSL, sResultadoMD5DeClase, 'La digestion MD5 de la clase no fue la misma que la de OpenSSL');
end;

procedure TestTOpenSSL.HacerDigestion_TipoSHA1_FuncioneCorrectamente;
begin
  // TODO: Implementar pruebas y validaciones de SHA1
  CheckTrue(True);
end;

procedure TestTOpenSSL.HacerDigestion_ConClaveIncorrecta_CauseExcepcion;
var
  fOpenSSL2: TOpenSSL;
  bExcepcionLanzada: Boolean;
begin
  // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
  bExcepcionLanzada := False;
  fOpenSSL2 := TOpenSSL.Create();
  try
    fOpenSSL2.HacerDigestion(fArchivoLlavePrivada, 'claveincorrectaintencional', 'Cadena', tdMD5);
  except
    On E: ELlavePrivadaClaveIncorrectaException do
    begin
      bExcepcionLanzada := True;
    end;
  end;

  CheckTrue(bExcepcionLanzada,
    'No se lanzo excepcion cuando se especifico clave privada incorrecta.');
  FreeAndNil(fOpenSSL2);
end;

procedure TestTOpenSSL.ObtenerCertificado_CertificadoDePrueba_RegreseElCertificadoConPropiedades;
var
  Certificado: TX509Certificate;
  dtInicioVigencia, dtFinVigencia: TDateTime;
  sNumSerie: String;

  function NombreMesANumero(sMes: String) : Integer;
  begin
    sMes:=Uppercase(sMes);
    Result:=0;
    if sMes = 'JAN' then Result:=1;
    if sMes = 'FEB' then Result:=2;
    if sMes = 'MAR' then Result:=3;
    if sMes = 'APR' then Result:=4;
    if sMes = 'MAY' then Result:=5;
    if sMes = 'JUN' then Result:=6;
    if sMes = 'JUL' then Result:=7;
    if sMes = 'AUG' then Result:=8;
    if sMes = 'SEP' then Result:=9;
    if sMes = 'OCT' then Result:=10;
    if sMes = 'NOV' then Result:=11;
    if sMes = 'DEC' then Result:=12;
  end;

  function leerFechaDeArchivo(sRuta: String) : TDateTime;
  var
     sFecha, sTxt, sMes, sHora, sAno, sDia: String;
  begin
      // Leemos el archivo y convertimos el contenido a una fecha de Delphi
      sTxt:=leerContenidoDeArchivo(sRuta);
      // Quitamos la parte inicial (ej:notBefore=)
      sFecha:=Copy(sTxt,AnsiPos('=',sTxt)+1, Length(sTxt));
      //Ej: Jul 30 16:58:40 2010 GMT
      sMes:=Copy(sFecha, 1, 3);
      sDia:=Copy(sFecha, 5, 2);
      sHora:=Copy(sFecha, 8, 8);
      sAno:=Copy(sFecha, 17, 4);
      // Procesamos la fecha que regresa OpenSSL para convertirla a formato Delphi
      Result:=StrToDateTime(sDia + '/' + IntToStr(NombreMesANumero(sMes)) + '/' + sAno + ' ' + sHora);
  end;

  // Convertimos el num de serie que regresa OpenSSL en hexadecimal
  // a integer de Delphi. Gracias a usuario 'dado' por su ayuda
  // para obtener este dato: http://www.clubdelphi.com/foros/showthread.php?t=66807&page=14
  function ValidarSerieDeOpenSSL(Serie: String) : String;
  var
     n: Integer;
     NumSerie: String;
  begin
    NumSerie := '';
    n := 9;
		while n <= length(Serie) do
		begin
			NumSerie := NumSerie + Serie[n];
			n := n + 2;
		end;
    Result:=NumSerie;
  end;

begin
  BorrarArchivoTempSiExiste(fDirTemporal + 'VigenciaInicio.txt');

  // Procesamos el certificado con el OpenSSL.exe para obtener los datos y
  // poder corroborarlos...
  EjecutarComandoOpenSSL(' x509 -inform DER -in "' + fRutaFixtures + _RUTA_CERTIFICADO +
                          '" -noout -startdate > "' + fDirTemporal + 'VigenciaInicio.txt" ');
  dtInicioVigencia:=leerFechaDeArchivo(fDirTemporal + 'VigenciaInicio.txt');
  // Fin de vigencia
  EjecutarComandoOpenSSL(' x509 -inform DER -in "' + fRutaFixtures + _RUTA_CERTIFICADO +
                          '" -noout -enddate > "' + fDirTemporal + 'VigenciaFin.txt" ');
  dtFinVigencia:=leerFechaDeArchivo(fDirTemporal + 'VigenciaFin.txt');

  // Numero de Serie
  EjecutarComandoOpenSSL(' x509 -inform DER -in "' + fRutaFixtures + _RUTA_CERTIFICADO +
                          '" -noout -serial > "' + fDirTemporal + 'Serial.txt" ');

  // "Limpiamos" el Serie que nos da el OpenSSL ya que incluye caracteres de mas...
  sNumSerie:= ValidarSerieDeOpenSSL(leerContenidoDeArchivo(fDirTemporal + 'Serial.txt'));

  Certificado := fOpenSSL.ObtenerCertificado(fRutaFixtures + _RUTA_CERTIFICADO);

  // Checamos las propiedades que nos interesan
  CheckEquals(dtInicioVigencia, Certificado.NotBefore, 'El inicio de vigencia del certificado no fue el mismo que regreso OpenSSL');
  CheckEquals(dtFinVigencia, Certificado.NotAfter, 'El fin de vigencia del certificado no fue el mismo que regreso OpenSSL');
  CheckEquals(sNumSerie, Certificado.SerialNumber, 'El numero de serie del certificado no fue el mismo que regreso OpenSSL');
  // Checamos que la longitud del Numero de Serie sea de 20 (especificada en el RFC 3280 de la especificacion X509)
  CheckEquals(20, Length(Certificado.SerialNumber), 'La longitud del numero de serie no fue la correcta');
  FreeAndNil(Certificado);
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTOpenSSL.Suite);

end.
