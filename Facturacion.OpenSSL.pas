{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}
unit Facturacion.OpenSSL;

interface

uses Facturacion.Comprobante,
     libeay32,
     OpenSSLUtils,
     LibEay32plus,
{$IF CompilerVersion >= 23}
     Winapi.Windows,
     System.SysUtils
{$ELSE}
     Windows,
     SysUtils
{$IFEND};

type

  TMetodoDigestion = (tdMD5, tdSHA1, tdSHA256);
  ENoExisteArchivoException = class(Exception);
  ECertificadoLlaveEsFiel = class(Exception);
  ECertificadoFallaLecturaException = class(Exception);
  ELlaveFormatoIncorrectoException = class(Exception);
  ELlaveLecturaException = class(Exception);
  ELlavePrivadaClaveIncorrectaException = class(Exception);
  ELlavePareceSerFiel = class(Exception);
  ELongitudBufferPequenoException = class(Exception);


  /// <summary>
  ///   Instancia de OpenSSL usada para realizar diferentes procesos de
  ///   digestión de cadenas
  /// </summary>
  IOpenSSL = interface
    ['{AF899DF4-2A9A-497C-AD90-13B22D7ACC35}']
    /// <summary>
    ///   Se encarga de pre-asignar la Llave Privada que se usará en el método
    ///   HacerDigestion quedando "en cache" para futuros llamados.
    /// </summary>
    /// <param name="aRutaArchivoLlavePrivada">
    ///   Ruta completa de la Llave Privada
    /// </param>
    /// <param name="aContrasena">
    ///   Clave de la Llave Privada
    /// </param>
    procedure AsignarLlavePrivada(const aRutaArchivoLlavePrivada: String;
                                  const aContrasena: String);
    /// <summary>
    ///   Se encarga de realizar la digestion de la cadena usando la llave
    ///   privada previamente asignada con el método AsignarLlavePrivada
    /// </summary>
    /// <param name="aCadena">
    ///   Cadena a encriptar
    /// </param>
    /// <param name="aTipoDigestion">
    ///   Tipo de digestión, MD5, SHA1, SHA256
    /// </param>
    /// <returns>
    ///   Cadena encriptada Base64
    /// </returns>
    /// <exception cref="ELlaveLecturaException">
    ///   Si no se ha asignado la llave privada previamente y se intenta hacer
    ///   la digestion
    /// </exception>
    function HacerDigestion(const aCadena: TCadenaUTF8;
                            const aTipoDigestion: TMetodoDigestion): TCadenaUTF8;
    /// <summary>
    ///   Se encarga de calcular el SHA1 de la cadena
    /// </summary>
    /// <returns>
    ///   SHA1 base 64
    /// </returns>
    /// <remarks>
    ///   <note type="note">
    ///     De momento esta función solo funciona en Delphi XE2 y delante
    ///     pues depende de la unidad System.Hash.
    ///   </note>
    /// </remarks>
    function CalcularSHA1(const aCadena: TCadenaUTF8) : TCadenaUTF8;
    function SonPareja(const aRutaCertificado, aRutaLlavePrivada: TFileName; const aClaveLlavePrivada : String): Boolean;
  end;



  TOpenSSL = class(TInterfacedObject, IOpenSSL)
  private
    fLlavePrivadaDesencriptada : pEVP_PKEY;

    function AbrirLlavePrivada(const aRuta, aClaveLlavePrivada: String):
        pPKCS8_Priv_Key_Info;
    function ObtenerLlavePrivadaDesencriptada(const aRutaLlavePrivada,
                                              aClaveLlavePrivada: String): pEVP_PKEY;
    procedure AlmacenarLlavePrivadaEnMemoria(const aRutaLlavePrivada, aClave: String);
    procedure LiberarLlavePrivadaSiAsignada;
    function ObtenerUltimoMensajeDeError: string;
    function BinToBase64(const PDat: PBYTE; const DatLen: DWORD): string;
    function ObtenerModulusDeCertificado(const aRutaCertificado: string): String;
    function ObtenerModulusDeLlavePrivada(const aRutaLlavePrivada, aClaveLlavePrivada: String): String;
  public
    destructor Destroy; override;
    procedure AsignarLlavePrivada(const aRutaArchivoLlavePrivada, aContrasena:
        string);
    procedure AfterConstruction; override;
    function SonPareja(const aRutaCertificado, aRutaLlavePrivada: TFileName; const
        aClaveLlavePrivada : String): Boolean;
    function HacerDigestion(const aCadena: TCadenaUTF8;
                            const aTipoDigestion: TMetodoDigestion): TCadenaUTF8;

    function CalcularSHA1(const aCadena: TCadenaUTF8) : TCadenaUTF8;
  end;

implementation

uses
{$IF CompilerVersion >= 23}
     System.StrUtils,
     System.Hash
{$ELSE}
     StrUtils
{$IFEND}
{$IFDEF CODESITE}
     ,CodeSiteLogging
{$ENDIF};


{ TOpenSSL }

procedure TOpenSSL.AfterConstruction;
begin
  inherited;

  OpenSSL_add_all_algorithms;
  OpenSSL_add_all_ciphers;
  OpenSSL_add_all_digests;
  ERR_load_crypto_strings;
end;

destructor TOpenSSL.Destroy;
begin
  LiberarLlavePrivadaSiAsignada;
  EVP_cleanup;

  inherited;
end;

procedure TOpenSSL.AsignarLlavePrivada(const aRutaArchivoLlavePrivada,
    aContrasena: string);
begin
  // Checamos si ya tenemos una llave privada previamente
  LiberarLlavePrivadaSiAsignada;

  AlmacenarLlavePrivadaEnMemoria(aRutaArchivoLlavePrivada,
                                 aContrasena);
end;

function TOpenSSL.HacerDigestion(const aCadena: TCadenaUTF8; const
    aTipoDigestion: TMetodoDigestion): TCadenaUTF8;
var
  mdctx: EVP_MD_CTX;
  {$IF CompilerVersion >= 20}
      Inbuf: Array[0..999999] of AnsiChar; // Antes [0..8192]
      Outbuf: array [0..1024] of AnsiChar;
  {$ELSE}
      Inbuf: Array[0..999999] of Char;
      Outbuf: array [0..1024] of Char;
  {$IFEND}
  Len, Tam: cardinal;
begin
  Len := 0;

  // Verificamos tener la llave privada desencriptada
  if not Assigned(fLlavePrivadaDesencriptada) then
    Raise ELlaveLecturaException.Create('No se tiene asiganada la llave privada, favor de asignarla con el metodo AsignarLlavePrivada');

  Tam:=Length(aCadena); // Obtenemos el tamaño de la cadena original
  try
      {$IF CompilerVersion >= 23}System.SysUtils{$ELSE}SysUtils{$IFEND}.StrPLCopy(inbuf, aCadena, Tam);  // Copiamos la cadena original al buffer de entrada
  except
      On E:Exception do
      begin
          if Pos('Access', E.Message) > 0 then
             Raise ELongitudBufferPequenoException.Create('Error de sellado digital: La cadena original fue mas grande que el tamaño del buffer,' +
                                                          'por favor intente aumentando el tamaño del buffer.');
      end;
  end;

  // Establecemos el tipo de digestion a realizar
  case aTipoDigestion of
    tdMD5     : EVP_SignInit(@mdctx, EVP_md5());
    tdSHA1    : EVP_SignInit(@mdctx, EVP_sha1());
    tdSHA256  : EVP_SignInit(@mdctx, EVP_sha256());
  end;

  // Establece los datos que vamos a usar
  EVP_SignUpdate(@mdctx,@inbuf,{$IF CompilerVersion >= 23}System.SysUtils{$ELSE}SysUtils{$IFEND}.StrLen(inbuf));

  // Realiza la digestion usando la llave privada que obtuvimos y leimos en memoria
  EVP_SignFinal(@mdctx, @outbuf, Len, fLlavePrivadaDesencriptada);

  // Regresa los resultados en formato Base64
  Result := BinToBase64(@outbuf,Len);
end;

function TOpenSSL.CalcularSHA1(const aCadena: TCadenaUTF8): TCadenaUTF8;
var
  Tam, Len: Cardinal;
  {$IF CompilerVersion >= 20}
      Inbuf: Array[0..1023] of AnsiChar;
      Outbuf: array[0..999999] of AnsiChar;
  {$ELSE}
      Inbuf: Array[0..1023] of Char;
      Outbuf: array [0..1023] of Char;
  {$IFEND}
  ctx : EVP_MD_CTX;
  res: Integer;
  sData, sha1delphi: String;
  hashbytes: TBytes;
begin
  // Ref: http://www.disi.unige.it/person/FerranteM/delphiopenssl/example2.html

  // Usamos la funcion nativa de Delphi para SHA1
  {$IF CompilerVersion >= 23}
    Result := THashSHA1.GetHashString(aCadena);
  {$ELSE}
    raise Exception.Create('Soporte SHA1 nativo para versiones anteriores no implementado');

    // NOTA: El siguiente codigo no funciona aun...
    Tam:=Length(aCadena); // Obtenemos el tamaño de la cadena original
    StrPLCopy(inbuf, aCadena, Tam);
    EVP_DigestInit(@ctx, EVP_sha1());
    EVP_DigestUpdate(@ctx, @Inbuf, StrLen(Inbuf));
    EVP_DigestFinal(@ctx, PByte(@Outbuf), Len);

    Result := BinToBase64(@Outbuf, Length(Outbuf));
  {$IFEND}
end;

// Funcion obtenida de: DelphiAccess - http://www.delphiaccess.com/forum/index.php?topic=3092.0
// Usuario: axesys
function TOpenSSL.BinToBase64(const PDat: PBYTE; const DatLen: DWORD): string;
const
  BaseTable: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
  s, s1: string;
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

  //{$IFDEF CODESITE} CodeSite.Send('HEX', S); {$ENDIF}

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
     ErrMsg: array [0..160] of AnsiChar;
  {$ELSE}
      ErrMsg: array [0..160] of Char;
  {$IFEND}
begin
  {$WARNINGS OFF}
  ERR_error_string(ERR_get_error, @ErrMsg);
  result := StrPas(PAnsiChar(@ErrMsg));
  {$WARNINGS ON}
end;

function TOpenSSL.AbrirLlavePrivada(const aRuta, aClaveLlavePrivada: String):
    pPKCS8_Priv_Key_Info;
var
  bioArchivoLlave : pBIO;
  sMsgErr: String;
  p8 : pX509_SIG;
  p8inf : pPKCS8_Priv_Key_Info;
  {$IF CompilerVersion >= 20}
      p8pass: PAnsiChar;
  {$ELSE}
      p8pass: PChar;
  {$IFEND}
begin
  // Creamos el objeto en memoria para leer la llave en formato binario .DER (.KEY)
  bioArchivoLlave := BIO_new(BIO_s_file());

  if Not FileExists(aRuta) then
    Raise ENoExisteArchivoException.Create('El archivo de llave privada no existe: ' + aRuta);

  // Checamos que la extension de la llave privada sea la correcta
  if AnsiPos('.PEM', Uppercase(aRuta)) > 0 then
    Raise ELlaveFormatoIncorrectoException.Create('La llave privada debe de ser el archivo binario (.key, .cer) y ' +
          'no el formato base64 .pem');

  // Leemos el archivo de llave binario en el objeto creado en memoria
  // DIferentes parametros si usa Delphi 2009 o superior...
  {$IF CompilerVersion >= 20}
      if BIO_read_filename(bioArchivoLlave, PWideChar(AnsiString(aRuta))) = 0 then
  {$ELSE}
      if BIO_read_filename(bioArchivoLlave, PChar(AnsiString(aRuta))) = 0 then
  {$IFEND}
        raise ELlaveLecturaException.Create('Error al leer llave privada. Error reportado: '+
              ObtenerUltimoMensajeDeError);

  // Checamos que la clave no esté vacia
  if Trim(aClaveLlavePrivada) = '' then
    raise ELlavePrivadaClaveIncorrectaException.Create('La clave de la llave privada esta vacia');

  // Convertimos al tipo adecuado de acuerdo a la version de Delphi...
  {$IF CompilerVersion >= 20}
      // Delphi 2009 o superior
      p8pass:=PAnsiChar(AnsiString(aClaveLlavePrivada));
  {$ELSE}
      p8pass:=PChar(AnsiString(aClaveLlavePrivada));
  {$IFEND}

  p8:=nil;
  p8inf:=nil;

  try
      //  Leemos la llave en formato binario (PKCS8)
      p8 := d2i_PKCS8_bio(bioArchivoLlave, nil);
      if not Assigned(p8) then
        raise ELlaveLecturaException.Create('Error al leer llave privada. Error reportado: '+
              ObtenerUltimoMensajeDeError);

      // Des encriptamos la llave en memoria usando la clave proporcionada
      p8inf := PKCS8_decrypt(p8, p8pass, StrLen(p8pass));
      if Not Assigned(p8inf) then
      begin
         sMsgErr:=ObtenerUltimoMensajeDeError;
         // TODO: Crear excepciones para los diferentes tipos de error que puede haber al
         // tratar de desencriptar la llave privada
         // Llave incorrecta (Mensaje exacto: 23077074:PKCS12 routines:PKCS12_pbe_crype:pkcs12 cipherfinal error)
         if ((AnsiPos('cipherfinal error', sMsgErr) > 0) or // clave incorrecta
            (AnsiPos('bad decrypt', sMsgErr) > 0))   // clave incorrecta
         then
            raise ELlavePrivadaClaveIncorrectaException.Create('La clave de la llave privada fue incorrecta')
         else
            if (AnsiPos('unknown pbe algorithm', sMsgErr) > 0) then // Clave vacia o pertenece a la FIEL
              Raise ELlavePareceSerFiel.Create('Al parecer la llave privada pertenece a la FIEL')
            else
              raise ELlaveLecturaException.Create('Error desconocido al desencriptar llave privada. Error reportado: '+
                    ObtenerUltimoMensajeDeError);
            // 'error:0607606B:lib(6):func(118):reason(107)'
      end;
  finally
      // Liberamos las variables usadas en memoria
      X509_SIG_free(p8);
      BIO_free(bioArchivoLlave);
  end;

  Result:=p8inf;
end;

// Metodo creado por Luis Carrasco (luis@bambucode.com) con ayuda de
// Marco Ferrante <marco@csita.unige.it>
// Lee una llave binaria (.key) que tiene formato DER en memoria
// para ser usada para hacer una digestion MD5, SHA1, SHA256, etc. sin necesidad
// de crear y usar un archivo PEM primero
function TOpenSSL.ObtenerLlavePrivadaDesencriptada(const aRutaLlavePrivada,
    aClaveLlavePrivada: String): pEVP_PKEY;
var
  p8inf : pPKCS8_Priv_Key_Info;
  resLlave   : pEVP_PKEY;
begin
  // Abrimos la llave privada
  p8inf:=AbrirLlavePrivada(aRutaLlavePrivada, aClaveLlavePrivada);

  // Convierte la llave de formato PKCS8 a PEM (en memoria)
  resLlave := EVP_PKCS82PKEY(p8inf);

  // Se tuvo exito al desencriptar la llave???
  Result:=resLlave;

  // NOTA: Es responsabilidad de el metodo que llama a esta funcion de ejecutar el
  // siguiente codigo EVP_PKEY_free(pkey); una vez usado el resultado de la misma
end;

procedure TOpenSSL.AlmacenarLlavePrivadaEnMemoria(const aRutaLlavePrivada,
    aClave: String);
begin
  fLlavePrivadaDesencriptada := ObtenerLlavePrivadaDesencriptada(aRutaLlavePrivada, aClave);

  if not Assigned(fLlavePrivadaDesencriptada) then
    Raise ELlaveLecturaException.Create('No fue posible leer la llave privada');
end;

function TOpenSSL.ObtenerModulusDeCertificado(const aRutaCertificado: string): String;
var
  llavePublica: PEVP_PKEY;
  bioModulus: pBIO;
  rsaInfo: pRSA;
  Inbuf: Array[0..1000] of AnsiChar;
  certificadoX509: TX509Certificate;
  longitudModulus: Integer;
begin
  bioModulus := BIO_new(BIO_s_mem());
  try
    certificadoX509 := TX509Certificate.Create;
    certificadoX509.LoadFromFile(aRutaCertificado);

    // Obtenemos la llave publica del certificado
    llavePublica := X509_get_pubkey(certificadoX509.fCertificate);
    if (llavePublica <> nil) then
    begin
      // Replicamos el codigo de x509.c lineas 820 -> 830
      if llavePublica.ktype = EVP_PKEY_RSA then
      begin
         rsaInfo := EVP_PKEY_get1_RSA(llavePublica);
         if BN_print(bioModulus, rsaInfo.n) <= 0 then
           raise Exception.Create('No fue posible obtener el Modulus del Certificado');

        // Leemos el Modulus del BIO en el buffer de cadena
        longitudModulus := BIO_read(bioModulus, @Inbuf, SizeOf(Inbuf));

        {$IFDEF CODESITE}
          CodeSite.Send('Modulus Certificado', Copy(StrPas(InBuf), 1, longitudModulus));
        {$ENDIF};

        Result := Copy(StrPas(InBuf), 1, longitudModulus);
      end else
        raise Exception.Create('No se soporta la lectura de certificados que no son RSA');
  end;
  finally
    BIO_free_all(bioModulus);
    certificadoX509.Free;
  end;
end;

function TOpenSSL.ObtenerModulusDeLlavePrivada(const aRutaLlavePrivada,
    aClaveLlavePrivada: String): String;
var
  rsaInfo: pRSA;
  bioModulus: pBIO;
  llaveDesencriptada: pEVP_PKEY;
  Inbuf: Array[0..1000] of AnsiChar;
  longitudModulus : Integer;
begin
  llaveDesencriptada := ObtenerLlavePrivadaDesencriptada(aRutaLlavePrivada, aClaveLlavePrivada);
  // Obtenemos las propiedades RSA de la Llave privada
  rsaInfo := EVP_PKEY_get1_RSA(llaveDesencriptada);
  // Creamos un BIO en memoria para almacenar el dato del Modulus
  bioModulus := BIO_new(BIO_s_mem());
  try
    // Asignamos el Modulus (propieda N del record RSA, rsa.c linea 336)
    if rsaInfo.n <> nil then
    begin
      // La funcion BN_print copia el apuntador del BIGNUMBER del modulus con un formato amigable dentro del BIO
      if BN_print(bioModulus, rsaInfo.n) <= 0 then
        raise Exception.Create('No fue posible obtner el Modulus de la Llave Privada');

      // Leemos el Modulus del BIO en el buffer de cadena
      longitudModulus := BIO_read(bioModulus, @Inbuf, SizeOf(Inbuf));

      {$IFDEF CODESITE}
        CodeSite.Send('Modulus Llave Privada', Copy(StrPas(InBuf), 1, longitudModulus));
      {$ENDIF};

      Result := Copy(StrPas(InBuf), 1, longitudModulus);
    end else
      Result := '';
  finally
     // Liberamos el BIO que teniamos en memoria
     BIO_free_all(bioModulus);
     EVP_PKEY_free(llaveDesencriptada);
  end;
end;


function TOpenSSL.SonPareja(const aRutaCertificado, aRutaLlavePrivada: TFileName; const aClaveLlavePrivada : String): Boolean;
var
  moduloLlavePrivada, moduloCertificado : string;
begin
  if Not FileExists(aRutaLlavePrivada) then
    raise Exception.Create('El archivo de llave privada no existe: ' + aRutaLlavePrivada);

  moduloLlavePrivada  := ObtenerModulusDeLlavePrivada(aRutaLlavePrivada, aClaveLlavePrivada);
  moduloCertificado   := ObtenerModulusDeCertificado(aRutaCertificado);

  {$IFDEF CODESITE}
  CodeSite.Send('Modulus Llave Privada', moduloLlavePrivada);
  CodeSite.Send('Modulus Certificado', moduloCertificado);
  CodeSite.Send('¿Son Pareja?', moduloCertificado = moduloLlavePrivada);
  {$ENDIF}

  Result := (moduloLlavePrivada = moduloCertificado);
end;

procedure TOpenSSL.LiberarLlavePrivadaSiAsignada;
begin
  // Liberamos el puntero a la llave privada usada previamente
  if fLlavePrivadaDesencriptada <> nil then
    EVP_PKEY_free(fLlavePrivadaDesencriptada);
end;

end.
