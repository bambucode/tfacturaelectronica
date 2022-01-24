{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{        Soporte del pac FinkOK Tecsis.Mx               }
{                                                       }
{*******************************************************}

unit FinkOkWsCancelacion;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_ATTR = $0010;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  CancelPendingResult  = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcuseSatEstatus      = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcuseSATConsulta     = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUID                 = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUIDS_AR             = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUID_AR              = class;                 { "apps.services.soap.core.views"[GblCplx] }
  FinkOKRespuestaCancelacion2     = class;                 { "apps.services.soap.core.views"[GblCplx] }
  UUIDS                = class;                 { "apps.services.soap.core.views"[GblCplx] }
  ReceiptResult        = class;                 { "apps.services.soap.core.views"[GblCplx] }
  QueryPendingResult   = class;                 { "apps.services.soap.core.views"[GblCplx] }
  AcceptRejectResult   = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Acepta               = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Rechaza              = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Folio                = class;                 { "apps.services.soap.core.views"[GblCplx] }
  RelatedResult        = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Hijo                 = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Padre                = class;                 { "apps.services.soap.core.views"[GblCplx] }
  Padre2               = class;                 { "apps.services.soap.core.views"[GblElm] }
  Hijo2                = class;                 { "apps.services.soap.core.views"[GblElm] }
  RelatedResult2       = class;                 { "apps.services.soap.core.views"[GblElm] }
  Folio2               = class;                 { "apps.services.soap.core.views"[GblElm] }
  Rechaza2             = class;                 { "apps.services.soap.core.views"[GblElm] }
  Acepta2              = class;                 { "apps.services.soap.core.views"[GblElm] }
  AcceptRejectResult2  = class;                 { "apps.services.soap.core.views"[GblElm] }
  QueryPendingResult2  = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUID2                = class;                 { "apps.services.soap.core.views"[GblElm] }
  ReceiptResult2       = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUIDS2               = class;                 { "apps.services.soap.core.views"[GblElm] }
  FinkOKRespuestaCancelacion22    = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUID_AR2             = class;                 { "apps.services.soap.core.views"[GblElm] }
  UUIDS_AR2            = class;                 { "apps.services.soap.core.views"[GblElm] }
  AcuseSATConsulta2    = class;                 { "apps.services.soap.core.views"[GblElm] }
  AcuseSatEstatus2     = class;                 { "apps.services.soap.core.views"[GblElm] }
  CancelPendingResult2 = class;                 { "apps.services.soap.core.views"[GblElm] }

  stringArray = array of WideString;            { "http://facturacion.finkok.com/cancellation"[GblCplx] }
  stringArray2 = array of WideString;           { "http://facturacion.finkok.com/cancel"[GblCplx] }


  // ************************************************************************ //
  // XML       : CancelPendingResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  CancelPendingResult = class(TRemotable)
  private
    Fuuids: stringArray2;
    Fuuids_Specified: boolean;
    Ferror: WideString;
    Ferror_Specified: boolean;
    procedure Setuuids(Index: Integer; const AstringArray2: stringArray2);
    function  uuids_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
  published
    property uuids: stringArray2  Index (IS_OPTN or IS_NLBL) read Fuuids write Setuuids stored uuids_Specified;
    property error: WideString    Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
  end;



  // ************************************************************************ //
  // XML       : AcuseSatEstatus, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSatEstatus = class(TRemotable)
  private
    Ferror: WideString;
    Ferror_Specified: boolean;
    Fsat: AcuseSATConsulta;
    Fsat_Specified: boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
    procedure Setsat(Index: Integer; const AAcuseSATConsulta: AcuseSATConsulta);
    function  sat_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property error: WideString        Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property sat:   AcuseSATConsulta  Index (IS_OPTN or IS_NLBL) read Fsat write Setsat stored sat_Specified;
  end;



  // ************************************************************************ //
  // XML       : AcuseSATConsulta, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSATConsulta = class(TRemotable)
  private
    FDetallesValidacionEFOS: WideString;
    FDetallesValidacionEFOS_Specified: boolean;
    FEsCancelable: WideString;
    FEsCancelable_Specified: boolean;
    FValidacionEFOS: WideString;
    FValidacionEFOS_Specified: boolean;
    FCodigoEstatus: WideString;
    FCodigoEstatus_Specified: boolean;
    FEstado: WideString;
    FEstado_Specified: boolean;
    FEstatusCancelacion: WideString;
    FEstatusCancelacion_Specified: boolean;
    procedure SetDetallesValidacionEFOS(Index: Integer; const AWideString: WideString);
    function  DetallesValidacionEFOS_Specified(Index: Integer): boolean;
    procedure SetEsCancelable(Index: Integer; const AWideString: WideString);
    function  EsCancelable_Specified(Index: Integer): boolean;
    procedure SetValidacionEFOS(Index: Integer; const AWideString: WideString);
    function  ValidacionEFOS_Specified(Index: Integer): boolean;
    procedure SetCodigoEstatus(Index: Integer; const AWideString: WideString);
    function  CodigoEstatus_Specified(Index: Integer): boolean;
    procedure SetEstado(Index: Integer; const AWideString: WideString);
    function  Estado_Specified(Index: Integer): boolean;
    procedure SetEstatusCancelacion(Index: Integer; const AWideString: WideString);
    function  EstatusCancelacion_Specified(Index: Integer): boolean;
  published
    property DetallesValidacionEFOS: WideString  Index (IS_OPTN or IS_NLBL) read FDetallesValidacionEFOS write SetDetallesValidacionEFOS stored DetallesValidacionEFOS_Specified;
    property EsCancelable:           WideString  Index (IS_OPTN or IS_NLBL) read FEsCancelable write SetEsCancelable stored EsCancelable_Specified;
    property ValidacionEFOS:         WideString  Index (IS_OPTN or IS_NLBL) read FValidacionEFOS write SetValidacionEFOS stored ValidacionEFOS_Specified;
    property CodigoEstatus:          WideString  Index (IS_OPTN or IS_NLBL) read FCodigoEstatus write SetCodigoEstatus stored CodigoEstatus_Specified;
    property Estado:                 WideString  Index (IS_OPTN or IS_NLBL) read FEstado write SetEstado stored Estado_Specified;
    property EstatusCancelacion:     WideString  Index (IS_OPTN or IS_NLBL) read FEstatusCancelacion write SetEstatusCancelacion stored EstatusCancelacion_Specified;
  end;

  UUIDArray  = array of UUID;                   { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : UUID, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID = class(TRemotable)
  private
    FUUID: WideString;
    FUUID_Specified: boolean;
    FFolioSustitucion: WideString;
    FFolioSustitucion_Specified: boolean;
    FMotivo: WideString;
    FMotivo_Specified: boolean;
    procedure SetUUID(Index: Integer; const AWideString: WideString);
    function  UUID_Specified(Index: Integer): boolean;
    procedure SetFolioSustitucion(Index: Integer; const AWideString: WideString);
    function  FolioSustitucion_Specified(Index: Integer): boolean;
    procedure SetMotivo(Index: Integer; const AWideString: WideString);
    function  Motivo_Specified(Index: Integer): boolean;
  published
    property UUID:             WideString  Index (IS_ATTR or IS_OPTN) read FUUID write SetUUID stored UUID_Specified;
    property FolioSustitucion: WideString  Index (IS_ATTR or IS_OPTN) read FFolioSustitucion write SetFolioSustitucion stored FolioSustitucion_Specified;
    property Motivo:           WideString  Index (IS_ATTR or IS_OPTN) read FMotivo write SetMotivo stored Motivo_Specified;
  end;

  UUID_ARArray = array of UUID_AR;              { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : UUIDS_AR, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS_AR = class(TRemotable)
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



  // ************************************************************************ //
  // XML       : UUID_AR, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID_AR = class(TRemotable)
  private
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    Frespuesta: WideString;
    Frespuesta_Specified: boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setrespuesta(Index: Integer; const AWideString: WideString);
    function  respuesta_Specified(Index: Integer): boolean;
  published
    property uuid:      WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property respuesta: WideString  Index (IS_OPTN or IS_NLBL) read Frespuesta write Setrespuesta stored respuesta_Specified;
  end;

  FolioArray = array of Folio;                  { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : FinkOKRespuestaCancelacion2, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  FinkOKRespuestaCancelacion2 = class(TRemotable)
  private
    FFolios: FolioArray;
    FFolios_Specified: boolean;
    FAcuse: WideString;
    FAcuse_Specified: boolean;
    FFecha: WideString;
    FFecha_Specified: boolean;
    FRfcEmisor: WideString;
    FRfcEmisor_Specified: boolean;
    FCodEstatus: WideString;
    FCodEstatus_Specified: boolean;
    procedure SetFolios(Index: Integer; const AFolioArray: FolioArray);
    function  Folios_Specified(Index: Integer): boolean;
    procedure SetAcuse(Index: Integer; const AWideString: WideString);
    function  Acuse_Specified(Index: Integer): boolean;
    procedure SetFecha(Index: Integer; const AWideString: WideString);
    function  Fecha_Specified(Index: Integer): boolean;
    procedure SetRfcEmisor(Index: Integer; const AWideString: WideString);
    function  RfcEmisor_Specified(Index: Integer): boolean;
    procedure SetCodEstatus(Index: Integer; const AWideString: WideString);
    function  CodEstatus_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Folios:     FolioArray  Index (IS_OPTN or IS_NLBL) read FFolios write SetFolios stored Folios_Specified;
    property Acuse:      WideString  Index (IS_OPTN or IS_NLBL) read FAcuse write SetAcuse stored Acuse_Specified;
    property Fecha:      WideString  Index (IS_OPTN or IS_NLBL) read FFecha write SetFecha stored Fecha_Specified;
    property RfcEmisor:  WideString  Index (IS_OPTN or IS_NLBL) read FRfcEmisor write SetRfcEmisor stored RfcEmisor_Specified;
    property CodEstatus: WideString  Index (IS_OPTN or IS_NLBL) read FCodEstatus write SetCodEstatus stored CodEstatus_Specified;
  end;



  // ************************************************************************ //
  // XML       : UUIDS, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS = class(TRemotable)
  private
    Fuuids: stringArray;
    Fuuids_Specified: boolean;
    procedure Setuuids(Index: Integer; const AstringArray: stringArray);
    function  uuids_Specified(Index: Integer): boolean;
  published
    property uuids: stringArray  Index (IS_OPTN or IS_NLBL) read Fuuids write Setuuids stored uuids_Specified;
  end;



  // ************************************************************************ //
  // XML       : ReceiptResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReceiptResult = class(TRemotable)
  private
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    Fsuccess: Boolean;
    Fsuccess_Specified: boolean;
    Freceipt: WideString;
    Freceipt_Specified: boolean;
    Ftaxpayer_id: WideString;
    Ftaxpayer_id_Specified: boolean;
    Ferror: WideString;
    Ferror_Specified: boolean;
    Fdate: WideString;
    Fdate_Specified: boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setsuccess(Index: Integer; const ABoolean: Boolean);
    function  success_Specified(Index: Integer): boolean;
    procedure Setreceipt(Index: Integer; const AWideString: WideString);
    function  receipt_Specified(Index: Integer): boolean;
    procedure Settaxpayer_id(Index: Integer; const AWideString: WideString);
    function  taxpayer_id_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
    procedure Setdate(Index: Integer; const AWideString: WideString);
    function  date_Specified(Index: Integer): boolean;
  published
    property uuid:        WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property success:     Boolean     Index (IS_OPTN or IS_NLBL) read Fsuccess write Setsuccess stored success_Specified;
    property receipt:     WideString  Index (IS_OPTN or IS_NLBL) read Freceipt write Setreceipt stored receipt_Specified;
    property taxpayer_id: WideString  Index (IS_OPTN or IS_NLBL) read Ftaxpayer_id write Settaxpayer_id stored taxpayer_id_Specified;
    property error:       WideString  Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property date:        WideString  Index (IS_OPTN or IS_NLBL) read Fdate write Setdate stored date_Specified;
  end;



  // ************************************************************************ //
  // XML       : QueryPendingResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  QueryPendingResult = class(TRemotable)
  private
    Fstatus: WideString;
    Fstatus_Specified: boolean;
    Fxml: WideString;
    Fxml_Specified: boolean;
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    Fuuid_status: WideString;
    Fuuid_status_Specified: boolean;
    Fnext_attempt: WideString;
    Fnext_attempt_Specified: boolean;
    Fattempts: WideString;
    Fattempts_Specified: boolean;
    Ferror: WideString;
    Ferror_Specified: boolean;
    Fdate: WideString;
    Fdate_Specified: boolean;
    procedure Setstatus(Index: Integer; const AWideString: WideString);
    function  status_Specified(Index: Integer): boolean;
    procedure Setxml(Index: Integer; const AWideString: WideString);
    function  xml_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setuuid_status(Index: Integer; const AWideString: WideString);
    function  uuid_status_Specified(Index: Integer): boolean;
    procedure Setnext_attempt(Index: Integer; const AWideString: WideString);
    function  next_attempt_Specified(Index: Integer): boolean;
    procedure Setattempts(Index: Integer; const AWideString: WideString);
    function  attempts_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
    procedure Setdate(Index: Integer; const AWideString: WideString);
    function  date_Specified(Index: Integer): boolean;
  published
    property status:       WideString  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property xml:          WideString  Index (IS_OPTN or IS_NLBL) read Fxml write Setxml stored xml_Specified;
    property uuid:         WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property uuid_status:  WideString  Index (IS_OPTN or IS_NLBL) read Fuuid_status write Setuuid_status stored uuid_status_Specified;
    property next_attempt: WideString  Index (IS_OPTN or IS_NLBL) read Fnext_attempt write Setnext_attempt stored next_attempt_Specified;
    property attempts:     WideString  Index (IS_OPTN or IS_NLBL) read Fattempts write Setattempts stored attempts_Specified;
    property error:        WideString  Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property date:         WideString  Index (IS_OPTN or IS_NLBL) read Fdate write Setdate stored date_Specified;
  end;

  RechazaArray = array of Rechaza;              { "apps.services.soap.core.views"[GblCplx] }
  AceptaArray = array of Acepta;                { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : AcceptRejectResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcceptRejectResult = class(TRemotable)
  private
    Frechazo: RechazaArray;
    Frechazo_Specified: boolean;
    Faceptacion: AceptaArray;
    Faceptacion_Specified: boolean;
    Ferror: WideString;
    Ferror_Specified: boolean;
    procedure Setrechazo(Index: Integer; const ARechazaArray: RechazaArray);
    function  rechazo_Specified(Index: Integer): boolean;
    procedure Setaceptacion(Index: Integer; const AAceptaArray: AceptaArray);
    function  aceptacion_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property rechazo:    RechazaArray  Index (IS_OPTN or IS_NLBL) read Frechazo write Setrechazo stored rechazo_Specified;
    property aceptacion: AceptaArray   Index (IS_OPTN or IS_NLBL) read Faceptacion write Setaceptacion stored aceptacion_Specified;
    property error:      WideString    Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
  end;



  // ************************************************************************ //
  // XML       : Acepta, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Acepta = class(TRemotable)
  private
    Fstatus: WideString;
    Fstatus_Specified: boolean;
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    procedure Setstatus(Index: Integer; const AWideString: WideString);
    function  status_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
  published
    property status: WideString  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property uuid:   WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
  end;



  // ************************************************************************ //
  // XML       : Rechaza, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Rechaza = class(TRemotable)
  private
    Fstatus: WideString;
    Fstatus_Specified: boolean;
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    procedure Setstatus(Index: Integer; const AWideString: WideString);
    function  status_Specified(Index: Integer): boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
  published
    property status: WideString  Index (IS_OPTN or IS_NLBL) read Fstatus write Setstatus stored status_Specified;
    property uuid:   WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
  end;



  // ************************************************************************ //
  // XML       : Folio, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Folio = class(TRemotable)
  private
    FUUID: WideString;
    FUUID_Specified: boolean;
    FEstatusUUID: WideString;
    FEstatusUUID_Specified: boolean;
    FEstatusCancelacion: WideString;
    FEstatusCancelacion_Specified: boolean;
    procedure SetUUID(Index: Integer; const AWideString: WideString);
    function  UUID_Specified(Index: Integer): boolean;
    procedure SetEstatusUUID(Index: Integer; const AWideString: WideString);
    function  EstatusUUID_Specified(Index: Integer): boolean;
    procedure SetEstatusCancelacion(Index: Integer; const AWideString: WideString);
    function  EstatusCancelacion_Specified(Index: Integer): boolean;
  published
    property UUID:               WideString  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
    property EstatusUUID:        WideString  Index (IS_OPTN or IS_NLBL) read FEstatusUUID write SetEstatusUUID stored EstatusUUID_Specified;
    property EstatusCancelacion: WideString  Index (IS_OPTN or IS_NLBL) read FEstatusCancelacion write SetEstatusCancelacion stored EstatusCancelacion_Specified;
  end;

  PadreArray = array of Padre;                  { "apps.services.soap.core.views"[GblCplx] }
  HijoArray  = array of Hijo;                   { "apps.services.soap.core.views"[GblCplx] }


  // ************************************************************************ //
  // XML       : RelatedResult, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  RelatedResult = class(TRemotable)
  private
    FPadres: PadreArray;
    FPadres_Specified: boolean;
    Ferror: WideString;
    Ferror_Specified: boolean;
    FHijos: HijoArray;
    FHijos_Specified: boolean;
    procedure SetPadres(Index: Integer; const APadreArray: PadreArray);
    function  Padres_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const AWideString: WideString);
    function  error_Specified(Index: Integer): boolean;
    procedure SetHijos(Index: Integer; const AHijoArray: HijoArray);
    function  Hijos_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Padres: PadreArray  Index (IS_OPTN or IS_NLBL) read FPadres write SetPadres stored Padres_Specified;
    property error:  WideString  Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property Hijos:  HijoArray   Index (IS_OPTN or IS_NLBL) read FHijos write SetHijos stored Hijos_Specified;
  end;



  // ************************************************************************ //
  // XML       : Hijo, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Hijo = class(TRemotable)
  private
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    Femisor: WideString;
    Femisor_Specified: boolean;
    Freceptor: WideString;
    Freceptor_Specified: boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setemisor(Index: Integer; const AWideString: WideString);
    function  emisor_Specified(Index: Integer): boolean;
    procedure Setreceptor(Index: Integer; const AWideString: WideString);
    function  receptor_Specified(Index: Integer): boolean;
  published
    property uuid:     WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property emisor:   WideString  Index (IS_OPTN or IS_NLBL) read Femisor write Setemisor stored emisor_Specified;
    property receptor: WideString  Index (IS_OPTN or IS_NLBL) read Freceptor write Setreceptor stored receptor_Specified;
  end;



  // ************************************************************************ //
  // XML       : Padre, global, <complexType>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Padre = class(TRemotable)
  private
    Fuuid: WideString;
    Fuuid_Specified: boolean;
    Femisor: WideString;
    Femisor_Specified: boolean;
    Freceptor: WideString;
    Freceptor_Specified: boolean;
    procedure Setuuid(Index: Integer; const AWideString: WideString);
    function  uuid_Specified(Index: Integer): boolean;
    procedure Setemisor(Index: Integer; const AWideString: WideString);
    function  emisor_Specified(Index: Integer): boolean;
    procedure Setreceptor(Index: Integer; const AWideString: WideString);
    function  receptor_Specified(Index: Integer): boolean;
  published
    property uuid:     WideString  Index (IS_OPTN or IS_NLBL) read Fuuid write Setuuid stored uuid_Specified;
    property emisor:   WideString  Index (IS_OPTN or IS_NLBL) read Femisor write Setemisor stored emisor_Specified;
    property receptor: WideString  Index (IS_OPTN or IS_NLBL) read Freceptor write Setreceptor stored receptor_Specified;
  end;



  // ************************************************************************ //
  // XML       : Padre, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Padre2 = class(Padre)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Hijo, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Hijo2 = class(Hijo)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RelatedResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  RelatedResult2 = class(RelatedResult)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Folio, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Folio2 = class(Folio)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Rechaza, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Rechaza2 = class(Rechaza)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Acepta, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  Acepta2 = class(Acepta)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AcceptRejectResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcceptRejectResult2 = class(AcceptRejectResult)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : QueryPendingResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  QueryPendingResult2 = class(QueryPendingResult)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUID, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID2 = class(UUID)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ReceiptResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  ReceiptResult2 = class(ReceiptResult)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUIDS, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS2 = class(UUIDS)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : FinkOKRespuestaCancelacion2, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  FinkOKRespuestaCancelacion22 = class(FinkOKRespuestaCancelacion2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUID_AR, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUID_AR2 = class(UUID_AR)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UUIDS_AR, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  UUIDS_AR2 = class(UUIDS_AR)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AcuseSATConsulta, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSATConsulta2 = class(AcuseSATConsulta)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AcuseSatEstatus, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  AcuseSatEstatus2 = class(AcuseSatEstatus)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : CancelPendingResult, global, <element>
  // Namespace : apps.services.soap.core.views
  // ************************************************************************ //
  CancelPendingResult2 = class(CancelPendingResult)
  private
  published
  end;


  // ************************************************************************ //
  // Name      : Application
  // Namespace : http://facturacion.finkok.com/cancel
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Application
  // service   : CancelSOAP
  // port      : Application
  // URL       : https://demo-facturacion.finkok.com/servicios/soap/cancel
  // ************************************************************************ //
  IFinkOkServicioCancelacion = interface(IInvokable)
  ['{A50B2847-80CB-1437-9E24-A9C18DE43316}']
    procedure dmethod(const UUIDS: UUIDS); stdcall;
    function  cancel_signature(const xml: TByteDynArray; const username: WideString; const password: WideString; const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  get_out_sat_status(const username: WideString; const password: WideString; const taxpayer_id: WideString; const rtaxpayer_id: WideString; const uuid: WideString; const total: WideString
                                 ): AcuseSatEstatus; stdcall;
    function  get_out_pending(const username: WideString; const password: WideString; const rtaxpayer_id: WideString): CancelPendingResult; stdcall;
    function  get_pending(const username: WideString; const password: WideString; const rtaxpayer_id: WideString): CancelPendingResult; stdcall;
    function  get_sat_status(const username: WideString; const password: WideString; const taxpayer_id: WideString; const rtaxpayer_id: WideString; const uuid: WideString; const total: WideString
                             ): AcuseSatEstatus; stdcall;
    function  get_related_signature(const xml: TByteDynArray; const username: WideString; const password: WideString): RelatedResult; stdcall;
    function  get_related(const username: WideString; const password: WideString; const taxpayer_id: WideString; const rtaxpayer_id: WideString; const uuid: WideString; const cer: TByteDynArray;
                          const key: TByteDynArray): RelatedResult; stdcall;
    function  query_pending_cancellation(const username: WideString; const password: WideString; const uuid: WideString): QueryPendingResult; stdcall;
    function  accept_reject_signature(const xml: TByteDynArray; const username: WideString; const password: WideString): AcceptRejectResult; stdcall;
    function  sign_cancel(const UUIDS: UUIDArray; const username: WideString; const password: WideString; const taxpayer_id: WideString; const serial: WideString; const store_pending: Boolean
                          ): FinkOKRespuestaCancelacion2; stdcall;
    function  get_receipt(const username: WideString; const password: WideString; const taxpayer_id: WideString; const uuid: WideString; const type_: WideString): ReceiptResult; stdcall;
    function  cancel(const UUIDS: UUIDArray; const username: WideString; const password: WideString; const taxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray;
                     const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  get_out_related(const username: WideString; const password: WideString; const taxpayer_id: WideString; const rtaxpayer_id: WideString; const uuid: WideString; const cer: TByteDynArray;
                              const key: TByteDynArray): RelatedResult; stdcall;
    function  out_cancel(const xml: TByteDynArray; const username: WideString; const password: WideString; const taxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray;
                         const store_pending: Boolean): FinkOKRespuestaCancelacion2; stdcall;
    function  out_accept_reject(const UUID_AR: UUID_AR; const username: WideString; const password: WideString; const rtaxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray
                                ): AcceptRejectResult; stdcall;
    function  accept_reject(const UUIDS_AR: UUIDS_AR; const username: WideString; const password: WideString; const rtaxpayer_id: WideString; const cer: TByteDynArray; const key: TByteDynArray
                            ): AcceptRejectResult; stdcall;
  end;

function GetIFinkOkServicioCancelacion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFinkOkServicioCancelacion;


implementation
  uses SysUtils;

function GetIFinkOkServicioCancelacion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFinkOkServicioCancelacion;
const
  defWSDL = 'https://demo-facturacion.finkok.com/servicios/soap/cancel.wsdl';
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


procedure CancelPendingResult.Setuuids(Index: Integer; const AstringArray2: stringArray2);
begin
  Fuuids := AstringArray2;
  Fuuids_Specified := True;
end;

function CancelPendingResult.uuids_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_Specified;
end;

procedure CancelPendingResult.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function CancelPendingResult.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

destructor AcuseSatEstatus.Destroy;
begin
  FreeAndNil(Fsat);
  inherited Destroy;
end;

procedure AcuseSatEstatus.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function AcuseSatEstatus.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure AcuseSatEstatus.Setsat(Index: Integer; const AAcuseSATConsulta: AcuseSATConsulta);
begin
  Fsat := AAcuseSATConsulta;
  Fsat_Specified := True;
end;

function AcuseSatEstatus.sat_Specified(Index: Integer): boolean;
begin
  Result := Fsat_Specified;
end;

procedure AcuseSATConsulta.SetDetallesValidacionEFOS(Index: Integer; const AWideString: WideString);
begin
  FDetallesValidacionEFOS := AWideString;
  FDetallesValidacionEFOS_Specified := True;
end;

function AcuseSATConsulta.DetallesValidacionEFOS_Specified(Index: Integer): boolean;
begin
  Result := FDetallesValidacionEFOS_Specified;
end;

procedure AcuseSATConsulta.SetEsCancelable(Index: Integer; const AWideString: WideString);
begin
  FEsCancelable := AWideString;
  FEsCancelable_Specified := True;
end;

function AcuseSATConsulta.EsCancelable_Specified(Index: Integer): boolean;
begin
  Result := FEsCancelable_Specified;
end;

procedure AcuseSATConsulta.SetValidacionEFOS(Index: Integer; const AWideString: WideString);
begin
  FValidacionEFOS := AWideString;
  FValidacionEFOS_Specified := True;
end;

function AcuseSATConsulta.ValidacionEFOS_Specified(Index: Integer): boolean;
begin
  Result := FValidacionEFOS_Specified;
end;

procedure AcuseSATConsulta.SetCodigoEstatus(Index: Integer; const AWideString: WideString);
begin
  FCodigoEstatus := AWideString;
  FCodigoEstatus_Specified := True;
end;

function AcuseSATConsulta.CodigoEstatus_Specified(Index: Integer): boolean;
begin
  Result := FCodigoEstatus_Specified;
end;

procedure AcuseSATConsulta.SetEstado(Index: Integer; const AWideString: WideString);
begin
  FEstado := AWideString;
  FEstado_Specified := True;
end;

function AcuseSATConsulta.Estado_Specified(Index: Integer): boolean;
begin
  Result := FEstado_Specified;
end;

procedure AcuseSATConsulta.SetEstatusCancelacion(Index: Integer; const AWideString: WideString);
begin
  FEstatusCancelacion := AWideString;
  FEstatusCancelacion_Specified := True;
end;

function AcuseSATConsulta.EstatusCancelacion_Specified(Index: Integer): boolean;
begin
  Result := FEstatusCancelacion_Specified;
end;

procedure UUID.SetUUID(Index: Integer; const AWideString: WideString);
begin
  FUUID := AWideString;
  FUUID_Specified := True;
end;

function UUID.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

procedure UUID.SetFolioSustitucion(Index: Integer; const AWideString: WideString);
begin
  FFolioSustitucion := AWideString;
  FFolioSustitucion_Specified := True;
end;

function UUID.FolioSustitucion_Specified(Index: Integer): boolean;
begin
  Result := FFolioSustitucion_Specified;
end;

procedure UUID.SetMotivo(Index: Integer; const AWideString: WideString);
begin
  FMotivo := AWideString;
  FMotivo_Specified := True;
end;

function UUID.Motivo_Specified(Index: Integer): boolean;
begin
  Result := FMotivo_Specified;
end;

destructor UUIDS_AR.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fuuids_ar)-1 do
    FreeAndNil(Fuuids_ar[I]);
  SetLength(Fuuids_ar, 0);
  inherited Destroy;
end;

procedure UUIDS_AR.Setuuids_ar(Index: Integer; const AUUID_ARArray: UUID_ARArray);
begin
  Fuuids_ar := AUUID_ARArray;
  Fuuids_ar_Specified := True;
end;

function UUIDS_AR.uuids_ar_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_ar_Specified;
end;

procedure UUID_AR.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function UUID_AR.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure UUID_AR.Setrespuesta(Index: Integer; const AWideString: WideString);
begin
  Frespuesta := AWideString;
  Frespuesta_Specified := True;
end;

function UUID_AR.respuesta_Specified(Index: Integer): boolean;
begin
  Result := Frespuesta_Specified;
end;

destructor FinkOKRespuestaCancelacion2.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FFolios)-1 do
    FreeAndNil(FFolios[I]);
  SetLength(FFolios, 0);
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

procedure FinkOKRespuestaCancelacion2.SetAcuse(Index: Integer; const AWideString: WideString);
begin
  FAcuse := AWideString;
  FAcuse_Specified := True;
end;

function FinkOKRespuestaCancelacion2.Acuse_Specified(Index: Integer): boolean;
begin
  Result := FAcuse_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetFecha(Index: Integer; const AWideString: WideString);
begin
  FFecha := AWideString;
  FFecha_Specified := True;
end;

function FinkOKRespuestaCancelacion2.Fecha_Specified(Index: Integer): boolean;
begin
  Result := FFecha_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetRfcEmisor(Index: Integer; const AWideString: WideString);
begin
  FRfcEmisor := AWideString;
  FRfcEmisor_Specified := True;
end;

function FinkOKRespuestaCancelacion2.RfcEmisor_Specified(Index: Integer): boolean;
begin
  Result := FRfcEmisor_Specified;
end;

procedure FinkOKRespuestaCancelacion2.SetCodEstatus(Index: Integer; const AWideString: WideString);
begin
  FCodEstatus := AWideString;
  FCodEstatus_Specified := True;
end;

function FinkOKRespuestaCancelacion2.CodEstatus_Specified(Index: Integer): boolean;
begin
  Result := FCodEstatus_Specified;
end;

procedure UUIDS.Setuuids(Index: Integer; const AstringArray: stringArray);
begin
  Fuuids := AstringArray;
  Fuuids_Specified := True;
end;

function UUIDS.uuids_Specified(Index: Integer): boolean;
begin
  Result := Fuuids_Specified;
end;

procedure ReceiptResult.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function ReceiptResult.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure ReceiptResult.Setsuccess(Index: Integer; const ABoolean: Boolean);
begin
  Fsuccess := ABoolean;
  Fsuccess_Specified := True;
end;

function ReceiptResult.success_Specified(Index: Integer): boolean;
begin
  Result := Fsuccess_Specified;
end;

procedure ReceiptResult.Setreceipt(Index: Integer; const AWideString: WideString);
begin
  Freceipt := AWideString;
  Freceipt_Specified := True;
end;

function ReceiptResult.receipt_Specified(Index: Integer): boolean;
begin
  Result := Freceipt_Specified;
end;

procedure ReceiptResult.Settaxpayer_id(Index: Integer; const AWideString: WideString);
begin
  Ftaxpayer_id := AWideString;
  Ftaxpayer_id_Specified := True;
end;

function ReceiptResult.taxpayer_id_Specified(Index: Integer): boolean;
begin
  Result := Ftaxpayer_id_Specified;
end;

procedure ReceiptResult.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function ReceiptResult.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure ReceiptResult.Setdate(Index: Integer; const AWideString: WideString);
begin
  Fdate := AWideString;
  Fdate_Specified := True;
end;

function ReceiptResult.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

procedure QueryPendingResult.Setstatus(Index: Integer; const AWideString: WideString);
begin
  Fstatus := AWideString;
  Fstatus_Specified := True;
end;

function QueryPendingResult.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure QueryPendingResult.Setxml(Index: Integer; const AWideString: WideString);
begin
  Fxml := AWideString;
  Fxml_Specified := True;
end;

function QueryPendingResult.xml_Specified(Index: Integer): boolean;
begin
  Result := Fxml_Specified;
end;

procedure QueryPendingResult.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function QueryPendingResult.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure QueryPendingResult.Setuuid_status(Index: Integer; const AWideString: WideString);
begin
  Fuuid_status := AWideString;
  Fuuid_status_Specified := True;
end;

function QueryPendingResult.uuid_status_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_status_Specified;
end;

procedure QueryPendingResult.Setnext_attempt(Index: Integer; const AWideString: WideString);
begin
  Fnext_attempt := AWideString;
  Fnext_attempt_Specified := True;
end;

function QueryPendingResult.next_attempt_Specified(Index: Integer): boolean;
begin
  Result := Fnext_attempt_Specified;
end;

procedure QueryPendingResult.Setattempts(Index: Integer; const AWideString: WideString);
begin
  Fattempts := AWideString;
  Fattempts_Specified := True;
end;

function QueryPendingResult.attempts_Specified(Index: Integer): boolean;
begin
  Result := Fattempts_Specified;
end;

procedure QueryPendingResult.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function QueryPendingResult.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure QueryPendingResult.Setdate(Index: Integer; const AWideString: WideString);
begin
  Fdate := AWideString;
  Fdate_Specified := True;
end;

function QueryPendingResult.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

destructor AcceptRejectResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Frechazo)-1 do
    FreeAndNil(Frechazo[I]);
  SetLength(Frechazo, 0);
  for I := 0 to Length(Faceptacion)-1 do
    FreeAndNil(Faceptacion[I]);
  SetLength(Faceptacion, 0);
  inherited Destroy;
end;

procedure AcceptRejectResult.Setrechazo(Index: Integer; const ARechazaArray: RechazaArray);
begin
  Frechazo := ARechazaArray;
  Frechazo_Specified := True;
end;

function AcceptRejectResult.rechazo_Specified(Index: Integer): boolean;
begin
  Result := Frechazo_Specified;
end;

procedure AcceptRejectResult.Setaceptacion(Index: Integer; const AAceptaArray: AceptaArray);
begin
  Faceptacion := AAceptaArray;
  Faceptacion_Specified := True;
end;

function AcceptRejectResult.aceptacion_Specified(Index: Integer): boolean;
begin
  Result := Faceptacion_Specified;
end;

procedure AcceptRejectResult.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function AcceptRejectResult.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure Acepta.Setstatus(Index: Integer; const AWideString: WideString);
begin
  Fstatus := AWideString;
  Fstatus_Specified := True;
end;

function Acepta.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure Acepta.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function Acepta.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Rechaza.Setstatus(Index: Integer; const AWideString: WideString);
begin
  Fstatus := AWideString;
  Fstatus_Specified := True;
end;

function Rechaza.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure Rechaza.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function Rechaza.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Folio.SetUUID(Index: Integer; const AWideString: WideString);
begin
  FUUID := AWideString;
  FUUID_Specified := True;
end;

function Folio.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

procedure Folio.SetEstatusUUID(Index: Integer; const AWideString: WideString);
begin
  FEstatusUUID := AWideString;
  FEstatusUUID_Specified := True;
end;

function Folio.EstatusUUID_Specified(Index: Integer): boolean;
begin
  Result := FEstatusUUID_Specified;
end;

procedure Folio.SetEstatusCancelacion(Index: Integer; const AWideString: WideString);
begin
  FEstatusCancelacion := AWideString;
  FEstatusCancelacion_Specified := True;
end;

function Folio.EstatusCancelacion_Specified(Index: Integer): boolean;
begin
  Result := FEstatusCancelacion_Specified;
end;

destructor RelatedResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FPadres)-1 do
    FreeAndNil(FPadres[I]);
  SetLength(FPadres, 0);
  for I := 0 to Length(FHijos)-1 do
    FreeAndNil(FHijos[I]);
  SetLength(FHijos, 0);
  inherited Destroy;
end;

procedure RelatedResult.SetPadres(Index: Integer; const APadreArray: PadreArray);
begin
  FPadres := APadreArray;
  FPadres_Specified := True;
end;

function RelatedResult.Padres_Specified(Index: Integer): boolean;
begin
  Result := FPadres_Specified;
end;

procedure RelatedResult.Seterror(Index: Integer; const AWideString: WideString);
begin
  Ferror := AWideString;
  Ferror_Specified := True;
end;

function RelatedResult.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure RelatedResult.SetHijos(Index: Integer; const AHijoArray: HijoArray);
begin
  FHijos := AHijoArray;
  FHijos_Specified := True;
end;

function RelatedResult.Hijos_Specified(Index: Integer): boolean;
begin
  Result := FHijos_Specified;
end;

procedure Hijo.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function Hijo.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Hijo.Setemisor(Index: Integer; const AWideString: WideString);
begin
  Femisor := AWideString;
  Femisor_Specified := True;
end;

function Hijo.emisor_Specified(Index: Integer): boolean;
begin
  Result := Femisor_Specified;
end;

procedure Hijo.Setreceptor(Index: Integer; const AWideString: WideString);
begin
  Freceptor := AWideString;
  Freceptor_Specified := True;
end;

function Hijo.receptor_Specified(Index: Integer): boolean;
begin
  Result := Freceptor_Specified;
end;

procedure Padre.Setuuid(Index: Integer; const AWideString: WideString);
begin
  Fuuid := AWideString;
  Fuuid_Specified := True;
end;

function Padre.uuid_Specified(Index: Integer): boolean;
begin
  Result := Fuuid_Specified;
end;

procedure Padre.Setemisor(Index: Integer; const AWideString: WideString);
begin
  Femisor := AWideString;
  Femisor_Specified := True;
end;

function Padre.emisor_Specified(Index: Integer): boolean;
begin
  Result := Femisor_Specified;
end;

procedure Padre.Setreceptor(Index: Integer; const AWideString: WideString);
begin
  Freceptor := AWideString;
  Freceptor_Specified := True;
end;

function Padre.receptor_Specified(Index: Integer): boolean;
begin
  Result := Freceptor_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IFinkOkServicioCancelacion), 'http://facturacion.finkok.com/cancel', 'UTF-8', '', 'Application');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFinkOkServicioCancelacion), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IFinkOkServicioCancelacion), ioDocument);
  InvRegistry.RegisterExternalParamName(TypeInfo(IFinkOkServicioCancelacion), 'get_receipt', 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stringArray), 'http://facturacion.finkok.com/cancellation', 'stringArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stringArray2), 'http://facturacion.finkok.com/cancel', 'stringArray2', 'stringArray');
  RemClassRegistry.RegisterXSClass(CancelPendingResult, 'apps.services.soap.core.views', 'CancelPendingResult');
  RemClassRegistry.RegisterXSClass(AcuseSatEstatus, 'apps.services.soap.core.views', 'AcuseSatEstatus');
  RemClassRegistry.RegisterXSClass(AcuseSATConsulta, 'apps.services.soap.core.views', 'AcuseSATConsulta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(UUIDArray), 'apps.services.soap.core.views', 'UUIDArray');
  RemClassRegistry.RegisterXSClass(UUID, 'apps.services.soap.core.views', 'UUID');
  RemClassRegistry.RegisterXSInfo(TypeInfo(UUID_ARArray), 'apps.services.soap.core.views', 'UUID_ARArray');
  RemClassRegistry.RegisterXSClass(UUIDS_AR, 'apps.services.soap.core.views', 'UUIDS_AR');
  RemClassRegistry.RegisterXSClass(UUID_AR, 'apps.services.soap.core.views', 'UUID_AR');
  RemClassRegistry.RegisterXSInfo(TypeInfo(FolioArray), 'apps.services.soap.core.views', 'FolioArray');
  RemClassRegistry.RegisterXSClass(FinkOKRespuestaCancelacion2, 'apps.services.soap.core.views', 'FinkOKRespuestaCancelacion2');
  RemClassRegistry.RegisterXSClass(UUIDS, 'apps.services.soap.core.views', 'UUIDS');
  RemClassRegistry.RegisterXSClass(ReceiptResult, 'apps.services.soap.core.views', 'ReceiptResult');
  RemClassRegistry.RegisterXSClass(QueryPendingResult, 'apps.services.soap.core.views', 'QueryPendingResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(RechazaArray), 'apps.services.soap.core.views', 'RechazaArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(AceptaArray), 'apps.services.soap.core.views', 'AceptaArray');
  RemClassRegistry.RegisterXSClass(AcceptRejectResult, 'apps.services.soap.core.views', 'AcceptRejectResult');
  RemClassRegistry.RegisterXSClass(Acepta, 'apps.services.soap.core.views', 'Acepta');
  RemClassRegistry.RegisterXSClass(Rechaza, 'apps.services.soap.core.views', 'Rechaza');
  RemClassRegistry.RegisterXSClass(Folio, 'apps.services.soap.core.views', 'Folio');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PadreArray), 'apps.services.soap.core.views', 'PadreArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(HijoArray), 'apps.services.soap.core.views', 'HijoArray');
  RemClassRegistry.RegisterXSClass(RelatedResult, 'apps.services.soap.core.views', 'RelatedResult');
  RemClassRegistry.RegisterXSClass(Hijo, 'apps.services.soap.core.views', 'Hijo');
  RemClassRegistry.RegisterXSClass(Padre, 'apps.services.soap.core.views', 'Padre');
  RemClassRegistry.RegisterXSClass(Padre2, 'apps.services.soap.core.views', 'Padre2', 'Padre');
  RemClassRegistry.RegisterXSClass(Hijo2, 'apps.services.soap.core.views', 'Hijo2', 'Hijo');
  RemClassRegistry.RegisterXSClass(RelatedResult2, 'apps.services.soap.core.views', 'RelatedResult2', 'RelatedResult');
  RemClassRegistry.RegisterXSClass(Folio2, 'apps.services.soap.core.views', 'Folio2', 'Folio');
  RemClassRegistry.RegisterXSClass(Rechaza2, 'apps.services.soap.core.views', 'Rechaza2', 'Rechaza');
  RemClassRegistry.RegisterXSClass(Acepta2, 'apps.services.soap.core.views', 'Acepta2', 'Acepta');
  RemClassRegistry.RegisterXSClass(AcceptRejectResult2, 'apps.services.soap.core.views', 'AcceptRejectResult2', 'AcceptRejectResult');
  RemClassRegistry.RegisterXSClass(QueryPendingResult2, 'apps.services.soap.core.views', 'QueryPendingResult2', 'QueryPendingResult');
  RemClassRegistry.RegisterXSClass(UUID2, 'apps.services.soap.core.views', 'UUID2', 'UUID');
  RemClassRegistry.RegisterXSClass(ReceiptResult2, 'apps.services.soap.core.views', 'ReceiptResult2', 'ReceiptResult');
  RemClassRegistry.RegisterXSClass(UUIDS2, 'apps.services.soap.core.views', 'UUIDS2', 'UUIDS');
  RemClassRegistry.RegisterXSClass(FinkOKRespuestaCancelacion22, 'apps.services.soap.core.views', 'FinkOKRespuestaCancelacion22', 'FinkOKRespuestaCancelacion2');
  RemClassRegistry.RegisterXSClass(UUID_AR2, 'apps.services.soap.core.views', 'UUID_AR2', 'UUID_AR');
  RemClassRegistry.RegisterXSClass(UUIDS_AR2, 'apps.services.soap.core.views', 'UUIDS_AR2', 'UUIDS_AR');
  RemClassRegistry.RegisterXSClass(AcuseSATConsulta2, 'apps.services.soap.core.views', 'AcuseSATConsulta2', 'AcuseSATConsulta');
  RemClassRegistry.RegisterXSClass(AcuseSatEstatus2, 'apps.services.soap.core.views', 'AcuseSatEstatus2', 'AcuseSatEstatus');
  RemClassRegistry.RegisterXSClass(CancelPendingResult2, 'apps.services.soap.core.views', 'CancelPendingResult2', 'CancelPendingResult');

end.
