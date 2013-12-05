unit FinkOkWsTimbrado;

// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://demo-facturacion.finkok.com/servicios/soap/stamp.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (11/25/2013 1:07:55 PM - 1.33.2.5)
// ************************************************************************ //

// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://demo-facturacion.finkok.com/servicios/soap/cancel.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (11/25/2013 1:11:58 PM - 1.33.2.5)
// ************************************************************************ //

// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://demo-facturacion.finkok.com/servicios/soap/registration.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (11/26/2013 10:04:30 AM - 1.33.2.5)
// ************************************************************************ //

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"
/// usados para timbrar
  QueryPendingResult       = class;                 { "apps.services.soap.core.views" } //timbrar y cancelar
  Incidencia               = class;                 { "apps.services.soap.core.views" }
  TFinkOkRespuestaTimbrado = class;                 { "apps.services.soap.core.views" }
// usados para cancelar
  UUIDS                    = class;                 { "apps.services.soap.core.views" }
  Folio                    = class;                 { "apps.services.soap.core.views" }
  CancelaCFDResult         = class;                 { "apps.services.soap.core.views" }
  ReceiptResult            = class;                 { "apps.services.soap.core.views" }
// usados para registrar nuevo rfc
  IFinkOkRespuestaRegistro       = class;                 { "apps.services.soap.core.views" }
  stringArray = array of WideString;            { "http://facturacion.finkok.com/cancellation" }


  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  QueryPendingResult = class(TRemotable)
  private
    Fstatus: WideString;
    Fxml: WideString;
    Fuuid: WideString;
    Fuuid_status: WideString;
    Fnext_attempt: WideString;
    Fattempts: WideString;
    Ferror: WideString;
    Fdate: WideString;
  published
    property status: WideString read Fstatus write Fstatus;
    property xml: WideString read Fxml write Fxml;
    property uuid: WideString read Fuuid write Fuuid;
    property uuid_status: WideString read Fuuid_status write Fuuid_status;
    property next_attempt: WideString read Fnext_attempt write Fnext_attempt;
    property attempts: WideString read Fattempts write Fattempts;
    property error: WideString read Ferror write Ferror;
    property date: WideString read Fdate write Fdate;
  end;



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Incidencia = class(TRemotable)
  private
    FIdIncidencia: WideString;
    FUuid: WideString;
    FCodigoError: WideString;
    FWorkProcessId: WideString;
    FMensajeIncidencia: WideString;
    FRfcEmisor: WideString;
    FNoCertificadoPac: WideString;
    FFechaRegistro: WideString;
  published
    property IdIncidencia: WideString read FIdIncidencia write FIdIncidencia;
    property Uuid: WideString read FUuid write FUuid;
    property CodigoError: WideString read FCodigoError write FCodigoError;
    property WorkProcessId: WideString read FWorkProcessId write FWorkProcessId;
    property MensajeIncidencia: WideString read FMensajeIncidencia write FMensajeIncidencia;
    property RfcEmisor: WideString read FRfcEmisor write FRfcEmisor;
    property NoCertificadoPac: WideString read FNoCertificadoPac write FNoCertificadoPac;
    property FechaRegistro: WideString read FFechaRegistro write FFechaRegistro;
  end;

  IncidenciaArray = array of Incidencia;        { "apps.services.soap.core.views" }


  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //

 TFinkOkRespuestaTimbrado = class(TRemotable)
  private
    Fxml: WideString;
    FUUID: WideString;
    Ffaultstring: WideString;
    FFecha: WideString;
    FCodEstatus: WideString;
    Ffaultcode: WideString;
    FSatSeal: WideString;
    FIncidencias: IncidenciaArray;
    FNoCertificadoSAT: WideString;
  public
    destructor Destroy; override;
  published
    property xml: WideString read Fxml write Fxml;
    property UUID: WideString read FUUID write FUUID;
    property faultstring: WideString read Ffaultstring write Ffaultstring;
    property Fecha: WideString read FFecha write FFecha;
    property CodEstatus: WideString read FCodEstatus write FCodEstatus;
    property faultcode: WideString read Ffaultcode write Ffaultcode;
    property SatSeal: WideString read FSatSeal write FSatSeal;
    property Incidencias: IncidenciaArray read FIncidencias write FIncidencias;
    property NoCertificadoSAT: WideString read FNoCertificadoSAT write FNoCertificadoSAT;
  end;

  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS = class(TRemotable)
  private
    Fuuids: stringArray;
//    constructor Create; overload;
  published
    property uuids: stringArray read Fuuids write Fuuids;
  end;


  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Folio = class(TRemotable)
  private
    FEstatusUUID: WideString;
    FUUID: WideString;
  published
    property EstatusUUID: WideString read FEstatusUUID write FEstatusUUID;
    property UUID: WideString read FUUID write FUUID;
  end;

  FolioArray = array of Folio;                  { "apps.services.soap.core.views" }

  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  CancelaCFDResult = class(TRemotable)
  private
    FFolios: FolioArray;
    FAcuse: WideString;
    FFecha: WideString;
    FRfcEmisor: WideString;
    FCodEstatus: WideString;
  public
    destructor Destroy; override;
  published
    property Folios: FolioArray read FFolios write FFolios;
    property Acuse: WideString read FAcuse write FAcuse;
    property Fecha: WideString read FFecha write FFecha;
    property RfcEmisor: WideString read FRfcEmisor write FRfcEmisor;
    property CodEstatus: WideString read FCodEstatus write FCodEstatus;
  end;



  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReceiptResult = class(TRemotable)
  private
    Fuuid: WideString;
    Fsuccess: Boolean;
    Freceipt: WideString;
    Ftaxpayer_id: WideString;
    Ferror: WideString;
    Fdate: WideString;
  published
    property uuid: WideString read Fuuid write Fuuid;
    property success: Boolean read Fsuccess write Fsuccess;
    property receipt: WideString read Freceipt write Freceipt;
    property taxpayer_id: WideString read Ftaxpayer_id write Ftaxpayer_id;
    property error: WideString read Ferror write Ferror;
    property date: WideString read Fdate write Fdate;
  end;

  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  IFinkOkRespuestaRegistro = class(TRemotable)
  private
    Fmessage: WideString;
    Fsuccess: Boolean;
  published
    property message: WideString read Fmessage write Fmessage;
    property success: Boolean read Fsuccess write Fsuccess;
  end;

  // ************************************************************************ //
  // Namespace : http://facturacion.finkok.com/stamp
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Application
  // service   : StampSOAP
  // port      : Application
  // URL       : http://demo-facturacion.finkok.com/servicios/soap/stamp
  // ************************************************************************ //

  IFinkOkServicioTimbrado = interface(IInvokable)
  ['{0AA07360-97A0-C6DA-8BD0-6C56DCAE7D6F}']
    function  stamp(const xml: TByteDynArray; const username: WideString; const password: WideString): TFinkOkRespuestaTimbrado; stdcall;
    function  stamped(const xml: TByteDynArray; const username: WideString; const password: WideString): TFinkOkRespuestaTimbrado; stdcall;
    function  quick_stamp(const xml: TByteDynArray; const username: WideString; const password: WideString): TFinkOkRespuestaTimbrado; stdcall;
    function  query_pending(const username: WideString; const password: WideString; const uuid: WideString): QueryPendingResult; stdcall;
  end;

  // ************************************************************************ //
  // Namespace : http://facturacion.finkok.com/cancel
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Aplicacion
  // service   : CancelSOAP
  // port      : Aplicacion
  // URL       : http://demo-facturacion.finkok.com/servicios/soap/cancel
  // ************************************************************************ //

  IFinkOkCancelaTimbrado = interface(IInvokable)
  ['{A50B2847-80CB-1437-9E24-A9C18DE43316}']
    function  cancel(const UUIDS: UUIDS; const username: WideString; const password: WideString; const taxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray; const store_pending: Boolean): CancelaCFDResult; stdcall;
    function  query_pending_cancellation(const username: WideString; const password: WideString; const uuid: WideString): QueryPendingResult; stdcall;
    function  get_receipt(const username: WideString; const password: WideString; const taxpayer_id: WideString; const uuid: WideString; const type_: WideString): ReceiptResult; stdcall;
    function  out_cancel(const xml: TByteDynArray; const username: WideString; const password: WideString; const taxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray; const store_pending: Boolean): CancelaCFDResult; stdcall;
  end;

  // ************************************************************************ //
  // Namespace : http://facturacion.finkok.com/registration
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Aplicacion
  // service   : RegistrationSOAP
  // port      : Aplicacion
  // URL       : http://demo-facturacion.finkok.com/servicios/soap/registration
  // ************************************************************************ //
  IFinkOkAltaCliente = interface(IInvokable)
  ['{8E23E329-6B09-E96E-D30F-4E0B79723D1D}']
    function  edit(const reseller_username: WideString; const reseller_password: WideString; const taxpayer_id: WideString; const status: WideString): IFinkOkRespuestaRegistro; stdcall;
    function  add(const reseller_username: WideString; const reseller_password: WideString; const taxpayer_id: WideString; const coupon: WideString; const added: WideString): IFinkOkRespuestaRegistro; stdcall;
    function  delete(const reseller_username: WideString; const reseller_password: WideString; const taxpayer_id: WideString): IFinkOkRespuestaRegistro; stdcall;
  end;

function GetFinkOkTimbrado(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkServicioTimbrado;
function GetFinkOkCancelar(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil):   IFinkOkCancelaTimbrado;
function GetFinkOkCliente(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkAltaCliente;

implementation

function GetFinkOkTimbrado(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkServicioTimbrado;
const
  defWSDL = 'http://demo-facturacion.finkok.com/servicios/soap/stamp.wsdl';
  defURL  = 'http://demo-facturacion.finkok.com/servicios/soap/stamp';
  defSvc  = 'StampSOAP';
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
    Result := (RIO as IFinkOkServicioTimbrado);
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

function GetFinkOkCancelar(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkCancelaTimbrado;
const
  defWSDL = 'http://demo-facturacion.finkok.com/servicios/soap/cancel.wsdl';
  defURL  = 'http://demo-facturacion.finkok.com/servicios/soap/cancel';
  defSvc  = 'CancelSOAP';
  defPrt  = 'Aplicacion';
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
    Result := (RIO as IFinkOkCancelaTimbrado);
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

function GetFinkOkCliente(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkAltaCliente;
const
  defWSDL = 'http://demo-facturacion.finkok.com/servicios/soap/registration.wsdl';
  defURL  = 'http://demo-facturacion.finkok.com/servicios/soap/registration';
  defSvc  = 'RegistrationSOAP';
  defPrt  = 'Aplicacion';
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
    Result := (RIO as IFinkOkAltaCliente);
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

destructor TFinkOkRespuestaTimbrado.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FIncidencias)-1 do
    if Assigned(FIncidencias[I]) then
      FIncidencias[I].Free;
  SetLength(FIncidencias, 0);
  inherited Destroy;
end;

destructor CancelaCFDResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FFolios)-1 do
    if Assigned(FFolios[I]) then
      FFolios[I].Free;
  SetLength(FFolios, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkServicioTimbrado), 'http://facturacion.finkok.com/stamp', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkServicioTimbrado), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkServicioTimbrado), ioDocument);
  RemClassRegistry.RegisterXSClass(QueryPendingResult, 'apps.services.soap.core.views', 'QueryPendingResult');
  RemClassRegistry.RegisterXSClass(Incidencia, 'apps.services.soap.core.views', 'Incidencia');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IncidenciaArray), 'apps.services.soap.core.views', 'IncidenciaArray');
  RemClassRegistry.RegisterXSClass(TFinkOkRespuestaTimbrado, 'apps.services.soap.core.views', 'AcuseRecepcionCFDI');
/// registro las que son para cancelar
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkCancelaTimbrado), 'http://facturacion.finkok.com/cancel', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkCancelaTimbrado), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkCancelaTimbrado), ioDocument);
  InvRegistry.RegisterExternalParamName(TypeInfo(IFinkOkCancelaTimbrado), 'get_receipt', 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stringArray), 'http://facturacion.finkok.com/cancellation', 'stringArray');
  RemClassRegistry.RegisterXSClass(UUIDS, 'apps.services.soap.core.views', 'UUIDS');
  RemClassRegistry.RegisterXSClass(Folio, 'apps.services.soap.core.views', 'Folio');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FolioArray), 'apps.services.soap.core.views', 'FolioArray');
  RemClassRegistry.RegisterXSClass(CancelaCFDResult, 'apps.services.soap.core.views', 'CancelaCFDResult');
  RemClassRegistry.RegisterXSClass(ReceiptResult, 'apps.services.soap.core.views', 'ReceiptResult');
// registro las que son para dar de alta Clientes (RFC)
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkAltaCliente), 'http://facturacion.finkok.com/registration', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkAltaCliente), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkAltaCliente), ioDocument);
  RemClassRegistry.RegisterXSClass(IFinkOkRespuestaRegistro, 'apps.services.soap.core.views', 'RegistrationResult');


end.
