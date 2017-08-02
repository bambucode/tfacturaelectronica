
{************************************************************************************}
{                                                                                    }
{                                  XML Data Binding                                  }
{                                                                                    }
{         Generated on: 7/17/2017 14:34:24                                           }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd   }
{                                                                                    }
{************************************************************************************}

unit Facturacion.ComplementoPagoV1;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IPagosV1 = interface;
  IPagos_PagoV1 = interface;
  IPagos_Pago_DoctoRelacionadoV1 = interface;
  IPagos_Pago_DoctoRelacionadoListV1 = interface;
  IPagos_Pago_ImpuestosV1 = interface;
  IPagos_Pago_ImpuestosListV1 = interface;
  IPagos_Pago_Impuestos_RetencionesV1 = interface;
  IPagos_Pago_Impuestos_Retenciones_RetencionV1 = interface;
  IPagos_Pago_Impuestos_TrasladosV1 = interface;
  IPagos_Pago_Impuestos_Traslados_TrasladoV1 = interface;

{ IPagosV1 }

  IPagosV1 = interface(IXMLNodeCollection)
    ['{80F43009-6ED0-4BE4-9E63-5A0B2B94C81B}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_Pago(Index: Integer): IPagos_PagoV1;
    procedure Set_Version(Value: UnicodeString);
    { Methods & Properties }
    function Add: IPagos_PagoV1;
    function Insert(const Index: Integer): IPagos_PagoV1;
    property Version: UnicodeString read Get_Version write Set_Version;
    property Pago[Index: Integer]: IPagos_PagoV1 read Get_Pago; default;
  end;

{ IPagos_PagoV1 }

  IPagos_PagoV1 = interface(IXMLNode)
    ['{A1A89FC8-17A1-49B0-B471-AD66DA088845}']
    { Property Accessors }
    function Get_FechaPago: UnicodeString;
    function Get_FormaDePagoP: UnicodeString;
    function Get_MonedaP: UnicodeString;
    function Get_TipoCambioP: UnicodeString;
    function Get_Monto: UnicodeString;
    function Get_NumOperacion: UnicodeString;
    function Get_RfcEmisorCtaOrd: UnicodeString;
    function Get_NomBancoOrdExt: UnicodeString;
    function Get_CtaOrdenante: UnicodeString;
    function Get_RfcEmisorCtaBen: UnicodeString;
    function Get_CtaBeneficiario: UnicodeString;
    function Get_TipoCadPago: UnicodeString;
    function Get_CertPago: UnicodeString;
    function Get_CadPago: UnicodeString;
    function Get_SelloPago: UnicodeString;
    function Get_DoctoRelacionado: IPagos_Pago_DoctoRelacionadoListV1;
    function Get_Impuestos: IPagos_Pago_ImpuestosListV1;
    procedure Set_FechaPago(Value: UnicodeString);
    procedure Set_FormaDePagoP(Value: UnicodeString);
    procedure Set_MonedaP(Value: UnicodeString);
    procedure Set_TipoCambioP(Value: UnicodeString);
    procedure Set_Monto(Value: UnicodeString);
    procedure Set_NumOperacion(Value: UnicodeString);
    procedure Set_RfcEmisorCtaOrd(Value: UnicodeString);
    procedure Set_NomBancoOrdExt(Value: UnicodeString);
    procedure Set_CtaOrdenante(Value: UnicodeString);
    procedure Set_RfcEmisorCtaBen(Value: UnicodeString);
    procedure Set_CtaBeneficiario(Value: UnicodeString);
    procedure Set_TipoCadPago(Value: UnicodeString);
    procedure Set_CertPago(Value: UnicodeString);
    procedure Set_CadPago(Value: UnicodeString);
    procedure Set_SelloPago(Value: UnicodeString);
    { Methods & Properties }
    property FechaPago: UnicodeString read Get_FechaPago write Set_FechaPago;
    property FormaDePagoP: UnicodeString read Get_FormaDePagoP write Set_FormaDePagoP;
    property MonedaP: UnicodeString read Get_MonedaP write Set_MonedaP;
    property TipoCambioP: UnicodeString read Get_TipoCambioP write Set_TipoCambioP;
    property Monto: UnicodeString read Get_Monto write Set_Monto;
    property NumOperacion: UnicodeString read Get_NumOperacion write Set_NumOperacion;
    property RfcEmisorCtaOrd: UnicodeString read Get_RfcEmisorCtaOrd write Set_RfcEmisorCtaOrd;
    property NomBancoOrdExt: UnicodeString read Get_NomBancoOrdExt write Set_NomBancoOrdExt;
    property CtaOrdenante: UnicodeString read Get_CtaOrdenante write Set_CtaOrdenante;
    property RfcEmisorCtaBen: UnicodeString read Get_RfcEmisorCtaBen write Set_RfcEmisorCtaBen;
    property CtaBeneficiario: UnicodeString read Get_CtaBeneficiario write Set_CtaBeneficiario;
    property TipoCadPago: UnicodeString read Get_TipoCadPago write Set_TipoCadPago;
    property CertPago: UnicodeString read Get_CertPago write Set_CertPago;
    property CadPago: UnicodeString read Get_CadPago write Set_CadPago;
    property SelloPago: UnicodeString read Get_SelloPago write Set_SelloPago;
    property DoctoRelacionado: IPagos_Pago_DoctoRelacionadoListV1 read Get_DoctoRelacionado;
    property Impuestos: IPagos_Pago_ImpuestosListV1 read Get_Impuestos;
  end;

{ IPagos_Pago_DoctoRelacionadoV1 }

  IPagos_Pago_DoctoRelacionadoV1 = interface(IXMLNode)
    ['{BF5EF19C-55AC-4950-8717-BDB5D83C99C7}']
    { Property Accessors }
    function Get_IdDocumento: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_MonedaDR: UnicodeString;
    function Get_TipoCambioDR: UnicodeString;
    function Get_MetodoDePagoDR: UnicodeString;
    function Get_NumParcialidad: Integer;
    function Get_ImpSaldoAnt: UnicodeString;
    function Get_ImpPagado: UnicodeString;
    function Get_ImpSaldoInsoluto: UnicodeString;
    procedure Set_IdDocumento(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_MonedaDR(Value: UnicodeString);
    procedure Set_TipoCambioDR(Value: UnicodeString);
    procedure Set_MetodoDePagoDR(Value: UnicodeString);
    procedure Set_NumParcialidad(Value: Integer);
    procedure Set_ImpSaldoAnt(Value: UnicodeString);
    procedure Set_ImpPagado(Value: UnicodeString);
    procedure Set_ImpSaldoInsoluto(Value: UnicodeString);
    { Methods & Properties }
    property IdDocumento: UnicodeString read Get_IdDocumento write Set_IdDocumento;
    property Serie: UnicodeString read Get_Serie write Set_Serie;
    property Folio: UnicodeString read Get_Folio write Set_Folio;
    property MonedaDR: UnicodeString read Get_MonedaDR write Set_MonedaDR;
    property TipoCambioDR: UnicodeString read Get_TipoCambioDR write Set_TipoCambioDR;
    property MetodoDePagoDR: UnicodeString read Get_MetodoDePagoDR write Set_MetodoDePagoDR;
    property NumParcialidad: Integer read Get_NumParcialidad write Set_NumParcialidad;
    property ImpSaldoAnt: UnicodeString read Get_ImpSaldoAnt write Set_ImpSaldoAnt;
    property ImpPagado: UnicodeString read Get_ImpPagado write Set_ImpPagado;
    property ImpSaldoInsoluto: UnicodeString read Get_ImpSaldoInsoluto write Set_ImpSaldoInsoluto;
  end;

{ IPagos_Pago_DoctoRelacionadoListV1 }

  IPagos_Pago_DoctoRelacionadoListV1 = interface(IXMLNodeCollection)
    ['{8D3863CB-444D-4E8E-B2FC-26213D609D65}']
    { Methods & Properties }
    function Add: IPagos_Pago_DoctoRelacionadoV1;
    function Insert(const Index: Integer): IPagos_Pago_DoctoRelacionadoV1;

    function Get_Item(Index: Integer): IPagos_Pago_DoctoRelacionadoV1;
    property Items[Index: Integer]: IPagos_Pago_DoctoRelacionadoV1 read Get_Item; default;
  end;

{ IPagos_Pago_ImpuestosV1 }

  IPagos_Pago_ImpuestosV1 = interface(IXMLNode)
    ['{6651E3A9-535C-489C-9EDC-9A9D9B11AFAB}']
    { Property Accessors }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IPagos_Pago_Impuestos_RetencionesV1;
    function Get_Traslados: IPagos_Pago_Impuestos_TrasladosV1;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
    { Methods & Properties }
    property TotalImpuestosRetenidos: UnicodeString read Get_TotalImpuestosRetenidos write Set_TotalImpuestosRetenidos;
    property TotalImpuestosTrasladados: UnicodeString read Get_TotalImpuestosTrasladados write Set_TotalImpuestosTrasladados;
    property Retenciones: IPagos_Pago_Impuestos_RetencionesV1 read Get_Retenciones;
    property Traslados: IPagos_Pago_Impuestos_TrasladosV1 read Get_Traslados;
  end;

{ IPagos_Pago_ImpuestosListV1 }

  IPagos_Pago_ImpuestosListV1 = interface(IXMLNodeCollection)
    ['{464DE912-1708-4AB5-8AD8-D03272EA2120}']
    { Methods & Properties }
    function Add: IPagos_Pago_ImpuestosV1;
    function Insert(const Index: Integer): IPagos_Pago_ImpuestosV1;

    function Get_Item(Index: Integer): IPagos_Pago_ImpuestosV1;
    property Items[Index: Integer]: IPagos_Pago_ImpuestosV1 read Get_Item; default;
  end;

{ IPagos_Pago_Impuestos_RetencionesV1 }

  IPagos_Pago_Impuestos_RetencionesV1 = interface(IXMLNodeCollection)
    ['{C3A103A2-E069-49CA-86FB-ACCA600D5C47}']
    { Property Accessors }
    function Get_Retencion(Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
    { Methods & Properties }
    function Add: IPagos_Pago_Impuestos_Retenciones_RetencionV1;
    function Insert(const Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
    property Retencion[Index: Integer]: IPagos_Pago_Impuestos_Retenciones_RetencionV1 read Get_Retencion; default;
  end;

{ IPagos_Pago_Impuestos_Retenciones_RetencionV1 }

  IPagos_Pago_Impuestos_Retenciones_RetencionV1 = interface(IXMLNode)
    ['{948FFFE0-A363-4A01-9F25-90BA6897EF17}']
    { Property Accessors }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property Impuesto: UnicodeString read Get_Impuesto write Set_Impuesto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ IPagos_Pago_Impuestos_TrasladosV1 }

  IPagos_Pago_Impuestos_TrasladosV1 = interface(IXMLNodeCollection)
    ['{B57F0216-84F6-454A-B6E3-E6CB3DC457FC}']
    { Property Accessors }
    function Get_Traslado(Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
    { Methods & Properties }
    function Add: IPagos_Pago_Impuestos_Traslados_TrasladoV1;
    function Insert(const Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
    property Traslado[Index: Integer]: IPagos_Pago_Impuestos_Traslados_TrasladoV1 read Get_Traslado; default;
  end;

{ IPagos_Pago_Impuestos_Traslados_TrasladoV1 }

  IPagos_Pago_Impuestos_Traslados_TrasladoV1 = interface(IXMLNode)
    ['{CC1E60C3-EBB9-4DD1-8ACC-83228191620C}']
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

{ Forward Decls }

  TPagosV1 = class;
  TPagos_PagoV1 = class;
  TPagos_Pago_DoctoRelacionadoV1 = class;
  TPagos_Pago_DoctoRelacionadoListV1 = class;
  TPagos_Pago_ImpuestosV1 = class;
  TPagos_Pago_ImpuestosListV1 = class;
  TPagos_Pago_Impuestos_RetencionesV1 = class;
  TPagos_Pago_Impuestos_Retenciones_RetencionV1 = class;
  TPagos_Pago_Impuestos_TrasladosV1 = class;
  TPagos_Pago_Impuestos_Traslados_TrasladoV1 = class;

{ TPagosV1 }

  TPagosV1 = class(TXMLNodeCollection, IPagosV1)
  protected
    { IPagosV1 }
    function Get_Version: UnicodeString;
    function Get_Pago(Index: Integer): IPagos_PagoV1;
    procedure Set_Version(Value: UnicodeString);
    function Add: IPagos_PagoV1;
    function Insert(const Index: Integer): IPagos_PagoV1;
  public
    procedure AfterConstruction; override;
  end;

{ TPagos_PagoV1 }

  TPagos_PagoV1 = class(TXMLNode, IPagos_PagoV1)
  private
    FDoctoRelacionado: IPagos_Pago_DoctoRelacionadoListV1;
    FImpuestos: IPagos_Pago_ImpuestosListV1;
  protected
    { IPagos_PagoV1 }
    function Get_FechaPago: UnicodeString;
    function Get_FormaDePagoP: UnicodeString;
    function Get_MonedaP: UnicodeString;
    function Get_TipoCambioP: UnicodeString;
    function Get_Monto: UnicodeString;
    function Get_NumOperacion: UnicodeString;
    function Get_RfcEmisorCtaOrd: UnicodeString;
    function Get_NomBancoOrdExt: UnicodeString;
    function Get_CtaOrdenante: UnicodeString;
    function Get_RfcEmisorCtaBen: UnicodeString;
    function Get_CtaBeneficiario: UnicodeString;
    function Get_TipoCadPago: UnicodeString;
    function Get_CertPago: UnicodeString;
    function Get_CadPago: UnicodeString;
    function Get_SelloPago: UnicodeString;
    function Get_DoctoRelacionado: IPagos_Pago_DoctoRelacionadoListV1;
    function Get_Impuestos: IPagos_Pago_ImpuestosListV1;
    procedure Set_FechaPago(Value: UnicodeString);
    procedure Set_FormaDePagoP(Value: UnicodeString);
    procedure Set_MonedaP(Value: UnicodeString);
    procedure Set_TipoCambioP(Value: UnicodeString);
    procedure Set_Monto(Value: UnicodeString);
    procedure Set_NumOperacion(Value: UnicodeString);
    procedure Set_RfcEmisorCtaOrd(Value: UnicodeString);
    procedure Set_NomBancoOrdExt(Value: UnicodeString);
    procedure Set_CtaOrdenante(Value: UnicodeString);
    procedure Set_RfcEmisorCtaBen(Value: UnicodeString);
    procedure Set_CtaBeneficiario(Value: UnicodeString);
    procedure Set_TipoCadPago(Value: UnicodeString);
    procedure Set_CertPago(Value: UnicodeString);
    procedure Set_CadPago(Value: UnicodeString);
    procedure Set_SelloPago(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TPagos_Pago_DoctoRelacionadoV1 }

  TPagos_Pago_DoctoRelacionadoV1 = class(TXMLNode, IPagos_Pago_DoctoRelacionadoV1)
  protected
    { IPagos_Pago_DoctoRelacionadoV1 }
    function Get_IdDocumento: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_MonedaDR: UnicodeString;
    function Get_TipoCambioDR: UnicodeString;
    function Get_MetodoDePagoDR: UnicodeString;
    function Get_NumParcialidad: Integer;
    function Get_ImpSaldoAnt: UnicodeString;
    function Get_ImpPagado: UnicodeString;
    function Get_ImpSaldoInsoluto: UnicodeString;
    procedure Set_IdDocumento(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_MonedaDR(Value: UnicodeString);
    procedure Set_TipoCambioDR(Value: UnicodeString);
    procedure Set_MetodoDePagoDR(Value: UnicodeString);
    procedure Set_NumParcialidad(Value: Integer);
    procedure Set_ImpSaldoAnt(Value: UnicodeString);
    procedure Set_ImpPagado(Value: UnicodeString);
    procedure Set_ImpSaldoInsoluto(Value: UnicodeString);
  end;

{ TPagos_Pago_DoctoRelacionadoListV1 }

  TPagos_Pago_DoctoRelacionadoListV1 = class(TXMLNodeCollection, IPagos_Pago_DoctoRelacionadoListV1)
  protected
    { IPagos_Pago_DoctoRelacionadoListV1 }
    function Add: IPagos_Pago_DoctoRelacionadoV1;
    function Insert(const Index: Integer): IPagos_Pago_DoctoRelacionadoV1;

    function Get_Item(Index: Integer): IPagos_Pago_DoctoRelacionadoV1;
  end;

{ TPagos_Pago_ImpuestosV1 }

  TPagos_Pago_ImpuestosV1 = class(TXMLNode, IPagos_Pago_ImpuestosV1)
  protected
    { IPagos_Pago_ImpuestosV1 }
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_TotalImpuestosTrasladados: UnicodeString;
    function Get_Retenciones: IPagos_Pago_Impuestos_RetencionesV1;
    function Get_Traslados: IPagos_Pago_Impuestos_TrasladosV1;
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    procedure Set_TotalImpuestosTrasladados(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TPagos_Pago_ImpuestosListV1 }

  TPagos_Pago_ImpuestosListV1 = class(TXMLNodeCollection, IPagos_Pago_ImpuestosListV1)
  protected
    { IPagos_Pago_ImpuestosListV1 }
    function Add: IPagos_Pago_ImpuestosV1;
    function Insert(const Index: Integer): IPagos_Pago_ImpuestosV1;

    function Get_Item(Index: Integer): IPagos_Pago_ImpuestosV1;
  end;

{ TPagos_Pago_Impuestos_RetencionesV1 }

  TPagos_Pago_Impuestos_RetencionesV1 = class(TXMLNodeCollection, IPagos_Pago_Impuestos_RetencionesV1)
  protected
    { IPagos_Pago_Impuestos_RetencionesV1 }
    function Get_Retencion(Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
    function Add: IPagos_Pago_Impuestos_Retenciones_RetencionV1;
    function Insert(const Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
  public
    procedure AfterConstruction; override;
  end;

{ TPagos_Pago_Impuestos_Retenciones_RetencionV1 }

  TPagos_Pago_Impuestos_Retenciones_RetencionV1 = class(TXMLNode, IPagos_Pago_Impuestos_Retenciones_RetencionV1)
  protected
    { IPagos_Pago_Impuestos_Retenciones_RetencionV1 }
    function Get_Impuesto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TPagos_Pago_Impuestos_TrasladosV1 }

  TPagos_Pago_Impuestos_TrasladosV1 = class(TXMLNodeCollection, IPagos_Pago_Impuestos_TrasladosV1)
  protected
    { IPagos_Pago_Impuestos_TrasladosV1 }
    function Get_Traslado(Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
    function Add: IPagos_Pago_Impuestos_Traslados_TrasladoV1;
    function Insert(const Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
  public
    procedure AfterConstruction; override;
  end;

{ TPagos_Pago_Impuestos_Traslados_TrasladoV1 }

  TPagos_Pago_Impuestos_Traslados_TrasladoV1 = class(TXMLNode, IPagos_Pago_Impuestos_Traslados_TrasladoV1)
  protected
    { IPagos_Pago_Impuestos_Traslados_TrasladoV1 }
    function Get_Impuesto: UnicodeString;
    function Get_TipoFactor: UnicodeString;
    function Get_TasaOCuota: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_Impuesto(Value: UnicodeString);
    procedure Set_TipoFactor(Value: UnicodeString);
    procedure Set_TasaOCuota(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ Global Functions }

function GetComplementoPagoV1(Doc: IXMLDocument): IPagosV1;
function LoadComplementoPagoV1(const FileName: string): IPagosV1;
function NewComplementoPagoV1: IPagosV1;

const
  TargetNamespace = 'http://www.sat.gob.mx/Pagos';

implementation

uses System.SysUtils,
     Facturacion.Helper,
     Facturacion.ComprobanteV33;

{ Global Functions }

function GetComplementoPagoV1(Doc: IXMLDocument): IPagosV1;
begin
  Result := Doc.GetDocBinding('pago10:Pagos', TPagosV1, TargetNamespace) as IPagosV1;
end;

function LoadComplementoPagoV1(const FileName: string): IPagosV1;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('pago10:Pagos', TPagosV1, TargetNamespace) as IPagosV1;
end;

function NewComplementoPagoV1: IPagosV1;
begin
  Result := NewXMLDocument.GetDocBinding('pago10:Pagos', TPagosV1, TargetNamespace) as IPagosV1;
end;

{ TPagosV1 }

procedure TPagosV1.AfterConstruction;
begin
   if (Self.AttributeNodes.FindNode('version') = nil) then
    Self.Set_Version('1.0');

  RegisterChildNode('Pago', TPagos_PagoV1);
  ItemTag := 'Pago';
  ItemInterface := IPagos_PagoV1;
  inherited;
end;

function TPagosV1.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TPagosV1.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TPagosV1.Get_Pago(Index: Integer): IPagos_PagoV1;
begin
  Result := List[Index] as IPagos_PagoV1;
end;

function TPagosV1.Add: IPagos_PagoV1;
begin
  Result := AddItem(-1) as IPagos_PagoV1;
end;

function TPagosV1.Insert(const Index: Integer): IPagos_PagoV1;
begin
  Result := AddItem(Index) as IPagos_PagoV1;
end;

{ TPagos_PagoV1 }

procedure TPagos_PagoV1.AfterConstruction;
begin
  RegisterChildNode('DoctoRelacionado', TPagos_Pago_DoctoRelacionadoV1);
  RegisterChildNode('Impuestos', TPagos_Pago_ImpuestosV1);
  FDoctoRelacionado := CreateCollection(TPagos_Pago_DoctoRelacionadoListV1, IPagos_Pago_DoctoRelacionadoV1, 'DoctoRelacionado') as IPagos_Pago_DoctoRelacionadoListV1;
  FImpuestos := CreateCollection(TPagos_Pago_ImpuestosListV1, IPagos_Pago_ImpuestosV1, 'Impuestos') as IPagos_Pago_ImpuestosListV1;
  inherited;
end;

function TPagos_PagoV1.Get_FechaPago: UnicodeString;
begin
  Result := AttributeNodes['FechaPago'].Text;
end;

procedure TPagos_PagoV1.Set_FechaPago(Value: UnicodeString);
begin
  SetAttribute('FechaPago', Value);
end;

function TPagos_PagoV1.Get_FormaDePagoP: UnicodeString;
begin
  Result := AttributeNodes['FormaDePagoP'].Text;
end;

procedure TPagos_PagoV1.Set_FormaDePagoP(Value: UnicodeString);
begin
  SetAttribute('FormaDePagoP', Value);
end;

function TPagos_PagoV1.Get_MonedaP: UnicodeString;
begin
  Result := AttributeNodes['MonedaP'].Text;
end;

procedure TPagos_PagoV1.Set_MonedaP(Value: UnicodeString);
begin
  SetAttribute('MonedaP', Value);
end;

function TPagos_PagoV1.Get_TipoCambioP: UnicodeString;
begin
  Result := AttributeNodes['TipoCambioP'].Text;
end;

procedure TPagos_PagoV1.Set_TipoCambioP(Value: UnicodeString);
begin
  SetAttribute('TipoCambioP', Value);
end;

function TPagos_PagoV1.Get_Monto: UnicodeString;
begin
  Result := AttributeNodes['Monto'].Text;
end;

procedure TPagos_PagoV1.Set_Monto(Value: UnicodeString);
begin
  SetAttribute('Monto', Value);
end;

function TPagos_PagoV1.Get_NumOperacion: UnicodeString;
begin
  Result := AttributeNodes['NumOperacion'].Text;
end;

procedure TPagos_PagoV1.Set_NumOperacion(Value: UnicodeString);
begin
  SetAttribute('NumOperacion', Value);
end;

function TPagos_PagoV1.Get_RfcEmisorCtaOrd: UnicodeString;
begin
  Result := AttributeNodes['RfcEmisorCtaOrd'].Text;
end;

procedure TPagos_PagoV1.Set_RfcEmisorCtaOrd(Value: UnicodeString);
begin
  SetAttribute('RfcEmisorCtaOrd', Value);
end;

function TPagos_PagoV1.Get_NomBancoOrdExt: UnicodeString;
begin
  Result := AttributeNodes['NomBancoOrdExt'].Text;
end;

procedure TPagos_PagoV1.Set_NomBancoOrdExt(Value: UnicodeString);
begin
  SetAttribute('NomBancoOrdExt', Value);
end;

function TPagos_PagoV1.Get_CtaOrdenante: UnicodeString;
begin
  Result := AttributeNodes['CtaOrdenante'].Text;
end;

procedure TPagos_PagoV1.Set_CtaOrdenante(Value: UnicodeString);
begin
  SetAttribute('CtaOrdenante', Value);
end;

function TPagos_PagoV1.Get_RfcEmisorCtaBen: UnicodeString;
begin
  Result := AttributeNodes['RfcEmisorCtaBen'].Text;
end;

procedure TPagos_PagoV1.Set_RfcEmisorCtaBen(Value: UnicodeString);
begin
  SetAttribute('RfcEmisorCtaBen', Value);
end;

function TPagos_PagoV1.Get_CtaBeneficiario: UnicodeString;
begin
  Result := AttributeNodes['CtaBeneficiario'].Text;
end;

procedure TPagos_PagoV1.Set_CtaBeneficiario(Value: UnicodeString);
begin
  SetAttribute('CtaBeneficiario', Value);
end;

function TPagos_PagoV1.Get_TipoCadPago: UnicodeString;
begin
  Result := AttributeNodes['TipoCadPago'].Text;
end;

procedure TPagos_PagoV1.Set_TipoCadPago(Value: UnicodeString);
begin
  SetAttribute('TipoCadPago', Value);
end;

function TPagos_PagoV1.Get_CertPago: UnicodeString;
begin
  Result := AttributeNodes['CertPago'].Text;
end;

procedure TPagos_PagoV1.Set_CertPago(Value: UnicodeString);
begin
  SetAttribute('CertPago', Value);
end;

function TPagos_PagoV1.Get_CadPago: UnicodeString;
begin
  Result := AttributeNodes['CadPago'].Text;
end;

procedure TPagos_PagoV1.Set_CadPago(Value: UnicodeString);
begin
  SetAttribute('CadPago', Value);
end;

function TPagos_PagoV1.Get_SelloPago: UnicodeString;
begin
  Result := AttributeNodes['SelloPago'].Text;
end;

procedure TPagos_PagoV1.Set_SelloPago(Value: UnicodeString);
begin
  SetAttribute('SelloPago', Value);
end;

function TPagos_PagoV1.Get_DoctoRelacionado: IPagos_Pago_DoctoRelacionadoListV1;
begin
  Result := FDoctoRelacionado;
end;

function TPagos_PagoV1.Get_Impuestos: IPagos_Pago_ImpuestosListV1;
begin
  Result := FImpuestos;
end;

{ TPagos_Pago_DoctoRelacionadoV1 }

function TPagos_Pago_DoctoRelacionadoV1.Get_IdDocumento: UnicodeString;
begin
  Result := AttributeNodes['IdDocumento'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_IdDocumento(Value: UnicodeString);
begin
  SetAttribute('IdDocumento', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_Serie: UnicodeString;
begin
  Result := AttributeNodes['Serie'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_Serie(Value: UnicodeString);
begin
  SetAttribute('Serie', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_Folio: UnicodeString;
begin
  Result := AttributeNodes['Folio'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_Folio(Value: UnicodeString);
begin
  SetAttribute('Folio', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_MonedaDR: UnicodeString;
begin
  Result := AttributeNodes['MonedaDR'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_MonedaDR(Value: UnicodeString);
begin
  SetAttribute('MonedaDR', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_TipoCambioDR: UnicodeString;
begin
  Result := AttributeNodes['TipoCambioDR'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_TipoCambioDR(Value: UnicodeString);
begin
  SetAttribute('TipoCambioDR', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_MetodoDePagoDR: UnicodeString;
begin
  Result := AttributeNodes['MetodoDePagoDR'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_MetodoDePagoDR(Value: UnicodeString);
begin
  SetAttribute('MetodoDePagoDR', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_NumParcialidad: Integer;
begin
  Result := AttributeNodes['NumParcialidad'].NodeValue;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_NumParcialidad(Value: Integer);
begin
  SetAttribute('NumParcialidad', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_ImpSaldoAnt: UnicodeString;
begin
  Result := AttributeNodes['ImpSaldoAnt'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_ImpSaldoAnt(Value: UnicodeString);
begin
  SetAttribute('ImpSaldoAnt', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_ImpPagado: UnicodeString;
begin
  Result := AttributeNodes['ImpPagado'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_ImpPagado(Value: UnicodeString);
begin
  SetAttribute('ImpPagado', Value);
end;

function TPagos_Pago_DoctoRelacionadoV1.Get_ImpSaldoInsoluto: UnicodeString;
begin
  Result := AttributeNodes['ImpSaldoInsoluto'].Text;
end;

procedure TPagos_Pago_DoctoRelacionadoV1.Set_ImpSaldoInsoluto(Value: UnicodeString);
begin
  SetAttribute('ImpSaldoInsoluto', Value);
end;

{ TPagos_Pago_DoctoRelacionadoListV1 }

function TPagos_Pago_DoctoRelacionadoListV1.Add: IPagos_Pago_DoctoRelacionadoV1;
begin
  Result := AddItem(-1) as IPagos_Pago_DoctoRelacionadoV1;
end;

function TPagos_Pago_DoctoRelacionadoListV1.Insert(const Index: Integer): IPagos_Pago_DoctoRelacionadoV1;
begin
  Result := AddItem(Index) as IPagos_Pago_DoctoRelacionadoV1;
end;

function TPagos_Pago_DoctoRelacionadoListV1.Get_Item(Index: Integer): IPagos_Pago_DoctoRelacionadoV1;
begin
  Result := List[Index] as IPagos_Pago_DoctoRelacionadoV1;
end;

{ TPagos_Pago_ImpuestosV1 }

procedure TPagos_Pago_ImpuestosV1.AfterConstruction;
begin
  RegisterChildNode('Retenciones', TPagos_Pago_Impuestos_RetencionesV1);
  RegisterChildNode('Traslados', TPagos_Pago_Impuestos_TrasladosV1);
  inherited;
end;

function TPagos_Pago_ImpuestosV1.Get_TotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosRetenidos'].Text;
end;

procedure TPagos_Pago_ImpuestosV1.Set_TotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosRetenidos', Value);
end;

function TPagos_Pago_ImpuestosV1.Get_TotalImpuestosTrasladados: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosTrasladados'].Text;
end;

procedure TPagos_Pago_ImpuestosV1.Set_TotalImpuestosTrasladados(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosTrasladados', Value);
end;

function TPagos_Pago_ImpuestosV1.Get_Retenciones: IPagos_Pago_Impuestos_RetencionesV1;
begin
  Result := ChildNodes['Retenciones'] as IPagos_Pago_Impuestos_RetencionesV1;
end;

function TPagos_Pago_ImpuestosV1.Get_Traslados: IPagos_Pago_Impuestos_TrasladosV1;
begin
  Result := ChildNodes['Traslados'] as IPagos_Pago_Impuestos_TrasladosV1;
end;

{ TPagos_Pago_ImpuestosListV1 }

function TPagos_Pago_ImpuestosListV1.Add: IPagos_Pago_ImpuestosV1;
begin
  Result := AddItem(-1) as IPagos_Pago_ImpuestosV1;
end;

function TPagos_Pago_ImpuestosListV1.Insert(const Index: Integer): IPagos_Pago_ImpuestosV1;
begin
  Result := AddItem(Index) as IPagos_Pago_ImpuestosV1;
end;

function TPagos_Pago_ImpuestosListV1.Get_Item(Index: Integer): IPagos_Pago_ImpuestosV1;
begin
  Result := List[Index] as IPagos_Pago_ImpuestosV1;
end;

{ TPagos_Pago_Impuestos_RetencionesV1 }

procedure TPagos_Pago_Impuestos_RetencionesV1.AfterConstruction;
begin
  RegisterChildNode('Retencion', TPagos_Pago_Impuestos_Retenciones_RetencionV1);
  ItemTag := 'Retencion';
  ItemInterface := IPagos_Pago_Impuestos_Retenciones_RetencionV1;
  inherited;
end;

function TPagos_Pago_Impuestos_RetencionesV1.Get_Retencion(Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
begin
  Result := List[Index] as IPagos_Pago_Impuestos_Retenciones_RetencionV1;
end;

function TPagos_Pago_Impuestos_RetencionesV1.Add: IPagos_Pago_Impuestos_Retenciones_RetencionV1;
begin
  Result := AddItem(-1) as IPagos_Pago_Impuestos_Retenciones_RetencionV1;
end;

function TPagos_Pago_Impuestos_RetencionesV1.Insert(const Index: Integer): IPagos_Pago_Impuestos_Retenciones_RetencionV1;
begin
  Result := AddItem(Index) as IPagos_Pago_Impuestos_Retenciones_RetencionV1;
end;

{ TPagos_Pago_Impuestos_Retenciones_RetencionV1 }

function TPagos_Pago_Impuestos_Retenciones_RetencionV1.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TPagos_Pago_Impuestos_Retenciones_RetencionV1.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TPagos_Pago_Impuestos_Retenciones_RetencionV1.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TPagos_Pago_Impuestos_Retenciones_RetencionV1.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TPagos_Pago_Impuestos_TrasladosV1 }

procedure TPagos_Pago_Impuestos_TrasladosV1.AfterConstruction;
begin
  RegisterChildNode('Traslado', TPagos_Pago_Impuestos_Traslados_TrasladoV1);
  ItemTag := 'Traslado';
  ItemInterface := IPagos_Pago_Impuestos_Traslados_TrasladoV1;
  inherited;
end;

function TPagos_Pago_Impuestos_TrasladosV1.Get_Traslado(Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
begin
  Result := List[Index] as IPagos_Pago_Impuestos_Traslados_TrasladoV1;
end;

function TPagos_Pago_Impuestos_TrasladosV1.Add: IPagos_Pago_Impuestos_Traslados_TrasladoV1;
begin
  Result := AddItem(-1) as IPagos_Pago_Impuestos_Traslados_TrasladoV1;
end;

function TPagos_Pago_Impuestos_TrasladosV1.Insert(const Index: Integer): IPagos_Pago_Impuestos_Traslados_TrasladoV1;
begin
  Result := AddItem(Index) as IPagos_Pago_Impuestos_Traslados_TrasladoV1;
end;

{ TPagos_Pago_Impuestos_Traslados_TrasladoV1 }

function TPagos_Pago_Impuestos_Traslados_TrasladoV1.Get_Impuesto: UnicodeString;
begin
  Result := AttributeNodes['Impuesto'].Text;
end;

procedure TPagos_Pago_Impuestos_Traslados_TrasladoV1.Set_Impuesto(Value: UnicodeString);
begin
  SetAttribute('Impuesto', Value);
end;

function TPagos_Pago_Impuestos_Traslados_TrasladoV1.Get_TipoFactor: UnicodeString;
begin
  Result := AttributeNodes['TipoFactor'].Text;
end;

procedure TPagos_Pago_Impuestos_Traslados_TrasladoV1.Set_TipoFactor(Value: UnicodeString);
begin
  SetAttribute('TipoFactor', Value);
end;

function TPagos_Pago_Impuestos_Traslados_TrasladoV1.Get_TasaOCuota: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuota'].Text;
end;

procedure TPagos_Pago_Impuestos_Traslados_TrasladoV1.Set_TasaOCuota(Value: UnicodeString);
begin
  SetAttribute('TasaOCuota', Value);
end;

function TPagos_Pago_Impuestos_Traslados_TrasladoV1.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TPagos_Pago_Impuestos_Traslados_TrasladoV1.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

end.