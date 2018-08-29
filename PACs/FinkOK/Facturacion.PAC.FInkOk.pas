{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2018 Bambu Code SA de CV          }
{        Soporte del pac FinkOK TecsisNet.net           }
{                                                       }
{*******************************************************}

unit Facturacion.PAC.FInkOk;

interface
uses
{$IFDEF CODESITE}
     CodeSiteLogging,
{$ENDIF}
{$IF CompilerVersion >= 23}
     System.Types,
     System.SysUtils,
     System.Classes,
     RegularExpressions,
{$ELSE}
     Types,
     SysUtils,
     Classes,
     PerlRegEx,
{$IFEND}
     Math,
     LibEay32Plus,
     XMLDoc,
     OpenSSLUtils,
     Facturacion.OpenSSL,
     Facturacion.CertificadoDeSellos,
     Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     FinkOkWsCancelacion,
     FinkOkWsTimbrado,
     FinkOkWsComun;

type
  TProveedorFinkOk = class(TProveedorAutorizadoCertificacionBase, IProveedorAutorizadoCertificacion)
  private
    fwsTimbradoFinkOk: IFinkOkServicioTimbrado;
    fwsClientesFinkOk: IFinkOkAltaCliente;
    fwsCancelacionFinkOk: IFinkOkServicioCancelacion;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    fCredencialesIntegrador : TFacturacionCredencialesPAC;
    fDocumentoXMLCancelado : TXMLDocument;
    function ExtraerNodoTimbre(const aComprobanteXML : TCadenaUTF8): TCadenaUTF8;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    function UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
    function FileToByteArray( const FileName : string ) : TByteDynArray;
    function WStringToArray(const S: WideString): StringArray;
    function ExtraerUUID(const aDocumentoTimbrado: String) : String;
  public
    procedure  Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8; overload;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
    function CancelarDocumento(const aUUID: TCadenaUTF8): Boolean; overload;
    function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID;
    function ObtenerAcuseDeCancelacion(const aUUID: string): string;
    Function ObtenerEstatus(aUUID,Total,RFCReceptor: TCadenaUTF8):AcuseSATConsulta2;
    function ObtenerRelacionados(aUUID: TCadenaUTF8): Boolean;
    function ObtenerPendientes: stringArray2;
  end;

implementation

{ TProveedorFinkOk }
procedure  TProveedorFinkOk.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
begin
  Assert(aWsTimbrado <> '', 'La instancia aWsTimbrado no debio ser vacia');
  fCredencialesPAC := aCredencialesPAC;
  fCredencialesIntegrador := aCredencialesIntegrador;  
  // Incializamos las instancias de los WebServices
  fwsTimbradoFinkOk := GetWsFinkOkTimbrado(False, aWsTimbrado);
  fwsClientesFinkOk := GetFinkOkCliente(False, aWsClientes);
  fwsCancelacionFinkOk := GetIFinkOkServicioCancelacion(False, aWsCancelacion);
  fCredencialesIntegrador.RFC:=aCredencialesIntegrador.RFC;
end;

function TProveedorFinkOk.FileToByteArray( const FileName : string ) : TByteDynArray;
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

function TProveedorFinkOk.WStringToArray(const S: WideString): StringArray;
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

function TProveedorFinkOk.ExtraerUUID(const aDocumentoTimbrado: String) : String;
const
  _LONGITUD_UUID = 36;
begin
    Result:=Copy(aDocumentoTimbrado,
                 AnsiPos('UUID="', aDocumentoTimbrado) + 6,
                 _LONGITUD_UUID);
end;

function TProveedorFinkOk.UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
begin
{$IF Compilerversion >= 20}Assert(StringElementSize(s)=1){$IFEND};
  SetLength(Result, Length(s));
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
end;

function TProveedorFinkOk.TimbrarDocumento(const aComprobante:
    IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
begin
  sXML := UTF8Bytes(UTF8Encode(aComprobante.XML));
  respuestaTimbrado := fwsTimbradoFinkOk.stamp(sXML,fCredencialesPAC.RFC,fCredencialesPAC.Clave);
  if Trim(respuestaTimbrado.CodEstatus) <> '' then
    Result := ExtraerNodoTimbre(respuestaTimbrado.xml);
  if Trim(respuestaTimbrado.CodEstatus) = '' then
   begin
   {$IFDEF CODESITE}
     CodeSite.Send('Falla Validacion Error No.', respuestaTimbrado.Incidencias[0].CodigoError+'/Detalle :'+respuestaTimbrado.Incidencias[0].MensajeIncidencia);
   {$ELSE}
     CodEstatus(respuestaTimbrado.Incidencias[0].CodigoError);
   {$ENDIF}
   end;
end;

function TProveedorFinkOk.ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
begin
 Result:=0;
end;

function TProveedorFinkOk.ExtraerNodoTimbre(const aComprobanteXML : TCadenaUTF8): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
 {$IF Compilerversion < 20}
  TRegex : TPerlRegex;
 {$ifend}
const
  _REGEX_TIMBRE = '<tfd:TimbreFiscalDigital.*?/>';
begin
  Assert(aComprobanteXML <> '', 'La respuesta del servicio de timbrado fue nula');
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
   contenidoComprobanteXML := aComprobanteXML;
   Result := TRegEx.Match(contenidoComprobanteXML,_REGEX_TIMBRE).Value;
  {$ELSE}
   TRegex := TPerlRegex.Create(nil);
   Try
     TRegex.Subject:=UTF8String(aComprobanteXML);
     TRegex.RegEx:=_REGEX_TIMBRE;
     if TRegex.Match then
      Result:=TRegex.MatchedExpression; 
    Except
       on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    End;
  {$IFEND}
  Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

function TProveedorFinkOk.CancelarDocumento(const aUUID: TCadenaUTF8): Boolean;
var
  certificadoSellos: ICertificadoDeSellos;
  respuestaCancelacion: FinkOKRespuestaCancelacion2;
  sKey,sCer:TByteDynArray;
  fAcuse:String;
  UUID:UUIDS2;
  OpenSSL: TOpenSSL;
  LlaveAbierta: pPKCS8_Priv_Key_Info;
  x509Certificado : TX509Certificate;
  key: TKeyPairGenerator;
begin
 Result:=True;
  fDocumentoXMLCancelado :=TXMLDocument.Create(nil);
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);
 OpenSSL:=TOpenSSL.Create;
 UUID:=UUIDS.Create;
// obtenemos el certificado
 x509Certificado := TX509Certificate.Create;
 x509Certificado.LoadFromFile(ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO));
 sCer:=UTF8Bytes(X509Certificado.AsBase64);
 x509Certificado.Free;
// obtenemos la llave
 llaveAbierta := openSSL.AbrirLlavePrivada(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA),ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE));
 openSSL.GuardarLlavePrivadaEnPEM(llaveAbierta, ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
 OpenSSL.Free;
 sKey:=FileToByteArray(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
//Eliminamos el archivo temporal
 DeleteFile(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
 UUID.UUIDS:=WStringToArray(AUUID);
 try
   respuestaCancelacion := fwsCancelacionFinkOk.cancel(UUID,fCredencialesPAC.RFC,fCredencialesPAC.Clave,
                           fcredencialesIntegrador.RFC,sCer,sKey,False);
       {$IFDEF CODESITE}
      CodeSite.Send('Folio', respuestaCancelacion.CodEstatus);
      CodeSite.Send('Acuse', respuestaCancelacion.Acuse);
      CodeSite.Send('Fecha de Inicio', respuestaCancelacion.Fecha);
      CodeSite.Send('Fecha de fin', respuestaCancelacion.RfcEmisor);
      {$ENDIF}
 if respuestaCancelacion.CodEstatus='' then
  begin
   fAcuse:=respuestaCancelacion.Acuse;
   if Trim(respuestaCancelacion.Folios[0].EstatusUUID)='201' then
    Begin
      {$IF Compilerversion >= 20}
       fDocumentoXMLCancelado.XML.Text:=respuestaCancelacion.Acuse;
      {$ELSE}
       fDocumentoXMLCancelado.XML.Text:=UTF8Encode(respuestaCancelacion.Acuse);
      {$IFEND}
       fDocumentoXMLCancelado.Active:=True;
      if Trim(respuestaCancelacion.CodEstatus)<>'' then
       {$IFDEF CODESITE}
        CodeSite.Send('Falla Validacion Error No.', respuestaCancelacion.CodEstatus);
       {$ELSE}
        raise exception.Create('Falla Validacion Error No.'+ respuestaCancelacion.CodEstatus);
       {$ENDIF}
    End
   Else if (Trim(respuestaCancelacion.Folios[0].EstatusUUID)='202') then
    Begin
     Result:=False;
     raise EPACNoEncontradoParaCancelarException.Create('Petición de cancelación realizada Previamente',-1,202,False);
    End
   else
    Result:=CodEstatus(respuestaCancelacion.Folios[0].EstatusUUID);
  end
 Else
  raise EPACNoEncontradoParaCancelarException.Create(respuestaCancelacion.CodEstatus,-1,-1,False);
 UUID.Free;
 except
  On E: Exception do
   if Not(E Is EPACException) then
   ProcesarExcepcionDePAC(E)
   else
   raise;
 end;
end;

function TProveedorFinkOk.CancelarDocumentos(
  const aUUID: TListadoUUID): TListadoCancelacionUUID;
begin

end;

function TProveedorFinkOk.ObtenerAcuseDeCancelacion(
  const aUUID: string): string;
begin
  Result:=fDocumentoXMLCancelado.XML.Text;
end;

function TProveedorFinkOk.ObtenerEstatus(aUUID,Total,RFCReceptor: TCadenaUTF8): AcuseSATConsulta2;
var
  RespuestaEstatus: AcuseSatEstatus2;
begin
 try
   RespuestaEstatus := fwsCancelacionFinkOk.get_sat_status(fCredencialesPAC.RFC,fCredencialesPAC.Clave,
                           fcredencialesIntegrador.RFC,RFCReceptor,aUUID,Total);
 if RespuestaEstatus.error='' then
  Result:=RespuestaEstatus.sat
 else
  CodEstatus(RespuestaEstatus.error);
 except
  On E: Exception do
   if Not(E Is EPACException) then
   ProcesarExcepcionDePAC(E)
   else
   raise;
 end;
end;

function TProveedorFinkOk.ObtenerPendientes: stringArray2;
var
  RespuestaEstatus: CancelPendingResult2;
begin
 try
   RespuestaEstatus := fwsCancelacionFinkOk.Get_pending(fCredencialesPAC.RFC,fCredencialesPAC.Clave,
                           fcredencialesIntegrador.RFC);
 if RespuestaEstatus.error='' then
  Result:=RespuestaEstatus.uuids
 else
  CodEstatus(RespuestaEstatus.error);
 except
  On E: Exception do
   if Not(E Is EPACException) then
   ProcesarExcepcionDePAC(E)
   else
   raise;
 end;
end;


function TProveedorFinkOk.ObtenerRelacionados(aUUID: TCadenaUTF8): Boolean;
var
  RespuestaRelacionados: RelatedResult2;
  sKey,sCer:TByteDynArray;
  OpenSSL: TOpenSSL;
  LlaveAbierta: pPKCS8_Priv_Key_Info;
  x509Certificado : TX509Certificate;
begin
 Result:=True;
  fDocumentoXMLCancelado :=TXMLDocument.Create(nil);
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);
 OpenSSL:=TOpenSSL.Create;
// obtenemos el certificado
 x509Certificado := TX509Certificate.Create;
 x509Certificado.LoadFromFile(ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO));
 sCer:=UTF8Bytes(X509Certificado.AsBase64);
 x509Certificado.Free;
// obtenemos la llave
 llaveAbierta := openSSL.AbrirLlavePrivada(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA),ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE));
 openSSL.GuardarLlavePrivadaEnPEM(llaveAbierta, ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
 OpenSSL.Free;
 sKey:=FileToByteArray(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
//Eliminamos el archivo temporal
 DeleteFile(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA)+'.pem');
 try
   RespuestaRelacionados := fwsCancelacionFinkOk.Get_related(fCredencialesPAC.RFC,fCredencialesPAC.Clave,
                           fcredencialesIntegrador.RFC,aUUID,sCer,sKey);
 if RespuestaRelacionados.error='' then
  begin
  // Falta agregar que hacer si encuentra
  end
 Else
  CodEstatus(RespuestaRelacionados.error);
 except
  On E: Exception do
   if Not(E Is EPACException) then
   ProcesarExcepcionDePAC(E)
   else
   raise;
 end;
end;

procedure TProveedorFinkOk.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion : string;
begin
  mensajeExcepcion := aExcepcion.Message;
     // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
     // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
     raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
//  end;
end;

end.

