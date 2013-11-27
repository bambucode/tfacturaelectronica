(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Metodos para calcular el cifrado con los algortimos MD5 y SHA1.

 Código original obtenido de:
 http://delphi.jmrds.com/?q=node/36

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit FacturacionHashes;

interface

uses Windows, SysUtils, Classes;

type

  TAlgoritmoHash = (haMD5, haSHA1);

  TFacturacionHashing = class
     class function CalcularHash(const aCadena: string; aAlgoritmo : TAlgoritmoHash) : String;
  end;


{function CalcHash(Stream: TStream; Algorithm: THashAlgorithm): string; overload;
function CalcHash(Archivo: string; Algorithm: THashAlgorithm): string; overload;        }

implementation

type
  HCRYPTPROV = ULONG;
  PHCRYPTPROV = ^HCRYPTPROV;
  HCRYPTKEY = ULONG;
  PHCRYPTKEY = ^HCRYPTKEY;
  HCRYPTHASH = ULONG;
  PHCRYPTHASH = ^HCRYPTHASH;
  LPAWSTR = PAnsiChar;
  ALG_ID = ULONG;

const
  CRYPT_NEWKEYSET = $00000008;
  PROV_RSA_FULL = 1;
  CALG_MD5 = $00008003;
  CALG_SHA1  = $00008004;
  HP_HASHVAL = $0002;

function CryptAcquireContext(phProv: PHCRYPTPROV;
  pszContainer: LPAWSTR;
  pszProvider: LPAWSTR;
  dwProvType: DWORD;
  dwFlags: DWORD): BOOL; stdcall;
  external ADVAPI32 name 'CryptAcquireContextA';

function CryptCreateHash(hProv: HCRYPTPROV;
  Algid: ALG_ID;
  hKey: HCRYPTKEY;
  dwFlags: DWORD;
  phHash: PHCRYPTHASH): BOOL; stdcall;
  external ADVAPI32 name 'CryptCreateHash';

function CryptHashData(hHash: HCRYPTHASH;
  const pbData: PBYTE;
  dwDataLen: DWORD;
  dwFlags: DWORD): BOOL; stdcall;
  external ADVAPI32 name 'CryptHashData';

function CryptGetHashParam(hHash: HCRYPTHASH;
  dwParam: DWORD;
  pbData: PBYTE;
  pdwDataLen: PDWORD;
  dwFlags: DWORD): BOOL; stdcall;
  external ADVAPI32 name 'CryptGetHashParam';

function CryptDestroyHash(hHash: HCRYPTHASH): BOOL; stdcall;
  external ADVAPI32 name 'CryptDestroyHash';

function CryptReleaseContext(hProv: HCRYPTPROV; dwFlags: DWORD): BOOL; stdcall;
  external ADVAPI32 name 'CryptReleaseContext';

function CalcHash(Stream: TStream; Algorithm: TAlgoritmoHash): string; overload;
var
  hProv: HCRYPTPROV;
  hHash: HCRYPTHASH;
  Buffer: PByte;
  BytesRead: DWORD;
  Algid: ALG_ID;
  Data: array[1..20] of Byte;
  DataLen: DWORD;
  Success: BOOL;
  i: integer;
begin
  Result:= EmptyStr;
  Success := CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL, 0);
  if (not Success) then
    if GetLastError() = DWORD(NTE_BAD_KEYSET) then
      Success := CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL,
        CRYPT_NEWKEYSET);
  if Success then
  begin
    if Algorithm = haMD5 then
    begin
      Algid:= CALG_MD5;
      Datalen:= 16
    end else
    begin
      Algid:= CALG_SHA1;
      Datalen:= 20;
    end;
    if CryptCreateHash(hProv, Algid, 0, 0, @hHash) then
    begin
      GetMem(Buffer,10*1024);
      try
        while  TRUE do
        begin
          BytesRead:= Stream.Read(Buffer^, 10*1024);
          if (BytesRead = 0) then
          begin
            if (CryptGetHashParam(hHash, HP_HASHVAL, @Data, @DataLen, 0)) then
              for i := 1 to DataLen do
                Result := Result + LowerCase(IntToHex(Integer(Data[i]), 2));
            break;
          end;
          if (not CryptHashData(hHash, Buffer, BytesRead, 0)) then
            break;
        end;
      finally
        FreeMem(Buffer);
      end;
      CryptDestroyHash(hHash);
    end;
    CryptReleaseContext(hProv, 0);
  end;
end;

function CalcHash(Archivo: string; Algorithm: TAlgoritmoHash): string; overload;
var
  Stream: TFileStream;
begin
  Result:= EmptyStr;
  if FileExists(Archivo) then
  try
    Stream:= TFileStream.Create(Archivo,fmOpenRead or fmShareDenyWrite);
    try
      Result:= CalcHash(Stream,Algorithm);
    finally
      Stream.Free;
    end;
  except end;
end;

class function TFacturacionHashing.CalcularHash(const aCadena: string; aAlgoritmo : TAlgoritmoHash) : String;
var
  Stream: TStringStream;
begin
  Result:= EmptyStr;
  Stream:= TStringStream.Create(aCadena);
  try
    Result:= CalcHash(Stream, aAlgoritmo);
  finally
    Stream.Free;
  end;
end;

end.
