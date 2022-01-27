{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{        Soporte del pac FinkOK Tecsis.Mx               }
{                                                       }
{*******************************************************}
unit FinkOkWsTimbrado;


interface

uses InvokeRegistry, SOAPHTTPClient,SysUtils, {$IF CompilerVersion >= 23}System.Types{$ELSE}Types{$IFEND}, XSBuiltIns,Facturacion.Comprobante;

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
  TFinkOkComprobanteXML       = class;                 { "apps.services.soap.core.views" } //timbrar y cancelar
  Incidencia               = class;                 { "apps.services.soap.core.views" }
  TFinkOkRespuestaTimbrado = class;                 { "apps.services.soap.core.views" }
  // ************************************************************************ //
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  TFinkOkComprobanteXML = class(TRemotable)
  private
    Fstatus: WideString;
    Fxml: TCadenaUTF8;
    Fuuid: WideString;
    Fuuid_status: WideString;
    Fnext_attempt: WideString;
    Fattempts: WideString;
    Ferror: WideString;
    Fdate: WideString;
  published
    property status: WideString read Fstatus write Fstatus;
    property xml: TCadenaUTF8 read Fxml write Fxml;
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
    Fxml: TCadenaUTF8;
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
    property xml: TCadenaUTF8 read Fxml write Fxml;
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
    function  query_pending(const username: WideString; const password: WideString; const uuid: WideString): TFinkOkComprobanteXML; stdcall;
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
function GetWsFinkOkTimbrado(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkServicioTimbrado;
//function GetFinkOkCancelar(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil):   IFinkOkCancelaTimbrado;
function GetFinkOkCliente(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkAltaCliente;

implementation

function GetWsFinkOkTimbrado(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkServicioTimbrado;
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

{function GetFinkOkCancelar(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkCancelaTimbrado;
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
}
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

initialization
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkServicioTimbrado), 'http://facturacion.finkok.com/stamp', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkServicioTimbrado), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkServicioTimbrado), ioDocument);
  RemClassRegistry.RegisterXSClass(TFinkOkComprobanteXML, 'apps.services.soap.core.views', 'TFinkOkComprobanteXML');
  RemClassRegistry.RegisterXSClass(Incidencia, 'apps.services.soap.core.views', 'Incidencia');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IncidenciaArray), 'apps.services.soap.core.views', 'IncidenciaArray');
  RemClassRegistry.RegisterXSClass(TFinkOkRespuestaTimbrado, 'apps.services.soap.core.views', 'AcuseRecepcionCFDI');
// registro las que son para dar de alta Clientes (RFC)
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkAltaCliente), 'http://facturacion.finkok.com/registration', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkAltaCliente), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkAltaCliente), ioDocument);
  RemClassRegistry.RegisterXSClass(IFinkOkRespuestaRegistro, 'apps.services.soap.core.views', 'RegistrationResult');


end.
