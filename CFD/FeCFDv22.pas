{****************************************************************************************}
{                                                                                        }
{                                    XML Data Binding                                    }
{                                                                                        }
{                                                                                        }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv22.xsd            }
{                                                                                        }
{****************************************************************************************}

unit FeCFDv22;

interface

uses xmldom, XMLDoc, XMLIntf, FeCFDv2,FeCFD;

type

  IXMLComprobante_Emisor_RegimenFiscal = interface;
  IXMLComprobante_Emisor_RegimenFiscalList = interface;
  IFEXmlEmisorV22 = Interface;

  // Interfase que especifica una propiedad exclusiva de CFD v2.2
  IFESoportaBloqueFolios = interface
    ['{79484EE2-CD90-4ADF-A3DF-55D6607157A8}']
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    property NoAprobacion: Integer read GetNoAprobacion write SetNoAprobacion;
    property AnoAprobacion: Integer read GetAnoAprobacion write SetAnoAprobacion;
  end;

  // Creamos el comprobante que hereda la v2.0
  IFEXMLComprobanteV22 = interface(IFEXmlComprobante)
  ['{8795E283-4283-4904-B6BD-D730D24AE80A}']
    { Property Accessors }
    function GetVersion:{$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSerie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFolio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTipoCambio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMoneda: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetLugarExpedicion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNumCtaPago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSerieFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFechaFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMontoFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTipoCambio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMoneda(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetLugarExpedicion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNumCtaPago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSerieFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFechaFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMontoFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Version: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetVersion write SetVersion;
    property Serie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetSerie write SetSerie;
    property Folio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFolio write SetFolio;
    property Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFecha write SetFecha;
    property Sello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetSello write SetSello;

    property FormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFormaDePago write SetFormaDePago;
    property NoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoCertificado write SetNoCertificado;
    property Certificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCertificado write SetCertificado;
    property CondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCondicionesDePago write SetCondicionesDePago;
    property SubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetSubTotal write SetSubTotal;
    property Descuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetDescuento write SetDescuento;
    property MotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMotivoDescuento write SetMotivoDescuento;
    property TipoCambio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTipoCambio write SetTipoCambio;
    property Moneda: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMoneda write SetMoneda;
    property Total: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTotal write SetTotal;
    property TipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTipoDeComprobante write SetTipoDeComprobante;
    property MetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMetodoDePago write SetMetodoDePago;
    property LugarExpedicion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetLugarExpedicion write SetLugarExpedicion;
    property NumCtaPago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNumCtaPago write SetNumCtaPago;
    property FolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFolioFiscalOrig write SetFolioFiscalOrig;
    property SerieFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetSerieFolioFiscalOrig write SetSerieFolioFiscalOrig;
    property FechaFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFechaFolioFiscalOrig write SetFechaFolioFiscalOrig;
    property MontoFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMontoFolioFiscalOrig write SetMontoFolioFiscalOrig;
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
    function GetRegimen: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetRegimen(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Regimen: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetRegimen write SetRegimen;
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

  TXMLIFEXMLComprobanteBaseV22 = class(TXMLNode, IFEXMLComprobanteV22)
  protected
    function GetVersion: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetSerie: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetFolio: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetSello: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetCertificado: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetDescuento: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetTipoCambio: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetMoneda: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetTotal: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetLugarExpedicion: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetNumCtaPago: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetSerieFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetFechaFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetMontoFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString; {$ELSE} UTF8String; {$IFEND}
    function GetEmisor: IFEXmlEmisorV22;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos:  IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTipoCambio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMoneda(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetLugarExpedicion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNumCtaPago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSerieFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFechaFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMontoFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

  TXMLIFEXMLComprobanteV22 = class(TXMLIFEXMLComprobanteBaseV22, IFESoportaBloqueFolios)
  private
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
  public
    property NoAprobacion: Integer read GetNoAprobacion write SetNoAprobacion;
    property AnoAprobacion: Integer read GetAnoAprobacion write SetAnoAprobacion;
  end;

{ TXMLIFEXMLComprobanteEmisorV22 }
  TXMLIFEXMLComprobanteEmisorV22 = class(TXMLNode, IFEXmlEmisorV22)
  private
    FRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
  protected
    { IFEXmlEmisorV22 }
    function GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDomicilioFiscal: IFEXMLT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    function GetRegimenFiscal: IXMLComprobante_Emisor_RegimenFiscalList;
    procedure SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TXMLT_UbicacionFiscal }

  TXMLT_UbicacionFiscal = class(TXMLNode, IFEXMLT_UbicacionFiscal)
  protected
    { IFEXMLT_UbicacionFiscal }
    function GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TXMLT_Ubicacion }

  TXMLT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
  protected
    { IFEXmlT_Ubicacion }
    function GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TXMLComprobante_Emisor_RegimenFiscal }
  TXMLComprobante_Emisor_RegimenFiscal = class(TXMLNode, IXMLComprobante_Emisor_RegimenFiscal)
  protected
    { IXMLComprobante_Emisor_RegimenFiscal }
    function GetRegimen: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetRegimen(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
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
function LoadComprobanteV22(const FileName: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND}): IFEXMLComprobanteV22;
function NewComprobanteV22: IFEXMLComprobanteV22;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobanteV22(Doc: IXMLDocument): IFEXMLComprobanteV22;
begin
  Result := Doc.GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

function LoadComprobanteV22(const FileName: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND}): IFEXMLComprobanteV22;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

function NewComprobanteV22: IFEXMLComprobanteV22;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TXMLIFEXMLComprobanteV22, TargetNamespace) as IFEXMLComprobanteV22;
end;

{ TXMLIFEXMLComprobante }

procedure TXMLIFEXMLComprobanteBaseV22.AfterConstruction;
begin
  RegisterChildNode('Emisor', TXMLIFEXMLComprobanteEmisorV22);
  RegisterChildNode('Receptor', TFEXmlReceptor);
  RegisterChildNode('Conceptos', TFEXmlConceptos);
  RegisterChildNode('Impuestos', TFEXmlImpuestos);
  RegisterChildNode('Complemento', TFEXmlComplemento);
  RegisterChildNode('Addenda', TFEXmlAddenda);
  inherited;
end;

function TXMLIFEXMLComprobanteBaseV22.GetAddenda: IFEXmlAddenda;
begin
  Result := ChildNodes['Addenda'] as IFEXmlAddenda;
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

function TXMLIFEXMLComprobanteBaseV22.GetTipoCambio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetTipoCambio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('TipoCambio', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetReceptor: IFEXmlReceptor;
begin
  Result := ChildNodes['Receptor'] as IFEXmlReceptor;
end;

function TXMLIFEXMLComprobanteBaseV22.GetConceptos: IFEXmlConceptos;
begin
  Result := ChildNodes['Conceptos'] as IFEXmlConceptos;
end;

function TXMLIFEXMLComprobanteBaseV22.GetImpuestos: IFEXmlImpuestos;
begin
  Result := ChildNodes['Impuestos'] as IFEXmlImpuestos;
end;

function TXMLIFEXMLComprobanteBaseV22.GetComplemento: IFEXmlComplemento;
begin
  Result := ChildNodes['Complemento'] as IFEXmlComplemento;
end;

function TXMLIFEXMLComprobanteBaseV22.GetMoneda: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetMoneda(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Moneda', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['total'].Text;
end;

function TXMLIFEXMLComprobanteBaseV22.GetLugarExpedicion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetLugarExpedicion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetNumCtaPago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['NumCtaPago'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetNumCtaPago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('NumCtaPago', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['FolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('FolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetSerieFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['SerieFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetSerieFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('SerieFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetFechaFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['FechaFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetFechaFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('FechaFolioFiscalOrig', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetMontoFolioFiscalOrig: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['MontoFolioFiscalOrig'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetMontoFolioFiscalOrig(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('MontoFolioFiscalOrig', Value);
end;




function TXMLIFEXMLComprobanteBaseV22.GetEmisor: IFEXmlEmisorV22;
begin
  Result := ChildNodes['Emisor'] as IFEXmlEmisorV22;
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

function TXMLIFEXMLComprobanteBaseV22.GetVersion:  {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('version', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetSerie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('serie', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('formaDePago', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noCertificado', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('certificado', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('condicionesDePago', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('subTotal', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('descuento', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('motivoDescuento', Value);
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('total', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('metodoDePago', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetFolio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('folio', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('fecha', Value);
end;

function TXMLIFEXMLComprobanteBaseV22.GetSello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TXMLIFEXMLComprobanteBaseV22.SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('sello', Value);
end;
function TXMLIFEXMLComprobanteEmisorV22.GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TXMLIFEXMLComprobanteEmisorV22.SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('rfc', Value);
end;

function TXMLIFEXMLComprobanteEmisorV22.GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TXMLIFEXMLComprobanteEmisorV22.SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
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

function TXMLT_UbicacionFiscal.GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('calle', Value);
end;

function TXMLT_UbicacionFiscal.GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_UbicacionFiscal.GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_UbicacionFiscal.GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_UbicacionFiscal.GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_UbicacionFiscal.GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_UbicacionFiscal.GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_UbicacionFiscal.GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('estado', Value);
end;

function TXMLT_UbicacionFiscal.GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('pais', Value);
end;

function TXMLT_UbicacionFiscal.GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_UbicacionFiscal.SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLT_Ubicacion }

function TXMLT_Ubicacion.GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_Ubicacion.SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('calle', Value);
end;

function TXMLT_Ubicacion.GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_Ubicacion.GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_Ubicacion.SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_Ubicacion.GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_Ubicacion.SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_Ubicacion.GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_Ubicacion.SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_Ubicacion.GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_Ubicacion.SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_Ubicacion.GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_Ubicacion.SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_Ubicacion.GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_Ubicacion.SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('estado', Value);
end;

function TXMLT_Ubicacion.GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_Ubicacion.SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('pais', Value);
end;

function TXMLT_Ubicacion.GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_Ubicacion.SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscal }

function TXMLComprobante_Emisor_RegimenFiscal.GetRegimen: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Regimen'].Text;
end;

procedure TXMLComprobante_Emisor_RegimenFiscal.SetRegimen(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Regimen', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscalList }

function TXMLComprobante_Emisor_RegimenFiscalList.Add: IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result := AddChild(ItemTag, ItemNS, True, -1) as IXMLComprobante_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.Insert(const Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result :=AddChild(ItemTag, ItemNS, True, Index) as IXMLComprobante_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.GetItem(Index: Integer): IXMLComprobante_Emisor_RegimenFiscal;
begin
  Result := List[Index] as IXMLComprobante_Emisor_RegimenFiscal;
end;

end.