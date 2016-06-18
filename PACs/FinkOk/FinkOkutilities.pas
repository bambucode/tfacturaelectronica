// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://demo-facturacion.finkok.com/servicios/soap/utilities.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (4/4/2014 1:50:57 PM - 1.33.2.5)
// ************************************************************************ //

unit FinkOkutilities;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:integer         - "http://www.w3.org/2001/XMLSchema"

  DateResult           = class;                 { "apps.services.soap.core.views" }
  XMLResult            = class;                 { "apps.services.soap.core.views" }
  ReportUUID           = class;                 { "apps.services.soap.core.views" }
  ReportUUIDResult     = class;                 { "apps.services.soap.core.views" }
  ReportTotal          = class;                 { "apps.services.soap.core.views" }
  ReportTotalResult    = class;                 { "apps.services.soap.core.views" }



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  DateResult = class(TRemotable)
  private
    Ferror: WideString;
    Fdatetime: WideString;
  published
    property error: WideString read Ferror write Ferror;
    property datetime: WideString read Fdatetime write Fdatetime;
  end;



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  XMLResult = class(TRemotable)
  private
    Fxml: WideString;
    Ferror: WideString;
  published
    property xml: WideString read Fxml write Fxml;
    property error: WideString read Ferror write Ferror;
  end;



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReportUUID = class(TRemotable)
  private
    Fdate: TXSDateTime;
    Fuuid: WideString;
  public
    destructor Destroy; override;
  published
    property date: TXSDateTime read Fdate write Fdate;
    property uuid: WideString read Fuuid write Fuuid;
  end;

  ReportUUIDArray = array of ReportUUID;        { "apps.services.soap.core.views" }


  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReportUUIDResult = class(TRemotable)
  private
    Finvoices: ReportUUIDArray;
    Ferror: WideString;
  public
    destructor Destroy; override;
  published
    property invoices: ReportUUIDArray read Finvoices write Finvoices;
    property error: WideString read Ferror write Ferror;
  end;



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReportTotal = class(TRemotable)
  private
    Ftotal: integer;
    Ftaxpayer_id: WideString;
  published
    property total: integer read Ftotal write Ftotal;
    property taxpayer_id: WideString read Ftaxpayer_id write Ftaxpayer_id;
  end;

  ReportTotalArray = array of ReportTotal;      { "apps.services.soap.core.views" }


  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReportTotalResult = class(TRemotable)
  private
    Fresult: ReportTotalArray;
    Ferror: WideString;
  public
    destructor Destroy; override;
  published
    property result: ReportTotalArray read Fresult write Fresult;
    property error: WideString read Ferror write Ferror;
  end;


  // ************************************************************************ //
  // Namespace : http://facturacion.finkok.com/utilities
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Application
  // service   : UtilitiesSOAP
  // port      : Application
  // URL       : http://demo-facturacion.finkok.com/servicios/soap/utilities
  // ************************************************************************ //
  Application = interface(IInvokable)
  ['{76571996-14CD-9B69-F639-DDAAECA79772}']
    function  datetime(const username: WideString; const password: WideString): DateResult; stdcall;
    function  report_total(const username: WideString; const password: WideString; const taxpayer_id: WideString; const date_from: TXSDateTime; const date_to: TXSDateTime): ReportTotalResult; stdcall;
    function  report_uuid(const username: WideString; const password: WideString; const taxpayer_id: WideString; const date_from: TXSDateTime; const date_to: TXSDateTime): ReportUUIDResult; stdcall;
    function  get_xml(const username: WideString; const password: WideString; const uuid: WideString; const taxpayer_id: WideString): XMLResult; stdcall;
  end;

function GetApplication(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Application;


implementation

function GetApplication(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Application;
const
  defWSDL = 'http://demo-facturacion.finkok.com/servicios/soap/utilities.wsdl';
  defURL  = 'http://demo-facturacion.finkok.com/servicios/soap/utilities';
  defSvc  = 'UtilitiesSOAP';
  defPrt  = 'Application';
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
    Result := (RIO as Application);
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


destructor ReportUUID.Destroy;
begin
  if Assigned(Fdate) then
    Fdate.Free;
  inherited Destroy;
end;

destructor ReportUUIDResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Finvoices)-1 do
    if Assigned(Finvoices[I]) then
      Finvoices[I].Free;
  SetLength(Finvoices, 0);
  inherited Destroy;
end;

destructor ReportTotalResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fresult)-1 do
    if Assigned(Fresult[I]) then
      Fresult[I].Free;
  SetLength(Fresult, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(Application), 'http://facturacion.finkok.com/utilities', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Application), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Application), ioDocument);
  RemClassRegistry.RegisterXSClass(DateResult, 'apps.services.soap.core.views', 'DateResult');
  RemClassRegistry.RegisterXSClass(XMLResult, 'apps.services.soap.core.views', 'XMLResult');
  RemClassRegistry.RegisterXSClass(ReportUUID, 'apps.services.soap.core.views', 'ReportUUID');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ReportUUIDArray), 'apps.services.soap.core.views', 'ReportUUIDArray');
  RemClassRegistry.RegisterXSClass(ReportUUIDResult, 'apps.services.soap.core.views', 'ReportUUIDResult');
  RemClassRegistry.RegisterXSClass(ReportTotal, 'apps.services.soap.core.views', 'ReportTotal');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ReportTotalArray), 'apps.services.soap.core.views', 'ReportTotalArray');
  RemClassRegistry.RegisterXSClass(ReportTotalResult, 'apps.services.soap.core.views', 'ReportTotalResult');

end.