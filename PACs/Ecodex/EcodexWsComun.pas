unit EcodexWsComun;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_NLBL = $0004;
  IS_REF  = $0080;

type

  FallaServicio2       = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  FallaSesion2         = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[GblCplx] }
  TEcodexFallaServicio        = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Flt][GblElm] }
  FallaSesion          = class;                 { "http://Ecodex.WS.Model/2011/CFDI"[Flt][GblElm] }


  // ************************************************************************ //
  // XML       : TEcodexFallaServicio, global, <complexType>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // ************************************************************************ //
  FallaServicio2 = class(TRemotable)
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
  // XML       : TEcodexFallaServicio, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: TEcodexFallaServicio
  // ************************************************************************ //
  TEcodexFallaServicio = class(ERemotableException)
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

implementation


procedure FallaServicio2.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function FallaServicio2.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure FallaServicio2.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function FallaServicio2.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;

procedure FallaSesion2.SetEstatus(Index: Integer; const AInteger: Integer);
begin
  FEstatus := AInteger;
  FEstatus_Specified := True;
end;

function FallaSesion2.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure FallaSesion2.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function FallaSesion2.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

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

initialization
  RemClassRegistry.RegisterXSClass(FallaServicio2, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaServicio2', 'TEcodexFallaServicio');
  RemClassRegistry.RegisterXSClass(FallaSesion2, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaSesion2', 'FallaSesion');
  RemClassRegistry.RegisterXSClass(TEcodexFallaServicio, 'http://Ecodex.WS.Model/2011/CFDI', 'TEcodexFallaServicio');
  RemClassRegistry.RegisterXSClass(FallaSesion, 'http://Ecodex.WS.Model/2011/CFDI', 'FallaSesion');
end.
