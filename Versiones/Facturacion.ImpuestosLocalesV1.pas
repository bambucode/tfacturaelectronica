
{**************************************************************************************************}
{                                                                                                  }
{                                         XML Data Binding                                         }
{                                                                                                  }
{                                                                                                  }
{**************************************************************************************************}

unit Facturacion.ImpuestosLocalesV1;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IImpuestosLocalesV1 = interface;
  IImpuestosLocalesV1_RetencionesLocales = interface;
  IImpuestosLocalesV1_RetencionesLocalesList = interface;
  IImpuestosLocalesV1_TrasladosLocales = interface;
  IImpuestosLocalesV1_TrasladosLocalesList = interface;

{ IImpuestosLocalesV1 }

  IImpuestosLocalesV1 = interface(IXMLNode)
    ['{BDE51B3E-9226-4054-8D1E-D4026894CCC2}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_TotaldeRetenciones: UnicodeString;
    function Get_TotaldeTraslados: UnicodeString;
    function Get_RetencionesLocales: IImpuestosLocalesV1_RetencionesLocalesList;
    function Get_TrasladosLocales: IImpuestosLocalesV1_TrasladosLocalesList;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TotaldeRetenciones(Value: UnicodeString);
    procedure Set_TotaldeTraslados(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property TotaldeRetenciones: UnicodeString read Get_TotaldeRetenciones write Set_TotaldeRetenciones;
    property TotaldeTraslados: UnicodeString read Get_TotaldeTraslados write Set_TotaldeTraslados;
    property RetencionesLocales: IImpuestosLocalesV1_RetencionesLocalesList read Get_RetencionesLocales;
    property TrasladosLocales: IImpuestosLocalesV1_TrasladosLocalesList read Get_TrasladosLocales;
  end;

{ IImpuestosLocalesV1_RetencionesLocales }

  IImpuestosLocalesV1_RetencionesLocales = interface(IXMLNode)
    ['{A6883E50-D206-4783-82DD-90443AA48A07}']
    { Property Accessors }
    function Get_ImpLocRetenido: UnicodeString;
    function Get_TasadeRetencion: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocRetenido(Value: UnicodeString);
    procedure Set_TasadeRetencion(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property ImpLocRetenido: UnicodeString read Get_ImpLocRetenido write Set_ImpLocRetenido;
    property TasadeRetencion: UnicodeString read Get_TasadeRetencion write Set_TasadeRetencion;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IImpuestosLocalesV1_RetencionesLocalesList }

  IImpuestosLocalesV1_RetencionesLocalesList = interface(IXMLNodeCollection)
    ['{7E8EC275-6167-4D79-862B-0C0E580B0EDC}']
    { Methods & Properties }
    function Add: IImpuestosLocalesV1_RetencionesLocales;
    function Insert(const Index: Integer): IImpuestosLocalesV1_RetencionesLocales;

    function Get_Item(Index: Integer): IImpuestosLocalesV1_RetencionesLocales;
    property Items[Index: Integer]: IImpuestosLocalesV1_RetencionesLocales read Get_Item; default;
  end;

{ IImpuestosLocalesV1_TrasladosLocales }

  IImpuestosLocalesV1_TrasladosLocales = interface(IXMLNode)
    ['{75AB862C-8F2D-48F8-989B-48C8117D9F97}']
    { Property Accessors }
    function Get_ImpLocTrasladado: UnicodeString;
    function Get_TasadeTraslado: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocTrasladado(Value: UnicodeString);
    procedure Set_TasadeTraslado(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property ImpLocTrasladado: UnicodeString read Get_ImpLocTrasladado write Set_ImpLocTrasladado;
    property TasadeTraslado: UnicodeString read Get_TasadeTraslado write Set_TasadeTraslado;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IImpuestosLocalesV1_TrasladosLocalesList }

  IImpuestosLocalesV1_TrasladosLocalesList = interface(IXMLNodeCollection)
    ['{050AE389-A4FB-4B40-BA60-ACBF648CEFCF}']
    { Methods & Properties }
    function Add: IImpuestosLocalesV1_TrasladosLocales;
    function Insert(const Index: Integer): IImpuestosLocalesV1_TrasladosLocales;

    function Get_Item(Index: Integer): IImpuestosLocalesV1_TrasladosLocales;
    property Items[Index: Integer]: IImpuestosLocalesV1_TrasladosLocales read Get_Item; default;
  end;

{ Forward Decls }

  TImpuestosLocalesV1 = class;
  TImpuestosLocalesV1_RetencionesLocales = class;
  TImpuestosLocalesV1_RetencionesLocalesList = class;
  TImpuestosLocalesV1_TrasladosLocales = class;
  TImpuestosLocalesV1_TrasladosLocalesList = class;

{ TImpuestosLocalesV1 }

  TImpuestosLocalesV1 = class(TXMLNode, IImpuestosLocalesV1)
  private
    FRetencionesLocales: IImpuestosLocalesV1_RetencionesLocalesList;
    FTrasladosLocales: IImpuestosLocalesV1_TrasladosLocalesList;
  protected
    { IImpuestosLocalesV1 }
    function Get_Version: UnicodeString;
    function Get_TotaldeRetenciones: UnicodeString;
    function Get_TotaldeTraslados: UnicodeString;
    function Get_RetencionesLocales: IImpuestosLocalesV1_RetencionesLocalesList;
    function Get_TrasladosLocales: IImpuestosLocalesV1_TrasladosLocalesList;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TotaldeRetenciones(Value: UnicodeString);
    procedure Set_TotaldeTraslados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TImpuestosLocalesV1_RetencionesLocales }

  TImpuestosLocalesV1_RetencionesLocales = class(TXMLNode, IImpuestosLocalesV1_RetencionesLocales)
  protected
    { IImpuestosLocalesV1_RetencionesLocales }
    function Get_ImpLocRetenido: UnicodeString;
    function Get_TasadeRetencion: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocRetenido(Value: UnicodeString);
    procedure Set_TasadeRetencion(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TImpuestosLocalesV1_RetencionesLocalesList }

  TImpuestosLocalesV1_RetencionesLocalesList = class(TXMLNodeCollection, IImpuestosLocalesV1_RetencionesLocalesList)
  protected
    { IImpuestosLocalesV1_RetencionesLocalesList }
    function Add: IImpuestosLocalesV1_RetencionesLocales;
    function Insert(const Index: Integer): IImpuestosLocalesV1_RetencionesLocales;

    function Get_Item(Index: Integer): IImpuestosLocalesV1_RetencionesLocales;
  end;

{ TImpuestosLocalesV1_TrasladosLocales }

  TImpuestosLocalesV1_TrasladosLocales = class(TXMLNode, IImpuestosLocalesV1_TrasladosLocales)
  protected
    { IImpuestosLocalesV1_TrasladosLocales }
    function Get_ImpLocTrasladado: UnicodeString;
    function Get_TasadeTraslado: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocTrasladado(Value: UnicodeString);
    procedure Set_TasadeTraslado(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TImpuestosLocalesV1_TrasladosLocalesList }

  TImpuestosLocalesV1_TrasladosLocalesList = class(TXMLNodeCollection, IImpuestosLocalesV1_TrasladosLocalesList)
  protected
    { IImpuestosLocalesV1_TrasladosLocalesList }
    function Add: IImpuestosLocalesV1_TrasladosLocales;
    function Insert(const Index: Integer): IImpuestosLocalesV1_TrasladosLocales;

    function Get_Item(Index: Integer): IImpuestosLocalesV1_TrasladosLocales;
  end;

{ Global Functions }

function GetImpuestosLocalesV1(Doc: IXMLDocument): IImpuestosLocalesV1;
function LoadImpuestosLocalesV1(const FileName: string): IImpuestosLocalesV1;
function NewImpuestosLocalesV1: IImpuestosLocalesV1;

const
  TargetNamespace = 'http://www.sat.gob.mx/implocal';

implementation

{ Global Functions }

function GetImpuestosLocalesV1(Doc: IXMLDocument): IImpuestosLocalesV1;
begin
  Result := Doc.GetDocBinding('implocal:ImpuestosLocales', TImpuestosLocalesV1, TargetNamespace) as IImpuestosLocalesV1;
end;

function LoadImpuestosLocalesV1(const FileName: string): IImpuestosLocalesV1;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('implocal:ImpuestosLocales', TImpuestosLocalesV1, TargetNamespace) as IImpuestosLocalesV1;
end;

function NewImpuestosLocalesV1: IImpuestosLocalesV1;
begin
  Result := NewXMLDocument.GetDocBinding('implocal:ImpuestosLocales', TImpuestosLocalesV1, TargetNamespace) as IImpuestosLocalesV1;
end;

{ TImpuestosLocalesV1 }

procedure TImpuestosLocalesV1.AfterConstruction;
begin
   if (Self.AttributeNodes.FindNode('version') = nil) then
    Self.Set_Version('1.0');

  RegisterChildNode('RetencionesLocales', TImpuestosLocalesV1_RetencionesLocales, TargetNamespace);
  RegisterChildNode('TrasladosLocales', TImpuestosLocalesV1_TrasladosLocales, TargetNamespace);
  FRetencionesLocales := CreateCollection(TImpuestosLocalesV1_RetencionesLocalesList, IImpuestosLocalesV1_RetencionesLocales, 'implocal:RetencionesLocales', '') as IImpuestosLocalesV1_RetencionesLocalesList;
  FTrasladosLocales := CreateCollection(TImpuestosLocalesV1_TrasladosLocalesList, IImpuestosLocalesV1_TrasladosLocales, 'implocal:TrasladosLocales', '') as IImpuestosLocalesV1_TrasladosLocalesList;
  inherited;
end;

function TImpuestosLocalesV1.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TImpuestosLocalesV1.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TImpuestosLocalesV1.Get_TotaldeRetenciones: UnicodeString;
begin
  Result := AttributeNodes['TotaldeRetenciones'].Text;
end;

procedure TImpuestosLocalesV1.Set_TotaldeRetenciones(Value: UnicodeString);
begin
  SetAttribute('TotaldeRetenciones', Value);
end;

function TImpuestosLocalesV1.Get_TotaldeTraslados: UnicodeString;
begin
  Result := AttributeNodes['TotaldeTraslados'].Text;
end;

procedure TImpuestosLocalesV1.Set_TotaldeTraslados(Value: UnicodeString);
begin
  SetAttribute('TotaldeTraslados', Value);
end;

function TImpuestosLocalesV1.Get_RetencionesLocales: IImpuestosLocalesV1_RetencionesLocalesList;
begin
  Result := FRetencionesLocales;
end;

function TImpuestosLocalesV1.Get_TrasladosLocales: IImpuestosLocalesV1_TrasladosLocalesList;
begin
  Result := FTrasladosLocales;
end;

{ TImpuestosLocalesV1_RetencionesLocales }

function TImpuestosLocalesV1_RetencionesLocales.Get_ImpLocRetenido: UnicodeString;
begin
  Result := AttributeNodes['ImpLocRetenido'].Text;
end;

procedure TImpuestosLocalesV1_RetencionesLocales.Set_ImpLocRetenido(Value: UnicodeString);
begin
  SetAttribute('ImpLocRetenido', Value);
end;

function TImpuestosLocalesV1_RetencionesLocales.Get_TasadeRetencion: UnicodeString;
begin
  Result := AttributeNodes['TasadeRetencion'].Text;
end;

procedure TImpuestosLocalesV1_RetencionesLocales.Set_TasadeRetencion(Value: UnicodeString);
begin
  SetAttribute('TasadeRetencion', Value);
end;

function TImpuestosLocalesV1_RetencionesLocales.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TImpuestosLocalesV1_RetencionesLocales.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TImpuestosLocalesV1_RetencionesLocalesList }

function TImpuestosLocalesV1_RetencionesLocalesList.Add: IImpuestosLocalesV1_RetencionesLocales;
begin
  Result := AddItem(-1) as IImpuestosLocalesV1_RetencionesLocales;
end;

function TImpuestosLocalesV1_RetencionesLocalesList.Insert(const Index: Integer): IImpuestosLocalesV1_RetencionesLocales;
begin
  Result := AddItem(Index) as IImpuestosLocalesV1_RetencionesLocales;
end;

function TImpuestosLocalesV1_RetencionesLocalesList.Get_Item(Index: Integer): IImpuestosLocalesV1_RetencionesLocales;
begin
  Result := List[Index] as IImpuestosLocalesV1_RetencionesLocales;
end;

{ TImpuestosLocalesV1_TrasladosLocales }

function TImpuestosLocalesV1_TrasladosLocales.Get_ImpLocTrasladado: UnicodeString;
begin
  Result := AttributeNodes['ImpLocTrasladado'].Text;
end;

procedure TImpuestosLocalesV1_TrasladosLocales.Set_ImpLocTrasladado(Value: UnicodeString);
begin
  SetAttribute('ImpLocTrasladado', Value);
end;

function TImpuestosLocalesV1_TrasladosLocales.Get_TasadeTraslado: UnicodeString;
begin
  Result := AttributeNodes['TasadeTraslado'].Text;
end;

procedure TImpuestosLocalesV1_TrasladosLocales.Set_TasadeTraslado(Value: UnicodeString);
begin
  SetAttribute('TasadeTraslado', Value);
end;

function TImpuestosLocalesV1_TrasladosLocales.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TImpuestosLocalesV1_TrasladosLocales.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TImpuestosLocalesV1_TrasladosLocalesList }

function TImpuestosLocalesV1_TrasladosLocalesList.Add: IImpuestosLocalesV1_TrasladosLocales;
begin
  Result := AddItem(-1) as IImpuestosLocalesV1_TrasladosLocales;
end;

function TImpuestosLocalesV1_TrasladosLocalesList.Insert(const Index: Integer): IImpuestosLocalesV1_TrasladosLocales;
begin
  Result := AddItem(Index) as IImpuestosLocalesV1_TrasladosLocales;
end;

function TImpuestosLocalesV1_TrasladosLocalesList.Get_Item(Index: Integer): IImpuestosLocalesV1_TrasladosLocales;
begin
  Result := List[Index] as IImpuestosLocalesV1_TrasladosLocales;
end;

end.