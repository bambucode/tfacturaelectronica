// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc?wsdl
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc?wsdl>0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc?xsd=xsd0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// ************************************************************************ //

unit EcodexWsTimbrado;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

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
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  InformacionQR2       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexComprobanteXML      = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  ComprobanteXML       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexAdvertenciaValidacion = class;               { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TSolicitudTimbradoEcodex   = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexEstadoComprobante  = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexFallaSesion         = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  //TEcodexFallaServicio       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  //TEcodexFallaValidacion     = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexRespuestaTimbrado   = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  SolicitudObtenerTimbrado = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  ComprobanteEstatus   = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  RespuestaEstatusTimbrado = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  RespuestaObtenerTimbrado = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  InformacionQR        = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  RespuestaObtenerQRTimbrado = class;           { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  SolicitudObtenerQRTimbrado = class;           { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  SolicitudEstatusTimbrado = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  EFallaValidacionException      = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Flt][GblElm] }
  FallaSesion          = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Flt][GblElm] }
  AdvertenciaValidacion = class;                { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  EFallaServicioException        = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Flt][GblElm] }
  TEcodexRespuestaCancelacion = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexSolicitudCancelacion = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }



  // ************************************************************************ //
  // XML       : InformacionQR, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  InformacionQR2 = class(TRemotable)
  private
    FImagen: TByteDynArray;
    FImagen_Specified: boolean;
    procedure SetImagen(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  Imagen_Specified(Index: Integer): boolean;
  published
    property Imagen: TByteDynArray  Index (IS_OPTN or IS_NLBL) read FImagen write SetImagen stored Imagen_Specified;
  end;

  TEcodexAdvertenciasDeValidacion = array of TEcodexAdvertenciaValidacion;   { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }


  // ************************************************************************ //
  // XML       : ComprobanteXML, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexComprobanteXML = class(TRemotable)
  private
    FDatosXML: string;
    FDatosXML_Specified: boolean;
    procedure SetDatosXML(Index: Integer; const Astring: string);
    function  DatosXML_Specified(Index: Integer): boolean;
  published
    property DatosXML: string  Index (IS_OPTN or IS_NLBL) read FDatosXML write SetDatosXML stored DatosXML_Specified;
  end;



  // ************************************************************************ //
  // XML       : ComprobanteXML, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  ComprobanteXML = class(TEcodexComprobanteXML)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AdvertenciaValidacion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexAdvertenciaValidacion = class(TRemotable)
  private
    FNodo: string;
    FDescripcion: string;
    FAntecedente: string;
    FAntecedente_Specified: boolean;
    FSugerencia: string;
    FSugerencia_Specified: boolean;
    procedure SetAntecedente(Index: Integer; const Astring: string);
    function  Antecedente_Specified(Index: Integer): boolean;
    procedure SetSugerencia(Index: Integer; const Astring: string);
    function  Sugerencia_Specified(Index: Integer): boolean;
  published
    property Nodo:        string  Index (IS_NLBL) read FNodo write FNodo;
    property Descripcion: string  Index (IS_NLBL) read FDescripcion write FDescripcion;
    property Antecedente: string  Index (IS_OPTN or IS_NLBL) read FAntecedente write SetAntecedente stored Antecedente_Specified;
    property Sugerencia:  string  Index (IS_OPTN or IS_NLBL) read FSugerencia write SetSugerencia stored Sugerencia_Specified;
  end;



  // ************************************************************************ //
  // XML       : TSolicitudTimbradoEcodex, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TSolicitudTimbradoEcodex = class(TRemotable)
  private
    FComprobanteXML: TEcodexComprobanteXML;
    FComprobanteXML_Specified: boolean;
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
    function  ComprobanteXML_Specified(Index: Integer): boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property ComprobanteXML: TEcodexComprobanteXML  Index (IS_OPTN or IS_NLBL) read FComprobanteXML write SetComprobanteXML stored ComprobanteXML_Specified;
    property RFC:            string           Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:          string           Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID:  Int64            Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : ComprobanteEstatus, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexEstadoComprobante = class(TRemotable)
  private
    FUUID: string;
    FCodigo: string;
    FCodigo_Specified: boolean;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FUltimaActualizacion: TXSDateTime;
    FUltimaActualizacion_Specified: boolean;
    procedure SetCodigo(Index: Integer; const Astring: string);
    function  Codigo_Specified(Index: Integer): boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetUltimaActualizacion(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  UltimaActualizacion_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property UUID:                string       Index (IS_NLBL) read FUUID write FUUID;
    property Codigo:              string       Index (IS_OPTN or IS_NLBL) read FCodigo write SetCodigo stored Codigo_Specified;
    property Descripcion:         string       Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property UltimaActualizacion: TXSDateTime  Index (IS_OPTN) read FUltimaActualizacion write SetUltimaActualizacion stored UltimaActualizacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : FallaSesion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexFallaSesion = class(TRemotable)
  private
    FRFC: string;
    FEstatus: Integer;
    FEstatus_Specified: boolean;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    procedure SetEstatus(Index: Integer; const AInteger: Integer);
    function  Estatus_Specified(Index: Integer): boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Estatus:     Integer  Index (IS_OPTN) read FEstatus write SetEstatus stored Estatus_Specified;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
  end;



  // ************************************************************************ //
  // XML       : EFallaServicioException, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  {TEcodexFallaServicio = class(TRemotable)
  private
    FRFC: string;
    FNumero: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FEvento: string;
    FEvento_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetEvento(Index: Integer; const Astring: string);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Numero:      Integer  read FNumero write FNumero;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property Evento:      string   Index (IS_OPTN or IS_NLBL) read FEvento write SetEvento stored Evento_Specified;
  end;
         }


  // ************************************************************************ //
  // XML       : EFallaValidacionException, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
 { TEcodexFallaValidacion = class(TRemotable)
  private
    FRFC: string;
    FNumero: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FNodo: string;
    FNodo_Specified: boolean;
    FAntecedente: string;
    FAntecedente_Specified: boolean;
    FSugerencia: string;
    FSugerencia_Specified: boolean;
    FEvento: string;
    FEvento_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetNodo(Index: Integer; const Astring: string);
    function  Nodo_Specified(Index: Integer): boolean;
    procedure SetAntecedente(Index: Integer; const Astring: string);
    function  Antecedente_Specified(Index: Integer): boolean;
    procedure SetSugerencia(Index: Integer; const Astring: string);
    function  Sugerencia_Specified(Index: Integer): boolean;
    procedure SetEvento(Index: Integer; const Astring: string);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Numero:      Integer  read FNumero write FNumero;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property Nodo:        string   Index (IS_OPTN or IS_NLBL) read FNodo write SetNodo stored Nodo_Specified;
    property Antecedente: string   Index (IS_OPTN or IS_NLBL) read FAntecedente write SetAntecedente stored Antecedente_Specified;
    property Sugerencia:  string   Index (IS_OPTN or IS_NLBL) read FSugerencia write SetSugerencia stored Sugerencia_Specified;
    property Evento:      string   Index (IS_OPTN or IS_NLBL) read FEvento write SetEvento stored Evento_Specified;
  end;    }



  // ************************************************************************ //
  // XML       : TEcodexRespuestaTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaTimbrado = class(TRemotable)
  private
    FAdvertencias: TEcodexAdvertenciasDeValidacion;
    FAdvertencias_Specified: boolean;
    FComprobanteXML: TEcodexComprobanteXML;
    FComprobanteXML_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetAdvertencias(Index: Integer; const AAdvertenciasValidacion: TEcodexAdvertenciasDeValidacion);
    function  Advertencias_Specified(Index: Integer): boolean;
    procedure SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
    function  ComprobanteXML_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Advertencias:   TEcodexAdvertenciasDeValidacion  Index (IS_OPTN or IS_NLBL) read FAdvertencias write SetAdvertencias stored Advertencias_Specified;
    property ComprobanteXML: TEcodexComprobanteXML         Index (IS_OPTN or IS_NLBL) read FComprobanteXML write SetComprobanteXML stored ComprobanteXML_Specified;
    property TransaccionID:  Int64                   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : SolicitudObtenerTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SolicitudObtenerTimbrado = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FTransaccionOriginal: Int64;
    FTransaccionOriginal_Specified: boolean;
    FUUID: string;
    FUUID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    procedure SetTransaccionOriginal(Index: Integer; const AInt64: Int64);
    function  TransaccionOriginal_Specified(Index: Integer): boolean;
    procedure SetUUID(Index: Integer; const Astring: string);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:                 string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:               string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID:       Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property TransaccionOriginal: Int64   Index (IS_OPTN) read FTransaccionOriginal write SetTransaccionOriginal stored TransaccionOriginal_Specified;
    property UUID:                string  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
  end;



  // ************************************************************************ //
  // XML       : ComprobanteEstatus, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  ComprobanteEstatus = class(TEcodexEstadoComprobante)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaEstatusTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaEstatusTimbrado = class(TRemotable)
  private
    FEstatus: TEcodexEstadoComprobante;
    FEstatus_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetEstatus(Index: Integer; const AComprobanteEstatus2: TEcodexEstadoComprobante);
    function  Estatus_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Estatus:       TEcodexEstadoComprobante  Index (IS_OPTN or IS_NLBL) read FEstatus write SetEstatus stored Estatus_Specified;
    property TransaccionID: Int64                Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : RespuestaObtenerTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaObtenerTimbrado = class(TRemotable)
  private
    FComprobanteXML: TEcodexComprobanteXML;
    FComprobanteXML_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
    function  ComprobanteXML_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property ComprobanteXML: TEcodexComprobanteXML  Index (IS_OPTN or IS_NLBL) read FComprobanteXML write SetComprobanteXML stored ComprobanteXML_Specified;
    property TransaccionID:  Int64            Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : InformacionQR, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  InformacionQR = class(InformacionQR2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RespuestaObtenerQRTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RespuestaObtenerQRTimbrado = class(TRemotable)
  private
    FQR: InformacionQR2;
    FQR_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetQR(Index: Integer; const AInformacionQR2: InformacionQR2);
    function  QR_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property QR:            InformacionQR2  Index (IS_OPTN or IS_NLBL) read FQR write SetQR stored QR_Specified;
    property TransaccionID: Int64           Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : SolicitudObtenerQRTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SolicitudObtenerQRTimbrado = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FUUID: string;
    FUUID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    procedure SetUUID(Index: Integer; const Astring: string);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:           string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:         string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property UUID:          string  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
  end;



  // ************************************************************************ //
  // XML       : SolicitudEstatusTimbrado, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SolicitudEstatusTimbrado = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FTransaccionOriginal: Int64;
    FTransaccionOriginal_Specified: boolean;
    FUUID: string;
    FUUID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    procedure SetTransaccionOriginal(Index: Integer; const AInt64: Int64);
    function  TransaccionOriginal_Specified(Index: Integer): boolean;
    procedure SetUUID(Index: Integer; const Astring: string);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:                 string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:               string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID:       Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property TransaccionOriginal: Int64   Index (IS_OPTN) read FTransaccionOriginal write SetTransaccionOriginal stored TransaccionOriginal_Specified;
    property UUID:                string  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
  end;



  // ************************************************************************ //
  // XML       : EFallaValidacionException, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: EFallaValidacionException
  // ************************************************************************ //
  EFallaValidacionException = class(ERemotableException)
  private
    FRFC: string;
    FNumero: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FNodo: string;
    FNodo_Specified: boolean;
    FAntecedente: string;
    FAntecedente_Specified: boolean;
    FSugerencia: string;
    FSugerencia_Specified: boolean;
    FEvento: string;
    FEvento_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetNodo(Index: Integer; const Astring: string);
    function  Nodo_Specified(Index: Integer): boolean;
    procedure SetAntecedente(Index: Integer; const Astring: string);
    function  Antecedente_Specified(Index: Integer): boolean;
    procedure SetSugerencia(Index: Integer; const Astring: string);
    function  Sugerencia_Specified(Index: Integer): boolean;
    procedure SetEvento(Index: Integer; const Astring: string);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Numero:      Integer  read FNumero write FNumero;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property Nodo:        string   Index (IS_OPTN or IS_NLBL) read FNodo write SetNodo stored Nodo_Specified;
    property Antecedente: string   Index (IS_OPTN or IS_NLBL) read FAntecedente write SetAntecedente stored Antecedente_Specified;
    property Sugerencia:  string   Index (IS_OPTN or IS_NLBL) read FSugerencia write SetSugerencia stored Sugerencia_Specified;
    property Evento:      string   Index (IS_OPTN or IS_NLBL) read FEvento write SetEvento stored Evento_Specified;
  end;



  // ************************************************************************ //
  // XML       : FallaSesion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: FallaSesion
  // ************************************************************************ //
  FallaSesion = class(ERemotableException)
  private
    FRFC: string;
    FEstatus: Integer;
    FEstatus_Specified: boolean;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    procedure SetEstatus(Index: Integer; const AInteger: Integer);
    function  Estatus_Specified(Index: Integer): boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Estatus:     Integer  Index (IS_OPTN) read FEstatus write SetEstatus stored Estatus_Specified;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
  end;



  // ************************************************************************ //
  // XML       : AdvertenciaValidacion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  AdvertenciaValidacion = class(TEcodexAdvertenciaValidacion)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : EFallaServicioException, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: EFallaServicioException
  // ************************************************************************ //
  EFallaServicioException = class(ERemotableException)
  private
    FRFC: string;
    FNumero: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FEvento: string;
    FEvento_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetEvento(Index: Integer; const Astring: string);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         string   Index (IS_NLBL) read FRFC write FRFC;
    property Numero:      Integer  read FNumero write FNumero;
    property Descripcion: string   Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property Evento:      string   Index (IS_OPTN or IS_NLBL) read FEvento write SetEvento stored Evento_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaCancelacion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaCancelacion = class(TRemotable)
  private
    FCancelada: Boolean;
    FCancelada_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetCancelada(Index: Integer; const ABoolean: Boolean);
    function  Cancelada_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property Cancelada:     Boolean  Index (IS_OPTN) read FCancelada write SetCancelada stored Cancelada_Specified;
    property TransaccionID: Int64    Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudCancelacion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudCancelacion = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FUUID: string;
    FUUID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    procedure SetUUID(Index: Integer; const Astring: string);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:           string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:         string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property UUID:          string  Index (IS_OPTN or IS_NLBL) read FUUID write SetUUID stored UUID_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // soapAction: http://Ecodex.WS.Model/2011/CFDI/IEcodexServicioTimbrado/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : PuertoTimbradoSeguro
  // service   : IEcodexServicioTimbrado
  // port      : PuertoTimbradoSeguro
  // URL       : https://wsdexpruebas.ecodex.com.mx:2045/ServicioTimbrado.svc
  // ************************************************************************ //
  IEcodexServicioTimbrado = interface(IInvokable)
  ['{4D5D2E91-4036-E0FB-94E1-A1DC8ECF686F}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  TimbraXML(const parameters: TSolicitudTimbradoEcodex): TEcodexRespuestaTimbrado; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  CancelaTimbrado(const parameters: TEcodexSolicitudCancelacion): TEcodexRespuestaCancelacion; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  EstatusTimbrado(const parameters: SolicitudEstatusTimbrado): RespuestaEstatusTimbrado; stdcall;

    // Cannot unwrap:
    //     - Input element wrapper name does not match operation's name
    function  ObtenerTimbrado(const parameters: SolicitudObtenerTimbrado): RespuestaObtenerTimbrado; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  ObtenerQRTimbrado(const parameters: SolicitudObtenerQRTimbrado): RespuestaObtenerQRTimbrado; stdcall;
  end;

function GetWsEcodexTimbrado(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioTimbrado;


implementation

uses SysUtils;

function GetWsEcodexTimbrado(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioTimbrado;
const
  defWSDL = 'https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc?wsdl';
  defURL  = 'https://pruebas.ecodex.com.mx:2045/ServicioTimbrado.svc';
  defSvc  = 'IEcodexServicioTimbrado';
  defPrt  = 'PuertoTimbradoSeguro';
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
    Result := (RIO as IEcodexServicioTimbrado);
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


procedure InformacionQR2.SetImagen(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FImagen := ATByteDynArray;
  FImagen_Specified := True;
end;

function InformacionQR2.Imagen_Specified(Index: Integer): boolean;
begin
  Result := FImagen_Specified;
end;

procedure TEcodexComprobanteXML.SetDatosXML(Index: Integer; const Astring: string);
begin
  FDatosXML := Astring;
  FDatosXML_Specified := True;
end;

function TEcodexComprobanteXML.DatosXML_Specified(Index: Integer): boolean;
begin
  Result := FDatosXML_Specified;
end;

procedure TEcodexAdvertenciaValidacion.SetAntecedente(Index: Integer; const Astring: string);
begin
  FAntecedente := Astring;
  FAntecedente_Specified := True;
end;

function TEcodexAdvertenciaValidacion.Antecedente_Specified(Index: Integer): boolean;
begin
  Result := FAntecedente_Specified;
end;

procedure TEcodexAdvertenciaValidacion.SetSugerencia(Index: Integer; const Astring: string);
begin
  FSugerencia := Astring;
  FSugerencia_Specified := True;
end;

function TEcodexAdvertenciaValidacion.Sugerencia_Specified(Index: Integer): boolean;
begin
  Result := FSugerencia_Specified;
end;

constructor TSolicitudTimbradoEcodex.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TSolicitudTimbradoEcodex.Destroy;
begin
  SysUtils.FreeAndNil(FComprobanteXML);
  inherited Destroy;
end;

procedure TSolicitudTimbradoEcodex.SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
begin
  FComprobanteXML := AComprobanteXML2;
  FComprobanteXML_Specified := True;
end;

function TSolicitudTimbradoEcodex.ComprobanteXML_Specified(Index: Integer): boolean;
begin
  Result := FComprobanteXML_Specified;
end;

procedure TSolicitudTimbradoEcodex.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TSolicitudTimbradoEcodex.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TSolicitudTimbradoEcodex.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TSolicitudTimbradoEcodex.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TSolicitudTimbradoEcodex.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TSolicitudTimbradoEcodex.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

destructor TEcodexEstadoComprobante.Destroy;
begin
  SysUtils.FreeAndNil(FUltimaActualizacion);
  inherited Destroy;
end;

procedure TEcodexEstadoComprobante.SetCodigo(Index: Integer; const Astring: string);
begin
  FCodigo := Astring;
  FCodigo_Specified := True;
end;

function TEcodexEstadoComprobante.Codigo_Specified(Index: Integer): boolean;
begin
  Result := FCodigo_Specified;
end;

procedure TEcodexEstadoComprobante.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function TEcodexEstadoComprobante.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure TEcodexEstadoComprobante.SetUltimaActualizacion(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FUltimaActualizacion := ATXSDateTime;
  FUltimaActualizacion_Specified := True;
end;

function TEcodexEstadoComprobante.UltimaActualizacion_Specified(Index: Integer): boolean;
begin
  Result := FUltimaActualizacion_Specified;
end;

procedure TEcodexFallaSesion.SetEstatus(Index: Integer; const AInteger: Integer);
begin
  FEstatus := AInteger;
  FEstatus_Specified := True;
end;

function TEcodexFallaSesion.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure TEcodexFallaSesion.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function TEcodexFallaSesion.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

{
procedure TEcodexFallaServicio.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function TEcodexFallaServicio.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure TEcodexFallaServicio.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function TEcodexFallaServicio.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;       }
            {
procedure TEcodexFallaValidacion.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function TEcodexFallaValidacion.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure TEcodexFallaValidacion.SetNodo(Index: Integer; const Astring: string);
begin
  FNodo := Astring;
  FNodo_Specified := True;
end;

function TEcodexFallaValidacion.Nodo_Specified(Index: Integer): boolean;
begin
  Result := FNodo_Specified;
end;

procedure TEcodexFallaValidacion.SetAntecedente(Index: Integer; const Astring: string);
begin
  FAntecedente := Astring;
  FAntecedente_Specified := True;
end;

function TEcodexFallaValidacion.Antecedente_Specified(Index: Integer): boolean;
begin
  Result := FAntecedente_Specified;
end;

procedure TEcodexFallaValidacion.SetSugerencia(Index: Integer; const Astring: string);
begin
  FSugerencia := Astring;
  FSugerencia_Specified := True;
end;

function TEcodexFallaValidacion.Sugerencia_Specified(Index: Integer): boolean;
begin
  Result := FSugerencia_Specified;
end;

procedure TEcodexFallaValidacion.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function TEcodexFallaValidacion.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;                     }

constructor TEcodexRespuestaTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TEcodexRespuestaTimbrado.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FAdvertencias)-1 do
    SysUtils.FreeAndNil(FAdvertencias[I]);
  System.SetLength(FAdvertencias, 0);
  SysUtils.FreeAndNil(FComprobanteXML);
  inherited Destroy;
end;

procedure TEcodexRespuestaTimbrado.SetAdvertencias(Index: Integer; const AAdvertenciasValidacion: TEcodexAdvertenciasDeValidacion);
begin
  FAdvertencias := AAdvertenciasValidacion;
  FAdvertencias_Specified := True;
end;

function TEcodexRespuestaTimbrado.Advertencias_Specified(Index: Integer): boolean;
begin
  Result := FAdvertencias_Specified;
end;

procedure TEcodexRespuestaTimbrado.SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
begin
  FComprobanteXML := AComprobanteXML2;
  FComprobanteXML_Specified := True;
end;

function TEcodexRespuestaTimbrado.ComprobanteXML_Specified(Index: Integer): boolean;
begin
  Result := FComprobanteXML_Specified;
end;

procedure TEcodexRespuestaTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor SolicitudObtenerTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure SolicitudObtenerTimbrado.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function SolicitudObtenerTimbrado.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure SolicitudObtenerTimbrado.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function SolicitudObtenerTimbrado.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure SolicitudObtenerTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function SolicitudObtenerTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

procedure SolicitudObtenerTimbrado.SetTransaccionOriginal(Index: Integer; const AInt64: Int64);
begin
  FTransaccionOriginal := AInt64;
  FTransaccionOriginal_Specified := True;
end;

function SolicitudObtenerTimbrado.TransaccionOriginal_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionOriginal_Specified;
end;

procedure SolicitudObtenerTimbrado.SetUUID(Index: Integer; const Astring: string);
begin
  FUUID := Astring;
  FUUID_Specified := True;
end;

function SolicitudObtenerTimbrado.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

constructor RespuestaEstatusTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaEstatusTimbrado.Destroy;
begin
  SysUtils.FreeAndNil(FEstatus);
  inherited Destroy;
end;

procedure RespuestaEstatusTimbrado.SetEstatus(Index: Integer; const AComprobanteEstatus2: TEcodexEstadoComprobante);
begin
  FEstatus := AComprobanteEstatus2;
  FEstatus_Specified := True;
end;

function RespuestaEstatusTimbrado.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure RespuestaEstatusTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function RespuestaEstatusTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor RespuestaObtenerTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaObtenerTimbrado.Destroy;
begin
  SysUtils.FreeAndNil(FComprobanteXML);
  inherited Destroy;
end;

procedure RespuestaObtenerTimbrado.SetComprobanteXML(Index: Integer; const AComprobanteXML2: TEcodexComprobanteXML);
begin
  FComprobanteXML := AComprobanteXML2;
  FComprobanteXML_Specified := True;
end;

function RespuestaObtenerTimbrado.ComprobanteXML_Specified(Index: Integer): boolean;
begin
  Result := FComprobanteXML_Specified;
end;

procedure RespuestaObtenerTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function RespuestaObtenerTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor RespuestaObtenerQRTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RespuestaObtenerQRTimbrado.Destroy;
begin
  SysUtils.FreeAndNil(FQR);
  inherited Destroy;
end;

procedure RespuestaObtenerQRTimbrado.SetQR(Index: Integer; const AInformacionQR2: InformacionQR2);
begin
  FQR := AInformacionQR2;
  FQR_Specified := True;
end;

function RespuestaObtenerQRTimbrado.QR_Specified(Index: Integer): boolean;
begin
  Result := FQR_Specified;
end;

procedure RespuestaObtenerQRTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function RespuestaObtenerQRTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor SolicitudObtenerQRTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure SolicitudObtenerQRTimbrado.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function SolicitudObtenerQRTimbrado.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure SolicitudObtenerQRTimbrado.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function SolicitudObtenerQRTimbrado.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure SolicitudObtenerQRTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function SolicitudObtenerQRTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

procedure SolicitudObtenerQRTimbrado.SetUUID(Index: Integer; const Astring: string);
begin
  FUUID := Astring;
  FUUID_Specified := True;
end;

function SolicitudObtenerQRTimbrado.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

constructor SolicitudEstatusTimbrado.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure SolicitudEstatusTimbrado.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function SolicitudEstatusTimbrado.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure SolicitudEstatusTimbrado.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function SolicitudEstatusTimbrado.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure SolicitudEstatusTimbrado.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function SolicitudEstatusTimbrado.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

procedure SolicitudEstatusTimbrado.SetTransaccionOriginal(Index: Integer; const AInt64: Int64);
begin
  FTransaccionOriginal := AInt64;
  FTransaccionOriginal_Specified := True;
end;

function SolicitudEstatusTimbrado.TransaccionOriginal_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionOriginal_Specified;
end;

procedure SolicitudEstatusTimbrado.SetUUID(Index: Integer; const Astring: string);
begin
  FUUID := Astring;
  FUUID_Specified := True;
end;

function SolicitudEstatusTimbrado.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

procedure EFallaValidacionException.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function EFallaValidacionException.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure EFallaValidacionException.SetNodo(Index: Integer; const Astring: string);
begin
  FNodo := Astring;
  FNodo_Specified := True;
end;

function EFallaValidacionException.Nodo_Specified(Index: Integer): boolean;
begin
  Result := FNodo_Specified;
end;

procedure EFallaValidacionException.SetAntecedente(Index: Integer; const Astring: string);
begin
  FAntecedente := Astring;
  FAntecedente_Specified := True;
end;

function EFallaValidacionException.Antecedente_Specified(Index: Integer): boolean;
begin
  Result := FAntecedente_Specified;
end;

procedure EFallaValidacionException.SetSugerencia(Index: Integer; const Astring: string);
begin
  FSugerencia := Astring;
  FSugerencia_Specified := True;
end;

function EFallaValidacionException.Sugerencia_Specified(Index: Integer): boolean;
begin
  Result := FSugerencia_Specified;
end;

procedure EFallaValidacionException.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function EFallaValidacionException.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;

procedure FallaSesion.SetEstatus(Index: Integer; const AInteger: Integer);
begin
  FEstatus := AInteger;
  FEstatus_Specified := True;
end;

function FallaSesion.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure FallaSesion.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function FallaSesion.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure EFallaServicioException.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function EFallaServicioException.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure EFallaServicioException.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function EFallaServicioException.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;

constructor TEcodexRespuestaCancelacion.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexRespuestaCancelacion.SetCancelada(Index: Integer; const ABoolean: Boolean);
begin
  FCancelada := ABoolean;
  FCancelada_Specified := True;
end;

function TEcodexRespuestaCancelacion.Cancelada_Specified(Index: Integer): boolean;
begin
  Result := FCancelada_Specified;
end;

procedure TEcodexRespuestaCancelacion.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaCancelacion.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexSolicitudCancelacion.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexSolicitudCancelacion.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudCancelacion.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexSolicitudCancelacion.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexSolicitudCancelacion.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexSolicitudCancelacion.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudCancelacion.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

procedure TEcodexSolicitudCancelacion.SetUUID(Index: Integer; const Astring: string);
begin
  FUUID := Astring;
  FUUID_Specified := True;
end;

function TEcodexSolicitudCancelacion.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

initialization
  { IEcodexServicioTimbrado }
  InvRegistry.RegisterInterface(TypeInfo(IEcodexServicioTimbrado), 'http://Ecodex.WS.Model/2011/CFDI', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IEcodexServicioTimbrado), 'http://Ecodex.WS.Model/2011/CFDI/Timbrado/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioTimbrado), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioTimbrado), ioLiteral);
  RemClassRegistry.RegisterXSClass(InformacionQR2, 'http://Ecodex.WS.Model/2011/CFDI', 'InformacionQR2', 'InformacionQR');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TEcodexAdvertenciasDeValidacion), 'http://Ecodex.WS.Model/2011/CFDI', 'AdvertenciasValidacion');
  RemClassRegistry.RegisterXSClass(TEcodexComprobanteXML, 'http://Ecodex.WS.Model/2011/CFDI', 'ComprobanteXML2', 'ComprobanteXML');
  RemClassRegistry.RegisterXSClass(ComprobanteXML, 'http://Ecodex.WS.Model/2011/CFDI', 'ComprobanteXML');
  RemClassRegistry.RegisterXSClass(TEcodexAdvertenciaValidacion, 'http://Ecodex.WS.Model/2011/CFDI', 'AdvertenciaValidacion2', 'AdvertenciaValidacion');
  RemClassRegistry.RegisterXSClass(TSolicitudTimbradoEcodex, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudTimbraXML');
  RemClassRegistry.RegisterSerializeOptions(TSolicitudTimbradoEcodex, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexEstadoComprobante, 'http://Ecodex.WS.Model/2011/CFDI', 'ComprobanteEstatus2', 'ComprobanteEstatus');
  RemClassRegistry.RegisterXSClass(TEcodexFallaSesion, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaSesion2', 'FallaSesion');

  RemClassRegistry.RegisterXSClass(EFallaServicioException, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaServicio2', 'FallaServicio');
  //RemClassRegistry.RegisterXSClass(TEcodexFallaValidacion, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaValidacion2', 'FallaValidacion');
  RemClassRegistry.RegisterXSClass(EFallaValidacionException, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaValidacion2', 'FallaValidacion');

  RemClassRegistry.RegisterXSClass(TEcodexRespuestaTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaTimbraXML');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TEcodexRespuestaTimbrado), 'Advertencias', '[ArrayItemName="AdvertenciaValidacion"]');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(SolicitudObtenerTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudObtenerTimbrado');
  RemClassRegistry.RegisterSerializeOptions(SolicitudObtenerTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ComprobanteEstatus, 'http://Ecodex.WS.Model/2011/CFDI', 'ComprobanteEstatus');
  RemClassRegistry.RegisterXSClass(RespuestaEstatusTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaEstatusTimbrado');
  RemClassRegistry.RegisterSerializeOptions(RespuestaEstatusTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RespuestaObtenerTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaObtenerTimbrado');
  RemClassRegistry.RegisterSerializeOptions(RespuestaObtenerTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(InformacionQR, 'http://Ecodex.WS.Model/2011/CFDI', 'InformacionQR');
  RemClassRegistry.RegisterXSClass(RespuestaObtenerQRTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaObtenerQRTimbrado');
  RemClassRegistry.RegisterSerializeOptions(RespuestaObtenerQRTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(SolicitudObtenerQRTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudObtenerQRTimbrado');
  RemClassRegistry.RegisterSerializeOptions(SolicitudObtenerQRTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(SolicitudEstatusTimbrado, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudEstatusTimbrado');
  RemClassRegistry.RegisterSerializeOptions(SolicitudEstatusTimbrado, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(EFallaValidacionException, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaValidacion');
  RemClassRegistry.RegisterXSClass(FallaSesion, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaSesion');
  RemClassRegistry.RegisterXSClass(AdvertenciaValidacion, 'http://Ecodex.WS.Model/2011/CFDI', 'AdvertenciaValidacion');
  RemClassRegistry.RegisterXSClass(EFallaServicioException, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaServicio');
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaCancelacion, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaCancelaTimbrado');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaCancelacion, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudCancelacion, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudCancelaTimbrado');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudCancelacion, [xoLiteralParam]);
end.