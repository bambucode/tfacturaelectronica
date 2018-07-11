{ ******************************************************* }
{                                                         }
{ TFacturaElectronica                                     }
{                                                         }
{ Soporte del PAC Facturacion México                      }
{                                                         }
{ ******************************************************* }

unit Facturacion.PAC.FacturacionMexico;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     FacturacionMexicoWsTimbrado,
{$IF CompilerVersion >= 23}
   System.Types,
   System.SysUtils,
   System.Classes
{$ELSE}
   Types,
   SysUtils,
   Classes
{$IFEND}
 ;

type

   TProveedorFacturacionMexico = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
   private
      fwsTimbrado: wservicePortType;
      fDominioWebService: string;
      fCredencialesPAC: TFacturacionCredencialesPAC;
      fParametros: TStrings;
      function ExtraerNodoTimbre(const aComprobanteXML: RawByteString) : TCadenaUTF8;
      procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
      function UTF8ToBytes(const s: TCadenaUTF8): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
      function BytesToUTF8(const ABytes: TBytedynArray): TCadenaUTF8; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
      function Decode64(S: String): TByteDynArray;  // http://delphiaccess.com/foros/index.php/topic/11984-base64/
      function Encode64(Bin: PByte; Count: integer): String; // http://delphiaccess.com/foros/index.php/topic/11984-base64/
   public
      procedure AfterConstruction; override;
      destructor Destroy; override;
      procedure  Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
      function Parametros: TStrings;
      function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8; overload;
      function TimbrarDocumento(const aXML : TCadenaUTF8; const aTransaccion : Int64): TCadenaUTF8; overload;
      function ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
      function CancelarDocumento(const aUUID: TCadenaUTF8): Boolean; overload;
      function CancelarDocumento(const aUUID: TCadenaUTF8; var aExtraInfo: TCadenaUTF8): Boolean; overload;
      function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID;
      function ObtenerAcuseDeCancelacion(const aUUID: string): string;
      function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string;
      function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8;
   end;

implementation

uses
   Facturacion.Tipos,
{$IF Compilerversion >= 23}
     System.RegularExpressions,
     Xml.xmldom,
     Xml.XMLIntf,
     Xml.Win.Msxmldom,
     Xml.XMLDoc
{$ELSE}
    {$IF Compilerversion >= 22}
     RegularExpressions,
   {$ELSE}
     PerlRegEx,
   {$IFEND}
     xmldom,
     XMLIntf,
     Msxmldom,
     XMLDoc
{$IFEND}
 ;

const
  SB64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  IB64: array[#0..#255] of integer = (
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3E, $FF, $FF, $FF, $3F,
    $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $FF, $FF, $FF, $FF, $FF,
    $FF, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28,
    $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
  );

  type
  SAByte = Array[0..0] of Byte;
  PSAByte = ^SAByte;

{ TProveedorSolucionFactible }

procedure TProveedorFacturacionMexico.AfterConstruction;
begin
  inherited;
  Parametros.Values[PAC_PARAM_SVC_MODO_PRODUCCION] := 'SI';
  Parametros.Values[PAC_PARAM_SVC_CFDI_VERSION]    := PAC_VALOR_CFDI_VERSION_33;
end;

function TProveedorFacturacionMexico.AgregarCliente(const aRFC, aRazonSocial,
  aCorreo: String): string;
begin

end;

function TProveedorFacturacionMexico.BytesToUTF8(
  const ABytes: TBytedynArray): TCadenaUTF8;
begin
   SetLength(Result, Length(ABytes));
   if Length(Result) > 0 then
      Move(abytes[0], Result[1], Length(ABytes));
end;

function TProveedorFacturacionMexico.CancelarDocumento(
  const aUUID: TCadenaUTF8): Boolean;
begin


end;

function TProveedorFacturacionMexico.CancelarDocumento(const aUUID: TCadenaUTF8;
  var aExtraInfo: TCadenaUTF8): Boolean;
var
 LRespuestaCancelacion: RespuestaCancelacion;
begin
  LRespuestaCancelacion := fwsTimbrado.cancelar( fCredencialesPAC.RFC, fCredencialesPAC.Clave, aUUID,
  Parametros.Values[PAC_PARAM_SEGURIDAD_CERTIFICADO],
  Parametros.Values[PAC_PARAM_SEGURIDAD_LLAVEPRIVADA],
  Parametros.Values[PAC_PARAM_SEGURIDAD_LLAVEPRIVADA_CLAVE]  );
  if LRespuestaCancelacion.codigo_mf_numero=0 then
  begin
   result := true;
   aExtraInfo := LRespuestaCancelacion.acuse;
  end
  else
  begin
   Result := false;
   aExtraInfo := Format('Error No. %d: "%s"',[LRespuestaCancelacion.codigo_mf_numero, LRespuestaCancelacion.codigo_mf_texto]);
  end;
end;

function TProveedorFacturacionMexico.CancelarDocumentos(
  const aUUID: TListadoUUID): TListadoCancelacionUUID;
var LIdx: Integer;
    LExtraInfo: TCadenaUTF8;
begin
 for Lidx := Low(aUUID) to High(aUUID) do
 begin
  if not assigned(result) then
      Result := TListadoCancelacionUUID.Create;
  result.Add(aUUID[LIdx], CancelarDocumento(aUUID[LIdx], LExtraInfo));
 end;
end;

procedure TProveedorFacturacionMexico.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
begin
   fDominioWebService := aWsTimbrado;
   fCredencialesPAC := aCredencialesPAC;
   // Inicializamos las instancias de los WebServices
   fwsTimbrado := GetwservicePortTypeRandom(False, fDominioWebService);

  Parametros.Values[PAC_PARAM_SESION_PAC_USUARIO_ID] := aCredencialesPAC.RFC;
  Parametros.Values[PAC_PARAM_SESION_PAC_USUARIO_CLAVE] := aCredencialesPAC.Clave;
  Parametros.Values[PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID] := aCredencialesPAC.DistribuidorID;

  Parametros.Values[PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID] := aCredencialesIntegrador.RFC;
  Parametros.Values[PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE] := aCredencialesIntegrador.Clave;
  Parametros.Values[PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID] := aCredencialesIntegrador.DistribuidorID;

  Parametros.Values[PAC_PARAM_SESION_TRANSACCION_INICIAL] := IntToStr(aTransaccionInicial);

  Parametros.Values[PAC_PARAM_SVC_URL_API] := aWsTimbrado;

  Parametros.Values[PAC_PARAM_SVC_URL_API_TIMBRADO] := aWsTimbrado;
  Parametros.Values[PAC_PARAM_SVC_URL_API_CLIENTES] := aWsTimbrado;
  Parametros.Values[PAC_PARAM_SVC_URL_API_CANCELACION] := aWsTimbrado;

end;

function TProveedorFacturacionMexico.Decode64(S: String): TByteDynArray;
var
  B: array[0..3] of BYTE;
  L, n, i, j: integer;
begin
  n:= 1;
  i:= 0;
  L:= Length(S);
  if L < 4 then exit;
  while S[L] = '=' do dec(L);
  SetLength(Result, (L*3) div 4);
  repeat
    for j:= 0 to 3 do
    begin
      while (n < L) and (IB64[S[n]] = $FF) do inc(n); B[j]:= IB64[S[n]]; inc(n);
    end;
    Result[i]:=   (B[0] shl 2) or (B[1] shr 4);
    if B[2] = 255 then break;
    Result[i+1]:= (B[1] shl 4) or (B[2] shr 2);
    if B[3] = 255 then break;
    Result[i+2]:= (B[2] shl 6) or B[3];
    inc(i, 3);
  until n > L;
end;

destructor TProveedorFacturacionMexico.Destroy;
begin
  if Assigned(fParametros) then
     FreeAndNil(fParametros);
  inherited;
end;

// sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
function TProveedorFacturacionMexico.UTF8ToBytes(const s:  TCadenaUTF8): TBytedynArray;
begin
   {$IF Compilerversion >= 20}
   Assert(StringElementSize(s) = 1)
   {$IFEND};
   SetLength(Result, Length(s));
   if Length(Result) > 0 then
      Move(s[1], Result[0], Length(s));
end;

function TProveedorFacturacionMexico.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
begin
 Result := TimbrarDocumento( UTF8Encode( aComprobante.XML ), aTransaccion );
end;

function TProveedorFacturacionMexico.ObtenerAcuseDeCancelacion(
  const aUUID: string): string;
begin

end;

function TProveedorFacturacionMexico.ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
var LSaldoReponse: saldoResponse;
begin
 result := -1;
 try
  LSaldoReponse := fwsTimbrado.saldo(aRFC, fCredencialesPAC.Clave);
  if LSaldoReponse.codigo_mf_numero=0 then
  begin
   Result := LSaldoReponse.saldo;
  end
  else
  begin
    raise EPACException.Create('Error al Consultar Saldo. Error No. ' +
                                IntToStr(LsaldoReponse.codigo_mf_numero) +
                                   ' / Detalle: ' +LsaldoReponse.codigo_mf_texto,
                                   0,
                                   LSaldoReponse.codigo_mf_numero, false);
  end;

 except
 end;



    result := lsaldoreponse.saldo
   {No existe esta funcionalidad para Solucion Factible, dejada solo por compatibilidad.}
end;

function TProveedorFacturacionMexico.ObtenerTimbrePrevio(
  const aIdTransaccionOriginal: Int64): TCadenaUTF8;
begin

end;

function TProveedorFacturacionMexico.Encode64(Bin: PByte;
  Count: integer): String;
var
  B0, B1, B2: BYTE;
  ABin: PSAByte;
  L, n, i: integer;
begin
  if Count = 0 then exit;
  ABin:= PSAByte(Bin);
  n:= 0;
  i:=1;
  L:= ((Count+2) div 3)*4;
  SetLength(Result, L);
  repeat
    B0:= ABin^[n];
    B1:= 0; B2:= 0;
    if (Count - n) > 0 then B1:= ABin^[n+1];
    if (Count - n) > 1 then B2:= ABin^[n+2];
    Result[i]:=   SB64[(B0 shr 2) and $003F +1];
    Result[i+1]:= SB64[((B0 shl 4) or (B1 shr 4)) and $3F +1];
    Result[i+2]:= SB64[((B1 shl 2) or (B2 shr 6)) and $3F +1];
    Result[i+3]:= SB64[(B2 and $3F) +1];
    inc(n,3);
    inc(i,4);
  until n >= Count;
  if n - Count >= 1 then Result[L]:=   '=';
  if n - Count = 2  then Result[L-1]:= '=';
end;

function TProveedorFacturacionMexico.ExtraerNodoTimbre(const aComprobanteXML: RawByteString): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
{$IF Compilerversion < 20}
  LRegEx: TPerlRegEx;
{$IFEND}
const
 _REGEX_TIMBRE = '<tfd:TimbreFiscalDigital.*?/>';
begin
  Assert(aComprobanteXML <> '',
    'La respuesta del servicio de timbrado fue nula');
 {$IF Compilerversion >= 22}
  // Delphi XE1 y superiores
  contenidoComprobanteXML := aComprobanteXML;
  Result := TRegEx.Match(contenidoComprobanteXML, _REGEX_TIMBRE).Value;
 {$ELSE}
  contenidoComprobanteXML := UTF8Encode(aComprobanteXML);
  LRegEx := TPerlRegEx.Create;
  try
  	LRegEx.RegEx := _REGEX_TIMBRE;
  	LRegEx.Options := [];
  	LRegEx.State := [];
  	LRegEx.Subject := contenidoComprobanteXML;
	 if LRegEx.Match then begin
	 	Result := LRegEx.MatchedText;
	 end
  	else begin
  		Result := '';
  	end;
  finally
   LRegex.Free;
  end;
 {$IFEND}

  Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

function TProveedorFacturacionMexico.Parametros: TStrings;
begin
if not Assigned(fParametros) then
    fParametros := TStringList.Create;
 result := fParametros;
end;

procedure TProveedorFacturacionMexico.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
   mensajeExcepcion: string;
   numeroErrorSAT: Integer;
begin
   mensajeExcepcion := aExcepcion.Message;
   raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TProveedorFacturacionMexico.TimbrarDocumento(const aXML: TCadenaUTF8;
  const aTransaccion: Int64): TCadenaUTF8;
var
   respuestaTimbrado: Respuesta;
   sXML: TBytedynArray;
   sXMLStr: TCadenaUTF8;
   aByteArray: TByteDynArray;
   {$IF Compilerversion < 20}
     Buffer: AnsiString;
   {$ifeNd}

begin
   sXMLStr := Encode64( PByte(UTF8ToBytes( aXml )), Length(aXml) );

   if Parametros.Values[PAC_PARAM_SVC_CFDI_VERSION] = PAC_VALOR_CFDI_VERSION_33 then
      respuestaTimbrado := fwsTimbrado.timbrar33(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, Parametros.Values[PAC_PARAM_SVC_MODO_PRODUCCION])
   else
      respuestaTimbrado := fwsTimbrado.timbrar32(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, Parametros.Values[PAC_PARAM_SVC_MODO_PRODUCCION]);

   if respuestaTimbrado.codigo_mf_numero=0 then
   Begin
    sXMLStr := respuestaTimbrado.cfdi;
    sXMLStr := UTF8Decode( BytesToUTF8( Decode64(sXMLStr) ) );
    Result := ExtraerNodoTimbre(sXMLStr)
   End
    else
       raise EPACException.Create('Error de Timbrado CFDI. Error No. ' +
                                   IntToStr(respuestaTimbrado.codigo_mf_numero) +
                                   ' / Detalle: ' +respuestaTimbrado.codigo_mf_texto,
                                   0,
                                   respuestaTimbrado.codigo_mf_numero, false);

end;
end.
