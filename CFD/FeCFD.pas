unit FeCFD;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IFEXmlComprobante = interface;
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
    function GetTotal: String;
    function GetMetodoDePago: String;
    function GetTipoDeComprobante: String;
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
    property Total: String read GetTotal write SetTotal;
    property MetodoDePago: String read GetMetodoDePago write SetMetodoDePago;
    property TipoDeComprobante: String read GetTipoDeComprobante write SetTipoDeComprobante;
    property Receptor: IFEXmlReceptor read GetReceptor;
    property Conceptos: IFEXmlConceptos read GetConceptos;
    property Impuestos: IFEXmlImpuestos read GetImpuestos;
    property Complemento: IFEXmlComplemento read GetComplemento;
    property Addenda: IFEXmlAddenda read GetAddenda;
  end;


{ IFEXmlT_UbicacionFiscal }

  IFEXmlT_UbicacionFiscal = interface(IXMLNode)
    ['{58F864FD-BBF7-4AA6-A4E5-095B220A88A9}']
    { Property Accessors }
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
    { Methods & Properties }
    property Calle: String read GetCalle write SetCalle;
    property NoExterior: String read GetNoExterior write SetNoExterior;
    property NoInterior: String read GetNoInterior write SetNoInterior;
    property Colonia: String read GetColonia write SetColonia;
    property Localidad: String read GetLocalidad write SetLocalidad;
    property Referencia: String read GetReferencia write SetReferencia;
    property Municipio: String read GetMunicipio write SetMunicipio;
    property Estado: String read GetEstado write SetEstado;
    property Pais: String read GetPais write SetPais;
    property CodigoPostal: String read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlT_Ubicacion }

  IFEXmlT_Ubicacion = interface(IXMLNode)
    ['{1B11BFDF-10CE-4528-ABD0-B8FA8B12457B}']
    { Property Accessors }
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
    { Methods & Properties }
    property Calle: String read GetCalle write SetCalle;
    property NoExterior: String read GetNoExterior write SetNoExterior;
    property NoInterior: String read GetNoInterior write SetNoInterior;
    property Colonia: String read GetColonia write SetColonia;
    property Localidad: String read GetLocalidad write SetLocalidad;
    property Referencia: String read GetReferencia write SetReferencia;
    property Municipio: String read GetMunicipio write SetMunicipio;
    property Estado: String read GetEstado write SetEstado;
    property Pais: String read GetPais write SetPais;
    property CodigoPostal: String read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlReceptor }

  IFEXmlReceptor = interface(IXMLNode)
    ['{217A478E-BE6B-4F1A-BDD5-B1F4746D2DF1}']
    { Property Accessors }
    function GetRfc: String;
    function GetNombre: String;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: String);
    procedure SetNombre(Value: String);
    { Methods & Properties }
    property Rfc: String read GetRfc write SetRfc;
    property Nombre: String read GetNombre write SetNombre;
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
    { Methods & Properties }
    property Cantidad: String read GetCantidad write SetCantidad;
    property Unidad: String read GetUnidad write SetUnidad;
    property NoIdentificacion: String read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: String read GetDescripcion write SetDescripcion;
    property ValorUnitario: String read GetValorUnitario write SetValorUnitario;
    property Importe: String read GetImporte write SetImporte;
    property InformacionAduanera: IFEXmlT_InformacionAduaneraList read GetInformacionAduanera;
    property CuentaPredial: IFEXmlCuentaPredial read GetCuentaPredial;
    property ComplementoConcepto: IFEXmlComplementoConcepto read GetComplementoConcepto;
    property Parte: IFEXmlParteList read GetParte;
  end;

{ IFEXmlT_InformacionAduanera }

  IFEXmlT_InformacionAduanera = interface(IXMLNode)
    ['{1C4E19E8-6933-4C24-B002-C90BE03BB0B9}']
    { Property Accessors }
    function GetNumero: String;
    function GetFecha: String;
    function GetAduana: String;
    procedure SetNumero(Value: String);
    procedure SetFecha(Value: String);
    procedure SetAduana(Value: String);
    { Methods & Properties }
    property Numero: String read GetNumero write SetNumero;
    property Fecha: String read GetFecha write SetFecha;
    property Aduana: String read GetAduana write SetAduana;
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
    function GetNumero: String;
    procedure SetNumero(Value: String);
    { Methods & Properties }
    property Numero: String read GetNumero write SetNumero;
  end;

{ IFEXmlComplementoConcepto }

  IFEXmlComplementoConcepto = interface(IXMLNode)
    ['{7E5E280F-1A44-423C-86ED-8857C62499B7}']
  end;

{ IFEXmlParte }

  IFEXmlParte = interface(IXMLNodeCollection)
    ['{C693D039-BA69-4BA9-96AD-E3D6D6F2FAF0}']
    { Property Accessors }
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
    { Methods & Properties }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    property Cantidad: String read GetCantidad write SetCantidad;
    property Unidad: String read GetUnidad write SetUnidad;
    property NoIdentificacion: String read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: String read GetDescripcion write SetDescripcion;
    property ValorUnitario: String read GetValorUnitario write SetValorUnitario;
    property Importe: String read GetImporte write SetImporte;
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
    function GetTotalImpuestosRetenidos: String;
    function GetTotalImpuestosTrasladados: String;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: String);
    procedure SetTotalImpuestosTrasladados(Value: String);
    { Methods & Properties }
    property TotalImpuestosRetenidos: String read GetTotalImpuestosRetenidos write SetTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: String read GetTotalImpuestosTrasladados write SetTotalImpuestosTrasladados;
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
    function GetImpuesto: String;
    function GetImporte: String;
    procedure SetImpuesto(Value: String);
    procedure SetImporte(Value: String);
    { Methods & Properties }
    property Impuesto: String read GetImpuesto write SetImpuesto;
    property Importe: String read GetImporte write SetImporte;
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
    function GetImpuesto: String;
    function GetTasa: String;
    function GetImporte: String;
    procedure SetImpuesto(Value: String);
    procedure SetTasa(Value: String);
    procedure SetImporte(Value: String);
    { Methods & Properties }
    property Impuesto: String read GetImpuesto write SetImpuesto;
    property Tasa: String read GetTasa write SetTasa;
    property Importe: String read GetImporte write SetImporte;
  end;

{ IFEXmlComplemento }

  IFEXmlComplemento = interface(IXMLNode)
    ['{A5C06D3E-61B8-4343-AAAB-EEAB6D38960A}']
  end;

{ IFEXmlAddenda }

  IFEXmlAddenda = interface(IXMLNode)
    ['{8DBF4538-781C-4E2B-8E4D-58545E8158FC}']
  end;


implementation

begin

end.
