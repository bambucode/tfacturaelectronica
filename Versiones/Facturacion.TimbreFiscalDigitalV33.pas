
{****************************************************************************************************************}
{                                                                                                                }
{                                                XML Data Binding                                                }
{                                                                                                                }
{                                                                                                                }
{****************************************************************************************************************}

unit Facturacion.TimbreFiscalDigitalV33;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTimbreFiscalDigital = interface;

{ IXMLTimbreFiscalDigital }

  IXMLTimbreFiscalDigital = interface(IXMLNode)
    ['{10E384BF-A049-4437-8112-D81E4A3989AD}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_UUID: UnicodeString;
    function Get_FechaTimbrado: UnicodeString;
    function Get_RfcProvCertif: UnicodeString;
    function Get_Leyenda: UnicodeString;
    function Get_SelloCFD: UnicodeString;
    function Get_NoCertificadoSAT: UnicodeString;
    function Get_SelloSAT: UnicodeString;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_FechaTimbrado(Value: UnicodeString);
    procedure Set_RfcProvCertif(Value: UnicodeString);
    procedure Set_Leyenda(Value: UnicodeString);
    procedure Set_SelloCFD(Value: UnicodeString);
    procedure Set_NoCertificadoSAT(Value: UnicodeString);
    procedure Set_SelloSAT(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property UUID: UnicodeString read Get_UUID write Set_UUID;
    property FechaTimbrado: UnicodeString read Get_FechaTimbrado write Set_FechaTimbrado;
    property RfcProvCertif: UnicodeString read Get_RfcProvCertif write Set_RfcProvCertif;
    property Leyenda: UnicodeString read Get_Leyenda write Set_Leyenda;
    property SelloCFD: UnicodeString read Get_SelloCFD write Set_SelloCFD;
    property NoCertificadoSAT: UnicodeString read Get_NoCertificadoSAT write Set_NoCertificadoSAT;
    property SelloSAT: UnicodeString read Get_SelloSAT write Set_SelloSAT;
  end;

{ Forward Decls }

  TXMLTimbreFiscalDigital = class;

{ TXMLTimbreFiscalDigital }

  TXMLTimbreFiscalDigital = class(TXMLNode, IXMLTimbreFiscalDigital)
  protected
    { IXMLTimbreFiscalDigital }
    function Get_Version: UnicodeString;
    function Get_UUID: UnicodeString;
    function Get_FechaTimbrado: UnicodeString;
    function Get_RfcProvCertif: UnicodeString;
    function Get_Leyenda: UnicodeString;
    function Get_SelloCFD: UnicodeString;
    function Get_NoCertificadoSAT: UnicodeString;
    function Get_SelloSAT: UnicodeString;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_FechaTimbrado(Value: UnicodeString);
    procedure Set_RfcProvCertif(Value: UnicodeString);
    procedure Set_Leyenda(Value: UnicodeString);
    procedure Set_SelloCFD(Value: UnicodeString);
    procedure Set_NoCertificadoSAT(Value: UnicodeString);
    procedure Set_SelloSAT(Value: UnicodeString);
  end;

{ Global Functions }

function GetTimbreFiscalDigital(Doc: IXMLDocument): IXMLTimbreFiscalDigital;
function LoadTimbreFiscalDigital(const FileName: string): IXMLTimbreFiscalDigital;
function NewTimbreFiscalDigital: IXMLTimbreFiscalDigital;

const
  TargetNamespace = 'http://www.sat.gob.mx/TimbreFiscalDigital';

implementation

{ Global Functions }

function GetTimbreFiscalDigital(Doc: IXMLDocument): IXMLTimbreFiscalDigital;
begin
  Result := Doc.GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IXMLTimbreFiscalDigital;
end;

function LoadTimbreFiscalDigital(const FileName: string): IXMLTimbreFiscalDigital;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IXMLTimbreFiscalDigital;
end;

function NewTimbreFiscalDigital: IXMLTimbreFiscalDigital;
begin
  Result := NewXMLDocument.GetDocBinding('TimbreFiscalDigital', TXMLTimbreFiscalDigital, TargetNamespace) as IXMLTimbreFiscalDigital;
end;

{ TXMLTimbreFiscalDigital }

function TXMLTimbreFiscalDigital.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TXMLTimbreFiscalDigital.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

function TXMLTimbreFiscalDigital.Get_FechaTimbrado: UnicodeString;
begin
  Result := AttributeNodes['FechaTimbrado'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_FechaTimbrado(Value: UnicodeString);
begin
  SetAttribute('FechaTimbrado', Value);
end;

function TXMLTimbreFiscalDigital.Get_RfcProvCertif: UnicodeString;
begin
  Result := AttributeNodes['RfcProvCertif'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_RfcProvCertif(Value: UnicodeString);
begin
  SetAttribute('RfcProvCertif', Value);
end;

function TXMLTimbreFiscalDigital.Get_Leyenda: UnicodeString;
begin
  Result := AttributeNodes['Leyenda'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_Leyenda(Value: UnicodeString);
begin
  SetAttribute('Leyenda', Value);
end;

function TXMLTimbreFiscalDigital.Get_SelloCFD: UnicodeString;
begin
  Result := AttributeNodes['SelloCFD'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_SelloCFD(Value: UnicodeString);
begin
  SetAttribute('SelloCFD', Value);
end;

function TXMLTimbreFiscalDigital.Get_NoCertificadoSAT: UnicodeString;
begin
  Result := AttributeNodes['NoCertificadoSAT'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_NoCertificadoSAT(Value: UnicodeString);
begin
  SetAttribute('NoCertificadoSAT', Value);
end;

function TXMLTimbreFiscalDigital.Get_SelloSAT: UnicodeString;
begin
  Result := AttributeNodes['SelloSAT'].Text;
end;

procedure TXMLTimbreFiscalDigital.Set_SelloSAT(Value: UnicodeString);
begin
  SetAttribute('SelloSAT', Value);
end;

end.