(******************************************************************************
 Extension de LibEay32.pas de Marco Ferrante para incluir funciones de
 lectura de llaves privadas en formato binario. Creada por:
 Bambu Code SA de CV - Ing. Luis Carrasco

 Probada con Codegear Delphi 2007 y Embarcadero Delphi XE.

 Agradecimientos:
   - Marco Ferrante por su ayuda para importar la funcion PKCS8_decrypt

 Este archivo pertenece al proyecto de codigo fuente de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente y el resto de la libreria se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
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

// Las siguientes funciones fueron obtenidas del archivo pkcs8.c del codigo fuente de la
// libreria OpenSSL 0.9.6.
function d2i_PKCS8_bio(bp: pBIO; p8: pX509_SIG) : pX509_SIG; cdecl;
procedure X509_SIG_free(a : pX509_SIG); cdecl;
function EVP_PKCS82PKEY(p8 : pPKCS8_Priv_Key_Info) : pEVP_PKEY; cdecl;
function PKCS8_decrypt(p8: pX509_SIG; Pass: PCharacter; PassLen: integer): pPKCS8_Priv_Key_Info; cdecl;
function d2i_PKCS8_PRIV_KEY_INFO(var a: pPKCS8_Priv_Key_Info; pp: PCharacter; Length: LongInt): pPKCS8_Priv_Key_Info; cdecl;
procedure PKCS8_PRIV_KEY_INFO_free(var a: pPKCS8_Priv_Key_Info); cdecl;


implementation

uses SysUtils;

const
  LIBEAY_DLL_NAME = 'libeay32.dll';

function d2i_PKCS8_bio; external LIBEAY_DLL_NAME;
procedure X509_SIG_free; external LIBEAY_DLL_NAME;
function EVP_PKCS82PKEY; external LIBEAY_DLL_NAME;
function d2i_PKCS8_PRIV_KEY_INFO; external LIBEAY_DLL_NAME;
procedure PKCS8_PRIV_KEY_INFO_free; external LIBEAY_DLL_NAME;
function PKCS8_decrypt; external LIBEAY_DLL_NAME;


end.


