{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{        Soporte del pac FinkOK Tecsis.Mx               }
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
     System.RegularExpressions,
{$ELSE}
     Types,
     SysUtils,
     Classes,
   {$IF Compilerversion >= 22}
     RegularExpressions,
   {$ELSE}
     PerlRegEx,
   {$IFEND}
{$IFEND}
     Math,
     LibEay32Plus,
     XMLDoc,
     OpenSSLUtils,
     Facturacion.OpenSSL,
     Facturacion.CertificadoDeSellos,
     Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     Facturacion.Tipos,
     Facturacion.Helper,
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
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    function FileToByteArray( const FileName : string ) : TByteDynArray;
    function FixedWideStringToArray(const aFixedWideString: WideString; const aElementFixedSize: Integer): StringArray;

  public
    procedure  Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8; overload; override;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
    function CancelarDocumento(const aUUID: TSolicitudCancelacion): Boolean; overload; override;
    function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID;
    function ObtenerAcuseDeCancelacion(const aUUID: string): string; override;
    Function ObtenerEstatus(aUUID,Total,RFCReceptor: TCadenaUTF8):AcuseSATConsulta;
    function ObtenerRelacionados(aUUID: TCadenaUTF8): TCadenaUTF8;
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
  fwsCancelacionFinkOk := GetIFinkOkServicioCancelacion(True,aWsCancelacion);
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

function TProveedorFinkOk.FixedWideStringToArray(const aFixedWideString: WideString; const aElementFixedSize: Integer): StringArray;
var
i : integer;
begin
 SetLength(result, Length(aFixedWideString) div aElementFixedSize);
 if Length(aFixedWideString) > 0 then
 begin
  for i := 1 to Length(aFixedWideString) div aElementFixedSize do
  begin
   SetLength(result[i-1], Length(aFixedWideString));
   result[i-1] := aFixedWideString;
  end;
 end;
end;

function TProveedorFinkOk.TimbrarDocumento(const aComprobante:
    IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
begin
  sXML := FacturacionHelper.UTF8ToBytes(UTF8Encode(aComprobante.XML));
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


function TProveedorFinkOk.CancelarDocumento(const aUUID: TSolicitudCancelacion): Boolean;
var
  certificadoSellos: ICertificadoDeSellos;
  respuestaCancelacion: FinkOKRespuestaCancelacion2;
  sKey,sCer:TByteDynArray;
  vUUID:UUIDArray;
  fAcuse:String;
  OpenSSL: TOpenSSL;
  LlaveAbierta: pPKCS8_Priv_Key_Info;
  x509Certificado : TX509Certificate;
  key: TKeyPairGenerator;
  I: Integer;
begin
 Result:=False;//'';
  fDocumentoXMLCancelado :=TXMLDocument.Create(nil);
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);
 OpenSSL:=TOpenSSL.Create;
// obtenemos el certificado
 x509Certificado := TX509Certificate.Create;
 x509Certificado.LoadFromFile(ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64));
 sCer:=FacturacionHelper.UTF8ToBytes(X509Certificado.AsBase64);
 x509Certificado.Free;
// obtenemos la llave
 llaveAbierta := openSSL.AbrirLlavePrivada(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64),ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE));
 openSSL.GuardarLlavePrivadaEnPEM(llaveAbierta, ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
 OpenSSL.Free;
 sKey:=FileToByteArray(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
//Eliminamos el archivo temporal
 DeleteFile(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
 SetLength(vUUID,Length(aUUID));
 for I := 0 to Length(aUUID)-1 do
  Begin
   vUUID[I]:=UUID.Create;
   vUUID[I].UUID:=aUUID[I].UUID;
   vUUID[I].FolioSustitucion:=aUUID[I].FolioSustitucion;
   vUUID[I].Motivo:=aUUID[I].Motivo;
  End;
 try
   respuestaCancelacion := fwsCancelacionFinkOk.cancel(vUUID,fCredencialesPAC.RFC,fCredencialesPAC.Clave,
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

function TProveedorFinkOk.ObtenerEstatus(aUUID,Total,RFCReceptor: TCadenaUTF8): AcuseSATConsulta;
var
  RespuestaEstatus: AcuseSatEstatus;
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
  RespuestaEstatus: CancelPendingResult;
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

function TProveedorFinkOk.ObtenerRelacionados(aUUID: TCadenaUTF8): TCadenaUTF8;
var
  Relacionados:TCadenaUTF8;
  certificadoSellos: ICertificadoDeSellos;
  RespuestaRelacionados: RelatedResult;//RelatedResult2;
  sKey,sCer:TByteDynArray;
  fAcuse:String;
  OpenSSL: TOpenSSL;
  LlaveAbierta: pPKCS8_Priv_Key_Info;
  x509Certificado : TX509Certificate;
  key: TKeyPairGenerator;
  I: Integer;
begin
 Result:='';
  fDocumentoXMLCancelado :=TXMLDocument.Create(nil);
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);
 OpenSSL:=TOpenSSL.Create;
// obtenemos el certificado
 x509Certificado := TX509Certificate.Create;
 x509Certificado.LoadFromFile(ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64));
 sCer:=FacturacionHelper.UTF8ToBytes(X509Certificado.AsBase64);
 x509Certificado.Free;
// obtenemos la llave
 llaveAbierta := openSSL.AbrirLlavePrivada(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64),ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE));
 openSSL.GuardarLlavePrivadaEnPEM(llaveAbierta, ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
 OpenSSL.Free;
 sKey:=FileToByteArray(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
//Eliminamos el archivo temporal
 DeleteFile(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)+'.pem');
 try
   RespuestaRelacionados := fwsCancelacionFinkOk.Get_related(fCredencialesPAC.RFC,fCredencialesPAC.Clave,
                           fcredencialesIntegrador.RFC,fcredencialesIntegrador.RFC,aUUID,sCer,sKey);

 if RespuestaRelacionados.error='' then
  Begin
   for I := 0 to Length(RespuestaRelacionados.Padres) - 1 do
    Begin
     Relacionados:='PADRES=UUID:'+RespuestaRelacionados.Padres[I].uuid+Chr(13);
     Relacionados:='PADRES=Emisor:'+RespuestaRelacionados.Padres[I].emisor+Chr(13);
     Relacionados:='PADRES=Receptor:'+RespuestaRelacionados.Padres[I].receptor+Chr(13);
    End;
   for I := 0 to Length(RespuestaRelacionados.Hijos) - 1 do
    Begin
     Relacionados:='HIJOS=UUID:'+RespuestaRelacionados.Hijos[I].uuid+Chr(13);
     Relacionados:='HIJOS=Emisor:'+RespuestaRelacionados.Hijos[I].emisor+Chr(13);
     Relacionados:='HIJOS=Receptor:'+RespuestaRelacionados.Hijos[I].receptor+Chr(13);
    End;
    Result:=Relacionados;
  End
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

