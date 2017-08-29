{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
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
     SysUtils;

type

  TProveedorComercio = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
  private
    fError,fErrorMsg,fSaldo:String;
    URLTimbrado: String;
    fDocumentoXMLTimbrado : IComprobanteFiscal;
    fDominioWebService : string;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    Function ProcesaErrorPac(const aLista : TStringList):Boolean;
    function RealizarPeticionREST(const URL: string;const aDocumentoXML: TCadenaUTF8): TCadenaUTF8;
  public
    procedure Configurar(const aDominioWebService: string; const aCredencialesPAC:
        TFacturacionCredencialesPAC; const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
   published
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
     {$IF Compilerversion >= 20}
     System.RegularExpressions,
     Xml.Win.Msxmldom,
     {$ELSE}
     msxmldom,
     {$IFEND}
     XMLDoc;

{ TProveedorComercio }



Function TProveedorComercio.RealizarPeticionREST(const URL: string; const aDocumentoXML:
    TCadenaUTF8): TCadenaUTF8;
var
  HTTP: THTTPSend;
  resultadoAPI : TStringStream;
  respuestaDeServidor: TStrings;
  llamadoExitoso: Boolean;
  Pr:String;
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
    pr:=HTTP.Headers.Text;
    HTTP.MimeType:='text/xml';
    HTTP.Protocol:='1.1';
    HTTP.KeepAlive:=True;
    HTTP.Headers.Add('usrws: '+fCredencialesPAC.RFC);
    HTTP.Headers.Add('pwdws: '+fCredencialesPAC.CLAVE);
    HTTP.Headers.Add('tipo:TIMBRE');
    HTTP.Document.CopyFrom(resultadoAPI, 0);
    llamadoExitoso:=HTTP.HTTPMethod('POST', URL);
    if (llamadoExitoso) and (ProcesaErrorPac(HTTP.Headers)) then
     begin
      respuestaDeServidor.LoadFromStream(HTTP.Document);
      Result := respuestaDeServidor.Text;
    end else
      raise Exception.Create('Error al timbrar en API: ' + fError +'/Mensaje:'+fErrorMsg);
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
  end;
end;

Procedure TProveedorComercio.Configurar(const aDominioWebService: string; const
    aCredencialesPAC: TFacturacionCredencialesPAC; const aTransaccionInicial:
    Int64);
begin
  fDominioWebService := aDominioWebService;
  fCredencialesPAC := aCredencialesPAC;
  URLTimbrado :=fDominioWebService+'/timbre/timbrarv5.aspx';
  // Incializamos las instancias de los WebServices
end;

function TProveedorComercio.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8;

var
  respuestaCadena: TCadenaUTF8;
begin
  try
    // Paso 1. Mandamos solicitar el timbre por medio del API Rest de Comercio Digital
    respuestaCadena := RealizarPeticionREST(URLTimbrado,UTF8Encode(aComprobante.XML));
    // Checamos haber recibido el timbrado correctamente
    if Copy(Trim(respuestaCadena),1,4)='<tfd' then
    Begin
      {$IF Compilerversion >= 20}
       Result :=respuestaCadena;
      {$ELSE}
       Result :=UTF8Encode(respuestaCadena);
      {$IFEND}
    end else
      raise exception.Create(respuestaCadena);
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
