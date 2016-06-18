
{*****************************************************************************}
{                                                                             }
{                              XML Data Binding                               }
{                                                                             }
{         Generated on: 12/5/2013 1:06:33 PM                                  }
{       Generated from: D:\Proyectos\Codigo\FinkOk\cancel_good_response.xml   }
{                                                                             }
{*****************************************************************************}

unit FECancelaFinkOK;

interface

uses xmldom, XMLDoc, XMLIntf,FacturaTipos;

type

{ Forward Decls }

  IFEXMLEnvelopeType = interface;
  IXMLBodyType = interface;
  IXMLCancelResponseType = interface;
  IXMLCancelResultType = interface;
  IXMLFoliosType = interface;
  IXMLFolioType = interface;

{ IFEXMLEnvelopeType }

  IFEXMLEnvelopeType = interface(IXMLNode)
    ['{6C4762C5-0A3E-40F8-9528-FE743BD1B2F3}']
    { Property Accessors }
    function Get_Body: IXMLBodyType;
    { Methods & Properties }
    property Body: IXMLBodyType read Get_Body;
  end;

{ IXMLBodyType }

  IXMLBodyType = interface(IXMLNode)
    ['{6E947150-C893-424B-BB94-E80AB70C6266}']
    { Property Accessors }
    function Get_CancelResponse: IXMLCancelResponseType;
    { Methods & Properties }
    property CancelResponse: IXMLCancelResponseType read Get_CancelResponse;
  end;

{ IXMLCancelResponseType }

  IXMLCancelResponseType = interface(IXMLNode)
    ['{B10DCD1B-59F4-408D-A214-66DC8CEED5A0}']
    { Property Accessors }
    function Get_CancelResult: IXMLCancelResultType;
    { Methods & Properties }
    property CancelResult: IXMLCancelResultType read Get_CancelResult;
  end;

{ IXMLCancelResultType }

  IXMLCancelResultType = interface(IXMLNode)
    ['{B1A77884-367F-4D15-950D-C40548F5017A}']
    { Property Accessors }
    function Get_Folios: IXMLFoliosType;
    function Get_Acuse: TUnicodeString;
    function Get_Fecha: TUnicodeString;
    function Get_RfcEmisor: Integer;
    procedure Set_Acuse(Value: TUnicodeString);
    procedure Set_Fecha(Value: TUnicodeString);
    procedure Set_RfcEmisor(Value: Integer);
    { Methods & Properties }
    property Folios: IXMLFoliosType read Get_Folios;
    property Acuse: TUnicodeString read Get_Acuse write Set_Acuse;
    property Fecha: TUnicodeString read Get_Fecha write Set_Fecha;
    property RfcEmisor: Integer read Get_RfcEmisor write Set_RfcEmisor;
  end;

{ IXMLFoliosType }

  IXMLFoliosType = interface(IXMLNode)
    ['{C6BC4BC4-EB6C-4A9E-AFCE-5577CDEBB4CA}']
    { Property Accessors }
    function Get_Folio: IXMLFolioType;
    { Methods & Properties }
    property Folio: IXMLFolioType read Get_Folio;
  end;

{ IXMLFolioType }

  IXMLFolioType = interface(IXMLNode)
    ['{7C2188C8-59E4-4A34-871C-60AD901C8EC8}']
    { Property Accessors }
    function Get_UUID: Integer;
    function Get_EstatusUUID: Integer;
    procedure Set_UUID(Value: Integer);
    procedure Set_EstatusUUID(Value: Integer);
    { Methods & Properties }
    property UUID: Integer read Get_UUID write Set_UUID;
    property EstatusUUID: Integer read Get_EstatusUUID write Set_EstatusUUID;
  end;

{ Forward Decls }

  TXMLIFEXMLEnvelopeType = class;
  TXMLBodyType = class;
  TXMLCancelResponseType = class;
  TXMLCancelResultType = class;
  TXMLFoliosType = class;
  TXMLFolioType = class;

{ TXMLIFEXMLEnvelopeType }

  TXMLIFEXMLEnvelopeType = class(TXMLNode, IFEXMLEnvelopeType)
  protected
    { IFEXMLEnvelopeType }
    function Get_Body: IXMLBodyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBodyType }

  TXMLBodyType = class(TXMLNode, IXMLBodyType)
  protected
    { IXMLBodyType }
    function Get_CancelResponse: IXMLCancelResponseType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCancelResponseType }

  TXMLCancelResponseType = class(TXMLNode, IXMLCancelResponseType)
  protected
    { IXMLCancelResponseType }
    function Get_CancelResult: IXMLCancelResultType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCancelResultType }

  TXMLCancelResultType = class(TXMLNode, IXMLCancelResultType)
  protected
    { IXMLCancelResultType }
    function Get_Folios: IXMLFoliosType;
    function Get_Acuse: TUnicodeString;
    function Get_Fecha: TUnicodeString;
    function Get_RfcEmisor: Integer;
    procedure Set_Acuse(Value: TUnicodeString);
    procedure Set_Fecha(Value: TUnicodeString);
    procedure Set_RfcEmisor(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFoliosType }

  TXMLFoliosType = class(TXMLNode, IXMLFoliosType)
  protected
    { IXMLFoliosType }
    function Get_Folio: IXMLFolioType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFolioType }

  TXMLFolioType = class(TXMLNode, IXMLFolioType)
  protected
    { IXMLFolioType }
    function Get_UUID: Integer;
    function Get_EstatusUUID: Integer;
    procedure Set_UUID(Value: Integer);
    procedure Set_EstatusUUID(Value: Integer);
  end;

{ Global Functions }

function GetEnvelope(Doc: IXMLDocument): IFEXMLEnvelopeType;
function LoadEnvelope(const FileName: string): IFEXMLEnvelopeType;
function NewEnvelope: IFEXMLEnvelopeType;

const
  TargetNamespace = 'http://schemas.xmlsoap.org/soap/envelope/';

implementation

{ Global Functions }

function GetEnvelope(Doc: IXMLDocument): IFEXMLEnvelopeType;
begin
  Result := Doc.GetDocBinding('Envelope', TXMLIFEXMLEnvelopeType, TargetNamespace) as IFEXMLEnvelopeType;
end;

function LoadEnvelope(const FileName: string): IFEXMLEnvelopeType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Envelope', TXMLIFEXMLEnvelopeType, TargetNamespace) as IFEXMLEnvelopeType;
end;

function NewEnvelope: IFEXMLEnvelopeType;
begin
  Result := NewXMLDocument.GetDocBinding('Envelope', TXMLIFEXMLEnvelopeType, TargetNamespace) as IFEXMLEnvelopeType;
end;

{ TXMLIFEXMLEnvelopeType }

procedure TXMLIFEXMLEnvelopeType.AfterConstruction;
begin
  RegisterChildNode('Body', TXMLBodyType);
  inherited;
end;

function TXMLIFEXMLEnvelopeType.Get_Body: IXMLBodyType;
begin
  Result := ChildNodes['Body'] as IXMLBodyType;
end;

{ TXMLBodyType }

procedure TXMLBodyType.AfterConstruction;
begin
  RegisterChildNode('cancelResponse', TXMLCancelResponseType);
  inherited;
end;

function TXMLBodyType.Get_CancelResponse: IXMLCancelResponseType;
begin
  Result := ChildNodes['cancelResponse'] as IXMLCancelResponseType;
end;

{ TXMLCancelResponseType }

procedure TXMLCancelResponseType.AfterConstruction;
begin
  RegisterChildNode('cancelResult', TXMLCancelResultType);
  inherited;
end;

function TXMLCancelResponseType.Get_CancelResult: IXMLCancelResultType;
begin
  Result := ChildNodes['cancelResult'] as IXMLCancelResultType;
end;

{ TXMLCancelResultType }

procedure TXMLCancelResultType.AfterConstruction;
begin
  RegisterChildNode('Folios', TXMLFoliosType);
  inherited;
end;

function TXMLCancelResultType.Get_Folios: IXMLFoliosType;
begin
  Result := ChildNodes['Folios'] as IXMLFoliosType;
end;

function TXMLCancelResultType.Get_Acuse: TUnicodeString;
begin
  Result := ChildNodes['Acuse'].Text;
end;

procedure TXMLCancelResultType.Set_Acuse(Value: TUnicodeString);
begin
  ChildNodes['Acuse'].NodeValue := Value;
end;

function TXMLCancelResultType.Get_Fecha: TUnicodeString;
begin
  Result := ChildNodes['Fecha'].Text;
end;

procedure TXMLCancelResultType.Set_Fecha(Value: TUnicodeString);
begin
  ChildNodes['Fecha'].NodeValue := Value;
end;

function TXMLCancelResultType.Get_RfcEmisor: Integer;
begin
  Result := ChildNodes['RfcEmisor'].NodeValue;
end;

procedure TXMLCancelResultType.Set_RfcEmisor(Value: Integer);
begin
  ChildNodes['RfcEmisor'].NodeValue := Value;
end;

{ TXMLFoliosType }

procedure TXMLFoliosType.AfterConstruction;
begin
  RegisterChildNode('Folio', TXMLFolioType);
  inherited;
end;

function TXMLFoliosType.Get_Folio: IXMLFolioType;
begin
  Result := ChildNodes['Folio'] as IXMLFolioType;
end;

{ TXMLFolioType }

function TXMLFolioType.Get_UUID: Integer;
begin
  Result := ChildNodes['UUID'].NodeValue;
end;

procedure TXMLFolioType.Set_UUID(Value: Integer);
begin
  ChildNodes['UUID'].NodeValue := Value;
end;

function TXMLFolioType.Get_EstatusUUID: Integer;
begin
  Result := ChildNodes['EstatusUUID'].NodeValue;
end;

procedure TXMLFolioType.Set_EstatusUUID(Value: Integer);
begin
  ChildNodes['EstatusUUID'].NodeValue := Value;
end;

end.