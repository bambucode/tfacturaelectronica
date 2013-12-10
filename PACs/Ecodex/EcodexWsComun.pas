{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit EcodexWsComun;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_NLBL = $0004;
  IS_REF  = $0080;

type

  // ************************************************************************ //
  // XML       : EFallaServicioException, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: EFallaServicioException
  // ************************************************************************ //
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Excepciones no controladas o que puedan ser causadas por algun
  ///	  problema en el servidor. Se recomienda implementar un metodo de
  ///	  reintentos en las llamadas.
  ///	</summary>
  {$ENDREGION}
  EEcodexFallaServicioException = class(ERemotableException)
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
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Por lo general indica la expiración del token o el uso de uno
  ///	  malformado o que no corresponde al emisor del que se hace la operación.
  {$ENDREGION}
  EEcodexFallaSesionException = class(ERemotableException)
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
  // XML       : EFallaValidacionException, global, <element>
  // Namespace : http://Ecodex.WS.Model/2011/CFDI
  // Info      : Fault
  // Base Types: EFallaValidacionException
  // ************************************************************************ //

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Esta indica algun error en uno o mas datos enviados por la aplicacion cliente.
  ///	  En el caso del timbrado se regresan los errores definidos por el SAT.
  ///	  En el caso del resto de los metodos.
  ///	</summary>
  {$ENDREGION}
  EEcodexFallaValidacionException = class(ERemotableException)
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

implementation

procedure EEcodexFallaServicioException.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function EEcodexFallaServicioException.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure EEcodexFallaServicioException.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function EEcodexFallaServicioException.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;


procedure EEcodexFallaSesionException.SetEstatus(Index: Integer; const AInteger: Integer);
begin
  FEstatus := AInteger;
  FEstatus_Specified := True;
end;

function EEcodexFallaSesionException.Estatus_Specified(Index: Integer): boolean;
begin
  Result := FEstatus_Specified;
end;

procedure EEcodexFallaSesionException.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function EEcodexFallaSesionException.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;




procedure EEcodexFallaValidacionException.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function EEcodexFallaValidacionException.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure EEcodexFallaValidacionException.SetNodo(Index: Integer; const Astring: string);
begin
  FNodo := Astring;
  FNodo_Specified := True;
end;

function EEcodexFallaValidacionException.Nodo_Specified(Index: Integer): boolean;
begin
  Result := FNodo_Specified;
end;

procedure EEcodexFallaValidacionException.SetAntecedente(Index: Integer; const Astring: string);
begin
  FAntecedente := Astring;
  FAntecedente_Specified := True;
end;

function EEcodexFallaValidacionException.Antecedente_Specified(Index: Integer): boolean;
begin
  Result := FAntecedente_Specified;
end;

procedure EEcodexFallaValidacionException.SetSugerencia(Index: Integer; const Astring: string);
begin
  FSugerencia := Astring;
  FSugerencia_Specified := True;
end;

function EEcodexFallaValidacionException.Sugerencia_Specified(Index: Integer): boolean;
begin
  Result := FSugerencia_Specified;
end;

procedure EEcodexFallaValidacionException.SetEvento(Index: Integer; const Astring: string);
begin
  FEvento := Astring;
  FEvento_Specified := True;
end;

function EEcodexFallaValidacionException.Evento_Specified(Index: Integer): boolean;
begin
  Result := FEvento_Specified;
end;


initialization
  RemClassRegistry.RegisterXSClass(EEcodexFallaServicioException,
                                   'http://Ecodex.WS.Model/2011/CFDI',
                                   'FallaServicio');

  RemClassRegistry.RegisterXSClass(EEcodexFallaSesionException,
                                  'http://Ecodex.WS.Model/2011/CFDI',
                                  'FallaSesion');

   RemClassRegistry.RegisterXSClass(EEcodexFallaValidacionException,
                                  'http://Ecodex.WS.Model/2011/CFDI',
                                  'FallaValidacion');
end.
