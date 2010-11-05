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

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IFEXmlComprobante = interface;
  IFEXmlEmisor = interface;
  IFEXmlT_UbicacionFiscal = interface;
  IFEXmlT_Ubicacion = interface;
  IFEXmlReceptor = interface;
  IFEXmlConceptos = interface;
  IFEXmlConcepto = interface;
  IFEXmlT_InformacionAduanera = interface;
  IFEXmlT_InformacionAduaneraList = interface;
  IFEXmlCuentaPredial = interface;
  IFEXmlComplementoConcepto = interface;
  IFEXmlParte = interface;
  IFEXmlParteList = interface;
  IFEXmlImpuestos = interface;
  IFEXmlRetenciones = interface;
  IFEXmlRetencion = interface;
  IFEXmlTraslados = interface;
  IFEXmlTraslado = interface;
  IFEXmlComplemento = interface;
  IFEXmlAddenda = interface;

{ IFEXmlComprobante }

  IFEXmlComprobante = interface(IXMLNode)
    ['{37DBD685-76E6-4BB3-A891-9B8DB6E382E1}']
    { Property Accessors }
    function GetVersion: WideString;
    function GetSerie: WideString;
    function GetFolio: WideString;
    function GetFecha: WideString;
    function GetSello: WideString;
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: WideString;
    function GetNoCertificado: WideString;
    function GetCertificado: WideString;
    function GetCondicionesDePago: WideString;
    function GetSubTotal: WideString;
    function GetDescuento: WideString;
    function GetMotivoDescuento: WideString;
    function GetTotal: WideString;
    function GetMetodoDePago: WideString;
    function GetTipoDeComprobante: WideString;
    function GetEmisor: IFEXmlEmisor;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: WideString);
    procedure SetSerie(Value: WideString);
    procedure SetFolio(Value: WideString);
    procedure SetFecha(Value: WideString);
    procedure SetSello(Value: WideString);
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: WideString);
    procedure SetNoCertificado(Value: WideString);
    procedure SetCertificado(Value: WideString);
    procedure SetCondicionesDePago(Value: WideString);
    procedure SetSubTotal(Value: WideString);
    procedure SetDescuento(Value: WideString);
    procedure SetMotivoDescuento(Value: WideString);
    procedure SetTotal(Value: WideString);
    procedure SetMetodoDePago(Value: WideString);
    procedure SetTipoDeComprobante(Value: WideString);
    { Methods & Properties }
    property Version: WideString read GetVersion write SetVersion;
    property Serie: WideString read GetSerie write SetSerie;
    property Folio: WideString read GetFolio write SetFolio;
    property Fecha: WideString read GetFecha write SetFecha;
    property Sello: WideString read GetSello write SetSello;
    property NoAprobacion: Integer read GetNoAprobacion write SetNoAprobacion;
    property AnoAprobacion: Integer read GetAnoAprobacion write SetAnoAprobacion;
    property FormaDePago: WideString read GetFormaDePago write SetFormaDePago;
    property NoCertificado: WideString read GetNoCertificado write SetNoCertificado;
    property Certificado: WideString read GetCertificado write SetCertificado;
    property CondicionesDePago: WideString read GetCondicionesDePago write SetCondicionesDePago;
    property SubTotal: WideString read GetSubTotal write SetSubTotal;
    property Descuento: WideString read GetDescuento write SetDescuento;
    property MotivoDescuento: WideString read GetMotivoDescuento write SetMotivoDescuento;
    property Total: WideString read GetTotal write SetTotal;
    property MetodoDePago: WideString read GetMetodoDePago write SetMetodoDePago;
    property TipoDeComprobante: WideString read GetTipoDeComprobante write SetTipoDeComprobante;
    property Emisor: IFEXmlEmisor read GetEmisor;
    property Receptor: IFEXmlReceptor read GetReceptor;
    property Conceptos: IFEXmlConceptos read GetConceptos;
    property Impuestos: IFEXmlImpuestos read GetImpuestos;
    property Complemento: IFEXmlComplemento read GetComplemento;
    property Addenda: IFEXmlAddenda read GetAddenda;
  end;

{ IFEXmlEmisor }

  IFEXmlEmisor = interface(IXMLNode)
    ['{C084D8B6-04E3-4DC8-94F3-584CD358CBC2}']
    { Property Accessors }
    function GetRfc: WideString;
    function GetNombre: WideString;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: WideString);
    procedure SetNombre(Value: WideString);
    { Methods & Properties }
    property Rfc: WideString read GetRfc write SetRfc;
    property Nombre: WideString read GetNombre write SetNombre;
    property DomicilioFiscal: IFEXmlT_UbicacionFiscal read GetDomicilioFiscal;
    property ExpedidoEn: IFEXmlT_Ubicacion read GetExpedidoEn;
  end;

{ IFEXmlT_UbicacionFiscal }

  IFEXmlT_UbicacionFiscal = interface(IXMLNode)
    ['{58F864FD-BBF7-4AA6-A4E5-095B220A88A9}']
    { Property Accessors }
    function GetCalle: WideString;
    function GetNoExterior: WideString;
    function GetNoInterior: WideString;
    function GetColonia: WideString;
    function GetLocalidad: WideString;
    function GetReferencia: WideString;
    function GetMunicipio: WideString;
    function GetEstado: WideString;
    function GetPais: WideString;
    function GetCodigoPostal: WideString;
    procedure SetCalle(Value: WideString);
    procedure SetNoExterior(Value: WideString);
    procedure SetNoInterior(Value: WideString);
    procedure SetColonia(Value: WideString);
    procedure SetLocalidad(Value: WideString);
    procedure SetReferencia(Value: WideString);
    procedure SetMunicipio(Value: WideString);
    procedure SetEstado(Value: WideString);
    procedure SetPais(Value: WideString);
    procedure SetCodigoPostal(Value: WideString);
    { Methods & Properties }
    property Calle: WideString read GetCalle write SetCalle;
    property NoExterior: WideString read GetNoExterior write SetNoExterior;
    property NoInterior: WideString read GetNoInterior write SetNoInterior;
    property Colonia: WideString read GetColonia write SetColonia;
    property Localidad: WideString read GetLocalidad write SetLocalidad;
    property Referencia: WideString read GetReferencia write SetReferencia;
    property Municipio: WideString read GetMunicipio write SetMunicipio;
    property Estado: WideString read GetEstado write SetEstado;
    property Pais: WideString read GetPais write SetPais;
    property CodigoPostal: WideString read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlT_Ubicacion }

  IFEXmlT_Ubicacion = interface(IXMLNode)
    ['{1B11BFDF-10CE-4528-ABD0-B8FA8B12457B}']
    { Property Accessors }
    function GetCalle: WideString;
    function GetNoExterior: WideString;
    function GetNoInterior: WideString;
    function GetColonia: WideString;
    function GetLocalidad: WideString;
    function GetReferencia: WideString;
    function GetMunicipio: WideString;
    function GetEstado: WideString;
    function GetPais: WideString;
    function GetCodigoPostal: WideString;
    procedure SetCalle(Value: WideString);
    procedure SetNoExterior(Value: WideString);
    procedure SetNoInterior(Value: WideString);
    procedure SetColonia(Value: WideString);
    procedure SetLocalidad(Value: WideString);
    procedure SetReferencia(Value: WideString);
    procedure SetMunicipio(Value: WideString);
    procedure SetEstado(Value: WideString);
    procedure SetPais(Value: WideString);
    procedure SetCodigoPostal(Value: WideString);
    { Methods & Properties }
    property Calle: WideString read GetCalle write SetCalle;
    property NoExterior: WideString read GetNoExterior write SetNoExterior;
    property NoInterior: WideString read GetNoInterior write SetNoInterior;
    property Colonia: WideString read GetColonia write SetColonia;
    property Localidad: WideString read GetLocalidad write SetLocalidad;
    property Referencia: WideString read GetReferencia write SetReferencia;
    property Municipio: WideString read GetMunicipio write SetMunicipio;
    property Estado: WideString read GetEstado write SetEstado;
    property Pais: WideString read GetPais write SetPais;
    property CodigoPostal: WideString read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlReceptor }

  IFEXmlReceptor = interface(IXMLNode)
    ['{217A478E-BE6B-4F1A-BDD5-B1F4746D2DF1}']
    { Property Accessors }
    function GetRfc: WideString;
    function GetNombre: WideString;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: WideString);
    procedure SetNombre(Value: WideString);
    { Methods & Properties }
    property Rfc: WideString read GetRfc write SetRfc;
    property Nombre: WideString read GetNombre write SetNombre;
    property Domicilio: IFEXmlT_Ubicacion read GetDomicilio;
  end;

{ IFEXmlConceptos }

  IFEXmlConceptos = interface(IXMLNodeCollection)
    ['{76AA1F25-0433-408F-A98F-9F0381C6ED79}']
    { Property Accessors }
    function GetConcepto(Index: Integer): IFEXmlConcepto;
    { Methods & Properties }
    function Add: IFEXmlConcepto;
    function Insert(const Index: Integer): IFEXmlConcepto;
    property Concepto[Index: Integer]: IFEXmlConcepto read GetConcepto; default;
  end;

{ IFEXmlConcepto }

  IFEXmlConcepto = interface(IXMLNode)
    ['{75132185-7289-40F9-A1F7-467D9E032722}']
    { Property Accessors }
    function GetCantidad: WideString;
    function GetUnidad: WideString;
    function GetNoIdentificacion: WideString;
    function GetDescripcion: WideString;
    function GetValorUnitario: WideString;
    function GetImporte: WideString;
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: WideString);
    procedure SetUnidad(Value: WideString);
    procedure SetNoIdentificacion(Value: WideString);
    procedure SetDescripcion(Value: WideString);
    procedure SetValorUnitario(Value: WideString);
    procedure SetImporte(Value: WideString);
    { Methods & Properties }
    property Cantidad: WideString read GetCantidad write SetCantidad;
    property Unidad: WideString read GetUnidad write SetUnidad;
    property NoIdentificacion: WideString read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: WideString read GetDescripcion write SetDescripcion;
    property ValorUnitario: WideString read GetValorUnitario write SetValorUnitario;
    property Importe: WideString read GetImporte write SetImporte;
    property InformacionAduanera: IFEXmlT_InformacionAduaneraList read GetInformacionAduanera;
    property CuentaPredial: IFEXmlCuentaPredial read GetCuentaPredial;
    property ComplementoConcepto: IFEXmlComplementoConcepto read GetComplementoConcepto;
    property Parte: IFEXmlParteList read GetParte;
  end;

{ IFEXmlT_InformacionAduanera }

  IFEXmlT_InformacionAduanera = interface(IXMLNode)
    ['{1C4E19E8-6933-4C24-B002-C90BE03BB0B9}']
    { Property Accessors }
    function GetNumero: WideString;
    function GetFecha: WideString;
    function GetAduana: WideString;
    procedure SetNumero(Value: WideString);
    procedure SetFecha(Value: WideString);
    procedure SetAduana(Value: WideString);
    { Methods & Properties }
    property Numero: WideString read GetNumero write SetNumero;
    property Fecha: WideString read GetFecha write SetFecha;
    property Aduana: WideString read GetAduana write SetAduana;
  end;

{ IFEXmlT_InformacionAduaneraList }

  IFEXmlT_InformacionAduaneraList = interface(IXMLNodeCollection)
    ['{50D13780-1D4D-44B6-883F-A02E19B932B2}']
    { Methods & Properties }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    function GetItem(Index: Integer): IFEXmlT_InformacionAduanera;
    property Items[Index: Integer]: IFEXmlT_InformacionAduanera read GetItem; default;
  end;

{ IFEXmlCuentaPredial }

  IFEXmlCuentaPredial = interface(IXMLNode)
    ['{89DBAAA1-4287-4264-8C4F-6C41703459E4}']
    { Property Accessors }
    function GetNumero: WideString;
    procedure SetNumero(Value: WideString);
    { Methods & Properties }
    property Numero: WideString read GetNumero write SetNumero;
  end;

{ IFEXmlComplementoConcepto }

  IFEXmlComplementoConcepto = interface(IXMLNode)
    ['{7E5E280F-1A44-423C-86ED-8857C62499B7}']
  end;

{ IFEXmlParte }

  IFEXmlParte = interface(IXMLNodeCollection)
    ['{C693D039-BA69-4BA9-96AD-E3D6D6F2FAF0}']
    { Property Accessors }
    function GetCantidad: WideString;
    function GetUnidad: WideString;
    function GetNoIdentificacion: WideString;
    function GetDescripcion: WideString;
    function GetValorUnitario: WideString;
    function GetImporte: WideString;
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: WideString);
    procedure SetUnidad(Value: WideString);
    procedure SetNoIdentificacion(Value: WideString);
    procedure SetDescripcion(Value: WideString);
    procedure SetValorUnitario(Value: WideString);
    procedure SetImporte(Value: WideString);
    { Methods & Properties }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    property Cantidad: WideString read GetCantidad write SetCantidad;
    property Unidad: WideString read GetUnidad write SetUnidad;
    property NoIdentificacion: WideString read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: WideString read GetDescripcion write SetDescripcion;
    property ValorUnitario: WideString read GetValorUnitario write SetValorUnitario;
    property Importe: WideString read GetImporte write SetImporte;
    property InformacionAduanera[Index: Integer]: IFEXmlT_InformacionAduanera read GetInformacionAduanera; default;
  end;

{ IFEXmlParteList }

  IFEXmlParteList = interface(IXMLNodeCollection)
    ['{E7F5084C-B0F6-4C18-9366-27D7ABD1B0A4}']
    { Methods & Properties }
    function Add: IFEXmlParte;
    function Insert(const Index: Integer): IFEXmlParte;
    function GetItem(Index: Integer): IFEXmlParte;
    property Items[Index: Integer]: IFEXmlParte read GetItem; default;
  end;

{ IFEXmlImpuestos }

  IFEXmlImpuestos = interface(IXMLNode)
    ['{2E9F64E1-2840-424F-A72C-5C4EDB296019}']
    { Property Accessors }
    function GetTotalImpuestosRetenidos: WideString;
    function GetTotalImpuestosTrasladados: WideString;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: WideString);
    procedure SetTotalImpuestosTrasladados(Value: WideString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: WideString read GetTotalImpuestosRetenidos write SetTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: WideString read GetTotalImpuestosTrasladados write SetTotalImpuestosTrasladados;
    property Retenciones: IFEXmlRetenciones read GetRetenciones;
    property Traslados: IFEXmlTraslados read GetTraslados;
  end;

{ IFEXmlRetenciones }

  IFEXmlRetenciones = interface(IXMLNodeCollection)
    ['{DE83AEE8-C819-4696-895E-F3C4F3AA0805}']
    { Property Accessors }
    function GetRetencion(Index: Integer): IFEXmlRetencion;
    { Methods & Properties }
    function Add: IFEXmlRetencion;
    function Insert(const Index: Integer): IFEXmlRetencion;
    property Retencion[Index: Integer]: IFEXmlRetencion read GetRetencion; default;
  end;

{ IFEXmlRetencion }

  IFEXmlRetencion = interface(IXMLNode)
    ['{89D6E172-CCEA-4444-95E0-55A9CE71F125}']
    { Property Accessors }
    function GetImpuesto: WideString;
    function GetImporte: WideString;
    procedure SetImpuesto(Value: WideString);
    procedure SetImporte(Value: WideString);
    { Methods & Properties }
    property Impuesto: WideString read GetImpuesto write SetImpuesto;
    property Importe: WideString read GetImporte write SetImporte;
  end;

{ IFEXmlTraslados }

  IFEXmlTraslados = interface(IXMLNodeCollection)
    ['{D921468A-C0B3-42D2-9F95-9167E5DA553C}']
    { Property Accessors }
    function GetTraslado(Index: Integer): IFEXmlTraslado;
    { Methods & Properties }
    function Add: IFEXmlTraslado;
    function Insert(const Index: Integer): IFEXmlTraslado;
    property Traslado[Index: Integer]: IFEXmlTraslado read GetTraslado; default;
  end;

{ IFEXmlTraslado }

  IFEXmlTraslado = interface(IXMLNode)
    ['{00633C3F-5D1A-4AB4-B34C-EF310B227AA1}']
    { Property Accessors }
    function GetImpuesto: WideString;
    function GetTasa: WideString;
    function GetImporte: WideString;
    procedure SetImpuesto(Value: WideString);
    procedure SetTasa(Value: WideString);
    procedure SetImporte(Value: WideString);
    { Methods & Properties }
    property Impuesto: WideString read GetImpuesto write SetImpuesto;
    property Tasa: WideString read GetTasa write SetTasa;
    property Importe: WideString read GetImporte write SetImporte;
  end;

{ IFEXmlComplemento }

  IFEXmlComplemento = interface(IXMLNode)
    ['{A5C06D3E-61B8-4343-AAAB-EEAB6D38960A}']
  end;

{ IFEXmlAddenda }

  IFEXmlAddenda = interface(IXMLNode)
    ['{8DBF4538-781C-4E2B-8E4D-58545E8158FC}']
  end;

{ Forward Decls }

  TFEXmlComprobante = class;
  TFEXmlEmisor = class;
  TFEXmlT_UbicacionFiscal = class;
  TFEXmlT_Ubicacion = class;
  TFEXmlReceptor = class;
  TFEXmlConceptos = class;
  TFEXmlConcepto = class;
  TFEXmlT_InformacionAduanera = class;
  TFEXmlT_InformacionAduaneraList = class;
  TFEXmlCuentaPredial = class;
  TFEXmlComplementoConcepto = class;
  TFEXmlParte = class;
  TFEXmlParteList = class;
  TFEXmlImpuestos = class;
  TFEXmlRetenciones = class;
  TFEXmlRetencion = class;
  TFEXmlTraslados = class;
  TFEXmlTraslado = class;
  TFEXmlComplemento = class;
  TFEXmlAddenda = class;

{ TFEXmlComprobante }

  TFEXmlComprobante = class(TXMLNode, IFEXmlComprobante)
  protected
    { IFEXmlComprobante }
    function GetVersion: WideString;
    function GetSerie: WideString;
    function GetFolio: WideString;
    function GetFecha: WideString;
    function GetSello: WideString;
    function GetNoAprobacion: Integer;
    function GetAnoAprobacion: Integer;
    function GetFormaDePago: WideString;
    function GetNoCertificado: WideString;
    function GetCertificado: WideString;
    function GetCondicionesDePago: WideString;
    function GetSubTotal: WideString;
    function GetDescuento: WideString;
    function GetMotivoDescuento: WideString;
    function GetTotal: WideString;
    function GetMetodoDePago: WideString;
    function GetTipoDeComprobante: WideString;
    function GetEmisor: IFEXmlEmisor;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: WideString);
    procedure SetSerie(Value: WideString);
    procedure SetFolio(Value: WideString);
    procedure SetFecha(Value: WideString);
    procedure SetSello(Value: WideString);
    procedure SetNoAprobacion(Value: Integer);
    procedure SetAnoAprobacion(Value: Integer);
    procedure SetFormaDePago(Value: WideString);
    procedure SetNoCertificado(Value: WideString);
    procedure SetCertificado(Value: WideString);
    procedure SetCondicionesDePago(Value: WideString);
    procedure SetSubTotal(Value: WideString);
    procedure SetDescuento(Value: WideString);
    procedure SetMotivoDescuento(Value: WideString);
    procedure SetTotal(Value: WideString);
    procedure SetMetodoDePago(Value: WideString);
    procedure SetTipoDeComprobante(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlEmisor }

  TFEXmlEmisor = class(TXMLNode, IFEXmlEmisor)
  protected
    { IFEXmlEmisor }
    function GetRfc: WideString;
    function GetNombre: WideString;
    function GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
    function GetExpedidoEn: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: WideString);
    procedure SetNombre(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_UbicacionFiscal }

  TFEXmlT_UbicacionFiscal = class(TXMLNode, IFEXmlT_UbicacionFiscal)
  protected
    { IFEXmlT_UbicacionFiscal }
    function GetCalle: WideString;
    function GetNoExterior: WideString;
    function GetNoInterior: WideString;
    function GetColonia: WideString;
    function GetLocalidad: WideString;
    function GetReferencia: WideString;
    function GetMunicipio: WideString;
    function GetEstado: WideString;
    function GetPais: WideString;
    function GetCodigoPostal: WideString;
    procedure SetCalle(Value: WideString);
    procedure SetNoExterior(Value: WideString);
    procedure SetNoInterior(Value: WideString);
    procedure SetColonia(Value: WideString);
    procedure SetLocalidad(Value: WideString);
    procedure SetReferencia(Value: WideString);
    procedure SetMunicipio(Value: WideString);
    procedure SetEstado(Value: WideString);
    procedure SetPais(Value: WideString);
    procedure SetCodigoPostal(Value: WideString);
  end;

{ TFEXmlT_Ubicacion }

  TFEXmlT_Ubicacion = class(TXMLNode, IFEXmlT_Ubicacion)
  protected
    { IFEXmlT_Ubicacion }
    function GetCalle: WideString;
    function GetNoExterior: WideString;
    function GetNoInterior: WideString;
    function GetColonia: WideString;
    function GetLocalidad: WideString;
    function GetReferencia: WideString;
    function GetMunicipio: WideString;
    function GetEstado: WideString;
    function GetPais: WideString;
    function GetCodigoPostal: WideString;
    procedure SetCalle(Value: WideString);
    procedure SetNoExterior(Value: WideString);
    procedure SetNoInterior(Value: WideString);
    procedure SetColonia(Value: WideString);
    procedure SetLocalidad(Value: WideString);
    procedure SetReferencia(Value: WideString);
    procedure SetMunicipio(Value: WideString);
    procedure SetEstado(Value: WideString);
    procedure SetPais(Value: WideString);
    procedure SetCodigoPostal(Value: WideString);
  end;

{ TFEXmlReceptor }

  TFEXmlReceptor = class(TXMLNode, IFEXmlReceptor)
  protected
    { IFEXmlReceptor }
    function GetRfc: WideString;
    function GetNombre: WideString;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: WideString);
    procedure SetNombre(Value: WideString);
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
    function GetCantidad: WideString;
    function GetUnidad: WideString;
    function GetNoIdentificacion: WideString;
    function GetDescripcion: WideString;
    function GetValorUnitario: WideString;
    function GetImporte: WideString;
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: WideString);
    procedure SetUnidad(Value: WideString);
    procedure SetNoIdentificacion(Value: WideString);
    procedure SetDescripcion(Value: WideString);
    procedure SetValorUnitario(Value: WideString);
    procedure SetImporte(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TFEXmlT_InformacionAduanera }

  TFEXmlT_InformacionAduanera = class(TXMLNode, IFEXmlT_InformacionAduanera)
  protected
    { IFEXmlT_InformacionAduanera }
    function GetNumero: WideString;
    function GetFecha: WideString;
    function GetAduana: WideString;
    procedure SetNumero(Value: WideString);
    procedure SetFecha(Value: WideString);
    procedure SetAduana(Value: WideString);
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
    function GetNumero: WideString;
    procedure SetNumero(Value: WideString);
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
    function GetCantidad: WideString;
    function GetUnidad: WideString;
    function GetNoIdentificacion: WideString;
    function GetDescripcion: WideString;
    function GetValorUnitario: WideString;
    function GetImporte: WideString;
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: WideString);
    procedure SetUnidad(Value: WideString);
    procedure SetNoIdentificacion(Value: WideString);
    procedure SetDescripcion(Value: WideString);
    procedure SetValorUnitario(Value: WideString);
    procedure SetImporte(Value: WideString);
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
    function GetTotalImpuestosRetenidos: WideString;
    function GetTotalImpuestosTrasladados: WideString;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: WideString);
    procedure SetTotalImpuestosTrasladados(Value: WideString);
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
    function GetImpuesto: WideString;
    function GetImporte: WideString;
    procedure SetImpuesto(Value: WideString);
    procedure SetImporte(Value: WideString);
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
    function GetImpuesto: WideString;
    function GetTasa: WideString;
    function GetImporte: WideString;
    procedure SetImpuesto(Value: WideString);
    procedure SetTasa(Value: WideString);
    procedure SetImporte(Value: WideString);
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

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobante;
function LoadComprobante(const FileName: WideString): IFEXmlComprobante;
function NewComprobante: IFEXmlComprobante;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/2';

implementation

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IFEXmlComprobante;
begin
  Result := Doc.GetDocBinding('Comprobante', TFEXmlComprobante, TargetNamespace) as IFEXmlComprobante;
end;

function LoadComprobante(const FileName: WideString): IFEXmlComprobante;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TFEXmlComprobante, TargetNamespace) as IFEXmlComprobante;
end;

function NewComprobante: IFEXmlComprobante;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TFEXmlComprobante, TargetNamespace) as IFEXmlComprobante;
end;

{ TFEXmlComprobante }

procedure TFEXmlComprobante.AfterConstruction;
begin
  RegisterChildNode('Emisor', TFEXmlEmisor);
  RegisterChildNode('Receptor', TFEXmlReceptor);
  RegisterChildNode('Conceptos', TFEXmlConceptos);
  RegisterChildNode('Impuestos', TFEXmlImpuestos);
  RegisterChildNode('Complemento', TFEXmlComplemento);
  RegisterChildNode('Addenda', TFEXmlAddenda);
  inherited;
end;

function TFEXmlComprobante.GetVersion: WideString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TFEXmlComprobante.SetVersion(Value: WideString);
begin
  SetAttribute('version', Value);
end;

function TFEXmlComprobante.GetSerie: WideString;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TFEXmlComprobante.SetSerie(Value: WideString);
begin
  SetAttribute('serie', Value);
end;

function TFEXmlComprobante.GetFolio: WideString;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TFEXmlComprobante.SetFolio(Value: WideString);
begin
  SetAttribute('folio', Value);
end;

function TFEXmlComprobante.GetFecha: WideString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlComprobante.SetFecha(Value: WideString);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlComprobante.GetSello: WideString;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TFEXmlComprobante.SetSello(Value: WideString);
begin
  SetAttribute('sello', Value);
end;

function TFEXmlComprobante.GetNoAprobacion: Integer;
begin
  Result := AttributeNodes['noAprobacion'].NodeValue;
end;

procedure TFEXmlComprobante.SetNoAprobacion(Value: Integer);
begin
  SetAttribute('noAprobacion', Value);
end;

function TFEXmlComprobante.GetAnoAprobacion: Integer;
begin
  Result := AttributeNodes['anoAprobacion'].NodeValue;
end;

procedure TFEXmlComprobante.SetAnoAprobacion(Value: Integer);
begin
  SetAttribute('anoAprobacion', Value);
end;

function TFEXmlComprobante.GetFormaDePago: WideString;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TFEXmlComprobante.SetFormaDePago(Value: WideString);
begin
  SetAttribute('formaDePago', Value);
end;

function TFEXmlComprobante.GetNoCertificado: WideString;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TFEXmlComprobante.SetNoCertificado(Value: WideString);
begin
  SetAttribute('noCertificado', Value);
end;

function TFEXmlComprobante.GetCertificado: WideString;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TFEXmlComprobante.SetCertificado(Value: WideString);
begin
  SetAttribute('certificado', Value);
end;

function TFEXmlComprobante.GetCondicionesDePago: WideString;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TFEXmlComprobante.SetCondicionesDePago(Value: WideString);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TFEXmlComprobante.GetSubTotal: WideString;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TFEXmlComprobante.SetSubTotal(Value: WideString);
begin
  SetAttribute('subTotal', Value);
end;

function TFEXmlComprobante.GetDescuento: WideString;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TFEXmlComprobante.SetDescuento(Value: WideString);
begin
  SetAttribute('descuento', Value);
end;

function TFEXmlComprobante.GetMotivoDescuento: WideString;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TFEXmlComprobante.SetMotivoDescuento(Value: WideString);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TFEXmlComprobante.GetTotal: WideString;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TFEXmlComprobante.SetTotal(Value: WideString);
begin
  SetAttribute('total', Value);
end;

function TFEXmlComprobante.GetMetodoDePago: WideString;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TFEXmlComprobante.SetMetodoDePago(Value: WideString);
begin
  SetAttribute('metodoDePago', Value);
end;

function TFEXmlComprobante.GetTipoDeComprobante: WideString;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TFEXmlComprobante.SetTipoDeComprobante(Value: WideString);
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TFEXmlComprobante.GetEmisor: IFEXmlEmisor;
begin
  Result := ChildNodes['Emisor'] as IFEXmlEmisor;
end;

function TFEXmlComprobante.GetReceptor: IFEXmlReceptor;
begin
  Result := ChildNodes['Receptor'] as IFEXmlReceptor;
end;

function TFEXmlComprobante.GetConceptos: IFEXmlConceptos;
begin
  Result := ChildNodes['Conceptos'] as IFEXmlConceptos;
end;

function TFEXmlComprobante.GetImpuestos: IFEXmlImpuestos;
begin
  Result := ChildNodes['Impuestos'] as IFEXmlImpuestos;
end;

function TFEXmlComprobante.GetComplemento: IFEXmlComplemento;
begin
  Result := ChildNodes['Complemento'] as IFEXmlComplemento;
end;

function TFEXmlComprobante.GetAddenda: IFEXmlAddenda;
begin
  Result := ChildNodes['Addenda'] as IFEXmlAddenda;
end;

{ TFEXmlEmisor }

procedure TFEXmlEmisor.AfterConstruction;
begin
  RegisterChildNode('DomicilioFiscal', TFEXmlT_UbicacionFiscal);
  RegisterChildNode('ExpedidoEn', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlEmisor.GetRfc: WideString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlEmisor.SetRfc(Value: WideString);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlEmisor.GetNombre: WideString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlEmisor.SetNombre(Value: WideString);
begin
  SetAttribute('nombre', Value);
end;

function TFEXmlEmisor.GetDomicilioFiscal: IFEXmlT_UbicacionFiscal;
begin
  Result := ChildNodes['DomicilioFiscal'] as IFEXmlT_UbicacionFiscal;
end;

function TFEXmlEmisor.GetExpedidoEn: IFEXmlT_Ubicacion;
begin
  Result := ChildNodes['ExpedidoEn'] as IFEXmlT_Ubicacion;
end;

{ TFEXmlT_UbicacionFiscal }

function TFEXmlT_UbicacionFiscal.GetCalle: WideString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCalle(Value: WideString);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoExterior: WideString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoExterior(Value: WideString);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetNoInterior: WideString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetNoInterior(Value: WideString);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_UbicacionFiscal.GetColonia: WideString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetColonia(Value: WideString);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetLocalidad: WideString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetLocalidad(Value: WideString);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_UbicacionFiscal.GetReferencia: WideString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetReferencia(Value: WideString);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_UbicacionFiscal.GetMunicipio: WideString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetMunicipio(Value: WideString);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_UbicacionFiscal.GetEstado: WideString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetEstado(Value: WideString);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_UbicacionFiscal.GetPais: WideString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetPais(Value: WideString);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_UbicacionFiscal.GetCodigoPostal: WideString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_UbicacionFiscal.SetCodigoPostal(Value: WideString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlT_Ubicacion }

function TFEXmlT_Ubicacion.GetCalle: WideString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCalle(Value: WideString);
begin
  SetAttribute('calle', Value);
end;

function TFEXmlT_Ubicacion.GetNoExterior: WideString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoExterior(Value: WideString);
begin
  SetAttribute('noExterior', Value);
end;

function TFEXmlT_Ubicacion.GetNoInterior: WideString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TFEXmlT_Ubicacion.SetNoInterior(Value: WideString);
begin
  SetAttribute('noInterior', Value);
end;

function TFEXmlT_Ubicacion.GetColonia: WideString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetColonia(Value: WideString);
begin
  SetAttribute('colonia', Value);
end;

function TFEXmlT_Ubicacion.GetLocalidad: WideString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TFEXmlT_Ubicacion.SetLocalidad(Value: WideString);
begin
  SetAttribute('localidad', Value);
end;

function TFEXmlT_Ubicacion.GetReferencia: WideString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TFEXmlT_Ubicacion.SetReferencia(Value: WideString);
begin
  SetAttribute('referencia', Value);
end;

function TFEXmlT_Ubicacion.GetMunicipio: WideString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TFEXmlT_Ubicacion.SetMunicipio(Value: WideString);
begin
  SetAttribute('municipio', Value);
end;

function TFEXmlT_Ubicacion.GetEstado: WideString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TFEXmlT_Ubicacion.SetEstado(Value: WideString);
begin
  SetAttribute('estado', Value);
end;

function TFEXmlT_Ubicacion.GetPais: WideString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TFEXmlT_Ubicacion.SetPais(Value: WideString);
begin
  SetAttribute('pais', Value);
end;

function TFEXmlT_Ubicacion.GetCodigoPostal: WideString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TFEXmlT_Ubicacion.SetCodigoPostal(Value: WideString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TFEXmlReceptor }

procedure TFEXmlReceptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TFEXmlT_Ubicacion);
  inherited;
end;

function TFEXmlReceptor.GetRfc: WideString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TFEXmlReceptor.SetRfc(Value: WideString);
begin
  SetAttribute('rfc', Value);
end;

function TFEXmlReceptor.GetNombre: WideString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TFEXmlReceptor.SetNombre(Value: WideString);
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

function TFEXmlConcepto.GetCantidad: WideString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlConcepto.SetCantidad(Value: WideString);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlConcepto.GetUnidad: WideString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlConcepto.SetUnidad(Value: WideString);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlConcepto.GetNoIdentificacion: WideString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlConcepto.SetNoIdentificacion(Value: WideString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlConcepto.GetDescripcion: WideString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlConcepto.SetDescripcion(Value: WideString);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlConcepto.GetValorUnitario: WideString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlConcepto.SetValorUnitario(Value: WideString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlConcepto.GetImporte: WideString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlConcepto.SetImporte(Value: WideString);
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

function TFEXmlT_InformacionAduanera.GetNumero: WideString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetNumero(Value: WideString);
begin
  SetAttribute('numero', Value);
end;

function TFEXmlT_InformacionAduanera.GetFecha: WideString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetFecha(Value: WideString);
begin
  SetAttribute('fecha', Value);
end;

function TFEXmlT_InformacionAduanera.GetAduana: WideString;
begin
  Result := AttributeNodes['aduana'].Text;
end;

procedure TFEXmlT_InformacionAduanera.SetAduana(Value: WideString);
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

function TFEXmlCuentaPredial.GetNumero: WideString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TFEXmlCuentaPredial.SetNumero(Value: WideString);
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

function TFEXmlParte.GetCantidad: WideString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TFEXmlParte.SetCantidad(Value: WideString);
begin
  SetAttribute('cantidad', Value);
end;

function TFEXmlParte.GetUnidad: WideString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TFEXmlParte.SetUnidad(Value: WideString);
begin
  SetAttribute('unidad', Value);
end;

function TFEXmlParte.GetNoIdentificacion: WideString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TFEXmlParte.SetNoIdentificacion(Value: WideString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TFEXmlParte.GetDescripcion: WideString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TFEXmlParte.SetDescripcion(Value: WideString);
begin
  SetAttribute('descripcion', Value);
end;

function TFEXmlParte.GetValorUnitario: WideString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TFEXmlParte.SetValorUnitario(Value: WideString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TFEXmlParte.GetImporte: WideString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlParte.SetImporte(Value: WideString);
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

function TFEXmlImpuestos.GetTotalImpuestosRetenidos: WideString;
begin
  Result := AttributeNodes['totalImpuestosRetenidos'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosRetenidos(Value: WideString);
begin
  SetAttribute('totalImpuestosRetenidos', Value);
end;

function TFEXmlImpuestos.GetTotalImpuestosTrasladados: WideString;
begin
  Result := AttributeNodes['totalImpuestosTrasladados'].Text;
end;

procedure TFEXmlImpuestos.SetTotalImpuestosTrasladados(Value: WideString);
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

function TFEXmlRetencion.GetImpuesto: WideString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlRetencion.SetImpuesto(Value: WideString);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlRetencion.GetImporte: WideString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlRetencion.SetImporte(Value: WideString);
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

function TFEXmlTraslado.GetImpuesto: WideString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TFEXmlTraslado.SetImpuesto(Value: WideString);
begin
  SetAttribute('impuesto', Value);
end;

function TFEXmlTraslado.GetTasa: WideString;
begin
  Result := AttributeNodes['tasa'].Text;
end;

procedure TFEXmlTraslado.SetTasa(Value: WideString);
begin
  SetAttribute('tasa', Value);
end;

function TFEXmlTraslado.GetImporte: WideString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TFEXmlTraslado.SetImporte(Value: WideString);
begin
  SetAttribute('importe', Value);
end;

{ TFEXmlComplemento }

{ TFEXmlAddenda }

end.
