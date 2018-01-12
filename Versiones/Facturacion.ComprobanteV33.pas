
{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}
{Generated from: http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd   }


unit Facturacion.ComprobanteV33;

interface

uses xmldom, XMLDoc, XMLIntf,
     Facturacion.Comprobante,
     Facturacion.TimbreFiscalDigitalV33;

type

{ Forward Decls }

  IComprobanteFiscalV33 = interface;
  IComprobanteFiscalV33_CfdiRelacionados = interface;
  IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado = interface;
  IComprobanteFiscalV33_Emisor = interface;
  IComprobanteFiscalV33_Receptor = interface;
  IComprobanteFiscalV33_Conceptos = interface;
  IComprobanteFiscalV33_Conceptos_Concepto = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Parte = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_ParteList = interface;
  IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera = interface;
  IComprobanteFiscalV33_Impuestos = interface;
  IComprobanteFiscalV33_Impuestos_Retenciones = interface;
  IComprobanteFiscalV33_Impuestos_Retenciones_Retencion = interface;
  IComprobanteFiscalV33_Impuestos_Traslados = interface;
  IComprobanteFiscalV33_Impuestos_Traslados_Traslado = interface;
  IComprobanteFiscalV33_Complemento = interface;
  IComprobanteFiscalV33_Addenda = interface;

{ IComprobanteFiscalV33 }

  IComprobanteFiscalV33 = interface(IComprobanteFiscal)
    ['{24F52F1E-99CE-461A-A59D-B32405C24BF6}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Sello: UnicodeString;
    function Get_FormaPago: UnicodeString;
    function Get_NoCertificado: UnicodeString;
    function Get_Certificado: UnicodeString;
    function Get_CondicionesDePago: UnicodeString;
    function Get_SubTotal: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_Moneda: UnicodeString;
    function Get_TipoCambio: UnicodeString;
    function Get_Total: UnicodeString;
    function Get_TipoDeComprobante: UnicodeString;
    function Get_MetodoPago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_Confirmacion: UnicodeString;
    function Get_CfdiRelacionados: IComprobanteFiscalV33_CfdiRelacionados;
    function Get_Emisor: IComprobanteFiscalV33_Emisor;
    function Get_Receptor: IComprobanteFiscalV33_Receptor;
    function Get_Conceptos: IComprobanteFiscalV33_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV33_Impuestos;
    function Get_Complemento: IComprobanteFiscalV33_Complemento;
    function Get_Addenda: IComprobanteFiscalV33_Addenda;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Sello(Value: UnicodeString);
    procedure Set_FormaPago(Value: UnicodeString);
    procedure Set_NoCertificado(Value: UnicodeString);
    procedure Set_Certificado(Value: UnicodeString);
    procedure Set_CondicionesDePago(Value: UnicodeString);
    procedure Set_SubTotal(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_Moneda(Value: UnicodeString);
    procedure Set_TipoCambio(Value: UnicodeString);
    procedure Set_Total(Value: UnicodeString);
    procedure Set_TipoDeComprobante(Value: UnicodeString);
    procedure Set_MetodoPago(Value: UnicodeString);
    procedure Set_LugarExpedicion(Value: UnicodeString);
    procedure Set_Confirmacion(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property Serie: UnicodeString read Get_Serie write Set_Serie;
    property Folio: UnicodeString read Get_Folio write Set_Folio;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property Sello: UnicodeString read Get_Sello write Set_Sello;
    property FormaPago: UnicodeString read Get_FormaPago write Set_FormaPago;
    property NoCertificado: UnicodeString read Get_NoCertificado write Set_NoCertificado;
    property Certificado: UnicodeString read Get_Certificado write Set_Certificado;
    property CondicionesDePago: UnicodeString read Get_CondicionesDePago write Set_CondicionesDePago;
    property SubTotal: UnicodeString read Get_SubTotal write Set_SubTotal;
    property Descuento: UnicodeString read Get_Descuento write Set_Descuento;
    property Moneda: UnicodeString read Get_Moneda write Set_Moneda;
    property TipoCambio: UnicodeString read Get_TipoCambio write Set_TipoCambio;
    property Total: UnicodeString read Get_Total write Set_Total;
    property TipoDeComprobante: UnicodeString read Get_TipoDeComprobante write Set_TipoDeComprobante;
    property MetodoPago: UnicodeString read Get_MetodoPago write Set_MetodoPago;
    property LugarExpedicion: UnicodeString read Get_LugarExpedicion write Set_LugarExpedicion;
    property Confirmacion: UnicodeString read Get_Confirmacion write Set_Confirmacion;
    property CfdiRelacionados: IComprobanteFiscalV33_CfdiRelacionados read Get_CfdiRelacionados;
    property Emisor: IComprobanteFiscalV33_Emisor read Get_Emisor;
    property Receptor: IComprobanteFiscalV33_Receptor read Get_Receptor;
    property Conceptos: IComprobanteFiscalV33_Conceptos read Get_Conceptos;
    property Impuestos: IComprobanteFiscalV33_Impuestos read Get_Impuestos;
    property Complemento: IComprobanteFiscalV33_Complemento read Get_Complemento;
    property Addenda: IComprobanteFiscalV33_Addenda read Get_Addenda;
  end;

{ IComprobanteFiscalV33_CfdiRelacionados }

  IComprobanteFiscalV33_CfdiRelacionados = interface(IXMLNodeCollection)
    ['{6AAF9F3F-5DE9-4123-ABBB-A26242F408CF}']
    { Property Accessors }
    function Get_TipoRelacion: UnicodeString;
    function Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
    procedure Set_TipoRelacion(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
    property TipoRelacion: UnicodeString read Get_TipoRelacion write Set_TipoRelacion;
    property CfdiRelacionado[Index: Integer]: IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado read Get_CfdiRelacionado; default;
  end;

{ IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado }

  IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado = interface(IXMLNode)
    ['{01AA9D73-217D-4009-8AE7-206BEFF81F43}']
    { Property Accessors }
    function Get_UUID: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
    { Methods & Properties }
    property UUID: UnicodeString read Get_UUID write Set_UUID;
  end;

{ IComprobanteFiscalV33_Emisor }

  IComprobanteFiscalV33_Emisor = interface(IXMLNode)
    ['{98EB4F0A-436A-4035-9F7C-28C56B8DC91B}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_RegimenFiscal: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_RegimenFiscal(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property RegimenFiscal: UnicodeString read Get_RegimenFiscal write Set_RegimenFiscal;
  end;

{ IComprobanteFiscalV33_Receptor }

  IComprobanteFiscalV33_Receptor = interface(IXMLNode)
    ['{681F1AAB-9A43-467D-B1C7-2C29A4F17773}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    function Get_NumRegIdTrib: UnicodeString;
    function Get_UsoCFDI: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_UsoCFDI(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property ResidenciaFiscal: UnicodeString read Get_ResidenciaFiscal write Set_ResidenciaFiscal;
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property UsoCFDI: UnicodeString read Get_UsoCFDI write Set_UsoCFDI;
  end;

{ IComprobanteFiscalV33_Conceptos }

  IComprobanteFiscalV33_Conceptos = interface(IXMLNodeCollection)
    ['{BEBDD7D7-DB4C-455B-8B91-AF68CBD84992}']
    { Property Accessors }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
    property Concepto[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto read Get_Concepto; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto }

  IComprobanteFiscalV33_Conceptos_Concepto = interface(IXMLNode)
    ['{302E5E03-4F86-4155-9C56-6FC3794D0360}']
    { Property Accessors }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_ClaveUnidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_Impuestos: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos;
    function Get_InformacionAduanera: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial;
    function Get_ComplementoConcepto: IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV33_Conceptos_Concepto_ParteList;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_ClaveUnidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    { Methods & Properties }
    property ClaveProdServ: UnicodeString read Get_ClaveProdServ write Set_ClaveProdServ;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property Cantidad: UnicodeString read Get_Cantidad write Set_Cantidad;
    property ClaveUnidad: UnicodeString read Get_ClaveUnidad write Set_ClaveUnidad;
    property Unidad: UnicodeString read Get_Unidad write Set_Unidad;
    property Descripcion: UnicodeString read Get_Descripcion write Set_Descripcion;
    property ValorUnitario: UnicodeString read Get_ValorUnitario write Set_ValorUnitario;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property Descuento: UnicodeString read Get_Descuento write Set_Descuento;
    property Impuestos: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos read Get_Impuestos;
    property InformacionAduanera: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList read Get_InformacionAduanera;
    property CuentaPredial: IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial read Get_CuentaPredial;
    property ComplementoConcepto: IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto read Get_ComplementoConcepto;
    property Parte: IComprobanteFiscalV33_Conceptos_Concepto_ParteList read Get_Parte;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Impuestos }

  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos = interface(IXMLNode)
    ['{EE945828-0FC0-4106-BF0F-7955E1AD8869}']
    { Property Accessors }
    function Get_Traslados: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados;
    function Get_Retenciones: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones;
    { Methods & Properties }
    property Traslados: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados read Get_Traslados;
    property Retenciones: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones read Get_Retenciones;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados }

  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados = interface(IXMLNodeCollection)
    ['{7457294A-FBBB-44B0-B6D5-498991707052}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    property Traslado[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado read Get_Traslado; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado }

  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado = interface(IXMLNode)
    ['{F85FD2A5-8E45-43AF-9BFC-DB8F2654E0C2}']
    { Property Accessors }
    function Get_Base: UnicodeString;
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Base(Value: UnicodeString);
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Base: UnicodeString read Get_Base write Set_Base;
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property TipoFactor: UnicodeString read Get_TipoFactor write Set_TipoFactor;
    property TasaOCuota: UnicodeString read Get_TasaOCuota write Set_TasaOCuota;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones }

  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones = interface(IXMLNodeCollection)
    ['{6B66D8D1-1ACE-4249-8847-449655F2C0D4}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    property Retencion[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion read Get_Retencion; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

  IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion = interface(IXMLNode)
    ['{9BA02BF3-4681-451F-9868-E27DDB4397BF}']
    { Property Accessors }
    function Get_Base: UnicodeString;
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Base(Value: UnicodeString);
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Base: UnicodeString read Get_Base write Set_Base;
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property TipoFactor: UnicodeString read Get_TipoFactor write Set_TipoFactor;
    property TasaOCuota: UnicodeString read Get_TasaOCuota write Set_TasaOCuota;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera }

  IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera = interface(IXMLNode)
    ['{7DA76D6C-7982-4716-95C1-7BD0E26A2705}']
    { Property Accessors }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    function Get_Fecha: UnicodeString;
    procedure Set_Fecha(Value: UnicodeString);
    function Get_Aduana: UnicodeString;
    procedure Set_Aduana(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property Aduana: UnicodeString read Get_Aduana write Set_Aduana;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList }

  IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList = interface(IXMLNodeCollection)
    ['{B9509127-57E4-43DF-903D-B1CC7F086877}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
    property Items[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera read Get_Item; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial }

  IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial = interface(IXMLNode)
    ['{34A8DAF5-BCD1-4195-BC58-3DE78590B08D}']
    { Property Accessors }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto }

  IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto = interface(IXMLNode)
    ['{CCB001E8-538D-43CE-863E-24133690B05D}']
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Parte }

  IComprobanteFiscalV33_Conceptos_Concepto_Parte = interface(IXMLNodeCollection)
    ['{FB9EFF24-714B-4E50-B1BD-7B59D3B47225}']
    { Property Accessors }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
    property ClaveProdServ: UnicodeString read Get_ClaveProdServ write Set_ClaveProdServ;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property Cantidad: UnicodeString read Get_Cantidad write Set_Cantidad;
    property Unidad: UnicodeString read Get_Unidad write Set_Unidad;
    property Descripcion: UnicodeString read Get_Descripcion write Set_Descripcion;
    property ValorUnitario: UnicodeString read Get_ValorUnitario write Set_ValorUnitario;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property InformacionAduanera[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera read Get_InformacionAduanera; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_ParteList }

  IComprobanteFiscalV33_Conceptos_Concepto_ParteList = interface(IXMLNodeCollection)
    ['{8CA3D63F-CD56-463E-AE38-CF7B892117FA}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;
    property Items[Index: Integer]: IComprobanteFiscalV33_Conceptos_Concepto_Parte read Get_Item; default;
  end;

{ IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera }

  IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera = interface(IXMLNode)
    ['{E5B59B2E-DAF2-4FE0-97FB-79BB357906E6}']
    { Property Accessors }
    { Property Accessors }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
  end;

{ IComprobanteFiscalV33_Impuestos }

  IComprobanteFiscalV33_Impuestos = interface(IXMLNode)
    ['{AFCF635C-4FD9-4577-9DED-8199052B8A52}']
    { Property Accessors }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV33_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV33_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: UnicodeString read Get_TotalImpuestosRetenidos write Set_TotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: UnicodeString read Get_TotalImpuestosTrasladados write Set_TotalImpuestosTrasladados;
    property Retenciones: IComprobanteFiscalV33_Impuestos_Retenciones read Get_Retenciones;
    property Traslados: IComprobanteFiscalV33_Impuestos_Traslados read Get_Traslados;
  end;

{ IComprobanteFiscalV33_Impuestos_Retenciones }

  IComprobanteFiscalV33_Impuestos_Retenciones = interface(IXMLNodeCollection)
    ['{65D1662C-9294-42EA-994E-078566A5EDC4}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
    property Retencion[Index: Integer]: IComprobanteFiscalV33_Impuestos_Retenciones_Retencion read Get_Retencion; default;
  end;

{ IComprobanteFiscalV33_Impuestos_Retenciones_Retencion }

  IComprobanteFiscalV33_Impuestos_Retenciones_Retencion = interface(IXMLNode)
    ['{3328F812-DC7C-4A05-83D3-AA7E11FDC987}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV33_Impuestos_Traslados }

  IComprobanteFiscalV33_Impuestos_Traslados = interface(IXMLNodeCollection)
    ['{CB86DAEA-C75F-4589-8D35-5A9169682EE0}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
    { Methods & Properties }
    function Add: IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
    property Traslado[Index: Integer]: IComprobanteFiscalV33_Impuestos_Traslados_Traslado read Get_Traslado; default;
  end;

{ IComprobanteFiscalV33_Impuestos_Traslados_Traslado }

  IComprobanteFiscalV33_Impuestos_Traslados_Traslado = interface(IXMLNode)
    ['{2B408635-51AE-494F-9661-408A57A815EC}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property TipoFactor: UnicodeString read Get_TipoFactor write Set_TipoFactor;
    property TasaOCuota: UnicodeString read Get_TasaOCuota write Set_TasaOCuota;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV33_Complemento }

  IComprobanteFiscalV33_Complemento = interface(IXMLNode)
    ['{7C11F42B-1408-4597-A5B1-2F763F8DB7C6}']
    function GetTimbreFiscalDigital: ITimbreFiscalDigitalV33;
    procedure SetTimbreFiscalDigital(const Value: ITimbreFiscalDigitalV33);
    property TimbreFiscalDigital: ITimbreFiscalDigitalV33 read GetTimbreFiscalDigital write SetTimbreFiscalDigital;
  end;

{ IComprobanteFiscalV33_Addenda }

  IComprobanteFiscalV33_Addenda = interface(IXMLNode)
    ['{14C4F8BE-F790-4373-AAF1-A8092D5024CF}']
  end;

{ Forward Decls }

  TComprobanteFiscalV33 = class;
  TComprobanteFiscalV33_CfdiRelacionados = class;
  TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado = class;
  TComprobanteFiscalV33_Emisor = class;
  TComprobanteFiscalV33_Receptor = class;
  TComprobanteFiscalV33_Conceptos = class;
  TComprobanteFiscalV33_Conceptos_Concepto = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion = class;
  TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera = class;
  TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList = class;
  TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial = class;
  TComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Parte = class;
  TComprobanteFiscalV33_Conceptos_Concepto_ParteList = class;
  TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera = class;
  TComprobanteFiscalV33_Impuestos = class;
  TComprobanteFiscalV33_Impuestos_Retenciones = class;
  TComprobanteFiscalV33_Impuestos_Retenciones_Retencion = class;
  TComprobanteFiscalV33_Impuestos_Traslados = class;
  TComprobanteFiscalV33_Impuestos_Traslados_Traslado = class;
  TComprobanteFiscalV33_Complemento = class;
  TComprobanteFiscalV33_Addenda = class;

{ TComprobanteFiscalV33 }

  TComprobanteFiscalV33 = class(TXMLNode, IComprobanteFiscalV33)
  protected
    { IComprobanteFiscalV33 }
    function Get_Version: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Sello: UnicodeString;
    function Get_FormaPago: UnicodeString;
    function Get_NoCertificado: UnicodeString;
    function Get_Certificado: UnicodeString;
    function Get_CondicionesDePago: UnicodeString;
    function Get_SubTotal: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_Moneda: UnicodeString;
    function Get_TipoCambio: UnicodeString;
    function Get_Total: UnicodeString;
    function Get_TipoDeComprobante: UnicodeString;
    function Get_MetodoPago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_Confirmacion: UnicodeString;
    function Get_CfdiRelacionados: IComprobanteFiscalV33_CfdiRelacionados;
    function Get_Emisor: IComprobanteFiscalV33_Emisor;
    function Get_Receptor: IComprobanteFiscalV33_Receptor;
    function Get_Conceptos: IComprobanteFiscalV33_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV33_Impuestos;
    function Get_Complemento: IComprobanteFiscalV33_Complemento;
    function Get_Addenda: IComprobanteFiscalV33_Addenda;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_Sello(Value: UnicodeString);
    procedure Set_FormaPago(Value: UnicodeString);
    procedure Set_NoCertificado(Value: UnicodeString);
    procedure Set_Certificado(Value: UnicodeString);
    procedure Set_CondicionesDePago(Value: UnicodeString);
    procedure Set_SubTotal(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_Moneda(Value: UnicodeString);
    procedure Set_TipoCambio(Value: UnicodeString);
    procedure Set_Total(Value: UnicodeString);
    procedure Set_TipoDeComprobante(Value: UnicodeString);
    procedure Set_MetodoPago(Value: UnicodeString);
    procedure Set_LugarExpedicion(Value: UnicodeString);
    procedure Set_Confirmacion(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
    procedure AsignarTimbreFiscal(const aXMLTimbre: TCadenaUTF8);
    procedure AgregarComplemento(aNodoAAgregar: IXMLNode; const aNameSpacePrefijo :
        String; const aNameSpaceURI: String; const aAnexarSchema: String);
  end;

{ TComprobanteFiscalV33_CfdiRelacionados }

  TComprobanteFiscalV33_CfdiRelacionados = class(TXMLNodeCollection, IComprobanteFiscalV33_CfdiRelacionados)
  protected
    { IComprobanteFiscalV33_CfdiRelacionados }
    function Get_TipoRelacion: UnicodeString;
    function Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
    procedure Set_TipoRelacion(Value: UnicodeString);
    function Add: IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado }

  TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado = class(TXMLNode, IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado)
  protected
    { IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado }
    function Get_UUID: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Emisor }

  TComprobanteFiscalV33_Emisor = class(TXMLNode, IComprobanteFiscalV33_Emisor)
  protected
    { IComprobanteFiscalV33_Emisor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_RegimenFiscal: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_RegimenFiscal(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Receptor }

  TComprobanteFiscalV33_Receptor = class(TXMLNode, IComprobanteFiscalV33_Receptor)
  protected
    { IComprobanteFiscalV33_Receptor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    function Get_NumRegIdTrib: UnicodeString;
    function Get_UsoCFDI: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_UsoCFDI(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Conceptos }

  TComprobanteFiscalV33_Conceptos = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos)
  protected
    { IComprobanteFiscalV33_Conceptos }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
    function Add: IComprobanteFiscalV33_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto }

  TComprobanteFiscalV33_Conceptos_Concepto = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto)
  private
    FInformacionAduanera: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList;
    FParte: IComprobanteFiscalV33_Conceptos_Concepto_ParteList;
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_ClaveUnidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_Impuestos: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos;
    function Get_InformacionAduanera: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial;
    function Get_ComplementoConcepto: IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV33_Conceptos_Concepto_ParteList;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_ClaveUnidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos }

  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_Impuestos)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Impuestos }
    function Get_Traslados: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados;
    function Get_Retenciones: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados }

  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado }

  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado }
    function Get_Base: UnicodeString;
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Base(Value: UnicodeString);
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones }

  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

  TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion }
    function Get_Base: UnicodeString;
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Base(Value: UnicodeString);
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera }

  TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    function Get_Fecha: UnicodeString;
    procedure Set_Fecha(Value: UnicodeString);
    function Get_Aduana: UnicodeString;
    procedure Set_Aduana(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList }

  TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial }

  TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto }

  TComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto }
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Parte }

  TComprobanteFiscalV33_Conceptos_Concepto_Parte = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos_Concepto_Parte)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Parte }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_ParteList }

  TComprobanteFiscalV33_Conceptos_Concepto_ParteList = class(TXMLNodeCollection, IComprobanteFiscalV33_Conceptos_Concepto_ParteList)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_ParteList }
    function Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;
  end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera }

  TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera = class(TXMLNode, IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera)
  protected
    { IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    function Get_Fecha: UnicodeString;
    procedure Set_Fecha(Value: UnicodeString);
    function Get_Aduana: UnicodeString;
    procedure Set_Aduana(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Impuestos }

  TComprobanteFiscalV33_Impuestos = class(TXMLNode, IComprobanteFiscalV33_Impuestos)
  protected
    { IComprobanteFiscalV33_Impuestos }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV33_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV33_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Impuestos_Retenciones }

  TComprobanteFiscalV33_Impuestos_Retenciones = class(TXMLNodeCollection, IComprobanteFiscalV33_Impuestos_Retenciones)
  protected
    { IComprobanteFiscalV33_Impuestos_Retenciones }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
    function Add: IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Impuestos_Retenciones_Retencion }

  TComprobanteFiscalV33_Impuestos_Retenciones_Retencion = class(TXMLNode, IComprobanteFiscalV33_Impuestos_Retenciones_Retencion)
  protected
    { IComprobanteFiscalV33_Impuestos_Retenciones_Retencion }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Impuestos_Traslados }

  TComprobanteFiscalV33_Impuestos_Traslados = class(TXMLNodeCollection, IComprobanteFiscalV33_Impuestos_Traslados)
  protected
    { IComprobanteFiscalV33_Impuestos_Traslados }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
    function Add: IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Impuestos_Traslados_Traslado }

  TComprobanteFiscalV33_Impuestos_Traslados_Traslado = class(TXMLNode, IComprobanteFiscalV33_Impuestos_Traslados_Traslado)
  protected
    { IComprobanteFiscalV33_Impuestos_Traslados_Traslado }
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TComprobanteFiscalV33_Complemento }

  TComprobanteFiscalV33_Complemento = class(TXMLNode, IComprobanteFiscalV33_Complemento)
  private
    function GetTimbreFiscalDigital: ITimbreFiscalDigitalV33;
    procedure SetTimbreFiscalDigital(const Value: ITimbreFiscalDigitalV33);
  protected
    { IComprobanteFiscalV33_Complemento }
  public
    procedure AfterConstruction; override;
  end;

{ TComprobanteFiscalV33_Addenda }

  TComprobanteFiscalV33_Addenda = class(TXMLNode, IComprobanteFiscalV33_Addenda)
  protected
    { IComprobanteFiscalV33_Addenda }
  end;

{ Global Functions }

function GetComprobanteFiscalV33(Doc: IXMLDocument): IComprobanteFiscalV33;
function LoadComprobanteFiscalV33(const FileName: string):
    IComprobanteFiscalV33;
function NewComprobanteFiscalV33: IComprobanteFiscalV33;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/3';

implementation

uses System.SysUtils,
     Facturacion.Helper;

const
  _NODO_XSI     = 'xmlns:xsi';
  _NODO_SL      = 'xsi:schemaLocation';
  _NODO_VERSION = 'Version';

{ Global Functions }

procedure establecerAtributosDeCFDI(comprobante: IComprobanteFiscalV33);
//var
//  documentoBase: IXMLDocument;
begin
  // Agregamos la auto identacion
  comprobante.OwnerDocument.Options := [doNodeAutoCreate, doAttrNull, doAutoPrefix, doNamespaceDecl, doNodeAutoIndent];

  if (comprobante.AttributeNodes.FindNode(_NODO_XSI) = nil) then
      comprobante.SetAttribute(_NODO_XSI,
                               'http://www.w3.org/2001/XMLSchema-instance');

  if (comprobante.AttributeNodes.FindNode(_NODO_SL) = nil) then
    comprobante.SetAttribute(_NODO_SL,
                            'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd');

  if (comprobante.AttributeNodes.FindNode(_NODO_VERSION) = nil) then
    comprobante.Version := '3.3';
end;

procedure TComprobanteFiscalV33.AsignarTimbreFiscal(const aXMLTimbre: TCadenaUTF8);
var
  timbreConXSI, schemaLocation : string;
  documentoXMLTimbre : IXMLDocument;
  nodoTimbre: ITimbreFiscalDigitalV33;
begin
  Assert(aXMLTimbre <> '', 'El XML del timbre no puede estar vacio');
  timbreConXSI := Trim(aXMLTimbre);

  // Si queremos leer el nodo de forma independiente tenemos que anexar la defincion del XSI:
  // xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" para que funcione
  // de lo contrario se lanzará una excepcion de DOM por que el namespace XSI no se encuentra definido
  if AnsiPos('xmlns:xsi', timbreConXSI) = 0 then
  begin
    timbreConXSI := StringReplace(timbreConXSI, 'TimbreFiscalDigital"',
                                                'TimbreFiscalDigital" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',
                                                [rfReplaceAll]);
  end;

  // Creamos el XMLDocument desde el XML del timbre
  documentoXMLTimbre := LoadXMLData(Trim(timbreConXSI));
  nodoTimbre         := GetTimbreFiscalDigitalV33(documentoXMLTimbre);

  // Agregamos el nodo del TimbreFiscalDigital al nodo Complemento del comprobante
  Get_Complemento.ChildNodes.Add(nodoTimbre);

  // Agregamos el XSD del TFD
//  schemaLocation := Self.AttributeNodes.FindNode(_NODO_SL).Text;
//  Self.SetAttribute(_NODO_SL, 'http://www.sat.gob.mx/TimbreFiscalDigital' +
//                             ' http://www.sat.gob.mx/sitio_internet/cfd/timbrefiscaldigital/TimbreFiscalDigitalv11.xsd');
end;

procedure TComprobanteFiscalV33.AgregarComplemento(aNodoAAgregar: IXMLNode;
                                                  const aNameSpacePrefijo : String;
                                                  const aNameSpaceURI: String;
                                                  const aAnexarSchema: String);
var
  copiaLocal : IXMLNode;
  schemaLocation : string;
begin
  Assert(aNodoAAgregar <> nil, 'La instancia aNodoAAgregar no debio ser nula');
  // Para evitar que se libere el nodo parámetro que nos estan proporcionando
  // creamos nuestra propia copia.
  copiaLocal := aNodoAAgregar.CloneNode(True);
  Get_Complemento.ChildNodes.Add(copiaLocal);

  // Anexamos el Namespace del complemento
  Self.DeclareNamespace(aNameSpacePrefijo, aNameSpaceURI);

  // Agregamos el XSD del TFD
  schemaLocation := Self.AttributeNodes.FindNode(_NODO_SL).Text;
  Self.SetAttribute(_NODO_SL,schemaLocation+ ' '+ aAnexarSchema);
  Self.Resync;
end;

function GetComprobanteFiscalV33(Doc: IXMLDocument): IComprobanteFiscalV33;
begin
  Result := Doc.GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV33, TargetNamespace) as IComprobanteFiscalV33;
end;

function LoadComprobanteFiscalV33(const FileName: string):
    IComprobanteFiscalV33;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV33, TargetNamespace) as IComprobanteFiscalV33;
end;

function NewComprobanteFiscalV33: IComprobanteFiscalV33;
begin
  Result := NewXMLDocument.GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV33, TargetNamespace) as IComprobanteFiscalV33;
end;

{ TComprobanteFiscalV33 }

procedure TComprobanteFiscalV33.AfterConstruction;
begin
  RegisterChildNode('CfdiRelacionados', TComprobanteFiscalV33_CfdiRelacionados);
  RegisterChildNode('Emisor', TComprobanteFiscalV33_Emisor);
  RegisterChildNode('Receptor', TComprobanteFiscalV33_Receptor);
  RegisterChildNode('Conceptos', TComprobanteFiscalV33_Conceptos);
  RegisterChildNode('Impuestos', TComprobanteFiscalV33_Impuestos);
  RegisterChildNode('Complemento', TComprobanteFiscalV33_Complemento);
  RegisterChildNode('Addenda', TComprobanteFiscalV33_Addenda);

  establecerAtributosDeCFDI(Self);

  inherited;
end;

function TComprobanteFiscalV33.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TComprobanteFiscalV33.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TComprobanteFiscalV33.Get_Serie: UnicodeString;
begin
  Result := AttributeNodes['Serie'].Text;
end;

procedure TComprobanteFiscalV33.Set_Serie(Value: UnicodeString);
begin
  SetAttribute('Serie', Value);
end;

function TComprobanteFiscalV33.Get_Folio: UnicodeString;
begin
  Result := AttributeNodes['Folio'].Text;
end;

procedure TComprobanteFiscalV33.Set_Folio(Value: UnicodeString);
begin
  SetAttribute('Folio', Value);
end;

function TComprobanteFiscalV33.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TComprobanteFiscalV33.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('Fecha', Value);
end;

function TComprobanteFiscalV33.Get_Sello: UnicodeString;
begin
  Result := AttributeNodes['Sello'].Text;
end;

procedure TComprobanteFiscalV33.Set_Sello(Value: UnicodeString);
begin
  SetAttribute('Sello', Value);
end;

function TComprobanteFiscalV33.Get_FormaPago: UnicodeString;
begin
  Result := AttributeNodes['FormaPago'].Text;
end;

procedure TComprobanteFiscalV33.Set_FormaPago(Value: UnicodeString);
begin
  SetAttribute('FormaPago', Value);
end;

function TComprobanteFiscalV33.Get_NoCertificado: UnicodeString;
begin
  Result := AttributeNodes['NoCertificado'].Text;
end;

procedure TComprobanteFiscalV33.Set_NoCertificado(Value: UnicodeString);
begin
  SetAttribute('NoCertificado', Value);
end;

function TComprobanteFiscalV33.Get_Certificado: UnicodeString;
begin
  Result := AttributeNodes['Certificado'].Text;
end;

procedure TComprobanteFiscalV33.Set_Certificado(Value: UnicodeString);
begin
  SetAttribute('Certificado', Value);
end;

function TComprobanteFiscalV33.Get_CondicionesDePago: UnicodeString;
begin
  Result := AttributeNodes['CondicionesDePago'].Text;
end;

procedure TComprobanteFiscalV33.Set_CondicionesDePago(Value: UnicodeString);
begin
  SetAttribute('CondicionesDePago', Value);
end;

function TComprobanteFiscalV33.Get_SubTotal: UnicodeString;
begin
  Result := AttributeNodes['SubTotal'].Text;
end;

procedure TComprobanteFiscalV33.Set_SubTotal(Value: UnicodeString);
begin
  SetAttribute('SubTotal', Value);
end;

function TComprobanteFiscalV33.Get_Descuento: UnicodeString;
begin
  Result := AttributeNodes['Descuento'].Text;
end;

procedure TComprobanteFiscalV33.Set_Descuento(Value: UnicodeString);
begin
  SetAttribute('Descuento', Value);
end;

function TComprobanteFiscalV33.Get_Moneda: UnicodeString;
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TComprobanteFiscalV33.Set_Moneda(Value: UnicodeString);
begin
  SetAttribute('Moneda', Value);
end;

function TComprobanteFiscalV33.Get_TipoCambio: UnicodeString;
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TComprobanteFiscalV33.Set_TipoCambio(Value: UnicodeString);
begin
  SetAttribute('TipoCambio', Value);
end;

function TComprobanteFiscalV33.Get_Total: UnicodeString;
begin
  Result := AttributeNodes['Total'].Text;
end;

procedure TComprobanteFiscalV33.Set_Total(Value: UnicodeString);
begin
  SetAttribute('Total', Value);
end;

function TComprobanteFiscalV33.Get_TipoDeComprobante: UnicodeString;
begin
  Result := AttributeNodes['TipoDeComprobante'].Text;
end;

procedure TComprobanteFiscalV33.Set_TipoDeComprobante(Value: UnicodeString);
begin
  SetAttribute('TipoDeComprobante', Value);
end;

function TComprobanteFiscalV33.Get_MetodoPago: UnicodeString;
begin
  Result := AttributeNodes['MetodoPago'].Text;
end;

procedure TComprobanteFiscalV33.Set_MetodoPago(Value: UnicodeString);
begin
  SetAttribute('MetodoPago', Value);
end;

function TComprobanteFiscalV33.Get_LugarExpedicion: UnicodeString;
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TComprobanteFiscalV33.Set_LugarExpedicion(Value: UnicodeString);
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TComprobanteFiscalV33.Get_Confirmacion: UnicodeString;
begin
  Result := AttributeNodes['Confirmacion'].Text;
end;

procedure TComprobanteFiscalV33.Set_Confirmacion(Value: UnicodeString);
begin
  SetAttribute('Confirmacion', Value);
end;

function TComprobanteFiscalV33.Get_CfdiRelacionados: IComprobanteFiscalV33_CfdiRelacionados;
begin
  Result := ChildNodes['CfdiRelacionados'] as IComprobanteFiscalV33_CfdiRelacionados;
end;

function TComprobanteFiscalV33.Get_Emisor: IComprobanteFiscalV33_Emisor;
begin
  Result := ChildNodes['Emisor'] as IComprobanteFiscalV33_Emisor;
end;

function TComprobanteFiscalV33.Get_Receptor: IComprobanteFiscalV33_Receptor;
begin
  Result := ChildNodes['Receptor'] as IComprobanteFiscalV33_Receptor;
end;

function TComprobanteFiscalV33.Get_Conceptos: IComprobanteFiscalV33_Conceptos;
begin
  Result := ChildNodes['Conceptos'] as IComprobanteFiscalV33_Conceptos;
end;

function TComprobanteFiscalV33.Get_Impuestos: IComprobanteFiscalV33_Impuestos;
begin
  Result := ChildNodes['Impuestos'] as IComprobanteFiscalV33_Impuestos;
end;

function TComprobanteFiscalV33.Get_Complemento: IComprobanteFiscalV33_Complemento;
begin
  Result := ChildNodes['Complemento'] as IComprobanteFiscalV33_Complemento;
end;

function TComprobanteFiscalV33.Get_Addenda: IComprobanteFiscalV33_Addenda;
begin
  Result := ChildNodes['Addenda'] as IComprobanteFiscalV33_Addenda;
end;

{ TComprobanteFiscalV33_CfdiRelacionados }

procedure TComprobanteFiscalV33_CfdiRelacionados.AfterConstruction;
begin
  RegisterChildNode('CfdiRelacionado', TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado);
  ItemTag := 'cfdi:CfdiRelacionado';
  ItemInterface := IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
  inherited;
end;

function TComprobanteFiscalV33_CfdiRelacionados.Get_TipoRelacion: UnicodeString;
begin
  Result := AttributeNodes['TipoRelacion'].Text;
end;

procedure TComprobanteFiscalV33_CfdiRelacionados.Set_TipoRelacion(Value: UnicodeString);
begin
  SetAttribute('TipoRelacion', Value);
end;

function TComprobanteFiscalV33_CfdiRelacionados.Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
begin
  Result := List[Index] as IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
end;

function TComprobanteFiscalV33_CfdiRelacionados.Add: IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
end;

function TComprobanteFiscalV33_CfdiRelacionados.Insert(const Index: Integer): IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado;
end;

{ TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado }

function TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TComprobanteFiscalV33_CfdiRelacionados_CfdiRelacionado.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

{ TComprobanteFiscalV33_Emisor }

function TComprobanteFiscalV33_Emisor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['Rfc'].Text;
end;

procedure TComprobanteFiscalV33_Emisor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('Rfc', Value);
end;

function TComprobanteFiscalV33_Emisor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TComprobanteFiscalV33_Emisor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TComprobanteFiscalV33_Emisor.Get_RegimenFiscal: UnicodeString;
begin
  Result := AttributeNodes['RegimenFiscal'].Text;
end;

procedure TComprobanteFiscalV33_Emisor.Set_RegimenFiscal(Value: UnicodeString);
begin
  SetAttribute('RegimenFiscal', Value);
end;

{ TComprobanteFiscalV33_Receptor }

function TComprobanteFiscalV33_Receptor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['Rfc'].Text;
end;

procedure TComprobanteFiscalV33_Receptor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('Rfc', Value);
end;

function TComprobanteFiscalV33_Receptor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TComprobanteFiscalV33_Receptor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TComprobanteFiscalV33_Receptor.Get_ResidenciaFiscal: UnicodeString;
begin
  Result := AttributeNodes['ResidenciaFiscal'].Text;
end;

procedure TComprobanteFiscalV33_Receptor.Set_ResidenciaFiscal(Value: UnicodeString);
begin
  SetAttribute('ResidenciaFiscal', Value);
end;

function TComprobanteFiscalV33_Receptor.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComprobanteFiscalV33_Receptor.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComprobanteFiscalV33_Receptor.Get_UsoCFDI: UnicodeString;
begin
  Result := AttributeNodes['UsoCFDI'].Text;
end;

procedure TComprobanteFiscalV33_Receptor.Set_UsoCFDI(Value: UnicodeString);
begin
  SetAttribute('UsoCFDI', Value);
end;

{ TComprobanteFiscalV33_Conceptos }

procedure TComprobanteFiscalV33_Conceptos.AfterConstruction;
begin
  RegisterChildNode('Concepto', TComprobanteFiscalV33_Conceptos_Concepto);
  ItemTag := 'cfdi:Concepto';
  ItemInterface := IComprobanteFiscalV33_Conceptos_Concepto;
  inherited;
end;

function TComprobanteFiscalV33_Conceptos.Get_Concepto(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto;
end;

function TComprobanteFiscalV33_Conceptos.Add: IComprobanteFiscalV33_Conceptos_Concepto;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto;
end;

function TComprobanteFiscalV33_Conceptos.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto }

procedure TComprobanteFiscalV33_Conceptos_Concepto.AfterConstruction;
begin
  RegisterChildNode('Impuestos', TComprobanteFiscalV33_Conceptos_Concepto_Impuestos);
  RegisterChildNode('InformacionAduanera', TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera);
  RegisterChildNode('CuentaPredial', TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial);
  RegisterChildNode('ComplementoConcepto', TComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto);
  RegisterChildNode('Parte', TComprobanteFiscalV33_Conceptos_Concepto_Parte);
  FInformacionAduanera := CreateCollection(TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList, IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera, 'InformacionAduanera') as IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList;
  FParte := CreateCollection(TComprobanteFiscalV33_Conceptos_Concepto_ParteList, IComprobanteFiscalV33_Conceptos_Concepto_Parte, 'Parte') as IComprobanteFiscalV33_Conceptos_Concepto_ParteList;
  inherited;
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_ClaveProdServ: UnicodeString;
begin
  Result := AttributeNodes['ClaveProdServ'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_ClaveProdServ(Value: UnicodeString);
begin
  SetAttribute('ClaveProdServ', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['Cantidad'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('Cantidad', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_ClaveUnidad: UnicodeString;
begin
  Result := AttributeNodes['ClaveUnidad'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_ClaveUnidad(Value: UnicodeString);
begin
  SetAttribute('ClaveUnidad', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['Unidad'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('Unidad', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['Descripcion'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('Descripcion', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitario'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('ValorUnitario', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Descuento: UnicodeString;
begin
  Result := AttributeNodes['Descuento'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto.Set_Descuento(Value: UnicodeString);
begin
  SetAttribute('Descuento', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Impuestos: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos;
begin
  Result := ChildNodes['Impuestos'] as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos;
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_InformacionAduanera: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList;
begin
  Result := FInformacionAduanera;
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_CuentaPredial: IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial;
begin
  Result := ChildNodes['CuentaPredial'] as IComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial;
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_ComplementoConcepto: IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto;
begin
  Result := ChildNodes['ComplementoConcepto'] as IComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto;
end;

function TComprobanteFiscalV33_Conceptos_Concepto.Get_Parte: IComprobanteFiscalV33_Conceptos_Concepto_ParteList;
begin
  Result := FParte;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos }

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos.AfterConstruction;
begin
  RegisterChildNode('Traslados', TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados);
  RegisterChildNode('Retenciones', TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones);
  inherited;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos.Get_Traslados: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados;
begin
  Result := ChildNodes['Traslados'] as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos.Get_Retenciones: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones;
begin
  Result := ChildNodes['Retenciones'] as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados }

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado);
  ItemTag := 'cfdi:Traslado';
  ItemInterface := IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  inherited;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados.Get_Traslado(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados.Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado }

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Base: UnicodeString;
begin
  Result := AttributeNodes['Base'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Base(Value: UnicodeString);
begin
  SetAttribute('Base', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones }

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion);
  ItemTag := 'cfdi:Retencion';
  ItemInterface := IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
  inherited;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones.Get_Retencion(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones.Add: IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Base: UnicodeString;
begin
  Result := AttributeNodes['Base'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Base(Value: UnicodeString);
begin
  SetAttribute('Base', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['Numero'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('Numero', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('Fecha', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Get_Aduana: UnicodeString;
begin
  Result := AttributeNodes['Aduana'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera.Set_Aduana(Value: UnicodeString);
begin
  SetAttribute('Aduana', Value);
end;


{ TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList }

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList.Add: IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_InformacionAduaneraList.Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto_InformacionAduanera;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial }

function TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['Numero'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_CuentaPredial.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('Numero', Value);
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_ComplementoConcepto }

{ TComprobanteFiscalV33_Conceptos_Concepto_Parte }

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera);
  ItemTag := 'cfdi:InformacionAduanera';
  ItemInterface := IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
  inherited;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_ClaveProdServ: UnicodeString;
begin
  Result := AttributeNodes['ClaveProdServ'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_ClaveProdServ(Value: UnicodeString);
begin
  SetAttribute('ClaveProdServ', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['Cantidad'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('Cantidad', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['Unidad'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('Unidad', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['Descripcion'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('Descripcion', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitario'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('ValorUnitario', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_ParteList }

function TComprobanteFiscalV33_Conceptos_Concepto_ParteList.Add: IComprobanteFiscalV33_Conceptos_Concepto_Parte;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Conceptos_Concepto_Parte;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_ParteList.Insert(const Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Conceptos_Concepto_Parte;
end;

function TComprobanteFiscalV33_Conceptos_Concepto_ParteList.Get_Item(Index: Integer): IComprobanteFiscalV33_Conceptos_Concepto_Parte;
begin
  Result := List[Index] as IComprobanteFiscalV33_Conceptos_Concepto_Parte;
end;

{ TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera }

function TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['Numero'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('Numero', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('Fecha', Value);
end;

function TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Get_Aduana: UnicodeString;
begin
  Result := AttributeNodes['Aduana'].Text;
end;

procedure TComprobanteFiscalV33_Conceptos_Concepto_Parte_InformacionAduanera.Set_Aduana(Value: UnicodeString);
begin
  SetAttribute('Aduana', Value);
end;

{ TComprobanteFiscalV33_Impuestos }

procedure TComprobanteFiscalV33_Impuestos.AfterConstruction;
begin
  RegisterChildNode('Retenciones', TComprobanteFiscalV33_Impuestos_Retenciones);
  RegisterChildNode('Traslados', TComprobanteFiscalV33_Impuestos_Traslados);
  inherited;
end;

function TComprobanteFiscalV33_Impuestos.Get_TotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosRetenidos'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos.Set_TotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosRetenidos', Value);
end;

function TComprobanteFiscalV33_Impuestos.Get_TotalImpuestosTrasladados: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosTrasladados'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos.Set_TotalImpuestosTrasladados(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosTrasladados', Value);
end;

function TComprobanteFiscalV33_Impuestos.Get_Retenciones: IComprobanteFiscalV33_Impuestos_Retenciones;
begin
  Result := ChildNodes['Retenciones'] as IComprobanteFiscalV33_Impuestos_Retenciones;
end;

function TComprobanteFiscalV33_Impuestos.Get_Traslados: IComprobanteFiscalV33_Impuestos_Traslados;
begin
  Result := ChildNodes['Traslados'] as IComprobanteFiscalV33_Impuestos_Traslados;
end;

{ TComprobanteFiscalV33_Impuestos_Retenciones }

procedure TComprobanteFiscalV33_Impuestos_Retenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TComprobanteFiscalV33_Impuestos_Retenciones_Retencion);
  ItemTag := 'cfdi:Retencion';
  ItemInterface := IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
  inherited;
end;

function TComprobanteFiscalV33_Impuestos_Retenciones.Get_Retencion(Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
begin
  Result := List[Index] as IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
end;

function TComprobanteFiscalV33_Impuestos_Retenciones.Add: IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
end;

function TComprobanteFiscalV33_Impuestos_Retenciones.Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Impuestos_Retenciones_Retencion;
end;

{ TComprobanteFiscalV33_Impuestos_Retenciones_Retencion }

function TComprobanteFiscalV33_Impuestos_Retenciones_Retencion.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Retenciones_Retencion.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TComprobanteFiscalV33_Impuestos_Retenciones_Retencion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Retenciones_Retencion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TComprobanteFiscalV33_Impuestos_Traslados }

procedure TComprobanteFiscalV33_Impuestos_Traslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TComprobanteFiscalV33_Impuestos_Traslados_Traslado);
  ItemTag := 'cfdi:Traslado';
  ItemInterface := IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
  inherited;
end;

function TComprobanteFiscalV33_Impuestos_Traslados.Get_Traslado(Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
begin
  Result := List[Index] as IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
end;

function TComprobanteFiscalV33_Impuestos_Traslados.Add: IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
end;

function TComprobanteFiscalV33_Impuestos_Traslados.Insert(const Index: Integer): IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
end;

{ TComprobanteFiscalV33_Impuestos_Traslados_Traslado }

function TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TComprobanteFiscalV33_Impuestos_Traslados_Traslado.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

procedure TComprobanteFiscalV33_Complemento.AfterConstruction;
begin
  RegisterChildNode('TimbreFiscalDigital', TTimbreFiscalDigitalV33,
                    Facturacion.TimbreFiscalDigitalV33.TargetNamespace);
  inherited;
end;

function TComprobanteFiscalV33_Complemento.GetTimbreFiscalDigital:
    ITimbreFiscalDigitalV33;
begin
  if (Self.HasChildNode('TimbreFiscalDigital', Facturacion.TimbreFiscalDigitalV33.TargetNamespace)) then
    Result := ChildNodes.FindNode('TimbreFiscalDigital', Facturacion.TimbreFiscalDigitalV33.TargetNamespace) As ITimbreFiscalDigitalV33
  else
    Result := nil;
end;

procedure TComprobanteFiscalV33_Complemento.SetTimbreFiscalDigital(const Value:
    ITimbreFiscalDigitalV33);
begin
  ChildNodes.Add(Value);
end;

{ TComprobanteFiscalV33_Complemento }

{ TComprobanteFiscalV33_Addenda }

end.