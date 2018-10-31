
{****************************************************************************************************************}
{                                                                                                                }
{                                                XML Data Binding                                                }
{                                                                                                                }
{                                                                                                                }
{****************************************************************************************************************}

unit Facturacion.TimbreFiscalDigitalV33;

interface

uses xmldom, XMLDoc, XMLIntf, Facturacion.Comprobante;

type

{ Forward Decls }

  ITimbreFiscalDigitalV33 = interface;

{ ITimbreFiscalDigitalV33 }

  ITimbreFiscalDigitalV33 = interface(IXMLNode)
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

  TTimbreFiscalDigitalV33 = class;

{ TTimbreFiscalDigitalV33 }

  TTimbreFiscalDigitalV33 = class(TXMLNode, ITimbreFiscalDigitalV33)
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
    function GetXML: DOMString; reintroduce;
  end;

{ Global Functions }

function GetTimbreFiscalDigitalV33(Doc: IXMLDocument): ITimbreFiscalDigitalV33;
function LoadTimbreFiscalDigitalV33(const FileName: string):
    ITimbreFiscalDigitalV33;
function NewTimbreFiscalDigitalV33: ITimbreFiscalDigitalV33;

const
  TargetNamespace = 'http://www.sat.gob.mx/TimbreFiscalDigital';

implementation

{ Global Functions }

function GetTimbreFiscalDigitalV33(Doc: IXMLDocument): ITimbreFiscalDigitalV33;
begin
  Result := Doc.GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

function LoadTimbreFiscalDigitalV33(const FileName: string):
    ITimbreFiscalDigitalV33;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

function NewTimbreFiscalDigitalV33: ITimbreFiscalDigitalV33;
begin
  Result := NewXMLDocument.GetDocBinding('tfd:TimbreFiscalDigital', TTimbreFiscalDigitalV33, TargetNamespace) as ITimbreFiscalDigitalV33;
end;

{ TTimbreFiscalDigitalV33 }

function TTimbreFiscalDigitalV33.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TTimbreFiscalDigitalV33.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

function TTimbreFiscalDigitalV33.GetXML: DOMString;
var
  nodoLeyenda: IXMLNode;
begin
 // Existe un error en el XSLT del Timbre fiscal donde si el Nodo Leyenda se auto-agreg� al final,
 //  Ej: cuando se consulta el valor de 'TimbreFiscalDigitalV33.Leyenda', entonces
 // la transformaci�n incluir� un CHR(10)+Chr(13) o #$D#$A entre el RFC y la Leyenda.

 //Ejemplo:
 // Sin Leyenda              : '|1.1|4ab11a49-cdcf-4e42-8278-3b89219431ca|2018-09-11T15:53:23|AAA010101AAA|ghabiW....Bxl7Q==|20001000000300022323'
 // Con Leyenda ('' � 'XX..'): '|1.1|4ab11a49-cdcf-4e42-8278-3b89219431ca|2018-09-11T15:53:23|AAA010101AAA'+'#$D#$A'+'||ghabiW....Bxl7Q==|20001000000300022323'

 // Por la tanto si el nodo de la Leyenda se auto-agreg� despu�s del timbrado,
 // este se eliminar� si el nodo est� vac�o para evitar ese error

 nodoLeyenda := self.AttributeNodes.FindNode('Leyenda');
 if Assigned( nodoLeyenda ) and
   (nodoLeyenda.Text='') and
   (self.AttributeNodes.IndexOf('Leyenda') = (self.AttributeNodes.Count-1) ) Then
 begin
  {Si la posici�n del nodo Leyenda es la �ltima en la lista de nodos,
   quiere decir que se agreg� despu�s del timbrado, por lo tanto se elimina}
  self.AttributeNodes.Delete('Leyenda');
 end;
 result := inherited GetXML;
end;

function TTimbreFiscalDigitalV33.Get_FechaTimbrado: UnicodeString;
begin
  Result := AttributeNodes['FechaTimbrado'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_FechaTimbrado(Value: UnicodeString);
begin
  SetAttribute('FechaTimbrado', Value);
end;

function TTimbreFiscalDigitalV33.Get_RfcProvCertif: UnicodeString;
begin
  Result := AttributeNodes['RfcProvCertif'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_RfcProvCertif(Value: UnicodeString);
begin
  SetAttribute('RfcProvCertif', Value);
end;

function TTimbreFiscalDigitalV33.Get_Leyenda: UnicodeString;
begin
  Result := AttributeNodes['Leyenda'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_Leyenda(Value: UnicodeString);
begin
  SetAttribute('Leyenda', Value);
end;

function TTimbreFiscalDigitalV33.Get_SelloCFD: UnicodeString;
begin
  Result := AttributeNodes['SelloCFD'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_SelloCFD(Value: UnicodeString);
begin
  SetAttribute('SelloCFD', Value);
end;

function TTimbreFiscalDigitalV33.Get_NoCertificadoSAT: UnicodeString;
begin
  Result := AttributeNodes['NoCertificadoSAT'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_NoCertificadoSAT(Value: UnicodeString);
begin
  SetAttribute('NoCertificadoSAT', Value);
end;

function TTimbreFiscalDigitalV33.Get_SelloSAT: UnicodeString;
begin
  Result := AttributeNodes['SelloSAT'].Text;
end;

procedure TTimbreFiscalDigitalV33.Set_SelloSAT(Value: UnicodeString);
begin
  SetAttribute('SelloSAT', Value);
end;

end.