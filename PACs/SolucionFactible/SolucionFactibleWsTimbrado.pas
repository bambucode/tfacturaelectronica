// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://solucionfactible.com/ws/services/Timbrado?wsdl
//  >Import : https://solucionfactible.com/ws/services/Timbrado?wsdl>0
//  >Import : https://solucionfactible.com/ws/services/Timbrado?wsdl>1
// Encoding : UTF-8
// Version  : 1.0
// (27/08/2017 01:05:36 p. m. - - $Rev: 90173 $)
// ************************************************************************ //

unit SolucionFactibleWsTimbrado;

interface

uses
{$IF CompilerVersion >= 23}
 Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns
{$ELSE}
 InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns
{$IFEND}
 ;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
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
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  CFDICertificacion    = class;                 { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblCplx] }
  CFDICancelacion      = class;                 { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblCplx] }
  CFDIResultadoCancelacion = class;             { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblCplx] }
  CFDIResultadoCertificacion = class;           { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblCplx] }

  Array_Of_CFDIResultadoCancelacion = array of CFDIResultadoCancelacion;   { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblUbnd] }
  Array_Of_CFDIResultadoCertificacion = array of CFDIResultadoCertificacion;   { "http://timbrado.ws.cfdi.solucionfactible.com/xsd"[GblUbnd] }


  // ************************************************************************ //
  // XML       : CFDICertificacion, global, <complexType>
  // Namespace : http://timbrado.ws.cfdi.solucionfactible.com/xsd
  // ************************************************************************ //
  CFDICertificacion = class(TRemotable)
  private
    Fmensaje: string;
    Fmensaje_Specified: boolean;
    Fresultados: Array_Of_CFDIResultadoCertificacion;
    Fresultados_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Setmensaje(Index: Integer; const Astring: string);
    function  mensaje_Specified(Index: Integer): boolean;
    procedure Setresultados(Index: Integer; const AArray_Of_CFDIResultadoCertificacion: Array_Of_CFDIResultadoCertificacion);
    function  resultados_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property mensaje:    string                               Index (IS_OPTN or IS_NLBL) read Fmensaje write Setmensaje stored mensaje_Specified;
    property resultados: Array_Of_CFDIResultadoCertificacion  Index (IS_OPTN or IS_UNBD or IS_NLBL) read Fresultados write Setresultados stored resultados_Specified;
    property status:     Integer                              Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : CFDICancelacion, global, <complexType>
  // Namespace : http://timbrado.ws.cfdi.solucionfactible.com/xsd
  // ************************************************************************ //
  CFDICancelacion = class(TRemotable)
  private
    Fmensaje: string;
    Fmensaje_Specified: boolean;
    Fresultados: Array_Of_CFDIResultadoCancelacion;
    Fresultados_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Setmensaje(Index: Integer; const Astring: string);
    function  mensaje_Specified(Index: Integer): boolean;
    procedure Setresultados(Index: Integer; const AArray_Of_CFDIResultadoCancelacion: Array_Of_CFDIResultadoCancelacion);
    function  resultados_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property mensaje:    string                             Index (IS_OPTN or IS_NLBL) read Fmensaje write Setmensaje stored mensaje_Specified;
    property resultados: Array_Of_CFDIResultadoCancelacion  Index (IS_OPTN or IS_UNBD or IS_NLBL) read Fresultados write Setresultados stored resultados_Specified;
    property status:     Integer                            Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
  end;

  Array_Of_string = array of string;            { "http://www.w3.org/2001/XMLSchema"[GblUbnd] }


  // ************************************************************************ //
  // XML       : CFDIResultadoCancelacion, global, <complexType>
  // Namespace : http://timbrado.ws.cfdi.solucionfactible.com/xsd
  // ************************************************************************ //
  CFDIResultadoCancelacion = class(TRemotable)
  private
    Fmensaje: string;
    Fmensaje_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    FstatusUUID: string;
    FstatusUUID_Specified: boolean;
    Fuuid: string;
    Fuuid_Specified: boolean;
    procedure Setmensaje(Index: Integer; const Astring: string);
    function  mensaje_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
    procedure SetstatusUUID(Index: Integer; const Astring: string);
    function  statusUUID_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
  published
    property mensaje:    string   Index (IS_OPTN or IS_NLBL) read Fmensaje write Setmensaje stored mensaje_Specified;
    property status:     Integer  Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property statusUUID: string   Index (IS_OPTN or IS_NLBL) read FstatusUUID write SetstatusUUID stored statusUUID_Specified;
    property uuid:       string   Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
  end;



  // ************************************************************************ //
  // XML       : CFDIResultadoCertificacion, global, <complexType>
  // Namespace : http://timbrado.ws.cfdi.solucionfactible.com/xsd
  // ************************************************************************ //
  CFDIResultadoCertificacion = class(TRemotable)
  private
    FcadenaOriginal: string;
    FcadenaOriginal_Specified: boolean;
    FcertificadoSAT: string;
    FcertificadoSAT_Specified: boolean;
    FcfdiTimbrado: TByteDynArray;
    FcfdiTimbrado_Specified: boolean;
    FfechaTimbrado: TXSDateTime;
    FfechaTimbrado_Specified: boolean;
    Fmensaje: string;
    Fmensaje_Specified: boolean;
    FqrCode: TByteDynArray;
    FqrCode_Specified: boolean;
    FselloSAT: string;
    FselloSAT_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    Fuuid: string;
    Fuuid_Specified: boolean;
    FversionTFD: string;
    FversionTFD_Specified: boolean;
    procedure SetcadenaOriginal(Index: Integer; const Astring: string);
    function  cadenaOriginal_Specified(Index: Integer): boolean;
    procedure SetcertificadoSAT(Index: Integer; const Astring: string);
    function  certificadoSAT_Specified(Index: Integer): boolean;
    procedure SetcfdiTimbrado(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  cfdiTimbrado_Specified(Index: Integer): boolean;
    procedure SetfechaTimbrado(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  fechaTimbrado_Specified(Index: Integer): boolean;
    procedure Setmensaje(Index: Integer; const Astring: string);
    function  mensaje_Specified(Index: Integer): boolean;
    procedure SetqrCode(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  qrCode_Specified(Index: Integer): boolean;
    procedure SetselloSAT(Index: Integer; const Astring: string);
    function  selloSAT_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure SetversionTFD(Index: Integer; const Astring: string);
    function  versionTFD_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cadenaOriginal: string         Index (IS_OPTN or IS_NLBL) read FcadenaOriginal write SetcadenaOriginal stored cadenaOriginal_Specified;
    property certificadoSAT: string         Index (IS_OPTN or IS_NLBL) read FcertificadoSAT write SetcertificadoSAT stored certificadoSAT_Specified;
    property cfdiTimbrado:   TByteDynArray  Index (IS_OPTN or IS_NLBL) read FcfdiTimbrado write SetcfdiTimbrado stored cfdiTimbrado_Specified;
    property fechaTimbrado:  TXSDateTime    Index (IS_OPTN or IS_NLBL) read FfechaTimbrado write SetfechaTimbrado stored fechaTimbrado_Specified;
    property mensaje:        string         Index (IS_OPTN or IS_NLBL) read Fmensaje write Setmensaje stored mensaje_Specified;
    property qrCode:         TByteDynArray  Index (IS_OPTN or IS_NLBL) read FqrCode write SetqrCode stored qrCode_Specified;
    property selloSAT:       string         Index (IS_OPTN or IS_NLBL) read FselloSAT write SetselloSAT stored selloSAT_Specified;
    property status:         Integer        Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property uuid:           string         Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property versionTFD:     string         Index (IS_OPTN or IS_NLBL) read FversionTFD write SetversionTFD stored versionTFD_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://timbrado.ws.cfdi.solucionfactible.com
  // soapAction: urn:%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : TimbradoSoap11Binding
  // service   : Timbrado
  // port      : TimbradoHttpsSoap11Endpoint
  // URL       : https://solucionfactible.com/ws/services/Timbrado.TimbradoHttpsSoap11Endpoint/
  // ************************************************************************ //
  TimbradoPortType = interface(IInvokable)
  ['{68544C63-E3B5-04D6-1F81-E0B578F1063F}']
    function  cancelarPorNotaCredito(const usuario: string; const password: string; const uuid: string; const derCertCSD: TByteDynArray; const derKeyCSD: TByteDynArray; const contrasenaCSD: string
                                     ): CFDIResultadoCertificacion; stdcall;
    function  cancelarViaCSDAlmacenado(const usuario: string; const password: string; const rfcEmisor: string; const uuids: Array_Of_string): CFDICancelacion; stdcall;
    function  enviarSolicitudCancelacion(const usuario: string; const password: string; const solicitudCancelacion: TByteDynArray): CFDICancelacion; stdcall;
    function  cancelar(const usuario: string; const password: string; const uuids: Array_Of_string; const derCertCSD: TByteDynArray; const derKeyCSD: TByteDynArray; const contrasenaCSD: string
                       ): CFDICancelacion; stdcall;
    function  timbrarBase64(const usuario: string; const password: string; const cfdiBase64: string; const zip: Boolean): CFDICertificacion; stdcall;
    function  timbrar(const usuario: string; const password: string; const cfdi: TByteDynArray; const zip: Boolean): CFDICertificacion; stdcall;
    function  cancelarBase64(const usuario: string; const password: string; const uuids: Array_Of_string; const derCertCSDBase64: string; const derKeyCSDBase64: string; const contrasenaCSD: string
                             ): CFDICancelacion; stdcall;
  end;

function GetTimbradoPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): TimbradoPortType;


implementation
  uses
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
;

function GetTimbradoPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): TimbradoPortType;
const
  defWSDL = 'https://solucionfactible.com/ws/services/Timbrado?wsdl';
  defURL  = 'https://solucionfactible.com/ws/services/Timbrado.TimbradoHttpsSoap11Endpoint/';
  defSvc  = 'Timbrado';
  defPrt  = 'TimbradoHttpsSoap11Endpoint';
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
    Result := (RIO as TimbradoPortType);
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


destructor CFDICertificacion.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fresultados)-1 do
    {$IF CompilerVersion >= 23}System.SysUtils{$ELSE}SysUtils{$IFEND}.FreeAndNil(Fresultados[I]);
  System.SetLength(Fresultados, 0);
  inherited Destroy;
end;

procedure CFDICertificacion.Setmensaje(Index: Integer; const Astring: string);
begin
  Fmensaje := Astring;
  Fmensaje_Specified := True;
end;

function CFDICertificacion.mensaje_Specified(Index: Integer): boolean;
begin
  Result := Fmensaje_Specified;
end;

procedure CFDICertificacion.Setresultados(Index: Integer; const AArray_Of_CFDIResultadoCertificacion: Array_Of_CFDIResultadoCertificacion);
begin
  Fresultados := AArray_Of_CFDIResultadoCertificacion;
  Fresultados_Specified := True;
end;

function CFDICertificacion.resultados_Specified(Index: Integer): boolean;
begin
  Result := Fresultados_Specified;
end;

procedure CFDICertificacion.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function CFDICertificacion.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

destructor CFDICancelacion.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fresultados)-1 do
    {$IF CompilerVersion >= 23}System.SysUtils{$ELSE}SysUtils{$IFEND}.FreeAndNil(Fresultados[I]);
  System.SetLength(Fresultados, 0);
  inherited Destroy;
end;

procedure CFDICancelacion.Setmensaje(Index: Integer; const Astring: string);
begin
  Fmensaje := Astring;
  Fmensaje_Specified := True;
end;

function CFDICancelacion.mensaje_Specified(Index: Integer): boolean;
begin
  Result := Fmensaje_Specified;
end;

procedure CFDICancelacion.Setresultados(Index: Integer; const AArray_Of_CFDIResultadoCancelacion: Array_Of_CFDIResultadoCancelacion);
begin
  Fresultados := AArray_Of_CFDIResultadoCancelacion;
  Fresultados_Specified := True;
end;

function CFDICancelacion.resultados_Specified(Index: Integer): boolean;
begin
  Result := Fresultados_Specified;
end;

procedure CFDICancelacion.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function CFDICancelacion.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure CFDIResultadoCancelacion.Setmensaje(Index: Integer; const Astring: string);
begin
  Fmensaje := Astring;
  Fmensaje_Specified := True;
end;

function CFDIResultadoCancelacion.mensaje_Specified(Index: Integer): boolean;
begin
  Result := Fmensaje_Specified;
end;

procedure CFDIResultadoCancelacion.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function CFDIResultadoCancelacion.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure CFDIResultadoCancelacion.SetstatusUUID(Index: Integer; const Astring: string);
begin
  FstatusUUID := Astring;
  FstatusUUID_Specified := True;
end;

function CFDIResultadoCancelacion.statusUUID_Specified(Index: Integer): boolean;
begin
  Result := FstatusUUID_Specified;
end;

procedure CFDIResultadoCancelacion.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function CFDIResultadoCancelacion.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

destructor CFDIResultadoCertificacion.Destroy;
begin
  {$IF CompilerVersion >= 23}System.SysUtils{$ELSE}SysUtils{$IFEND}.FreeAndNil(FfechaTimbrado);
  inherited Destroy;
end;

procedure CFDIResultadoCertificacion.SetcadenaOriginal(Index: Integer; const Astring: string);
begin
  FcadenaOriginal := Astring;
  FcadenaOriginal_Specified := True;
end;

function CFDIResultadoCertificacion.cadenaOriginal_Specified(Index: Integer): boolean;
begin
  Result := FcadenaOriginal_Specified;
end;

procedure CFDIResultadoCertificacion.SetcertificadoSAT(Index: Integer; const Astring: string);
begin
  FcertificadoSAT := Astring;
  FcertificadoSAT_Specified := True;
end;

function CFDIResultadoCertificacion.certificadoSAT_Specified(Index: Integer): boolean;
begin
  Result := FcertificadoSAT_Specified;
end;

procedure CFDIResultadoCertificacion.SetcfdiTimbrado(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FcfdiTimbrado := ATByteDynArray;
  FcfdiTimbrado_Specified := True;
end;

function CFDIResultadoCertificacion.cfdiTimbrado_Specified(Index: Integer): boolean;
begin
  Result := FcfdiTimbrado_Specified;
end;

procedure CFDIResultadoCertificacion.SetfechaTimbrado(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FfechaTimbrado := ATXSDateTime;
  FfechaTimbrado_Specified := True;
end;

function CFDIResultadoCertificacion.fechaTimbrado_Specified(Index: Integer): boolean;
begin
  Result := FfechaTimbrado_Specified;
end;

procedure CFDIResultadoCertificacion.Setmensaje(Index: Integer; const Astring: string);
begin
  Fmensaje := Astring;
  Fmensaje_Specified := True;
end;

function CFDIResultadoCertificacion.mensaje_Specified(Index: Integer): boolean;
begin
  Result := Fmensaje_Specified;
end;

procedure CFDIResultadoCertificacion.SetqrCode(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FqrCode := ATByteDynArray;
  FqrCode_Specified := True;
end;

function CFDIResultadoCertificacion.qrCode_Specified(Index: Integer): boolean;
begin
  Result := FqrCode_Specified;
end;

procedure CFDIResultadoCertificacion.SetselloSAT(Index: Integer; const Astring: string);
begin
  FselloSAT := Astring;
  FselloSAT_Specified := True;
end;

function CFDIResultadoCertificacion.selloSAT_Specified(Index: Integer): boolean;
begin
  Result := FselloSAT_Specified;
end;

procedure CFDIResultadoCertificacion.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function CFDIResultadoCertificacion.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure CFDIResultadoCertificacion.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function CFDIResultadoCertificacion.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure CFDIResultadoCertificacion.SetversionTFD(Index: Integer; const Astring: string);
begin
  FversionTFD := Astring;
  FversionTFD_Specified := True;
end;

function CFDIResultadoCertificacion.versionTFD_Specified(Index: Integer): boolean;
begin
  Result := FversionTFD_Specified;
end;

initialization
  { TimbradoPortType }
  InvRegistry.RegisterInterface(TypeInfo(TimbradoPortType), 'http://timbrado.ws.cfdi.solucionfactible.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TimbradoPortType), 'urn:%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(TimbradoPortType), ioDocument);
  { TimbradoPortType.cancelarPorNotaCredito }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'uuid', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'derCertCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'derKeyCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'contrasenaCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarPorNotaCredito', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.cancelarViaCSDAlmacenado }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', 'rfcEmisor', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', 'uuids', '',
                                '', IS_UNBD or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarViaCSDAlmacenado', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.enviarSolicitudCancelacion }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'enviarSolicitudCancelacion', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'enviarSolicitudCancelacion', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'enviarSolicitudCancelacion', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'enviarSolicitudCancelacion', 'solicitudCancelacion', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'enviarSolicitudCancelacion', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.cancelar }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'cancelar', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'uuids', '',
                                '', IS_UNBD or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'derCertCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'derKeyCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'contrasenaCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelar', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.timbrarBase64 }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'timbrarBase64', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrarBase64', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrarBase64', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrarBase64', 'cfdiBase64', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrarBase64', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.timbrar }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'timbrar', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrar', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrar', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrar', 'cfdi', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'timbrar', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  { TimbradoPortType.cancelarBase64 }
  InvRegistry.RegisterMethodInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'usuario', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'password', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'uuids', '',
                                '', IS_UNBD or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'derCertCSDBase64', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'derKeyCSDBase64', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'contrasenaCSD', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(TimbradoPortType), 'cancelarBase64', 'return', '',
                                '[Namespace="http://timbrado.ws.cfdi.solucionfactible.com/xsd"]', IS_NLBL);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_CFDIResultadoCancelacion), 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'Array_Of_CFDIResultadoCancelacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_CFDIResultadoCertificacion), 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'Array_Of_CFDIResultadoCertificacion');
  RemClassRegistry.RegisterXSClass(CFDICertificacion, 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'CFDICertificacion');
  RemClassRegistry.RegisterXSClass(CFDICancelacion, 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'CFDICancelacion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_string), 'http://www.w3.org/2001/XMLSchema', 'Array_Of_string');
  RemClassRegistry.RegisterXSClass(CFDIResultadoCancelacion, 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'CFDIResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(CFDIResultadoCertificacion, 'http://timbrado.ws.cfdi.solucionfactible.com/xsd', 'CFDIResultadoCertificacion');

end.