// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?wsdl
//  >Import : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?wsdl>0
//  >Import : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?xsd=xsd0
//  >Import : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?xsd=xsd2
//  >Import : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// (10/10/2018 11:31:45 a. m. - - $Rev: 76228 $)
// ************************************************************************ //

unit Facturacion.ConsultaCFDI.WebService;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TAcuseConsultaCFDI                = class;                 { "http://schemas.datacontract.org/2004/07/Sat.Cfdi.Negocio.ConsultaCfdi.Servicio"[GblElm] }


  // ************************************************************************ //
  // XML       : TAcuseConsultaCFDI, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/Sat.Cfdi.Negocio.ConsultaCfdi.Servicio
  // ************************************************************************ //
  TAcuseConsultaCFDI = class(TRemotable)
  private
    FCodigoEstatus: string;
    FCodigoEstatus_Specified: boolean;
    FEstado: string;
    fEstatusCancelacion: String;
    fEstatusCancelacion_Specified : Boolean;
    FEstado_Specified: boolean;
    fEsCancelable: String;
    procedure SetCodigoEstatus(Index: Integer; const Astring: string);
    function  CodigoEstatus_Specified(Index: Integer): boolean;
    procedure SetEstado(Index: Integer; const Astring: string);
    procedure SetEstatusCancelacion(Index: Integer; const Astring: string);
    function  Estado_Specified(Index: Integer): boolean;
    function EstatusCancelacion_Specified(Index: Integer): Boolean;
  published
    property CodigoEstatus: string  Index (IS_OPTN or IS_NLBL) read FCodigoEstatus write SetCodigoEstatus stored CodigoEstatus_Specified;
    property Estado:        string  Index (IS_OPTN or IS_NLBL) read FEstado write SetEstado stored Estado_Specified;
    property EsCancelable:  String  Index (IS_OPTN or IS_NLBL) read fEsCancelable write fEsCancelable;
    property EstatusCancelacion: string  Index (IS_OPTN or IS_NLBL) read fEstatusCancelacion write SetEstatusCancelacion stored EstatusCancelacion_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/IConsultaCFDIWebService/Consulta
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : BasicHttpBinding_IConsultaCFDIService
  // service   : ConsultaCFDIService
  // port      : BasicHttpBinding_IConsultaCFDIService
  // URL       : https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc
  // ************************************************************************ //
  IConsultaCFDIWebService = interface(IInvokable)
  ['{4DF23DD6-082D-EA7B-1ED2-F90B5634558F}']
    function Consulta(const expresionImpresa: string): TAcuseConsultaCFDI; stdcall;
  end;

function GetConsultaCFDIWebService(UseWSDL: Boolean=System.False; Addr:
    string=''; HTTPRIO: THTTPRIO = nil): IConsultaCFDIWebService;

implementation
  uses System.SysUtils;

function GetConsultaCFDIWebService(UseWSDL: Boolean=System.False; Addr:
    string=''; HTTPRIO: THTTPRIO = nil): IConsultaCFDIWebService;
const
  defWSDL = 'https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc?wsdl';
  defURL  = 'https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc';
  defSvc  = 'ConsultaCFDIService';
  defPrt  = 'BasicHttpBinding_IConsultaCFDIService';
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
    Result := (RIO as IConsultaCFDIWebService);
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


procedure TAcuseConsultaCFDI.SetCodigoEstatus(Index: Integer; const Astring: string);
begin
  FCodigoEstatus := Astring;
  FCodigoEstatus_Specified := True;
end;

function TAcuseConsultaCFDI.CodigoEstatus_Specified(Index: Integer): boolean;
begin
  Result := FCodigoEstatus_Specified;
end;

procedure TAcuseConsultaCFDI.SetEstado(Index: Integer; const Astring: string);
begin
  FEstado := Astring;
  FEstado_Specified := True;
end;

procedure TAcuseConsultaCFDI.SetEstatusCancelacion(Index: Integer; const Astring: string);
begin
  fEstatusCancelacion := Astring;
  fEstatusCancelacion_Specified := True;
end;

function TAcuseConsultaCFDI.Estado_Specified(Index: Integer): boolean;
begin
  Result := FEstado_Specified;
end;

function TAcuseConsultaCFDI.EstatusCancelacion_Specified(Index: Integer): Boolean;
begin
  Result := fEstatusCancelacion_Specified;
end;

initialization
  { IConsultaCFDIWebService }
  InvRegistry.RegisterInterface(TypeInfo(IConsultaCFDIWebService), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IConsultaCFDIWebService), 'http://tempuri.org/IConsultaCFDIService/Consulta');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IConsultaCFDIWebService), ioDocument);
  { IConsultaCFDIWebService.Consulta }
  InvRegistry.RegisterMethodInfo(TypeInfo(IConsultaCFDIWebService), 'Consulta', '',
                                 '[ReturnName="ConsultaResult"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IConsultaCFDIWebService), 'Consulta', 'expresionImpresa', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IConsultaCFDIWebService), 'Consulta', 'ConsultaResult', '',
                                '[Namespace="http://schemas.datacontract.org/2004/07/Sat.Cfdi.Negocio.ConsultaCfdi.Servicio"]', IS_NLBL);
  RemClassRegistry.RegisterXSClass(TAcuseConsultaCFDI, 'http://schemas.datacontract.org/2004/07/Sat.Cfdi.Negocio.ConsultaCfdi.Servicio', 'Acuse');

end.