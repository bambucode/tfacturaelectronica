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
// WSDL     : http://pruebas.ecodex.com.mx:2044/ServicioCancelacion.svc?wsdl
//  >Import : http://pruebas.ecodex.com.mx:2044/ServicioCancelacion.svc?wsdl>0
//  >Import : http://pruebas.ecodex.com.mx:2044/ServicioCancelacion.svc?xsd=xsd0
//  >Import : http://pruebas.ecodex.com.mx:2044/ServicioCancelacion.svc?xsd=xsd1
// Encoding : utf-8
// Codegen  : [wfServer+, wfOutputLiteralTypes+, wfMapStringsToWideStrings+, wfMapArraysToClasses+, wfGenTrueGUIDs+, wfAllowOutParameters+, wfUseSettersAndGetters+, wfUseXSTypeForSimpleNillable+, wfCreateArrayElemTypeAlias+]
// Version  : 1.0
// (28/07/2014 04:42:46 p.m. - - $Rev: 70145 $)
// ************************************************************************ //

unit EcodexWSCancelacion;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, ProveedorAutorizadoCertificacion;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TEcodexListaResultadoCancelacion2 = class;           { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexListaResultadoCancelacion = class;            { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexRespuestaCancelaMultiple = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexListaCancelar2       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexSolicitudCancelaOtros = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexRespuestaRecuperarAcuse = class;              { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexRespuestaCancelaOtros = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexSolicitudAcuse       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexFallaValidacion2     = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexSolicitudCancelaMultiple = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexListaCancelar        = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexResultadoCancelacion2 = class;                { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexResultadoCancelacion = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexFallaSesion2         = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexFallaServicio2       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }

  Array_Of_TEcodexResultadoCancelacion = array of TEcodexResultadoCancelacion2;   { "http://Ecodex.WS.Model/2011/CFDI"[GblUbnd] }


  // ************************************************************************ //
  // XML       : TEcodexListaResultadoCancelacion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexListaResultadoCancelacion2 = class(TRemotable)
  private
    FResultadoCancelacion: Array_Of_TEcodexResultadoCancelacion;
    FResultadoCancelacion_Specified: boolean;
    function  GetResultadoCancelacion(Index: Integer): Array_Of_TEcodexResultadoCancelacion;
    procedure SetResultadoCancelacion(Index: Integer; const AArray_Of_ResultadoCancelacion: Array_Of_TEcodexResultadoCancelacion);
    function  ResultadoCancelacion_Specified(Index: Integer): boolean;
  public
    //function   GetResultadoCancelacion2Array(Index: Integer): TEcodexResultadoCancelacion2;
    procedure  SetResultadoCancelacion2Array(Index: Integer; const Item: TEcodexResultadoCancelacion2);
    function   GetResultadoCancelacion2ArrayLength: Integer;
    procedure  SetResultadoCancelacion2ArrayLength(Len: Integer);

    //property   ResultadoCancelacion2Array[Index: Integer]: TEcodexResultadoCancelacion2 read GetResultadoCancelacion2Array write SetResultadoCancelacion2Array; default;
    property   Len: Integer read GetResultadoCancelacion2ArrayLength write SetResultadoCancelacion2ArrayLength;
  published
    property TEcodexResultadoCancelacion: Array_Of_TEcodexResultadoCancelacion  Index (IS_OPTN or IS_UNBD or IS_NLBL) read GetResultadoCancelacion write SetResultadoCancelacion stored ResultadoCancelacion_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexListaResultadoCancelacion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexListaResultadoCancelacion = class(TEcodexListaResultadoCancelacion2)
  private
  published
  end;


  // ************************************************************************ //
  // XML       : TEcodexRespuestaCancelaMultiple, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaCancelaMultiple = class(TRemotable)
  private
    FResultado: TEcodexListaResultadoCancelacion2;
    FResultado_Specified: boolean;
    FTransaccionID: TXSString;
    FTransaccionID_Specified: boolean;
    function  GetResultado(Index: Integer): TEcodexListaResultadoCancelacion2;
    procedure SetResultado(Index: Integer; const AListaResultadoCancelacion2: TEcodexListaResultadoCancelacion2);
    function  Resultado_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): TXSString;
    procedure SetTransaccionID(Index: Integer; const ATXSString: TXSString);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property Resultado:     TEcodexListaResultadoCancelacion2  Index (IS_OPTN or IS_NLBL) read GetResultado write SetResultado stored Resultado_Specified;
    property TransaccionID: TXSString                   Index (IS_OPTN or IS_NLBL) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;

  guid            =  type WideString;      { "http://schemas.microsoft.com/2003/10/Serialization/"[GblSmpl] }
  Array_Of_guid = array of guid;                { "http://schemas.microsoft.com/2003/10/Serialization/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : TEcodexListaCancelar, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexListaCancelar2 = class(TRemotable)
  private
    Fguid: Array_Of_guid;
    Fguid_Specified: boolean;
    function  Getguid(Index: Integer): Array_Of_guid;
    procedure Setguid(Index: Integer; const AArray_Of_guid: Array_Of_guid);
    function  guid_Specified(Index: Integer): boolean;
  public
    function   GetguidArray(Index: Integer): guid;
    procedure  SetguidArray(Index: Integer; const Item: guid);
    function   GetguidArrayLength: Integer;
    procedure  SetguidArrayLength(Len: Integer);

    property   guidArray[Index: Integer]: guid read GetguidArray write SetguidArray; default;
    property   Len: Integer read GetguidArrayLength write SetguidArrayLength;
  published
    property guid: Array_Of_guid  Index (IS_OPTN or IS_UNBD) read Getguid write Setguid stored guid_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudCancelaOtros, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudCancelaOtros = class(TRemotable)
  private
    FRFCEmisor: TXSString;
    FRFCEmisor_Specified: boolean;
    FRFCReceptor: TXSString;
    FRFCReceptor_Specified: boolean;
    FToken: TXSString;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FUUID: guid;
    FUUID_Specified: boolean;
    function  GetRFCEmisor(Index: Integer): TXSString;
    procedure SetRFCEmisor(Index: Integer; const ATXSString: TXSString);
    function  RFCEmisor_Specified(Index: Integer): boolean;
    function  GetRFCReceptor(Index: Integer): TXSString;
    procedure SetRFCReceptor(Index: Integer; const ATXSString: TXSString);
    function  RFCReceptor_Specified(Index: Integer): boolean;
    function  GetToken(Index: Integer): TXSString;
    procedure SetToken(Index: Integer; const ATXSString: TXSString);
    function  Token_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): Int64;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    function  GetUUID(Index: Integer): guid;
    procedure SetUUID(Index: Integer; const Aguid: guid);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFCEmisor:     TXSString  Index (IS_OPTN or IS_NLBL) read GetRFCEmisor write SetRFCEmisor stored RFCEmisor_Specified;
    property RFCReceptor:   TXSString  Index (IS_OPTN or IS_NLBL) read GetRFCReceptor write SetRFCReceptor stored RFCReceptor_Specified;
    property Token:         TXSString  Index (IS_OPTN or IS_NLBL) read GetToken write SetToken stored Token_Specified;
    property TransaccionID: Int64      Index (IS_OPTN) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property UUID:          guid       Index (IS_OPTN) read GetUUID write SetUUID stored UUID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaRecuperarAcuse, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaRecuperarAcuse = class(TRemotable)
  private
    FAcuseXML: String;
    FAcuseXML_Specified: boolean;
    FEstatus: String;
    FEstatus_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    function GetAcuseXML(Index: Integer): String;
    procedure SetAcuseXML(Index: Integer; const AsString: String);
    function  AcuseXML_Specified(Index: Integer): boolean;
    function GetEstatus(Index: Integer): String;
    procedure SetEstatus(Index: Integer; const ATXSString: String);
    function  Estatus_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): Int64;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property AcuseXML: String index (IS_OPTN or IS_NLBL) read GetAcuseXML write
        SetAcuseXML stored AcuseXML_Specified;
    property Estatus: String index (IS_OPTN or IS_NLBL) read GetEstatus write
        SetEstatus stored Estatus_Specified;
    property TransaccionID: Int64      Index (IS_OPTN) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaCancelaOtros, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaCancelaOtros = class(TRemotable)
  private
    FResultado: TEcodexListaResultadoCancelacion2;
    FResultado_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    function  GetResultado(Index: Integer): TEcodexListaResultadoCancelacion2;
    procedure SetResultado(Index: Integer; const AListaResultadoCancelacion2: TEcodexListaResultadoCancelacion2);
    function  Resultado_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): Int64;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property Resultado:     TEcodexListaResultadoCancelacion2  Index (IS_OPTN or IS_NLBL) read GetResultado write SetResultado stored Resultado_Specified;
    property TransaccionID: Int64                       Index (IS_OPTN) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudAcuse, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudAcuse = class(TRemotable)
  private
    FRFC: String;
    FRFC_Specified: boolean;
    FToken: String;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    FUUID: guid;
    FUUID_Specified: boolean;
    function GetRFC(Index: Integer): string;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    function GetToken(Index: Integer): string;
    procedure SetToken(Index: Integer; const ATXSString: string);
    function  Token_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): Int64;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
    function GetUUID(Index: Integer): string;
    procedure SetUUID(Index: Integer; const Aguid: string);
    function  UUID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC: string index (IS_OPTN or IS_NLBL) read GetRFC write SetRFC stored
        RFC_Specified;
    property Token: string index (IS_OPTN or IS_NLBL) read GetToken write SetToken
        stored Token_Specified;
    property TransaccionID: Int64      Index (IS_OPTN) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
    property UUID: string index (IS_OPTN) read GetUUID write SetUUID stored
        UUID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexFallaValidacion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexFallaValidacion2 = class(TRemotable)
  private
    FRFC: TXSString;
    FNumero: Integer;
    FDescripcion: TXSString;
    FDescripcion_Specified: boolean;
    FNodo: TXSString;
    FNodo_Specified: boolean;
    FAntecedente: TXSString;
    FAntecedente_Specified: boolean;
    FSugerencia: TXSString;
    FSugerencia_Specified: boolean;
    FEvento: TXSString;
    FEvento_Specified: boolean;
    function  GetRFC(Index: Integer): TXSString;
    procedure SetRFC(Index: Integer; const ATXSString: TXSString);
    function  GetNumero: Integer;
    procedure SetNumero(const AInteger: Integer);
    function  GetDescripcion(Index: Integer): TXSString;
    procedure SetDescripcion(Index: Integer; const ATXSString: TXSString);
    function  Descripcion_Specified(Index: Integer): boolean;
    function  GetNodo(Index: Integer): TXSString;
    procedure SetNodo(Index: Integer; const ATXSString: TXSString);
    function  Nodo_Specified(Index: Integer): boolean;
    function  GetAntecedente(Index: Integer): TXSString;
    procedure SetAntecedente(Index: Integer; const ATXSString: TXSString);
    function  Antecedente_Specified(Index: Integer): boolean;
    function  GetSugerencia(Index: Integer): TXSString;
    procedure SetSugerencia(Index: Integer; const ATXSString: TXSString);
    function  Sugerencia_Specified(Index: Integer): boolean;
    function  GetEvento(Index: Integer): TXSString;
    procedure SetEvento(Index: Integer; const ATXSString: TXSString);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         TXSString  Index (IS_NLBL) read GetRFC write SetRFC;
    property Numero:      Integer    read GetNumero write SetNumero;
    property Descripcion: TXSString  Index (IS_OPTN or IS_NLBL) read GetDescripcion write SetDescripcion stored Descripcion_Specified;
    property Nodo:        TXSString  Index (IS_OPTN or IS_NLBL) read GetNodo write SetNodo stored Nodo_Specified;
    property Antecedente: TXSString  Index (IS_OPTN or IS_NLBL) read GetAntecedente write SetAntecedente stored Antecedente_Specified;
    property Sugerencia:  TXSString  Index (IS_OPTN or IS_NLBL) read GetSugerencia write SetSugerencia stored Sugerencia_Specified;
    property Evento:      TXSString  Index (IS_OPTN or IS_NLBL) read GetEvento write SetEvento stored Evento_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudCancelaMultiple, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudCancelaMultiple = class(TRemotable)
  private
    FListaCancelar: TEcodexListaCancelar2;
    FListaCancelar_Specified: boolean;
    FRFC: TXSString;
    FRFC_Specified: boolean;
    FToken: TXSString;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    function  GetListaCancelar(Index: Integer): TEcodexListaCancelar2;
    procedure SetListaCancelar(Index: Integer; const AListaCancelar2: TEcodexListaCancelar2);
    function  ListaCancelar_Specified(Index: Integer): boolean;
    function  GetRFC(Index: Integer): TXSString;
    procedure SetRFC(Index: Integer; const ATXSString: TXSString);
    function  RFC_Specified(Index: Integer): boolean;
    function  GetToken(Index: Integer): TXSString;
    procedure SetToken(Index: Integer; const ATXSString: TXSString);
    function  Token_Specified(Index: Integer): boolean;
    function  GetTransaccionID(Index: Integer): Int64;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property TEcodexListaCancelar: TEcodexListaCancelar2  Index (IS_OPTN or IS_NLBL) read GetListaCancelar write SetListaCancelar stored ListaCancelar_Specified;
    property RFC:           TXSString       Index (IS_OPTN or IS_NLBL) read GetRFC write SetRFC stored RFC_Specified;
    property Token:         TXSString       Index (IS_OPTN or IS_NLBL) read GetToken write SetToken stored Token_Specified;
    property TransaccionID: Int64           Index (IS_OPTN) read GetTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexListaCancelar, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexListaCancelar = class(TEcodexListaCancelar2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : TEcodexResultadoCancelacion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexResultadoCancelacion2 = class(TRemotable)
  private
    FUUID: guid;
    FUUID_Specified: boolean;
    FEstatus: TXSString;
    FEstatus_Specified: boolean;
    function  GetUUID(Index: Integer): guid;
    procedure SetUUID(Index: Integer; const Aguid: guid);
    function  UUID_Specified(Index: Integer): boolean;
    function  GetEstatus(Index: Integer): TXSString;
    procedure SetEstatus(Index: Integer; const ATXSString: TXSString);
    function  Estatus_Specified(Index: Integer): boolean;
  published
    property UUID:    guid       Index (IS_OPTN) read GetUUID write SetUUID stored UUID_Specified;
    property Estatus: TXSString  Index (IS_OPTN or IS_NLBL) read GetEstatus write SetEstatus stored Estatus_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexResultadoCancelacion, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexResultadoCancelacion = class(TEcodexResultadoCancelacion2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : TEcodexFallaSesion, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexFallaSesion2 = class(TRemotable)
  private
    FRFC: TXSString;
    FEstatus: Integer;
    FEstatus_Specified: boolean;
    FDescripcion: TXSString;
    FDescripcion_Specified: boolean;
    function  GetRFC(Index: Integer): TXSString;
    procedure SetRFC(Index: Integer; const ATXSString: TXSString);
    function  GetEstatus(Index: Integer): Integer;
    procedure SetEstatus(Index: Integer; const AInteger: Integer);
    function  Estatus_Specified(Index: Integer): boolean;
    function  GetDescripcion(Index: Integer): TXSString;
    procedure SetDescripcion(Index: Integer; const ATXSString: TXSString);
    function  Descripcion_Specified(Index: Integer): boolean;
  published
    property RFC:         TXSString  Index (IS_NLBL) read GetRFC write SetRFC;
    property Estatus:     Integer    Index (IS_OPTN) read GetEstatus write SetEstatus stored Estatus_Specified;
    property Descripcion: TXSString  Index (IS_OPTN or IS_NLBL) read GetDescripcion write SetDescripcion stored Descripcion_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexFallaServicio, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexFallaServicio2 = class(TRemotable)
  private
    FRFC: TXSString;
    FNumero: Integer;
    FDescripcion: TXSString;
    FDescripcion_Specified: boolean;
    FEvento: TXSString;
    FEvento_Specified: boolean;
    function  GetRFC(Index: Integer): TXSString;
    procedure SetRFC(Index: Integer; const ATXSString: TXSString);
    function  GetNumero: Integer;
    procedure SetNumero(const AInteger: Integer);
    function  GetDescripcion(Index: Integer): TXSString;
    procedure SetDescripcion(Index: Integer; const ATXSString: TXSString);
    function  Descripcion_Specified(Index: Integer): boolean;
    function  GetEvento(Index: Integer): TXSString;
    procedure SetEvento(Index: Integer; const ATXSString: TXSString);
    function  Evento_Specified(Index: Integer): boolean;
  published
    property RFC:         TXSString  Index (IS_NLBL) read GetRFC write SetRFC;
    property Numero:      Integer    read GetNumero write SetNumero;
    property Descripcion: TXSString  Index (IS_OPTN or IS_NLBL) read GetDescripcion write SetDescripcion stored Descripcion_Specified;
    property Evento:      TXSString  Index (IS_OPTN or IS_NLBL) read GetEvento write SetEvento stored Evento_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // soapAction: http://Ecodex.WS.Model/2011/CFDI/Cancelaciones/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : PuertoCancelacionSeguro
  // service   : Cancelaciones
  // port      : PuertoCancelacionSeguro
  // URL       : https://servicios.ecodex.com.mx:4043/ServicioCancelacion.svc
  // ************************************************************************ //
  IEcodexServicioCancelacion = interface(IInvokable)
  ['{8AB4AE9F-51DB-4517-AA39-D5E69D8F083A}']

    // Cannot unwrap:
    //     - Input element wrapper name does not match operation's name
    function  CancelaMultiple(const parameters: TEcodexSolicitudCancelaMultiple): TEcodexRespuestaCancelaMultiple; stdcall;

    // Cannot unwrap:
    //     - Input element wrapper name does not match operation's name
    function  RecuperarAcuses(const parameters: TEcodexSolicitudAcuse): TEcodexRespuestaRecuperarAcuse; stdcall;

    // Cannot unwrap:
    //     - Input element wrapper name does not match operation's name
    function  CancelaOtros(const parameters: TEcodexSolicitudCancelaOtros): TEcodexRespuestaCancelaOtros; stdcall;
  end;

  function GetEcodexWSCancelacion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IEcodexServicioCancelacion;
  function GetUltimoXMLEnviadoEcodexWsCancelacion: string;
  function GetUltimoXMLRecibidoEcodexWsCancelacion: string;

implementation

uses SysUtils, uWSHelper, EcodexWsComun;

var
  wsHelper: TWSHelper;

function GetEcodexWSCancelacion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IEcodexServicioCancelacion;
const
  defWSDL = 'https://servicios.ecodex.com.mx:4043/ServicioCancelacion.svc?wsdl';
  defURL  = 'https://servicios.ecodex.com.mx:4043/ServicioCancelacion.svc';
  defSvc  = 'IEcodexServicioCancelacion';
  defPrt  = 'PuertoCancelacionSeguro';
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

  // Configuramos uso de UTF8 (Probablemente solo para Delphi 2010 y menores)
  //RIO.HTTPWebNode.UseUTF8InHeader := True;
  RIO.OnBeforeExecute := wsHelper.BeforeExecute;
  RIO.OnAfterExecute := wsHelper.AfterExecute;

  try
    Result := (RIO as IEcodexServicioCancelacion);
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

function GetUltimoXMLEnviadoEcodexWsCancelacion: string;
begin
  Result := '';

  if wsHelper <> nil then
    Result := wsHelper.UltimoXMLEnviado;
end;

function GetUltimoXMLRecibidoEcodexWsCancelacion: string;
begin
  Result := '';

  if wsHelper <> nil then
    Result := wsHelper.UltimoXMLRecibido;
end;

procedure TEcodexListaResultadoCancelacion2.SetResultadoCancelacion2Array(Index: Integer; const Item: TEcodexResultadoCancelacion2);
begin
   FResultadoCancelacion[Index] := Item;
end;

function TEcodexListaResultadoCancelacion2.GetResultadoCancelacion2ArrayLength: Integer;
begin
  if Assigned(FResultadoCancelacion) then
    Result := System.Length(FResultadoCancelacion)
  else
    Result := 0;
end;

procedure TEcodexListaResultadoCancelacion2.SetResultadoCancelacion2ArrayLength(Len: Integer);
begin
  System.SetLength(FResultadoCancelacion, Len);
end;

function TEcodexListaResultadoCancelacion2.GetResultadoCancelacion(Index: Integer): Array_Of_TEcodexResultadoCancelacion;
begin
  Result := FResultadoCancelacion;
end;

procedure TEcodexListaResultadoCancelacion2.SetResultadoCancelacion(Index: Integer; const AArray_Of_ResultadoCancelacion: Array_Of_TEcodexResultadoCancelacion);
begin
  FResultadoCancelacion := AArray_Of_ResultadoCancelacion;
  FResultadoCancelacion_Specified := True;
end;

function TEcodexListaResultadoCancelacion2.ResultadoCancelacion_Specified(Index: Integer): boolean;
begin
  Result := FResultadoCancelacion_Specified;
end;

constructor TEcodexRespuestaCancelaMultiple.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexRespuestaCancelaMultiple.GetResultado(Index: Integer): TEcodexListaResultadoCancelacion2;
begin
  Result := FResultado;
end;

procedure TEcodexRespuestaCancelaMultiple.SetResultado(Index: Integer; const AListaResultadoCancelacion2: TEcodexListaResultadoCancelacion2);
begin
  FResultado := AListaResultadoCancelacion2;
  FResultado_Specified := True;
end;

function TEcodexRespuestaCancelaMultiple.Resultado_Specified(Index: Integer): boolean;
begin
  Result := FResultado_Specified;
end;

function TEcodexRespuestaCancelaMultiple.GetTransaccionID(Index: Integer): TXSString;
begin
  Result := FTransaccionID;
end;

procedure TEcodexRespuestaCancelaMultiple.SetTransaccionID(Index: Integer; const ATXSString: TXSString);
begin
  FTransaccionID := ATXSString;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaCancelaMultiple.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

function TEcodexListaCancelar2.GetguidArray(Index: Integer): guid;
begin
  Result := Fguid[Index];
end;

procedure TEcodexListaCancelar2.SetguidArray(Index: Integer; const Item: guid);
begin
   Fguid[Index] := Item;
end;

function TEcodexListaCancelar2.GetguidArrayLength: Integer;
begin
  if Assigned(Fguid) then
    Result := System.Length(Fguid)
  else
    Result := 0;
end;

procedure TEcodexListaCancelar2.SetguidArrayLength(Len: Integer);
begin
  System.SetLength(Fguid, Len);
end;

function TEcodexListaCancelar2.Getguid(Index: Integer): Array_Of_guid;
begin
  Result := Fguid;
end;

procedure TEcodexListaCancelar2.Setguid(Index: Integer; const AArray_Of_guid: Array_Of_guid);
begin
  Fguid := AArray_Of_guid;
  Fguid_Specified := True;
end;

function TEcodexListaCancelar2.guid_Specified(Index: Integer): boolean;
begin
  Result := Fguid_Specified;
end;

constructor TEcodexSolicitudCancelaOtros.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexSolicitudCancelaOtros.GetRFCEmisor(Index: Integer): TXSString;
begin
  Result := FRFCEmisor;
end;

procedure TEcodexSolicitudCancelaOtros.SetRFCEmisor(Index: Integer; const ATXSString: TXSString);
begin
  FRFCEmisor := ATXSString;
  FRFCEmisor_Specified := True;
end;

function TEcodexSolicitudCancelaOtros.RFCEmisor_Specified(Index: Integer): boolean;
begin
  Result := FRFCEmisor_Specified;
end;

function TEcodexSolicitudCancelaOtros.GetRFCReceptor(Index: Integer): TXSString;
begin
  Result := FRFCReceptor;
end;

procedure TEcodexSolicitudCancelaOtros.SetRFCReceptor(Index: Integer; const ATXSString: TXSString);
begin
  FRFCReceptor := ATXSString;
  FRFCReceptor_Specified := True;
end;

function TEcodexSolicitudCancelaOtros.RFCReceptor_Specified(Index: Integer): boolean;
begin
  Result := FRFCReceptor_Specified;
end;

function TEcodexSolicitudCancelaOtros.GetToken(Index: Integer): TXSString;
begin
  Result := FToken;
end;

procedure TEcodexSolicitudCancelaOtros.SetToken(Index: Integer; const ATXSString: TXSString);
begin
  FToken := ATXSString;
  FToken_Specified := True;
end;

function TEcodexSolicitudCancelaOtros.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

function TEcodexSolicitudCancelaOtros.GetTransaccionID(Index: Integer): Int64;
begin
  Result := FTransaccionID;
end;

procedure TEcodexSolicitudCancelaOtros.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudCancelaOtros.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

function TEcodexSolicitudCancelaOtros.GetUUID(Index: Integer): guid;
begin
  Result := FUUID;
end;

procedure TEcodexSolicitudCancelaOtros.SetUUID(Index: Integer; const Aguid: guid);
begin
  FUUID := Aguid;
  FUUID_Specified := True;
end;

function TEcodexSolicitudCancelaOtros.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

constructor TEcodexRespuestaRecuperarAcuse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexRespuestaRecuperarAcuse.GetAcuseXML(Index: Integer): String;
begin
  Result := FAcuseXML;
end;

procedure TEcodexRespuestaRecuperarAcuse.SetAcuseXML(Index: Integer; const
    AsString: String);
begin
  FAcuseXML := AsString;
  FAcuseXML_Specified := True;
end;

function TEcodexRespuestaRecuperarAcuse.AcuseXML_Specified(Index: Integer): boolean;
begin
  Result := FAcuseXML_Specified;
end;

function TEcodexRespuestaRecuperarAcuse.GetEstatus(Index: Integer): String;
begin
  Result := FEstatus;
end;

procedure TEcodexRespuestaRecuperarAcuse.SetEstatus(Index: Integer; const
    ATXSString: String);
begin
  FEstatus := ATXSString;
  FEstatus_Specified := True;
end;

function TEcodexRespuestaRecuperarAcuse.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

function TEcodexRespuestaRecuperarAcuse.GetTransaccionID(Index: Integer): Int64;
begin
  Result := FTransaccionID;
end;

procedure TEcodexRespuestaRecuperarAcuse.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaRecuperarAcuse.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexRespuestaCancelaOtros.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexRespuestaCancelaOtros.GetResultado(Index: Integer): TEcodexListaResultadoCancelacion2;
begin
  Result := FResultado;
end;

procedure TEcodexRespuestaCancelaOtros.SetResultado(Index: Integer; const AListaResultadoCancelacion2: TEcodexListaResultadoCancelacion2);
begin
  FResultado := AListaResultadoCancelacion2;
  FResultado_Specified := True;
end;

function TEcodexRespuestaCancelaOtros.Resultado_Specified(Index: Integer): boolean;
begin
  Result := FResultado_Specified;
end;

function TEcodexRespuestaCancelaOtros.GetTransaccionID(Index: Integer): Int64;
begin
  Result := FTransaccionID;
end;

procedure TEcodexRespuestaCancelaOtros.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaCancelaOtros.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexSolicitudAcuse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexSolicitudAcuse.GetRFC(Index: Integer): string;
begin
  Result := FRFC;
end;

procedure TEcodexSolicitudAcuse.SetRFC(Index: Integer; const Astring:
    string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudAcuse.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

function TEcodexSolicitudAcuse.GetToken(Index: Integer): string;
begin
  Result := FToken;
end;

procedure TEcodexSolicitudAcuse.SetToken(Index: Integer; const ATXSString:
    string);
begin
  FToken := ATXSString;
  FToken_Specified := True;
end;

function TEcodexSolicitudAcuse.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

function TEcodexSolicitudAcuse.GetTransaccionID(Index: Integer): Int64;
begin
  Result := FTransaccionID;
end;

procedure TEcodexSolicitudAcuse.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudAcuse.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

function TEcodexSolicitudAcuse.GetUUID(Index: Integer): string;
begin
  Result := FUUID;
end;

procedure TEcodexSolicitudAcuse.SetUUID(Index: Integer; const Aguid: string);
begin
  FUUID := Aguid;
  FUUID_Specified := True;
end;

function TEcodexSolicitudAcuse.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

function TEcodexFallaValidacion2.GetRFC(Index: Integer): TXSString;
begin
  Result := FRFC;
end;

procedure TEcodexFallaValidacion2.SetRFC(Index: Integer; const ATXSString: TXSString);
begin
  FRFC := ATXSString;
end;

function TEcodexFallaValidacion2.GetNumero: Integer;
begin
  Result := FNumero;
end;

procedure TEcodexFallaValidacion2.SetNumero(const AInteger: Integer);
begin
  FNumero := AInteger;
end;

function TEcodexFallaValidacion2.GetDescripcion(Index: Integer): TXSString;
begin
  Result := FDescripcion;
end;

procedure TEcodexFallaValidacion2.SetDescripcion(Index: Integer; const ATXSString: TXSString);
begin
  FDescripcion := ATXSString;
  FDescripcion_Specified := True;
end;

function TEcodexFallaValidacion2.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

function TEcodexFallaValidacion2.GetNodo(Index: Integer): TXSString;
begin
  Result := FNodo;
end;

procedure TEcodexFallaValidacion2.SetNodo(Index: Integer; const ATXSString: TXSString);
begin
  FNodo := ATXSString;
  FNodo_Specified := True;
end;

function TEcodexFallaValidacion2.Nodo_Specified(Index: Integer): boolean;
begin
  Result := FNodo_Specified;
end;

function TEcodexFallaValidacion2.GetAntecedente(Index: Integer): TXSString;
begin
  Result := FAntecedente;
end;

procedure TEcodexFallaValidacion2.SetAntecedente(Index: Integer; const ATXSString: TXSString);
begin
  FAntecedente := ATXSString;
  FAntecedente_Specified := True;
end;

function TEcodexFallaValidacion2.Antecedente_Specified(Index: Integer): boolean;
begin
  Result := FAntecedente_Specified;
end;

function TEcodexFallaValidacion2.GetSugerencia(Index: Integer): TXSString;
begin
  Result := FSugerencia;
end;

procedure TEcodexFallaValidacion2.SetSugerencia(Index: Integer; const ATXSString: TXSString);
begin
  FSugerencia := ATXSString;
  FSugerencia_Specified := True;
end;

function TEcodexFallaValidacion2.Sugerencia_Specified(Index: Integer): boolean;
begin
  Result := FSugerencia_Specified;
end;

function TEcodexFallaValidacion2.GetEvento(Index: Integer): TXSString;
begin
  Result := FEvento;
end;

procedure TEcodexFallaValidacion2.SetEvento(Index: Integer; const ATXSString: TXSString);
begin
  FEvento := ATXSString;
  FEvento_Specified := True;
end;

function TEcodexFallaValidacion2.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;

constructor TEcodexSolicitudCancelaMultiple.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

function TEcodexSolicitudCancelaMultiple.GetListaCancelar(Index: Integer): TEcodexListaCancelar2;
begin
  Result := FListaCancelar;
end;

procedure TEcodexSolicitudCancelaMultiple.SetListaCancelar(Index: Integer; const AListaCancelar2: TEcodexListaCancelar2);
begin
  FListaCancelar := AListaCancelar2;
  FListaCancelar_Specified := True;
end;

function TEcodexSolicitudCancelaMultiple.ListaCancelar_Specified(Index: Integer): boolean;
begin
  Result := FListaCancelar_Specified;
end;

function TEcodexSolicitudCancelaMultiple.GetRFC(Index: Integer): TXSString;
begin
  Result := FRFC;
end;

procedure TEcodexSolicitudCancelaMultiple.SetRFC(Index: Integer; const ATXSString: TXSString);
begin
  FRFC := ATXSString;
  FRFC_Specified := True;
end;

function TEcodexSolicitudCancelaMultiple.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

function TEcodexSolicitudCancelaMultiple.GetToken(Index: Integer): TXSString;
begin
  Result := FToken;
end;

procedure TEcodexSolicitudCancelaMultiple.SetToken(Index: Integer; const ATXSString: TXSString);
begin
  FToken := ATXSString;
  FToken_Specified := True;
end;

function TEcodexSolicitudCancelaMultiple.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

function TEcodexSolicitudCancelaMultiple.GetTransaccionID(Index: Integer): Int64;
begin
  Result := FTransaccionID;
end;

procedure TEcodexSolicitudCancelaMultiple.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudCancelaMultiple.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

function TEcodexResultadoCancelacion2.GetUUID(Index: Integer): guid;
begin
  Result := FUUID;
end;

procedure TEcodexResultadoCancelacion2.SetUUID(Index: Integer; const Aguid: guid);
begin
  FUUID := Aguid;
  FUUID_Specified := True;
end;

function TEcodexResultadoCancelacion2.UUID_Specified(Index: Integer): boolean;
begin
  Result := FUUID_Specified;
end;

function TEcodexResultadoCancelacion2.GetEstatus(Index: Integer): TXSString;
begin
  Result := FEstatus;
end;

procedure TEcodexResultadoCancelacion2.SetEstatus(Index: Integer; const ATXSString: TXSString);
begin
  FEstatus := ATXSString;
  FEstatus_Specified := True;
end;

function TEcodexResultadoCancelacion2.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

function TEcodexFallaSesion2.GetRFC(Index: Integer): TXSString;
begin
  Result := FRFC;
end;

procedure TEcodexFallaSesion2.SetRFC(Index: Integer; const ATXSString: TXSString);
begin
  FRFC := ATXSString;
end;

function TEcodexFallaSesion2.GetEstatus(Index: Integer): Integer;
begin
  Result := FEstatus;
end;

procedure TEcodexFallaSesion2.SetEstatus(Index: Integer; const AInteger: Integer);
begin
  FEstatus := AInteger;
  FEstatus_Specified := True;
end;

function TEcodexFallaSesion2.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

function TEcodexFallaSesion2.GetDescripcion(Index: Integer): TXSString;
begin
  Result := FDescripcion;
end;

procedure TEcodexFallaSesion2.SetDescripcion(Index: Integer; const ATXSString: TXSString);
begin
  FDescripcion := ATXSString;
  FDescripcion_Specified := True;
end;

function TEcodexFallaSesion2.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

function TEcodexFallaServicio2.GetRFC(Index: Integer): TXSString;
begin
  Result := FRFC;
end;

procedure TEcodexFallaServicio2.SetRFC(Index: Integer; const ATXSString: TXSString);
begin
  FRFC := ATXSString;
end;

function TEcodexFallaServicio2.GetNumero: Integer;
begin
  Result := FNumero;
end;

procedure TEcodexFallaServicio2.SetNumero(const AInteger: Integer);
begin
  FNumero := AInteger;
end;

function TEcodexFallaServicio2.GetDescripcion(Index: Integer): TXSString;
begin
  Result := FDescripcion;
end;

procedure TEcodexFallaServicio2.SetDescripcion(Index: Integer; const ATXSString: TXSString);
begin
  FDescripcion := ATXSString;
  FDescripcion_Specified := True;
end;

function TEcodexFallaServicio2.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

function TEcodexFallaServicio2.GetEvento(Index: Integer): TXSString;
begin
  Result := FEvento;
end;

procedure TEcodexFallaServicio2.SetEvento(Index: Integer; const ATXSString: TXSString);
begin
  FEvento := ATXSString;
  FEvento_Specified := True;
end;

function TEcodexFallaServicio2.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;

initialization
  { IEcodexServicioCancelacion }
  InvRegistry.RegisterInterface(TypeInfo(IEcodexServicioCancelacion), 'http://Ecodex.WS.Model/2011/CFDI', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IEcodexServicioCancelacion), 'http://Ecodex.WS.Model/2011/CFDI/Cancelaciones/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioCancelacion), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioCancelacion), ioLiteral);

  InvRegistry.RegisterException(TypeInfo(IEcodexServicioCancelacion), EEcodexFallaSesionException);
  InvRegistry.RegisterException(TypeInfo(IEcodexServicioCancelacion), EEcodexFallaServicioException);
  InvRegistry.RegisterException(TypeInfo(IEcodexServicioCancelacion), EEcodexFallaValidacionException);
  InvRegistry.RegisterExceptionMethod(TypeInfo(IEcodexServicioCancelacion), EEcodexFallaValidacionException, 'RecuperarAcuses');
  InvRegistry.RegisterExceptionMethod(TypeInfo(IEcodexServicioCancelacion), EEcodexFallaValidacionException, 'CancelaOtros');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_TEcodexResultadoCancelacion), 'http://Ecodex.WS.Model/2011/CFDI', 'Array_Of_TEcodexResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(TEcodexListaResultadoCancelacion2, 'http://Ecodex.WS.Model/2011/CFDI', 'ListaResultadoCancelacion2', 'ListaResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(TEcodexListaResultadoCancelacion, 'http://Ecodex.WS.Model/2011/CFDI', 'ListaResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaCancelaMultiple, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaCancelaMultiple');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaCancelaMultiple, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(guid), 'http://schemas.microsoft.com/2003/10/Serialization/', 'guid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_guid), 'http://schemas.microsoft.com/2003/10/Serialization/', 'Array_Of_guid');
  RemClassRegistry.RegisterXSClass(TEcodexListaCancelar2, 'http://Ecodex.WS.Model/2011/CFDI', 'ListaCancelar2', 'ListaCancelar');
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudCancelaOtros, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudCancelaOtros');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudCancelaOtros, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaRecuperarAcuse, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaRecuperarAcuse');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaRecuperarAcuse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaCancelaOtros, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaCancelaOtros');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaCancelaOtros, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudAcuse, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudAcuse');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudAcuse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexFallaValidacion2, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaValidacion2', 'FallaValidacion');
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudCancelaMultiple, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudCancelaMultiple');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudCancelaMultiple, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexListaCancelar, 'http://Ecodex.WS.Model/2011/CFDI', 'ListaCancelar');
  RemClassRegistry.RegisterXSClass(TEcodexResultadoCancelacion2, 'http://Ecodex.WS.Model/2011/CFDI', 'ResultadoCancelacion2', 'ResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(TEcodexResultadoCancelacion, 'http://Ecodex.WS.Model/2011/CFDI', 'ResultadoCancelacion');
  RemClassRegistry.RegisterXSClass(TEcodexFallaSesion2, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaSesion2', 'FallaSesion');
  RemClassRegistry.RegisterXSClass(TEcodexFallaServicio2, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaServicio2', 'FallaServicio');

  wsHelper := TWSHelper.Create;
finalization
  if Assigned(wsHelper) then
    wsHelper.Free;
end.
