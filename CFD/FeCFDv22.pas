
{****************************************************************************************}
{                                                                                        }
{                                    XML Data Binding                                    }
{                                                                                        }
{                                                                                        }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv22.xsd            }
{   Settings stored in: C:\Delphi\eleventa\externos\TFacturaElectronica\CFD\cfdv22.xdb   }
{                                                                                        }
{****************************************************************************************}

unit FeCFDv22;

interface

uses xmldom, XMLDoc, XMLIntf, FeCFDv2, FeCFD;

type

  IXMLComprobante_Emisor_RegimenFiscal = interface;
  IXMLComprobante_Emisor_RegimenFiscalList = interface;
  IFEXmlEmisorV22 = Interface;

  // Creamos el comprobante que hereda la v2.0
  IFEXMLComprobanteV22 = interface(IFEXMLComprobante)
  ['{8795E283-4283-4904-B6BD-D730D24AE80A}']
    { Property Accessors }
    function GetVersion: UnicodeString;
    function GetSerie: UnicodeString;
    function GetFolio: UnicodeString;
    function GetFecha: UnicodeString;
    function GetSello: UnicodeString;
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: UnicodeString;
    function GetNoCertificado: UnicodeString;
    function GetCertificado: UnicodeString;
    function GetCondicionesDePago: UnicodeString;
    function GetSubTotal: UnicodeString;
    function GetDescuento: UnicodeString;
    function GetMotivoDescuento: UnicodeString;
    function GetTipoCambio: UnicodeString;
    function GetMoneda: UnicodeString;
    function GetTotal: UnicodeString;
    function GetTipoDeComprobante: UnicodeString;
    function GetMetodoDePago: UnicodeString;
    function GetLugarExpedicion: UnicodeString;
    function GetNumCtaPago: UnicodeString;
    function GetFolioFiscalOrig: UnicodeString;
    function GetSerieFolioFiscalOrig: UnicodeString;
    function GetFechaFolioFiscalOrig: UnicodeString;
    function GetMontoFolioFiscalOrig: UnicodeString;
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: UnicodeString);
    procedure SetSerie(Value: UnicodeString);
    procedure SetFolio(Value: UnicodeString);
    procedure SetFecha(Value: UnicodeString);
    procedure SetSello(Value: UnicodeString);
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: UnicodeString);
    procedure SetNoCertificado(Value: UnicodeString);
    procedure SetCertificado(Value: UnicodeString);
    procedure SetCondicionesDePago(Value: UnicodeString);
    procedure SetSubTotal(Value: UnicodeString);
    procedure SetDescuento(Value: UnicodeString);
    procedure SetMotivoDescuento(Value: UnicodeString);
    procedure SetTipoCambio(Value: UnicodeString);
    procedure SetMoneda(Value: UnicodeString);
    procedure SetTotal(Value: UnicodeString);
    procedure SetTipoDeComprobante(Value: UnicodeString);
    procedure SetMetodoDePago(Value: UnicodeString);
    procedure SetLugarExpedicion(Value: UnicodeString);
    procedure SetNumCtaPago(Value: UnicodeString);
    procedure SetFolioFiscalOrig(Value: UnicodeString);
    procedure SetSerieFolioFiscalOrig(Value: UnicodeString);
    procedure SetFechaFolioFiscalOrig(Value: UnicodeString);
    procedure SetMontoFolioFiscalOrig(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read GetVersion write SetVersion;
    property Serie: UnicodeString read GetSerie write SetSerie;
    property Folio: UnicodeString read GetFolio write SetFolio;
    property Fecha: UnicodeString read GetFecha write SetFecha;
    property Sello: UnicodeString read GetSello write SetSello;
    property NoAprobacion: Integer read GetNoAprobacion write SetNoAprobacion;
    property AnoAprobacion: Integer read GetAnoAprobacion write SetAnoAprobacion;
    property FormaDePago: UnicodeString read GetFormaDePago write SetFormaDePago;
    property NoCertificado: UnicodeString read GetNoCertificado write SetNoCertificado;
    property Certificado: UnicodeString read GetCertificado write SetCertificado;
    property CondicionesDePago: UnicodeString read GetCondicionesDePago write SetCondicionesDePago;
    property SubTotal: UnicodeString read GetSubTotal write SetSubTotal;
    property Descuento: UnicodeString read GetDescuento write SetDescuento;
    property MotivoDescuento: UnicodeString read GetMotivoDescuento write SetMotivoDescuento;
    property TipoCambio: UnicodeString read GetTipoCambio write SetTipoCambio;
    property Moneda: UnicodeString read GetMoneda write SetMoneda;
    property Total: UnicodeString read GetTotal write SetTotal;
    property TipoDeComprobante: UnicodeString read GetTipoDeComprobante write SetTipoDeComprobante;
    property MetodoDePago: UnicodeString read GetMetodoDePago write SetMetodoDePago;
    property LugarExpedicion: UnicodeString read GetLugarExpedicion write SetLugarExpedicion;
    property NumCtaPago: UnicodeString read GetNumCtaPago write SetNumCtaPago;
    property FolioFiscalOrig: UnicodeString read GetFolioFiscalOrig write SetFolioFiscalOrig;
    property SerieFolioFiscalOrig: UnicodeString read GetSerieFolioFiscalOrig write SetSerieFolioFiscalOrig;
    property FechaFolioFiscalOrig: UnicodeString read GetFechaFolioFiscalOrig write SetFechaFolioFiscalOrig;
    property MontoFolioFiscalOrig: UnicodeString read GetMontoFolioFiscalOrig write SetMontoFolioFiscalOrig;
    property Emisor: IFEXmlEmisorV22 read GetEmisor;
    property Receptor: IFEXmlReceptor read GetReceptor;
    property Conceptos: IFEXmlConceptos read GetConceptos;
    property Impuestos: IFEXmlImpuestos read GetImpuestos;
    property Complemento: IFEXmlComplemento read GetComplemento;
    property Addenda: IFEXmlAddenda read GetAddenda;
  end;

{ IFEXmlEmisorV22 }
  IFEXmlEmisorV22 = interface(IFEXmlEmisorV2)
  ['{FCAB82C8-71A2-427D-97F4-82719291344E}']
    function GetRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
    property RegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList read GetRegimenFiscal;
  end;

{ IXMLComprobante_Emisor_RegimenFiscal }
  IXMLComprobante_Emisor_RegimenFiscal = interface(IXMLNode)
    ['{A6293FB5-7AA2-42F0-8D41-13D8FC3EA731}']
    { Property Accessors }
    function GetRegimen: UnicodeString;
    procedure SetRegimen(Value: UnicodeString);
    { Methods & Properties }
    property Regimen: UnicodeString read GetRegimen write SetRegimen;
  end;

{ IXMLComprobante_Emisor_RegimenFiscalList }
  IXMLComprobante_Emisor_RegimenFiscalList = interface(IXMLNodeCollection)
    ['{F0D8DAEC-18CC-40CC-AA35-43690BBCEFFA}']
    { Methods & Properties }
    function Add: IXMLComprobante_Emisor_RegimenFiscal;
    function Insert(const Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;

    function GetItem(Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
    property Items[Index: Integer]: IXMLComprobante_Emisor_RegimenFiscal read GetItem; default;
  end;

{ IXMLComprobante_Conceptos_Concepto_Parte }
  TXMLIFEXMLComprobanteV22 = class;
  TXMLIFEXMLComprobanteEmisorV22 = class;
  TXMLT_UbicacionFiscal = class;
  TXMLT_Ubicacion = class;
  TXMLComprobante_Emisor_RegimenFiscal = class;
  TXMLComprobante_Emisor_RegimenFiscalList = class;

{ TXMLIFEXMLComprobante }

  TXMLIFEXMLComprobanteV22 = class(TXMLNode, IFEXMLComprobanteV22)
  protected
    { IFEXMLComprobanteV22 }
    function GetVersion: UnicodeString;
    function GetSerie: UnicodeString;
    function GetFolio: UnicodeString;
    function GetFecha: UnicodeString;
    function GetSello: UnicodeString;
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: UnicodeString;
    function GetNoCertificado: UnicodeString;
    function GetCertificado: UnicodeString;
    function GetCondicionesDePago: UnicodeString;
    function GetSubTotal: UnicodeString;
    function GetDescuento: UnicodeString;
    function GetMotivoDescuento: UnicodeString;
    function GetTipoCambio: UnicodeString;
    function GetMoneda: UnicodeString;
    function GetTotal: UnicodeString;
    function GetTipoDeComprobante: UnicodeString;
    function GetMetodoDePago: UnicodeString;
    function GetLugarExpedicion: UnicodeString;
    function GetNumCtaPago: UnicodeString;
    function GetFolioFiscalOrig: UnicodeString;
    function GetSerieFolioFiscalOrig: UnicodeString;
    function GetFechaFolioFiscalOrig: UnicodeString;
    function GetMontoFolioFiscalOrig: UnicodeString;
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: UnicodeString);
    procedure SetSerie(Value: UnicodeString);
    procedure SetFolio(Value: UnicodeString);
    procedure SetFecha(Value: UnicodeString);
    procedure SetSello(Value: UnicodeString);
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: UnicodeString);
    procedure SetNoCertificado(Value: UnicodeString);
    procedure SetCertificado(Value: UnicodeString);
    procedure SetCondicionesDePago(Value: UnicodeString);
    procedure SetSubTotal(Value: UnicodeString);
    procedure SetDescuento(Value: UnicodeString);
    procedure SetMotivoDescuento(Value: UnicodeString);
    procedure SetTipoCambio(Value: UnicodeString);
    procedure SetMoneda(Value: UnicodeString);
    procedure SetTotal(Value: UnicodeString);
    procedure SetTipoDeComprobante(Value: UnicodeString);
    procedure SetMetodoDePago(Value: UnicodeString);
    procedure SetLugarExpedicion(Value: UnicodeString);
    procedure SetNumCtaPago(Value: UnicodeString);
    procedure SetFolioFiscalOrig(Value: UnicodeString);
    procedure SetSerieFolioFiscalOrig(Value: UnicodeString);
    procedure SetFechaFolioFiscalOrig(Value: UnicodeString);
    procedure SetMontoFolioFiscalOrig(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIFEXMLComprobanteEmisorV22 }

  TXMLIFEXMLComprobanteEmisorV22 = class(TXMLNode, IFEXmlEmisorV22)
  private
    FRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
  protected
    { IFEXmlEmisorV22 }
    function GetRfc: UnicodeString;
    function GetNombre: UnicodeString;
    function GetDomicilioFiscal: IFEXMLT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    function GetRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
    procedure SetRfc(Value: UnicodeString);
    procedure SetNombre(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLT_UbicacionFiscal }

  TXMLT_UbicacionFiscal = class(TXMLNode, IFEXMLT_UbicacionFiscal)
  protected
    { IFEXMLT_UbicacionFiscal }
    function GetCalle: UnicodeString;
    function GetNoExterior: UnicodeString;
    function GetNoInterior: UnicodeString;
    function GetColonia: UnicodeString;
    function GetLocalidad: UnicodeString;
    function GetReferencia: UnicodeString;
    function GetMunicipio: UnicodeString;
    function GetEstado: UnicodeString;
    function GetPais: UnicodeString;
    function GetCodigoPostal: UnicodeString;
    procedure SetCalle(Value: UnicodeString);
    procedure SetNoExterior(Value: UnicodeString);
    procedure SetNoInterior(Value: UnicodeString);
    procedure SetColonia(Value: UnicodeString);
    procedure SetLocalidad(Value: UnicodeString);
    procedure SetReferencia(Value: UnicodeString);
    procedure SetMunicipio(Value: UnicodeString);
    procedure SetEstado(Value: UnicodeString);
    procedure SetPais(Value: UnicodeString);
    procedure SetCodigoPostal(Value: UnicodeString);
  end;

{ TXMLT_Ubicacion }

  TXMLT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
  protected
    { IFEXmlT_Ubicacion }
    function GetCalle: UnicodeString;
    function GetNoExterior: UnicodeString;
    function GetNoInterior: UnicodeString;
    function GetColonia: UnicodeString;
    function GetLocalidad: UnicodeString;
    function GetReferencia: UnicodeString;
    function GetMunicipio: UnicodeString;
    function GetEstado: UnicodeString;
    function GetPais: UnicodeString;
    function GetCodigoPostal: UnicodeString;
    procedure SetCalle(Value: UnicodeString);
    procedure SetNoExterior(Value: UnicodeString);
    procedure SetNoInterior(Value: UnicodeString);
    procedure SetColonia(Value: UnicodeString);
    procedure SetLocalidad(Value: UnicodeString);
    procedure SetReferencia(Value: UnicodeString);
    procedure SetMunicipio(Value: UnicodeString);
    procedure SetEstado(Value: UnicodeString);
    procedure SetPais(Value: UnicodeString);
    procedure SetCodigoPostal(Value: UnicodeString);
  end;

{ TXMLComprobante_Emisor_RegimenFiscal }
  TXMLComprobante_Emisor_RegimenFiscal = class(TXMLNode, IXMLComprobante_Emisor_RegimenFiscal)
  protected
    { IXMLComprobante_Emisor_RegimenFiscal }
    function GetRegimen: UnicodeString;
    procedure SetRegimen(Value: UnicodeString);
  end;

{ TXMLComprobante_Emisor_RegimenFiscalList }
  TXMLComprobante_Emisor_RegimenFiscalList = class(TXMLNodeCollection, IXMLComprobante_Emisor_RegimenFiscalList)
  protected
    { IXMLComprobante_Emisor_RegimenFiscalList }
    function Add: IXMLComprobante_Emisor_RegimenFiscal;
    function Insert(const Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;

    function GetItem(Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
  end;

function GetComprobanteV22(Doc: IXMLDocument): IFEXMLComprobanteV22;
function LoadComprobanteV22(const FileName: string): IFEXMLComprobanteV22;
function NewComprobanteV22: IFEXMLComprobanteV22;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobanteV22(Doc: IXMLDocument): IFEXMLComprobanteV22;
begin
  Result := Doc.GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

function LoadComprobanteV22(const FileName: string): IFEXMLComprobanteV22;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

function NewComprobanteV22: IFEXMLComprobanteV22;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

{ TXMLIFEXMLComprobante }

procedure TXMLIFEXMLComprobanteV22.AfterConstruction;
begin
  RegisterChildNode('Emisor', TXMLIFEXMLComprobanteEmisorV22);
  RegisterChildNode('Receptor', TFEXmlReceptor);
  RegisterChildNode('Conceptos', TFEXmlConceptos);
  RegisterChildNode('Impuestos', TFEXmlImpuestos);
  RegisterChildNode('Complemento', TFEXmlComplemento);
  RegisterChildNode('Addenda', TFEXmlAddenda);
  inherited;
end;

function TXMLIFEXMLComprobanteV22.GetVersion: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetVersion(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLIFEXMLComprobanteV22.GetSerie: UnicodeString;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetSerie(Value: UnicodeString);
begin
  SetAttribute('serie', Value);
end;

function TXMLIFEXMLComprobanteV22.GetFolio: UnicodeString;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetFolio(Value: UnicodeString);
begin
  SetAttribute('folio', Value);
end;

function TXMLIFEXMLComprobanteV22.GetFecha: UnicodeString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetFecha(Value: UnicodeString);
begin
  SetAttribute('fecha', Value);
end;

function TXMLIFEXMLComprobanteV22.GetSello: UnicodeString;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetSello(Value: UnicodeString);
begin
  SetAttribute('sello', Value);
end;

function TXMLIFEXMLComprobanteV22.GetNoAprobacion: Integer;
begin
  Result := AttributeNodes['noAprobacion'].NodeValue;
end;

procedure TXMLIFEXMLComprobanteV22.SetNoAprobacion(Value: Integer);
begin
  SetAttribute('noAprobacion', Value);
end;

function TXMLIFEXMLComprobanteV22.GetAnoAprobacion: Integer;
begin
  Result := AttributeNodes['anoAprobacion'].NodeValue;
end;

procedure TXMLIFEXMLComprobanteV22.SetAnoAprobacion(Value: Integer);
begin
  SetAttribute('anoAprobacion', Value);
end;

function TXMLIFEXMLComprobanteV22.GetFormaDePago: UnicodeString;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetFormaDePago(Value: UnicodeString);
begin
  SetAttribute('formaDePago', Value);
end;

function TXMLIFEXMLComprobanteV22.GetNoCertificado: UnicodeString;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetNoCertificado(Value: UnicodeString);
begin
  SetAttribute('noCertificado', Value);
end;

function TXMLIFEXMLComprobanteV22.GetCertificado: UnicodeString;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetCertificado(Value: UnicodeString);
begin
  SetAttribute('certificado', Value);
end;

function TXMLIFEXMLComprobanteV22.GetCondicionesDePago: UnicodeString;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetCondicionesDePago(Value: UnicodeString);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TXMLIFEXMLComprobanteV22.GetSubTotal: UnicodeString;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetSubTotal(Value: UnicodeString);
begin
  SetAttribute('subTotal', Value);
end;

function TXMLIFEXMLComprobanteV22.GetDescuento: UnicodeString;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetDescuento(Value: UnicodeString);
begin
  SetAttribute('descuento', Value);
end;

function TXMLIFEXMLComprobanteV22.GetMotivoDescuento: UnicodeString;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetMotivoDescuento(Value: UnicodeString);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TXMLIFEXMLComprobanteV22.GetTipoCambio: UnicodeString;
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetTipoCambio(Value: UnicodeString);
begin
  SetAttribute('TipoCambio', Value);
end;

function TXMLIFEXMLComprobanteV22.GetMoneda: UnicodeString;
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetMoneda(Value: UnicodeString);
begin
  SetAttribute('Moneda', Value);
end;

function TXMLIFEXMLComprobanteV22.GetTotal: UnicodeString;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetTotal(Value: UnicodeString);
begin
  SetAttribute('total', Value);
end;

function TXMLIFEXMLComprobanteV22.GetTipoDeComprobante: UnicodeString;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetTipoDeComprobante(Value: UnicodeString);
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TXMLIFEXMLComprobanteV22.GetMetodoDePago: UnicodeString;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetMetodoDePago(Value: UnicodeString);
begin
  SetAttribute('metodoDePago', Value);
end;

function TXMLIFEXMLComprobanteV22.GetLugarExpedicion: UnicodeString;
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetLugarExpedicion(Value: UnicodeString);
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TXMLIFEXMLComprobanteV22.GetNumCtaPago: UnicodeString;
begin
  Result := AttributeNodes['NumCtaPago'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetNumCtaPago(Value: UnicodeString);
begin
  SetAttribute('NumCtaPago', Value);
end;

function TXMLIFEXMLComprobanteV22.GetFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['FolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('FolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV22.GetSerieFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['SerieFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetSerieFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('SerieFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV22.GetFechaFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['FechaFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetFechaFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('FechaFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV22.GetMontoFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['MontoFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV22.SetMontoFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('MontoFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV22.GetEmisor: IFEXmlEmisorV22;
begin
  Result := ChildNodes['Emisor'] as IFEXmlEmisorV22;
end;

function TXMLIFEXMLComprobanteV22.GetReceptor: IFEXmlReceptor;
begin
  Result := ChildNodes['Receptor'] as IFEXmlReceptor;
end;

function TXMLIFEXMLComprobanteV22.GetConceptos: IFEXmlConceptos;
begin
  Result := ChildNodes['Conceptos'] as IFEXmlConceptos;
end;

function TXMLIFEXMLComprobanteV22.GetImpuestos: IFEXmlImpuestos;
begin
  Result := ChildNodes['Impuestos'] as IFEXmlImpuestos;
end;

function TXMLIFEXMLComprobanteV22.GetComplemento: IFEXmlComplemento;
begin
  Result := ChildNodes['Complemento'] as IFEXmlComplemento;
end;

function TXMLIFEXMLComprobanteV22.GetAddenda: IFEXmlAddenda;
begin
  Result := ChildNodes['Addenda'] as IFEXmlAddenda;
end;

{ TXMLIFEXMLComprobanteEmisorV22 }

procedure TXMLIFEXMLComprobanteEmisorV22.AfterConstruction;
begin
  RegisterChildNode('DomicilioFiscal', TXMLT_UbicacionFiscal);
  RegisterChildNode('ExpedidoEn', TXMLT_Ubicacion);
  RegisterChildNode('RegimenFiscal', TXMLComprobante_Emisor_RegimenFiscal);
  FRegimenFiscal := CreateCollection(TXMLComprobante_Emisor_RegimenFiscalList,
                                     IXMLComprobante_Emisor_RegimenFiscal,
                                     'RegimenFiscal') as IXMLComprobante_Emisor_RegimenFiscalList;
  inherited;
end;

function TXMLIFEXMLComprobanteEmisorV22.GetRfc: UnicodeString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TXMLIFEXMLComprobanteEmisorV22.SetRfc(Value: UnicodeString);
begin
  SetAttribute('rfc', Value);
end;

function TXMLIFEXMLComprobanteEmisorV22.GetNombre: UnicodeString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TXMLIFEXMLComprobanteEmisorV22.SetNombre(Value: UnicodeString);
begin
  SetAttribute('nombre', Value);
end;

function TXMLIFEXMLComprobanteEmisorV22.GetDomicilioFiscal: IFEXMLT_UbicacionFiscal;
begin
  Result := ChildNodes['DomicilioFiscal'] as IFEXMLT_UbicacionFiscal;
end;

function TXMLIFEXMLComprobanteEmisorV22.GetExpedidoEn: IFEXmlT_Ubicacion;
begin
  Result := ChildNodes['ExpedidoEn'] as IFEXmlT_Ubicacion;
end;

function TXMLIFEXMLComprobanteEmisorV22.GetRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
begin
  Result := FRegimenFiscal;
end;

{ TXMLT_UbicacionFiscal }

function TXMLT_UbicacionFiscal.GetCalle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCalle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_UbicacionFiscal.GetNoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_UbicacionFiscal.GetNoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_UbicacionFiscal.GetColonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetColonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_UbicacionFiscal.GetLocalidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetLocalidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_UbicacionFiscal.GetReferencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetReferencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_UbicacionFiscal.GetMunicipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetMunicipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_UbicacionFiscal.GetEstado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetEstado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_UbicacionFiscal.GetPais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetPais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_UbicacionFiscal.GetCodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLT_Ubicacion }

function TXMLT_Ubicacion.GetCalle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_Ubicacion.SetCalle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_Ubicacion.GetNoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_Ubicacion.GetNoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_Ubicacion.GetColonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_Ubicacion.SetColonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_Ubicacion.GetLocalidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_Ubicacion.SetLocalidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_Ubicacion.GetReferencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_Ubicacion.SetReferencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_Ubicacion.GetMunicipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_Ubicacion.SetMunicipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_Ubicacion.GetEstado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_Ubicacion.SetEstado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_Ubicacion.GetPais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_Ubicacion.SetPais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_Ubicacion.GetCodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_Ubicacion.SetCodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscal }

function TXMLComprobante_Emisor_RegimenFiscal.GetRegimen: UnicodeString;
begin
  Result := AttributeNodes['Regimen'].Text;
end;

procedure TXMLComprobante_Emisor_RegimenFiscal.SetRegimen(Value: UnicodeString);
begin
  SetAttribute('Regimen', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscalList }

function TXMLComprobante_Emisor_RegimenFiscalList.Add: IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result := AddItem(-1) as IXMLComprobante_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.Insert(const Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result := AddItem(Index) as IXMLComprobante_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.GetItem(Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result := List[Index] as IXMLComprobante_Emisor_RegimenFiscal;
end;

end.