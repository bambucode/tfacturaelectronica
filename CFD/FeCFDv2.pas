unit FeCFDv2;

{*********************************************************************************}
{                                                                                 }
{                                XML Data Binding                                 }
{                                                                                 }
{         Generated on: 11/10/2010 12:27:18 p.m.                                  }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd      }
{   Settings stored in: bc_facturacionelectronica\CFD\CFDv2.xsd   }
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
    function GetRfc: UnicodeString;
    function GetNombre: UnicodeString;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: UnicodeString);
    procedure SetNombre(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read GetRfc write SetRfc;
    property Nombre: UnicodeString read GetNombre write SetNombre;
    property DomicilioFiscal: IFEXmlT_UbicacionFiscal read GetDomicilioFiscal;
    property ExpedidoEn: IFEXmlT_Ubicacion read GetExpedidoEn;
  end;

  TFEXmlComprobanteV2 = class;
  TFEXmlEmisorV2 = class;

{ TFEXmlComprobanteV2 }

  TFEXmlComprobanteV2 = class(TXMLNode, IFEXmlComprobanteV2)
  protected
    { IFEXmlComprobanteV2 }
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
    function GetTotal: UnicodeString;
    function GetMetodoDePago: UnicodeString;
    function GetTipoDeComprobante: UnicodeString;
    function GetEmisor: IFEXmlEmisorV2;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
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
    procedure SetTotal(Value: UnicodeString);
    procedure SetMetodoDePago(Value: UnicodeString);
    procedure SetTipoDeComprobante(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlEmisorV2 }

  TFEXmlEmisorV2 = class(TXMLNode, IFEXmlEmisorV2)
  protected
    { IFEXmlEmisorV2 }
    function GetRfc: UnicodeString;
    function GetNombre: UnicodeString;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: UnicodeString);
    procedure SetNombre(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_UbicacionFiscal }

  TFEXmlT_UbicacionFiscal = class(TXMLNode, IFEXmlT_UbicacionFiscal)
  protected
    { IFEXmlT_UbicacionFiscal }
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

{ TFEXmlT_Ubicacion }

  TFEXmlT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
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

{ TFEXmlReceptor }

  TFEXmlReceptor = class(TXMLNode, IFEXmlReceptor)
  protected
    { IFEXmlReceptor }
    function GetRfc: UnicodeString;
    function GetNombre: UnicodeString;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: UnicodeString);
    procedure SetNombre(Value: UnicodeString);
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
    function GetCantidad: UnicodeString;
    function GetUnidad: UnicodeString;
    function GetNoIdentificacion: UnicodeString;
    function GetDescripcion: UnicodeString;
    function GetValorUnitario: UnicodeString;
    function GetImporte: UnicodeString;
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: UnicodeString);
    procedure SetUnidad(Value: UnicodeString);
    procedure SetNoIdentificacion(Value: UnicodeString);
    procedure SetDescripcion(Value: UnicodeString);
    procedure SetValorUnitario(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_InformacionAduanera }

  TFEXmlT_InformacionAduanera = class(TXMLNode, IFEXmlT_InformacionAduanera)
  protected
    { IFEXmlT_InformacionAduanera }
    function GetNumero: UnicodeString;
    function GetFecha: UnicodeString;
    function GetAduana: UnicodeString;
    procedure SetNumero(Value: UnicodeString);
    procedure SetFecha(Value: UnicodeString);
    procedure SetAduana(Value: UnicodeString);
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
    function GetNumero: UnicodeString;
    procedure SetNumero(Value: UnicodeString);
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
    function GetCantidad: UnicodeString;
    function GetUnidad: UnicodeString;
    function GetNoIdentificacion: UnicodeString;
    function GetDescripcion: UnicodeString;
    function GetValorUnitario: UnicodeString;
    function GetImporte: UnicodeString;
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: UnicodeString);
    procedure SetUnidad(Value: UnicodeString);
    procedure SetNoIdentificacion(Value: UnicodeString);
    procedure SetDescripcion(Value: UnicodeString);
    procedure SetValorUnitario(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
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
    function GetTotalImpuestosRetenidos: UnicodeString;
    function GetTotalImpuestosTrasladados: UnicodeString;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: UnicodeString);
    procedure SetTotalImpuestosTrasladados(Value: UnicodeString);
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
    function GetImpuesto: UnicodeString;
    function GetImporte: UnicodeString;
    procedure SetImpuesto(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
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
    function GetImpuesto: UnicodeString;
    function GetTasa: UnicodeString;
    function GetImporte: UnicodeString;
    procedure SetImpuesto(Value: UnicodeString);
    procedure SetTasa(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
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
function LoadComprobante(const FileName: UnicodeString): IFEXmlComprobanteV2;
function NewComprobante: IFEXmlComprobanteV2;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobanteV2;
begin
  Result := Doc.GetDocBinding('Comprobante', TFEXmlComprobanteV2, TargetNamespace) as IFEXmlComprobanteV2;
end;

function LoadComprobante(const FileName: UnicodeString): IFEXmlComprobanteV2;
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

function TFEXmlComprobanteV2.GetVersion: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TFEXmlComprobanteV2.SetVersion(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TFEXmlComprobanteV2.GetSerie: UnicodeString;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TFEXmlComprobanteV2.SetSerie(Value: UnicodeString);
begin
  SetAttribute('serie', Value);
end;

function TFEXmlComprobanteV2.GetFolio: UnicodeString;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TFEXmlComprobanteV2.SetFolio(Value: UnicodeString);
begin
  SetAttribute('folio', Value);
end;

function TFEXmlComprobanteV2.GetFecha: UnicodeString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlComprobanteV2.SetFecha(Value: UnicodeString);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlComprobanteV2.GetSello: UnicodeString;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TFEXmlComprobanteV2.SetSello(Value: UnicodeString);
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

function TFEXmlComprobanteV2.GetFormaDePago: UnicodeString;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetFormaDePago(Value: UnicodeString);
begin
  SetAttribute('formaDePago', Value);
end;

function TFEXmlComprobanteV2.GetNoCertificado: UnicodeString;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetNoCertificado(Value: UnicodeString);
begin
  SetAttribute('noCertificado', Value);
end;

function TFEXmlComprobanteV2.GetCertificado: UnicodeString;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TFEXmlComprobanteV2.SetCertificado(Value: UnicodeString);
begin
  SetAttribute('certificado', Value);
end;

function TFEXmlComprobanteV2.GetCondicionesDePago: UnicodeString;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetCondicionesDePago(Value: UnicodeString);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TFEXmlComprobanteV2.GetSubTotal: UnicodeString;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TFEXmlComprobanteV2.SetSubTotal(Value: UnicodeString);
begin
  SetAttribute('subTotal', Value);
end;

function TFEXmlComprobanteV2.GetDescuento: UnicodeString;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetDescuento(Value: UnicodeString);
begin
  SetAttribute('descuento', Value);
end;

function TFEXmlComprobanteV2.GetMotivoDescuento: UnicodeString;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TFEXmlComprobanteV2.SetMotivoDescuento(Value: UnicodeString);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TFEXmlComprobanteV2.GetTotal: UnicodeString;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TFEXmlComprobanteV2.SetTotal(Value: UnicodeString);
begin
  SetAttribute('total', Value);
end;

function TFEXmlComprobanteV2.GetMetodoDePago: UnicodeString;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TFEXmlComprobanteV2.SetMetodoDePago(Value: UnicodeString);
begin
  SetAttribute('metodoDePago', Value);
end;

function TFEXmlComprobanteV2.GetTipoDeComprobante: UnicodeString;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TFEXmlComprobanteV2.SetTipoDeComprobante(Value: UnicodeString);
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

function TFEXmlEmisorV2.GetRfc: UnicodeString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlEmisorV2.SetRfc(Value: UnicodeString);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlEmisorV2.GetNombre: UnicodeString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlEmisorV2.SetNombre(Value: UnicodeString);
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

function TFEXmlT_UbicacionFiscal.GetCalle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCalle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetColonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetColonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetLocalidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetLocalidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_UbicacionFiscal.GetReferencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetReferencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetMunicipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetMunicipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_UbicacionFiscal.GetEstado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetEstado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_UbicacionFiscal.GetPais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetPais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_UbicacionFiscal.GetCodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlT_Ubicacion }

function TFEXmlT_Ubicacion.GetCalle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCalle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_Ubicacion.GetNoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_Ubicacion.GetNoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_Ubicacion.GetColonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetColonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_Ubicacion.GetLocalidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_Ubicacion.SetLocalidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_Ubicacion.GetReferencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetReferencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_Ubicacion.GetMunicipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_Ubicacion.SetMunicipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_Ubicacion.GetEstado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_Ubicacion.SetEstado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_Ubicacion.GetPais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_Ubicacion.SetPais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_Ubicacion.GetCodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlReceptor }

procedure TFEXmlReceptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlReceptor.GetRfc: UnicodeString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlReceptor.SetRfc(Value: UnicodeString);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlReceptor.GetNombre: UnicodeString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlReceptor.SetNombre(Value: UnicodeString);
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

function TFEXmlConcepto.GetCantidad: UnicodeString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlConcepto.SetCantidad(Value: UnicodeString);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlConcepto.GetUnidad: UnicodeString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlConcepto.SetUnidad(Value: UnicodeString);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlConcepto.GetNoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlConcepto.SetNoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlConcepto.GetDescripcion: UnicodeString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlConcepto.SetDescripcion(Value: UnicodeString);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlConcepto.GetValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlConcepto.SetValorUnitario(Value: UnicodeString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlConcepto.GetImporte: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlConcepto.SetImporte(Value: UnicodeString);
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

function TFEXmlT_InformacionAduanera.GetNumero: UnicodeString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetNumero(Value: UnicodeString);
begin
  SetAttribute('numero', Value);
end;

function TFEXmlT_InformacionAduanera.GetFecha: UnicodeString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetFecha(Value: UnicodeString);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlT_InformacionAduanera.GetAduana: UnicodeString;
begin
  Result := AttributeNodes['aduana'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetAduana(Value: UnicodeString);
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

function TFEXmlCuentaPredial.GetNumero: UnicodeString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlCuentaPredial.SetNumero(Value: UnicodeString);
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

function TFEXmlParte.GetCantidad: UnicodeString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlParte.SetCantidad(Value: UnicodeString);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlParte.GetUnidad: UnicodeString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlParte.SetUnidad(Value: UnicodeString);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlParte.GetNoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlParte.SetNoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlParte.GetDescripcion: UnicodeString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlParte.SetDescripcion(Value: UnicodeString);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlParte.GetValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlParte.SetValorUnitario(Value: UnicodeString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlParte.GetImporte: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlParte.SetImporte(Value: UnicodeString);
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

function TFEXmlImpuestos.GetTotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['totalImpuestosRetenidos'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('totalImpuestosRetenidos', Value);
end;

function TFEXmlImpuestos.GetTotalImpuestosTrasladados: UnicodeString;
begin
  Result := AttributeNodes['totalImpuestosTrasladados'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosTrasladados(Value: UnicodeString);
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

function TFEXmlRetencion.GetImpuesto: UnicodeString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlRetencion.SetImpuesto(Value: UnicodeString);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlRetencion.GetImporte: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlRetencion.SetImporte(Value: UnicodeString);
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

function TFEXmlTraslado.GetImpuesto: UnicodeString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlTraslado.SetImpuesto(Value: UnicodeString);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlTraslado.GetTasa: UnicodeString;
begin
  Result := AttributeNodes['tasa'].Text;
end;

procedure TFEXmlTraslado.SetTasa(Value: UnicodeString);
begin
  SetAttribute('tasa', Value);
end;

function TFEXmlTraslado.GetImporte: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlTraslado.SetImporte(Value: UnicodeString);
begin
  SetAttribute('importe', Value);
end;

{ TFEXmlComplemento }

{ TFEXmlAddenda }

end.
