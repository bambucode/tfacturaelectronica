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
    function GetVersion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetSerie: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetFolio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetSello: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetFormaDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetCertificado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetCondicionesDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetSubTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetMotivoDescuento: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetTotal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetMetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetTipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetReceptor: IFEXmlReceptor;
    function GetConceptos: IFEXmlConceptos;
    function GetImpuestos: IFEXmlImpuestos;
    function GetComplemento: IFEXmlComplemento;
    function GetAddenda: IFEXmlAddenda;
    procedure SetVersion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetSerie(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetFolio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetSello(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetFormaDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetCertificado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetCondicionesDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetSubTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetMotivoDescuento(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetTotal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetMetodoDePago(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetTipoDeComprobante(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
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
    property Total: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTotal write SetTotal;
    property MetodoDePago: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMetodoDePago write SetMetodoDePago;
    property TipoDeComprobante: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTipoDeComprobante write SetTipoDeComprobante;
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
    function GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Calle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCalle write SetCalle;
    property NoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoExterior write SetNoExterior;
    property NoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoInterior write SetNoInterior;
    property Colonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetColonia write SetColonia;
    property Localidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetLocalidad write SetLocalidad;
    property Referencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetReferencia write SetReferencia;
    property Municipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMunicipio write SetMunicipio;
    property Estado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetEstado write SetEstado;
    property Pais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetPais write SetPais;
    property CodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlT_Ubicacion }

  IFEXmlT_Ubicacion = interface(IXMLNode)
    ['{1B11BFDF-10CE-4528-ABD0-B8FA8B12457B}']
    { Property Accessors }
    function GetCalle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetColonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetLocalidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetReferencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetMunicipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetEstado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetPais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetCodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetCalle(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoExterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoInterior(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetColonia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetLocalidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetReferencia(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetMunicipio(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetEstado(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetPais(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetCodigoPostal(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Calle: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCalle write SetCalle;
    property NoExterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoExterior write SetNoExterior;
    property NoInterior: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoInterior write SetNoInterior;
    property Colonia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetColonia write SetColonia;
    property Localidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetLocalidad write SetLocalidad;
    property Referencia: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetReferencia write SetReferencia;
    property Municipio: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetMunicipio write SetMunicipio;
    property Estado: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetEstado write SetEstado;
    property Pais: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetPais write SetPais;
    property CodigoPostal: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCodigoPostal write SetCodigoPostal;
  end;

{ IFEXmlReceptor }

  IFEXmlReceptor = interface(IXMLNode)
    ['{217A478E-BE6B-4F1A-BDD5-B1F4746D2DF1}']
    { Property Accessors }
    function GetRfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetDomicilio: IFEXmlT_Ubicacion;
    procedure SetRfc(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNombre(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Rfc: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetRfc write SetRfc;
    property Nombre: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNombre write SetNombre;
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
    function GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetInformacionAduanera: IFEXmlT_InformacionAduaneraList;
    function GetCuentaPredial: IFEXmlCuentaPredial;
    function GetComplementoConcepto: IFEXmlComplementoConcepto;
    function GetParte: IFEXmlParteList;
    procedure SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Cantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCantidad write SetCantidad;
    property Unidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetUnidad write SetUnidad;
    property NoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetDescripcion write SetDescripcion;
    property ValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetValorUnitario write SetValorUnitario;
    property Importe: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImporte write SetImporte;
    property InformacionAduanera: IFEXmlT_InformacionAduaneraList read GetInformacionAduanera;
    property CuentaPredial: IFEXmlCuentaPredial read GetCuentaPredial;
    property ComplementoConcepto: IFEXmlComplementoConcepto read GetComplementoConcepto;
    property Parte: IFEXmlParteList read GetParte;
  end;

{ IFEXmlT_InformacionAduanera }

  IFEXmlT_InformacionAduanera = interface(IXMLNode)
    ['{1C4E19E8-6933-4C24-B002-C90BE03BB0B9}']
    { Property Accessors }
    function GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetFecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetAduana: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetFecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetAduana(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Numero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNumero write SetNumero;
    property Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetFecha write SetFecha;
    property Aduana: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetAduana write SetAduana;
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
    function GetNumero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetNumero(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Numero: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNumero write SetNumero;
  end;

{ IFEXmlComplementoConcepto }

  IFEXmlComplementoConcepto = interface(IXMLNode)
    ['{7E5E280F-1A44-423C-86ED-8857C62499B7}']
  end;

{ IFEXmlParte }

  IFEXmlParte = interface(IXMLNodeCollection)
    ['{C693D039-BA69-4BA9-96AD-E3D6D6F2FAF0}']
    { Property Accessors }
    function GetCantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetUnidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetNoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetDescripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetInformacionAduanera(Index: Integer): IFEXmlT_InformacionAduanera;
    procedure SetCantidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetUnidad(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetNoIdentificacion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetDescripcion(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetValorUnitario(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    function Add: IFEXmlT_InformacionAduanera;
    function Insert(const Index: Integer): IFEXmlT_InformacionAduanera;
    property Cantidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetCantidad write SetCantidad;
    property Unidad: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetUnidad write SetUnidad;
    property NoIdentificacion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetNoIdentificacion write SetNoIdentificacion;
    property Descripcion: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetDescripcion write SetDescripcion;
    property ValorUnitario: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetValorUnitario write SetValorUnitario;
    property Importe: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImporte write SetImporte;
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
    function GetTotalImpuestosRetenidos: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetTotalImpuestosTrasladados: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetRetenciones: IFEXmlRetenciones;
    function GetTraslados: IFEXmlTraslados;
    procedure SetTotalImpuestosRetenidos(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetTotalImpuestosTrasladados(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property TotalImpuestosRetenidos: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTotalImpuestosRetenidos write SetTotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTotalImpuestosTrasladados write SetTotalImpuestosTrasladados;
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
    function GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Impuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImpuesto write SetImpuesto;
    property Importe: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImporte write SetImporte;
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
    function GetImpuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetTasa: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    function GetImporte: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} ;
    procedure SetImpuesto(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetTasa(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    procedure SetImporte(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} );
    { Methods & Properties }
    property Impuesto: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImpuesto write SetImpuesto;
    property Tasa: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetTasa write SetTasa;
    property Importe: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read GetImporte write SetImporte;
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
