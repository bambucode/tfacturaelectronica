
{*****************************************************************************************************************}
{                                                                                                                 }
{                                                XML Data Binding                                                 }
{                                                                                                                 }
{         Generated on: 10/05/2017 11:19:15 a. m.                                                                 }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigitalv11.xsd   }
{                                                                                                                 }
{*****************************************************************************************************************}

unit Facturacion.TimbreFiscalDigitalV33;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  ITimbreFiscalDigitalV33 = interface;

{ ITimbreFiscalDigitalV33 }

  ITimbreFiscalDigitalV33 = interface(IXMLNode)
    ['{707E4EA1-6D06-497E-82D6-D15AF85054EA}']
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

  TXMLITimbreFiscalDigitalV33 = class;

{ TXMLITimbreFiscalDigitalV33 }

  TXMLITimbreFiscalDigitalV33 = class(TXMLNode, ITimbreFiscalDigitalV33)
  protected
    { ITimbreFiscalDigitalV33 }
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

function GetTimbreFiscalDigital(Doc: IXMLDocument): ITimbreFiscalDigitalV33;
function LoadTimbreFiscalDigital(const FileName: string): ITimbreFiscalDigitalV33;
function NewTimbreFiscalDigital: ITimbreFiscalDigitalV33;

const
  TargetNamespace = 'http://www.sat.gob.mx/TimbreFiscalDigital';

implementation

{ Global Functions }

function GetTimbreFiscalDigital(Doc: IXMLDocument): ITimbreFiscalDigitalV33;
begin
  Result := Doc.GetDocBinding('TimbreFiscalDigital', TXMLITimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

function LoadTimbreFiscalDigital(const FileName: string): ITimbreFiscalDigitalV33;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TimbreFiscalDigital', TXMLITimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

function NewTimbreFiscalDigital: ITimbreFiscalDigitalV33;
begin
  Result := NewXMLDocument.GetDocBinding('TimbreFiscalDigital', TXMLITimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

{ TXMLITimbreFiscalDigitalV33 }

function TXMLITimbreFiscalDigitalV33.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_FechaTimbrado: UnicodeString;
begin
  Result := AttributeNodes['FechaTimbrado'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_FechaTimbrado(Value: UnicodeString);
begin
  SetAttribute('FechaTimbrado', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_RfcProvCertif: UnicodeString;
begin
  Result := AttributeNodes['RfcProvCertif'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_RfcProvCertif(Value: UnicodeString);
begin
  SetAttribute('RfcProvCertif', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_Leyenda: UnicodeString;
begin
  Result := AttributeNodes['Leyenda'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_Leyenda(Value: UnicodeString);
begin
  SetAttribute('Leyenda', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_SelloCFD: UnicodeString;
begin
  Result := AttributeNodes['SelloCFD'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_SelloCFD(Value: UnicodeString);
begin
  SetAttribute('SelloCFD', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_NoCertificadoSAT: UnicodeString;
begin
  Result := AttributeNodes['NoCertificadoSAT'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_NoCertificadoSAT(Value: UnicodeString);
begin
  SetAttribute('NoCertificadoSAT', Value);
end;

function TXMLITimbreFiscalDigitalV33.Get_SelloSAT: UnicodeString;
begin
  Result := AttributeNodes['SelloSAT'].Text;
end;

procedure TXMLITimbreFiscalDigitalV33.Set_SelloSAT(Value: UnicodeString);
begin
  SetAttribute('SelloSAT', Value);
end;

end.