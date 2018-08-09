{ ******************************************************* }
{                                                         }
{ TFacturaElectronica                                     }
{                                                         }
{ Soporte del PAC MultiFacturas                           }
{                                                         }
{ ******************************************************* }

unit Facturacion.PAC.MultiFacturas;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     MultiFacturasWsTimbrado,
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

   TProveedorMultiFacturas = class(TProveedorAutorizadoCertificacionBase, IProveedorAutorizadoCertificacion)
   private
      fwsTimbrado: wservicePortType;
      fDominioWebService: string;
      fCredencialesPAC: TFacturacionCredencialesPAC;
      procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
      function UTF8ToBytes(const s: TCadenaUTF8): TByteDynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
      function BytesToUTF8(const ABytes: TByteDynArray): TCadenaUTF8; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
      function Decode64(S: String): TByteDynArray;  // http://delphiaccess.com/foros/index.php/topic/11984-base64/
      function Encode64(Bin: PByte; Count: integer): String; // http://delphiaccess.com/foros/index.php/topic/11984-base64/
   public
      procedure AfterConstruction; override;
      destructor Destroy; override;
      procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
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

procedure TProveedorMultiFacturas.AfterConstruction;
begin
  inherited;
  AsignarParametro(PAC_PARAM_SVC_CFG_MULTIPLES_URLS, PAC_VALOR_SI);
end;

function TProveedorMultiFacturas.AgregarCliente(const aRFC, aRazonSocial,
  aCorreo: String): string;
begin

end;

function TProveedorMultiFacturas.BytesToUTF8(
  const ABytes: TByteDynArray): TCadenaUTF8;
begin
   SetLength(Result, Length(ABytes));
   if Length(Result) > 0 then
      Move(abytes[0], Result[1], Length(ABytes));
end;

function TProveedorMultiFacturas.CancelarDocumento(
  const aUUID: TCadenaUTF8): Boolean;
var LExtraInfo: TCadenaUTF8;
begin

 result := CancelarDocumento(aUUID, LExtraInfo);

end;

function TProveedorMultiFacturas.CancelarDocumento(const aUUID: TCadenaUTF8;
  var aExtraInfo: TCadenaUTF8): Boolean;
var
 LRespuestaCancelacion: RespuestaCancelacion;
begin
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);

  LRespuestaCancelacion := fwsTimbrado.cancelar( fCredencialesPAC.RFC, fCredencialesPAC.Clave, aUUID,
   ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO),
   ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA),
   ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE) );
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

function TProveedorMultiFacturas.CancelarDocumentos(
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

procedure TProveedorMultiFacturas.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
begin
   fDominioWebService := aWsTimbrado;
   fCredencialesPAC := aCredencialesPAC;

   // Inicializamos las instancias de los WebServices
   if ObtenerParametro(PAC_PARAM_SVC_CFG_MULTIPLES_URLS)=PAC_VALOR_SI then
      fwsTimbrado := GetwservicePortTypeRandom(False, fDominioWebService)
   else
      fwsTimbrado := GetwservicePortType(False, fDominioWebService);

  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_ID, aCredencialesPAC.RFC);
  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_CLAVE, aCredencialesPAC.Clave);
  AsignarParametro(PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID, aCredencialesPAC.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID, aCredencialesIntegrador.RFC);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE, aCredencialesIntegrador.Clave);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID, aCredencialesIntegrador.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_TRANSACCION_INICIAL, IntToStr(aTransaccionInicial));

  AsignarParametro(PAC_PARAM_SVC_URL_API, aWsTimbrado);

  AsignarParametro(PAC_PARAM_SVC_URL_API_TIMBRADO, aWsTimbrado);
  AsignarParametro(PAC_PARAM_SVC_URL_API_CLIENTES, aWsTimbrado);
  AsignarParametro(PAC_PARAM_SVC_URL_API_CANCELACION, aWsTimbrado);

end;

function TProveedorMultiFacturas.Decode64(S: String): TByteDynArray;
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

destructor TProveedorMultiFacturas.Destroy;
begin
  if Assigned(fParametros) then
     FreeAndNil(fParametros);
  inherited;
end;

// sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
function TProveedorMultiFacturas.UTF8ToBytes(const s:  TCadenaUTF8): TBytedynArray;
begin
   {$IF Compilerversion >= 20}
   Assert(StringElementSize(s) = 1)
   {$IFEND};
   SetLength(Result, Length(s));
   if Length(Result) > 0 then
      Move(s[1], Result[0], Length(s));
end;

function TProveedorMultiFacturas.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
begin
 Result := TimbrarDocumento( UTF8Encode( aComprobante.XML ), aTransaccion );
end;

function TProveedorMultiFacturas.ObtenerAcuseDeCancelacion(
  const aUUID: string): string;
begin

end;

function TProveedorMultiFacturas.ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
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

function TProveedorMultiFacturas.ObtenerTimbrePrevio(
  const aIdTransaccionOriginal: Int64): TCadenaUTF8;
begin

end;

function TProveedorMultiFacturas.Encode64(Bin: PByte;
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

procedure TProveedorMultiFacturas.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
   mensajeExcepcion: string;
   numeroErrorSAT: Integer;
begin
   mensajeExcepcion := aExcepcion.Message;
   raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TProveedorMultiFacturas.TimbrarDocumento(const aXML: TCadenaUTF8;
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

   if ObtenerParametroDef(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_33) = PAC_VALOR_CFDI_VERSION_33 then
      respuestaTimbrado := fwsTimbrado.timbrar33(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, ObtenerParametroDef(PAC_PARAM_SVC_CFG_MODO_PRODUCCION,PAC_VALOR_NO))
   else
      respuestaTimbrado := fwsTimbrado.timbrar32(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, ObtenerParametroDef(PAC_PARAM_SVC_CFG_MODO_PRODUCCION,PAC_VALOR_NO));

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
