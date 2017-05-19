
{************************************************************************************************}
{                                                                                                }
{                                        XML Data Binding                                        }
{                                                                                                }
{                                                                                                }
{************************************************************************************************}

unit Facturacion.ComprobanteV32;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IComprobanteFiscalV32 = interface;
  IComprobanteFiscalV32_Emisor = interface;
  IComprobanteFiscalV32_UbicacionFiscal = interface;
  IComprobanteFiscalV32_Ubicacion = interface;
  IComprobanteFiscalV32_Emisor_RegimenFiscal = interface;
  IComprobanteFiscalV32_Emisor_RegimenFiscalList = interface;
  IComprobanteFiscalV32_Receptor = interface;
  IComprobanteFiscalV32_Conceptos = interface;
  IComprobanteFiscalV32_Conceptos_Concepto = interface;
  IComprobanteFiscalV32_InformacionAduanera = interface;
  IComprobanteFiscalV32_InformacionAduaneraList = interface;
  IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial = interface;
  IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto = interface;
  IComprobanteFiscalV32_Conceptos_Concepto_Parte = interface;
  IComprobanteFiscalV32_Conceptos_Concepto_ParteList = interface;
  IComprobanteFiscalV32_Impuestos = interface;
  IComprobanteFiscalV32_Impuestos_Retenciones = interface;
  IComprobanteFiscalV32_Impuestos_Retenciones_Retencion = interface;
  IComprobanteFiscalV32_Impuestos_Traslados = interface;
  IComprobanteFiscalV32_Impuestos_Traslados_Traslado = interface;
  IComprobanteFiscalV32_Complemento = interface;
  IComprobanteFiscalV32_Addenda = interface;

{ IComprobanteFiscalV32 }

  IComprobanteFiscalV32 = interface(IXMLNode)
    ['{C018CDC5-5889-4659-A166-9E5A173406AC}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Sello: UnicodeString;
    function Get_FormaDePago: UnicodeString;
    function Get_NoCertificado: UnicodeString;
    function Get_Certificado: UnicodeString;
    function Get_CondicionesDePago: UnicodeString;
    function Get_SubTotal: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_MotivoDescuento: UnicodeString;
    function Get_TipoCambio: UnicodeString;
    function Get_Moneda: UnicodeString;
    function Get_Total: UnicodeString;
    function Get_TipoDeComprobante: UnicodeString;
    function Get_MetodoDePago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_NumCtaPago: UnicodeString;
    function Get_FolioFiscalOrig: UnicodeString;
    function Get_SerieFolioFiscalOrig: UnicodeString;
    function Get_FechaFolioFiscalOrig: UnicodeString;
    function Get_MontoFolioFiscalOrig: UnicodeString;
    function Get_Emisor: IComprobanteFiscalV32_Emisor;
    function Get_Receptor: IComprobanteFiscalV32_Receptor;
    function Get_Conceptos: IComprobanteFiscalV32_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV32_Impuestos;
    function Get_Complemento: IComprobanteFiscalV32_Complemento;
    function Get_Addenda: IComprobanteFiscalV32_Addenda;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Sello(Value: UnicodeString);
    procedure Set_FormaDePago(Value: UnicodeString);
    procedure Set_NoCertificado(Value: UnicodeString);
    procedure Set_Certificado(Value: UnicodeString);
    procedure Set_CondicionesDePago(Value: UnicodeString);
    procedure Set_SubTotal(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_MotivoDescuento(Value: UnicodeString);
    procedure Set_TipoCambio(Value: UnicodeString);
    procedure Set_Moneda(Value: UnicodeString);
    procedure Set_Total(Value: UnicodeString);
    procedure Set_TipoDeComprobante(Value: UnicodeString);
    procedure Set_MetodoDePago(Value: UnicodeString);
    procedure Set_LugarExpedicion(Value: UnicodeString);
    procedure Set_NumCtaPago(Value: UnicodeString);
    procedure Set_FolioFiscalOrig(Value: UnicodeString);
    procedure Set_SerieFolioFiscalOrig(Value: UnicodeString);
    procedure Set_FechaFolioFiscalOrig(Value: UnicodeString);
    procedure Set_MontoFolioFiscalOrig(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property Serie: UnicodeString read Get_Serie write Set_Serie;
    property Folio: UnicodeString read Get_Folio write Set_Folio;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property Sello: UnicodeString read Get_Sello write Set_Sello;
    property FormaDePago: UnicodeString read Get_FormaDePago write Set_FormaDePago;
    property NoCertificado: UnicodeString read Get_NoCertificado write Set_NoCertificado;
    property Certificado: UnicodeString read Get_Certificado write Set_Certificado;
    property CondicionesDePago: UnicodeString read Get_CondicionesDePago write Set_CondicionesDePago;
    property SubTotal: UnicodeString read Get_SubTotal write Set_SubTotal;
    property Descuento: UnicodeString read Get_Descuento write Set_Descuento;
    property MotivoDescuento: UnicodeString read Get_MotivoDescuento write Set_MotivoDescuento;
    property TipoCambio: UnicodeString read Get_TipoCambio write Set_TipoCambio;
    property Moneda: UnicodeString read Get_Moneda write Set_Moneda;
    property Total: UnicodeString read Get_Total write Set_Total;
    property TipoDeComprobante: UnicodeString read Get_TipoDeComprobante write Set_TipoDeComprobante;
    property MetodoDePago: UnicodeString read Get_MetodoDePago write Set_MetodoDePago;
    property LugarExpedicion: UnicodeString read Get_LugarExpedicion write Set_LugarExpedicion;
    property NumCtaPago: UnicodeString read Get_NumCtaPago write Set_NumCtaPago;
    property FolioFiscalOrig: UnicodeString read Get_FolioFiscalOrig write Set_FolioFiscalOrig;
    property SerieFolioFiscalOrig: UnicodeString read Get_SerieFolioFiscalOrig write Set_SerieFolioFiscalOrig;
    property FechaFolioFiscalOrig: UnicodeString read Get_FechaFolioFiscalOrig write Set_FechaFolioFiscalOrig;
    property MontoFolioFiscalOrig: UnicodeString read Get_MontoFolioFiscalOrig write Set_MontoFolioFiscalOrig;
    property Emisor: IComprobanteFiscalV32_Emisor read Get_Emisor;
    property Receptor: IComprobanteFiscalV32_Receptor read Get_Receptor;
    property Conceptos: IComprobanteFiscalV32_Conceptos read Get_Conceptos;
    property Impuestos: IComprobanteFiscalV32_Impuestos read Get_Impuestos;
    property Complemento: IComprobanteFiscalV32_Complemento read Get_Complemento;
    property Addenda: IComprobanteFiscalV32_Addenda read Get_Addenda;
  end;

{ IComprobanteFiscalV32_Emisor }

  IComprobanteFiscalV32_Emisor = interface(IXMLNode)
    ['{741EBD22-84AE-42F0-8C6B-E40A782D35B1}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_DomicilioFiscal: IComprobanteFiscalV32_UbicacionFiscal;
    function Get_ExpedidoEn: IComprobanteFiscalV32_Ubicacion;
    function Get_RegimenFiscal: IComprobanteFiscalV32_Emisor_RegimenFiscalList;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property DomicilioFiscal: IComprobanteFiscalV32_UbicacionFiscal read Get_DomicilioFiscal;
    property ExpedidoEn: IComprobanteFiscalV32_Ubicacion read Get_ExpedidoEn;
    property RegimenFiscal: IComprobanteFiscalV32_Emisor_RegimenFiscalList read Get_RegimenFiscal;
  end;

{ IComprobanteFiscalV32_UbicacionFiscal }

  IComprobanteFiscalV32_UbicacionFiscal = interface(IXMLNode)
    ['{F8F04714-6452-4B4A-8A37-BC7AF7ACF117}']
    { Property Accessors }
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NoExterior: UnicodeString read Get_NoExterior write Set_NoExterior;
    property NoInterior: UnicodeString read Get_NoInterior write Set_NoInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ IComprobanteFiscalV32_Ubicacion }

  IComprobanteFiscalV32_Ubicacion = interface(IXMLNode)
    ['{D611FB84-616C-4C83-8FAA-A98323EF5093}']
    { Property Accessors }
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NoExterior: UnicodeString read Get_NoExterior write Set_NoExterior;
    property NoInterior: UnicodeString read Get_NoInterior write Set_NoInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ IComprobanteFiscalV32_Emisor_RegimenFiscal }

  IComprobanteFiscalV32_Emisor_RegimenFiscal = interface(IXMLNode)
    ['{1CAF225E-E683-45EF-B4E5-A2926CF6ECE4}']
    { Property Accessors }
    function Get_Regimen: UnicodeString;
    procedure Set_Regimen(Value: UnicodeString);
    { Methods & Properties }
    property Regimen: UnicodeString read Get_Regimen write Set_Regimen;
  end;

{ IComprobanteFiscalV32_Emisor_RegimenFiscalList }

  IComprobanteFiscalV32_Emisor_RegimenFiscalList = interface(IXMLNodeCollection)
    ['{41691E65-0E45-4ED1-B5D9-BEDC6EA29D53}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_Emisor_RegimenFiscal;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;
    property Items[Index: Integer]: IComprobanteFiscalV32_Emisor_RegimenFiscal read Get_Item; default;
  end;

{ IComprobanteFiscalV32_Receptor }

  IComprobanteFiscalV32_Receptor = interface(IXMLNode)
    ['{397F2929-F701-4886-9D41-B0800E3CAAF1}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio: IComprobanteFiscalV32_Ubicacion;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property Domicilio: IComprobanteFiscalV32_Ubicacion read Get_Domicilio;
  end;

{ IComprobanteFiscalV32_Conceptos }

  IComprobanteFiscalV32_Conceptos = interface(IXMLNodeCollection)
    ['{3BB9E2A7-AAC7-41F3-9513-BF95B5723081}']
    { Property Accessors }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
    property Concepto[Index: Integer]: IComprobanteFiscalV32_Conceptos_Concepto read Get_Concepto; default;
  end;

{ IComprobanteFiscalV32_Conceptos_Concepto }

  IComprobanteFiscalV32_Conceptos_Concepto = interface(IXMLNode)
    ['{B345F4BA-72C4-4C51-8940-152F8C205DE3}']
    { Property Accessors }
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera: IComprobanteFiscalV32_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial;
    function Get_ComplementoConcepto: IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV32_Conceptos_Concepto_ParteList;
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Cantidad: UnicodeString read Get_Cantidad write Set_Cantidad;
    property Unidad: UnicodeString read Get_Unidad write Set_Unidad;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property Descripcion: UnicodeString read Get_Descripcion write Set_Descripcion;
    property ValorUnitario: UnicodeString read Get_ValorUnitario write Set_ValorUnitario;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property InformacionAduanera: IComprobanteFiscalV32_InformacionAduaneraList read Get_InformacionAduanera;
    property CuentaPredial: IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial read Get_CuentaPredial;
    property ComplementoConcepto: IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto read Get_ComplementoConcepto;
    property Parte: IComprobanteFiscalV32_Conceptos_Concepto_ParteList read Get_Parte;
  end;

{ IComprobanteFiscalV32_InformacionAduanera }

  IComprobanteFiscalV32_InformacionAduanera = interface(IXMLNode)
    ['{177ED3AD-2515-4AA7-BEA3-5BB635ABBB19}']
    { Property Accessors }
    function Get_Numero: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Aduana: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Aduana(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property Aduana: UnicodeString read Get_Aduana write Set_Aduana;
  end;

{ IComprobanteFiscalV32_InformacionAduaneraList }

  IComprobanteFiscalV32_InformacionAduaneraList = interface(IXMLNodeCollection)
    ['{52290AE7-F241-4A39-BF1C-29845CCFD677}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
    property Items[Index: Integer]: IComprobanteFiscalV32_InformacionAduanera read Get_Item; default;
  end;

{ IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial }

  IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial = interface(IXMLNode)
    ['{B543873D-8F4C-45FB-B780-E7DD3D58E063}']
    { Property Accessors }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
  end;

{ IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto }

  IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto = interface(IXMLNode)
    ['{BCD040CF-864E-4946-9F72-C9264E007274}']
  end;

{ IComprobanteFiscalV32_Conceptos_Concepto_Parte }

  IComprobanteFiscalV32_Conceptos_Concepto_Parte = interface(IXMLNodeCollection)
    ['{F511025E-8991-4717-9558-3B420B08A294}']
    { Property Accessors }
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
    property Cantidad: UnicodeString read Get_Cantidad write Set_Cantidad;
    property Unidad: UnicodeString read Get_Unidad write Set_Unidad;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property Descripcion: UnicodeString read Get_Descripcion write Set_Descripcion;
    property ValorUnitario: UnicodeString read Get_ValorUnitario write Set_ValorUnitario;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property InformacionAduanera[Index: Integer]: IComprobanteFiscalV32_InformacionAduanera read Get_InformacionAduanera; default;
  end;

{ IComprobanteFiscalV32_Conceptos_Concepto_ParteList }

  IComprobanteFiscalV32_Conceptos_Concepto_ParteList = interface(IXMLNodeCollection)
    ['{D63E7450-EBC8-43F5-A2E6-3D224BD05ADF}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;
    property Items[Index: Integer]: IComprobanteFiscalV32_Conceptos_Concepto_Parte read Get_Item; default;
  end;

{ IComprobanteFiscalV32_Impuestos }

  IComprobanteFiscalV32_Impuestos = interface(IXMLNode)
    ['{BC6F24CC-0717-4373-89FA-1C4263E394C9}']
    { Property Accessors }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV32_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV32_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: UnicodeString read Get_TotalImpuestosRetenidos write Set_TotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: UnicodeString read Get_TotalImpuestosTrasladados write Set_TotalImpuestosTrasladados;
    property Retenciones: IComprobanteFiscalV32_Impuestos_Retenciones read Get_Retenciones;
    property Traslados: IComprobanteFiscalV32_Impuestos_Traslados read Get_Traslados;
  end;

{ IComprobanteFiscalV32_Impuestos_Retenciones }

  IComprobanteFiscalV32_Impuestos_Retenciones = interface(IXMLNodeCollection)
    ['{47987050-FACB-4816-A3F4-F31B92946E58}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
    property Retencion[Index: Integer]: IComprobanteFiscalV32_Impuestos_Retenciones_Retencion read Get_Retencion; default;
  end;

{ IComprobanteFiscalV32_Impuestos_Retenciones_Retencion }

  IComprobanteFiscalV32_Impuestos_Retenciones_Retencion = interface(IXMLNode)
    ['{7FCAC018-4976-4A74-A853-B140589CA4F1}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV32_Impuestos_Traslados }

  IComprobanteFiscalV32_Impuestos_Traslados = interface(IXMLNodeCollection)
    ['{D5857541-E1BC-4180-BA1B-58580307C404}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
    { Methods & Properties }
    function Add: IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
    property Traslado[Index: Integer]: IComprobanteFiscalV32_Impuestos_Traslados_Traslado read Get_Traslado; default;
  end;

{ IComprobanteFiscalV32_Impuestos_Traslados_Traslado }

  IComprobanteFiscalV32_Impuestos_Traslados_Traslado = interface(IXMLNode)
    ['{7D3DEDAA-FC75-4E56-8D66-DA65C7B6DFD9}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_Tasa: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Tasa(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property Tasa: UnicodeString read Get_Tasa write Set_Tasa;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV32_Complemento }

  IComprobanteFiscalV32_Complemento = interface(IXMLNode)
    ['{A213DB70-FC9C-48EC-A4AF-552E5289A052}']
  end;

{ IComprobanteFiscalV32_Addenda }

  IComprobanteFiscalV32_Addenda = interface(IXMLNode)
    ['{C1D14BE8-CAC8-40B0-BA9E-21E92D055253}']
  end;

{ Forward Decls }

  TXMLComprobante = class;
  TXMLComprobante_Emisor = class;
  TXMLT_UbicacionFiscal = class;
  TXMLT_Ubicacion = class;
  TXMLComprobante_Emisor_RegimenFiscal = class;
  TXMLComprobante_Emisor_RegimenFiscalList = class;
  TXMLComprobante_Receptor = class;
  TXMLComprobante_Conceptos = class;
  TXMLComprobante_Conceptos_Concepto = class;
  TXMLT_InformacionAduanera = class;
  TXMLT_InformacionAduaneraList = class;
  TXMLComprobante_Conceptos_Concepto_CuentaPredial = class;
  TXMLComprobante_Conceptos_Concepto_ComplementoConcepto = class;
  TXMLComprobante_Conceptos_Concepto_Parte = class;
  TXMLComprobante_Conceptos_Concepto_ParteList = class;
  TXMLComprobante_Impuestos = class;
  TXMLComprobante_Impuestos_Retenciones = class;
  TXMLComprobante_Impuestos_Retenciones_Retencion = class;
  TXMLComprobante_Impuestos_Traslados = class;
  TXMLComprobante_Impuestos_Traslados_Traslado = class;
  TXMLComprobante_Complemento = class;
  TXMLComprobante_Addenda = class;

{ TXMLComprobante }

  TXMLComprobante = class(TXMLNode, IComprobanteFiscalV32)
  protected
    { IComprobanteFiscalV32 }
    function Get_Version: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Sello: UnicodeString;
    function Get_FormaDePago: UnicodeString;
    function Get_NoCertificado: UnicodeString;
    function Get_Certificado: UnicodeString;
    function Get_CondicionesDePago: UnicodeString;
    function Get_SubTotal: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_MotivoDescuento: UnicodeString;
    function Get_TipoCambio: UnicodeString;
    function Get_Moneda: UnicodeString;
    function Get_Total: UnicodeString;
    function Get_TipoDeComprobante: UnicodeString;
    function Get_MetodoDePago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_NumCtaPago: UnicodeString;
    function Get_FolioFiscalOrig: UnicodeString;
    function Get_SerieFolioFiscalOrig: UnicodeString;
    function Get_FechaFolioFiscalOrig: UnicodeString;
    function Get_MontoFolioFiscalOrig: UnicodeString;
    function Get_Emisor: IComprobanteFiscalV32_Emisor;
    function Get_Receptor: IComprobanteFiscalV32_Receptor;
    function Get_Conceptos: IComprobanteFiscalV32_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV32_Impuestos;
    function Get_Complemento: IComprobanteFiscalV32_Complemento;
    function Get_Addenda: IComprobanteFiscalV32_Addenda;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Sello(Value: UnicodeString);
    procedure Set_FormaDePago(Value: UnicodeString);
    procedure Set_NoCertificado(Value: UnicodeString);
    procedure Set_Certificado(Value: UnicodeString);
    procedure Set_CondicionesDePago(Value: UnicodeString);
    procedure Set_SubTotal(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_MotivoDescuento(Value: UnicodeString);
    procedure Set_TipoCambio(Value: UnicodeString);
    procedure Set_Moneda(Value: UnicodeString);
    procedure Set_Total(Value: UnicodeString);
    procedure Set_TipoDeComprobante(Value: UnicodeString);
    procedure Set_MetodoDePago(Value: UnicodeString);
    procedure Set_LugarExpedicion(Value: UnicodeString);
    procedure Set_NumCtaPago(Value: UnicodeString);
    procedure Set_FolioFiscalOrig(Value: UnicodeString);
    procedure Set_SerieFolioFiscalOrig(Value: UnicodeString);
    procedure Set_FechaFolioFiscalOrig(Value: UnicodeString);
    procedure Set_MontoFolioFiscalOrig(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Emisor }

  TXMLComprobante_Emisor = class(TXMLNode, IComprobanteFiscalV32_Emisor)
  private
    FRegimenFiscal: IComprobanteFiscalV32_Emisor_RegimenFiscalList;
  protected
    { IComprobanteFiscalV32_Emisor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_DomicilioFiscal: IComprobanteFiscalV32_UbicacionFiscal;
    function Get_ExpedidoEn: IComprobanteFiscalV32_Ubicacion;
    function Get_RegimenFiscal: IComprobanteFiscalV32_Emisor_RegimenFiscalList;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLT_UbicacionFiscal }

  TXMLT_UbicacionFiscal = class(TXMLNode, IComprobanteFiscalV32_UbicacionFiscal)
  protected
    { IComprobanteFiscalV32_UbicacionFiscal }
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TXMLT_Ubicacion }

  TXMLT_Ubicacion = class(TXMLNode, IComprobanteFiscalV32_Ubicacion)
  protected
    { IComprobanteFiscalV32_Ubicacion }
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TXMLComprobante_Emisor_RegimenFiscal }

  TXMLComprobante_Emisor_RegimenFiscal = class(TXMLNode, IComprobanteFiscalV32_Emisor_RegimenFiscal)
  protected
    { IComprobanteFiscalV32_Emisor_RegimenFiscal }
    function Get_Regimen: UnicodeString;
    procedure Set_Regimen(Value: UnicodeString);
  end;

{ TXMLComprobante_Emisor_RegimenFiscalList }

  TXMLComprobante_Emisor_RegimenFiscalList = class(TXMLNodeCollection, IComprobanteFiscalV32_Emisor_RegimenFiscalList)
  protected
    { IComprobanteFiscalV32_Emisor_RegimenFiscalList }
    function Add: IComprobanteFiscalV32_Emisor_RegimenFiscal;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;
  end;

{ TXMLComprobante_Receptor }

  TXMLComprobante_Receptor = class(TXMLNode, IComprobanteFiscalV32_Receptor)
  protected
    { IComprobanteFiscalV32_Receptor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio: IComprobanteFiscalV32_Ubicacion;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Conceptos }

  TXMLComprobante_Conceptos = class(TXMLNodeCollection, IComprobanteFiscalV32_Conceptos)
  protected
    { IComprobanteFiscalV32_Conceptos }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
    function Add: IComprobanteFiscalV32_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Conceptos_Concepto }

  TXMLComprobante_Conceptos_Concepto = class(TXMLNode, IComprobanteFiscalV32_Conceptos_Concepto)
  private
    FInformacionAduanera: IComprobanteFiscalV32_InformacionAduaneraList;
    FParte: IComprobanteFiscalV32_Conceptos_Concepto_ParteList;
  protected
    { IComprobanteFiscalV32_Conceptos_Concepto }
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera: IComprobanteFiscalV32_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial;
    function Get_ComplementoConcepto: IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV32_Conceptos_Concepto_ParteList;
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLT_InformacionAduanera }

  TXMLT_InformacionAduanera = class(TXMLNode, IComprobanteFiscalV32_InformacionAduanera)
  protected
    { IComprobanteFiscalV32_InformacionAduanera }
    function Get_Numero: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Aduana: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Aduana(Value: UnicodeString);
  end;

{ TXMLT_InformacionAduaneraList }

  TXMLT_InformacionAduaneraList = class(TXMLNodeCollection, IComprobanteFiscalV32_InformacionAduaneraList)
  protected
    { IComprobanteFiscalV32_InformacionAduaneraList }
    function Add: IComprobanteFiscalV32_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
  end;

{ TXMLComprobante_Conceptos_Concepto_CuentaPredial }

  TXMLComprobante_Conceptos_Concepto_CuentaPredial = class(TXMLNode, IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial)
  protected
    { IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
  end;

{ TXMLComprobante_Conceptos_Concepto_ComplementoConcepto }

  TXMLComprobante_Conceptos_Concepto_ComplementoConcepto = class(TXMLNode, IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto)
  protected
    { IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto }
  end;

{ TXMLComprobante_Conceptos_Concepto_Parte }

  TXMLComprobante_Conceptos_Concepto_Parte = class(TXMLNodeCollection, IComprobanteFiscalV32_Conceptos_Concepto_Parte)
  protected
    { IComprobanteFiscalV32_Conceptos_Concepto_Parte }
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    function Add: IComprobanteFiscalV32_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Conceptos_Concepto_ParteList }

  TXMLComprobante_Conceptos_Concepto_ParteList = class(TXMLNodeCollection, IComprobanteFiscalV32_Conceptos_Concepto_ParteList)
  protected
    { IComprobanteFiscalV32_Conceptos_Concepto_ParteList }
    function Add: IComprobanteFiscalV32_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;
  end;

{ TXMLComprobante_Impuestos }

  TXMLComprobante_Impuestos = class(TXMLNode, IComprobanteFiscalV32_Impuestos)
  protected
    { IComprobanteFiscalV32_Impuestos }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV32_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV32_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Impuestos_Retenciones }

  TXMLComprobante_Impuestos_Retenciones = class(TXMLNodeCollection, IComprobanteFiscalV32_Impuestos_Retenciones)
  protected
    { IComprobanteFiscalV32_Impuestos_Retenciones }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
    function Add: IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Impuestos_Retenciones_Retencion }

  TXMLComprobante_Impuestos_Retenciones_Retencion = class(TXMLNode, IComprobanteFiscalV32_Impuestos_Retenciones_Retencion)
  protected
    { IComprobanteFiscalV32_Impuestos_Retenciones_Retencion }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TXMLComprobante_Impuestos_Traslados }

  TXMLComprobante_Impuestos_Traslados = class(TXMLNodeCollection, IComprobanteFiscalV32_Impuestos_Traslados)
  protected
    { IComprobanteFiscalV32_Impuestos_Traslados }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
    function Add: IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComprobante_Impuestos_Traslados_Traslado }

  TXMLComprobante_Impuestos_Traslados_Traslado = class(TXMLNode, IComprobanteFiscalV32_Impuestos_Traslados_Traslado)
  protected
    { IComprobanteFiscalV32_Impuestos_Traslados_Traslado }
    function Get_Impuesto: UnicodeString;
    function Get_Tasa: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Tasa(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TXMLComprobante_Complemento }

  TXMLComprobante_Complemento = class(TXMLNode, IComprobanteFiscalV32_Complemento)
  protected
    { IComprobanteFiscalV32_Complemento }
  end;

{ TXMLComprobante_Addenda }

  TXMLComprobante_Addenda = class(TXMLNode, IComprobanteFiscalV32_Addenda)
  protected
    { IComprobanteFiscalV32_Addenda }
  end;

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IComprobanteFiscalV32;
function LoadComprobante(const FileName: string): IComprobanteFiscalV32;
function NewComprobante: IComprobanteFiscalV32;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/3';

implementation

{ Global Functions }

function GetComprobante(Doc: IXMLDocument): IComprobanteFiscalV32;
begin
  Result := Doc.GetDocBinding('Comprobante', TXMLComprobante, TargetNamespace) as IComprobanteFiscalV32;
end;

function LoadComprobante(const FileName: string): IComprobanteFiscalV32;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Comprobante', TXMLComprobante, TargetNamespace) as IComprobanteFiscalV32;
end;

function NewComprobante: IComprobanteFiscalV32;
begin
  Result := NewXMLDocument.GetDocBinding('Comprobante', TXMLComprobante, TargetNamespace) as IComprobanteFiscalV32;
end;

{ TXMLComprobante }

procedure TXMLComprobante.AfterConstruction;
begin
  RegisterChildNode('Emisor', TXMLComprobante_Emisor);
  RegisterChildNode('Receptor', TXMLComprobante_Receptor);
  RegisterChildNode('Conceptos', TXMLComprobante_Conceptos);
  RegisterChildNode('Impuestos', TXMLComprobante_Impuestos);
  RegisterChildNode('Complemento', TXMLComprobante_Complemento);
  RegisterChildNode('Addenda', TXMLComprobante_Addenda);
  inherited;
end;

function TXMLComprobante.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLComprobante.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLComprobante.Get_Serie: UnicodeString;
begin
  Result := AttributeNodes['serie'].Text;
end;

procedure TXMLComprobante.Set_Serie(Value: UnicodeString);
begin
  SetAttribute('serie', Value);
end;

function TXMLComprobante.Get_Folio: UnicodeString;
begin
  Result := AttributeNodes['folio'].Text;
end;

procedure TXMLComprobante.Set_Folio(Value: UnicodeString);
begin
  SetAttribute('folio', Value);
end;

function TXMLComprobante.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TXMLComprobante.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('fecha', Value);
end;

function TXMLComprobante.Get_Sello: UnicodeString;
begin
  Result := AttributeNodes['sello'].Text;
end;

procedure TXMLComprobante.Set_Sello(Value: UnicodeString);
begin
  SetAttribute('sello', Value);
end;

function TXMLComprobante.Get_FormaDePago: UnicodeString;
begin
  Result := AttributeNodes['formaDePago'].Text;
end;

procedure TXMLComprobante.Set_FormaDePago(Value: UnicodeString);
begin
  SetAttribute('formaDePago', Value);
end;

function TXMLComprobante.Get_NoCertificado: UnicodeString;
begin
  Result := AttributeNodes['noCertificado'].Text;
end;

procedure TXMLComprobante.Set_NoCertificado(Value: UnicodeString);
begin
  SetAttribute('noCertificado', Value);
end;

function TXMLComprobante.Get_Certificado: UnicodeString;
begin
  Result := AttributeNodes['certificado'].Text;
end;

procedure TXMLComprobante.Set_Certificado(Value: UnicodeString);
begin
  SetAttribute('certificado', Value);
end;

function TXMLComprobante.Get_CondicionesDePago: UnicodeString;
begin
  Result := AttributeNodes['condicionesDePago'].Text;
end;

procedure TXMLComprobante.Set_CondicionesDePago(Value: UnicodeString);
begin
  SetAttribute('condicionesDePago', Value);
end;

function TXMLComprobante.Get_SubTotal: UnicodeString;
begin
  Result := AttributeNodes['subTotal'].Text;
end;

procedure TXMLComprobante.Set_SubTotal(Value: UnicodeString);
begin
  SetAttribute('subTotal', Value);
end;

function TXMLComprobante.Get_Descuento: UnicodeString;
begin
  Result := AttributeNodes['descuento'].Text;
end;

procedure TXMLComprobante.Set_Descuento(Value: UnicodeString);
begin
  SetAttribute('descuento', Value);
end;

function TXMLComprobante.Get_MotivoDescuento: UnicodeString;
begin
  Result := AttributeNodes['motivoDescuento'].Text;
end;

procedure TXMLComprobante.Set_MotivoDescuento(Value: UnicodeString);
begin
  SetAttribute('motivoDescuento', Value);
end;

function TXMLComprobante.Get_TipoCambio: UnicodeString;
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TXMLComprobante.Set_TipoCambio(Value: UnicodeString);
begin
  SetAttribute('TipoCambio', Value);
end;

function TXMLComprobante.Get_Moneda: UnicodeString;
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TXMLComprobante.Set_Moneda(Value: UnicodeString);
begin
  SetAttribute('Moneda', Value);
end;

function TXMLComprobante.Get_Total: UnicodeString;
begin
  Result := AttributeNodes['total'].Text;
end;

procedure TXMLComprobante.Set_Total(Value: UnicodeString);
begin
  SetAttribute('total', Value);
end;

function TXMLComprobante.Get_TipoDeComprobante: UnicodeString;
begin
  Result := AttributeNodes['tipoDeComprobante'].Text;
end;

procedure TXMLComprobante.Set_TipoDeComprobante(Value: UnicodeString);
begin
  SetAttribute('tipoDeComprobante', Value);
end;

function TXMLComprobante.Get_MetodoDePago: UnicodeString;
begin
  Result := AttributeNodes['metodoDePago'].Text;
end;

procedure TXMLComprobante.Set_MetodoDePago(Value: UnicodeString);
begin
  SetAttribute('metodoDePago', Value);
end;

function TXMLComprobante.Get_LugarExpedicion: UnicodeString;
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TXMLComprobante.Set_LugarExpedicion(Value: UnicodeString);
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TXMLComprobante.Get_NumCtaPago: UnicodeString;
begin
  Result := AttributeNodes['NumCtaPago'].Text;
end;

procedure TXMLComprobante.Set_NumCtaPago(Value: UnicodeString);
begin
  SetAttribute('NumCtaPago', Value);
end;

function TXMLComprobante.Get_FolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['FolioFiscalOrig'].Text;
end;

procedure TXMLComprobante.Set_FolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('FolioFiscalOrig', Value);
end;

function TXMLComprobante.Get_SerieFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['SerieFolioFiscalOrig'].Text;
end;

procedure TXMLComprobante.Set_SerieFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('SerieFolioFiscalOrig', Value);
end;

function TXMLComprobante.Get_FechaFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['FechaFolioFiscalOrig'].Text;
end;

procedure TXMLComprobante.Set_FechaFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('FechaFolioFiscalOrig', Value);
end;

function TXMLComprobante.Get_MontoFolioFiscalOrig: UnicodeString;
begin
  Result := AttributeNodes['MontoFolioFiscalOrig'].Text;
end;

procedure TXMLComprobante.Set_MontoFolioFiscalOrig(Value: UnicodeString);
begin
  SetAttribute('MontoFolioFiscalOrig', Value);
end;

function TXMLComprobante.Get_Emisor: IComprobanteFiscalV32_Emisor;
begin
  Result := ChildNodes['Emisor'] as IComprobanteFiscalV32_Emisor;
end;

function TXMLComprobante.Get_Receptor: IComprobanteFiscalV32_Receptor;
begin
  Result := ChildNodes['Receptor'] as IComprobanteFiscalV32_Receptor;
end;

function TXMLComprobante.Get_Conceptos: IComprobanteFiscalV32_Conceptos;
begin
  Result := ChildNodes['Conceptos'] as IComprobanteFiscalV32_Conceptos;
end;

function TXMLComprobante.Get_Impuestos: IComprobanteFiscalV32_Impuestos;
begin
  Result := ChildNodes['Impuestos'] as IComprobanteFiscalV32_Impuestos;
end;

function TXMLComprobante.Get_Complemento: IComprobanteFiscalV32_Complemento;
begin
  Result := ChildNodes['Complemento'] as IComprobanteFiscalV32_Complemento;
end;

function TXMLComprobante.Get_Addenda: IComprobanteFiscalV32_Addenda;
begin
  Result := ChildNodes['Addenda'] as IComprobanteFiscalV32_Addenda;
end;

{ TXMLComprobante_Emisor }

procedure TXMLComprobante_Emisor.AfterConstruction;
begin
  RegisterChildNode('DomicilioFiscal', TXMLT_UbicacionFiscal);
  RegisterChildNode('ExpedidoEn', TXMLT_Ubicacion);
  RegisterChildNode('RegimenFiscal', TXMLComprobante_Emisor_RegimenFiscal);
  FRegimenFiscal := CreateCollection(TXMLComprobante_Emisor_RegimenFiscalList, IComprobanteFiscalV32_Emisor_RegimenFiscal, 'RegimenFiscal') as IComprobanteFiscalV32_Emisor_RegimenFiscalList;
  inherited;
end;

function TXMLComprobante_Emisor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TXMLComprobante_Emisor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('rfc', Value);
end;

function TXMLComprobante_Emisor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TXMLComprobante_Emisor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('nombre', Value);
end;

function TXMLComprobante_Emisor.Get_DomicilioFiscal: IComprobanteFiscalV32_UbicacionFiscal;
begin
  Result := ChildNodes['DomicilioFiscal'] as IComprobanteFiscalV32_UbicacionFiscal;
end;

function TXMLComprobante_Emisor.Get_ExpedidoEn: IComprobanteFiscalV32_Ubicacion;
begin
  Result := ChildNodes['ExpedidoEn'] as IComprobanteFiscalV32_Ubicacion;
end;

function TXMLComprobante_Emisor.Get_RegimenFiscal: IComprobanteFiscalV32_Emisor_RegimenFiscalList;
begin
  Result := FRegimenFiscal;
end;

{ TXMLT_UbicacionFiscal }

function TXMLT_UbicacionFiscal.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_UbicacionFiscal.Get_NoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_NoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_UbicacionFiscal.Get_NoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_NoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_UbicacionFiscal.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_UbicacionFiscal.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_UbicacionFiscal.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_UbicacionFiscal.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_UbicacionFiscal.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_UbicacionFiscal.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_UbicacionFiscal.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_UbicacionFiscal.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLT_Ubicacion }

function TXMLT_Ubicacion.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['calle'].Text;
end;

procedure TXMLT_Ubicacion.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('calle', Value);
end;

function TXMLT_Ubicacion.Get_NoExterior: UnicodeString;
begin
  Result := AttributeNodes['noExterior'].Text;
end;

procedure TXMLT_Ubicacion.Set_NoExterior(Value: UnicodeString);
begin
  SetAttribute('noExterior', Value);
end;

function TXMLT_Ubicacion.Get_NoInterior: UnicodeString;
begin
  Result := AttributeNodes['noInterior'].Text;
end;

procedure TXMLT_Ubicacion.Set_NoInterior(Value: UnicodeString);
begin
  SetAttribute('noInterior', Value);
end;

function TXMLT_Ubicacion.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['colonia'].Text;
end;

procedure TXMLT_Ubicacion.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('colonia', Value);
end;

function TXMLT_Ubicacion.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['localidad'].Text;
end;

procedure TXMLT_Ubicacion.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('localidad', Value);
end;

function TXMLT_Ubicacion.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['referencia'].Text;
end;

procedure TXMLT_Ubicacion.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('referencia', Value);
end;

function TXMLT_Ubicacion.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['municipio'].Text;
end;

procedure TXMLT_Ubicacion.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('municipio', Value);
end;

function TXMLT_Ubicacion.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['estado'].Text;
end;

procedure TXMLT_Ubicacion.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('estado', Value);
end;

function TXMLT_Ubicacion.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['pais'].Text;
end;

procedure TXMLT_Ubicacion.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('pais', Value);
end;

function TXMLT_Ubicacion.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['codigoPostal'].Text;
end;

procedure TXMLT_Ubicacion.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('codigoPostal', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscal }

function TXMLComprobante_Emisor_RegimenFiscal.Get_Regimen: UnicodeString;
begin
  Result := AttributeNodes['Regimen'].Text;
end;

procedure TXMLComprobante_Emisor_RegimenFiscal.Set_Regimen(Value: UnicodeString);
begin
  SetAttribute('Regimen', Value);
end;

{ TXMLComprobante_Emisor_RegimenFiscalList }

function TXMLComprobante_Emisor_RegimenFiscalList.Add: IComprobanteFiscalV32_Emisor_RegimenFiscal;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.Insert(const Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_Emisor_RegimenFiscal;
end;

function TXMLComprobante_Emisor_RegimenFiscalList.Get_Item(Index: Integer): IComprobanteFiscalV32_Emisor_RegimenFiscal;
begin
  Result := List[Index] as IComprobanteFiscalV32_Emisor_RegimenFiscal;
end;

{ TXMLComprobante_Receptor }

procedure TXMLComprobante_Receptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TXMLT_Ubicacion);
  inherited;
end;

function TXMLComprobante_Receptor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['rfc'].Text;
end;

procedure TXMLComprobante_Receptor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('rfc', Value);
end;

function TXMLComprobante_Receptor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['nombre'].Text;
end;

procedure TXMLComprobante_Receptor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('nombre', Value);
end;

function TXMLComprobante_Receptor.Get_Domicilio: IComprobanteFiscalV32_Ubicacion;
begin
  Result := ChildNodes['Domicilio'] as IComprobanteFiscalV32_Ubicacion;
end;

{ TXMLComprobante_Conceptos }

procedure TXMLComprobante_Conceptos.AfterConstruction;
begin
  RegisterChildNode('Concepto', TXMLComprobante_Conceptos_Concepto);
  ItemTag := 'Concepto';
  ItemInterface := IComprobanteFiscalV32_Conceptos_Concepto;
  inherited;
end;

function TXMLComprobante_Conceptos.Get_Concepto(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
begin
  Result := List[Index] as IComprobanteFiscalV32_Conceptos_Concepto;
end;

function TXMLComprobante_Conceptos.Add: IComprobanteFiscalV32_Conceptos_Concepto;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_Conceptos_Concepto;
end;

function TXMLComprobante_Conceptos.Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_Conceptos_Concepto;
end;

{ TXMLComprobante_Conceptos_Concepto }

procedure TXMLComprobante_Conceptos_Concepto.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TXMLT_InformacionAduanera);
  RegisterChildNode('CuentaPredial', TXMLComprobante_Conceptos_Concepto_CuentaPredial);
  RegisterChildNode('ComplementoConcepto', TXMLComprobante_Conceptos_Concepto_ComplementoConcepto);
  RegisterChildNode('Parte', TXMLComprobante_Conceptos_Concepto_Parte);
  FInformacionAduanera := CreateCollection(TXMLT_InformacionAduaneraList, IComprobanteFiscalV32_InformacionAduanera, 'InformacionAduanera') as IComprobanteFiscalV32_InformacionAduaneraList;
  FParte := CreateCollection(TXMLComprobante_Conceptos_Concepto_ParteList, IComprobanteFiscalV32_Conceptos_Concepto_Parte, 'Parte') as IComprobanteFiscalV32_Conceptos_Concepto_ParteList;
  inherited;
end;

function TXMLComprobante_Conceptos_Concepto.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('cantidad', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('unidad', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('descripcion', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('importe', Value);
end;

function TXMLComprobante_Conceptos_Concepto.Get_InformacionAduanera: IComprobanteFiscalV32_InformacionAduaneraList;
begin
  Result := FInformacionAduanera;
end;

function TXMLComprobante_Conceptos_Concepto.Get_CuentaPredial: IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial;
begin
  Result := ChildNodes['CuentaPredial'] as IComprobanteFiscalV32_Conceptos_Concepto_CuentaPredial;
end;

function TXMLComprobante_Conceptos_Concepto.Get_ComplementoConcepto: IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto;
begin
  Result := ChildNodes['ComplementoConcepto'] as IComprobanteFiscalV32_Conceptos_Concepto_ComplementoConcepto;
end;

function TXMLComprobante_Conceptos_Concepto.Get_Parte: IComprobanteFiscalV32_Conceptos_Concepto_ParteList;
begin
  Result := FParte;
end;

{ TXMLT_InformacionAduanera }

function TXMLT_InformacionAduanera.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TXMLT_InformacionAduanera.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('numero', Value);
end;

function TXMLT_InformacionAduanera.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['fecha'].Text;
end;

procedure TXMLT_InformacionAduanera.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('fecha', Value);
end;

function TXMLT_InformacionAduanera.Get_Aduana: UnicodeString;
begin
  Result := AttributeNodes['aduana'].Text;
end;

procedure TXMLT_InformacionAduanera.Set_Aduana(Value: UnicodeString);
begin
  SetAttribute('aduana', Value);
end;

{ TXMLT_InformacionAduaneraList }

function TXMLT_InformacionAduaneraList.Add: IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_InformacionAduanera;
end;

function TXMLT_InformacionAduaneraList.Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_InformacionAduanera;
end;

function TXMLT_InformacionAduaneraList.Get_Item(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV32_InformacionAduanera;
end;

{ TXMLComprobante_Conceptos_Concepto_CuentaPredial }

function TXMLComprobante_Conceptos_Concepto_CuentaPredial.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['numero'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_CuentaPredial.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('numero', Value);
end;

{ TXMLComprobante_Conceptos_Concepto_ComplementoConcepto }

{ TXMLComprobante_Conceptos_Concepto_Parte }

procedure TXMLComprobante_Conceptos_Concepto_Parte.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TXMLT_InformacionAduanera);
  ItemTag := 'InformacionAduanera';
  ItemInterface := IComprobanteFiscalV32_InformacionAduanera;
  inherited;
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['cantidad'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('cantidad', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['unidad'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('unidad', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['noIdentificacion'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('noIdentificacion', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['descripcion'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('descripcion', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['valorUnitario'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('valorUnitario', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TXMLComprobante_Conceptos_Concepto_Parte.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('importe', Value);
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV32_InformacionAduanera;
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Add: IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_InformacionAduanera;
end;

function TXMLComprobante_Conceptos_Concepto_Parte.Insert(const Index: Integer): IComprobanteFiscalV32_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_InformacionAduanera;
end;

{ TXMLComprobante_Conceptos_Concepto_ParteList }

function TXMLComprobante_Conceptos_Concepto_ParteList.Add: IComprobanteFiscalV32_Conceptos_Concepto_Parte;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_Conceptos_Concepto_Parte;
end;

function TXMLComprobante_Conceptos_Concepto_ParteList.Insert(const Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_Conceptos_Concepto_Parte;
end;

function TXMLComprobante_Conceptos_Concepto_ParteList.Get_Item(Index: Integer): IComprobanteFiscalV32_Conceptos_Concepto_Parte;
begin
  Result := List[Index] as IComprobanteFiscalV32_Conceptos_Concepto_Parte;
end;

{ TXMLComprobante_Impuestos }

procedure TXMLComprobante_Impuestos.AfterConstruction;
begin
  RegisterChildNode('Retenciones', TXMLComprobante_Impuestos_Retenciones);
  RegisterChildNode('Traslados', TXMLComprobante_Impuestos_Traslados);
  inherited;
end;

function TXMLComprobante_Impuestos.Get_TotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['totalImpuestosRetenidos'].Text;
end;

procedure TXMLComprobante_Impuestos.Set_TotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('totalImpuestosRetenidos', Value);
end;

function TXMLComprobante_Impuestos.Get_TotalImpuestosTrasladados: UnicodeString;
begin
  Result := AttributeNodes['totalImpuestosTrasladados'].Text;
end;

procedure TXMLComprobante_Impuestos.Set_TotalImpuestosTrasladados(Value: UnicodeString);
begin
  SetAttribute('totalImpuestosTrasladados', Value);
end;

function TXMLComprobante_Impuestos.Get_Retenciones: IComprobanteFiscalV32_Impuestos_Retenciones;
begin
  Result := ChildNodes['Retenciones'] as IComprobanteFiscalV32_Impuestos_Retenciones;
end;

function TXMLComprobante_Impuestos.Get_Traslados: IComprobanteFiscalV32_Impuestos_Traslados;
begin
  Result := ChildNodes['Traslados'] as IComprobanteFiscalV32_Impuestos_Traslados;
end;

{ TXMLComprobante_Impuestos_Retenciones }

procedure TXMLComprobante_Impuestos_Retenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TXMLComprobante_Impuestos_Retenciones_Retencion);
  ItemTag := 'Retencion';
  ItemInterface := IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
  inherited;
end;

function TXMLComprobante_Impuestos_Retenciones.Get_Retencion(Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
begin
  Result := List[Index] as IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
end;

function TXMLComprobante_Impuestos_Retenciones.Add: IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
end;

function TXMLComprobante_Impuestos_Retenciones.Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_Impuestos_Retenciones_Retencion;
end;

{ TXMLComprobante_Impuestos_Retenciones_Retencion }

function TXMLComprobante_Impuestos_Retenciones_Retencion.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TXMLComprobante_Impuestos_Retenciones_Retencion.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('impuesto', Value);
end;

function TXMLComprobante_Impuestos_Retenciones_Retencion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TXMLComprobante_Impuestos_Retenciones_Retencion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('importe', Value);
end;

{ TXMLComprobante_Impuestos_Traslados }

procedure TXMLComprobante_Impuestos_Traslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TXMLComprobante_Impuestos_Traslados_Traslado);
  ItemTag := 'Traslado';
  ItemInterface := IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
  inherited;
end;

function TXMLComprobante_Impuestos_Traslados.Get_Traslado(Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
begin
  Result := List[Index] as IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
end;

function TXMLComprobante_Impuestos_Traslados.Add: IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
end;

function TXMLComprobante_Impuestos_Traslados.Insert(const Index: Integer): IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV32_Impuestos_Traslados_Traslado;
end;

{ TXMLComprobante_Impuestos_Traslados_Traslado }

function TXMLComprobante_Impuestos_Traslados_Traslado.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['impuesto'].Text;
end;

procedure TXMLComprobante_Impuestos_Traslados_Traslado.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('impuesto', Value);
end;

function TXMLComprobante_Impuestos_Traslados_Traslado.Get_Tasa: UnicodeString;
begin
  Result := AttributeNodes['tasa'].Text;
end;

procedure TXMLComprobante_Impuestos_Traslados_Traslado.Set_Tasa(Value: UnicodeString);
begin
  SetAttribute('tasa', Value);
end;

function TXMLComprobante_Impuestos_Traslados_Traslado.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['importe'].Text;
end;

procedure TXMLComprobante_Impuestos_Traslados_Traslado.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('importe', Value);
end;

{ TXMLComprobante_Complemento }

{ TXMLComprobante_Addenda }

end.