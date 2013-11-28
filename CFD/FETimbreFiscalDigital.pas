
{*****************************************************************************************}
{                                                                                         }
{                                    XML Data Binding                                     }
{                                                                                         }
{         Generated on: 11/22/2013 10:36:32 AM                                            }
{                                                                                         }
{*****************************************************************************************}

unit FETimbreFiscalDigital;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }
  IFEXMLtimbreFiscalDigital = interface;

{ IFEXMLtimbreFiscalDigital }

  IFEXMLtimbreFiscalDigital = interface(IXMLNode)
    ['{B521ED3C-55C7-4FEA-A641-BE87E4D5AB23}']
    { Property Accessors }
    function Get_Version: WideString;
    function Get_UUID: WideString;
    function Get_FechaTimbrado: WideString;
    function Get_SelloCFD: WideString;
    function Get_NoCertificadoSAT: WideString;
    function Get_SelloSAT: WideString;
    procedure Set_Version(Value: WideString);
    procedure Set_UUID(Value: WideString);
    procedure Set_FechaTimbrado(Value: WideString);
    procedure Set_SelloCFD(Value: WideString);
    procedure Set_NoCertificadoSAT(Value: WideString);
    procedure Set_SelloSAT(Value: WideString);
    { Methods & Properties }
    property Version: WideString read Get_Version write Set_Version;
    property UUID: WideString read Get_UUID write Set_UUID;
    property FechaTimbrado: WideString read Get_FechaTimbrado write Set_FechaTimbrado;
    property SelloCFD: WideString read Get_SelloCFD write Set_SelloCFD;
    property NoCertificadoSAT: WideString read Get_NoCertificadoSAT write Set_NoCertificadoSAT;
    property SelloSAT: WideString read Get_SelloSAT write Set_SelloSAT;
  end;

{ Forward Decls }

  TXMLTimbreFiscalDigital = class;

{ TXMLTimbreFiscalDigital }

  TXMLTimbreFiscalDigital = class(TXMLNode, IFEXMLtimbreFiscalDigital)
  protected
    { IFEXMLtimbreFiscalDigital }
    function Get_Version: WideString;
    function Get_UUID: WideString;
    function Get_FechaTimbrado: WideString;
    function Get_SelloCFD: WideString;
    function Get_NoCertificadoSAT: WideString;
    function Get_SelloSAT: WideString;
    procedure Set_Version(Value: WideString);
    procedure Set_UUID(Value: WideString);
    procedure Set_FechaTimbrado(Value: WideString);
    procedure Set_SelloCFD(Value: WideString);
    procedure Set_NoCertificadoSAT(Value: WideString);
    procedure Set_SelloSAT(Value: WideString);
  end;

{ Global Functions }

function GetTimbreFiscalDigital(Doc: IXMLDocument): IFEXMLtimbreFiscalDigital;
function LoadTimbreFiscalDigital(const FileName: WideString): IFEXMLtimbreFiscalDigital;
function NewTimbreFiscalDigital: IFEXMLtimbreFiscalDigital;

const
  TargetNamespace = 'http://www.sat.gob.mx/TimbreFiscalDigital';

implementation

{ Global Functions }

function GetTimbreFiscalDigital(Doc: IXMLDocument): IFEXMLtimbreFiscalDigital;
begin
  Result := Doc.GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IFEXMLtimbreFiscalDigital;
end;

function LoadTimbreFiscalDigital(const FileName: WideString): IFEXMLtimbreFiscalDigital;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IFEXMLtimbreFiscalDigital;
end;

function NewTimbreFiscalDigital: IFEXMLtimbreFiscalDigital;
begin
  Result := NewXMLDocument.GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IFEXMLtimbreFiscalDigital;
end;

{ TXMLTimbreFiscalDigital }

function TXMLTimbreFiscalDigital.Get_Version: WideString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_Version(Value: WideString);
begin
  SetAttribute('version', Value);
end;

function TXMLTimbreFiscalDigital.Get_UUID: WideString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_UUID(Value: WideString);
begin
  SetAttribute('UUID', Value);
end;

function TXMLTimbreFiscalDigital.Get_FechaTimbrado: WideString;
begin
  Result := AttributeNodes['FechaTimbrado'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_FechaTimbrado(Value: WideString);
begin
  SetAttribute('FechaTimbrado', Value);
end;

function TXMLTimbreFiscalDigital.Get_SelloCFD: WideString;
begin
  Result := AttributeNodes['selloCFD'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_SelloCFD(Value: WideString);
begin
  SetAttribute('selloCFD', Value);
end;

function TXMLTimbreFiscalDigital.Get_NoCertificadoSAT: WideString;
begin
  Result := AttributeNodes['noCertificadoSAT'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_NoCertificadoSAT(Value: WideString);
begin
  SetAttribute('noCertificadoSAT', Value);
end;

function TXMLTimbreFiscalDigital.Get_SelloSAT: WideString;
begin
  Result := AttributeNodes['selloSAT'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_SelloSAT(Value: WideString);
begin
  SetAttribute('selloSAT', Value);
end;

end.