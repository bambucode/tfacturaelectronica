
{*************************************************************************************************************}
{                                                                                                             }
{                                              XML Data Binding                                               }
{                                                                                                             }
{                                                                                                             }
{*************************************************************************************************************}

unit Facturacion.TimbreFiscalDigitalV32;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  ITimbreFiscalDigitalV32 = interface;

{ ITimbreFiscalDigitalV32 }

  ITimbreFiscalDigitalV32 = interface(IXMLNode)
    ['{7E4571B5-95B7-4E75-8B64-519C20CDDADD}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_UUID: UnicodeString;
    function Get_FechaTimbrado: UnicodeString;
    function Get_SelloCFD: UnicodeString;
    function Get_NoCertificadoSAT: UnicodeString;
    function Get_SelloSAT: UnicodeString;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_FechaTimbrado(Value: UnicodeString);
    procedure Set_SelloCFD(Value: UnicodeString);
    procedure Set_NoCertificadoSAT(Value: UnicodeString);
    procedure Set_SelloSAT(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property UUID: UnicodeString read Get_UUID write Set_UUID;
    property FechaTimbrado: UnicodeString read Get_FechaTimbrado write Set_FechaTimbrado;
    property SelloCFD: UnicodeString read Get_SelloCFD write Set_SelloCFD;
    property NoCertificadoSAT: UnicodeString read Get_NoCertificadoSAT write Set_NoCertificadoSAT;
    property SelloSAT: UnicodeString read Get_SelloSAT write Set_SelloSAT;
  end;

{ Forward Decls }

  TTimbreFiscalDigitalV32 = class;

{ TTimbreFiscalDigitalV32 }

  TTimbreFiscalDigitalV32 = class(TXMLNode, ITimbreFiscalDigitalV32)
  protected
    { ITimbreFiscalDigitalV32 }
    function Get_Version: UnicodeString;
    function Get_UUID: UnicodeString;
    function Get_FechaTimbrado: UnicodeString;
    function Get_SelloCFD: UnicodeString;
    function Get_NoCertificadoSAT: UnicodeString;
    function Get_SelloSAT: UnicodeString;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_FechaTimbrado(Value: UnicodeString);
    procedure Set_SelloCFD(Value: UnicodeString);
    procedure Set_NoCertificadoSAT(Value: UnicodeString);
    procedure Set_SelloSAT(Value: UnicodeString);
  end;

{ Global Functions }

function GetTimbreFiscalDigitalV32(Doc: IXMLDocument): ITimbreFiscalDigitalV32;
function LoadTimbreFiscalDigitalV32(const FileName: string):
    ITimbreFiscalDigitalV32;
function NewTimbreFiscalDigitalV32: ITimbreFiscalDigitalV32;

const
  TargetNamespace = 'http://www.sat.gob.mx/TimbreFiscalDigital';

implementation

{ Global Functions }

function GetTimbreFiscalDigitalV32(Doc: IXMLDocument): ITimbreFiscalDigitalV32;
begin
  Result := Doc.GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV32, TargetNamespace) as ITimbreFiscalDigitalV32;
end;

function LoadTimbreFiscalDigitalV32(const FileName: string):
    ITimbreFiscalDigitalV32;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV32, TargetNamespace) as ITimbreFiscalDigitalV32;
end;

function NewTimbreFiscalDigitalV32: ITimbreFiscalDigitalV32;
begin
  Result := NewXMLDocument.GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV32, TargetNamespace) as ITimbreFiscalDigitalV32;
end;

{ TTimbreFiscalDigitalV32 }

function TTimbreFiscalDigitalV32.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TTimbreFiscalDigitalV32.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

function TTimbreFiscalDigitalV32.Get_FechaTimbrado: UnicodeString;
begin
  Result := AttributeNodes['FechaTimbrado'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_FechaTimbrado(Value: UnicodeString);
begin
  SetAttribute('FechaTimbrado', Value);
end;

function TTimbreFiscalDigitalV32.Get_SelloCFD: UnicodeString;
begin
  Result := AttributeNodes['selloCFD'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_SelloCFD(Value: UnicodeString);
begin
  SetAttribute('selloCFD', Value);
end;

function TTimbreFiscalDigitalV32.Get_NoCertificadoSAT: UnicodeString;
begin
  Result := AttributeNodes['noCertificadoSAT'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_NoCertificadoSAT(Value: UnicodeString);
begin
  SetAttribute('noCertificadoSAT', Value);
end;

function TTimbreFiscalDigitalV32.Get_SelloSAT: UnicodeString;
begin
  Result := AttributeNodes['selloSAT'].Text;
end;

procedure TTimbreFiscalDigitalV32.Set_SelloSAT(Value: UnicodeString);
begin
  SetAttribute('selloSAT', Value);
end;

end.