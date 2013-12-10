{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc?wsdl
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc?wsdl>0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc?xsd=xsd0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// ************************************************************************ //

unit EcodexWsSeguridad;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TEcodexSolicitudDeToken = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexRespuestaObtenerToken = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }


  // ************************************************************************ //
  // XML       : TEcodexSolicitudDeToken, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudDeToken = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:           string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaObtenerToken, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaObtenerToken = class(TRemotable)
  private
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property Token:         string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // soapAction: http://Ecodex.WS.Model/2011/CFDI/IEcodexServicioSeguridad/ObtenerToken
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : PuertoSeguridadSeguro
  // service   : IEcodexServicioSeguridad
  // port      : PuertoSeguridadSeguro
  // URL       : https://wsdexpruebas.ecodex.com.mx:2045/ServicioSeguridad.svc
  // ************************************************************************ //
  IEcodexServicioSeguridad = interface(IInvokable)
  ['{2C122BAD-CCE6-E6E5-9506-803AFCE248BD}']
    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  ObtenerToken(const parameters: TEcodexSolicitudDeToken): TEcodexRespuestaObtenerToken; stdcall;
  end;

function GetWsEcodexSeguridad(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioSeguridad;


implementation
  uses SysUtils;

function GetWsEcodexSeguridad(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioSeguridad;
const
  defWSDL = 'https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc?wsdl';
  defURL  = 'https://pruebas.ecodex.com.mx:2045/ServicioSeguridad.svc';
  defSvc  = 'IEcodexServicioSeguridad';
  defPrt  = 'PuertoSeguridadSeguro';
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
    Result := (RIO as IEcodexServicioSeguridad);
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

constructor TEcodexSolicitudDeToken.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexSolicitudDeToken.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudDeToken.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexSolicitudDeToken.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudDeToken.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexRespuestaObtenerToken.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexRespuestaObtenerToken.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexRespuestaObtenerToken.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexRespuestaObtenerToken.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaObtenerToken.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

initialization
  { IEcodexServicioSeguridad }
  InvRegistry.RegisterInterface(TypeInfo(IEcodexServicioSeguridad), 'http://Ecodex.WS.Model/2011/CFDI', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IEcodexServicioSeguridad), 'http://Ecodex.WS.Model/2011/CFDI/Seguridad/ObtenerToken');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioSeguridad), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioSeguridad), ioLiteral);
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudDeToken, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudObtenerToken');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudDeToken, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaObtenerToken, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaObtenerToken');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaObtenerToken, [xoLiteralParam]);

end.