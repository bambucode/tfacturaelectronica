(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

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
    function EncriptarUsandoOpenSSL(aCadena: String; aTipoEncripcion:
        TTipoDigestionOpenSSL): string;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure HacerDigestion_TipoMD5_FuncioneCorrectamente;
    procedure HacerDigestion_TipoSHA1_FuncioneCorrectamente;
    procedure HacerDigestion_ConClaveIncorrecta_CauseExcepcion;
    procedure ObtenerCertificado_CertificadoDePrueba_RegreseElCertificadoConPropiedades;
    procedure ObtenerModulusDeCertificado_DeCertificado_RegreseValorCorrecto;
    procedure ObtenerModulusDeLlavePrivada_DeLlave_RegreseValorCorrecto;
  end;

implementation

uses
  Windows, SysUtils, Classes, FacturaTipos, Forms, OpenSSLUtils, DateUtils,
  ConstantesFixtures,
  CodeSiteLogging;


procedure TestTOpenSSL.SetUp;
begin
  inherited;
  fArchivoLlavePrivada := fRutaFixtures + '\openssl\aaa010101aaa_csd_01.key';
  fClaveLlavePrivada := '12345678a';
  // Creamos el objeto OpenSSL
  fOpenSSL := TOpenSSL.Create();
end;

procedure TestTOpenSSL.TearDown;
begin
  FreeAndNil(fOpenSSL);
end;

function TestTOpenSSL.EncriptarUsandoOpenSSL(aCadena: String; aTipoEncripcion:
    TTipoDigestionOpenSSL): string;
var
  sResultadoMD5OpenSSL: WideString;
  TipoEncripcion: String;
const
  _ARCHIVO_CERTIFICADO = 'aaa010101aaa_CSD_01.cer';
  _ARCHIVO_LLAVE_PEM = 'aaa010101aaa_CSD_01.pem';
  _ARCHIVO_CADENA_TEMPORAL = 'cadena_hacerdigestion.txt';
  _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL = 'cadena_hacerdigestion.txt';
begin
  Assert(FileExists(fArchivoLlavePrivada), 'No existio el archivo de llave privada:' + fArchivoLlavePrivada);

  case aTipoEncripcion of
    tdMD5: TipoEncripcion:='md5';
    tdSHA1: TipoEncripcion:='sha1';
  end;

  // Borramos los archivos temporales que vamos a usar si acaso existen (de pruebas pasadas)
  BorrarArchivoTempSiExiste(_ARCHIVO_CADENA_TEMPORAL);
  BorrarArchivoTempSiExiste(_ARCHIVO_TEMPORAL_RESULTADO_OPENSSL);
  BorrarArchivoTempSiExiste(TipoEncripcion + '_cadena_de_prueba.bin');

  Sleep(100);

  // Guardamos el contenido de la cadena de prueba a un archivo temporal
  guardarArchivoEnUTF8(UTF8Encode(aCadena),
                                  _ARCHIVO_CADENA_TEMPORAL);

  // Generamos el archivo PEM de la llave privada para usarla con OpenSSL
  EjecutarComandoOpenSSL('pkcs8 -inform DER -in ' + fArchivoLlavePrivada +
                         ' -passin pass:' + fClaveLlavePrivada +
                         ' -out ' + fDirTemporal + _ARCHIVO_LLAVE_PEM);

  // Primero hacemos la digestion usando openssl.exe y la linea de comandos
  EjecutarComandoOpenSSL('dgst -' + TipoEncripcion + ' -sign "' + fDirTemporal + _ARCHIVO_LLAVE_PEM +
    '" -out "' + fDirTemporal + '\' + TipoEncripcion + '_cadena_de_prueba.bin" "' + fDirTemporal +
    _ARCHIVO_CADENA_TEMPORAL + '"');

  // Convertimos el resultado (archivo binario) a base64
  EjecutarComandoOpenSSL(' enc -base64 -in "' + fDirTemporal +
    TipoEncripcion + '_cadena_de_prueba.bin" -out "' + fDirTemporal +
    _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL + '"');

  // Quitamos los retornos de carro ya que la codificacion Base64 de OpenSSL la regresa con ENTERs
  sResultadoMD5OpenSSL := QuitarRetornos(leerContenidoDeArchivo(fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL));
  //CodeSite.Send(TipoEncripcion + ' OpenSSL', sResultadoMD5OpenSSL);
  Result := sResultadoMD5OpenSSL;
end;

procedure TestTOpenSSL.HacerDigestion_TipoMD5_FuncioneCorrectamente;
var
  sResultadoMD5DeClase, sResultadoMD5OpenSSL: WideString;
const
  // Se puede probar la efectividad del metodo cambiando la siguiente cadena
  // la cual debe ser la misma entre el resultado de la clase y de comandos manuales de Openssl.exe
  _CADENA_DE_PRUEBA = '||2.0|AA|2|2010-11-03T13:36:23|35|2008|ingreso|UNA SOLA EXHIBICIÓN|13360.00|0.00|15497.60|FIFC000101AM1|CONTRIBUYENTE DE PRUEBA' +
               ' FICTICIO FICTICIO|1|99|CENTRO|SAN MIGUEL XOXTLA|SAN MIGUEL XOXTLA|PUEBLA|MÉXICO|72620|CPC400101CM9|CONTRIBUYENTE DE PRUEBA CUATRO' +
               ' SA DE CV|AV HIDALGO|77|GUERRERO|DISTRITO FEDERAL|México|06300|1.00|PZ|1|Mac Book Air|10000.00|10000.00|3.00|PZ|2|Magic Mouse|900.00' +
               '|2700.00|5.50|HRS|3|Servicio de soporte técnico|120.00|660.00|IVA|16.00|1600.00|IVA|16.00|432.00|IVA|16.00|105.60|2137.60||';

begin
  // Encriptamos la cadena de prueba usando OpenSSL para comparar los resultados
  sResultadoMD5OpenSSL:=EncriptarUsandoOpenSSL(_CADENA_DE_PRUEBA, tdMD5);

  {$IF Compilerversion < 20}
  // Si es Delphi 2009 o menor codificamos el String usando la funcion de UTF8Encode
  // en Delphi XE2 la cadena ya viene como tipo String que es igual que UnicodeString
  _CADENA_DE_PRUEBA := UTF8Encode(_CADENA_DE_PRUEBA);
  {$IFEND}

  // Ahora, hacemos la digestion con la libreria
  sResultadoMD5DeClase := fOpenSSL.HacerDigestion(fArchivoLlavePrivada,
                                                  fClaveLlavePrivada,
                                                  _CADENA_DE_PRUEBA,
                                                  tdMD5);

  //CodeSite.Send('MD5 TFacturacion', sResultadoMD5DeClase);

  // Comparamos los resultados (sin retornos de carro), los cuales deben de ser los mismos
  CheckEquals(sResultadoMD5OpenSSL,
              sResultadoMD5DeClase,
              'La digestion MD5 de la clase no fue la misma que la de OpenSSL');
end;

procedure TestTOpenSSL.HacerDigestion_TipoSHA1_FuncioneCorrectamente;
var
  sResultadoSHADeClase, sResultadoSHAOpenSSL: WideString;
const
  _CADENA_DE_PRUEBA = '||2.0|AA|2|2010-11-03T13:36:23|35|2008|ingreso|UNA SOLA EXHIBICIÓN|13360.00|0.00|15497.60|FIFC000101AM1|CONTRIBUYENTE DE PRUEBA' +
               ' FICTICIO FICTICIO|1|99|CENTRO|SAN MIGUEL XOXTLA|SAN MIGUEL XOXTLA|PUEBLA|MÉXICO|72620|CPC400101CM9|CONTRIBUYENTE DE PRUEBA CUATRO' +
               ' SA DE CV|AV HIDALGO|77|GUERRERO|DISTRITO FEDERAL|México|06300|1.00|PZ|1|Mac Book Air|10000.00|10000.00|3.00|PZ|2|Magic Mouse|900.00' +
               '|2700.00|5.50|HRS|3|Servicio de soporte técnico|120.00|660.00|IVA|16.00|1600.00|IVA|16.00|432.00|IVA|16.00|105.60|2137.60||';

begin
  // Encriptamos la cadena de prueba usando OpenSSL para comparar los resultados
  sResultadoSHAOpenSSL:=EncriptarUsandoOpenSSL(_CADENA_DE_PRUEBA, tdSHA1);

  {$IF Compilerversion < 20}
  // Si es Delphi 2009 o menor codificamos el String usando la funcion de UTF8Encode
  // en Delphi XE2 la cadena ya viene como tipo String que es igual que UnicodeString
  _CADENA_DE_PRUEBA := UTF8Encode(_CADENA_DE_PRUEBA);
  {$IFEND}

  // Ahora, hacemos la digestion con la libreria
  sResultadoSHADeClase := fOpenSSL.HacerDigestion(fArchivoLlavePrivada,
                                                  fClaveLlavePrivada,
                                                  _CADENA_DE_PRUEBA,
                                                  tdSHA1);

  // Comparamos los resultados (sin retornos de carro), los cuales deben de ser los mismos
  CheckEquals(sResultadoSHAOpenSSL,
              sResultadoSHADeClase,
              'La digestion SHA1 de la clase no fue la misma que la de OpenSSL');
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
     sFecha, sTxt, sMes, sHora, sAno, sDia, hora, min, seg: String;
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

      hora := Copy(sHora, 1, 2);
      min := Copy(sHora, 4, 2);
      seg := Copy(sHora, 7, 2);

      // Procesamos la fecha que regresa OpenSSL para convertirla a formato Delphi
      Result:=EncodeDateTime(StrToInt(sAno),
                             NombreMesANumero(sMes),
                             StrToInt(sDia),
                             StrToInt(hora),
                             StrToInt(min),
                             StrToInt(seg),
                             0);
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

const
  _LONGITUD_NUMERO_SERIE_CERTIFICADO = 20;
begin
  BorrarArchivoTempSiExiste(fDirTemporal + 'VigenciaInicio.txt');

  Assert(FileExists(fRutaFixtures + _RUTA_CERTIFICADO),
        'Debe existir el certificado antes de poder ejecutar la prueba');

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
  try
    CodeSite.Send(Certificado.AsBase64);
    CheckTrue(Certificado <> nil, 'Se debio haber obtenido una instancia al certificado');
    // Checamos las propiedades que nos interesan
    CheckEquals(dtInicioVigencia, Certificado.NotBefore, 'El inicio de vigencia del certificado no fue el mismo que regreso OpenSSL');
    CheckEquals(dtFinVigencia, Certificado.NotAfter, 'El fin de vigencia del certificado no fue el mismo que regreso OpenSSL');
    CheckEquals(sNumSerie, Certificado.SerialNumber, 'El numero de serie del certificado no fue el mismo que regreso OpenSSL');
    // Checamos que la longitud del Numero de Serie sea de 20 (especificada en el RFC 3280 de la especificacion X509)
    CheckEquals(_LONGITUD_NUMERO_SERIE_CERTIFICADO,
                Length(Certificado.SerialNumber),
                'La longitud del numero de serie no fue la correcta');
  finally
     FreeAndNil(Certificado);
  end;
end;

procedure
    TestTOpenSSL.ObtenerModulusDeCertificado_DeCertificado_RegreseValorCorrecto;
var
  openSSL: TOpenSSL;
  modulusCertificado, modulusCertificadoEsperado: string;
begin
  // Obtenemos el modulus del Certificado usando OpenSSL.exe
  EjecutarComandoOpenSSL(' x509 -inform DER -in "' + fRutaFixtures + _RUTA_CERTIFICADO +
                          '" -noout -modulus > "' + fDirTemporal + 'ModulusCertificado.txt" ');
  modulusCertificadoEsperado := leerContenidoDeArchivo(fDirTemporal + 'ModulusCertificado.txt');
  // Quitamos la palabra "Modulus=" que regresa OpenSSL
  modulusCertificadoEsperado := StringReplace(modulusCertificadoEsperado, 'Modulus=', '', [rfReplaceAll]);
  try
    openSSL := TOpenSSL.Create;
    modulusCertificado := openSSL.ObtenerModulusDeCertificado(fRutaFixtures + _RUTA_CERTIFICADO);

    CheckTrue(modulusCertificado <> '', 'No se obtuvo el Modulus del Certificado');
    CheckEquals(modulusCertificadoEsperado,
                modulusCertificado,
                'El modulus del certificado obtenido no fue el mismo que regresó OpenSSL.exe');
  finally
    openSSL.Free;
  end;
end;

procedure
    TestTOpenSSL.ObtenerModulusDeLlavePrivada_DeLlave_RegreseValorCorrecto;
var
  openSSL: TOpenSSL;
  modulusDeLlave, modulusDeLlaveEsperado: string;
begin
  // Desencriptamos la llave privada
  EjecutarComandoOpenSSL(' pkcs8 -inform DER -in "' + fArchivoLlavePrivada +
                          '" -passin pass:'+ fClaveLlavePrivada + ' -out "' + fDirTemporal + 'llaveprivada.key" ');

  // Obtenemos el modulus de la Llave Privada usando OpenSSL.exe para corroborarlo
  EjecutarComandoOpenSSL(' rsa -in  "' + fDirTemporal + 'llaveprivada.key"' +
                          ' -noout -modulus > "' + fDirTemporal + 'ModulusLlave.txt" ');

  modulusDeLlaveEsperado := leerContenidoDeArchivo(fDirTemporal + 'ModulusLlave.txt');
  // Quitamos la palabra "Modulus=" que regresa OpenSSL
  modulusDeLlaveEsperado := StringReplace(modulusDeLlaveEsperado, 'Modulus=', '', [rfReplaceAll]);
  try
    openSSL := TOpenSSL.Create;
    modulusDeLlave := openSSL.ObtenerModulusDeLlavePrivada(fArchivoLlavePrivada, fClaveLlavePrivada);

    CheckTrue(modulusDeLlave <> '', 'No se obtuvo el Modulus de la Llave Privada');
    CheckEquals(modulusDeLlaveEsperado,
                modulusDeLlave,
                'El modulus de la Llave Privada obtenido no fue el mismo que regresó OpenSSL.exe');
  finally
    openSSL.Free;
  end;
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTOpenSSL.Suite);

end.
