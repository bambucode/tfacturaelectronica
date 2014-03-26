unit FeCFDv2;

{*********************************************************************************}
{                                                                                 }
{                                XML Data Binding                                 }
{                                                                                 }
{         Generated on: 11/10/2010 12:27:18 p.m.                                  }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd      }
{                                                                                 }
{*********************************************************************************}

interface

uses xmldom, XMLDoc, XMLIntf, FeCFD;

type

  IFEXmlEmisorV2 = interface;

  IFEXmlComprobanteV2 = interface(IFEXmlComprobante)
  ['{6584BFA5-1FBC-44A6-A200-C4A70CBFE3F4}']
    function GetEmisor: IFEXmlEmisorV2;
    property Emisor: IFEXmlEmisorV2 read GetEmisor;
  end;

{ IFEXmlEmisorV2 }

  IFEXmlEmisorV2 = interface(IXMLNode)
  ['{C084D8B6-04E3-4DC8-94F3-584CD358CBC2}']
    { Property Accessors }
    function GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Rfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetRfc write SetRfc;
    property Nombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNombre write SetNombre;
    property DomicilioFiscal: IFEXmlT_UbicacionFiscal read GetDomicilioFiscal;
    property ExpedidoEn: IFEXmlT_Ubicacion read GetExpedidoEn;
  end;

  TFEXmlComprobanteV2 = class;
  TFEXmlEmisorV2 = class;

{ TFEXmlComprobanteV2 }

  TFEXmlComprobanteV2 = class(TXMLNode, IFEXmlComprobanteV2)
  protected
    { IFEXmlComprobanteV2 }
    function GetVersion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSerie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFolio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetEmisor: IFEXmlEmisorV2;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlEmisorV2 }

  TFEXmlEmisorV2 = class(TXMLNode, IFEXmlEmisorV2)
  protected
    { IFEXmlEmisorV2 }
    function GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_UbicacionFiscal }

  TFEXmlT_UbicacionFiscal = class(TXMLNode, IFEXmlT_UbicacionFiscal)
  protected
    { IFEXmlT_UbicacionFiscal }
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

{ TFEXmlT_Ubicacion }

  TFEXmlT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
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

{ TFEXmlReceptor }

  TFEXmlReceptor = class(TXMLNode, IFEXmlReceptor)
  protected
    { IFEXmlReceptor }
    function GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlConceptos }

  TFEXmlConceptos = class(TXMLNodeCollection, IFEXmlConceptos)
  protected
    { IFEXmlConceptos }
    function GetConcepto(Index: Integer): IFEXmlConcepto;
    function Add: IFEXmlConcepto;
    function Insert(const Index: Integer): IFEXmlConcepto;
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlConcepto }

  TFEXmlConcepto = class(TXMLNode, IFEXmlConcepto)
  private
    FInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    FParte: IFEXmlParteList;
  protected
    { IFEXmlConcepto }
    function GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_InformacionAduanera }

  TFEXmlT_InformacionAduanera = class(TXMLNode, IFEXmlT_InformacionAduanera)
  protected
    { IFEXmlT_InformacionAduanera }
    function GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetAduana: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetAduana(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TFEXmlT_InformacionAduaneraList }

  TFEXmlT_InformacionAduaneraList = class(TXMLNodeCollection, IFEXmlT_InformacionAduaneraList)
  protected
    { IFEXmlT_InformacionAduaneraList }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    function GetItem(Index: Integer): IFEXmlT_InformacionAduanera;
  end;

{ TFEXmlCuentaPredial }

  TFEXmlCuentaPredial = class(TXMLNode, IFEXmlCuentaPredial)
  protected
    { IFEXmlCuentaPredial }
    function GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TFEXmlComplementoConcepto }

  TFEXmlComplementoConcepto = class(TXMLNode, IFEXmlComplementoConcepto)
  protected
    { IFEXmlComplementoConcepto }
  end;

{ TFEXmlParte }

  TFEXmlParte = class(TXMLNodeCollection, IFEXmlParte)
  protected
    { IFEXmlParte }
    function GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlParteList }

  TFEXmlParteList = class(TXMLNodeCollection, IFEXmlParteList)
  protected
    { IFEXmlParteList }
    function Add: IFEXmlParte;
    function Insert(const Index: Integer): IFEXmlParte;
    function GetItem(Index: Integer): IFEXmlParte;
  end;

{ TFEXmlImpuestos }

  TFEXmlImpuestos = class(TXMLNode, IFEXmlImpuestos)
  protected
    { IFEXmlImpuestos }
    function GetTotalImpuestosRetenidos: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTotalImpuestosTrasladados: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTotalImpuestosTrasladados(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlRetenciones }

  TFEXmlRetenciones = class(TXMLNodeCollection, IFEXmlRetenciones)
  protected
    { IFEXmlRetenciones }
    function GetRetencion(Index: Integer): IFEXmlRetencion;
    function Add: IFEXmlRetencion;
    function Insert(const Index: Integer): IFEXmlRetencion;
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlRetencion }

  TFEXmlRetencion = class(TXMLNode, IFEXmlRetencion)
  protected
    { IFEXmlRetencion }
    function GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TFEXmlTraslados }

  TFEXmlTraslados = class(TXMLNodeCollection, IFEXmlTraslados)
  protected
    { IFEXmlTraslados }
    function GetTraslado(Index: Integer): IFEXmlTraslado;
    function Add: IFEXmlTraslado;
    function Insert(const Index: Integer): IFEXmlTraslado;
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlTraslado }

  TFEXmlTraslado = class(TXMLNode, IFEXmlTraslado)
  protected
    { IFEXmlTraslado }
    function GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetTasa: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetTasa(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TFEXmlComplemento }

  TFEXmlComplemento = class(TXMLNode, IFEXmlComplemento)
  protected
    { IFEXmlComplemento }
  end;

{ TFEXmlAddenda }

  TFEXmlAddenda = class(TXMLNode, IFEXmlAddenda)
  protected
    { IFEXmlAddenda }
  end;

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobanteV2;
function LoadComprobante(const FileName: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND}): IFEXmlComprobanteV2;
function NewComprobante: IFEXmlComprobanteV2;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobanteV2;
begin
  Result := Doc.GetDocBinding('Comprobante', TFEXmlComprobanteV2, TargetNamespace) as IFEXmlComprobanteV2;
end;

function LoadComprobante(const FileName: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND}): IFEXmlComprobanteV2;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TFEXmlComprobanteV2, TargetNamespace) as IFEXmlComprobanteV2;
end;

function NewComprobante: IFEXmlComprobanteV2;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TFEXmlComprobanteV2, TargetNamespace) as IFEXmlComprobanteV2;
end;

{ TFEXmlComprobanteV2 }

procedure TFEXmlComprobanteV2.AfterConstruction;
begin
  RegisterChildNode('Emisor', TFEXmlEmisorV2);
  RegisterChildNode('Receptor', TFEXmlReceptor);
  RegisterChildNode('Conceptos', TFEXmlConceptos);
  RegisterChildNode('Impuestos', TFEXmlImpuestos);
  RegisterChildNode('Complemento', TFEXmlComplemento);
  RegisterChildNode('Addenda', TFEXmlAddenda);
  inherited;
end;

function TFEXmlComprobanteV2.GetVersion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TFEXmlComprobanteV2.SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('version', Value);
end;

function TFEXmlComprobanteV2.GetSerie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TFEXmlComprobanteV2.SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('serie', Value);
end;

function TFEXmlComprobanteV2.GetFolio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TFEXmlComprobanteV2.SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('folio', Value);
end;

function TFEXmlComprobanteV2.GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlComprobanteV2.SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlComprobanteV2.GetSello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TFEXmlComprobanteV2.SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('sello', Value);
end;

function TFEXmlComprobanteV2.GetNoAprobacion: Integer;
begin
  Result := AttributeNodes['noAprobacion'].NodeValue;
end;

procedure TFEXmlComprobanteV2.SetNoAprobacion(Value: Integer);
begin
  SetAttribute('noAprobacion', Value);
end;

function TFEXmlComprobanteV2.GetAnoAprobacion: Integer;
begin
  Result := AttributeNodes['anoAprobacion'].NodeValue;
end;

procedure TFEXmlComprobanteV2.SetAnoAprobacion(Value: Integer);
begin
  SetAttribute('anoAprobacion', Value);
end;

function TFEXmlComprobanteV2.GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('formaDePago', Value);
end;

function TFEXmlComprobanteV2.GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noCertificado', Value);
end;

function TFEXmlComprobanteV2.GetCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('certificado', Value);
end;

function TFEXmlComprobanteV2.GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('condicionesDePago', Value);
end;

function TFEXmlComprobanteV2.GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TFEXmlComprobanteV2.SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('subTotal', Value);
end;

function TFEXmlComprobanteV2.GetDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('descuento', Value);
end;

function TFEXmlComprobanteV2.GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('motivoDescuento', Value);
end;

function TFEXmlComprobanteV2.GetTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TFEXmlComprobanteV2.SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('total', Value);
end;

function TFEXmlComprobanteV2.GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('metodoDePago', Value);
end;

function TFEXmlComprobanteV2.GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TFEXmlComprobanteV2.SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TFEXmlComprobanteV2.GetEmisor: IFEXmlEmisorV2;
begin
  Result := ChildNodes['Emisor'] as IFEXmlEmisorV2;
end;

function TFEXmlComprobanteV2.GetReceptor: IFEXmlReceptor;
begin
  Result := ChildNodes['Receptor'] as IFEXmlReceptor;
end;

function TFEXmlComprobanteV2.GetConceptos: IFEXmlConceptos;
begin
  Result := ChildNodes['Conceptos'] as IFEXmlConceptos;
end;

function TFEXmlComprobanteV2.GetImpuestos: IFEXmlImpuestos;
begin
  Result := ChildNodes['Impuestos'] as IFEXmlImpuestos;
end;

function TFEXmlComprobanteV2.GetComplemento: IFEXmlComplemento;
begin
  Result := ChildNodes['Complemento'] as IFEXmlComplemento;
end;

function TFEXmlComprobanteV2.GetAddenda: IFEXmlAddenda;
begin
  Result := ChildNodes['Addenda'] as IFEXmlAddenda;
end;

{ TFEXmlEmisorV2 }

procedure TFEXmlEmisorV2.AfterConstruction;
begin
  RegisterChildNode('DomicilioFiscal', TFEXmlT_UbicacionFiscal);
  RegisterChildNode('ExpedidoEn', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlEmisorV2.GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlEmisorV2.SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlEmisorV2.GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlEmisorV2.SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('nombre', Value);
end;

function TFEXmlEmisorV2.GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
begin
  Result := ChildNodes['DomicilioFiscal'] as IFEXmlT_UbicacionFiscal;
end;

function TFEXmlEmisorV2.GetExpedidoEn: IFEXmlT_Ubicacion;
begin
  Result := ChildNodes['ExpedidoEn'] as IFEXmlT_Ubicacion;
end;

{ TFEXmlT_UbicacionFiscal }

function TFEXmlT_UbicacionFiscal.GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_UbicacionFiscal.GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_UbicacionFiscal.GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_UbicacionFiscal.GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_UbicacionFiscal.GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlT_Ubicacion }

function TFEXmlT_Ubicacion.GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_Ubicacion.GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_Ubicacion.GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_Ubicacion.GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_Ubicacion.GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_Ubicacion.SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_Ubicacion.GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_Ubicacion.GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_Ubicacion.SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_Ubicacion.GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_Ubicacion.SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_Ubicacion.GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_Ubicacion.SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_Ubicacion.GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlReceptor }

procedure TFEXmlReceptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlReceptor.GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlReceptor.SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlReceptor.GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlReceptor.SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('nombre', Value);
end;

function TFEXmlReceptor.GetDomicilio: IFEXmlT_Ubicacion;
begin
  Result := ChildNodes['Domicilio'] as IFEXmlT_Ubicacion;
end;

{ TFEXmlConceptos }

procedure TFEXmlConceptos.AfterConstruction;
begin
  RegisterChildNode('Concepto', TFEXmlConcepto);
  ItemTag := 'Concepto';
  ItemInterface := IFEXmlConcepto;
  inherited;
end;

function TFEXmlConceptos.GetConcepto(Index: Integer): IFEXmlConcepto;
begin
  Result := List[Index] as IFEXmlConcepto;
end;

function TFEXmlConceptos.Add: IFEXmlConcepto;
begin
  //Result := AddItem(-1) as IFEXmlConcepto;
  Result := AddChild(ItemTag, ItemNS, True, -1) as IFEXMLConcepto; //Nueva forma para versiones de delphi XE?
end;

function TFEXmlConceptos.Insert(const Index: Integer): IFEXmlConcepto;
begin
  //Result := AddItem(Index) as IFEXmlConcepto;
  Result := AddChild(ItemTag, ItemNS, True, Index) as IFEXMLConcepto;
end;

{ TFEXmlConcepto }

procedure TFEXmlConcepto.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TFEXmlT_InformacionAduanera);
  RegisterChildNode('CuentaPredial', TFEXmlCuentaPredial);
  RegisterChildNode('ComplementoConcepto', TFEXmlComplementoConcepto);
  RegisterChildNode('Parte', TFEXmlParte);
  FInformacionAduanera := CreateCollection(TFEXmlT_InformacionAduaneraList, IFEXmlT_InformacionAduanera, 'InformacionAduanera') as IFEXmlT_InformacionAduaneraList;
  FParte := CreateCollection(TFEXmlParteList, IFEXmlParte, 'Parte') as IFEXmlParteList;
  inherited;
end;

function TFEXmlConcepto.GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlConcepto.SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlConcepto.GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlConcepto.SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlConcepto.GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlConcepto.SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlConcepto.GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlConcepto.SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlConcepto.GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlConcepto.SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlConcepto.GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlConcepto.SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('importe', Value);
end;

function TFEXmlConcepto.GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
begin
  Result := FInformacionAduanera;
end;

function TFEXmlConcepto.GetCuentaPredial: IFEXmlCuentaPredial;
begin
  Result := ChildNodes['CuentaPredial'] as IFEXmlCuentaPredial;
end;

function TFEXmlConcepto.GetComplementoConcepto: IFEXmlComplementoConcepto;
begin
  Result := ChildNodes['ComplementoConcepto'] as IFEXmlComplementoConcepto;
end;

function TFEXmlConcepto.GetParte: IFEXmlParteList;
begin
  Result := FParte;
end;

{ TFEXmlT_InformacionAduanera }

function TFEXmlT_InformacionAduanera.GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('numero', Value);
end;

function TFEXmlT_InformacionAduanera.GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlT_InformacionAduanera.GetAduana: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['aduana'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetAduana(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('aduana', Value);
end;

{ TFEXmlT_InformacionAduaneraList }

function TFEXmlT_InformacionAduaneraList.Add: IFEXmlT_InformacionAduanera;
begin
  Result := AddItem(-1) as IFEXmlT_InformacionAduanera;
end;

function TFEXmlT_InformacionAduaneraList.Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
begin
  Result := AddItem(Index) as IFEXmlT_InformacionAduanera;
end;
function TFEXmlT_InformacionAduaneraList.GetItem(Index: Integer): IFEXmlT_InformacionAduanera;
begin
  Result := List[Index] as IFEXmlT_InformacionAduanera;
end;

{ TFEXmlCuentaPredial }

function TFEXmlCuentaPredial.GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlCuentaPredial.SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('numero', Value);
end;

{ TFEXmlComplementoConcepto }

{ TFEXmlParte }

procedure TFEXmlParte.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TFEXmlT_InformacionAduanera);
  ItemTag := 'InformacionAduanera';
  ItemInterface := IFEXmlT_InformacionAduanera;
  inherited;
end;

function TFEXmlParte.GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlParte.SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlParte.GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlParte.SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlParte.GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlParte.SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlParte.GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlParte.SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlParte.GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlParte.SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlParte.GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlParte.SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('importe', Value);
end;

function TFEXmlParte.GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
begin
  Result := List[Index] as IFEXmlT_InformacionAduanera;
end;

function TFEXmlParte.Add: IFEXmlT_InformacionAduanera;
begin
  Result := AddItem(-1) as IFEXmlT_InformacionAduanera;
end;

function TFEXmlParte.Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
begin
  Result := AddItem(Index) as IFEXmlT_InformacionAduanera;
end;

{ TFEXmlParteList }

function TFEXmlParteList.Add: IFEXmlParte;
begin
  Result := AddItem(-1) as IFEXmlParte;
end;

function TFEXmlParteList.Insert(const Index: Integer): IFEXmlParte;
begin
  Result := AddItem(Index) as IFEXmlParte;
end;
function TFEXmlParteList.GetItem(Index: Integer): IFEXmlParte;
begin
  Result := List[Index] as IFEXmlParte;
end;

{ TFEXmlImpuestos }

procedure TFEXmlImpuestos.AfterConstruction;
begin
  RegisterChildNode('Retenciones', TFEXmlRetenciones);
  RegisterChildNode('Traslados', TFEXmlTraslados);
  inherited;
end;

function TFEXmlImpuestos.GetTotalImpuestosRetenidos: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['totalImpuestosRetenidos'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosRetenidos(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('totalImpuestosRetenidos', Value);
end;

function TFEXmlImpuestos.GetTotalImpuestosTrasladados: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['totalImpuestosTrasladados'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosTrasladados(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('totalImpuestosTrasladados', Value);
end;

function TFEXmlImpuestos.GetRetenciones: IFEXmlRetenciones;
begin
  Result := ChildNodes['Retenciones'] as IFEXmlRetenciones;
end;

function TFEXmlImpuestos.GetTraslados: IFEXmlTraslados;
begin
  Result := ChildNodes['Traslados'] as IFEXmlTraslados;
end;

{ TFEXmlRetenciones }

procedure TFEXmlRetenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TFEXmlRetencion);
  ItemTag := 'Retencion';
  ItemInterface := IFEXmlRetencion;
  inherited;
end;

function TFEXmlRetenciones.GetRetencion(Index: Integer): IFEXmlRetencion;
begin
  Result := List[Index] as IFEXmlRetencion;
end;

function TFEXmlRetenciones.Add: IFEXmlRetencion;
begin
  Result := AddItem(-1) as IFEXmlRetencion;
end;

function TFEXmlRetenciones.Insert(const Index: Integer): IFEXmlRetencion;
begin
  Result := AddItem(Index) as IFEXmlRetencion;
end;

{ TFEXmlRetencion }

function TFEXmlRetencion.GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlRetencion.SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlRetencion.GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlRetencion.SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('importe', Value);
end;

{ TFEXmlTraslados }

procedure TFEXmlTraslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TFEXmlTraslado);
  ItemTag := 'Traslado';
  ItemInterface := IFEXmlTraslado;
  inherited;
end;

function TFEXmlTraslados.GetTraslado(Index: Integer): IFEXmlTraslado;
begin
  Result := List[Index] as IFEXmlTraslado;
end;

function TFEXmlTraslados.Add: IFEXmlTraslado;
begin
  Result := AddChild(ItemTag, ItemNS, True, -1) as IFEXmlTraslado;
end;

function TFEXmlTraslados.Insert(const Index: Integer): IFEXmlTraslado;
begin
  Result := AddChild(ItemTag, ItemNS, True, Index) as IFEXmlTraslado;
end;

{ TFEXmlTraslado }

function TFEXmlTraslado.GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlTraslado.SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlTraslado.GetTasa: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['tasa'].Text;
end;

procedure TFEXmlTraslado.SetTasa(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('tasa', Value);
end;

function TFEXmlTraslado.GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlTraslado.SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('importe', Value);
end;

{ TFEXmlComplemento }

{ TFEXmlAddenda }

end.
