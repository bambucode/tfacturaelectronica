
{************************************************************************************************}
{                                                                                                }
{                                        XML Data Binding                                        }
{                                                                                                }
{         Generated on: 1/14/2014 5:28:35 PM                                                     }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd           }
{   Settings stored in: FEImpuestosLocales.pas                                                   }
{                                                                                                }
{************************************************************************************************}

unit FEImpuestosLocales;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLImpuestosLocales = interface;
  IXMLImpuestosLocales_RetencionesLocales = interface;
  IXMLImpuestosLocales_RetencionesLocalesList = interface;
  IXMLImpuestosLocales_TrasladosLocales = interface;
  IXMLImpuestosLocales_TrasladosLocalesList = interface;

{ IXMLImpuestosLocales }

  IXMLImpuestosLocales = interface(IXMLNode)
    ['{EFA58A15-A8BC-466D-B6B7-B0003072659A}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_TotaldeRetenciones: UnicodeString;
    function Get_TotaldeTraslados: UnicodeString;
    function Get_RetencionesLocales: IXMLImpuestosLocales_RetencionesLocalesList;
    function Get_TrasladosLocales: IXMLImpuestosLocales_TrasladosLocalesList;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TotaldeRetenciones(Value: UnicodeString);
    procedure Set_TotaldeTraslados(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property TotaldeRetenciones: UnicodeString read Get_TotaldeRetenciones write Set_TotaldeRetenciones;
    property TotaldeTraslados: UnicodeString read Get_TotaldeTraslados write Set_TotaldeTraslados;
    property RetencionesLocales: IXMLImpuestosLocales_RetencionesLocalesList read Get_RetencionesLocales;
    property TrasladosLocales: IXMLImpuestosLocales_TrasladosLocalesList read Get_TrasladosLocales;
  end;

{ IXMLImpuestosLocales_RetencionesLocales }

  IXMLImpuestosLocales_RetencionesLocales = interface(IXMLNode)
    ['{DF5ACEE7-B902-4DE7-BA92-287D3BF51CFB}']
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

{ IXMLImpuestosLocales_RetencionesLocalesList }

  IXMLImpuestosLocales_RetencionesLocalesList = interface(IXMLNodeCollection)
    ['{D25D079F-41E4-40DA-8C1F-1B19197E20F4}']
    { Methods & Properties }
    function Add: IXMLImpuestosLocales_RetencionesLocales;
    function Insert(const Index: Integer): IXMLImpuestosLocales_RetencionesLocales;

    function Get_Item(Index: Integer): IXMLImpuestosLocales_RetencionesLocales;
    property Items[Index: Integer]: IXMLImpuestosLocales_RetencionesLocales read Get_Item; default;
  end;

{ IXMLImpuestosLocales_TrasladosLocales }

  IXMLImpuestosLocales_TrasladosLocales = interface(IXMLNode)
    ['{F2668E73-6083-4FBC-B1DD-66E2343962AA}']
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

{ IXMLImpuestosLocales_TrasladosLocalesList }

  IXMLImpuestosLocales_TrasladosLocalesList = interface(IXMLNodeCollection)
    ['{0CE814EB-6501-4530-8B4F-F795DE23B78C}']
    { Methods & Properties }
    function Add: IXMLImpuestosLocales_TrasladosLocales;
    function Insert(const Index: Integer): IXMLImpuestosLocales_TrasladosLocales;

    function Get_Item(Index: Integer): IXMLImpuestosLocales_TrasladosLocales;
    property Items[Index: Integer]: IXMLImpuestosLocales_TrasladosLocales read Get_Item; default;
  end;

{ Forward Decls }

  TXMLImpuestosLocales = class;
  TXMLImpuestosLocales_RetencionesLocales = class;
  TXMLImpuestosLocales_RetencionesLocalesList = class;
  TXMLImpuestosLocales_TrasladosLocales = class;
  TXMLImpuestosLocales_TrasladosLocalesList = class;

{ TXMLImpuestosLocales }

  TXMLImpuestosLocales = class(TXMLNode, IXMLImpuestosLocales)
  private
    FRetencionesLocales: IXMLImpuestosLocales_RetencionesLocalesList;
    FTrasladosLocales: IXMLImpuestosLocales_TrasladosLocalesList;
  protected
    { IXMLImpuestosLocales }
    function Get_Version: UnicodeString;
    function Get_TotaldeRetenciones: UnicodeString;
    function Get_TotaldeTraslados: UnicodeString;
    function Get_RetencionesLocales: IXMLImpuestosLocales_RetencionesLocalesList;
    function Get_TrasladosLocales: IXMLImpuestosLocales_TrasladosLocalesList;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TotaldeRetenciones(Value: UnicodeString);
    procedure Set_TotaldeTraslados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLImpuestosLocales_RetencionesLocales }

  TXMLImpuestosLocales_RetencionesLocales = class(TXMLNode, IXMLImpuestosLocales_RetencionesLocales)
  protected
    { IXMLImpuestosLocales_RetencionesLocales }
    function Get_ImpLocRetenido: UnicodeString;
    function Get_TasadeRetencion: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocRetenido(Value: UnicodeString);
    procedure Set_TasadeRetencion(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TXMLImpuestosLocales_RetencionesLocalesList }

  TXMLImpuestosLocales_RetencionesLocalesList = class(TXMLNodeCollection, IXMLImpuestosLocales_RetencionesLocalesList)
  protected
    { IXMLImpuestosLocales_RetencionesLocalesList }
    function Add: IXMLImpuestosLocales_RetencionesLocales;
    function Insert(const Index: Integer): IXMLImpuestosLocales_RetencionesLocales;

    function Get_Item(Index: Integer): IXMLImpuestosLocales_RetencionesLocales;
  end;

{ TXMLImpuestosLocales_TrasladosLocales }

  TXMLImpuestosLocales_TrasladosLocales = class(TXMLNode, IXMLImpuestosLocales_TrasladosLocales)
  protected
    { IXMLImpuestosLocales_TrasladosLocales }
    function Get_ImpLocTrasladado: UnicodeString;
    function Get_TasadeTraslado: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_ImpLocTrasladado(Value: UnicodeString);
    procedure Set_TasadeTraslado(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TXMLImpuestosLocales_TrasladosLocalesList }

  TXMLImpuestosLocales_TrasladosLocalesList = class(TXMLNodeCollection, IXMLImpuestosLocales_TrasladosLocalesList)
  protected
    { IXMLImpuestosLocales_TrasladosLocalesList }
    function Add: IXMLImpuestosLocales_TrasladosLocales;
    function Insert(const Index: Integer): IXMLImpuestosLocales_TrasladosLocales;

    function Get_Item(Index: Integer): IXMLImpuestosLocales_TrasladosLocales;
  end;

{ Global Functions }

function NuevoNodoImpuestosLocales(Doc: IXMLDocument): IXMLImpuestosLocales;
function LoadImpuestosLocales(const FileName: string): IXMLImpuestosLocales;
function NewImpuestosLocales: IXMLImpuestosLocales;

const
  TargetNamespace = 'http://www.sat.gob.mx/implocal';

implementation

{ Global Functions }

function NuevoNodoImpuestosLocales(Doc: IXMLDocument): IXMLImpuestosLocales;
begin
  Result := Doc.GetDocBinding('implocal:ImpuestosLocales', TXMLImpuestosLocales, TargetNamespace) as IXMLImpuestosLocales;
end;

function LoadImpuestosLocales(const FileName: string): IXMLImpuestosLocales;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('implocal:ImpuestosLocales', TXMLImpuestosLocales, TargetNamespace) as IXMLImpuestosLocales;
end;

function NewImpuestosLocales: IXMLImpuestosLocales;
begin
  Result := NewXMLDocument.GetDocBinding('implocal:ImpuestosLocales', TXMLImpuestosLocales, TargetNamespace) as IXMLImpuestosLocales;
end;

{ TXMLImpuestosLocales }

procedure TXMLImpuestosLocales.AfterConstruction;
begin
  RegisterChildNode('RetencionesLocales', TXMLImpuestosLocales_RetencionesLocales);
  RegisterChildNode('TrasladosLocales', TXMLImpuestosLocales_TrasladosLocales);
  FRetencionesLocales := CreateCollection(TXMLImpuestosLocales_RetencionesLocalesList, IXMLImpuestosLocales_RetencionesLocales, 'implocal:RetencionesLocales') as IXMLImpuestosLocales_RetencionesLocalesList;
  FTrasladosLocales := CreateCollection(TXMLImpuestosLocales_TrasladosLocalesList, IXMLImpuestosLocales_TrasladosLocales, 'implocal:TrasladosLocales') as IXMLImpuestosLocales_TrasladosLocalesList;

  // Declaramos el NameSpace de CFDI para que agregue el prefijo "cfdi:" a los nodos del complemento
  // Ref: https://forums.embarcadero.com/thread.jspa?threadID=64760
  //DeclareNamespace('implocal', 'http://www.sat.gob.mx/implocal');
  //RegisterChildNode('ImpuestosLocales', TXMLImpuestosLocales, 'http://www.sat.gob.mx/implocal');
  
  inherited;
end;

function TXMLImpuestosLocales.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLImpuestosLocales.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLImpuestosLocales.Get_TotaldeRetenciones: UnicodeString;
begin
  Result := AttributeNodes['TotaldeRetenciones'].Text;
end;

procedure TXMLImpuestosLocales.Set_TotaldeRetenciones(Value: UnicodeString);
begin
  SetAttribute('TotaldeRetenciones', Value);
end;

function TXMLImpuestosLocales.Get_TotaldeTraslados: UnicodeString;
begin
  Result := AttributeNodes['TotaldeTraslados'].Text;
end;

procedure TXMLImpuestosLocales.Set_TotaldeTraslados(Value: UnicodeString);
begin
  SetAttribute('TotaldeTraslados', Value);
end;

function TXMLImpuestosLocales.Get_RetencionesLocales: IXMLImpuestosLocales_RetencionesLocalesList;
begin
  Result := FRetencionesLocales;
end;

function TXMLImpuestosLocales.Get_TrasladosLocales: IXMLImpuestosLocales_TrasladosLocalesList;
begin
  Result := FTrasladosLocales;
end;

{ TXMLImpuestosLocales_RetencionesLocales }

function TXMLImpuestosLocales_RetencionesLocales.Get_ImpLocRetenido: UnicodeString;
begin
  Result := AttributeNodes['ImpLocRetenido'].Text;
end;

procedure TXMLImpuestosLocales_RetencionesLocales.Set_ImpLocRetenido(Value: UnicodeString);
begin
  SetAttribute('ImpLocRetenido', Value);
end;

function TXMLImpuestosLocales_RetencionesLocales.Get_TasadeRetencion: UnicodeString;
begin
  Result := AttributeNodes['TasadeRetencion'].Text;
end;

procedure TXMLImpuestosLocales_RetencionesLocales.Set_TasadeRetencion(Value: UnicodeString);
begin
  SetAttribute('TasadeRetencion', Value);
end;

function TXMLImpuestosLocales_RetencionesLocales.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLImpuestosLocales_RetencionesLocales.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TXMLImpuestosLocales_RetencionesLocalesList }

function TXMLImpuestosLocales_RetencionesLocalesList.Add: IXMLImpuestosLocales_RetencionesLocales;
begin
  Result := AddItem(-1) as IXMLImpuestosLocales_RetencionesLocales;
end;

function TXMLImpuestosLocales_RetencionesLocalesList.Insert(const Index: Integer): IXMLImpuestosLocales_RetencionesLocales;
begin
  Result := AddItem(Index) as IXMLImpuestosLocales_RetencionesLocales;
end;

function TXMLImpuestosLocales_RetencionesLocalesList.Get_Item(Index: Integer): IXMLImpuestosLocales_RetencionesLocales;
begin
  Result := List[Index] as IXMLImpuestosLocales_RetencionesLocales;
end;

{ TXMLImpuestosLocales_TrasladosLocales }

function TXMLImpuestosLocales_TrasladosLocales.Get_ImpLocTrasladado: UnicodeString;
begin
  Result := AttributeNodes['ImpLocTrasladado'].Text;
end;

procedure TXMLImpuestosLocales_TrasladosLocales.Set_ImpLocTrasladado(Value: UnicodeString);
begin
  SetAttribute('ImpLocTrasladado', Value);
end;

function TXMLImpuestosLocales_TrasladosLocales.Get_TasadeTraslado: UnicodeString;
begin
  Result := AttributeNodes['TasadeTraslado'].Text;
end;

procedure TXMLImpuestosLocales_TrasladosLocales.Set_TasadeTraslado(Value: UnicodeString);
begin
  SetAttribute('TasadeTraslado', Value);
end;

function TXMLImpuestosLocales_TrasladosLocales.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLImpuestosLocales_TrasladosLocales.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TXMLImpuestosLocales_TrasladosLocalesList }

function TXMLImpuestosLocales_TrasladosLocalesList.Add: IXMLImpuestosLocales_TrasladosLocales;
begin
  Result := AddItem(-1) as IXMLImpuestosLocales_TrasladosLocales;
end;

function TXMLImpuestosLocales_TrasladosLocalesList.Insert(const Index: Integer): IXMLImpuestosLocales_TrasladosLocales;
begin
  Result := AddItem(Index) as IXMLImpuestosLocales_TrasladosLocales;
end;

function TXMLImpuestosLocales_TrasladosLocalesList.Get_Item(Index: Integer): IXMLImpuestosLocales_TrasladosLocales;
begin
  Result := List[Index] as IXMLImpuestosLocales_TrasladosLocales;
end;

end.