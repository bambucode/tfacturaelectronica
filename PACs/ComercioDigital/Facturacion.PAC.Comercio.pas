{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{   Soporte del pac comercio digital TecsisNet.net      }
{                                                       }
{*******************************************************}

unit Facturacion.PAC.Comercio;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     SynaCode,
     HTTPSend,
     Facturacion.Comprobante,
     Facturacion.Tipos,
     ssl_openssl,
     Classes,
//     Forms,
     ComercioWsComun,
     SysUtils;

type

  TProveedorComercio = class(TProveedorAutorizadoCertificacionBase, IProveedorAutorizadoCertificacion)
  private
    fRespuesta:TCadenaUTF8;
    fError,fErrorMsg,fSaldo:String;
    fWsTimbradoComercio,fWsCancelacionComercio: String;
    fDocumentoXMLTimbrado : IComprobanteFiscal;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    fCredencialesIntegrador : TFacturacionCredencialesPAC;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    Function ProcesaErrorPac(const aLista : TStringList):Boolean;
    function RealizarTimbradoREST(const aDocumentoXML: TCadenaUTF8): TCadenaUTF8;
    function RealizarCancelacionREST(RFCR, UUID, EmailR, EmailE, TipoC,
      Total: String): String;
  public
    procedure  Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64); override;
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8; overload; override;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer; override;
    function CancelarDocumento(RFCR,UUID,EmailR,EmailE,TipoC,Total:String): TCadenaUTF8; overload;
   public
    property Respuesta :TCadenaUTF8 read fRespuesta write fRespuesta;
    property Saldo :String read fSaldo;
    property ErrorMsg :String read fErrorMsg;
    property Error :String read fError;
  end;

implementation

uses xmldom,
     XMLIntf,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     {$IF Compilerversion >= 23}
     Xml.Win.Msxmldom,
     {$ELSE}
     msxmldom,
     {$IFEND}
     XMLDoc;

{ TProveedorComercio }

function EncodeF(const Archivo: string): UnicodeString;
function MemoryStreamToString(M: TMemoryStream): UnicodeString; //extraida de http://stackoverflow.com/questions/732666/converting-tmemorystream-to-string-in-delphi-2009
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

function TProveedorComercio.RealizarCancelacionREST(RFCR,UUID,EmailR,EmailE,TipoC,Total:String): String;
var
  HTTP: THTTPSend;
  {$IF Compilerversion >= 20}
   resultadoAPI : TStringStream;
  {$ELSE}
   resultadoAPI : TMemoryStream;
  {$IFEND}
  respuestaDeServidor: TStrings;
  llamadoExitoso: Boolean;
  Res: TStrings;
begin
  // TODO: Cambiar este codigo para no depender de Synapse
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_ARCHIVO)='' then
   raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_ARCHIVO)='' then
   raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);
  HTTP := THTTPSend.Create;
  respuestaDeServidor := TStringList.Create;
  Res:= TStringList.Create;
  try
   res.Add('');
   res.Add('USER='+EncodeURL(fCredencialesPAC.RFC));
   res.Add('PWDW='+fCredencialesPAC.CLAVE);
   res.Add('RFCE='+EncodeURL(fCredencialesPAC.RFC));
   res.Add('UUID='+Trim(UUID));
   res.Add('PWDK='+ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE));//Trim(fclaveLlavePrivada));
   res.Add('KEYF='+EncodeF(ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_ARCHIVO)));//frutaLlavePrivada));
   res.Add('CERT='+EncodeF(ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_ARCHIVO)));//frutaCertificado));
   Res.Add('TIPO=cfdi3.3');//+Trim(fqueVersion));
   res.Add('ACUS=SI');
   res.Add('RFCR='+EncodeURL(RFCR));//receptor
   Res.Add('TOTAL='+EncodeURL(Total));//Total del Comprobante
   Res.Add('TIPOC='+EncodeURL(TipoC));//Tipo de comprobante [I (Ingreso), E (Egreso), N (Nomina), T (Traslado), P (Pagos) ]
   res.Add('EMAILE='+EncodeURL(EmailE));//Correo Emisor
   if Trim(EmailR)<>'' then
    res.Add('EMAILR='+EncodeURL(EmailR));//Correo Receptor
  {$IF Compilerversion >= 20}
   resultadoAPI := TStringStream.Create;
  {$ELSE}
   resultadoAPI := TMemoryStream.Create;
  {$IFEND}
   Res.SaveToStream(resultadoAPI);
   HTTP.Document.LoadFromStream(resultadoAPI);
   HTTP.MimeType:='text/plain';
   HTTP.Protocol:='1.1';
   HTTP.Status100:=True;
   HTTP.KeepAlive:=True;
   llamadoExitoso:=HTTP.HTTPMethod('POST', fWsCancelacionComercio+'/cancela3/cancelarUuid');
   if llamadoExitoso then
    begin
     respuestaDeServidor.LoadFromStream(HTTP.Document);
     if Trim(respuestaDeServidor.Text)<>'' then
      Result := respuestaDeServidor.Text
     Else
      Result:=HTTP.Headers.Text;
    end;
    fRespuesta:=HTTP.Headers.Text;
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
    Res.Free;
  end;

end;

Function TProveedorComercio.RealizarTimbradoREST(const aDocumentoXML:
    TCadenaUTF8): TCadenaUTF8;
var
  HTTP: THTTPSend;
  resultadoAPI : TStringStream;
  respuestaDeServidor: TStrings;
  llamadoExitoso: Boolean;
//  Pr:String;
begin
  // TODO: Cambiar este codigo para no depender de Synapse
  {$IF Compilerversion >= 20}
   resultadoAPI := TStringStream.Create('<?xml version="1.0" encoding="UTF-8"?>'+aDocumentoXML,TEncoding.UTF8 );
  {$ELSE}
   resultadoAPI := TStringStream.Create('<?xml version="1.0" encoding="UTF-8"?>'+aDocumentoXML);
  {$IFEND}
  HTTP := THTTPSend.Create;
  respuestaDeServidor := TStringList.Create;
  try
    // Copiamos el documento XML al Memory Stream
    resultadoAPI.WriteString('<?xml version="1.0" encoding="UTF-8"?>'+aDocumentoXML);
    HTTP.MimeType:='text/xml';
    HTTP.Protocol:='1.1';
    HTTP.KeepAlive:=True;
    HTTP.Headers.Add('usrws: '+fCredencialesPAC.RFC);
    HTTP.Headers.Add('pwdws: '+fCredencialesPAC.CLAVE);
    HTTP.Headers.Add('tipo:TIMBRE');
    HTTP.Document.CopyFrom(resultadoAPI, 0);
    llamadoExitoso:=HTTP.HTTPMethod('POST', fWsTimbradoComercio+'/timbre/timbrarv5.aspx');
    if (llamadoExitoso) and (ProcesaErrorPac(HTTP.Headers)) then
     begin
      respuestaDeServidor.LoadFromStream(HTTP.Document);
      if Trim(respuestaDeServidor.Text)<>'' then
       Result := respuestaDeServidor.Text
      Else
       Result:=HTTP.Headers.Text;
    end;
    fRespuesta:=HTTP.Headers.Text;
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
  end;
end;

function TProveedorComercio.CancelarDocumento(
  RFCR,UUID,EmailR,EmailE,TipoC,Total:String): TCadenaUTF8;
var
  respuestaCadena: TCadenaUTF8;
begin
 try
  // Paso 1. Mandamos solicitar el timbre por medio del API Rest de Comercio Digital
  respuestaCadena := RealizarCancelacionREST(RFCR,UUID,EmailR,EmailE,TipoC,Total);
  // Checamos haber recibido el timbrado correctamente
  if Copy(Trim(fRespuesta),Pos('CODIGO',UpperCase(Trim(fRespuesta)))+8,3)='000' then
   Begin
    {$IF Compilerversion >= 20}
     Result :=respuestaCadena;
    {$ELSE}
     Result :=UTF8Encode(respuestaCadena);
    {$IFEND}
   end
 else
  PACCodEstatus(Copy(Trim(fRespuesta),Pos('CODIGO',UpperCase(Trim(fRespuesta)))+8,3));
 except
  On E:Exception do
   begin
    ProcesarExcepcionDePAC(E);
    // TODO: Procesar correctamente los diferentes tipos de errores
   end;
  end;
end;

procedure  TProveedorComercio.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                     const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                     const aTransaccionInicial: Int64);

begin
  fCredencialesIntegrador := aCredencialesIntegrador;  
  fWsTimbradoComercio :=aWsTimbrado;
  fWsCancelacionComercio :=aWsCancelacion;
  // Incializamos las instancias de los WebServices
  fCredencialesPAC := aCredencialesPAC;
  fCredencialesIntegrador.RFC:=aCredencialesIntegrador.RFC;  
end;

function TProveedorComercio.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8;
var
  respuestaCadena: TCadenaUTF8;
begin
  try
    // Paso 1. Mandamos solicitar el timbre por medio del API Rest de Comercio Digital
    respuestaCadena := RealizarTimbradoREST(UTF8Encode(aComprobante.XML));
    // Checamos haber recibido el timbrado correctamente
   if Copy(Trim(fRespuesta),Pos('CODIGO',UpperCase(Trim(fRespuesta)))+8,3)='000' then
    Begin
    {$IF Compilerversion >= 20}
     Result :=respuestaCadena;
    {$ELSE}
     Result :=UTF8Encode(respuestaCadena);
    {$IFEND}
    end
   else
    PACCodEstatus(Copy(Trim(fRespuesta),Pos('CODIGO',UpperCase(Trim(fRespuesta)))+8,3));
  except
    On E:Exception do
    begin
     ProcesarExcepcionDePAC(E);
     // TODO: Procesar correctamente los diferentes tipos de errores
    end;
  end;
end;

function TProveedorComercio.ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
begin
end;


function TProveedorComercio.ProcesaErrorPac(const aLista: TStringList): Boolean;
var
  I: Integer;
begin
 Result:=True;
 for i := 0 to aLista.Count - 1 do
  Begin
   if (Copy(aLista[i],0,7)='codigo:') and (Copy(aLista[i],0,11)<>'codigo: 000') then
    Begin
     fError:=Trim(Copy(aLista[i],8,10));
     Result:=False;
    End;
   if Copy(aLista[i],0,7)='errmsg:' then
    Begin
     fErrorMsg:=Trim(Copy(aLista[i],13,200));
     Result:=False;
    End;
   if (Copy(aLista[i],0,6)='saldo:') and (Result=True) then
    fSaldo:=Trim(Copy(aLista[i],13,200));
  End;
end;

procedure TProveedorComercio.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion : string;
begin
  mensajeExcepcion := aExcepcion.Message;
  raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

end.
