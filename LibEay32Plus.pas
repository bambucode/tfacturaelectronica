(******************************************************************************
 Extension de LibEay32.pas de Marco Ferrante para incluir funciones de
 lectura de llaves privadas en formato binario. Creada por:
 Bambu Code SA de CV - Ing. Luis Carrasco

 Probada con Codegear Delphi 2007 y Embarcadero Delphi XE.

 Agradecimientos:
   - Marco Ferrante por su ayuda para importar la funcion PKCS8_decrypt

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente y el resto de la libreria se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)

unit LibEay32Plus;

interface

uses LibEay32;

type

  // Usamos la version correcta del tipo Char segun la version de Delphi usada.
 {$IF CompilerVersion >= 20}
      PCharacter = PAnsiChar;
 {$ELSE}
      PCharacter = PChar;
 {$IFEND}

  pX509_SIG = ^X509_SIG;
  X509_SIG = record
     algor: Pointer; // X509_ALGOR *algor;
     digest: Pointer; // ASN1_OCTET_STRING *digest;
  end;

  pPKCS8_Priv_Key_Info = ^PKCS8_Priv_Key_Info;
  PKCS8_Priv_Key_Info = record
	  broken: Integer; // Flag for various broken formats */
	  version: Pointer; // ASN1_INTEGER *version;
    pkeyalg: Pointer; // X509_ALGOR *pkeyalg;
    pkey: Pointer; // ASN1_TYPE *pkey; /* Should be OCTET STRING but some are broken */
    Attributes: Pointer; // STACK_OF(X509_ATTRIBUTE) *attributes;
	end;

const
  LIBEAY_DLL_NAME = 'libeay32.dll';

function toPCharacter(Str: String) : PCharacter;
// Las siguientes funciones fueron obtenidas del archivo pkcs8.c del codigo fuente de la
// libreria OpenSSL 0.9.6.
function d2i_PKCS8_bio(bp: pBIO; p8: pX509_SIG) : pX509_SIG; cdecl;
procedure X509_SIG_free(a : pX509_SIG); cdecl;
function EVP_PKCS82PKEY(p8 : pPKCS8_Priv_Key_Info) : pEVP_PKEY; cdecl;
function PKCS8_decrypt(p8: pX509_SIG; Pass: PCharacter; PassLen: integer): pPKCS8_Priv_Key_Info; cdecl;
// Funcion usada para guardar la llave privada en formato base64 (PEM)
function PEM_write_bio_PKCS8_PRIV_KEY_INFO(p8 : pPKCS8_Priv_Key_Info; bp: pBIO): Integer; cdecl;
function d2i_PKCS8_PRIV_KEY_INFO(var a: pPKCS8_Priv_Key_Info; pp: PCharacter; Length: LongInt): pPKCS8_Priv_Key_Info; cdecl;
procedure PKCS8_PRIV_KEY_INFO_free(var a: pPKCS8_Priv_Key_Info); cdecl;
// Funciones para obtener datos del certificado
procedure EVP_MD_CTX_init(ctx: PEVP_MD_CTX); cdecl; external LIBEAY_DLL_NAME;
function EVP_MD_CTX_cleanup(ctx: PEVP_MD_CTX): integer; cdecl; external LIBEAY_DLL_NAME;
function ASN1_INTEGER_to_BN(ai: pASN1_INTEGER; bn: pBIGNUM): pBIGNUM; cdecl; external LIBEAY_DLL_NAME;

// Funciones necesarias para obtener el Certificado en Base 64
function OBJ_create(oid, SN, Ln: PCharacter) : Integer; cdecl; external LIBEAY_DLL_NAME;
procedure OBJ_cleanup(); cdecl; external LIBEAY_DLL_NAME;

implementation

uses SysUtils;

function d2i_PKCS8_bio; external LIBEAY_DLL_NAME;
procedure X509_SIG_free; external LIBEAY_DLL_NAME;
function EVP_PKCS82PKEY; external LIBEAY_DLL_NAME;
function d2i_PKCS8_PRIV_KEY_INFO; external LIBEAY_DLL_NAME;
procedure PKCS8_PRIV_KEY_INFO_free; external LIBEAY_DLL_NAME;
function PKCS8_decrypt; external LIBEAY_DLL_NAME;
function PEM_write_bio_PKCS8_PRIV_KEY_INFO; external LIBEAY_DLL_NAME;

{$IF CompilerVersion >= 20}
    function toPCharacter(Str: String) : PCharacter;
    begin
       Result:=PAnsiChar(AnsiString(Str));
    end;
{$ELSE}
    function toPCharacter(Str: String) : PCharacter;
    begin
       Result:=PChar(AnsiString(Str));
    end;
{$IFEND}

end.

