(******************************************************************************
 Libreria usada para interactuar con la libreria OpenSSL y exportar sus metodos
 de hashing/digestion usando una llave privada.

 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
 unit ClaseOpenSSL;

interface

uses libeay32, SysUtils, Windows;

  type

    TTipoDigestion = (tdMD5, tdSHA1);
    TNoExisteArchivoException = Exception;
    TLlaveFormatoIncorrectoException = Exception;
    TLlaveLecturaException = Exception;
    TLlavePrivadaClaveIncorrectaException = Exception;

    ///<summary>Clase que representa a la liberia OpenSSL y que tiene
    ///  metodos usados para generar el sello digital (digestion md5) y
    ///  lectura de la llave privada en su formato nativo binario (.key)
    ///</summary>
    TOpenSSL = class
        fArchivoLlavePrivada: String;
        fClaveLlavePrivada: String;
    private
        function ObtenerLlavePrivadaDesencriptada() : pEVP_PKEY;
        ///<summary>Funcion usada para convertir un buffer de bytes
        /// en caracteres 'imprimibles' (codificacion base64).
        ///</summary>
        function BinToBase64(const PDat: PBYTE; const DatLen: DWORD): String;
        function ObtenerUltimoMensajeDeError: string;
    public
        /// <summary>Crea el objeto, inicializa la liberia OpenSSL, y establece la llave privada a usar</summary>
        /// <param name="ArchivoLlavePrivada">Ruta completa al archivo de llave privada a usar (archivo con extension .key)</param>
        /// <param name="ClaveLlavePrivada">La clave privada a usar para abrir el archivo de llave privada</param>
        constructor Create(ArchivoLlavePrivada, ClaveLlavePrivada: String); overload;
        /// <summary>Hace una digestion (hashing) de la Cadena segun el Tipo de digestion y regresa el resultado en formato base64</summary>
        /// <param name="sCadena">Cadena a la cual se va a hacer la digestion</param>
        /// <param name="trTipo">Tipo de digestion a realizar (tdMD5, tdSHA1)</param>
        function HacerDigestion(sCadena: WideString; trTipo: TTipoDigestion) : String;
        destructor Destroy;
    end;

implementation

uses  StrUtils, libeay32plus;

constructor TOpenSSL.Create(ArchivoLlavePrivada, ClaveLlavePrivada: String);
begin
  OpenSSL_add_all_algorithms;
  OpenSSL_add_all_ciphers;
  OpenSSL_add_all_digests;
  ERR_load_crypto_strings;

  // Seed the pseudo-random number generator
  // This should be something a little more "random"!
  // RAND_load_file('c:\windows\paint.exe', 512);

  fArchivoLlavePrivada:=ArchivoLlavePrivada;
  fClaveLlavePrivada:= ClaveLlavePrivada;
end;

destructor TOpenSSL.Destroy;
begin
  	EVP_cleanup;
    inherited;
end;

// Funcion obtenida de: DelphiAccess - http://www.delphiaccess.com/forum/index.php?topic=3092.0
// Usuario: axesys
function TOpenSSL.BinToBase64(const PDat: PBYTE; const DatLen: DWORD): string;
const BaseTable: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var s, s1: string;
	i, p, len, n, Addnum: DWORD;
	PBin: PBYTE;
begin
	result := '';
	S := '';
	addnum := 0;
	PBin := PDat;
	for i := 1 to DatLen do
	begin
		S := S + IntToHex(PBin^, 2);
		PBin := PBYTE(DWORD(PDat) + i);
	end;
	case (length(s) mod 3) of
		0: addnum := 0;
		1: begin
				s := s + '00';
				addnum := 2;
			end;
		2: begin
				s := s + '0';
				addnum := 1;
			end;
	end;
	len := length(s) div 3;
	for i := 1 to len do
	begin
		s1 := midstr(S, i * 3 - 2, 3);
		p := strtoint('$' + s1);
		n := p div 64;
		result := result + basetable[n + 1];
		n := p mod 64;
		result := result + basetable[n + 1];
	end;
	if addnum = 1 then result := result + '==';
	if addnum = 2 then result[length(result)] := '=';
end;

// Regresa el ultimo mensaje de error reportado por la liberia de OpenSSL
// Funcion copiada de OpenSSLUtils.pas de Marco Ferrante
function TOpenSSL.ObtenerUltimoMensajeDeError: string;
var
  {$IF CompilerVersion >= 20}
     ErrMsg: array [0..160] of WideChar;
  {$ELSE}
      ErrMsg: array [0..160] of Char;
  {$IFEND}
begin
  ERR_error_string(ERR_get_error, @ErrMsg);
  result := StrPas(PAnsiChar(@ErrMsg));
end;

// Metodo creado por Luis Carrasco (luis@bambucode.com) con ayuda de
// Marco Ferrante <marco@csita.unige.it>
// Lee una llave binaria (.key) que tiene formato DER en memoria
// para ser usada para hacer una digestion MD5, SHA1, etc. sin necesidad
// de crear y usar un archivo PEM primero
function TOpenSSL.ObtenerLlavePrivadaDesencriptada() : pEVP_PKEY;
var
    bioArchivoLlave : pBIO;
    sMsgErr: String;
    p8 : pX509_SIG;
    p8inf : pPKCS8_Priv_Key_Info;
    resLlave   : pEVP_PKEY;
    {$IF CompilerVersion >= 20}
        p8pass: PAnsiChar;
    {$ELSE}
        p8pass: PChar;
    {$IFEND}
begin
    // Creamos el objeto en memoria para leer la llave en formato binario .DER (.KEY)
    bioArchivoLlave := BIO_new(BIO_s_file());

    if Not FileExists(fArchivoLlavePrivada) then
      Raise TNoExisteArchivoException.Create('El archivo de llave privada no existe.');

    // Checamos que la extension de la llave privada sea la correcta
    if AnsiPos('.PEM', Uppercase(fArchivoLlavePrivada)) > 0 then
      Raise TLlaveFormatoIncorrectoException.Create('La llave privada debe de ser el archivo binario (.key, .cer) y no el formato base64 .pem');

    // Leemos el archivo de llave binario en el objeto creado en memoria
    // DIferentes parametros si usa Delphi 2009 o superior...
    {$IF CompilerVersion >= 20}
        if BIO_read_filename(bioArchivoLlave, PWideChar(AnsiString(fArchivoLlavePrivada))) = 0 then
    {$ELSE}
        if BIO_read_filename(bioArchivoLlave, PChar(AnsiString(fArchivoLlavePrivada))) = 0 then
    {$IFEND}
          raise TLlaveLecturaException.Create('Error al leer llave privada. Error reportado: '+ ObtenerUltimoMensajeDeError);

    // Convertimos al tipo adecuado de acuerdo a la version de Delphi...
    {$IF CompilerVersion >= 20}
        // Delphi 2009 o superior
        p8pass:=PAnsiChar(AnsiString(fClaveLlavePrivada));
    {$ELSE}
        p8pass:=PChar(AnsiString(fClaveLlavePrivada));
    {$IFEND}

    p8:=nil;
    p8inf:=nil;

    try
        //  Leemos la llave en formato binario (PKCS8)
        p8 := d2i_PKCS8_bio(bioArchivoLlave, nil);
        if not Assigned(p8) then
          raise TLlaveLecturaException.Create('Error al leer llave privada. Error reportado: '+ ObtenerUltimoMensajeDeError);

        // Des encriptamos la llave usando la clave proporcionada
        p8inf := PKCS8_decrypt(p8, p8pass, StrLen(p8pass));
        if Not Assigned(p8inf) then
        begin
           sMsgErr:=ObtenerUltimoMensajeDeError;
           // TODO: Crear excepciones para los diferentes tipos de error que puede haber al
           // tratar de desencriptar la llave privada
           // Llave incorrecta (Mensaje exacto: 23077074:PKCS12 routines:PKCS12_pbe_crype:pkcs12 cipherfinal error)
           if AnsiPos('cipherfinal error', sMsgErr) > 0 then
              raise TLlavePrivadaClaveIncorrectaException.Create('La clave de la llave privada fue incorrecta')
           else
              raise TLlaveLecturaException.Create('Error al desencriptar llave privada. Error reportado: '+ ObtenerUltimoMensajeDeError);
        end;
    finally
        // Liberamos las variables usadas en memoria
        X509_SIG_free(p8);
	      BIO_free(bioArchivoLlave);
        EVP_cleanup;
    end;

    // Convierte la llave de formato PKCS8 a PEM (en memoria)
    resLlave := EVP_PKCS82PKEY(p8inf);

    // Se tuvo exito al desencriptar la llave???
    Result:=resLlave;

    // NOTA: Es responsabilidad de el metodo que llama a esta funcion de ejecutar el
    // siguiente codigo EVP_PKEY_free(pkey); una vez usado el resultado de la misma
end;

function TOpenSSL.HacerDigestion(sCadena: WideString; trTipo: TTipoDigestion) : String;
var
  mdctx: EVP_MD_CTX;
  {$IF CompilerVersion >= 20}
      Inbuf: Array [0..8192] of AnsiChar;
      Outbuf: array [0..1023] of AnsiChar;
  {$ELSE}
      Inbuf: Array [0..8192] of Char;
      Outbuf: array [0..1023] of Char;
  {$IFEND}
	ekLlavePrivada: pEVP_PKEY;
  Len: cardinal;
begin
  Len:=0;
  ekLlavePrivada := ObtenerLlavePrivadaDesencriptada;
  // Copiamos la cadena al buffer de entrada
  StrPCopy(inbuf,sCadena);

  if not Assigned(ekLlavePrivada) then
    Raise TLlaveLecturaException.Create('No fue posible leer la llave privada');

  // Establecemos el tipo de digestion a realizar
  case trTipo of
    tdMD5: EVP_SignInit(@mdctx,EVP_md5());
    tdSHA1: EVP_SignInit(@mdctx,EVP_sha1());
  end;

  // Establece los datos que vamos a usar
	EVP_SignUpdate(@mdctx,@inbuf,StrLen(inbuf));
  // Realiza la digestion usando la llave privada que obtuvimos y leimos en memoria
	EVP_SignFinal(@mdctx,@outbuf,Len,ekLlavePrivada);
  // Liberamos el puntero a la llave privada usada previamente
  EVP_PKEY_free(ekLlavePrivada);

	Result := BinToBase64(@outbuf,Len);
end;

end.
