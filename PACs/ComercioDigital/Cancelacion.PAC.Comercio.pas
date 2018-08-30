{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{   Soporte del pac comercio digital TecsisNet.net      }
{                                                       }
{*******************************************************}

unit Cancelacion.PAC.Comercio;

interface
uses Classes,Facturacion.Tipos,SysUtils,SynaCode,ssl_openssl,httpsend,
Facturacion.Comprobante;
type
  TProveedorComercioCancelar = class
   private
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    fURL:string;
    fError,fErrorMsg,fSaldo,
    fqueVersion, frutaCertificado, frutaLlavePrivada, fclaveLlavePrivada: string;
    function ProcesaErrorPac(const aLista: TStringList): Boolean;
   Public
    function RealizarCancelacionREST(RFCR,UUID,EmailR,EmailE,TipoC,Total:String):String;
    procedure Configurar(const aURL: string;
      const aCredencialesPAC: TFacturacionCredencialesPAC;
      const aqueVersion, arutaCertificado, arutaLlavePrivada, aclaveLlavePrivada: string);
  end;
implementation

{ TProveedorComercioCancelar }

Procedure TProveedorComercioCancelar.Configurar(const aURL: string;
      const aCredencialesPAC: TFacturacionCredencialesPAC;
      const aqueVersion, arutaCertificado, arutaLlavePrivada, aclaveLlavePrivada: string);
begin
  fURL := aURL;
  fCredencialesPAC := aCredencialesPAC;
  fqueVersion:=aqueVersion;
  frutaCertificado:=arutaCertificado;
  frutaLlavePrivada:=arutaLlavePrivada;
  fclaveLlavePrivada:=aclaveLlavePrivada;
  // Incializamos las instancias de los WebServices
end;

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

function TProveedorComercioCancelar.ProcesaErrorPac(const aLista: TStringList): Boolean;
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

function TProveedorComercioCancelar.RealizarCancelacionREST(RFCR,UUID,EmailR,EmailE,TipoC,Total:String): String;
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
//  Funciones:TFuncionesComunesPAC;
//  fLlave,fCer:string;
begin
  // TODO: Cambiar este codigo para no depender de Synapse
  HTTP := THTTPSend.Create;
  respuestaDeServidor := TStringList.Create;
  Res:= TStringList.Create;
  try
   res.Add('POST '+fURL+' HTTP/1.2');
   res.Add('Content-Type: text/plain');
   res.Add('Host: cancela.comercio-digital.mx');
   res.Add('Content-Length: 3285');
   res.Add('Expect: 100-continue');
   res.Add('Connection: Keep-Alive');
   res.Add('');
   res.Add('USER=GPAPEL1.');
   res.Add('PWDW='+fCredencialesPAC.CLAVE);
   res.Add('RFCE='+EncodeURL(fCredencialesPAC.RFC));
   res.Add('UUID='+Trim(UUID));
   res.Add('PWDK='+Trim(fclaveLlavePrivada));
   res.Add('KEYF='+EncodeF(frutaLlavePrivada));
   res.Add('CERT='+EncodeF(frutaCertificado));
   Res.Add('TIPO='+Trim(fqueVersion));//cfdi3.3');
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
   resultadoAPI.SaveToFile('d:\File.txt');
   HTTP.Document.LoadFromStream(resultadoAPI);
   llamadoExitoso:=HTTP.HTTPMethod('POST', fURL);
    if llamadoExitoso then
    begin
      respuestaDeServidor.LoadFromStream(HTTP.Document);
      Result := respuestaDeServidor.Text;
    end else
      raise Exception.Create('Error al cancelar en API:' + HTTP.ResultString);
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
    Res.Free;
//    Funciones.Free;
  end;

end;


end.
