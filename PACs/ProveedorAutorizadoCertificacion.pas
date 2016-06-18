{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la estructura de un PAC para basarse en ella
  y poder implementar a un nuevo PAC. Se deben de implementar los métodos
  definidos en esta clase.

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit ProveedorAutorizadoCertificacion;

interface

uses Classes,
    {$IF Compilerversion >= 20}
      System.Types,
    {$ELSE}
      Types,
    {$IFEND}
     SynaCode,
     SysUtils,
     FinkOkwsTimbrado,
     FacturaTipos,
     Math;

type

// Definimos el tipo nativo en Delphi para enviar el XML al PAC
TTipoComprobanteXML = String;

{$REGION 'Documentation'}
///	<summary>
///	  Clase padre abstracta que representa a un proveedor autorizado de certificacion
///	  (PAC) y los métodos de timbrado y cancelación que todos deben de
///	  soportar. Todas las implementaciones de PAC deben heredar esta clase
///	</summary>
{$ENDREGION}
 TProveedorAutorizadoCertificacion = class
 protected
  function getNombre() : String; virtual; abstract;
  function getAcuseXML() : TUnicodeString; overload; virtual; abstract;
 public
  constructor Create(const aDominioWebService: string; const
      aDominioWebServiceSeguridad: String = ''; const aDominioWebServiceRespaldo:
      String = ''; const aDominioWebServiceCancelacion: string = ''); overload; virtual; abstract;
  constructor Create(const aDominioWebService: string); overload; virtual; abstract;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); overload; virtual; abstract;
  procedure AsignarCredenciales(const aCredenciales, aCredencialesIntegrador: TFEPACCredenciales); overload; virtual; abstract;
  function ObtenerAcuseDeCancelacion(const aDocumento: TTipoComprobanteXML): string; virtual; abstract;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; virtual; abstract;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; virtual; abstract;
  function AgregaCliente(const aNuevoEmisor: TFEContribuyente): String; virtual; abstract;
  function EditaCliente(const Activar: Boolean;const aRFC:String):String; virtual; abstract;
  function BorraCliente(const aRFC: String):String; virtual; abstract;
  function SaldoCliente(const aRFC: String) : Integer; virtual; abstract;
  property Nombre : String read getNombre;
  property Acuse : TUnicodeString read getAcuseXML;
 end;
 TFuncionesComunesPAC = class
  public
   function ExtraerUUID(const aDocumentoTimbrado: TTipoComprobanteXML) : String;
   function FileToByteArray( const FileName : string ) : TByteDynArray;
   function WStringToArray(const S: WideString): StringArray;
   function UTF8Bytes(const s: TUnicodeString): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
   function EncodeF(const Archivo: string): TUnicodeString;
 end;

implementation
function TFuncionesComunesPAC.EncodeF(const Archivo: string): TUnicodeString;
function MemoryStreamToString(M: TMemoryStream): TUnicodeString; //extraida de http://stackoverflow.com/questions/732666/converting-tmemorystream-to-string-in-delphi-2009
begin
  SetString(Result, PChar(M.Memory), M.Size div SizeOf(Char));
end;
var
 {$IF Compilerversion >= 20}
  stream : TStringStream;
 {$ELSE}
  stream : TMemoryStream;
 {$IFEND}
begin
  try
 {$IF Compilerversion >= 20}
   stream := TStringStream.Create;
   stream.LoadFromFile(Archivo);
   result :=  EncodeBase64(stream.DataString);
 {$ELSE}
   stream := TMemoryStream.Create;
   stream.LoadFromFile(Archivo);
  result :=  EncodeBase64(MemoryStreamToString(stream));
 {$IFEND}
  finally
    stream.Free;
  end;
end;

function TFuncionesComunesPAC.UTF8Bytes(const s: TUnicodeString): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
begin
{$IF Compilerversion >= 20}Assert(StringElementSize(s)=1){$IFEND};
  SetLength(Result, Length(s)+1);
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
  Result[high(Result)] := 0;
end;

function TFuncionesComunesPAC.ExtraerUUID(const aDocumentoTimbrado: TTipoComprobanteXML) : String;
const
  _LONGITUD_UUID = 36;
begin
    Result:=Copy(aDocumentoTimbrado,
                 AnsiPos('UUID="', aDocumentoTimbrado) + 6,
                 _LONGITUD_UUID);
end;

function TFuncionesComunesPAC.FileToByteArray( const FileName : string ) : TByteDynArray;
const BLOCK_SIZE=1024;
var BytesRead, BytesToWrite, Count : integer;
 F : FIle of Byte;
 pTemp : Pointer;
begin
 AssignFile( F, FileName );
 Reset(F);
try
 Count := FileSize( F );
 SetLength(Result, Count );
 pTemp := @Result[0];
 BytesRead := BLOCK_SIZE;
 while (BytesRead = BLOCK_SIZE ) do
 begin
  BytesToWrite := Min(Count, BLOCK_SIZE);
  BlockRead(F, pTemp^, BytesToWrite , BytesRead );
   pTemp := Pointer(LongInt(pTemp) + BLOCK_SIZE);
  Count := Count-BytesRead;
 end;
finally
  CloseFile( F );
 end;
end;

function TFuncionesComunesPAC.WStringToArray(const S: WideString): StringArray;
var
i : integer;
begin
SetLength(result, Length(S) div 36); //cada uuid es de 36 caracteres
if Length(S) > 0 then
for i := 1 to Length(S) div 36 do begin
SetLength(result[i-1], Length(S));
result[i-1] := S;
end;
end;

end.
