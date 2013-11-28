unit FeCFDv32;

interface

uses xmldom, XMLDoc, XMLIntf, FeCFD,FeCFDv22,FeCFDv2,FETimbreFiscalDigital;

type
  // Creamos el comprobante que hereda la v2.0
  IFEXMLComprobanteV32 = interface(IFEXMLComprobante)
  ['{8795E283-4283-4904-B6BD-D730D24AE80A}']
    { Property Accessors }
    function GetVersion: String;
    function GetSerie: String;
    function GetFolio: String;
    function GetFecha: String;
    function GetSello: String;
    function GetFormaDePago: String;
    function GetNoCertificado: String;
    function GetCertificado: String;
    function GetCondicionesDePago: String;
    function GetSubTotal: String;
    function GetDescuento: String;
    function GetMotivoDescuento: String;
    function GetTipoCambio: String;
    function GetMoneda: String;
    function GetTotal: String;
    function GetTipoDeComprobante: String;
    function GetMetodoDePago: String;
    function GetLugarExpedicion: String;
    function GetNumCtaPago: String;
    function GetFolioFiscalOrig: String;
    function GetSerieFolioFiscalOrig: String;
    function GetFechaFolioFiscalOrig: String;
    function GetMontoFolioFiscalOrig: String;
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: String);
    procedure SetSerie(Value: String);
    procedure SetFolio(Value: String);
    procedure SetFecha(Value: String);
    procedure SetSello(Value: String);
    procedure SetFormaDePago(Value: String);
    procedure SetNoCertificado(Value: String);
    procedure SetCertificado(Value: String);
    procedure SetCondicionesDePago(Value: String);
    procedure SetSubTotal(Value: String);
    procedure SetDescuento(Value: String);
    procedure SetMotivoDescuento(Value: String);
    procedure SetTipoCambio(Value: String);
    procedure SetMoneda(Value: String);
    procedure SetTotal(Value: String);
    procedure SetTipoDeComprobante(Value: String);
    procedure SetMetodoDePago(Value: String);
    procedure SetLugarExpedicion(Value: String);
    procedure SetNumCtaPago(Value: String);
    procedure SetFolioFiscalOrig(Value: String);
    procedure SetSerieFolioFiscalOrig(Value: String);
    procedure SetFechaFolioFiscalOrig(Value: String);
    procedure SetMontoFolioFiscalOrig(Value: String);
    { Methods & Properties }
    property Version: String read GetVersion write SetVersion;
    property Serie: String read GetSerie write SetSerie;
    property Folio: String read GetFolio write SetFolio;
    property Fecha: String read GetFecha write SetFecha;
    property Sello: String read GetSello write SetSello;
    property FormaDePago: String read GetFormaDePago write SetFormaDePago;
    property NoCertificado: String read GetNoCertificado write SetNoCertificado;
    property Certificado: String read GetCertificado write SetCertificado;
    property CondicionesDePago: String read GetCondicionesDePago write SetCondicionesDePago;
    property SubTotal: String read GetSubTotal write SetSubTotal;
    property Descuento: String read GetDescuento write SetDescuento;
    property MotivoDescuento: String read GetMotivoDescuento write SetMotivoDescuento;
    property TipoCambio: String read GetTipoCambio write SetTipoCambio;
    property Moneda: String read GetMoneda write SetMoneda;
    property Total: String read GetTotal write SetTotal;
    property TipoDeComprobante: String read GetTipoDeComprobante write SetTipoDeComprobante;
    property MetodoDePago: String read GetMetodoDePago write SetMetodoDePago;
    property LugarExpedicion: String read GetLugarExpedicion write SetLugarExpedicion;
    property NumCtaPago: String read GetNumCtaPago write SetNumCtaPago;
    property FolioFiscalOrig: String read GetFolioFiscalOrig write SetFolioFiscalOrig;
    property SerieFolioFiscalOrig: String read GetSerieFolioFiscalOrig write SetSerieFolioFiscalOrig;
    property FechaFolioFiscalOrig: String read GetFechaFolioFiscalOrig write SetFechaFolioFiscalOrig;
    property MontoFolioFiscalOrig: String read GetMontoFolioFiscalOrig write SetMontoFolioFiscalOrig;
    property Emisor: IFEXmlEmisorV22 read GetEmisor;
    property Receptor: IFEXmlReceptor read GetReceptor;
    property Conceptos: IFEXmlConceptos read GetConceptos;
    property Impuestos: IFEXmlImpuestos read GetImpuestos;
    property Complemento: IFEXmlComplemento read GetComplemento;
    property Addenda: IFEXmlAddenda read GetAddenda;
  end;

{ TXMLIFEXMLComprobante }
  TXMLIFEXMLComprobanteV32 = class(TXMLNode, IFEXMLComprobanteV32)
  protected

    { IFEXMLComprobanteV32 }
    function GetVersion: String;
    function GetSerie: String;
    function GetFolio: String;
    function GetFecha: String;
    function GetSello: String;
    function GetFormaDePago: String;
    function GetNoCertificado: String;
    function GetCertificado: String;
    function GetCondicionesDePago: String;
    function GetSubTotal: String;
    function GetDescuento: String;
    function GetMotivoDescuento: String;
    function GetTipoCambio: String;
    function GetMoneda: String;
    function GetTotal: String;
    function GetTipoDeComprobante: String;
    function GetMetodoDePago: String;
    function GetLugarExpedicion: String;
    function GetNumCtaPago: String;
    function GetFolioFiscalOrig: String;
    function GetSerieFolioFiscalOrig: String;
    function GetFechaFolioFiscalOrig: String;
    function GetMontoFolioFiscalOrig: String;
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: String);
    procedure SetSerie(Value: String);
    procedure SetFolio(Value: String);
    procedure SetFecha(Value: String);
    procedure SetSello(Value: String);
    procedure SetFormaDePago(Value: String);
    procedure SetNoCertificado(Value: String);
    procedure SetCertificado(Value: String);
    procedure SetCondicionesDePago(Value: String);
    procedure SetSubTotal(Value: String);
    procedure SetDescuento(Value: String);
    procedure SetMotivoDescuento(Value: String);
    procedure SetTipoCambio(Value: String);
    procedure SetMoneda(Value: String);
    procedure SetTotal(Value: String);
    procedure SetTipoDeComprobante(Value: String);
    procedure SetMetodoDePago(Value: String);
    procedure SetLugarExpedicion(Value: String);
    procedure SetNumCtaPago(Value: String);
    procedure SetFolioFiscalOrig(Value: String);
    procedure SetSerieFolioFiscalOrig(Value: String);
    procedure SetFechaFolioFiscalOrig(Value: String);
    procedure SetMontoFolioFiscalOrig(Value: String);
  public
    procedure AfterConstruction; override;
  end;


{ TXMLT_UbicacionFiscal }

  TXMLT_UbicacionFiscal = class(TXMLNode, IFEXMLT_UbicacionFiscal)
  protected
    { IFEXMLT_UbicacionFiscal }
    function GetCalle: String;
    function GetNoExterior: String;
    function GetNoInterior: String;
    function GetColonia: String;
    function GetLocalidad: String;
    function GetReferencia: String;
    function GetMunicipio: String;
    function GetEstado: String;
    function GetPais: String;
    function GetCodigoPostal: String;
    procedure SetCalle(Value: String);
    procedure SetNoExterior(Value: String);
    procedure SetNoInterior(Value: String);
    procedure SetColonia(Value: String);
    procedure SetLocalidad(Value: String);
    procedure SetReferencia(Value: String);
    procedure SetMunicipio(Value: String);
    procedure SetEstado(Value: String);
    procedure SetPais(Value: String);
    procedure SetCodigoPostal(Value: String);
  end;

{ TXMLT_Ubicacion }

  TXMLT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
  protected
    { IFEXmlT_Ubicacion }
    function GetCalle: String;
    function GetNoExterior: String;
    function GetNoInterior: String;
    function GetColonia: String;
    function GetLocalidad: String;
    function GetReferencia: String;
    function GetMunicipio: String;
    function GetEstado: String;
    function GetPais: String;
    function GetCodigoPostal: String;
    procedure SetCalle(Value: String);
    procedure SetNoExterior(Value: String);
    procedure SetNoInterior(Value: String);
    procedure SetColonia(Value: String);
    procedure SetLocalidad(Value: String);
    procedure SetReferencia(Value: String);
    procedure SetMunicipio(Value: String);
    procedure SetEstado(Value: String);
    procedure SetPais(Value: String);
    procedure SetCodigoPostal(Value: String);
  end;



{ TXMLComprobante_Emisor_RegimenFiscal }
  TXMLComprobante_Emisor_RegimenFiscal = class(TXMLNode, IXMLComprobante_Emisor_RegimenFiscal)
  protected
    { IXMLComprobante_Emisor_RegimenFiscal }
    function GetRegimen: String;
    procedure SetRegimen(Value: String);
  end;

{ TXMLComprobante_Emisor_RegimenFiscalList }
  TXMLComprobante_Emisor_RegimenFiscalList = class(TXMLNodeCollection, IXMLComprobante_Emisor_RegimenFiscalList)
  protected
    { IXMLComprobante_Emisor_RegimenFiscalList }
    function Add: IXMLComprobante_Emisor_RegimenFiscal;
    function Insert(const Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;

    function GetItem(Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
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

{ TXMLIFEXMLComprobante }

procedure TXMLIFEXMLComprobanteV32.AfterConstruction;
begin
  RegisterChildNode('Emisor', TXMLIFEXMLComprobanteEmisorV22);
  RegisterChildNode('Receptor', TFEXmlReceptor);
  RegisterChildNode('Conceptos', TFEXmlConceptos);
  RegisterChildNode('Impuestos', TFEXmlImpuestos);
  RegisterChildNode('Complemento', TFEXmlComplemento);

  RegisterChildNode('Addenda', TFEXmlAddenda);
  inherited;
end;

function TXMLIFEXMLComprobanteV32.GetVersion: String;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetVersion(Value: String);
begin
  SetAttribute('version', Value);
end;

function TXMLIFEXMLComprobanteV32.GetSerie: String;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetSerie(Value: String);
begin
  SetAttribute('serie', Value);
end;

function TXMLIFEXMLComprobanteV32.GetFolio: String;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetFolio(Value: String);
begin
  SetAttribute('folio', Value);
end;

function TXMLIFEXMLComprobanteV32.GetFecha: String;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetFecha(Value: String);
begin
  SetAttribute('fecha', Value);
end;

function TXMLIFEXMLComprobanteV32.GetSello: String;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetSello(Value: String);
begin
  SetAttribute('sello', Value);
end;

function TXMLIFEXMLComprobanteV32.GetFormaDePago: String;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetFormaDePago(Value: String);
begin
  SetAttribute('formaDePago', Value);
end;

function TXMLIFEXMLComprobanteV32.GetNoCertificado: String;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetNoCertificado(Value: String);
begin
  SetAttribute('noCertificado', Value);
end;

function TXMLIFEXMLComprobanteV32.GetCertificado: String;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetCertificado(Value: String);
begin
  SetAttribute('certificado', Value);
end;

function TXMLIFEXMLComprobanteV32.GetCondicionesDePago: String;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetCondicionesDePago(Value: String);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TXMLIFEXMLComprobanteV32.GetSubTotal: String;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetSubTotal(Value: String);
begin
  SetAttribute('subTotal', Value);
end;

function TXMLIFEXMLComprobanteV32.GetDescuento: String;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetDescuento(Value: String);
begin
  SetAttribute('descuento', Value);
end;

function TXMLIFEXMLComprobanteV32.GetMotivoDescuento: String;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetMotivoDescuento(Value: String);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TXMLIFEXMLComprobanteV32.GetTipoCambio: String;
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetTipoCambio(Value: String);
begin
  SetAttribute('TipoCambio', Value);
end;

function TXMLIFEXMLComprobanteV32.GetMoneda: String;
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetMoneda(Value: String);
begin
  SetAttribute('Moneda', Value);
end;

function TXMLIFEXMLComprobanteV32.GetTotal: String;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetTotal(Value: String);
begin
  SetAttribute('total', Value);
end;

function TXMLIFEXMLComprobanteV32.GetTipoDeComprobante: String;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetTipoDeComprobante(Value: String);
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TXMLIFEXMLComprobanteV32.GetMetodoDePago: String;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetMetodoDePago(Value: String);
begin
  SetAttribute('metodoDePago', Value);
end;

function TXMLIFEXMLComprobanteV32.GetLugarExpedicion: String;
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetLugarExpedicion(Value: String);
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TXMLIFEXMLComprobanteV32.GetNumCtaPago: String;
begin
  Result := AttributeNodes['NumCtaPago'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetNumCtaPago(Value: String);
begin
  SetAttribute('NumCtaPago', Value);
end;

function TXMLIFEXMLComprobanteV32.GetFolioFiscalOrig: String;
begin
  Result := AttributeNodes['FolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetFolioFiscalOrig(Value: String);
begin
  SetAttribute('FolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV32.GetSerieFolioFiscalOrig: String;
begin
  Result := AttributeNodes['SerieFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetSerieFolioFiscalOrig(Value: String);
begin
  SetAttribute('SerieFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV32.GetFechaFolioFiscalOrig: String;
begin
  Result := AttributeNodes['FechaFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetFechaFolioFiscalOrig(Value: String);
begin
  SetAttribute('FechaFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV32.GetMontoFolioFiscalOrig: String;
begin
  Result := AttributeNodes['MontoFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteV32.SetMontoFolioFiscalOrig(Value: String);
begin
  SetAttribute('MontoFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteV32.GetEmisor: IFEXmlEmisorV22;
begin
  Result := ChildNodes['Emisor'] as IFEXmlEmisorV22;
end;

function TXMLIFEXMLComprobanteV32.GetReceptor: IFEXmlReceptor;
begin
  Result := ChildNodes['Receptor'] as IFEXmlReceptor;
end;

function TXMLIFEXMLComprobanteV32.GetConceptos: IFEXmlConceptos;
begin
  Result := ChildNodes['Conceptos'] as IFEXmlConceptos;
end;

function TXMLIFEXMLComprobanteV32.GetImpuestos: IFEXmlImpuestos;
begin
  Result := ChildNodes['Impuestos'] as IFEXmlImpuestos;
end;

function TXMLIFEXMLComprobanteV32.GetComplemento: IFEXmlComplemento;
begin
  Result := ChildNodes['Complemento'] as IFEXmlComplemento;
end;

function TXMLIFEXMLComprobanteV32.GetAddenda: IFEXmlAddenda;
begin
  Result := ChildNodes['Addenda'] as IFEXmlAddenda;
end;

{ TXMLT_UbicacionFiscal }

function TXMLT_UbicacionFiscal.GetCalle: String;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCalle(Value: String);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_UbicacionFiscal.GetNoExterior: String;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoExterior(Value: String);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_UbicacionFiscal.GetNoInterior: String;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoInterior(Value: String);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_UbicacionFiscal.GetColonia: String;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetColonia(Value: String);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_UbicacionFiscal.GetLocalidad: String;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetLocalidad(Value: String);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_UbicacionFiscal.GetReferencia: String;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetReferencia(Value: String);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_UbicacionFiscal.GetMunicipio: String;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetMunicipio(Value: String);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_UbicacionFiscal.GetEstado: String;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetEstado(Value: String);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_UbicacionFiscal.GetPais: String;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetPais(Value: String);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_UbicacionFiscal.GetCodigoPostal: String;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCodigoPostal(Value: String);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLT_Ubicacion }

function TXMLT_Ubicacion.GetCalle: String;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_Ubicacion.SetCalle(Value: String);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_Ubicacion.GetNoExterior: String;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoExterior(Value: String);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_Ubicacion.GetNoInterior: String;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoInterior(Value: String);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_Ubicacion.GetColonia: String;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_Ubicacion.SetColonia(Value: String);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_Ubicacion.GetLocalidad: String;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_Ubicacion.SetLocalidad(Value: String);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_Ubicacion.GetReferencia: String;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_Ubicacion.SetReferencia(Value: String);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_Ubicacion.GetMunicipio: String;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_Ubicacion.SetMunicipio(Value: String);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_Ubicacion.GetEstado: String;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_Ubicacion.SetEstado(Value: String);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_Ubicacion.GetPais: String;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_Ubicacion.SetPais(Value: String);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_Ubicacion.GetCodigoPostal: String;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_Ubicacion.SetCodigoPostal(Value: String);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscal }

function TXMLComprobante_Emisor_RegimenFiscal.GetRegimen: String;
begin
  Result := AttributeNodes['Regimen'].Text;
end;

procedure TXMLComprobante_Emisor_RegimenFiscal.SetRegimen(Value: String);
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
