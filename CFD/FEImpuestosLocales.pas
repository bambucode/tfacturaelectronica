
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

uses xmldom, XMLDoc, XMLIntf,FacturaTipos;

type

{ Forward Decls }

  IFEXMLImpuestosLocales = interface;
  IFEXMLImpuestosLocales_RetencionesLocales = interface;
  IFEXMLImpuestosLocales_RetencionesLocalesList = interface;
  IFEXMLImpuestosLocales_TrasladosLocales = interface;
  IFEXMLImpuestosLocales_TrasladosLocalesList = interface;

{ IFEXMLImpuestosLocales }

  IFEXMLImpuestosLocales = interface(IXMLNode)
  ['{EFA58A15-A8BC-466D-B6B7-B0003072659A}']
    { Property Accessors }
    function Get_Version: TUnicodeString;
    function Get_TotaldeRetenciones: TUnicodeString;
    function Get_TotaldeTraslados: TUnicodeString;
    function Get_RetencionesLocales: IFEXMLImpuestosLocales_RetencionesLocalesList;
    function Get_TrasladosLocales: IFEXMLImpuestosLocales_TrasladosLocalesList;
    procedure Set_Version(Value: TUnicodeString);
    procedure Set_TotaldeRetenciones(Value: TUnicodeString);
    procedure Set_TotaldeTraslados(Value: TUnicodeString);
    { Methods & Properties }
    property Version: TUnicodeString read Get_Version write Set_Version;
    property TotaldeRetenciones: TUnicodeString read Get_TotaldeRetenciones write Set_TotaldeRetenciones;
    property TotaldeTraslados: TUnicodeString read Get_TotaldeTraslados write Set_TotaldeTraslados;
    property RetencionesLocales: IFEXMLImpuestosLocales_RetencionesLocalesList read Get_RetencionesLocales;
    property TrasladosLocales: IFEXMLImpuestosLocales_TrasladosLocalesList read Get_TrasladosLocales;
  end;

{ IFEXMLImpuestosLocales_RetencionesLocales }

  IFEXMLImpuestosLocales_RetencionesLocales = interface(IXMLNode)
    ['{DF5ACEE7-B902-4DE7-BA92-287D3BF51CFB}']
    { Property Accessors }
    function Get_ImpLocRetenido: TUnicodeString;
    function Get_TasadeRetencion: TUnicodeString;
    function Get_Importe: TUnicodeString;
    procedure Set_ImpLocRetenido(Value: TUnicodeString);
    procedure Set_TasadeRetencion(Value: TUnicodeString);
    procedure Set_Importe(Value: TUnicodeString);
    { Methods & Properties }
    property ImpLocRetenido: TUnicodeString read Get_ImpLocRetenido write Set_ImpLocRetenido;
    property TasadeRetencion: TUnicodeString read Get_TasadeRetencion write Set_TasadeRetencion;
    property Importe: TUnicodeString read Get_Importe write Set_Importe;
  end;

{ IFEXMLImpuestosLocales_RetencionesLocalesList }

  IFEXMLImpuestosLocales_RetencionesLocalesList = interface(IXMLNodeCollection)
    ['{D25D079F-41E4-40DA-8C1F-1B19197E20F4}']
    { Methods & Properties }
    function Add: IFEXMLImpuestosLocales_RetencionesLocales;
    function Insert(const Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;

    function Get_Item(Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;
    property Items[Index: Integer]: IFEXMLImpuestosLocales_RetencionesLocales read Get_Item; default;
  end;

{ IFEXMLImpuestosLocales_TrasladosLocales }

  IFEXMLImpuestosLocales_TrasladosLocales = interface(IXMLNode)
    ['{F2668E73-6083-4FBC-B1DD-66E2343962AA}']
    { Property Accessors }
    function Get_ImpLocTrasladado: TUnicodeString;
    function Get_TasadeTraslado: TUnicodeString;
    function Get_Importe: TUnicodeString;
    procedure Set_ImpLocTrasladado(Value: TUnicodeString);
    procedure Set_TasadeTraslado(Value: TUnicodeString);
    procedure Set_Importe(Value: TUnicodeString);
    { Methods & Properties }
    property ImpLocTrasladado: TUnicodeString read Get_ImpLocTrasladado write Set_ImpLocTrasladado;
    property TasadeTraslado: TUnicodeString read Get_TasadeTraslado write Set_TasadeTraslado;
    property Importe: TUnicodeString read Get_Importe write Set_Importe;
  end;

{ IFEXMLImpuestosLocales_TrasladosLocalesList }

  IFEXMLImpuestosLocales_TrasladosLocalesList = interface(IXMLNodeCollection)
    ['{0CE814EB-6501-4530-8B4F-F795DE23B78C}']
    { Methods & Properties }
    function Add: IFEXMLImpuestosLocales_TrasladosLocales;
    function Insert(const Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;

    function Get_Item(Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;
    property Items[Index: Integer]: IFEXMLImpuestosLocales_TrasladosLocales read Get_Item; default;
  end;

{ Forward Decls }

  TFEXMLImpuestosLocales = class;
  TFEXMLImpuestosLocales_RetencionesLocales = class;
  TFEXMLImpuestosLocales_RetencionesLocalesList = class;
  TFEXMLImpuestosLocales_TrasladosLocales = class;
  TFEXMLImpuestosLocales_TrasladosLocalesList = class;

{ TFEXMLImpuestosLocales }

  TFEXMLImpuestosLocales = class(TXMLNode, IFEXMLImpuestosLocales)
  private
    FRetencionesLocales: IFEXMLImpuestosLocales_RetencionesLocalesList;
    FTrasladosLocales: IFEXMLImpuestosLocales_TrasladosLocalesList;
  protected
    { IFEXMLImpuestosLocales }
    function Get_Version: TUnicodeString;
    function Get_TotaldeRetenciones: TUnicodeString;
    function Get_TotaldeTraslados: TUnicodeString;
    function Get_RetencionesLocales: IFEXMLImpuestosLocales_RetencionesLocalesList;
    function Get_TrasladosLocales: IFEXMLImpuestosLocales_TrasladosLocalesList;
    procedure Set_Version(Value: TUnicodeString);
    procedure Set_TotaldeRetenciones(Value: TUnicodeString);
    procedure Set_TotaldeTraslados(Value: TUnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXMLImpuestosLocales_RetencionesLocales }

  TFEXMLImpuestosLocales_RetencionesLocales = class(TXMLNode,
      IFEXMLImpuestosLocales_RetencionesLocales)
  protected
    { IFEXMLImpuestosLocales_RetencionesLocales }
    function Get_ImpLocRetenido: TUnicodeString;
    function Get_TasadeRetencion: TUnicodeString;
    function Get_Importe: TUnicodeString;
    procedure Set_ImpLocRetenido(Value: TUnicodeString);
    procedure Set_TasadeRetencion(Value: TUnicodeString);
    procedure Set_Importe(Value: TUnicodeString);
  end;

{ TFEXMLImpuestosLocales_RetencionesLocalesList }

  TFEXMLImpuestosLocales_RetencionesLocalesList = class(TXMLNodeCollection,
      IFEXMLImpuestosLocales_RetencionesLocalesList)
  protected
    { IFEXMLImpuestosLocales_RetencionesLocalesList }
    function Add: IFEXMLImpuestosLocales_RetencionesLocales;
    function Insert(const Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;

    function Get_Item(Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;
  end;

{ TFEXMLImpuestosLocales_TrasladosLocales }

  TFEXMLImpuestosLocales_TrasladosLocales = class(TXMLNode,
      IFEXMLImpuestosLocales_TrasladosLocales)
  protected
    { IFEXMLImpuestosLocales_TrasladosLocales }
    function Get_ImpLocTrasladado: TUnicodeString;
    function Get_TasadeTraslado: TUnicodeString;
    function Get_Importe: TUnicodeString;
    procedure Set_ImpLocTrasladado(Value: TUnicodeString);
    procedure Set_TasadeTraslado(Value: TUnicodeString);
    procedure Set_Importe(Value: TUnicodeString);
  end;

{ TFEXMLImpuestosLocales_TrasladosLocalesList }

  TFEXMLImpuestosLocales_TrasladosLocalesList = class(TXMLNodeCollection,
      IFEXMLImpuestosLocales_TrasladosLocalesList)
  protected
    { IFEXMLImpuestosLocales_TrasladosLocalesList }
    function Add: IFEXMLImpuestosLocales_TrasladosLocales;
    function Insert(const Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;

    function Get_Item(Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;
  end;

{ Global Functions }

function NuevoNodoImpuestosLocales(Doc: IXMLDocument): IFEXMLImpuestosLocales;
function LoadImpuestosLocales(const FileName: string): IFEXMLImpuestosLocales;
function NewImpuestosLocales: IFEXMLImpuestosLocales;

type
  TDOMStringDynArray = array of DOMString;
  TStringSplitOption = (ssNone, ssRemoveEmptyEntries);
  TStringSplitOptions = set of TStringSplitOption;

const
  TargetNamespace = 'http://www.sat.gob.mx/implocal';

implementation

uses SysUtils;

{ Global Functions }

function NuevoNodoImpuestosLocales(Doc: IXMLDocument): IFEXMLImpuestosLocales;
begin
  Result := Doc.GetDocBinding('implocal:ImpuestosLocales', TFEXMLImpuestosLocales, TargetNamespace) as IFEXMLImpuestosLocales;
end;

function LoadImpuestosLocales(const FileName: string): IFEXMLImpuestosLocales;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('implocal:ImpuestosLocales', TFEXMLImpuestosLocales, TargetNamespace) as IFEXMLImpuestosLocales;
end;

function NewImpuestosLocales: IFEXMLImpuestosLocales;
begin
  Result := NewXMLDocument.GetDocBinding('implocal:ImpuestosLocales', TFEXMLImpuestosLocales, TargetNamespace) as IFEXMLImpuestosLocales;
end;

{ TFEXMLImpuestosLocales }

procedure TFEXMLImpuestosLocales.AfterConstruction;
begin
  inherited;
  DeclareNamespace('implocal', TargetNamespace);

  RegisterChildNode('RetencionesLocales', TFEXMLImpuestosLocales_RetencionesLocales, TargetNamespace);
  RegisterChildNode('TrasladosLocales', TFEXMLImpuestosLocales_TrasladosLocales, TargetNamespace);

  fRetencionesLocales := CreateCollection(TFEXMLImpuestosLocales_RetencionesLocalesList,
                                          IFEXMLImpuestosLocales_RetencionesLocales,
                                          'implocal:RetencionesLocales;RetencionesLocales',
                                          TargetNamespace) as IFEXMLImpuestosLocales_RetencionesLocalesList;

  fTrasladosLocales := CreateCollection(TFEXMLImpuestosLocales_TrasladosLocalesList,
                                        IFEXMLImpuestosLocales_TrasladosLocales,
                                        'implocal:TrasladosLocales;TrasladosLocales',
                                        TargetNamespace) as IFEXMLImpuestosLocales_TrasladosLocalesList;
end;

function TFEXMLImpuestosLocales.Get_Version: TUnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TFEXMLImpuestosLocales.Set_Version(Value: TUnicodeString);
begin
  SetAttribute('version', Value);
end;

function TFEXMLImpuestosLocales.Get_TotaldeRetenciones: TUnicodeString;
begin
  Result := AttributeNodes['TotaldeRetenciones'].Text;
end;

procedure TFEXMLImpuestosLocales.Set_TotaldeRetenciones(Value: TUnicodeString);
begin
  SetAttribute('TotaldeRetenciones', Value);
end;

function TFEXMLImpuestosLocales.Get_TotaldeTraslados: TUnicodeString;
begin
  Result := AttributeNodes['TotaldeTraslados'].Text;
end;

procedure TFEXMLImpuestosLocales.Set_TotaldeTraslados(Value: TUnicodeString);
begin
  SetAttribute('TotaldeTraslados', Value);
end;

function TFEXMLImpuestosLocales.Get_RetencionesLocales: IFEXMLImpuestosLocales_RetencionesLocalesList;
begin
  Result := FRetencionesLocales;
end;

function TFEXMLImpuestosLocales.Get_TrasladosLocales: IFEXMLImpuestosLocales_TrasladosLocalesList;
begin
  Result := FTrasladosLocales;
end;

{ TFEXMLImpuestosLocales_RetencionesLocales }

function TFEXMLImpuestosLocales_RetencionesLocales.Get_ImpLocRetenido: TUnicodeString;
begin
  Result := AttributeNodes['ImpLocRetenido'].Text;
end;

procedure TFEXMLImpuestosLocales_RetencionesLocales.Set_ImpLocRetenido(Value: TUnicodeString);
begin
  SetAttribute('ImpLocRetenido', Value);
end;

function TFEXMLImpuestosLocales_RetencionesLocales.Get_TasadeRetencion: TUnicodeString;
begin
  Result := AttributeNodes['TasadeRetencion'].Text;
end;

procedure TFEXMLImpuestosLocales_RetencionesLocales.Set_TasadeRetencion(Value: TUnicodeString);
begin
  SetAttribute('TasadeRetencion', Value);
end;

function TFEXMLImpuestosLocales_RetencionesLocales.Get_Importe: TUnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TFEXMLImpuestosLocales_RetencionesLocales.Set_Importe(Value: TUnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TFEXMLImpuestosLocales_RetencionesLocalesList }

function TFEXMLImpuestosLocales_RetencionesLocalesList.Add: IFEXMLImpuestosLocales_RetencionesLocales;
begin
  Result := Insert(-1);
end;

function TFEXMLImpuestosLocales_RetencionesLocalesList.Insert(const Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;
begin
  Result := AddChild('implocal:RetencionesLocales',
                     TargetNamespace,
                     False,
                     Index) as IFEXMLImpuestosLocales_RetencionesLocales;
end;

function TFEXMLImpuestosLocales_RetencionesLocalesList.Get_Item(Index: Integer): IFEXMLImpuestosLocales_RetencionesLocales;
begin
  Result := List[Index] as IFEXMLImpuestosLocales_RetencionesLocales;
end;

{ TFEXMLImpuestosLocales_TrasladosLocales }

function TFEXMLImpuestosLocales_TrasladosLocales.Get_ImpLocTrasladado: TUnicodeString;
begin
  Result := AttributeNodes['ImpLocTrasladado'].Text;
end;

procedure TFEXMLImpuestosLocales_TrasladosLocales.Set_ImpLocTrasladado(Value: TUnicodeString);
begin
  SetAttribute('ImpLocTrasladado', Value);
end;

function TFEXMLImpuestosLocales_TrasladosLocales.Get_TasadeTraslado: TUnicodeString;
begin
  Result := AttributeNodes['TasadeTraslado'].Text;
end;

procedure TFEXMLImpuestosLocales_TrasladosLocales.Set_TasadeTraslado(Value: TUnicodeString);
begin
  SetAttribute('TasadeTraslado', Value);
end;

function TFEXMLImpuestosLocales_TrasladosLocales.Get_Importe: TUnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TFEXMLImpuestosLocales_TrasladosLocales.Set_Importe(Value: TUnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TFEXMLImpuestosLocales_TrasladosLocalesList }

function TFEXMLImpuestosLocales_TrasladosLocalesList.Add: IFEXMLImpuestosLocales_TrasladosLocales;
begin
  Result := Insert(-1);
end;

function TFEXMLImpuestosLocales_TrasladosLocalesList.Insert(const Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;
begin
  Result := AddChild('implocal:TrasladosLocales',
                     TargetNamespace,
                     False,
                     Index) as IFEXMLImpuestosLocales_TrasladosLocales;
end;

function TFEXMLImpuestosLocales_TrasladosLocalesList.Get_Item(Index: Integer): IFEXMLImpuestosLocales_TrasladosLocales;
begin
  Result := List[Index] as IFEXMLImpuestosLocales_TrasladosLocales;
end;

end.