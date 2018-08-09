// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ws.facturacionmexico.com.mx/pac/timbrarjava.php?wsdl
//  >Import : http://ws.facturacionmexico.com.mx/pac/timbrarjava.php?wsdl>0
// Encoding : ISO-8859-1
// Codegen  : [wfMapStringsToWideStrings+, wfCreateArrayElemTypeAlias+]
// Version  : 1.0
// (10/07/2018 08:51:54 p. m. - - $Rev: 34800 $)
// ************************************************************************ //

unit MultiFacturasWsTimbrado;

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
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Respuesta            = class;                 { "urn:wservicewsdl"[GblCplx] }
  RespuestaRetencion   = class;                 { "urn:wservicewsdl"[GblCplx] }
  RespuestaCancelacion = class;                 { "urn:wservicewsdl"[GblCplx] }
  saldoResponse        = class;                 { "urn:wservicewsdl"[GblCplx] }



  // ************************************************************************ //
  // XML       : Respuesta, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  Respuesta = class(TRemotable)
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
  // XML       : RespuestaRetencion, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  RespuestaRetencion = class(TRemotable)
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
    Fretencion: WideString;
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
    property retencion:                 WideString  read Fretencion write Fretencion;
  end;



  // ************************************************************************ //
  // XML       : RespuestaCancelacion, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  RespuestaCancelacion = class(TRemotable)
  private
    Fidpac: Integer;
    Fpac: Integer;
    Fproduccion: WideString;
    Fcodigo_mf_numero: Integer;
    Fcodigo_mf_texto: WideString;
    Facuse: WideString;
    Fmensaje_original_pac_json: WideString;
    Fejecucion: Single;
  published
    property idpac:                     Integer     read Fidpac write Fidpac;
    property pac:                       Integer     read Fpac write Fpac;
    property produccion:                WideString  read Fproduccion write Fproduccion;
    property codigo_mf_numero:          Integer     read Fcodigo_mf_numero write Fcodigo_mf_numero;
    property codigo_mf_texto:           WideString  read Fcodigo_mf_texto write Fcodigo_mf_texto;
    property acuse:                     WideString  read Facuse write Facuse;
    property mensaje_original_pac_json: WideString  read Fmensaje_original_pac_json write Fmensaje_original_pac_json;
    property ejecucion:                 Single      read Fejecucion write Fejecucion;
  end;



  // ************************************************************************ //
  // XML       : saldoResponse, global, <complexType>
  // Namespace : urn:wservicewsdl
  // ************************************************************************ //
  saldoResponse = class(TRemotable)
  private
    Fcodigo_mf_numero: Int64;
    Fcodigo_mf_texto: WideString;
    Fsaldo: Integer;
  published
    property codigo_mf_numero: Int64       read Fcodigo_mf_numero write Fcodigo_mf_numero;
    property codigo_mf_texto:  WideString  read Fcodigo_mf_texto write Fcodigo_mf_texto;
    property saldo:            Integer     read Fsaldo write Fsaldo;
  end;


  // ************************************************************************ //
  // Namespace : urn:wservicewsdl
  // soapAction: |urn:wservicewsdl#timbrar|urn:wservicewsdl#cancelar|urn:wservicewsdl#saldoNET
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : wserviceBinding
  // service   : wservice
  // port      : wservicePort
  // URL       : http://pac1.facturacionmexico.com.mx/pac/timbrarnet.php
  // ************************************************************************ //
  wservicePortType = interface(IInvokable)
  ['{7C5ED08C-B43C-FB0D-86AB-2836E6D407DC}']
    function  timbrar32(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): Respuesta; stdcall;
    function  timbrar33(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): Respuesta; stdcall;
    function  cancelar(const rfc: WideString; const clave: WideString; const uuid: WideString; const cer: WideString; const key: WideString; const pass_cer: WideString
                       ): RespuestaCancelacion; stdcall;
    function  saldo(const rfc: WideString; const clave: WideString): saldoResponse; stdcall;
    function  retencion(const rfc: WideString; const clave: WideString; const xml: WideString; const produccion: WideString): RespuestaRetencion; stdcall;
  end;

function GetwservicePortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wservicePortType;
function GetwservicePortTypeRandom(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wservicePortType;


implementation
  uses SysUtils, Math;

function GetwservicePortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wservicePortType;
const
  defWSDL = 'http://ws.facturacionmexico.com.mx/pac/timbrarjava.php?wsdl';
  defURL  = 'http://ws.facturacionmexico.com.mx/pac/timbrarjava.php';
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
  defWSDL = 'http://pac{%id%}.facturacionmexico.com.mx/pac/timbrarjava.php?wsdl';
  defURL  = 'http://pac{%id%}.facturacionmexico.com.mx/pac/timbrarjava.php';
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
  InvRegistry.RegisterAllSOAPActions(TypeInfo(wservicePortType), '|urn:wservicewsdl#timbrar|urn:wservicewsdl#cancelar|urn:wservicewsdl#saldoNET');
  RemClassRegistry.RegisterXSClass(Respuesta, 'urn:wservicewsdl', 'Respuesta');
  RemClassRegistry.RegisterXSClass(RespuestaRetencion, 'urn:wservicewsdl', 'RespuestaRetencion');
  RemClassRegistry.RegisterXSClass(RespuestaCancelacion, 'urn:wservicewsdl', 'RespuestaCancelacion');
  RemClassRegistry.RegisterXSClass(saldoResponse, 'urn:wservicewsdl', 'saldoResponse');

end.
