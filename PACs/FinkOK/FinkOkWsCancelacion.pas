// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : D:\Descargas\cancel.wsdl.xml
//  >Import : D:\Descargas\cancel.wsdl.xml>0
//  >Import : D:\Descargas\cancel.wsdl.xml>1
//  >Import : D:\Descargas\cancel.wsdl.xml>2
// Encoding : UTF-8
// Version  : 1.0
// (23/08/2018 08:23:18 a. m. - - $Rev: 90173 $)
// ************************************************************************ //

unit FinkOkWsCancelacion;

interface

uses
{$IF CompilerVersion >= 23}
 Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, System.SysUtils
{$ELSE}
 InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, SysUtils
{$IFEND}
;
const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;


type
// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : D:\Descargas\cancel.wsdl.xml
//  >Import : D:\Descargas\cancel.wsdl.xml>0
//  >Import : D:\Descargas\cancel.wsdl.xml>1
//  >Import : D:\Descargas\cancel.wsdl.xml>2
// Encoding : UTF-8
// Version  : 1.0
// (23/08/2018 08:23:18 a. m. - - $Rev: 90173 $)
// ************************************************************************ //


  UUIDS_AR2            = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcuseSATConsulta2    = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcuseSatEstatus2     = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcceptRejectResult2  = class;                 { "apps.services.soap.core.views"[GblCplx] }
  QueryPendingResult2  = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Rechaza2             = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Accepta2             = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUID_AR2             = class;                 { "apps.services.soap.core.views"[GblCplx] }
  FinkOKRespuestaCancelacion2    = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUIDS2               = class;                 { "apps.services.soap.core.views"[GblCplx] }
  CancelPendingResult2 = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Folio2               = class;                 { "apps.services.soap.core.views"[GblCplx] }
  ReceiptResult2       = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcuseSATConsulta     = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUIDS_AR             = class;                 { "apps.services.soap.core.views"[GblElm] }
  QueryPendingResult   = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUID_AR              = class;                 { "apps.services.soap.core.views"[GblElm] }
  CancelPendingResult  = class;                 { "apps.services.soap.core.views"[GblElm] }
  AcuseSatEstatus      = class;                 { "apps.services.soap.core.views"[GblElm] }
  FinkOKRespuestaCancelacion     = class;                 { "apps.services.soap.core.views"[GblElm] }
  Folio                = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUIDS                = class;                 { "apps.services.soap.core.views"[GblElm] }
  ReceiptResult        = class;                 { "apps.services.soap.core.views"[GblElm] }
  Hijo2                = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Padre2               = class;                 { "apps.services.soap.core.views"[GblCplx] }
  RelatedResult2       = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Padre                = class;                 { "apps.services.soap.core.views"[GblElm] }
  Accepta              = class;                 { "apps.services.soap.core.views"[GblElm] }
  AcceptRejectResult   = class;                 { "apps.services.soap.core.views"[GblElm] }
  Rechaza              = class;                 { "apps.services.soap.core.views"[GblElm] }
  Hijo                 = class;                 { "apps.services.soap.core.views"[GblElm] }
  RelatedResult        = class;                 { "apps.services.soap.core.views"[GblElm] }

  UUID_ARArray = array of UUID_AR2;             { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : UUIDS_AR, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS_AR2 = class(TRemotable)
  private
    Fuuids_ar: UUID_ARArray;
    Fuuids_ar_Specified: boolean;
    procedure Setuuids_ar(Index: Integer; const AUUID_ARArray: UUID_ARArray);
    function  uuids_ar_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property uuids_ar: UUID_ARArray  Index (IS_OPTN or IS_NLBL) read Fuuids_ar write Setuuids_ar stored uuids_ar_Specified;
  end;

  AcceptaArray = array of Accepta2;             { "apps.services.soap.core.views"[GblCplx] }
  RechazaArray = array of Rechaza2;             { "apps.services.soap.core.views"[GblCplx] }
  FolioArray = array of Folio2;                 { "apps.services.soap.core.views"[GblCplx] }
  stringArray = array of string;                { "http://facturacion.finkok.com/cancellation"[GblCplx] }


  // ************************************************************************ //
  // XML       : AcuseSATConsulta, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSATConsulta2 = class(TRemotable)
  private
    FEsCancelable: string;
    FEsCancelable_Specified: boolean;
    FCodigoEstatus: string;
    FCodigoEstatus_Specified: boolean;
    FEstado: string;
    FEstado_Specified: boolean;
    FEstatusCancelacion: string;
    FEstatusCancelacion_Specified: boolean;
    procedure SetEsCancelable(Index: Integer; const Astring: string);
    function  EsCancelable_Specified(Index: Integer): boolean;
    procedure SetCodigoEstatus(Index: Integer; const Astring: string);
    function  CodigoEstatus_Specified(Index: Integer): boolean;
    procedure SetEstado(Index: Integer; const Astring: string);
    function  Estado_Specified(Index: Integer): boolean;
    procedure SetEstatusCancelacion(Index: Integer; const Astring: string);
    function  EstatusCancelacion_Specified(Index: Integer): boolean;
  published
    property EsCancelable:       string  Index (IS_OPTN or IS_NLBL) read FEsCancelable write SetEsCancelable stored EsCancelable_Specified;
    property CodigoEstatus:      string  Index (IS_OPTN or IS_NLBL) read FCodigoEstatus write SetCodigoEstatus stored CodigoEstatus_Specified;
    property Estado:             string  Index (IS_OPTN or IS_NLBL) read FEstado write SetEstado stored Estado_Specified;
    property EstatusCancelacion: string  Index (IS_OPTN or IS_NLBL) read FEstatusCancelacion write SetEstatusCancelacion stored EstatusCancelacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : AcuseSatEstatus, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSatEstatus2 = class(TRemotable)
  private
    Ferror: string;
    Ferror_Specified: boolean;
    Fsat: AcuseSATConsulta2;
    Fsat_Specified: boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
    procedure Setsat(Index: Integer; const AAcuseSATConsulta2: AcuseSATConsulta2);
    function  sat_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property error: string             Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property sat:   AcuseSATConsulta2  Index (IS_OPTN or IS_NLBL) read Fsat write Setsat stored sat_Specified;
  end;



  // ************************************************************************ //
  // XML       : AcceptRejectResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcceptRejectResult2 = class(TRemotable)
  private
    Frechazo: RechazaArray;
    Frechazo_Specified: boolean;
    Faceptacion: AcceptaArray;
    Faceptacion_Specified: boolean;
    Ferror: string;
    Ferror_Specified: boolean;
    procedure Setrechazo(Index: Integer; const ARechazaArray: RechazaArray);
    function  rechazo_Specified(Index: Integer): boolean;
    procedure Setaceptacion(Index: Integer; const AAcceptaArray: AcceptaArray);
    function  aceptacion_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property rechazo:    RechazaArray  Index (IS_OPTN or IS_NLBL) read Frechazo write Setrechazo stored rechazo_Specified;
    property aceptacion: AcceptaArray  Index (IS_OPTN or IS_NLBL) read Faceptacion write Setaceptacion stored aceptacion_Specified;
    property error:      string        Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
  end;



  // ************************************************************************ //
  // XML       : QueryPendingResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  QueryPendingResult2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fxml: string;
    Fxml_Specified: boolean;
    Fuuid: string;
    Fuuid_Specified: boolean;
    Fuuid_status: string;
    Fuuid_status_Specified: boolean;
    Fnext_attempt: string;
    Fnext_attempt_Specified: boolean;
    Fattempts: string;
    Fattempts_Specified: boolean;
    Ferror: string;
    Ferror_Specified: boolean;
    Fdate: string;
    Fdate_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setxml(Index: Integer; const Astring: string);
    function  xml_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setuuid_status(Index: Integer; const Astring: string);
    function  uuid_status_Specified(Index: Integer): boolean;
    procedure Setnext_attempt(Index: Integer; const Astring: string);
    function  next_attempt_Specified(Index: Integer): boolean;
    procedure Setattempts(Index: Integer; const Astring: string);
    function  attempts_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
    procedure Setdate(Index: Integer; const Astring: string);
    function  date_Specified(Index: Integer): boolean;
  published
    property status:       string  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property xml:          string  Index (IS_OPTN or IS_NLBL) read Fxml write Setxml stored xml_Specified;
    property uuid:         string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property uuid_status:  string  Index (IS_OPTN or IS_NLBL) read Fuuid_status write Setuuid_status stored uuid_status_Specified;
    property next_attempt: string  Index (IS_OPTN or IS_NLBL) read Fnext_attempt write Setnext_attempt stored next_attempt_Specified;
    property attempts:     string  Index (IS_OPTN or IS_NLBL) read Fattempts write Setattempts stored attempts_Specified;
    property error:        string  Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property date:         string  Index (IS_OPTN or IS_NLBL) read Fdate write Setdate stored date_Specified;
  end;



  // ************************************************************************ //
  // XML       : Rechaza, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Rechaza2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fuuid: string;
    Fuuid_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
  published
    property status: string  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property uuid:   string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
  end;



  // ************************************************************************ //
  // XML       : Accepta, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Accepta2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fuuid: string;
    Fuuid_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
  published
    property status: string  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property uuid:   string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
  end;



  // ************************************************************************ //
  // XML       : UUID_AR, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID_AR2 = class(TRemotable)
  private
    Fuuid: string;
    Fuuid_Specified: boolean;
    Frespuesta: string;
    Frespuesta_Specified: boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setrespuesta(Index: Integer; const Astring: string);
    function  respuesta_Specified(Index: Integer): boolean;
  published
    property uuid:      string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property respuesta: string  Index (IS_OPTN or IS_NLBL) read Frespuesta write Setrespuesta stored respuesta_Specified;
  end;



  // ************************************************************************ //
  // XML       : FinkOKRespuestaCancelacion, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  FinkOKRespuestaCancelacion2 = class(TRemotable)
  private
    FFolios: FolioArray;
    FFolios_Specified: boolean;
    FAcuse: string;
    FAcuse_Specified: boolean;
    FFecha: string;
    FFecha_Specified: boolean;
    FRfcEmisor: string;
    FRfcEmisor_Specified: boolean;
    FCodEstatus: string;
    FCodEstatus_Specified: boolean;
    procedure SetFolios(Index: Integer; const AFolioArray: FolioArray);
    function  Folios_Specified(Index: Integer): boolean;
    procedure SetAcuse(Index: Integer; const Astring: string);
    function  Acuse_Specified(Index: Integer): boolean;
    procedure SetFecha(Index: Integer; const Astring: string);
    function  Fecha_Specified(Index: Integer): boolean;
    procedure SetRfcEmisor(Index: Integer; const Astring: string);
    function  RfcEmisor_Specified(Index: Integer): boolean;
    procedure SetCodEstatus(Index: Integer; const Astring: string);
    function  CodEstatus_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Folios:     FolioArray  Index (IS_OPTN or IS_NLBL) read FFolios write SetFolios stored Folios_Specified;
    property Acuse:      string      Index (IS_OPTN or IS_NLBL) read FAcuse write SetAcuse stored Acuse_Specified;
    property Fecha:      string      Index (IS_OPTN or IS_NLBL) read FFecha write SetFecha stored Fecha_Specified;
    property RfcEmisor:  string      Index (IS_OPTN or IS_NLBL) read FRfcEmisor write SetRfcEmisor stored RfcEmisor_Specified;
    property CodEstatus: string      Index (IS_OPTN or IS_NLBL) read FCodEstatus write SetCodEstatus stored CodEstatus_Specified;
  end;



  // ************************************************************************ //
  // XML       : UUIDS, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS2 = class(TRemotable)
  private
    Fuuids: stringArray;
    Fuuids_Specified: boolean;
    procedure Setuuids(Index: Integer; const AstringArray: stringArray);
    function  uuids_Specified(Index: Integer): boolean;
  published
    property uuids: stringArray  Index (IS_OPTN or IS_NLBL) read Fuuids write Setuuids stored uuids_Specified;
  end;

  stringArray2 = array of string;               { "http://facturacion.finkok.com/cancel"[GblCplx] }


  // ************************************************************************ //
  // XML       : CancelPendingResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  CancelPendingResult2 = class(TRemotable)
  private
    Fuuids: stringArray2;
    Fuuids_Specified: boolean;
    Ferror: string;
    Ferror_Specified: boolean;
    procedure Setuuids(Index: Integer; const AstringArray2: stringArray2);
    function  uuids_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
  published
    property uuids: stringArray2  Index (IS_OPTN or IS_NLBL) read Fuuids write Setuuids stored uuids_Specified;
    property error: string        Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
  end;



  // ************************************************************************ //
  // XML       : Folio, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Folio2 = class(TRemotable)
  private
    FUUID: string;
    FUUID_Specified: boolean;
    FEstatusUUID: string;
    FEstatusUUID_Specified: boolean;
    FEstatusCancelacion: string;
    FEstatusCancelacion_Specified: boolean;
    procedure SetUUID(Index: Integer; const Astring: string);
    function  UUID_Specified(Index: Integer): boolean;
    procedure SetEstatusUUID(Index: Integer; const Astring: string);
    function  EstatusUUID_Specified(Index: Integer): boolean;
    procedure SetEstatusCancelacion(Index: Integer; const Astring: string);
    function  EstatusCancelacion_Specified(Index: Integer): boolean;
  published
    property UUID:               string  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
    property EstatusUUID:        string  Index (IS_OPTN or IS_NLBL) read FEstatusUUID write SetEstatusUUID stored EstatusUUID_Specified;
    property EstatusCancelacion: string  Index (IS_OPTN or IS_NLBL) read FEstatusCancelacion write SetEstatusCancelacion stored EstatusCancelacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : ReceiptResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReceiptResult2 = class(TRemotable)
  private
    Fuuid: string;
    Fuuid_Specified: boolean;
    Fsuccess: Boolean;
    Fsuccess_Specified: boolean;
    Freceipt: string;
    Freceipt_Specified: boolean;
    Ftaxpayer_id: string;
    Ftaxpayer_id_Specified: boolean;
    Ferror: string;
    Ferror_Specified: boolean;
    Fdate: string;
    Fdate_Specified: boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setsuccess(Index: Integer; const ABoolean: Boolean);
    function  success_Specified(Index: Integer): boolean;
    procedure Setreceipt(Index: Integer; const Astring: string);
    function  receipt_Specified(Index: Integer): boolean;
    procedure Settaxpayer_id(Index: Integer; const Astring: string);
    function  taxpayer_id_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
    procedure Setdate(Index: Integer; const Astring: string);
    function  date_Specified(Index: Integer): boolean;
  published
    property uuid:        string   Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property success:     Boolean  Index (IS_OPTN or IS_NLBL) read Fsuccess write Setsuccess stored success_Specified;
    property receipt:     string   Index (IS_OPTN or IS_NLBL) read Freceipt write Setreceipt stored receipt_Specified;
    property taxpayer_id: string   Index (IS_OPTN or IS_NLBL) read Ftaxpayer_id write Settaxpayer_id stored taxpayer_id_Specified;
    property error:       string   Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property date:        string   Index (IS_OPTN or IS_NLBL) read Fdate write Setdate stored date_Specified;
  end;



  // ************************************************************************ //
  // XML       : AcuseSATConsulta, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSATConsulta = class(AcuseSATConsulta2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUIDS_AR, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS_AR = class(UUIDS_AR2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : QueryPendingResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  QueryPendingResult = class(QueryPendingResult2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUID_AR, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID_AR = class(UUID_AR2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : CancelPendingResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  CancelPendingResult = class(CancelPendingResult2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AcuseSatEstatus, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSatEstatus = class(AcuseSatEstatus2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : FinkOKRespuestaCancelacion, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  FinkOKRespuestaCancelacion = class(FinkOKRespuestaCancelacion2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Folio, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Folio = class(Folio2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUIDS, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS = class(UUIDS2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ReceiptResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReceiptResult = class(ReceiptResult2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Hijo, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Hijo2 = class(TRemotable)
  private
    Fuuid: string;
    Fuuid_Specified: boolean;
    Femisor: string;
    Femisor_Specified: boolean;
    Freceptor: string;
    Freceptor_Specified: boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setemisor(Index: Integer; const Astring: string);
    function  emisor_Specified(Index: Integer): boolean;
    procedure Setreceptor(Index: Integer; const Astring: string);
    function  receptor_Specified(Index: Integer): boolean;
  published
    property uuid:     string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property emisor:   string  Index (IS_OPTN or IS_NLBL) read Femisor write Setemisor stored emisor_Specified;
    property receptor: string  Index (IS_OPTN or IS_NLBL) read Freceptor write Setreceptor stored receptor_Specified;
  end;



  // ************************************************************************ //
  // XML       : Padre, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Padre2 = class(TRemotable)
  private
    Fuuid: string;
    Fuuid_Specified: boolean;
    Femisor: string;
    Femisor_Specified: boolean;
    Freceptor: string;
    Freceptor_Specified: boolean;
    procedure Setuuid(Index: Integer; const Astring: string);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setemisor(Index: Integer; const Astring: string);
    function  emisor_Specified(Index: Integer): boolean;
    procedure Setreceptor(Index: Integer; const Astring: string);
    function  receptor_Specified(Index: Integer): boolean;
  published
    property uuid:     string  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property emisor:   string  Index (IS_OPTN or IS_NLBL) read Femisor write Setemisor stored emisor_Specified;
    property receptor: string  Index (IS_OPTN or IS_NLBL) read Freceptor write Setreceptor stored receptor_Specified;
  end;

  HijoArray  = array of Hijo2;                  { "apps.services.soap.core.views"[GblCplx] }
  PadreArray = array of Padre2;                 { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : RelatedResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  RelatedResult2 = class(TRemotable)
  private
    FPadres: PadreArray;
    FPadres_Specified: boolean;
    Ferror: string;
    Ferror_Specified: boolean;
    FHijos: HijoArray;
    FHijos_Specified: boolean;
    procedure SetPadres(Index: Integer; const APadreArray: PadreArray);
    function  Padres_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Astring: string);
    function  error_Specified(Index: Integer): boolean;
    procedure SetHijos(Index: Integer; const AHijoArray: HijoArray);
    function  Hijos_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Padres: PadreArray  Index (IS_OPTN or IS_NLBL) read FPadres write SetPadres stored Padres_Specified;
    property error:  string      Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property Hijos:  HijoArray   Index (IS_OPTN or IS_NLBL) read FHijos write SetHijos stored Hijos_Specified;
  end;



  // ************************************************************************ //
  // XML       : Padre, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Padre = class(Padre2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Accepta, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Accepta = class(Accepta2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AcceptRejectResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcceptRejectResult = class(AcceptRejectResult2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Rechaza, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Rechaza = class(Rechaza2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Hijo, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Hijo = class(Hijo2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RelatedResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  RelatedResult = class(RelatedResult2)
  private
  published
  end;


  // ************************************************************************ //
  // Name      : Application
  // Namespace : http://facturacion.finkok.com/cancel
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : Application
  // service   : CancelSOAP
  // port      : Application
  // URL       : https://demo-facturacion.finkok.com/servicios/soap/cancel
  // ************************************************************************ //
  IFinkOkServicioCancelacion = interface(IInvokable)
  ['{A50B2847-80CB-1437-9E24-A9C18DE43316}']
    function  cancel_signature(const xml: TByteDynArray; const username: string; const password: string; const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  get_out_pending(const username: string; const password: string; const rtaxpayer_id: string): CancelPendingResult2; stdcall;
    function  get_pending(const username: string; const password: string; const rtaxpayer_id: string): CancelPendingResult2; stdcall;
    function  get_sat_status(const username: string; const password: string; const taxpayer_id: string; const rtaxpayer_id: string; const uuid: string; const total: string
                             ): AcuseSatEstatus2; stdcall;
    function  get_related(const username: string; const password: string; const rtaxpayer_id: string; const uuid: string; const cer: TByteDynArray; const key: TByteDynArray
                          ): RelatedResult2; stdcall;
    function  query_pending_cancellation(const username: string; const password: string; const uuid: string): QueryPendingResult2; stdcall;
    function  sign_cancel(const UUIDS: UUIDS2; const username: string; const password: string; const taxpayer_id: string; const serial: string; const store_pending: Boolean
                          ): FinkOKRespuestaCancelacion2; stdcall;
    function  get_receipt(const username: string; const password: string; const taxpayer_id: string; const uuid: string; const type_: string): ReceiptResult2; stdcall;
    function  cancel(const UUIDS: UUIDS2; const username: string; const password: string; const taxpayer_id: string; const cer: TByteDynArray; const key: TByteDynArray;
                     const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  get_out_related(const username: string; const password: string; const rtaxpayer_id: string; const uuid: string; const cer: TByteDynArray; const key: TByteDynArray
                              ): RelatedResult2; stdcall;
    function  out_cancel(const xml: TByteDynArray; const username: string; const password: string; const taxpayer_id: string; const cer: TByteDynArray; const key: TByteDynArray;
                         const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  out_accept_reject(const UUID_AR: UUID_AR2; const username: string; const password: string; const rtaxpayer_id: string; const cer: TByteDynArray; const key: TByteDynArray
                                ): AcceptRejectResult2; stdcall;
    function  accept_reject(const UUIDS_AR: UUIDS_AR2; const username: string; const password: string; const rtaxpayer_id: string; const cer: TByteDynArray; const key: TByteDynArray
                            ): AcceptRejectResult2; stdcall;
  end;

function GetIFinkOkServicioCancelacion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkServicioCancelacion;


implementation

function GetIFinkOkServicioCancelacion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkServicioCancelacion;
const
  defWSDL = 'D:\Descargas\cancel.wsdl.xml';
  defURL  = 'https://demo-facturacion.finkok.com/servicios/soap/cancel';
  defSvc  = 'CancelSOAP';
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
    Result := (RIO as IFinkOkServicioCancelacion);
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


destructor UUIDS_AR2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fuuids_ar)-1 do
    FreeAndNil(Fuuids_ar[I]);
  System.SetLength(Fuuids_ar, 0);
  inherited Destroy;
end;

procedure UUIDS_AR2.Setuuids_ar(Index: Integer; const AUUID_ARArray: UUID_ARArray);
begin
  Fuuids_ar := AUUID_ARArray;
  Fuuids_ar_Specified := True;
end;

function UUIDS_AR2.uuids_ar_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_ar_Specified;
end;

procedure AcuseSATConsulta2.SetEsCancelable(Index: Integer; const Astring: string);
begin
  FEsCancelable := Astring;
  FEsCancelable_Specified := True;
end;

function AcuseSATConsulta2.EsCancelable_Specified(Index: Integer): boolean;
begin
  Result := FEsCancelable_Specified;
end;

procedure AcuseSATConsulta2.SetCodigoEstatus(Index: Integer; const Astring: string);
begin
  FCodigoEstatus := Astring;
  FCodigoEstatus_Specified := True;
end;

function AcuseSATConsulta2.CodigoEstatus_Specified(Index: Integer): boolean;
begin
  Result := FCodigoEstatus_Specified;
end;

procedure AcuseSATConsulta2.SetEstado(Index: Integer; const Astring: string);
begin
  FEstado := Astring;
  FEstado_Specified := True;
end;

function AcuseSATConsulta2.Estado_Specified(Index: Integer): boolean;
begin
  Result := FEstado_Specified;
end;

procedure AcuseSATConsulta2.SetEstatusCancelacion(Index: Integer; const Astring: string);
begin
  FEstatusCancelacion := Astring;
  FEstatusCancelacion_Specified := True;
end;

function AcuseSATConsulta2.EstatusCancelacion_Specified(Index: Integer): boolean;
begin
  Result := FEstatusCancelacion_Specified;
end;

destructor AcuseSatEstatus2.Destroy;
begin
  FreeAndNil(Fsat);
  inherited Destroy;
end;

procedure AcuseSatEstatus2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function AcuseSatEstatus2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure AcuseSatEstatus2.Setsat(Index: Integer; const AAcuseSATConsulta2: AcuseSATConsulta2);
begin
  Fsat := AAcuseSATConsulta2;
  Fsat_Specified := True;
end;

function AcuseSatEstatus2.sat_Specified(Index: Integer): boolean;
begin
  Result := Fsat_Specified;
end;

destructor AcceptRejectResult2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Frechazo)-1 do
    FreeAndNil(Frechazo[I]);
  System.SetLength(Frechazo, 0);
  for I := 0 to System.Length(Faceptacion)-1 do
    FreeAndNil(Faceptacion[I]);
  System.SetLength(Faceptacion, 0);
  inherited Destroy;
end;

procedure AcceptRejectResult2.Setrechazo(Index: Integer; const ARechazaArray: RechazaArray);
begin
  Frechazo := ARechazaArray;
  Frechazo_Specified := True;
end;

function AcceptRejectResult2.rechazo_Specified(Index: Integer): boolean;
begin
  Result := Frechazo_Specified;
end;

procedure AcceptRejectResult2.Setaceptacion(Index: Integer; const AAcceptaArray: AcceptaArray);
begin
  Faceptacion := AAcceptaArray;
  Faceptacion_Specified := True;
end;

function AcceptRejectResult2.aceptacion_Specified(Index: Integer): boolean;
begin
  Result := Faceptacion_Specified;
end;

procedure AcceptRejectResult2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function AcceptRejectResult2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure QueryPendingResult2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function QueryPendingResult2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure QueryPendingResult2.Setxml(Index: Integer; const Astring: string);
begin
  Fxml := Astring;
  Fxml_Specified := True;
end;

function QueryPendingResult2.xml_Specified(Index: Integer): boolean;
begin
  Result := Fxml_Specified;
end;

procedure QueryPendingResult2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function QueryPendingResult2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure QueryPendingResult2.Setuuid_status(Index: Integer; const Astring: string);
begin
  Fuuid_status := Astring;
  Fuuid_status_Specified := True;
end;

function QueryPendingResult2.uuid_status_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_status_Specified;
end;

procedure QueryPendingResult2.Setnext_attempt(Index: Integer; const Astring: string);
begin
  Fnext_attempt := Astring;
  Fnext_attempt_Specified := True;
end;

function QueryPendingResult2.next_attempt_Specified(Index: Integer): boolean;
begin
  Result := Fnext_attempt_Specified;
end;

procedure QueryPendingResult2.Setattempts(Index: Integer; const Astring: string);
begin
  Fattempts := Astring;
  Fattempts_Specified := True;
end;

function QueryPendingResult2.attempts_Specified(Index: Integer): boolean;
begin
  Result := Fattempts_Specified;
end;

procedure QueryPendingResult2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function QueryPendingResult2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure QueryPendingResult2.Setdate(Index: Integer; const Astring: string);
begin
  Fdate := Astring;
  Fdate_Specified := True;
end;

function QueryPendingResult2.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

procedure Rechaza2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function Rechaza2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure Rechaza2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function Rechaza2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Accepta2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function Accepta2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure Accepta2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function Accepta2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure UUID_AR2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function UUID_AR2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure UUID_AR2.Setrespuesta(Index: Integer; const Astring: string);
begin
  Frespuesta := Astring;
  Frespuesta_Specified := True;
end;

function UUID_AR2.respuesta_Specified(Index: Integer): boolean;
begin
  Result := Frespuesta_Specified;
end;

destructor FinkOKRespuestaCancelacion2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FFolios)-1 do
    FreeAndNil(FFolios[I]);
  System.SetLength(FFolios, 0);
  inherited Destroy;
end;

procedure FinkOKRespuestaCancelacion2.SetFolios(Index: Integer; const AFolioArray: FolioArray);
begin
  FFolios := AFolioArray;
  FFolios_Specified := True;
end;

function FinkOKRespuestaCancelacion2.Folios_Specified(Index: Integer): boolean;
begin
  Result := FFolios_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetAcuse(Index: Integer; const Astring: string);
begin
  FAcuse := Astring;
  FAcuse_Specified := True;
end;

function FinkOKRespuestaCancelacion2.Acuse_Specified(Index: Integer): boolean;
begin
  Result := FAcuse_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetFecha(Index: Integer; const Astring: string);
begin
  FFecha := Astring;
  FFecha_Specified := True;
end;

function FinkOKRespuestaCancelacion2.Fecha_Specified(Index: Integer): boolean;
begin
  Result := FFecha_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetRfcEmisor(Index: Integer; const Astring: string);
begin
  FRfcEmisor := Astring;
  FRfcEmisor_Specified := True;
end;

function FinkOKRespuestaCancelacion2.RfcEmisor_Specified(Index: Integer): boolean;
begin
  Result := FRfcEmisor_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetCodEstatus(Index: Integer; const Astring: string);
begin
  FCodEstatus := Astring;
  FCodEstatus_Specified := True;
end;

function FinkOKRespuestaCancelacion2.CodEstatus_Specified(Index: Integer): boolean;
begin
  Result := FCodEstatus_Specified;
end;

procedure UUIDS2.Setuuids(Index: Integer; const AstringArray: stringArray);
begin
  Fuuids := AstringArray;
  Fuuids_Specified := True;
end;

function UUIDS2.uuids_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_Specified;
end;

procedure CancelPendingResult2.Setuuids(Index: Integer; const AstringArray2: stringArray2);
begin
  Fuuids := AstringArray2;
  Fuuids_Specified := True;
end;

function CancelPendingResult2.uuids_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_Specified;
end;

procedure CancelPendingResult2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function CancelPendingResult2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure Folio2.SetUUID(Index: Integer; const Astring: string);
begin
  FUUID := Astring;
  FUUID_Specified := True;
end;

function Folio2.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

procedure Folio2.SetEstatusUUID(Index: Integer; const Astring: string);
begin
  FEstatusUUID := Astring;
  FEstatusUUID_Specified := True;
end;

function Folio2.EstatusUUID_Specified(Index: Integer): boolean;
begin
  Result := FEstatusUUID_Specified;
end;

procedure Folio2.SetEstatusCancelacion(Index: Integer; const Astring: string);
begin
  FEstatusCancelacion := Astring;
  FEstatusCancelacion_Specified := True;
end;

function Folio2.EstatusCancelacion_Specified(Index: Integer): boolean;
begin
  Result := FEstatusCancelacion_Specified;
end;

procedure ReceiptResult2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function ReceiptResult2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure ReceiptResult2.Setsuccess(Index: Integer; const ABoolean: Boolean);
begin
  Fsuccess := ABoolean;
  Fsuccess_Specified := True;
end;

function ReceiptResult2.success_Specified(Index: Integer): boolean;
begin
  Result := Fsuccess_Specified;
end;

procedure ReceiptResult2.Setreceipt(Index: Integer; const Astring: string);
begin
  Freceipt := Astring;
  Freceipt_Specified := True;
end;

function ReceiptResult2.receipt_Specified(Index: Integer): boolean;
begin
  Result := Freceipt_Specified;
end;

procedure ReceiptResult2.Settaxpayer_id(Index: Integer; const Astring: string);
begin
  Ftaxpayer_id := Astring;
  Ftaxpayer_id_Specified := True;
end;

function ReceiptResult2.taxpayer_id_Specified(Index: Integer): boolean;
begin
  Result := Ftaxpayer_id_Specified;
end;

procedure ReceiptResult2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function ReceiptResult2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure ReceiptResult2.Setdate(Index: Integer; const Astring: string);
begin
  Fdate := Astring;
  Fdate_Specified := True;
end;

function ReceiptResult2.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

procedure Hijo2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function Hijo2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Hijo2.Setemisor(Index: Integer; const Astring: string);
begin
  Femisor := Astring;
  Femisor_Specified := True;
end;

function Hijo2.emisor_Specified(Index: Integer): boolean;
begin
  Result := Femisor_Specified;
end;

procedure Hijo2.Setreceptor(Index: Integer; const Astring: string);
begin
  Freceptor := Astring;
  Freceptor_Specified := True;
end;

function Hijo2.receptor_Specified(Index: Integer): boolean;
begin
  Result := Freceptor_Specified;
end;

procedure Padre2.Setuuid(Index: Integer; const Astring: string);
begin
  Fuuid := Astring;
  Fuuid_Specified := True;
end;

function Padre2.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Padre2.Setemisor(Index: Integer; const Astring: string);
begin
  Femisor := Astring;
  Femisor_Specified := True;
end;

function Padre2.emisor_Specified(Index: Integer): boolean;
begin
  Result := Femisor_Specified;
end;

procedure Padre2.Setreceptor(Index: Integer; const Astring: string);
begin
  Freceptor := Astring;
  Freceptor_Specified := True;
end;

function Padre2.receptor_Specified(Index: Integer): boolean;
begin
  Result := Freceptor_Specified;
end;

destructor RelatedResult2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FPadres)-1 do
    FreeAndNil(FPadres[I]);
  System.SetLength(FPadres, 0);
  for I := 0 to System.Length(FHijos)-1 do
    FreeAndNil(FHijos[I]);
  System.SetLength(FHijos, 0);
  inherited Destroy;
end;

procedure RelatedResult2.SetPadres(Index: Integer; const APadreArray: PadreArray);
begin
  FPadres := APadreArray;
  FPadres_Specified := True;
end;

function RelatedResult2.Padres_Specified(Index: Integer): boolean;
begin
  Result := FPadres_Specified;
end;

procedure RelatedResult2.Seterror(Index: Integer; const Astring: string);
begin
  Ferror := Astring;
  Ferror_Specified := True;
end;

function RelatedResult2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure RelatedResult2.SetHijos(Index: Integer; const AHijoArray: HijoArray);
begin
  FHijos := AHijoArray;
  FHijos_Specified := True;
end;

function RelatedResult2.Hijos_Specified(Index: Integer): boolean;
begin
  Result := FHijos_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkServicioCancelacion), 'http://facturacion.finkok.com/cancel', 'UTF-8', '', 'Application');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkServicioCancelacion), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkServicioCancelacion), ioDocument);
  InvRegistry.RegisterExternalParamName(TypeInfo(IFinkOkServicioCancelacion), 'get_receipt', 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stringArray), 'http://facturacion.finkok.com/cancellation', 'stringArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FolioArray), 'apps.services.soap.core.views', 'FolioArray');
  RemClassRegistry.RegisterXSClass(FinkOKRespuestaCancelacion, 'apps.services.soap.core.views', 'CancelaCFDResult');
  RemClassRegistry.RegisterXSClass(AcuseSatEstatus, 'apps.services.soap.core.views', 'AcuseSatEstatus');
  RemClassRegistry.RegisterXSClass(AcuseSATConsulta, 'apps.services.soap.core.views', 'AcuseSATConsulta');
  RemClassRegistry.RegisterXSClass(Folio, 'apps.services.soap.core.views', 'Folio');
  RemClassRegistry.RegisterXSClass(ReceiptResult, 'apps.services.soap.core.views', 'ReceiptResult');
  RemClassRegistry.RegisterXSClass(UUIDS, 'apps.services.soap.core.views', 'UUIDS');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stringArray2), 'http://facturacion.finkok.com/cancel', 'stringArray2', 'stringArray');
  RemClassRegistry.RegisterXSClass(CancelPendingResult, 'apps.services.soap.core.views', 'CancelPendingResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(UUID_ARArray), 'apps.services.soap.core.views', 'UUID_ARArray');
  RemClassRegistry.RegisterXSClass(UUIDS_AR, 'apps.services.soap.core.views', 'UUIDS_AR');
  RemClassRegistry.RegisterXSClass(UUID_AR, 'apps.services.soap.core.views', 'UUID_AR');
  RemClassRegistry.RegisterXSClass(QueryPendingResult, 'apps.services.soap.core.views', 'QueryPendingResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(RechazaArray), 'apps.services.soap.core.views', 'RechazaArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(AcceptaArray), 'apps.services.soap.core.views', 'AcceptaArray');
  RemClassRegistry.RegisterXSClass(AcceptRejectResult, 'apps.services.soap.core.views', 'AcceptRejectResult');
  RemClassRegistry.RegisterXSClass(Accepta, 'apps.services.soap.core.views', 'Accepta');
  RemClassRegistry.RegisterXSClass(Rechaza, 'apps.services.soap.core.views', 'Rechaza');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PadreArray), 'apps.services.soap.core.views', 'PadreArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(HijoArray), 'apps.services.soap.core.views', 'HijoArray');
  RemClassRegistry.RegisterXSClass(RelatedResult, 'apps.services.soap.core.views', 'RelatedResult');
  RemClassRegistry.RegisterXSClass(Hijo, 'apps.services.soap.core.views', 'Hijo');
  RemClassRegistry.RegisterXSClass(Padre, 'apps.services.soap.core.views', 'Padre');
  RemClassRegistry.RegisterXSClass(Padre2, 'apps.services.soap.core.views', 'Padre2', 'Padre');
  RemClassRegistry.RegisterXSClass(Hijo2, 'apps.services.soap.core.views', 'Hijo2', 'Hijo');
  RemClassRegistry.RegisterXSClass(RelatedResult2, 'apps.services.soap.core.views', 'RelatedResult2', 'RelatedResult');
  RemClassRegistry.RegisterXSClass(Rechaza2, 'apps.services.soap.core.views', 'Rechaza2', 'Rechaza');
  RemClassRegistry.RegisterXSClass(Accepta2, 'apps.services.soap.core.views', 'Accepta2', 'Accepta');
  RemClassRegistry.RegisterXSClass(AcceptRejectResult2, 'apps.services.soap.core.views', 'AcceptRejectResult2', 'AcceptRejectResult');
  RemClassRegistry.RegisterXSClass(QueryPendingResult2, 'apps.services.soap.core.views', 'QueryPendingResult2', 'QueryPendingResult');
  RemClassRegistry.RegisterXSClass(UUID_AR2, 'apps.services.soap.core.views', 'UUID_AR2', 'UUID_AR');
  RemClassRegistry.RegisterXSClass(UUIDS_AR2, 'apps.services.soap.core.views', 'UUIDS_AR2', 'UUIDS_AR');
  RemClassRegistry.RegisterXSClass(AcuseSATConsulta2, 'apps.services.soap.core.views', 'AcuseSATConsulta2', 'AcuseSATConsulta');
  RemClassRegistry.RegisterXSClass(CancelPendingResult2, 'apps.services.soap.core.views', 'CancelPendingResult2', 'CancelPendingResult');
  RemClassRegistry.RegisterXSClass(UUIDS2, 'apps.services.soap.core.views', 'UUIDS2', 'UUIDS');
  RemClassRegistry.RegisterXSClass(ReceiptResult2, 'apps.services.soap.core.views', 'ReceiptResult2', 'ReceiptResult');
  RemClassRegistry.RegisterXSClass(Folio2, 'apps.services.soap.core.views', 'Folio2', 'Folio');
  RemClassRegistry.RegisterXSClass(AcuseSatEstatus2, 'apps.services.soap.core.views', 'AcuseSatEstatus2', 'AcuseSatEstatus');
  RemClassRegistry.RegisterXSClass(FinkOKRespuestaCancelacion2, 'apps.services.soap.core.views', 'CancelaCFDResult2', 'CancelaCFDResult');

end.
