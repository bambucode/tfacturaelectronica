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
    function GetRfc: String;
    function GetNombre: String;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: String);
    procedure SetNombre(Value: String);
    { Methods & Properties }
    property Rfc: String read GetRfc write SetRfc;
    property Nombre: String read GetNombre write SetNombre;
    property DomicilioFiscal: IFEXmlT_UbicacionFiscal read GetDomicilioFiscal;
    property ExpedidoEn: IFEXmlT_Ubicacion read GetExpedidoEn;
  end;

  TFEXmlComprobanteV2 = class;
  TFEXmlEmisorV2 = class;

{ TFEXmlComprobanteV2 }

  TFEXmlComprobanteV2 = class(TXMLNode, IFEXmlComprobanteV2)
  protected
    { IFEXmlComprobanteV2 }
    function GetVersion: String;
    function GetSerie: String;
    function GetFolio: String;
    function GetFecha: String;
    function GetSello: String;
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: String;
    function GetNoCertificado: String;
    function GetCertificado: String;
    function GetCondicionesDePago: String;
    function GetSubTotal: String;
    function GetDescuento: String;
    function GetMotivoDescuento: String;
    function GetTotal: String;
    function GetMetodoDePago: String;
    function GetTipoDeComprobante: String;
    function GetEmisor: IFEXmlEmisorV2;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: String);
    procedure SetSerie(Value: String);
    procedure SetFolio(Value: String);
    procedure SetFecha(Value: String);
    procedure SetSello(Value: String);
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: String);
    procedure SetNoCertificado(Value: String);
    procedure SetCertificado(Value: String);
    procedure SetCondicionesDePago(Value: String);
    procedure SetSubTotal(Value: String);
    procedure SetDescuento(Value: String);
    procedure SetMotivoDescuento(Value: String);
    procedure SetTotal(Value: String);
    procedure SetMetodoDePago(Value: String);
    procedure SetTipoDeComprobante(Value: String);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlEmisorV2 }

  TFEXmlEmisorV2 = class(TXMLNode, IFEXmlEmisorV2)
  protected
    { IFEXmlEmisorV2 }
    function GetRfc: String;
    function GetNombre: String;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: String);
    procedure SetNombre(Value: String);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_UbicacionFiscal }

  TFEXmlT_UbicacionFiscal = class(TXMLNode, IFEXmlT_UbicacionFiscal)
  protected
    { IFEXmlT_UbicacionFiscal }
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

{ TFEXmlT_Ubicacion }

  TFEXmlT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
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

{ TFEXmlReceptor }

  TFEXmlReceptor = class(TXMLNode, IFEXmlReceptor)
  protected
    { IFEXmlReceptor }
    function GetRfc: String;
    function GetNombre: String;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: String);
    procedure SetNombre(Value: String);
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
    function GetCantidad: String;
    function GetUnidad: String;
    function GetNoIdentificacion: String;
    function GetDescripcion: String;
    function GetValorUnitario: String;
    function GetImporte: String;
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: String);
    procedure SetUnidad(Value: String);
    procedure SetNoIdentificacion(Value: String);
    procedure SetDescripcion(Value: String);
    procedure SetValorUnitario(Value: String);
    procedure SetImporte(Value: String);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_InformacionAduanera }

  TFEXmlT_InformacionAduanera = class(TXMLNode, IFEXmlT_InformacionAduanera)
  protected
    { IFEXmlT_InformacionAduanera }
    function GetNumero: String;
    function GetFecha: String;
    function GetAduana: String;
    procedure SetNumero(Value: String);
    procedure SetFecha(Value: String);
    procedure SetAduana(Value: String);
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
    function GetNumero: String;
    procedure SetNumero(Value: String);
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
    function GetCantidad: String;
    function GetUnidad: String;
    function GetNoIdentificacion: String;
    function GetDescripcion: String;
    function GetValorUnitario: String;
    function GetImporte: String;
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: String);
    procedure SetUnidad(Value: String);
    procedure SetNoIdentificacion(Value: String);
    procedure SetDescripcion(Value: String);
    procedure SetValorUnitario(Value: String);
    procedure SetImporte(Value: String);
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
    function GetTotalImpuestosRetenidos: String;
    function GetTotalImpuestosTrasladados: String;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: String);
    procedure SetTotalImpuestosTrasladados(Value: String);
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
    function GetImpuesto: String;
    function GetImporte: String;
    procedure SetImpuesto(Value: String);
    procedure SetImporte(Value: String);
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
    function GetImpuesto: String;
    function GetTasa: String;
    function GetImporte: String;
    procedure SetImpuesto(Value: String);
    procedure SetTasa(Value: String);
    procedure SetImporte(Value: String);
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
function LoadComprobante(const FileName: String): IFEXmlComprobanteV2;
function NewComprobante: IFEXmlComprobanteV2;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobanteV2;
begin
  Result := Doc.GetDocBinding('Comprobante', TFEXmlComprobanteV2, TargetNamespace) as IFEXmlComprobanteV2;
end;

function LoadComprobante(const FileName: String): IFEXmlComprobanteV2;
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

function TFEXmlComprobanteV2.GetVersion: String;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TFEXmlComprobanteV2.SetVersion(Value: String);
begin
  SetAttribute('version', Value);
end;

function TFEXmlComprobanteV2.GetSerie: String;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TFEXmlComprobanteV2.SetSerie(Value: String);
begin
  SetAttribute('serie', Value);
end;

function TFEXmlComprobanteV2.GetFolio: String;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TFEXmlComprobanteV2.SetFolio(Value: String);
begin
  SetAttribute('folio', Value);
end;

function TFEXmlComprobanteV2.GetFecha: String;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlComprobanteV2.SetFecha(Value: String);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlComprobanteV2.GetSello: String;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TFEXmlComprobanteV2.SetSello(Value: String);
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

function TFEXmlComprobanteV2.GetFormaDePago: String;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetFormaDePago(Value: String);
begin
  SetAttribute('formaDePago', Value);
end;

function TFEXmlComprobanteV2.GetNoCertificado: String;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetNoCertificado(Value: String);
begin
  SetAttribute('noCertificado', Value);
end;

function TFEXmlComprobanteV2.GetCertificado: String;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetCertificado(Value: String);
begin
  SetAttribute('certificado', Value);
end;

function TFEXmlComprobanteV2.GetCondicionesDePago: String;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetCondicionesDePago(Value: String);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TFEXmlComprobanteV2.GetSubTotal: String;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TFEXmlComprobanteV2.SetSubTotal(Value: String);
begin
  SetAttribute('subTotal', Value);
end;

function TFEXmlComprobanteV2.GetDescuento: String;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetDescuento(Value: String);
begin
  SetAttribute('descuento', Value);
end;

function TFEXmlComprobanteV2.GetMotivoDescuento: String;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetMotivoDescuento(Value: String);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TFEXmlComprobanteV2.GetTotal: String;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TFEXmlComprobanteV2.SetTotal(Value: String);
begin
  SetAttribute('total', Value);
end;

function TFEXmlComprobanteV2.GetMetodoDePago: String;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetMetodoDePago(Value: String);
begin
  SetAttribute('metodoDePago', Value);
end;

function TFEXmlComprobanteV2.GetTipoDeComprobante: String;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TFEXmlComprobanteV2.SetTipoDeComprobante(Value: String);
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

function TFEXmlEmisorV2.GetRfc: String;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlEmisorV2.SetRfc(Value: String);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlEmisorV2.GetNombre: String;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlEmisorV2.SetNombre(Value: String);
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

function TFEXmlT_UbicacionFiscal.GetCalle: String;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCalle(Value: String);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoExterior: String;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoExterior(Value: String);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoInterior: String;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoInterior(Value: String);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetColonia: String;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetColonia(Value: String);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetLocalidad: String;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetLocalidad(Value: String);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_UbicacionFiscal.GetReferencia: String;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetReferencia(Value: String);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetMunicipio: String;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetMunicipio(Value: String);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_UbicacionFiscal.GetEstado: String;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetEstado(Value: String);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_UbicacionFiscal.GetPais: String;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetPais(Value: String);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_UbicacionFiscal.GetCodigoPostal: String;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCodigoPostal(Value: String);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlT_Ubicacion }

function TFEXmlT_Ubicacion.GetCalle: String;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCalle(Value: String);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_Ubicacion.GetNoExterior: String;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoExterior(Value: String);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_Ubicacion.GetNoInterior: String;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoInterior(Value: String);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_Ubicacion.GetColonia: String;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetColonia(Value: String);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_Ubicacion.GetLocalidad: String;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_Ubicacion.SetLocalidad(Value: String);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_Ubicacion.GetReferencia: String;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetReferencia(Value: String);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_Ubicacion.GetMunicipio: String;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_Ubicacion.SetMunicipio(Value: String);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_Ubicacion.GetEstado: String;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_Ubicacion.SetEstado(Value: String);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_Ubicacion.GetPais: String;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_Ubicacion.SetPais(Value: String);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_Ubicacion.GetCodigoPostal: String;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCodigoPostal(Value: String);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlReceptor }

procedure TFEXmlReceptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlReceptor.GetRfc: String;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlReceptor.SetRfc(Value: String);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlReceptor.GetNombre: String;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlReceptor.SetNombre(Value: String);
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
  Result := AddItem(-1) as IFEXmlConcepto;
end;

function TFEXmlConceptos.Insert(const Index: Integer): IFEXmlConcepto;
begin
  Result := AddItem(Index) as IFEXmlConcepto;
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

function TFEXmlConcepto.GetCantidad: String;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlConcepto.SetCantidad(Value: String);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlConcepto.GetUnidad: String;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlConcepto.SetUnidad(Value: String);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlConcepto.GetNoIdentificacion: String;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlConcepto.SetNoIdentificacion(Value: String);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlConcepto.GetDescripcion: String;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlConcepto.SetDescripcion(Value: String);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlConcepto.GetValorUnitario: String;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlConcepto.SetValorUnitario(Value: String);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlConcepto.GetImporte: String;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlConcepto.SetImporte(Value: String);
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

function TFEXmlT_InformacionAduanera.GetNumero: String;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetNumero(Value: String);
begin
  SetAttribute('numero', Value);
end;

function TFEXmlT_InformacionAduanera.GetFecha: String;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetFecha(Value: String);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlT_InformacionAduanera.GetAduana: String;
begin
  Result := AttributeNodes['aduana'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetAduana(Value: String);
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

function TFEXmlCuentaPredial.GetNumero: String;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlCuentaPredial.SetNumero(Value: String);
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

function TFEXmlParte.GetCantidad: String;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlParte.SetCantidad(Value: String);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlParte.GetUnidad: String;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlParte.SetUnidad(Value: String);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlParte.GetNoIdentificacion: String;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlParte.SetNoIdentificacion(Value: String);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlParte.GetDescripcion: String;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlParte.SetDescripcion(Value: String);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlParte.GetValorUnitario: String;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlParte.SetValorUnitario(Value: String);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlParte.GetImporte: String;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlParte.SetImporte(Value: String);
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

function TFEXmlImpuestos.GetTotalImpuestosRetenidos: String;
begin
  Result := AttributeNodes['totalImpuestosRetenidos'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosRetenidos(Value: String);
begin
  SetAttribute('totalImpuestosRetenidos', Value);
end;

function TFEXmlImpuestos.GetTotalImpuestosTrasladados: String;
begin
  Result := AttributeNodes['totalImpuestosTrasladados'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosTrasladados(Value: String);
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

function TFEXmlRetencion.GetImpuesto: String;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlRetencion.SetImpuesto(Value: String);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlRetencion.GetImporte: String;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlRetencion.SetImporte(Value: String);
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
  Result := AddItem(-1) as IFEXmlTraslado;
end;

function TFEXmlTraslados.Insert(const Index: Integer): IFEXmlTraslado;
begin
  Result := AddItem(Index) as IFEXmlTraslado;
end;

{ TFEXmlTraslado }

function TFEXmlTraslado.GetImpuesto: String;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlTraslado.SetImpuesto(Value: String);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlTraslado.GetTasa: String;
begin
  Result := AttributeNodes['tasa'].Text;
end;

procedure TFEXmlTraslado.SetTasa(Value: String);
begin
  SetAttribute('tasa', Value);
end;

function TFEXmlTraslado.GetImporte: String;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlTraslado.SetImporte(Value: String);
begin
  SetAttribute('importe', Value);
end;

{ TFEXmlComplemento }

{ TFEXmlAddenda }

end.
