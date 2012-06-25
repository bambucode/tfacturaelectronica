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
    property Total: UnicodeString read GetTotal write SetTotal;
    property MetodoDePago: UnicodeString read GetMetodoDePago write SetMetodoDePago;
    property TipoDeComprobante: UnicodeString read GetTipoDeComprobante write SetTipoDeComprobante;
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
    { Methods & Properties }
    property Calle: UnicodeString read GetCalle write SetCalle;
    property NoExterior: UnicodeString read GetNoExterior write SetNoExterior;
    property NoInterior: UnicodeString read GetNoInterior write SetNoInterior;
    property Colonia: UnicodeString read GetColonia write SetColonia;
    property Localidad: UnicodeString read GetLocalidad write SetLocalidad;
    property Referencia: UnicodeString read GetReferencia write SetReferencia;
    property Municipio: UnicodeString read GetMunicipio write SetMunicipio;
    property Estado: UnicodeString read GetEstado write SetEstado;
    property Pais: UnicodeString read GetPais write SetPais;
    property CodigoPostal: UnicodeString read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlT_Ubicacion }

  IFEXmlT_Ubicacion = interface(IXMLNode)
    ['{1B11BFDF-10CE-4528-ABD0-B8FA8B12457B}']
    { Property Accessors }
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
    { Methods & Properties }
    property Calle: UnicodeString read GetCalle write SetCalle;
    property NoExterior: UnicodeString read GetNoExterior write SetNoExterior;
    property NoInterior: UnicodeString read GetNoInterior write SetNoInterior;
    property Colonia: UnicodeString read GetColonia write SetColonia;
    property Localidad: UnicodeString read GetLocalidad write SetLocalidad;
    property Referencia: UnicodeString read GetReferencia write SetReferencia;
    property Municipio: UnicodeString read GetMunicipio write SetMunicipio;
    property Estado: UnicodeString read GetEstado write SetEstado;
    property Pais: UnicodeString read GetPais write SetPais;
    property CodigoPostal: UnicodeString read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlReceptor }

  IFEXmlReceptor = interface(IXMLNode)
    ['{217A478E-BE6B-4F1A-BDD5-B1F4746D2DF1}']
    { Property Accessors }
    function GetRfc: UnicodeString;
    function GetNombre: UnicodeString;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: UnicodeString);
    procedure SetNombre(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read GetRfc write SetRfc;
    property Nombre: UnicodeString read GetNombre write SetNombre;
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
    { Methods & Properties }
    property Cantidad: UnicodeString read GetCantidad write SetCantidad;
    property Unidad: UnicodeString read GetUnidad write SetUnidad;
    property NoIdentificacion: UnicodeString read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: UnicodeString read GetDescripcion write SetDescripcion;
    property ValorUnitario: UnicodeString read GetValorUnitario write SetValorUnitario;
    property Importe: UnicodeString read GetImporte write SetImporte;
    property InformacionAduanera: IFEXmlT_InformacionAduaneraList read GetInformacionAduanera;
    property CuentaPredial: IFEXmlCuentaPredial read GetCuentaPredial;
    property ComplementoConcepto: IFEXmlComplementoConcepto read GetComplementoConcepto;
    property Parte: IFEXmlParteList read GetParte;
  end;

{ IFEXmlT_InformacionAduanera }

  IFEXmlT_InformacionAduanera = interface(IXMLNode)
    ['{1C4E19E8-6933-4C24-B002-C90BE03BB0B9}']
    { Property Accessors }
    function GetNumero: UnicodeString;
    function GetFecha: UnicodeString;
    function GetAduana: UnicodeString;
    procedure SetNumero(Value: UnicodeString);
    procedure SetFecha(Value: UnicodeString);
    procedure SetAduana(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read GetNumero write SetNumero;
    property Fecha: UnicodeString read GetFecha write SetFecha;
    property Aduana: UnicodeString read GetAduana write SetAduana;
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
    function GetNumero: UnicodeString;
    procedure SetNumero(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read GetNumero write SetNumero;
  end;

{ IFEXmlComplementoConcepto }

  IFEXmlComplementoConcepto = interface(IXMLNode)
    ['{7E5E280F-1A44-423C-86ED-8857C62499B7}']
  end;

{ IFEXmlParte }

  IFEXmlParte = interface(IXMLNodeCollection)
    ['{C693D039-BA69-4BA9-96AD-E3D6D6F2FAF0}']
    { Property Accessors }
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
    { Methods & Properties }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    property Cantidad: UnicodeString read GetCantidad write SetCantidad;
    property Unidad: UnicodeString read GetUnidad write SetUnidad;
    property NoIdentificacion: UnicodeString read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: UnicodeString read GetDescripcion write SetDescripcion;
    property ValorUnitario: UnicodeString read GetValorUnitario write SetValorUnitario;
    property Importe: UnicodeString read GetImporte write SetImporte;
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
    function GetTotalImpuestosRetenidos: UnicodeString;
    function GetTotalImpuestosTrasladados: UnicodeString;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: UnicodeString);
    procedure SetTotalImpuestosTrasladados(Value: UnicodeString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: UnicodeString read GetTotalImpuestosRetenidos write SetTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: UnicodeString read GetTotalImpuestosTrasladados write SetTotalImpuestosTrasladados;
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
    function GetImpuesto: UnicodeString;
    function GetImporte: UnicodeString;
    procedure SetImpuesto(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read GetImpuesto write SetImpuesto;
    property Importe: UnicodeString read GetImporte write SetImporte;
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
    function GetImpuesto: UnicodeString;
    function GetTasa: UnicodeString;
    function GetImporte: UnicodeString;
    procedure SetImpuesto(Value: UnicodeString);
    procedure SetTasa(Value: UnicodeString);
    procedure SetImporte(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read GetImpuesto write SetImpuesto;
    property Tasa: UnicodeString read GetTasa write SetTasa;
    property Importe: UnicodeString read GetImporte write SetImporte;
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
