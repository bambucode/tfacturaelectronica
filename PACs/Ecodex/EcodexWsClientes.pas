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
// WSDL     : https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?wsdl
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?wsdl>0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?xsd=xsd0
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?xsd=xsd2
//  >Import : https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// (22/11/2013 01:56:34 p.m. - - $Rev: 45757 $)
// ************************************************************************ //

unit EcodexWsClientes;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TEcodexResultadoRegistroEmisor = class;             { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexNuevoEmisor          = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  Aviso2               = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexCuentaEstatus       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexSolicitudAvisosNuevos = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexRespuestaRegistro    = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  AltaEmisor           = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexSolicitudRegistroCliente = class;             { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  ResultadoRegistroEmisor = class;              { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexRespuestaAsignacionTimbres = class;           { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexSolicitudAsignacionTimbres = class;           { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  Aviso                = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexRespuestaAvisosNuevos = class;                { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  CuentaEstatus        = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblElm] }
  TEcodexRespuestaEstatusCuenta = class;               { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }
  TEcodexSolicitudEstatusCuenta = class;               { "http://Ecodex.WS.Model/2011/CFDI"[Lit][GblElm] }

  Avisos     = array of Aviso2;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }


  // ************************************************************************ //
  // XML       : ResultadoRegistroEmisor, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexResultadoRegistroEmisor = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FEstatus: string;
    FEstatus_Specified: boolean;
    FClaveCertificado: string;
    FClaveCertificado_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetEstatus(Index: Integer; const Astring: string);
    function  Estatus_Specified(Index: Integer): boolean;
    procedure SetClaveCertificado(Index: Integer; const Astring: string);
    function  ClaveCertificado_Specified(Index: Integer): boolean;
  published
    property RFC:              string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Estatus:          string  Index (IS_OPTN or IS_NLBL) read FEstatus write SetEstatus stored Estatus_Specified;
    property ClaveCertificado: string  Index (IS_OPTN or IS_NLBL) read FClaveCertificado write SetClaveCertificado stored ClaveCertificado_Specified;
  end;



  // ************************************************************************ //
  // XML       : AltaEmisor, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexNuevoEmisor = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FRazonSocial: string;
    FRazonSocial_Specified: boolean;
    FCorreoElectronico: string;
    FCorreoElectronico_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetRazonSocial(Index: Integer; const Astring: string);
    function  RazonSocial_Specified(Index: Integer): boolean;
    procedure SetCorreoElectronico(Index: Integer; const Astring: string);
    function  CorreoElectronico_Specified(Index: Integer): boolean;
  published
    property RFC:               string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property RazonSocial:       string  Index (IS_OPTN or IS_NLBL) read FRazonSocial write SetRazonSocial stored RazonSocial_Specified;
    property CorreoElectronico: string  Index (IS_OPTN or IS_NLBL) read FCorreoElectronico write SetCorreoElectronico stored CorreoElectronico_Specified;
  end;

  ArrayOfstring = array of string;              { "http://schemas.microsoft.com/2003/10/Serialization/Arrays"[GblCplx] }

  // ************************************************************************ //
  // XML       : Aviso, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  Aviso2 = class(TRemotable)
  private
    FVigencia: TXSDateTime;
    FVigencia_Specified: boolean;
    FMensaje: string;
    procedure SetVigencia(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  Vigencia_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Vigencia: TXSDateTime  Index (IS_OPTN) read FVigencia write SetVigencia stored Vigencia_Specified;
    property Mensaje:  string       Index (IS_NLBL) read FMensaje write FMensaje;
  end;



  // ************************************************************************ //
  // XML       : CuentaEstatus, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  TEcodexCuentaEstatus = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FCodigo: string;
    FCodigo_Specified: boolean;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FFechaInicio: TXSDateTime;
    FFechaInicio_Specified: boolean;
    FFechaFin: TXSDateTime;
    FFechaFin_Specified: boolean;
    FTimbresAsignados: Integer;
    FTimbresAsignados_Specified: boolean;
    FTimbresDisponibles: Integer;
    FTimbresDisponibles_Specified: boolean;
    FCertificados: ArrayOfstring;
    FCertificados_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetCodigo(Index: Integer; const Astring: string);
    function  Codigo_Specified(Index: Integer): boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetFechaInicio(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  FechaInicio_Specified(Index: Integer): boolean;
    procedure SetFechaFin(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  FechaFin_Specified(Index: Integer): boolean;
    procedure SetTimbresAsignados(Index: Integer; const AInteger: Integer);
    function  TimbresAsignados_Specified(Index: Integer): boolean;
    procedure SetTimbresDisponibles(Index: Integer; const AInteger: Integer);
    function  TimbresDisponibles_Specified(Index: Integer): boolean;
    procedure SetCertificados(Index: Integer; const AArrayOfstring: ArrayOfstring);
    function  Certificados_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RFC:                string         Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Codigo:             string         Index (IS_OPTN or IS_NLBL) read FCodigo write SetCodigo stored Codigo_Specified;
    property Descripcion:        string         Index (IS_OPTN or IS_NLBL) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property FechaInicio:        TXSDateTime    Index (IS_OPTN) read FFechaInicio write SetFechaInicio stored FechaInicio_Specified;
    property FechaFin:           TXSDateTime    Index (IS_OPTN) read FFechaFin write SetFechaFin stored FechaFin_Specified;
    property TimbresAsignados:   Integer        Index (IS_OPTN) read FTimbresAsignados write SetTimbresAsignados stored TimbresAsignados_Specified;
    property TimbresDisponibles: Integer        Index (IS_OPTN) read FTimbresDisponibles write SetTimbresDisponibles stored TimbresDisponibles_Specified;
    property Certificados:       ArrayOfstring  Index (IS_OPTN or IS_NLBL) read FCertificados write SetCertificados stored Certificados_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudAvisosNuevos, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudAvisosNuevos = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:           string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:         string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaRegistro, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaRegistro = class(TRemotable)
  private
    FRespuesta: TEcodexResultadoRegistroEmisor;
    FRespuesta_Specified: boolean;
    FTransaccionId: Int64;
    FTransaccionId_Specified: boolean;
    procedure SetRespuesta(Index: Integer; const AResultadoRegistroEmisor2: TEcodexResultadoRegistroEmisor);
    function  Respuesta_Specified(Index: Integer): boolean;
    procedure SetTransaccionId(Index: Integer; const AInt64: Int64);
    function  TransaccionId_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Respuesta:     TEcodexResultadoRegistroEmisor  Index (IS_OPTN or IS_NLBL) read FRespuesta write SetRespuesta stored Respuesta_Specified;
    property TransaccionId: Int64                     Index (IS_OPTN) read FTransaccionId write SetTransaccionId stored TransaccionId_Specified;
  end;



  // ************************************************************************ //
  // XML       : AltaEmisor, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  AltaEmisor = class(TEcodexNuevoEmisor)
  private
  published
  end;

  // ************************************************************************ //
  // XML       : TEcodexSolicitudRegistroCliente, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudRegistroCliente = class(TRemotable)
  private
    FEmisor: TEcodexNuevoEmisor;
    FEmisor_Specified: boolean;
    FRfcIntegrador: string;
    FRfcIntegrador_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetEmisor(Index: Integer; const AAltaEmisor2: TEcodexNuevoEmisor);
    function  Emisor_Specified(Index: Integer): boolean;
    procedure SetRfcIntegrador(Index: Integer; const Astring: string);
    function  RfcIntegrador_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Emisor:        TEcodexNuevoEmisor  Index (IS_OPTN or IS_NLBL) read FEmisor write SetEmisor stored Emisor_Specified;
    property RfcIntegrador: string       Index (IS_OPTN or IS_NLBL) read FRfcIntegrador write SetRfcIntegrador stored RfcIntegrador_Specified;
    property Token:         string       Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64        Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : ResultadoRegistroEmisor, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  ResultadoRegistroEmisor = class(TEcodexResultadoRegistroEmisor)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : TEcodexRespuestaAsignacionTimbres, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaAsignacionTimbres = class(TRemotable)
  private
    FSaldoAnterior: Int64;
    FSaldoAnterior_Specified: boolean;
    FSaldoNuevo: Integer;
    FSaldoNuevo_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionId: Int64;
    FTransaccionId_Specified: boolean;
    procedure SetSaldoAnterior(Index: Integer; const AInt64: Int64);
    function  SaldoAnterior_Specified(Index: Integer): boolean;
    procedure SetSaldoNuevo(Index: Integer; const AInteger: Integer);
    function  SaldoNuevo_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionId(Index: Integer; const AInt64: Int64);
    function  TransaccionId_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property SaldoAnterior: Int64    Index (IS_OPTN) read FSaldoAnterior write SetSaldoAnterior stored SaldoAnterior_Specified;
    property SaldoNuevo:    Integer  Index (IS_OPTN) read FSaldoNuevo write SetSaldoNuevo stored SaldoNuevo_Specified;
    property Token:         string   Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionId: Int64    Index (IS_OPTN) read FTransaccionId write SetTransaccionId stored TransaccionId_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudAsignacionTimbres, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudAsignacionTimbres = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FTimbresAsignar: Integer;
    FTimbresAsignar_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionId: Int64;
    FTransaccionId_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetTimbresAsignar(Index: Integer; const AInteger: Integer);
    function  TimbresAsignar_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionId(Index: Integer; const AInt64: Int64);
    function  TransaccionId_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:            string   Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property TimbresAsignar: Integer  Index (IS_OPTN) read FTimbresAsignar write SetTimbresAsignar stored TimbresAsignar_Specified;
    property Token:          string   Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionId:  Int64    Index (IS_OPTN) read FTransaccionId write SetTransaccionId stored TransaccionId_Specified;
  end;

  // ************************************************************************ //
  // XML       : Aviso, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  Aviso = class(Aviso2)
  private
  published
  end;

  // ************************************************************************ //
  // XML       : TEcodexRespuestaAvisosNuevos, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaAvisosNuevos = class(TRemotable)
  private
    FAvisos: Avisos;
    FAvisos_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetAvisos(Index: Integer; const AAvisos: Avisos);
    function  Avisos_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Avisos:        Avisos  Index (IS_OPTN or IS_NLBL) read FAvisos write SetAvisos stored Avisos_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;

  // ************************************************************************ //
  // XML       : CuentaEstatus, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  CuentaEstatus = class(TEcodexCuentaEstatus)
  private
  published
  end;

  // ************************************************************************ //
  // XML       : TEcodexRespuestaEstatusCuenta, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexRespuestaEstatusCuenta = class(TRemotable)
  private
    FEstatus: TEcodexCuentaEstatus;
    FEstatus_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetEstatus(Index: Integer; const ACuentaEstatus2: TEcodexCuentaEstatus);
    function  Estatus_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Estatus:       TEcodexCuentaEstatus  Index (IS_OPTN or IS_NLBL) read FEstatus write SetEstatus stored Estatus_Specified;
    property TransaccionID: Int64           Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;



  // ************************************************************************ //
  // XML       : TEcodexSolicitudEstatusCuenta, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  TEcodexSolicitudEstatusCuenta = class(TRemotable)
  private
    FRFC: string;
    FRFC_Specified: boolean;
    FToken: string;
    FToken_Specified: boolean;
    FTransaccionID: Int64;
    FTransaccionID_Specified: boolean;
    procedure SetRFC(Index: Integer; const Astring: string);
    function  RFC_Specified(Index: Integer): boolean;
    procedure SetToken(Index: Integer; const Astring: string);
    function  Token_Specified(Index: Integer): boolean;
    procedure SetTransaccionID(Index: Integer; const AInt64: Int64);
    function  TransaccionID_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property RFC:           string  Index (IS_OPTN or IS_NLBL) read FRFC write SetRFC stored RFC_Specified;
    property Token:         string  Index (IS_OPTN or IS_NLBL) read FToken write SetToken stored Token_Specified;
    property TransaccionID: Int64   Index (IS_OPTN) read FTransaccionID write SetTransaccionID stored TransaccionID_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // soapAction: |http://Ecodex.WS.Model/2011/CFDI/ServicioClientes/AvisosNuevos|http://Ecodex.WS.Model/2011/CFDI/ServicioClientes/EstatusCuenta|Registrar|AsignacionTimbres
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : PuertoClientesSeguro
  // service   : IEcodexServicioClientes
  // port      : PuertoClientesSeguro
  // URL       : https://wsdexpruebas.ecodex.com.mx:2045/ServicioClientes.svc
  // ************************************************************************ //
  IEcodexServicioClientes = interface(IInvokable)
  ['{8FC0C998-279B-1C07-5269-CBEB7D660ED3}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  AvisosNuevos(const parameters: TEcodexSolicitudAvisosNuevos): TEcodexRespuestaAvisosNuevos; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  EstatusCuenta(const parameters: TEcodexSolicitudEstatusCuenta): TEcodexRespuestaEstatusCuenta; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  Registrar(const parameters: TEcodexSolicitudRegistroCliente): TEcodexRespuestaRegistro; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  AsignacionTimbres(const parameters: TEcodexSolicitudAsignacionTimbres): TEcodexRespuestaAsignacionTimbres; stdcall;
  end;

function GetWsEcodexClientes(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioClientes;
function GetUltimoXMLEnviadoEcodexWsClientes: string;
function GetUltimoXMLRecibidoEcodexWsClientes: string;


implementation
  uses SysUtils, uWSHelper;

var
  wsHelper: TWSHelper;

function GetWsEcodexClientes(UseWSDL: Boolean=System.False; Addr: string='';
    HTTPRIO: THTTPRIO = nil): IEcodexServicioClientes;
const
  defWSDL = 'https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc?wsdl';
  defURL  = 'https://pruebas.ecodex.com.mx:2045/ServicioClientes.svc';
  defSvc  = 'IEcodexServicioClientes';
  defPrt  = '4043';
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

  RIO.OnBeforeExecute := wsHelper.BeforeExecute;
  RIO.OnAfterExecute := wsHelper.AfterExecute;
  try
    Result := (RIO as IEcodexServicioClientes);
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

function GetUltimoXMLEnviadoEcodexWsClientes: string;
begin
  Result := wsHelper.UltimoXMLEnviado;
end;

function GetUltimoXMLRecibidoEcodexWsClientes: string;
begin
  Result := wsHelper.UltimoXMLRecibido;
end;


procedure TEcodexResultadoRegistroEmisor.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexResultadoRegistroEmisor.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexResultadoRegistroEmisor.SetEstatus(Index: Integer; const Astring: string);
begin
  FEstatus := Astring;
  FEstatus_Specified := True;
end;

function TEcodexResultadoRegistroEmisor.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure TEcodexResultadoRegistroEmisor.SetClaveCertificado(Index: Integer; const Astring: string);
begin
  FClaveCertificado := Astring;
  FClaveCertificado_Specified := True;
end;

function TEcodexResultadoRegistroEmisor.ClaveCertificado_Specified(Index: Integer): boolean;
begin
  Result := FClaveCertificado_Specified;
end;

procedure TEcodexNuevoEmisor.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexNuevoEmisor.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexNuevoEmisor.SetRazonSocial(Index: Integer; const Astring: string);
begin
  FRazonSocial := Astring;
  FRazonSocial_Specified := True;
end;

function TEcodexNuevoEmisor.RazonSocial_Specified(Index: Integer): boolean;
begin
  Result := FRazonSocial_Specified;
end;

procedure TEcodexNuevoEmisor.SetCorreoElectronico(Index: Integer; const Astring: string);
begin
  FCorreoElectronico := Astring;
  FCorreoElectronico_Specified := True;
end;

function TEcodexNuevoEmisor.CorreoElectronico_Specified(Index: Integer): boolean;
begin
  Result := FCorreoElectronico_Specified;
end;

destructor Aviso2.Destroy;
begin
  SysUtils.FreeAndNil(FVigencia);
  inherited Destroy;
end;

procedure Aviso2.SetVigencia(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FVigencia := ATXSDateTime;
  FVigencia_Specified := True;
end;

function Aviso2.Vigencia_Specified(Index: Integer): boolean;
begin
  Result := FVigencia_Specified;
end;

destructor TEcodexCuentaEstatus.Destroy;
begin
  SysUtils.FreeAndNil(FFechaInicio);
  SysUtils.FreeAndNil(FFechaFin);
  inherited Destroy;
end;

procedure TEcodexCuentaEstatus.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexCuentaEstatus.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexCuentaEstatus.SetCodigo(Index: Integer; const Astring: string);
begin
  FCodigo := Astring;
  FCodigo_Specified := True;
end;

function TEcodexCuentaEstatus.Codigo_Specified(Index: Integer): boolean;
begin
  Result := FCodigo_Specified;
end;

procedure TEcodexCuentaEstatus.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function TEcodexCuentaEstatus.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure TEcodexCuentaEstatus.SetFechaInicio(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FFechaInicio := ATXSDateTime;
  FFechaInicio_Specified := True;
end;

function TEcodexCuentaEstatus.FechaInicio_Specified(Index: Integer): boolean;
begin
  Result := FFechaInicio_Specified;
end;

procedure TEcodexCuentaEstatus.SetFechaFin(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FFechaFin := ATXSDateTime;
  FFechaFin_Specified := True;
end;

function TEcodexCuentaEstatus.FechaFin_Specified(Index: Integer): boolean;
begin
  Result := FFechaFin_Specified;
end;

procedure TEcodexCuentaEstatus.SetTimbresAsignados(Index: Integer; const AInteger: Integer);
begin
  FTimbresAsignados := AInteger;
  FTimbresAsignados_Specified := True;
end;

function TEcodexCuentaEstatus.TimbresAsignados_Specified(Index: Integer): boolean;
begin
  Result := FTimbresAsignados_Specified;
end;

procedure TEcodexCuentaEstatus.SetTimbresDisponibles(Index: Integer; const AInteger: Integer);
begin
  FTimbresDisponibles := AInteger;
  FTimbresDisponibles_Specified := True;
end;

function TEcodexCuentaEstatus.TimbresDisponibles_Specified(Index: Integer): boolean;
begin
  Result := FTimbresDisponibles_Specified;
end;

procedure TEcodexCuentaEstatus.SetCertificados(Index: Integer; const AArrayOfstring: ArrayOfstring);
begin
  FCertificados := AArrayOfstring;
  FCertificados_Specified := True;
end;

function TEcodexCuentaEstatus.Certificados_Specified(Index: Integer): boolean;
begin
  Result := FCertificados_Specified;
end;

constructor TEcodexSolicitudAvisosNuevos.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexSolicitudAvisosNuevos.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudAvisosNuevos.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexSolicitudAvisosNuevos.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexSolicitudAvisosNuevos.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexSolicitudAvisosNuevos.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudAvisosNuevos.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexRespuestaRegistro.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TEcodexRespuestaRegistro.Destroy;
begin
  SysUtils.FreeAndNil(FRespuesta);
  inherited Destroy;
end;

procedure TEcodexRespuestaRegistro.SetRespuesta(Index: Integer; const AResultadoRegistroEmisor2: TEcodexResultadoRegistroEmisor);
begin
  FRespuesta := AResultadoRegistroEmisor2;
  FRespuesta_Specified := True;
end;

function TEcodexRespuestaRegistro.Respuesta_Specified(Index: Integer): boolean;
begin
  Result := FRespuesta_Specified;
end;

procedure TEcodexRespuestaRegistro.SetTransaccionId(Index: Integer; const AInt64: Int64);
begin
  FTransaccionId := AInt64;
  FTransaccionId_Specified := True;
end;

function TEcodexRespuestaRegistro.TransaccionId_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionId_Specified;
end;

constructor TEcodexSolicitudRegistroCliente.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TEcodexSolicitudRegistroCliente.Destroy;
begin
  SysUtils.FreeAndNil(FEmisor);
  inherited Destroy;
end;

procedure TEcodexSolicitudRegistroCliente.SetEmisor(Index: Integer; const AAltaEmisor2: TEcodexNuevoEmisor);
begin
  FEmisor := AAltaEmisor2;
  FEmisor_Specified := True;
end;

function TEcodexSolicitudRegistroCliente.Emisor_Specified(Index: Integer): boolean;
begin
  Result := FEmisor_Specified;
end;

procedure TEcodexSolicitudRegistroCliente.SetRfcIntegrador(Index: Integer; const Astring: string);
begin
  FRfcIntegrador := Astring;
  FRfcIntegrador_Specified := True;
end;

function TEcodexSolicitudRegistroCliente.RfcIntegrador_Specified(Index: Integer): boolean;
begin
  Result := FRfcIntegrador_Specified;
end;

procedure TEcodexSolicitudRegistroCliente.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexSolicitudRegistroCliente.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexSolicitudRegistroCliente.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudRegistroCliente.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexRespuestaAsignacionTimbres.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexRespuestaAsignacionTimbres.SetSaldoAnterior(Index: Integer; const AInt64: Int64);
begin
  FSaldoAnterior := AInt64;
  FSaldoAnterior_Specified := True;
end;

function TEcodexRespuestaAsignacionTimbres.SaldoAnterior_Specified(Index: Integer): boolean;
begin
  Result := FSaldoAnterior_Specified;
end;

procedure TEcodexRespuestaAsignacionTimbres.SetSaldoNuevo(Index: Integer; const AInteger: Integer);
begin
  FSaldoNuevo := AInteger;
  FSaldoNuevo_Specified := True;
end;

function TEcodexRespuestaAsignacionTimbres.SaldoNuevo_Specified(Index: Integer): boolean;
begin
  Result := FSaldoNuevo_Specified;
end;

procedure TEcodexRespuestaAsignacionTimbres.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexRespuestaAsignacionTimbres.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexRespuestaAsignacionTimbres.SetTransaccionId(Index: Integer; const AInt64: Int64);
begin
  FTransaccionId := AInt64;
  FTransaccionId_Specified := True;
end;

function TEcodexRespuestaAsignacionTimbres.TransaccionId_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionId_Specified;
end;

constructor TEcodexSolicitudAsignacionTimbres.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexSolicitudAsignacionTimbres.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudAsignacionTimbres.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexSolicitudAsignacionTimbres.SetTimbresAsignar(Index: Integer; const AInteger: Integer);
begin
  FTimbresAsignar := AInteger;
  FTimbresAsignar_Specified := True;
end;

function TEcodexSolicitudAsignacionTimbres.TimbresAsignar_Specified(Index: Integer): boolean;
begin
  Result := FTimbresAsignar_Specified;
end;

procedure TEcodexSolicitudAsignacionTimbres.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexSolicitudAsignacionTimbres.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexSolicitudAsignacionTimbres.SetTransaccionId(Index: Integer; const AInt64: Int64);
begin
  FTransaccionId := AInt64;
  FTransaccionId_Specified := True;
end;

function TEcodexSolicitudAsignacionTimbres.TransaccionId_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionId_Specified;
end;

constructor TEcodexRespuestaAvisosNuevos.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TEcodexRespuestaAvisosNuevos.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FAvisos)-1 do
    SysUtils.FreeAndNil(FAvisos[I]);
  System.SetLength(FAvisos, 0);
  inherited Destroy;
end;

procedure TEcodexRespuestaAvisosNuevos.SetAvisos(Index: Integer; const AAvisos: Avisos);
begin
  FAvisos := AAvisos;
  FAvisos_Specified := True;
end;

function TEcodexRespuestaAvisosNuevos.Avisos_Specified(Index: Integer): boolean;
begin
  Result := FAvisos_Specified;
end;

procedure TEcodexRespuestaAvisosNuevos.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaAvisosNuevos.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexRespuestaEstatusCuenta.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TEcodexRespuestaEstatusCuenta.Destroy;
begin
  SysUtils.FreeAndNil(FEstatus);
  inherited Destroy;
end;

procedure TEcodexRespuestaEstatusCuenta.SetEstatus(Index: Integer; const ACuentaEstatus2: TEcodexCuentaEstatus);
begin
  FEstatus := ACuentaEstatus2;
  FEstatus_Specified := True;
end;

function TEcodexRespuestaEstatusCuenta.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure TEcodexRespuestaEstatusCuenta.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexRespuestaEstatusCuenta.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

constructor TEcodexSolicitudEstatusCuenta.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure TEcodexSolicitudEstatusCuenta.SetRFC(Index: Integer; const Astring: string);
begin
  FRFC := Astring;
  FRFC_Specified := True;
end;

function TEcodexSolicitudEstatusCuenta.RFC_Specified(Index: Integer): boolean;
begin
  Result := FRFC_Specified;
end;

procedure TEcodexSolicitudEstatusCuenta.SetToken(Index: Integer; const Astring: string);
begin
  FToken := Astring;
  FToken_Specified := True;
end;

function TEcodexSolicitudEstatusCuenta.Token_Specified(Index: Integer): boolean;
begin
  Result := FToken_Specified;
end;

procedure TEcodexSolicitudEstatusCuenta.SetTransaccionID(Index: Integer; const AInt64: Int64);
begin
  FTransaccionID := AInt64;
  FTransaccionID_Specified := True;
end;

function TEcodexSolicitudEstatusCuenta.TransaccionID_Specified(Index: Integer): boolean;
begin
  Result := FTransaccionID_Specified;
end;

initialization
  { IEcodexServicioClientes }
  InvRegistry.RegisterInterface(TypeInfo(IEcodexServicioClientes), 'http://Ecodex.WS.Model/2011/CFDI', 'utf-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(IEcodexServicioClientes), '|http://Ecodex.WS.Model/2011/CFDI/ServicioClientes/AvisosNuevos|http://Ecodex.WS.Model/2011/CFDI/ServicioClientes/EstatusCuenta|Registrar|AsignacionTimbres');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioClientes), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(IEcodexServicioClientes), ioLiteral);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Avisos), 'http://Ecodex.WS.Model/2011/CFDI', 'Avisos');
  RemClassRegistry.RegisterXSClass(TEcodexResultadoRegistroEmisor, 'http://Ecodex.WS.Model/2011/CFDI', 'ResultadoRegistroEmisor', 'ResultadoRegistroEmisor');
  RemClassRegistry.RegisterXSClass(TEcodexNuevoEmisor, 'http://Ecodex.WS.Model/2011/CFDI', 'AltaEmisor', 'AltaEmisor');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfstring), 'http://schemas.microsoft.com/2003/10/Serialization/Arrays', 'ArrayOfstring');
  RemClassRegistry.RegisterXSClass(Aviso2, 'http://Ecodex.WS.Model/2011/CFDI', 'Aviso2', 'Aviso');
  RemClassRegistry.RegisterXSClass(TEcodexCuentaEstatus, 'http://Ecodex.WS.Model/2011/CFDI', 'CuentaEstatus', 'CuentaEstatus');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TEcodexCuentaEstatus), 'Certificados', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudAvisosNuevos, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudAvisosNuevos');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudAvisosNuevos, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaRegistro, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaRegistro');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaRegistro, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(AltaEmisor, 'http://Ecodex.WS.Model/2011/CFDI', 'AltaEmisor');
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudRegistroCliente, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudRegistroCliente');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudRegistroCliente, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ResultadoRegistroEmisor, 'http://Ecodex.WS.Model/2011/CFDI', 'ResultadoRegistroEmisor');
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaAsignacionTimbres, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaAsignacionTimbres');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaAsignacionTimbres, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudAsignacionTimbres, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudAsignacionTimbres');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudAsignacionTimbres, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(Aviso, 'http://Ecodex.WS.Model/2011/CFDI', 'Aviso');
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaAvisosNuevos, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaAvisosNuevos');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TEcodexRespuestaAvisosNuevos), 'Avisos', '[ArrayItemName="Aviso"]');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaAvisosNuevos, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(CuentaEstatus, 'http://Ecodex.WS.Model/2011/CFDI', 'CuentaEstatus');
  RemClassRegistry.RegisterXSClass(TEcodexRespuestaEstatusCuenta, 'http://Ecodex.WS.Model/2011/CFDI', 'RespuestaEstatusCuenta');
  RemClassRegistry.RegisterSerializeOptions(TEcodexRespuestaEstatusCuenta, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TEcodexSolicitudEstatusCuenta, 'http://Ecodex.WS.Model/2011/CFDI', 'SolicitudEstatusCuenta');
  RemClassRegistry.RegisterSerializeOptions(TEcodexSolicitudEstatusCuenta, [xoLiteralParam]);

  wsHelper := TWSHelper.Create;
finalization
  if Assigned(wsHelper) then
    wsHelper.Free;
end.