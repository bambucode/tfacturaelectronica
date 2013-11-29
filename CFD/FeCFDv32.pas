unit FeCFDv32;

interface

uses Xmldom,
     XMLDoc,
     XMLIntf,
     FeCFD,
     FeCFDv2,
     FeCFDv22,
     FETimbreFiscalDigital;

type
  // Creamos el comprobante que hereda la v2.2
  IFEXMLComprobanteV32 = interface(IFEXMLComprobanteV22)
  ['{E00E28F4-899F-4236-8AF4-897FF5C973E6}']
    { Property Accessors }
  end;

{ TXMLIFEXMLComprobante }
  TXMLIFEXMLComprobanteV32 = class(TXMLIFEXMLComprobanteBaseV22, IFEXMLComprobanteV32)
  public
  end;

function GetComprobanteV32(Doc: IXMLDocument): IFEXMLComprobanteV32;
function LoadComprobanteV32(const FileName: string): IFEXMLComprobanteV32;
function NewComprobanteV32: IFEXMLComprobanteV32;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/3';

implementation

{ Global Functions }

function GetComprobanteV32(Doc: IXMLDocument): IFEXMLComprobanteV32;
begin
  Result := Doc.GetDocBinding('cfdi:Comprobante', TXMLIFEXMLComprobanteV32, TargetNamespace) as IFEXMLComprobanteV32;
end;

function LoadComprobanteV32(const FileName: string): IFEXMLComprobanteV32;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV32, TargetNamespace) as IFEXMLComprobanteV32;
end;

function NewComprobanteV32: IFEXMLComprobanteV32;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV32, TargetNamespace) as IFEXMLComprobanteV32;
end;

end.
