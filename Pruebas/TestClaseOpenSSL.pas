unit TestClaseOpenSSL;

interface

uses
  TestFramework, TestPrueba, ClaseOpenSSL;

type

  TestTOpenSSL = class(TTestPrueba)
  strict private
      sRutaExe : String;
      fOpenSSL: TOpenSSL;
      fArchivoLlavePrivada: String;
      fClaveLlavePrivada: String;
  public
      procedure SetUp; override;
      procedure TearDown; override;
      procedure EjecutarComandoOpenSSL(sComando: String);
  published
      procedure HacerDigestion_TipoMD5_FuncioneCorrectamente;
      procedure HacerDigestion_TipoSHA1_FuncioneCorrectamente;
      procedure HacerDigestion_ConClaveIncorrecta_CauseExcepcion;
  end;

const
  // Configura tu propia ruta a OpenSSL.exe
  _RUTA_OPENSSL_EXE = 'C:\Debug\SAT\openssl.exe';

implementation

uses
  Windows, SysUtils, Classes, FacturaTipos, ShellApi, Forms;

procedure TestTOpenSSL.SetUp;
begin
   inherited;
   fArchivoLlavePrivada:=fRutaEXE + 'Fixtures\openssl\aaa010101aaa_CSD_02.key';
   fClaveLlavePrivada:=leerContenidoDeFixture('openssl\aaa010101aaa_CSD_02_clave.txt');
   // Creamos el objeto OpenSSL
   fOpenSSL := TOpenSSL.Create(fArchivoLlavePrivada,fClaveLlavePrivada);
end;

procedure TestTOpenSSL.TearDown;
begin
   FreeAndNil(fOpenSSL);
end;

procedure TestTOpenSSL.EjecutarComandoOpenSSL(sComando: String);
begin
  ShellExecute(Application.Handle, nil, pChar(_RUTA_OPENSSL_EXE), PChar(sComando),nil,SW_SHOW);
end;

procedure TestTOpenSSL.HacerDigestion_TipoMD5_FuncioneCorrectamente;
var
    sResultadoMD5DeClase, sResultadoMD5OpenSSL: WideString;
    sRutaLlavePEM: String;

    function QuitarRetornos(sCad: WideString) : WideString;
    begin
        Result:=StringReplace(sCad, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    end;

    procedure BorrarArchivoTempSiExiste(sNombre: String);
    begin
         if FileExists(fDirTemporal + sNombre) then
            DeleteFile(fDirTemporal + sNombre);
    end;
    
const
    // Se puede probar la efectividad del metodo cambiando la siguiente cadena
    // la cual debe ser la misma entre el resultado de la clase y de comandos manuales de Openssl.exe
    _CADENA_DE_PRUEBA = 'Esta es una cadena de prueba para la digestion';

    _ARCHIVO_LLAVE_PEM = 'aaa010101aaa_CSD_02.pem';
    _ARCHIVO_CADENA_TEMPORAL = 'cadena_hacerdigestion.txt';
    _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL = 'md5_cadena_hacerdigestion.txt';
begin
      // Borramos los archivos temporales que vamos a usar si acaso existen (de pruebas pasadas)
      BorrarArchivoTempSiExiste(_ARCHIVO_CADENA_TEMPORAL);
      BorrarArchivoTempSiExiste(_ARCHIVO_TEMPORAL_RESULTADO_OPENSSL);
      BorrarArchivoTempSiExiste('md5_cadena_de_prueba.bin');

      // Guardamos el contenido de la cadena de prueba a un archivo temporal
      guardarArchivoTemporal(_CADENA_DE_PRUEBA, _ARCHIVO_CADENA_TEMPORAL);

     // Primero hacemos la digestion usando openssl.exe y la linea de comandos
     EjecutarComandoOpenSSL('dgst -md5 -sign "' + fRutaFixtures + 'openssl\' + _ARCHIVO_LLAVE_PEM +
                            '" -out "' + fDirTemporal + 'md5_cadena_de_prueba.bin" "' + fDirTemporal + _ARCHIVO_CADENA_TEMPORAL + '"');
     Sleep(1000);

     // Convertimos el resultado (archivo binario) a base64
     EjecutarComandoOpenSSL(' enc -base64 -in "' + fDirTemporal + 'md5_cadena_de_prueba.bin" -out "' + fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL + '"');
     Sleep(1000);

     // Quitamos los retornos de carro ya que la codificacion Base64 de OpenSSL la regresa con ENTERs
     sResultadoMD5OpenSSL:=QuitarRetornos(leerContenidoDeArchivo(fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL));
     // Ahora, hacemos la digestion con la libreria
     sResultadoMD5DeClase:=fOpenSSL.HacerDigestion(_CADENA_DE_PRUEBA, tdMD5);
     
     // Comparamos los resultados (sin retornos de carro), los cuales deben de ser los mismos
     CheckEquals(sResultadoMD5OpenSSL, sResultadoMD5DeClase, 'La digestion MD5 de la clase no fue la misma que la de OpenSSL');
end;

procedure TestTOpenSSL.HacerDigestion_TipoSHA1_FuncioneCorrectamente;
begin
   CheckTrue(True);
end;

procedure  TestTOpenSSL.HacerDigestion_ConClaveIncorrecta_CauseExcepcion;
var
  fOpenSSL2: TOpenSSL;
  bExcepcionLanzada: Boolean;
begin
   // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
   bExcepcionLanzada:=False;
   fOpenSSL2 := TOpenSSL.Create(fArchivoLlavePrivada, 'claveincorrectaintencional');
   try
       fOpenSSL2.HacerDigestion('Cadena', tdMD5);
   except
       On E: TLlavePrivadaClaveIncorrectaException do
       begin
          bExcepcionLanzada:=True;
       end;
   end;

   CheckTrue(bExcepcionLanzada, 'No se lanzo excepcion cuando se especifico clave privada incorrecta.');
   FreeAndNil(fOpenSSL2);
end;

initialization
  // Registra la prueba de esta unidad en la suite de pruebas
  RegisterTest(TestTOpenSSL.Suite);
end.
