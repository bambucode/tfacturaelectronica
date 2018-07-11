// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ws.facturacionmexico.com.mx/pac/?wsdl
//  >Import : http://ws.facturacionmexico.com.mx/pac/?wsdl>0
// Encoding : ISO-8859-1
// Codegen  : [wfMapStringsToWideStrings+, wfCreateArrayElemTypeAlias+]
// Version  : 1.0
// (10/07/2018 08:38:06 p. m. - - $Rev: 34800 $)
// ************************************************************************ //

unit MultiFacturasWsTimbradoEx;

interface
uses
{$IF CompilerVersion >= 23}
 Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns
{$ELSE}
 InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns
{$IFEND}
 ;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:Array           - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  RespuestaNET         = class;                 { "urn:wservicewsdl"[GblCplx] }
  saldoResponse        = class;                 { "urn:wservicewsdl"[GblCplx] }



  // ************************************************************************ //
  // XML       : RespuestaNET, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  RespuestaNET = class(TRemotable)
  private
    Fcfdi: WideString;
    Fpng: WideString;
    Fidpac: Integer;
    Fpac: Integer;
    Fproduccion: WideString;
    Fcodigo_mf_numero: Integer;
    Fcodigo_mf_texto: WideString;
    Fmensaje_original_pac_json: WideString;
    Fcancelada: WideString;
    Fsaldo: Integer;
    Fuuid: WideString;
    Fservidor: WideString;
    Fejecucion: Single;
    Fdebug: WideString;
  published
    property cfdi:                      WideString  read Fcfdi write Fcfdi;
    property png:                       WideString  read Fpng write Fpng;
    property idpac:                     Integer     read Fidpac write Fidpac;
    property pac:                       Integer     read Fpac write Fpac;
    property produccion:                WideString  read Fproduccion write Fproduccion;
    property codigo_mf_numero:          Integer     read Fcodigo_mf_numero write Fcodigo_mf_numero;
    property codigo_mf_texto:           WideString  read Fcodigo_mf_texto write Fcodigo_mf_texto;
    property mensaje_original_pac_json: WideString  read Fmensaje_original_pac_json write Fmensaje_original_pac_json;
    property cancelada:                 WideString  read Fcancelada write Fcancelada;
    property saldo:                     Integer     read Fsaldo write Fsaldo;
    property uuid:                      WideString  read Fuuid write Fuuid;
    property servidor:                  WideString  read Fservidor write Fservidor;
    property ejecucion:                 Single      read Fejecucion write Fejecucion;
    property debug:                     WideString  read Fdebug write Fdebug;
  end;



  // ************************************************************************ //
  // XML       : saldoResponse, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  saldoResponse = class(TRemotable)
  private
    FsaldoResult: WideString;
    Fsaldo: Integer;
  published
    property saldoResult: WideString  read FsaldoResult write FsaldoResult;
    property saldo:       Integer     read Fsaldo write Fsaldo;
  end;


  // ************************************************************************ //
  // Namespace : urn:wservicewsdl
  // soapAction: |urn:wservicewsdl#timbrar|urn:wservicewsdl#timbrar64|urn:wservicewsdl#saldo|urn:wservicewsdl#saldoNET|urn:wservicewsdl#cancelar|urn:wservicewsdl#generar_pem|urn:wservicewsdl#ticket|urn:wservicewsdl#ticket_reporte|urn:wservicewsdl#factura_reporte|urn:wservicewsdl#factura_respaldo|urn:wservicewsdl#genera_dotnet|urn:wservicewsdl#genera_ut8|urn:wservicewsdl#acuseSAT|urn:wservicewsdl#cancela_ut8|urn:wservicewsdl#timbradoMicrosip|urn:wservicewsdl#timbrar33b64
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : wserviceBinding
  // service   : wservice
  // port      : wservicePort
  // URL       : http://ws.facturacionmexico.com.mx/pac/index.php
  // ************************************************************************ //
  wservicePortType = interface(IInvokable)
  ['{7C5ED08C-B43C-FB0D-86AB-2836E6D407DC}']
    {function  timbrar(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): Array; stdcall;}
    function  timbrarNET(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): RespuestaNET; stdcall;
    {
    function  timbrar64(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): Array; stdcall;
    function  retencion(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): Array; stdcall;
    function  saldo(const rfc: WideString; const clave: WideString): Array; stdcall;
    }
    function  saldoNET(const rfc: WideString; const clave: WideString): saldoResponse; stdcall;
    {
    function  cancelar(const rfc: WideString; const clave: WideString; const uuid: WideString; const cer: WideString; const key: WideString; const pass_cer: WideString
                       ): Array; stdcall;
    function  generar_pem(const cer_base64: WideString; const key_base64: WideString; const pass_base64: WideString): Array; stdcall;
    function  respaldo_masivo(const rfc: WideString; const clave: WideString; const respaldo_base64: WideString): Array; stdcall;
    function  ticket(const rfc: WideString; const clave: WideString; const ticket: WideString; const produccion: WideString): Array; stdcall;
    function  ticket_reporte(const rfc: WideString; const clave: WideString; const tipo: WideString; const fecha_inicial: WideString; const fecha_final: WideString): Array; stdcall;
    function  ticket_cancela(const rfc: WideString; const clave: WideString; const codigo: WideString): Array; stdcall;
    function  factura_reporte(const rfc: WideString; const clave: WideString; const mes: WideString; const ano: WideString): Array; stdcall;
    function  factura_recupera_respaldo(const rfc: WideString; const clave: WideString; const referencia: WideString; const uuid: WideString): Array; stdcall;
    function  genera_dotnet(const empresa: WideString; const pwd: WideString; const fe_xml: WideString): Array; stdcall;
    function  genera_ut8(const rfc: WideString; const clave: WideString; const xml: WideString): Array; stdcall;
    function  acuseSAT(const rfc: WideString; const pwd: WideString; const uuid: WideString): Array; stdcall;
    function  cancela_ut8(const rfc: WideString; const pwd: WideString; const xml_in: WideString): Array; stdcall;
    function  timbradoMICROSIP(const rfc: WideString; const clave: WideString; const tipo: WideString; const xml: WideString; const produccion: WideString): Array; stdcall;
    }
    function  timbrar33b64(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): RespuestaNET; stdcall;
  end;

function GetwservicePortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wservicePortType;
function GetwservicePortTypeRandom(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wservicePortType;

implementation
  uses SysUtils, Math;

function GetwservicePortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wservicePortType;
const
  defWSDL = 'http://ws.facturacionmexico.com.mx/pac/?wsdl';
  defURL  = 'http://ws.facturacionmexico.com.mx/pac/index.php';
  defSvc  = 'wservice';
  defPrt  = 'wservicePort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as wservicePortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

function GetwservicePortTypeRandom(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wservicePortType;
const
  defWSDL = 'http://pac{%id%}.facturacionmexico.com.mx/pac/?wsdl';
  defURL  = 'http://pac{%id%}.facturacionmexico.com.mx/pac/index.php';
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  Addr := StringReplace( Addr, '{%id%}', IntToStr(RandomRange(1,10)), [rfReplaceAll, rfIgnoreCase]);
  result := GetwservicePortType(UseWSDL, Addr, HTTPRIO);
end;

initialization
  { wservicePortType }
  InvRegistry.RegisterInterface(TypeInfo(wservicePortType), 'urn:wservicewsdl', 'ISO-8859-1');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(wservicePortType), '|urn:wservicewsdl#timbrar'
                                                                +'|urn:wservicewsdl#timbrar64'
                                                                +'|urn:wservicewsdl#saldo'
                                                                +'|urn:wservicewsdl#saldoNET'
                                                                +'|urn:wservicewsdl#cancelar'
                                                                +'|urn:wservicewsdl#generar_pem'
                                                                +'|urn:wservicewsdl#ticket'
                                                                +'|urn:wservicewsdl#ticket_reporte'
                                                                +'|urn:wservicewsdl#factura_reporte'
                                                                +'|urn:wservicewsdl#factura_respaldo'
                                                                +'|urn:wservicewsdl#genera_dotnet'
                                                                +'|urn:wservicewsdl#genera_ut8'
                                                                +'|urn:wservicewsdl#acuseSAT'
                                                                +'|urn:wservicewsdl#cancela_ut8'
                                                                +'|urn:wservicewsdl#timbradoMicrosip'
                                                                +'|urn:wservicewsdl#timbrar33b64'
                                                                );
  RemClassRegistry.RegisterXSClass(RespuestaNET, 'urn:wservicewsdl', 'RespuestaNET');
  RemClassRegistry.RegisterXSClass(saldoResponse, 'urn:wservicewsdl', 'saldoResponse');

end.