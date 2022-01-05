
{*******************************************************************************}
{                                                                               }
{                               XML Data Binding                                }
{                                                                               }
{         Generated on: 05/01/2022 09:37:39 a. m.                               }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd   }
{   Settings stored in: C:\Delphi\tfacturaelectronica\Schemas\4.0\settings      }
{                                                                               }
{*******************************************************************************}

unit Facturacion.ComprobanteV40;

interface

uses  Facturacion.Comprobante,
      Facturacion.TimbreFiscalDigitalV33,
      SysUtils,
      Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IComprobanteFiscalV40 = interface;
  IComprobanteFiscalV40_InformacionGlobal = interface;
  IComprobanteFiscalV40_CfdiRelacionados = interface;
  IComprobanteFiscalV40_CfdiRelacionadosList = interface;
  IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado = interface;
  IComprobanteFiscalV40_Emisor = interface;
  IComprobanteFiscalV40_Receptor = interface;
  IComprobanteFiscalV40_Conceptos = interface;
  IComprobanteFiscalV40_Conceptos_Concepto = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Parte = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_ParteList = interface;
  IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera = interface;
  IComprobanteFiscalV40_Impuestos = interface;
  IComprobanteFiscalV40_Impuestos_Retenciones = interface;
  IComprobanteFiscalV40_Impuestos_Retenciones_Retencion = interface;
  IComprobanteFiscalV40_Impuestos_Traslados = interface;
  IComprobanteFiscalV40_Impuestos_Traslados_Traslado = interface;
  IComprobanteFiscalV40_Complemento = interface;
  IComprobanteFiscalV40_Addenda = interface;

{ IComprobanteFiscalV40 }

  IComprobanteFiscalV40 = interface(IComprobanteFiscal)
    ['{57EDBFBD-7B80-4A73-8C7A-6302B6017BFC}']
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
    function Get_Exportacion: UnicodeString;
    function Get_MetodoPago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_Confirmacion: UnicodeString;
    function Get_InformacionGlobal: IComprobanteFiscalV40_InformacionGlobal;
    function Get_CfdiRelacionados: IComprobanteFiscalV40_CfdiRelacionadosList;
    function Get_Emisor: IComprobanteFiscalV40_Emisor;
    function Get_Receptor: IComprobanteFiscalV40_Receptor;
    function Get_Conceptos: IComprobanteFiscalV40_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV40_Impuestos;
    function Get_Complemento: IComprobanteFiscalV40_Complemento;
    function Get_Addenda: IComprobanteFiscalV40_Addenda;
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
    procedure Set_Exportacion(Value: UnicodeString);
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
    property Exportacion: UnicodeString read Get_Exportacion write Set_Exportacion;
    property MetodoPago: UnicodeString read Get_MetodoPago write Set_MetodoPago;
    property LugarExpedicion: UnicodeString read Get_LugarExpedicion write Set_LugarExpedicion;
    property Confirmacion: UnicodeString read Get_Confirmacion write Set_Confirmacion;
    property InformacionGlobal: IComprobanteFiscalV40_InformacionGlobal read Get_InformacionGlobal;
    property CfdiRelacionados: IComprobanteFiscalV40_CfdiRelacionadosList read Get_CfdiRelacionados;
    property Emisor: IComprobanteFiscalV40_Emisor read Get_Emisor;
    property Receptor: IComprobanteFiscalV40_Receptor read Get_Receptor;
    property Conceptos: IComprobanteFiscalV40_Conceptos read Get_Conceptos;
    property Impuestos: IComprobanteFiscalV40_Impuestos read Get_Impuestos;
    property Complemento: IComprobanteFiscalV40_Complemento read Get_Complemento;
    property Addenda: IComprobanteFiscalV40_Addenda read Get_Addenda;
  end;

{ IComprobanteFiscalV40_InformacionGlobal }

  IComprobanteFiscalV40_InformacionGlobal = interface(IXMLNode)
    ['{CC852B6B-2F16-4809-A23D-65CA5D120896}']
    { Property Accessors }
    function Get_Periodicidad: UnicodeString;
    function Get_Meses: UnicodeString;
    function Get_Año: SmallInt;
    procedure Set_Periodicidad(Value: UnicodeString);
    procedure Set_Meses(Value: UnicodeString);
    procedure Set_Año(Value: SmallInt);
    { Methods & Properties }
    property Periodicidad: UnicodeString read Get_Periodicidad write Set_Periodicidad;
    property Meses: UnicodeString read Get_Meses write Set_Meses;
    property Año: SmallInt read Get_Año write Set_Año;
  end;

{ IComprobanteFiscalV40_CfdiRelacionados }

  IComprobanteFiscalV40_CfdiRelacionados = interface(IXMLNodeCollection)
    ['{C50464AA-C6C7-402D-A2A1-59C462408EAC}']
    { Property Accessors }
    function Get_TipoRelacion: UnicodeString;
    function Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
    procedure Set_TipoRelacion(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
    property TipoRelacion: UnicodeString read Get_TipoRelacion write Set_TipoRelacion;
    property CfdiRelacionado[Index: Integer]: IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado read Get_CfdiRelacionado; default;
  end;

{ IComprobanteFiscalV40_CfdiRelacionadosList }

  IComprobanteFiscalV40_CfdiRelacionadosList = interface(IXMLNodeCollection)
    ['{5A2DE8DD-78AB-4E71-B1CD-35104C51D0F2}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_CfdiRelacionados;
    function Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;
    property Items[Index: Integer]: IComprobanteFiscalV40_CfdiRelacionados read Get_Item; default;
  end;

{ IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado }

  IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado = interface(IXMLNode)
    ['{C7C63667-503E-4703-956A-20B756FCD0BE}']
    { Property Accessors }
    function Get_UUID: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
    { Methods & Properties }
    property UUID: UnicodeString read Get_UUID write Set_UUID;
  end;

{ IComprobanteFiscalV40_Emisor }

  IComprobanteFiscalV40_Emisor = interface(IXMLNode)
    ['{8873AF56-37A5-489D-896A-1EA16FA71067}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_RegimenFiscal: UnicodeString;
    function Get_FacAtrAdquirente: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_RegimenFiscal(Value: UnicodeString);
    procedure Set_FacAtrAdquirente(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property RegimenFiscal: UnicodeString read Get_RegimenFiscal write Set_RegimenFiscal;
    property FacAtrAdquirente: UnicodeString read Get_FacAtrAdquirente write Set_FacAtrAdquirente;
  end;

{ IComprobanteFiscalV40_Receptor }

  IComprobanteFiscalV40_Receptor = interface(IXMLNode)
    ['{8B99F795-6F6E-4C49-9F11-AEE68CEE08FF}']
    { Property Accessors }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_DomicilioFiscalReceptor: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    function Get_NumRegIdTrib: UnicodeString;
    function Get_RegimenFiscalReceptor: UnicodeString;
    function Get_UsoCFDI: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_DomicilioFiscalReceptor(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_RegimenFiscalReceptor(Value: UnicodeString);
    procedure Set_UsoCFDI(Value: UnicodeString);
    { Methods & Properties }
    property Rfc: UnicodeString read Get_Rfc write Set_Rfc;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property DomicilioFiscalReceptor: UnicodeString read Get_DomicilioFiscalReceptor write Set_DomicilioFiscalReceptor;
    property ResidenciaFiscal: UnicodeString read Get_ResidenciaFiscal write Set_ResidenciaFiscal;
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property RegimenFiscalReceptor: UnicodeString read Get_RegimenFiscalReceptor write Set_RegimenFiscalReceptor;
    property UsoCFDI: UnicodeString read Get_UsoCFDI write Set_UsoCFDI;
  end;

{ IComprobanteFiscalV40_Conceptos }

  IComprobanteFiscalV40_Conceptos = interface(IXMLNodeCollection)
    ['{03FD9A58-5178-4DAC-9C7D-2184C901D859}']
    { Property Accessors }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
    property Concepto[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto read Get_Concepto; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto }

  IComprobanteFiscalV40_Conceptos_Concepto = interface(IXMLNode)
    ['{CBB75B1E-4CF2-478F-903A-7AB29137793B}']
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
    function Get_ObjetoImp: UnicodeString;
    function Get_Impuestos: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos;
    function Get_ACuentaTerceros: IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros;
    function Get_InformacionAduanera: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList;
    function Get_ComplementoConcepto: IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV40_Conceptos_Concepto_ParteList;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_ClaveUnidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_ObjetoImp(Value: UnicodeString);
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
    property ObjetoImp: UnicodeString read Get_ObjetoImp write Set_ObjetoImp;
    property Impuestos: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos read Get_Impuestos;
    property ACuentaTerceros: IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros read Get_ACuentaTerceros;
    property InformacionAduanera: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList read Get_InformacionAduanera;
    property CuentaPredial: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList read Get_CuentaPredial;
    property ComplementoConcepto: IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto read Get_ComplementoConcepto;
    property Parte: IComprobanteFiscalV40_Conceptos_Concepto_ParteList read Get_Parte;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Impuestos }

  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos = interface(IXMLNode)
    ['{189A2FB0-4294-4006-A179-EB6F84B21467}']
    { Property Accessors }
    function Get_Traslados: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados;
    function Get_Retenciones: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones;
    { Methods & Properties }
    property Traslados: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados read Get_Traslados;
    property Retenciones: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones read Get_Retenciones;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados }

  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados = interface(IXMLNodeCollection)
    ['{9F5028EB-A6D6-4507-A8B6-63A60A019F26}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    property Traslado[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado read Get_Traslado; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado }

  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado = interface(IXMLNode)
    ['{FCC742D1-AD64-47A9-B685-A8769AEE513E}']
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

{ IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones }

  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones = interface(IXMLNodeCollection)
    ['{D278F9D1-16E3-47C6-BDF0-9211E0E147B3}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    property Retencion[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion read Get_Retencion; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

  IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion = interface(IXMLNode)
    ['{42D7433D-4615-4E78-B40D-AB45C37A9DCF}']
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

{ IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros }

  IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros = interface(IXMLNode)
    ['{2AB70426-C600-4EFE-93DC-AC7139FBD23C}']
    { Property Accessors }
    function Get_RfcACuentaTerceros: UnicodeString;
    function Get_NombreACuentaTerceros: UnicodeString;
    function Get_RegimenFiscalACuentaTerceros: UnicodeString;
    function Get_DomicilioFiscalACuentaTerceros: UnicodeString;
    procedure Set_RfcACuentaTerceros(Value: UnicodeString);
    procedure Set_NombreACuentaTerceros(Value: UnicodeString);
    procedure Set_RegimenFiscalACuentaTerceros(Value: UnicodeString);
    procedure Set_DomicilioFiscalACuentaTerceros(Value: UnicodeString);
    { Methods & Properties }
    property RfcACuentaTerceros: UnicodeString read Get_RfcACuentaTerceros write Set_RfcACuentaTerceros;
    property NombreACuentaTerceros: UnicodeString read Get_NombreACuentaTerceros write Set_NombreACuentaTerceros;
    property RegimenFiscalACuentaTerceros: UnicodeString read Get_RegimenFiscalACuentaTerceros write Set_RegimenFiscalACuentaTerceros;
    property DomicilioFiscalACuentaTerceros: UnicodeString read Get_DomicilioFiscalACuentaTerceros write Set_DomicilioFiscalACuentaTerceros;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera }

  IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera = interface(IXMLNode)
    ['{9582C46D-E788-4114-BFFE-7AAE9C5CC6BE}']
    { Property Accessors }
    function Get_NumeroPedimento: UnicodeString;
    procedure Set_NumeroPedimento(Value: UnicodeString);
    { Methods & Properties }
    property NumeroPedimento: UnicodeString read Get_NumeroPedimento write Set_NumeroPedimento;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList }

  IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList = interface(IXMLNodeCollection)
    ['{428C069C-F063-446A-91E3-4FAF75703781}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
    property Items[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera read Get_Item; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial }

  IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial = interface(IXMLNode)
    ['{20CBA7AF-F3D6-4498-B38C-9388FA10ACEC}']
    { Property Accessors }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
    { Methods & Properties }
    property Numero: UnicodeString read Get_Numero write Set_Numero;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList }

  IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList = interface(IXMLNodeCollection)
    ['{79D135EA-AFEF-465D-B863-2705AA0B6DC3}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
    property Items[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial read Get_Item; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto }

  IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto = interface(IXMLNode)
    ['{33396634-0929-4342-AF4A-E86464311EC4}']
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Parte }

  IComprobanteFiscalV40_Conceptos_Concepto_Parte = interface(IXMLNodeCollection)
    ['{1C853643-7150-4241-A9F1-39477CDAF300}']
    { Property Accessors }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
    property ClaveProdServ: UnicodeString read Get_ClaveProdServ write Set_ClaveProdServ;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property Cantidad: UnicodeString read Get_Cantidad write Set_Cantidad;
    property Unidad: UnicodeString read Get_Unidad write Set_Unidad;
    property Descripcion: UnicodeString read Get_Descripcion write Set_Descripcion;
    property ValorUnitario: UnicodeString read Get_ValorUnitario write Set_ValorUnitario;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property InformacionAduanera[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera read Get_InformacionAduanera; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_ParteList }

  IComprobanteFiscalV40_Conceptos_Concepto_ParteList = interface(IXMLNodeCollection)
    ['{23A27DCE-13B2-4F19-9813-7DE28419A462}']
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;
    property Items[Index: Integer]: IComprobanteFiscalV40_Conceptos_Concepto_Parte read Get_Item; default;
  end;

{ IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera }

  IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera = interface(IXMLNode)
    ['{3AEADCB6-D9D7-4624-8BB1-154592657E30}']
    { Property Accessors }
    function Get_NumeroPedimento: UnicodeString;
    procedure Set_NumeroPedimento(Value: UnicodeString);
    { Methods & Properties }
    property NumeroPedimento: UnicodeString read Get_NumeroPedimento write Set_NumeroPedimento;
  end;

{ IComprobanteFiscalV40_Impuestos }

  IComprobanteFiscalV40_Impuestos = interface(IXMLNode)
    ['{41AB4693-C725-4E09-8C3F-D6F79380AFD2}']
    { Property Accessors }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV40_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV40_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: UnicodeString read Get_TotalImpuestosRetenidos write Set_TotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: UnicodeString read Get_TotalImpuestosTrasladados write Set_TotalImpuestosTrasladados;
    property Retenciones: IComprobanteFiscalV40_Impuestos_Retenciones read Get_Retenciones;
    property Traslados: IComprobanteFiscalV40_Impuestos_Traslados read Get_Traslados;
  end;

{ IComprobanteFiscalV40_Impuestos_Retenciones }

  IComprobanteFiscalV40_Impuestos_Retenciones = interface(IXMLNodeCollection)
    ['{C553E176-8AC0-4890-9E69-9121E483F17C}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
    property Retencion[Index: Integer]: IComprobanteFiscalV40_Impuestos_Retenciones_Retencion read Get_Retencion; default;
  end;

{ IComprobanteFiscalV40_Impuestos_Retenciones_Retencion }

  IComprobanteFiscalV40_Impuestos_Retenciones_Retencion = interface(IXMLNode)
    ['{4252E222-27DD-4EB8-B7C9-B1D82B0DD0B6}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IComprobanteFiscalV40_Impuestos_Traslados }

  IComprobanteFiscalV40_Impuestos_Traslados = interface(IXMLNodeCollection)
    ['{9D8BB8AE-7F37-4E6E-9D85-686CE7C97D98}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
    { Methods & Properties }
    function Add: IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
    property Traslado[Index: Integer]: IComprobanteFiscalV40_Impuestos_Traslados_Traslado read Get_Traslado; default;
  end;

{ IComprobanteFiscalV40_Impuestos_Traslados_Traslado }

  IComprobanteFiscalV40_Impuestos_Traslados_Traslado = interface(IXMLNode)
    ['{70619DFF-2779-4A57-82CF-78BCEDA4C39B}']
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

{ IComprobanteFiscalV40_Complemento }

  IComprobanteFiscalV40_Complemento = interface(IXMLNode)
    ['{A0FC2954-170C-4645-9BA4-F1714C57FBD8}']
    function GetTimbreFiscalDigital: ITimbreFiscalDigitalV33;
    procedure SetTimbreFiscalDigital(const Value: ITimbreFiscalDigitalV33);
    property TimbreFiscalDigital: ITimbreFiscalDigitalV33 read GetTimbreFiscalDigital write SetTimbreFiscalDigital;
  end;

{ IComprobanteFiscalV40_Addenda }

  IComprobanteFiscalV40_Addenda = interface(IXMLNode)
    ['{A020345E-9957-45D3-BD60-2E0E18899D32}']
  end;

{ Forward Decls }

  TComprobanteFiscalV40 = class;
  TXMLIComprobanteFiscalV40_InformacionGlobal = class;
  TXMLIComprobanteFiscalV40_CfdiRelacionados = class;
  TXMLIComprobanteFiscalV40_CfdiRelacionadosList = class;
  TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado = class;
  TXMLIComprobanteFiscalV40_Emisor = class;
  TXMLIComprobanteFiscalV40_Receptor = class;
  TXMLIComprobanteFiscalV40_Conceptos = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList = class;
  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera = class;
  TXMLIComprobanteFiscalV40_Impuestos = class;
  TXMLIComprobanteFiscalV40_Impuestos_Retenciones = class;
  TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion = class;
  TXMLIComprobanteFiscalV40_Impuestos_Traslados = class;
  TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado = class;
  TComprobanteFiscalV40_Complemento = class;
  TXMLIComprobanteFiscalV40_Addenda = class;

{ TComprobanteFiscalV40 }

  TComprobanteFiscalV40 = class(TXMLNode, IComprobanteFiscalV40)
  private
    FCfdiRelacionados: IComprobanteFiscalV40_CfdiRelacionadosList;
  protected
    { IComprobanteFiscalV40 }
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
    function Get_Exportacion: UnicodeString;
    function Get_MetodoPago: UnicodeString;
    function Get_LugarExpedicion: UnicodeString;
    function Get_Confirmacion: UnicodeString;
    function Get_InformacionGlobal: IComprobanteFiscalV40_InformacionGlobal;
    function Get_CfdiRelacionados: IComprobanteFiscalV40_CfdiRelacionadosList;
    function Get_Emisor: IComprobanteFiscalV40_Emisor;
    function Get_Receptor: IComprobanteFiscalV40_Receptor;
    function Get_Conceptos: IComprobanteFiscalV40_Conceptos;
    function Get_Impuestos: IComprobanteFiscalV40_Impuestos;
    function Get_Complemento: IComprobanteFiscalV40_Complemento;
    function Get_Addenda: IComprobanteFiscalV40_Addenda;
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
    procedure Set_Exportacion(Value: UnicodeString);
    procedure Set_MetodoPago(Value: UnicodeString);
    procedure Set_LugarExpedicion(Value: UnicodeString);
    procedure Set_Confirmacion(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
    procedure AsignarTimbreFiscal(const aXMLTimbre: TCadenaUTF8);
    procedure AgregarComplemento(aNodoAAgregar: IXMLNode; const aNameSpacePrefijo :
        String; const aNameSpaceURI: String; const aAnexarSchema: String);
  end;

{ TXMLIComprobanteFiscalV40_InformacionGlobal }

  TXMLIComprobanteFiscalV40_InformacionGlobal = class(TXMLNode, IComprobanteFiscalV40_InformacionGlobal)
  protected
    { IComprobanteFiscalV40_InformacionGlobal }
    function Get_Periodicidad: UnicodeString;
    function Get_Meses: UnicodeString;
    function Get_Año: SmallInt;
    procedure Set_Periodicidad(Value: UnicodeString);
    procedure Set_Meses(Value: UnicodeString);
    procedure Set_Año(Value: SmallInt);
  end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionados }

  TXMLIComprobanteFiscalV40_CfdiRelacionados = class(TXMLNodeCollection, IComprobanteFiscalV40_CfdiRelacionados)
  protected
    { IComprobanteFiscalV40_CfdiRelacionados }
    function Get_TipoRelacion: UnicodeString;
    function Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
    procedure Set_TipoRelacion(Value: UnicodeString);
    function Add: IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionadosList }

  TXMLIComprobanteFiscalV40_CfdiRelacionadosList = class(TXMLNodeCollection, IComprobanteFiscalV40_CfdiRelacionadosList)
  protected
    { IComprobanteFiscalV40_CfdiRelacionadosList }
    function Add: IComprobanteFiscalV40_CfdiRelacionados;
    function Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;
  end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado }

  TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado = class(TXMLNode, IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado)
  protected
    { IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado }
    function Get_UUID: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Emisor }

  TXMLIComprobanteFiscalV40_Emisor = class(TXMLNode, IComprobanteFiscalV40_Emisor)
  protected
    { IComprobanteFiscalV40_Emisor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_RegimenFiscal: UnicodeString;
    function Get_FacAtrAdquirente: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_RegimenFiscal(Value: UnicodeString);
    procedure Set_FacAtrAdquirente(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Receptor }

  TXMLIComprobanteFiscalV40_Receptor = class(TXMLNode, IComprobanteFiscalV40_Receptor)
  protected
    { IComprobanteFiscalV40_Receptor }
    function Get_Rfc: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_DomicilioFiscalReceptor: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    function Get_NumRegIdTrib: UnicodeString;
    function Get_RegimenFiscalReceptor: UnicodeString;
    function Get_UsoCFDI: UnicodeString;
    procedure Set_Rfc(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_DomicilioFiscalReceptor(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_RegimenFiscalReceptor(Value: UnicodeString);
    procedure Set_UsoCFDI(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Conceptos }

  TXMLIComprobanteFiscalV40_Conceptos = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos)
  protected
    { IComprobanteFiscalV40_Conceptos }
    function Get_Concepto(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
    function Add: IComprobanteFiscalV40_Conceptos_Concepto;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto)
  private
    FInformacionAduanera: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList;
    FCuentaPredial: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList;
    FParte: IComprobanteFiscalV40_Conceptos_Concepto_ParteList;
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_ClaveUnidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_Descuento: UnicodeString;
    function Get_ObjetoImp: UnicodeString;
    function Get_Impuestos: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos;
    function Get_ACuentaTerceros: IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros;
    function Get_InformacionAduanera: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList;
    function Get_CuentaPredial: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList;
    function Get_ComplementoConcepto: IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto;
    function Get_Parte: IComprobanteFiscalV40_Conceptos_Concepto_ParteList;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_ClaveUnidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    procedure Set_Descuento(Value: UnicodeString);
    procedure Set_ObjetoImp(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_Impuestos)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Impuestos }
    function Get_Traslados: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados;
    function Get_Retenciones: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado }
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

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion }
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

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros }
    function Get_RfcACuentaTerceros: UnicodeString;
    function Get_NombreACuentaTerceros: UnicodeString;
    function Get_RegimenFiscalACuentaTerceros: UnicodeString;
    function Get_DomicilioFiscalACuentaTerceros: UnicodeString;
    procedure Set_RfcACuentaTerceros(Value: UnicodeString);
    procedure Set_NombreACuentaTerceros(Value: UnicodeString);
    procedure Set_RegimenFiscalACuentaTerceros(Value: UnicodeString);
    procedure Set_DomicilioFiscalACuentaTerceros(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera }
    function Get_NumeroPedimento: UnicodeString;
    procedure Set_NumeroPedimento(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial }
    function Get_Numero: UnicodeString;
    procedure Set_Numero(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto }
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_Parte)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Parte }
    function Get_ClaveProdServ: UnicodeString;
    function Get_NoIdentificacion: UnicodeString;
    function Get_Cantidad: UnicodeString;
    function Get_Unidad: UnicodeString;
    function Get_Descripcion: UnicodeString;
    function Get_ValorUnitario: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
    procedure Set_ClaveProdServ(Value: UnicodeString);
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_Cantidad(Value: UnicodeString);
    procedure Set_Unidad(Value: UnicodeString);
    procedure Set_Descripcion(Value: UnicodeString);
    procedure Set_ValorUnitario(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList = class(TXMLNodeCollection, IComprobanteFiscalV40_Conceptos_Concepto_ParteList)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_ParteList }
    function Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;

    function Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;
  end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera }

  TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera = class(TXMLNode, IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera)
  protected
    { IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera }
    function Get_NumeroPedimento: UnicodeString;
    procedure Set_NumeroPedimento(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Impuestos }

  TXMLIComprobanteFiscalV40_Impuestos = class(TXMLNode, IComprobanteFiscalV40_Impuestos)
  protected
    { IComprobanteFiscalV40_Impuestos }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IComprobanteFiscalV40_Impuestos_Retenciones;
    function Get_Traslados: IComprobanteFiscalV40_Impuestos_Traslados;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Impuestos_Retenciones }

  TXMLIComprobanteFiscalV40_Impuestos_Retenciones = class(TXMLNodeCollection, IComprobanteFiscalV40_Impuestos_Retenciones)
  protected
    { IComprobanteFiscalV40_Impuestos_Retenciones }
    function Get_Retencion(Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
    function Add: IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion }

  TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion = class(TXMLNode, IComprobanteFiscalV40_Impuestos_Retenciones_Retencion)
  protected
    { IComprobanteFiscalV40_Impuestos_Retenciones_Retencion }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TXMLIComprobanteFiscalV40_Impuestos_Traslados }

  TXMLIComprobanteFiscalV40_Impuestos_Traslados = class(TXMLNodeCollection, IComprobanteFiscalV40_Impuestos_Traslados)
  protected
    { IComprobanteFiscalV40_Impuestos_Traslados }
    function Get_Traslado(Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
    function Add: IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
    function Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado }

  TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado = class(TXMLNode, IComprobanteFiscalV40_Impuestos_Traslados_Traslado)
  protected
    { IComprobanteFiscalV40_Impuestos_Traslados_Traslado }
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

{ TComprobanteFiscalV40_Complemento }

  TComprobanteFiscalV40_Complemento = class(TXMLNode,
      IComprobanteFiscalV40_Complemento)
  private
    function GetTimbreFiscalDigital: ITimbreFiscalDigitalV33;
    procedure SetTimbreFiscalDigital(const Value: ITimbreFiscalDigitalV33);
  protected
    { IComprobanteFiscalV33_Complemento }
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIComprobanteFiscalV40_Addenda }

  TXMLIComprobanteFiscalV40_Addenda = class(TXMLNode, IComprobanteFiscalV40_Addenda)
  protected
    { IComprobanteFiscalV40_Addenda }
  end;

{ Global Functions }

function GetComprobanteFiscalV40(Doc: IXMLDocument): IComprobanteFiscalV40;
function LoadComprobanteFiscalV40(const FileName: string):
    IComprobanteFiscalV40;
function NewComprobanteFiscalV40: IComprobanteFiscalV40;

const
  TargetNamespace = 'http://www.sat.gob.mx/cfd/4';

implementation

uses Xml.xmlutil;

const
  _NODO_XSI     = 'xmlns:xsi';
  _NODO_SL      = 'xsi:schemaLocation';
  _NODO_VERSION = 'Version';

{ Global Functions }

procedure establecerAtributosDeCFDI(comprobante: IComprobanteFiscalV40);
begin
  // Agregamos la auto identacion
  comprobante.OwnerDocument.Options := [doNodeAutoCreate, doAttrNull, doAutoPrefix, doNamespaceDecl, doNodeAutoIndent];

  if (comprobante.AttributeNodes.FindNode(_NODO_XSI) = nil) then
      comprobante.SetAttribute(_NODO_XSI,
                               'http://www.w3.org/2001/XMLSchema-instance');

  if (comprobante.AttributeNodes.FindNode(_NODO_SL) = nil) then
    comprobante.SetAttribute(_NODO_SL,
                            'http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd');

  if (comprobante.AttributeNodes.FindNode(_NODO_VERSION) = nil) then
    comprobante.Version := '4.0';
end;

{ Global Functions }

function GetComprobanteFiscalV40(Doc: IXMLDocument): IComprobanteFiscalV40;
begin
  Result := Doc.GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV40, TargetNamespace) as IComprobanteFiscalV40;
end;

function LoadComprobanteFiscalV40(const FileName: string):
    IComprobanteFiscalV40;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV40, TargetNamespace) as IComprobanteFiscalV40;
end;

function NewComprobanteFiscalV40: IComprobanteFiscalV40;
begin
  Result := NewXMLDocument.GetDocBinding('cfdi:Comprobante', TComprobanteFiscalV40, TargetNamespace) as IComprobanteFiscalV40;
end;

{ TComprobanteFiscalV40 }

procedure TComprobanteFiscalV40.AgregarComplemento(aNodoAAgregar: IXMLNode;
  const aNameSpacePrefijo, aNameSpaceURI, aAnexarSchema: String);
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

  // Agregamos el XSD del complemento
  schemaLocation := Self.AttributeNodes.FindNode(_NODO_SL).Text;
  Self.SetAttribute(_NODO_SL,schemaLocation+ ' '+ aAnexarSchema);
  Self.Resync;
end;

procedure TComprobanteFiscalV40.AsignarTimbreFiscal(
  const aXMLTimbre: TCadenaUTF8);
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
  if AnsiPos(_NODO_XSI, timbreConXSI) = 0 then
  begin
    timbreConXSI := StringReplace(timbreConXSI, 'TimbreFiscalDigital"',
                                                'TimbreFiscalDigital" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',
                                                [rfReplaceAll]);
  end;

  // Creamos el XMLDocument desde el XML del timbre
  documentoXMLTimbre := LoadXMLData(timbreConXSI);
  nodoTimbre         := GetTimbreFiscalDigitalV33(documentoXMLTimbre);

  // Agregamos el nodo del TimbreFiscalDigital al nodo Complemento del comprobante
  Get_Complemento.ChildNodes.Add(nodoTimbre);

  // Agregamos el XSD del TFD
  schemaLocation := Self.AttributeNodes.FindNode(_NODO_SL).Text;
  Self.SetAttribute(_NODO_SL, schemaLocation +
                              ' http://www.sat.gob.mx/TimbreFiscalDigital' +
                              ' http://www.sat.gob.mx/sitio_internet/cfd/timbrefiscaldigital/TimbreFiscalDigitalv11.xsd');

end;

procedure TComprobanteFiscalV40.AfterConstruction;
begin
  RegisterChildNode('InformacionGlobal', TXMLIComprobanteFiscalV40_InformacionGlobal);
  RegisterChildNode('CfdiRelacionados', TXMLIComprobanteFiscalV40_CfdiRelacionados);
  RegisterChildNode('Emisor', TXMLIComprobanteFiscalV40_Emisor);
  RegisterChildNode('Receptor', TXMLIComprobanteFiscalV40_Receptor);
  RegisterChildNode('Conceptos', TXMLIComprobanteFiscalV40_Conceptos);
  RegisterChildNode('Impuestos', TXMLIComprobanteFiscalV40_Impuestos);
  RegisterChildNode('Complemento', TComprobanteFiscalV40_Complemento);
  RegisterChildNode('Addenda', TXMLIComprobanteFiscalV40_Addenda);
  FCfdiRelacionados := CreateCollection(TXMLIComprobanteFiscalV40_CfdiRelacionadosList, IComprobanteFiscalV40_CfdiRelacionados, 'CfdiRelacionados') as IComprobanteFiscalV40_CfdiRelacionadosList;

  establecerAtributosDeCFDI(Self);

  inherited;
end;

function TComprobanteFiscalV40.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TComprobanteFiscalV40.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TComprobanteFiscalV40.Get_Serie: UnicodeString;
begin
  Result := AttributeNodes['Serie'].Text;
end;

procedure TComprobanteFiscalV40.Set_Serie(Value: UnicodeString);
begin
  SetAttribute('Serie', Value);
end;

function TComprobanteFiscalV40.Get_Folio: UnicodeString;
begin
  Result := AttributeNodes['Folio'].Text;
end;

procedure TComprobanteFiscalV40.Set_Folio(Value: UnicodeString);
begin
  SetAttribute('Folio', Value);
end;

function TComprobanteFiscalV40.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TComprobanteFiscalV40.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('Fecha', Value);
end;

function TComprobanteFiscalV40.Get_Sello: UnicodeString;
begin
  Result := AttributeNodes['Sello'].Text;
end;

procedure TComprobanteFiscalV40.Set_Sello(Value: UnicodeString);
begin
  SetAttribute('Sello', Value);
end;

function TComprobanteFiscalV40.Get_FormaPago: UnicodeString;
begin
  Result := AttributeNodes['FormaPago'].Text;
end;

procedure TComprobanteFiscalV40.Set_FormaPago(Value: UnicodeString);
begin
  SetAttribute('FormaPago', Value);
end;

function TComprobanteFiscalV40.Get_NoCertificado: UnicodeString;
begin
  Result := AttributeNodes['NoCertificado'].Text;
end;

procedure TComprobanteFiscalV40.Set_NoCertificado(Value: UnicodeString);
begin
  SetAttribute('NoCertificado', Value);
end;

function TComprobanteFiscalV40.Get_Certificado: UnicodeString;
begin
  Result := AttributeNodes['Certificado'].Text;
end;

procedure TComprobanteFiscalV40.Set_Certificado(Value: UnicodeString);
begin
  SetAttribute('Certificado', Value);
end;

function TComprobanteFiscalV40.Get_CondicionesDePago: UnicodeString;
begin
  Result := AttributeNodes['CondicionesDePago'].Text;
end;

procedure TComprobanteFiscalV40.Set_CondicionesDePago(Value: UnicodeString);
begin
  SetAttribute('CondicionesDePago', Value);
end;

function TComprobanteFiscalV40.Get_SubTotal: UnicodeString;
begin
  Result := AttributeNodes['SubTotal'].Text;
end;

procedure TComprobanteFiscalV40.Set_SubTotal(Value: UnicodeString);
begin
  SetAttribute('SubTotal', Value);
end;

function TComprobanteFiscalV40.Get_Descuento: UnicodeString;
begin
  Result := AttributeNodes['Descuento'].Text;
end;

procedure TComprobanteFiscalV40.Set_Descuento(Value: UnicodeString);
begin
  SetAttribute('Descuento', Value);
end;

function TComprobanteFiscalV40.Get_Moneda: UnicodeString;
begin
  Result := AttributeNodes['Moneda'].Text;
end;

procedure TComprobanteFiscalV40.Set_Moneda(Value: UnicodeString);
begin
  SetAttribute('Moneda', Value);
end;

function TComprobanteFiscalV40.Get_TipoCambio: UnicodeString;
begin
  Result := AttributeNodes['TipoCambio'].Text;
end;

procedure TComprobanteFiscalV40.Set_TipoCambio(Value: UnicodeString);
begin
  SetAttribute('TipoCambio', Value);
end;

function TComprobanteFiscalV40.Get_Total: UnicodeString;
begin
  Result := AttributeNodes['Total'].Text;
end;

procedure TComprobanteFiscalV40.Set_Total(Value: UnicodeString);
begin
  SetAttribute('Total', Value);
end;

function TComprobanteFiscalV40.Get_TipoDeComprobante: UnicodeString;
begin
  Result := AttributeNodes['TipoDeComprobante'].Text;
end;

procedure TComprobanteFiscalV40.Set_TipoDeComprobante(Value: UnicodeString);
begin
  SetAttribute('TipoDeComprobante', Value);
end;

function TComprobanteFiscalV40.Get_Exportacion: UnicodeString;
begin
  Result := AttributeNodes['Exportacion'].Text;
end;

procedure TComprobanteFiscalV40.Set_Exportacion(Value: UnicodeString);
begin
  SetAttribute('Exportacion', Value);
end;

function TComprobanteFiscalV40.Get_MetodoPago: UnicodeString;
begin
  Result := AttributeNodes['MetodoPago'].Text;
end;

procedure TComprobanteFiscalV40.Set_MetodoPago(Value: UnicodeString);
begin
  SetAttribute('MetodoPago', Value);
end;

function TComprobanteFiscalV40.Get_LugarExpedicion: UnicodeString;
begin
  Result := AttributeNodes['LugarExpedicion'].Text;
end;

procedure TComprobanteFiscalV40.Set_LugarExpedicion(Value: UnicodeString);
begin
  SetAttribute('LugarExpedicion', Value);
end;

function TComprobanteFiscalV40.Get_Confirmacion: UnicodeString;
begin
  Result := AttributeNodes['Confirmacion'].Text;
end;

procedure TComprobanteFiscalV40.Set_Confirmacion(Value: UnicodeString);
begin
  SetAttribute('Confirmacion', Value);
end;

function TComprobanteFiscalV40.Get_InformacionGlobal: IComprobanteFiscalV40_InformacionGlobal;
begin
  Result := ChildNodes['InformacionGlobal'] as IComprobanteFiscalV40_InformacionGlobal;
end;

function TComprobanteFiscalV40.Get_CfdiRelacionados: IComprobanteFiscalV40_CfdiRelacionadosList;
begin
  Result := FCfdiRelacionados;
end;

function TComprobanteFiscalV40.Get_Emisor: IComprobanteFiscalV40_Emisor;
begin
  Result := ChildNodes['Emisor'] as IComprobanteFiscalV40_Emisor;
end;

function TComprobanteFiscalV40.Get_Receptor: IComprobanteFiscalV40_Receptor;
begin
  Result := ChildNodes['Receptor'] as IComprobanteFiscalV40_Receptor;
end;

function TComprobanteFiscalV40.Get_Conceptos: IComprobanteFiscalV40_Conceptos;
begin
  Result := ChildNodes['Conceptos'] as IComprobanteFiscalV40_Conceptos;
end;

function TComprobanteFiscalV40.Get_Impuestos: IComprobanteFiscalV40_Impuestos;
begin
  Result := ChildNodes['Impuestos'] as IComprobanteFiscalV40_Impuestos;
end;

function TComprobanteFiscalV40.Get_Complemento: IComprobanteFiscalV40_Complemento;
begin
  Result := ChildNodes['Complemento'] as IComprobanteFiscalV40_Complemento;
end;



function TComprobanteFiscalV40.Get_Addenda: IComprobanteFiscalV40_Addenda;
begin
  Result := ChildNodes['Addenda'] as IComprobanteFiscalV40_Addenda;
end;

{ TXMLIComprobanteFiscalV40_InformacionGlobal }

function TXMLIComprobanteFiscalV40_InformacionGlobal.Get_Periodicidad: UnicodeString;
begin
  Result := AttributeNodes['Periodicidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_InformacionGlobal.Set_Periodicidad(Value: UnicodeString);
begin
  SetAttribute('Periodicidad', Value);
end;

function TXMLIComprobanteFiscalV40_InformacionGlobal.Get_Meses: UnicodeString;
begin
  Result := AttributeNodes['Meses'].Text;
end;

procedure TXMLIComprobanteFiscalV40_InformacionGlobal.Set_Meses(Value: UnicodeString);
begin
  SetAttribute('Meses', Value);
end;

function TXMLIComprobanteFiscalV40_InformacionGlobal.Get_Año: SmallInt;
begin
  Result := AttributeNodes['Año'].NodeValue;
end;

procedure TXMLIComprobanteFiscalV40_InformacionGlobal.Set_Año(Value: SmallInt);
begin
  SetAttribute('Año', Value);
end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionados }

procedure TXMLIComprobanteFiscalV40_CfdiRelacionados.AfterConstruction;
begin
  RegisterChildNode('CfdiRelacionado', TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado);
  ItemTag := 'CfdiRelacionado';
  ItemInterface := IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
  inherited;
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionados.Get_TipoRelacion: UnicodeString;
begin
  Result := AttributeNodes['TipoRelacion'].Text;
end;

procedure TXMLIComprobanteFiscalV40_CfdiRelacionados.Set_TipoRelacion(Value: UnicodeString);
begin
  SetAttribute('TipoRelacion', Value);
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionados.Get_CfdiRelacionado(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
begin
  Result := List[Index] as IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionados.Add: IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionados.Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado;
end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionadosList }

function TXMLIComprobanteFiscalV40_CfdiRelacionadosList.Add: IComprobanteFiscalV40_CfdiRelacionados;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_CfdiRelacionados;
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionadosList.Insert(const Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_CfdiRelacionados;
end;

function TXMLIComprobanteFiscalV40_CfdiRelacionadosList.Get_Item(Index: Integer): IComprobanteFiscalV40_CfdiRelacionados;
begin
  Result := List[Index] as IComprobanteFiscalV40_CfdiRelacionados;
end;

{ TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado }

function TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TXMLIComprobanteFiscalV40_CfdiRelacionados_CfdiRelacionado.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

{ TXMLIComprobanteFiscalV40_Emisor }

function TXMLIComprobanteFiscalV40_Emisor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['Rfc'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Emisor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('Rfc', Value);
end;

function TXMLIComprobanteFiscalV40_Emisor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Emisor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TXMLIComprobanteFiscalV40_Emisor.Get_RegimenFiscal: UnicodeString;
begin
  Result := AttributeNodes['RegimenFiscal'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Emisor.Set_RegimenFiscal(Value: UnicodeString);
begin
  SetAttribute('RegimenFiscal', Value);
end;

function TXMLIComprobanteFiscalV40_Emisor.Get_FacAtrAdquirente: UnicodeString;
begin
  Result := AttributeNodes['FacAtrAdquirente'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Emisor.Set_FacAtrAdquirente(Value: UnicodeString);
begin
  SetAttribute('FacAtrAdquirente', Value);
end;

{ TXMLIComprobanteFiscalV40_Receptor }

function TXMLIComprobanteFiscalV40_Receptor.Get_Rfc: UnicodeString;
begin
  Result := AttributeNodes['Rfc'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_Rfc(Value: UnicodeString);
begin
  SetAttribute('Rfc', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_DomicilioFiscalReceptor: UnicodeString;
begin
  Result := AttributeNodes['DomicilioFiscalReceptor'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_DomicilioFiscalReceptor(Value: UnicodeString);
begin
  SetAttribute('DomicilioFiscalReceptor', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_ResidenciaFiscal: UnicodeString;
begin
  Result := AttributeNodes['ResidenciaFiscal'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_ResidenciaFiscal(Value: UnicodeString);
begin
  SetAttribute('ResidenciaFiscal', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_RegimenFiscalReceptor: UnicodeString;
begin
  Result := AttributeNodes['RegimenFiscalReceptor'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_RegimenFiscalReceptor(Value: UnicodeString);
begin
  SetAttribute('RegimenFiscalReceptor', Value);
end;

function TXMLIComprobanteFiscalV40_Receptor.Get_UsoCFDI: UnicodeString;
begin
  Result := AttributeNodes['UsoCFDI'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Receptor.Set_UsoCFDI(Value: UnicodeString);
begin
  SetAttribute('UsoCFDI', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos }

procedure TXMLIComprobanteFiscalV40_Conceptos.AfterConstruction;
begin
  RegisterChildNode('Concepto', TXMLIComprobanteFiscalV40_Conceptos_Concepto);
  ItemTag := 'Concepto';
  ItemInterface := IComprobanteFiscalV40_Conceptos_Concepto;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos.Get_Concepto(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto;
end;

function TXMLIComprobanteFiscalV40_Conceptos.Add: IComprobanteFiscalV40_Conceptos_Concepto;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto;
end;

function TXMLIComprobanteFiscalV40_Conceptos.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto }

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.AfterConstruction;
begin
  RegisterChildNode('Impuestos', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos);
  RegisterChildNode('ACuentaTerceros', TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros);
  RegisterChildNode('InformacionAduanera', TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera);
  RegisterChildNode('CuentaPredial', TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial);
  RegisterChildNode('ComplementoConcepto', TXMLIComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto);
  RegisterChildNode('Parte', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte);
  FInformacionAduanera := CreateCollection(TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList, IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera, 'InformacionAduanera') as IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList;
  FCuentaPredial := CreateCollection(TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList, IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial, 'CuentaPredial') as IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList;
  FParte := CreateCollection(TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList, IComprobanteFiscalV40_Conceptos_Concepto_Parte, 'Parte') as IComprobanteFiscalV40_Conceptos_Concepto_ParteList;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ClaveProdServ: UnicodeString;
begin
  Result := AttributeNodes['ClaveProdServ'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_ClaveProdServ(Value: UnicodeString);
begin
  SetAttribute('ClaveProdServ', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['Cantidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('Cantidad', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ClaveUnidad: UnicodeString;
begin
  Result := AttributeNodes['ClaveUnidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_ClaveUnidad(Value: UnicodeString);
begin
  SetAttribute('ClaveUnidad', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['Unidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('Unidad', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['Descripcion'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('Descripcion', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitario'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('ValorUnitario', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Descuento: UnicodeString;
begin
  Result := AttributeNodes['Descuento'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_Descuento(Value: UnicodeString);
begin
  SetAttribute('Descuento', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ObjetoImp: UnicodeString;
begin
  Result := AttributeNodes['ObjetoImp'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto.Set_ObjetoImp(Value: UnicodeString);
begin
  SetAttribute('ObjetoImp', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Impuestos: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos;
begin
  Result := ChildNodes['Impuestos'] as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ACuentaTerceros: IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros;
begin
  Result := ChildNodes['ACuentaTerceros'] as IComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_InformacionAduanera: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList;
begin
  Result := FInformacionAduanera;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_CuentaPredial: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList;
begin
  Result := FCuentaPredial;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_ComplementoConcepto: IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto;
begin
  Result := ChildNodes['ComplementoConcepto'] as IComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto.Get_Parte: IComprobanteFiscalV40_Conceptos_Concepto_ParteList;
begin
  Result := FParte;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos }

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos.AfterConstruction;
begin
  RegisterChildNode('Traslados', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados);
  RegisterChildNode('Retenciones', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones);
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos.Get_Traslados: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados;
begin
  Result := ChildNodes['Traslados'] as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos.Get_Retenciones: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones;
begin
  Result := ChildNodes['Retenciones'] as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados }

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado);
  ItemTag := 'Traslado';
  ItemInterface := IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados.Get_Traslado(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados.Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Base: UnicodeString;
begin
  Result := AttributeNodes['Base'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Base(Value: UnicodeString);
begin
  SetAttribute('Base', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Traslados_Traslado.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones }

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion);
  ItemTag := 'Retencion';
  ItemInterface := IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones.Get_Retencion(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones.Add: IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Base: UnicodeString;
begin
  Result := AttributeNodes['Base'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Base(Value: UnicodeString);
begin
  SetAttribute('Base', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Impuestos_Retenciones_Retencion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Get_RfcACuentaTerceros: UnicodeString;
begin
  Result := AttributeNodes['RfcACuentaTerceros'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Set_RfcACuentaTerceros(Value: UnicodeString);
begin
  SetAttribute('RfcACuentaTerceros', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Get_NombreACuentaTerceros: UnicodeString;
begin
  Result := AttributeNodes['NombreACuentaTerceros'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Set_NombreACuentaTerceros(Value: UnicodeString);
begin
  SetAttribute('NombreACuentaTerceros', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Get_RegimenFiscalACuentaTerceros: UnicodeString;
begin
  Result := AttributeNodes['RegimenFiscalACuentaTerceros'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Set_RegimenFiscalACuentaTerceros(Value: UnicodeString);
begin
  SetAttribute('RegimenFiscalACuentaTerceros', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Get_DomicilioFiscalACuentaTerceros: UnicodeString;
begin
  Result := AttributeNodes['DomicilioFiscalACuentaTerceros'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_ACuentaTerceros.Set_DomicilioFiscalACuentaTerceros(Value: UnicodeString);
begin
  SetAttribute('DomicilioFiscalACuentaTerceros', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera.Get_NumeroPedimento: UnicodeString;
begin
  Result := AttributeNodes['NumeroPedimento'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera.Set_NumeroPedimento(Value: UnicodeString);
begin
  SetAttribute('NumeroPedimento', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList.Add: IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_InformacionAduaneraList.Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_InformacionAduanera;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial.Get_Numero: UnicodeString;
begin
  Result := AttributeNodes['Numero'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial.Set_Numero(Value: UnicodeString);
begin
  SetAttribute('Numero', Value);
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList.Add: IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_CuentaPredialList.Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_CuentaPredial;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ComplementoConcepto }

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte }

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.AfterConstruction;
begin
  RegisterChildNode('InformacionAduanera', TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera);
  ItemTag := 'InformacionAduanera';
  ItemInterface := IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_ClaveProdServ: UnicodeString;
begin
  Result := AttributeNodes['ClaveProdServ'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_ClaveProdServ(Value: UnicodeString);
begin
  SetAttribute('ClaveProdServ', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_Cantidad: UnicodeString;
begin
  Result := AttributeNodes['Cantidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_Cantidad(Value: UnicodeString);
begin
  SetAttribute('Cantidad', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_Unidad: UnicodeString;
begin
  Result := AttributeNodes['Unidad'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_Unidad(Value: UnicodeString);
begin
  SetAttribute('Unidad', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_Descripcion: UnicodeString;
begin
  Result := AttributeNodes['Descripcion'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_Descripcion(Value: UnicodeString);
begin
  SetAttribute('Descripcion', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_ValorUnitario: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitario'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_ValorUnitario(Value: UnicodeString);
begin
  SetAttribute('ValorUnitario', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Get_InformacionAduanera(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList.Add: IComprobanteFiscalV40_Conceptos_Concepto_Parte;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Conceptos_Concepto_Parte;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList.Insert(const Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Conceptos_Concepto_Parte;
end;

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_ParteList.Get_Item(Index: Integer): IComprobanteFiscalV40_Conceptos_Concepto_Parte;
begin
  Result := List[Index] as IComprobanteFiscalV40_Conceptos_Concepto_Parte;
end;

{ TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera }

function TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera.Get_NumeroPedimento: UnicodeString;
begin
  Result := AttributeNodes['NumeroPedimento'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Conceptos_Concepto_Parte_InformacionAduanera.Set_NumeroPedimento(Value: UnicodeString);
begin
  SetAttribute('NumeroPedimento', Value);
end;

{ TXMLIComprobanteFiscalV40_Impuestos }

procedure TXMLIComprobanteFiscalV40_Impuestos.AfterConstruction;
begin
  RegisterChildNode('Retenciones', TXMLIComprobanteFiscalV40_Impuestos_Retenciones);
  RegisterChildNode('Traslados', TXMLIComprobanteFiscalV40_Impuestos_Traslados);
  inherited;
end;

function TXMLIComprobanteFiscalV40_Impuestos.Get_TotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosRetenidos'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos.Set_TotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosRetenidos', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos.Get_TotalImpuestosTrasladados: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosTrasladados'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos.Set_TotalImpuestosTrasladados(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosTrasladados', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos.Get_Retenciones: IComprobanteFiscalV40_Impuestos_Retenciones;
begin
  Result := ChildNodes['Retenciones'] as IComprobanteFiscalV40_Impuestos_Retenciones;
end;

function TXMLIComprobanteFiscalV40_Impuestos.Get_Traslados: IComprobanteFiscalV40_Impuestos_Traslados;
begin
  Result := ChildNodes['Traslados'] as IComprobanteFiscalV40_Impuestos_Traslados;
end;

{ TXMLIComprobanteFiscalV40_Impuestos_Retenciones }

procedure TXMLIComprobanteFiscalV40_Impuestos_Retenciones.AfterConstruction;
begin
  RegisterChildNode('Retencion', TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion);
  ItemTag := 'Retencion';
  ItemInterface := IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Retenciones.Get_Retencion(Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
begin
  Result := List[Index] as IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Retenciones.Add: IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Retenciones.Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Impuestos_Retenciones_Retencion;
end;

{ TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion }

function TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Retenciones_Retencion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TXMLIComprobanteFiscalV40_Impuestos_Traslados }

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados.AfterConstruction;
begin
  RegisterChildNode('Traslado', TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado);
  ItemTag := 'Traslado';
  ItemInterface := IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
  inherited;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados.Get_Traslado(Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
begin
  Result := List[Index] as IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados.Add: IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(-1) as IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados.Insert(const Index: Integer): IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
begin
  Result := AddItem(Index) as IComprobanteFiscalV40_Impuestos_Traslados_Traslado;
end;

{ TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado }

function TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Get_Base: UnicodeString;
begin
  Result := AttributeNodes['Base'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Set_Base(Value: UnicodeString);
begin
  SetAttribute('Base', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TXMLIComprobanteFiscalV40_Impuestos_Traslados_Traslado.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TComprobanteFiscalV40_Complemento }

{ TXMLIComprobanteFiscalV40_Addenda }

{ TComprobanteFiscalV40_Complemento }

procedure TComprobanteFiscalV40_Complemento.AfterConstruction;
begin
  RegisterChildNode('TimbreFiscalDigital', TTimbreFiscalDigitalV33,
                    Facturacion.TimbreFiscalDigitalV33.TargetNamespace);
  inherited;
end;

function TComprobanteFiscalV40_Complemento.GetTimbreFiscalDigital: ITimbreFiscalDigitalV33;
begin
   if (Self.HasChildNode('TimbreFiscalDigital', Facturacion.TimbreFiscalDigitalV33.TargetNamespace)) then
    Result := ChildNodes.FindNode('TimbreFiscalDigital', Facturacion.TimbreFiscalDigitalV33.TargetNamespace) As ITimbreFiscalDigitalV33
  else
    Result := nil;
end;

procedure TComprobanteFiscalV40_Complemento.SetTimbreFiscalDigital(
  const Value: ITimbreFiscalDigitalV33);
begin
  ChildNodes.Add(Value);
end;

end.