
{************************************************************************************}
{                                                                                    }
{                                  XML Data Binding                                  }
{                                                                                    }
{         Generated on: 06/01/2022 11:13:04 a. m.                                    }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd   }
{   Settings stored in: C:\Delphi\tfacturaelectronica\Schemas\4.0\Pagos20-bindings   }
{                                                                                    }
{************************************************************************************}

unit Facturacion.ComplementoPagoV2;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IPagosV20 = interface;
  IPagosV20_Totales = interface;
  IPagosV20_Pago = interface;
  IPagosV20_PagoList = interface;
  IPagosV20_Pago_DoctoRelacionado = interface;
  IPagosV20_Pago_DoctoRelacionadoList = interface;
  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR = interface;
  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR = interface;
  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR = interface;
  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR = interface;
  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR = interface;
  IPagosV20_Pago_ImpuestosP = interface;
  IPagosV20_Pago_ImpuestosP_RetencionesP = interface;
  IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP = interface;
  IPagosV20_Pago_ImpuestosP_TrasladosP = interface;
  IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP = interface;

{ IPagosV20 }

  IPagosV20 = interface(IXMLNode)
    ['{C5BB2899-91D1-4C71-AD13-25CAA19A4F30}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_Totales: IPagosV20_Totales;
    function Get_Pago: IPagosV20_PagoList;
    procedure Set_Version(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property Totales: IPagosV20_Totales read Get_Totales;
    property Pago: IPagosV20_PagoList read Get_Pago;
  end;

{ IPagosV20_Totales }

  IPagosV20_Totales = interface(IXMLNode)
    ['{B8986BB6-7BCB-498C-8C03-315220C8A049}']
    { Property Accessors }
    function Get_TotalRetencionesIVA: UnicodeString;
    function Get_TotalRetencionesISR: UnicodeString;
    function Get_TotalRetencionesIEPS: UnicodeString;
    function Get_TotalTrasladosBaseIVA16: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA16: UnicodeString;
    function Get_TotalTrasladosBaseIVA8: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA8: UnicodeString;
    function Get_TotalTrasladosBaseIVA0: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA0: UnicodeString;
    function Get_TotalTrasladosBaseIVAExento: UnicodeString;
    function Get_MontoTotalPagos: UnicodeString;
    procedure Set_TotalRetencionesIVA(Value: UnicodeString);
    procedure Set_TotalRetencionesISR(Value: UnicodeString);
    procedure Set_TotalRetencionesIEPS(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA16(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA16(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA8(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA8(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA0(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA0(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVAExento(Value: UnicodeString);
    procedure Set_MontoTotalPagos(Value: UnicodeString);
    { Methods & Properties }
    property TotalRetencionesIVA: UnicodeString read Get_TotalRetencionesIVA write Set_TotalRetencionesIVA;
    property TotalRetencionesISR: UnicodeString read Get_TotalRetencionesISR write Set_TotalRetencionesISR;
    property TotalRetencionesIEPS: UnicodeString read Get_TotalRetencionesIEPS write Set_TotalRetencionesIEPS;
    property TotalTrasladosBaseIVA16: UnicodeString read Get_TotalTrasladosBaseIVA16 write Set_TotalTrasladosBaseIVA16;
    property TotalTrasladosImpuestoIVA16: UnicodeString read Get_TotalTrasladosImpuestoIVA16 write Set_TotalTrasladosImpuestoIVA16;
    property TotalTrasladosBaseIVA8: UnicodeString read Get_TotalTrasladosBaseIVA8 write Set_TotalTrasladosBaseIVA8;
    property TotalTrasladosImpuestoIVA8: UnicodeString read Get_TotalTrasladosImpuestoIVA8 write Set_TotalTrasladosImpuestoIVA8;
    property TotalTrasladosBaseIVA0: UnicodeString read Get_TotalTrasladosBaseIVA0 write Set_TotalTrasladosBaseIVA0;
    property TotalTrasladosImpuestoIVA0: UnicodeString read Get_TotalTrasladosImpuestoIVA0 write Set_TotalTrasladosImpuestoIVA0;
    property TotalTrasladosBaseIVAExento: UnicodeString read Get_TotalTrasladosBaseIVAExento write Set_TotalTrasladosBaseIVAExento;
    property MontoTotalPagos: UnicodeString read Get_MontoTotalPagos write Set_MontoTotalPagos;
  end;

{ IPagosV20_Pago }

  IPagosV20_Pago = interface(IXMLNode)
    ['{B4B70E26-DC89-474E-87F2-8E7F719D5921}']
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
    function Get_DoctoRelacionado: IPagosV20_Pago_DoctoRelacionadoList;
    function Get_ImpuestosP: IPagosV20_Pago_ImpuestosP;
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
    property DoctoRelacionado: IPagosV20_Pago_DoctoRelacionadoList read Get_DoctoRelacionado;
    property ImpuestosP: IPagosV20_Pago_ImpuestosP read Get_ImpuestosP;
  end;

{ IPagosV20_PagoList }

  IPagosV20_PagoList = interface(IXMLNodeCollection)
    ['{A5A1B644-C501-403B-959A-0C436E7D3085}']
    { Methods & Properties }
    function Add: IPagosV20_Pago;
    function Insert(const Index: Integer): IPagosV20_Pago;

    function Get_Item(Index: Integer): IPagosV20_Pago;
    property Items[Index: Integer]: IPagosV20_Pago read Get_Item; default;
  end;

{ IPagosV20_Pago_DoctoRelacionado }

  IPagosV20_Pago_DoctoRelacionado = interface(IXMLNode)
    ['{EC25C2EF-1D66-4940-AF72-F054F99F26A1}']
    { Property Accessors }
    function Get_IdDocumento: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_MonedaDR: UnicodeString;
    function Get_EquivalenciaDR: UnicodeString;
    function Get_NumParcialidad: Integer;
    function Get_ImpSaldoAnt: UnicodeString;
    function Get_ImpPagado: UnicodeString;
    function Get_ImpSaldoInsoluto: UnicodeString;
    function Get_ObjetoImpDR: UnicodeString;
    function Get_ImpuestosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR;
    procedure Set_IdDocumento(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_MonedaDR(Value: UnicodeString);
    procedure Set_EquivalenciaDR(Value: UnicodeString);
    procedure Set_NumParcialidad(Value: Integer);
    procedure Set_ImpSaldoAnt(Value: UnicodeString);
    procedure Set_ImpPagado(Value: UnicodeString);
    procedure Set_ImpSaldoInsoluto(Value: UnicodeString);
    procedure Set_ObjetoImpDR(Value: UnicodeString);
    { Methods & Properties }
    property IdDocumento: UnicodeString read Get_IdDocumento write Set_IdDocumento;
    property Serie: UnicodeString read Get_Serie write Set_Serie;
    property Folio: UnicodeString read Get_Folio write Set_Folio;
    property MonedaDR: UnicodeString read Get_MonedaDR write Set_MonedaDR;
    property EquivalenciaDR: UnicodeString read Get_EquivalenciaDR write Set_EquivalenciaDR;
    property NumParcialidad: Integer read Get_NumParcialidad write Set_NumParcialidad;
    property ImpSaldoAnt: UnicodeString read Get_ImpSaldoAnt write Set_ImpSaldoAnt;
    property ImpPagado: UnicodeString read Get_ImpPagado write Set_ImpPagado;
    property ImpSaldoInsoluto: UnicodeString read Get_ImpSaldoInsoluto write Set_ImpSaldoInsoluto;
    property ObjetoImpDR: UnicodeString read Get_ObjetoImpDR write Set_ObjetoImpDR;
    property ImpuestosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR read Get_ImpuestosDR;
  end;

{ IPagosV20_Pago_DoctoRelacionadoList }

  IPagosV20_Pago_DoctoRelacionadoList = interface(IXMLNodeCollection)
    ['{0F78D2E0-1411-4986-B62A-7298A1655169}']
    { Methods & Properties }
    function Add: IPagosV20_Pago_DoctoRelacionado;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado;

    function Get_Item(Index: Integer): IPagosV20_Pago_DoctoRelacionado;
    property Items[Index: Integer]: IPagosV20_Pago_DoctoRelacionado read Get_Item; default;
  end;

{ IPagosV20_Pago_DoctoRelacionado_ImpuestosDR }

  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR = interface(IXMLNode)
    ['{4A7E7012-793B-4470-9F61-CED6A4A6DA31}']
    { Property Accessors }
    function Get_RetencionesDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR;
    function Get_TrasladosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR;
    { Methods & Properties }
    property RetencionesDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR read Get_RetencionesDR;
    property TrasladosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR read Get_TrasladosDR;
  end;

{ IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR }

  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR = interface(IXMLNodeCollection)
    ['{642D9C08-6D4E-4272-9D28-9936CA9C9E83}']
    { Property Accessors }
    function Get_RetencionDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
    { Methods & Properties }
    function Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
    property RetencionDR[Index: Integer]: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR read Get_RetencionDR; default;
  end;

{ IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR }

  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR = interface(IXMLNode)
    ['{73681A73-655C-4980-A53B-4A4B222AF178}']
    { Property Accessors }
    function Get_BaseDR: UnicodeString;
    function Get_ImpuestoDR: UnicodeString;
    function Get_TipoFactorDR: UnicodeString;
    function Get_TasaOCuotaDR: UnicodeString;
    function Get_ImporteDR: UnicodeString;
    procedure Set_BaseDR(Value: UnicodeString);
    procedure Set_ImpuestoDR(Value: UnicodeString);
    procedure Set_TipoFactorDR(Value: UnicodeString);
    procedure Set_TasaOCuotaDR(Value: UnicodeString);
    procedure Set_ImporteDR(Value: UnicodeString);
    { Methods & Properties }
    property BaseDR: UnicodeString read Get_BaseDR write Set_BaseDR;
    property ImpuestoDR: UnicodeString read Get_ImpuestoDR write Set_ImpuestoDR;
    property TipoFactorDR: UnicodeString read Get_TipoFactorDR write Set_TipoFactorDR;
    property TasaOCuotaDR: UnicodeString read Get_TasaOCuotaDR write Set_TasaOCuotaDR;
    property ImporteDR: UnicodeString read Get_ImporteDR write Set_ImporteDR;
  end;

{ IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR }

  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR = interface(IXMLNodeCollection)
    ['{D87E562A-1F2E-472C-A90F-7F6CFF9CF80B}']
    { Property Accessors }
    function Get_TrasladoDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
    { Methods & Properties }
    function Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
    property TrasladoDR[Index: Integer]: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR read Get_TrasladoDR; default;
  end;

{ IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR }

  IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR = interface(IXMLNode)
    ['{C6859D34-B0F0-4EE9-AE99-DAE234C1EB11}']
    { Property Accessors }
    function Get_BaseDR: UnicodeString;
    function Get_ImpuestoDR: UnicodeString;
    function Get_TipoFactorDR: UnicodeString;
    function Get_TasaOCuotaDR: UnicodeString;
    function Get_ImporteDR: UnicodeString;
    procedure Set_BaseDR(Value: UnicodeString);
    procedure Set_ImpuestoDR(Value: UnicodeString);
    procedure Set_TipoFactorDR(Value: UnicodeString);
    procedure Set_TasaOCuotaDR(Value: UnicodeString);
    procedure Set_ImporteDR(Value: UnicodeString);
    { Methods & Properties }
    property BaseDR: UnicodeString read Get_BaseDR write Set_BaseDR;
    property ImpuestoDR: UnicodeString read Get_ImpuestoDR write Set_ImpuestoDR;
    property TipoFactorDR: UnicodeString read Get_TipoFactorDR write Set_TipoFactorDR;
    property TasaOCuotaDR: UnicodeString read Get_TasaOCuotaDR write Set_TasaOCuotaDR;
    property ImporteDR: UnicodeString read Get_ImporteDR write Set_ImporteDR;
  end;

{ IPagosV20_Pago_ImpuestosP }

  IPagosV20_Pago_ImpuestosP = interface(IXMLNode)
    ['{547F3026-7E9E-4EDE-8359-23B755D49822}']
    { Property Accessors }
    function Get_RetencionesP: IPagosV20_Pago_ImpuestosP_RetencionesP;
    function Get_TrasladosP: IPagosV20_Pago_ImpuestosP_TrasladosP;
    { Methods & Properties }
    property RetencionesP: IPagosV20_Pago_ImpuestosP_RetencionesP read Get_RetencionesP;
    property TrasladosP: IPagosV20_Pago_ImpuestosP_TrasladosP read Get_TrasladosP;
  end;

{ IPagosV20_Pago_ImpuestosP_RetencionesP }

  IPagosV20_Pago_ImpuestosP_RetencionesP = interface(IXMLNodeCollection)
    ['{FCB2218C-F0D4-4B4E-8BB3-729EF15ABA28}']
    { Property Accessors }
    function Get_RetencionP(Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
    { Methods & Properties }
    function Add: IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
    function Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
    property RetencionP[Index: Integer]: IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP read Get_RetencionP; default;
  end;

{ IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP }

  IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP = interface(IXMLNode)
    ['{8DD66E98-B9E2-48DA-8EA1-CF706DF5689E}']
    { Property Accessors }
    function Get_ImpuestoP: UnicodeString;
    function Get_ImporteP: UnicodeString;
    procedure Set_ImpuestoP(Value: UnicodeString);
    procedure Set_ImporteP(Value: UnicodeString);
    { Methods & Properties }
    property ImpuestoP: UnicodeString read Get_ImpuestoP write Set_ImpuestoP;
    property ImporteP: UnicodeString read Get_ImporteP write Set_ImporteP;
  end;

{ IPagosV20_Pago_ImpuestosP_TrasladosP }

  IPagosV20_Pago_ImpuestosP_TrasladosP = interface(IXMLNodeCollection)
    ['{537B071C-0DC3-477E-B276-6A21D6ED4BA0}']
    { Property Accessors }
    function Get_TrasladoP(Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
    { Methods & Properties }
    function Add: IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
    function Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
    property TrasladoP[Index: Integer]: IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP read Get_TrasladoP; default;
  end;

{ IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP }

  IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP = interface(IXMLNode)
    ['{92BE9C15-27BA-4592-93C8-161B1E2393B4}']
    { Property Accessors }
    function Get_BaseP: UnicodeString;
    function Get_ImpuestoP: UnicodeString;
    function Get_TipoFactorP: UnicodeString;
    function Get_TasaOCuotaP: UnicodeString;
    function Get_ImporteP: UnicodeString;
    procedure Set_BaseP(Value: UnicodeString);
    procedure Set_ImpuestoP(Value: UnicodeString);
    procedure Set_TipoFactorP(Value: UnicodeString);
    procedure Set_TasaOCuotaP(Value: UnicodeString);
    procedure Set_ImporteP(Value: UnicodeString);
    { Methods & Properties }
    property BaseP: UnicodeString read Get_BaseP write Set_BaseP;
    property ImpuestoP: UnicodeString read Get_ImpuestoP write Set_ImpuestoP;
    property TipoFactorP: UnicodeString read Get_TipoFactorP write Set_TipoFactorP;
    property TasaOCuotaP: UnicodeString read Get_TasaOCuotaP write Set_TasaOCuotaP;
    property ImporteP: UnicodeString read Get_ImporteP write Set_ImporteP;
  end;

{ Forward Decls }

  TPagosV20 = class;
  TPagosV20_Totales = class;
  TPagosV20_Pago = class;
  TPagosV20_PagoList = class;
  TPagosV20_Pago_DoctoRelacionado = class;
  TPagosV20_Pago_DoctoRelacionadoList = class;
  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR = class;
  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR = class;
  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR = class;
  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR = class;
  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR = class;
  TPagosV20_Pago_ImpuestosP = class;
  TPagosV20_Pago_ImpuestosP_RetencionesP = class;
  TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP = class;
  TPagosV20_Pago_ImpuestosP_TrasladosP = class;
  TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP = class;

{ TPagosV20 }

  TPagosV20 = class(TXMLNode, IPagosV20)
  private
    FPago: IPagosV20_PagoList;
  protected
    { IPagosV20 }
    function Get_Version: UnicodeString;
    function Get_Totales: IPagosV20_Totales;
    function Get_Pago: IPagosV20_PagoList;
    procedure Set_Version(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Totales }

  TPagosV20_Totales = class(TXMLNode, IPagosV20_Totales)
  protected
    { IPagosV20_Totales }
    function Get_TotalRetencionesIVA: UnicodeString;
    function Get_TotalRetencionesISR: UnicodeString;
    function Get_TotalRetencionesIEPS: UnicodeString;
    function Get_TotalTrasladosBaseIVA16: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA16: UnicodeString;
    function Get_TotalTrasladosBaseIVA8: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA8: UnicodeString;
    function Get_TotalTrasladosBaseIVA0: UnicodeString;
    function Get_TotalTrasladosImpuestoIVA0: UnicodeString;
    function Get_TotalTrasladosBaseIVAExento: UnicodeString;
    function Get_MontoTotalPagos: UnicodeString;
    procedure Set_TotalRetencionesIVA(Value: UnicodeString);
    procedure Set_TotalRetencionesISR(Value: UnicodeString);
    procedure Set_TotalRetencionesIEPS(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA16(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA16(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA8(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA8(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVA0(Value: UnicodeString);
    procedure Set_TotalTrasladosImpuestoIVA0(Value: UnicodeString);
    procedure Set_TotalTrasladosBaseIVAExento(Value: UnicodeString);
    procedure Set_MontoTotalPagos(Value: UnicodeString);
  end;

{ TPagosV20_Pago }

  TPagosV20_Pago = class(TXMLNode, IPagosV20_Pago)
  private
    FDoctoRelacionado: IPagosV20_Pago_DoctoRelacionadoList;
  protected
    { IPagosV20_Pago }
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
    function Get_DoctoRelacionado: IPagosV20_Pago_DoctoRelacionadoList;
    function Get_ImpuestosP: IPagosV20_Pago_ImpuestosP;
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

{ TPagosV20_PagoList }

  TPagosV20_PagoList = class(TXMLNodeCollection, IPagosV20_PagoList)
  protected
    { IPagosV20_PagoList }
    function Add: IPagosV20_Pago;
    function Insert(const Index: Integer): IPagosV20_Pago;

    function Get_Item(Index: Integer): IPagosV20_Pago;
  end;

{ TPagosV20_Pago_DoctoRelacionado }

  TPagosV20_Pago_DoctoRelacionado = class(TXMLNode, IPagosV20_Pago_DoctoRelacionado)
  protected
    { IPagosV20_Pago_DoctoRelacionado }
    function Get_IdDocumento: UnicodeString;
    function Get_Serie: UnicodeString;
    function Get_Folio: UnicodeString;
    function Get_MonedaDR: UnicodeString;
    function Get_EquivalenciaDR: UnicodeString;
    function Get_NumParcialidad: Integer;
    function Get_ImpSaldoAnt: UnicodeString;
    function Get_ImpPagado: UnicodeString;
    function Get_ImpSaldoInsoluto: UnicodeString;
    function Get_ObjetoImpDR: UnicodeString;
    function Get_ImpuestosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR;
    procedure Set_IdDocumento(Value: UnicodeString);
    procedure Set_Serie(Value: UnicodeString);
    procedure Set_Folio(Value: UnicodeString);
    procedure Set_MonedaDR(Value: UnicodeString);
    procedure Set_EquivalenciaDR(Value: UnicodeString);
    procedure Set_NumParcialidad(Value: Integer);
    procedure Set_ImpSaldoAnt(Value: UnicodeString);
    procedure Set_ImpPagado(Value: UnicodeString);
    procedure Set_ImpSaldoInsoluto(Value: UnicodeString);
    procedure Set_ObjetoImpDR(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_DoctoRelacionadoList }

  TPagosV20_Pago_DoctoRelacionadoList = class(TXMLNodeCollection, IPagosV20_Pago_DoctoRelacionadoList)
  protected
    { IPagosV20_Pago_DoctoRelacionadoList }
    function Add: IPagosV20_Pago_DoctoRelacionado;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado;

    function Get_Item(Index: Integer): IPagosV20_Pago_DoctoRelacionado;
  end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR }

  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR = class(TXMLNode, IPagosV20_Pago_DoctoRelacionado_ImpuestosDR)
  protected
    { IPagosV20_Pago_DoctoRelacionado_ImpuestosDR }
    function Get_RetencionesDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR;
    function Get_TrasladosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR }

  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR = class(TXMLNodeCollection, IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR)
  protected
    { IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR }
    function Get_RetencionDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
    function Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR }

  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR = class(TXMLNode, IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR)
  protected
    { IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR }
    function Get_BaseDR: UnicodeString;
    function Get_ImpuestoDR: UnicodeString;
    function Get_TipoFactorDR: UnicodeString;
    function Get_TasaOCuotaDR: UnicodeString;
    function Get_ImporteDR: UnicodeString;
    procedure Set_BaseDR(Value: UnicodeString);
    procedure Set_ImpuestoDR(Value: UnicodeString);
    procedure Set_TipoFactorDR(Value: UnicodeString);
    procedure Set_TasaOCuotaDR(Value: UnicodeString);
    procedure Set_ImporteDR(Value: UnicodeString);
  end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR }

  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR = class(TXMLNodeCollection, IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR)
  protected
    { IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR }
    function Get_TrasladoDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
    function Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
    function Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR }

  TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR = class(TXMLNode, IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR)
  protected
    { IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR }
    function Get_BaseDR: UnicodeString;
    function Get_ImpuestoDR: UnicodeString;
    function Get_TipoFactorDR: UnicodeString;
    function Get_TasaOCuotaDR: UnicodeString;
    function Get_ImporteDR: UnicodeString;
    procedure Set_BaseDR(Value: UnicodeString);
    procedure Set_ImpuestoDR(Value: UnicodeString);
    procedure Set_TipoFactorDR(Value: UnicodeString);
    procedure Set_TasaOCuotaDR(Value: UnicodeString);
    procedure Set_ImporteDR(Value: UnicodeString);
  end;

{ TPagosV20_Pago_ImpuestosP }

  TPagosV20_Pago_ImpuestosP = class(TXMLNode, IPagosV20_Pago_ImpuestosP)
  protected
    { IPagosV20_Pago_ImpuestosP }
    function Get_RetencionesP: IPagosV20_Pago_ImpuestosP_RetencionesP;
    function Get_TrasladosP: IPagosV20_Pago_ImpuestosP_TrasladosP;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_ImpuestosP_RetencionesP }

  TPagosV20_Pago_ImpuestosP_RetencionesP = class(TXMLNodeCollection, IPagosV20_Pago_ImpuestosP_RetencionesP)
  protected
    { IPagosV20_Pago_ImpuestosP_RetencionesP }
    function Get_RetencionP(Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
    function Add: IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
    function Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP }

  TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP = class(TXMLNode, IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP)
  protected
    { IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP }
    function Get_ImpuestoP: UnicodeString;
    function Get_ImporteP: UnicodeString;
    procedure Set_ImpuestoP(Value: UnicodeString);
    procedure Set_ImporteP(Value: UnicodeString);
  end;

{ TPagosV20_Pago_ImpuestosP_TrasladosP }

  TPagosV20_Pago_ImpuestosP_TrasladosP = class(TXMLNodeCollection, IPagosV20_Pago_ImpuestosP_TrasladosP)
  protected
    { IPagosV20_Pago_ImpuestosP_TrasladosP }
    function Get_TrasladoP(Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
    function Add: IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
    function Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
  public
    procedure AfterConstruction; override;
  end;

{ TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP }

  TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP = class(TXMLNode, IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP)
  protected
    { IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP }
    function Get_BaseP: UnicodeString;
    function Get_ImpuestoP: UnicodeString;
    function Get_TipoFactorP: UnicodeString;
    function Get_TasaOCuotaP: UnicodeString;
    function Get_ImporteP: UnicodeString;
    procedure Set_BaseP(Value: UnicodeString);
    procedure Set_ImpuestoP(Value: UnicodeString);
    procedure Set_TipoFactorP(Value: UnicodeString);
    procedure Set_TasaOCuotaP(Value: UnicodeString);
    procedure Set_ImporteP(Value: UnicodeString);
  end;

{ Global Functions }

function GetComplementoPagoV2(Doc: IXMLDocument): IPagosV20;
function LoadComplementoPagoV2(const FileName: string): IPagosV20;
function NewComplementoPagoV20: IPagosV20;

const
  TargetNamespace = 'http://www.sat.gob.mx/Pagos20';

implementation

uses Xml.xmlutil;

{ Global Functions }

function GetComplementoPagoV2(Doc: IXMLDocument): IPagosV20;
begin
  Result := Doc.GetDocBinding('pago20:Pagos', TPagosV20, TargetNamespace) as IPagosV20;
end;

function LoadComplementoPagoV2(const FileName: string): IPagosV20;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('pago20:Pagos', TPagosV20, TargetNamespace) as IPagosV20;
end;

function NewComplementoPagoV20: IPagosV20;
begin
  Result := NewXMLDocument.GetDocBinding('pago20:Pagos', TPagosV20, TargetNamespace) as IPagosV20;
end;

{ TPagosV20 }

procedure TPagosV20.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
    Self.Set_Version('2.0');

  RegisterChildNode('Totales', TPagosV20_Totales);
  RegisterChildNode('Pago', TPagosV20_Pago);
  FPago := CreateCollection(TPagosV20_PagoList, IPagosV20_Pago, 'Pago') as IPagosV20_PagoList;



//  RegisterChildNode('Pago', TPagosV20_Pago);
//  ItemTag := 'pago10:Pago';
//  ItemInterface := IPagos_PagoV1;

  inherited;
end;

function TPagosV20.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TPagosV20.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TPagosV20.Get_Totales: IPagosV20_Totales;
begin
  Result := ChildNodes['Totales'] as IPagosV20_Totales;
end;

function TPagosV20.Get_Pago: IPagosV20_PagoList;
begin
  Result := FPago;
end;

{ TPagosV20_Totales }

function TPagosV20_Totales.Get_TotalRetencionesIVA: UnicodeString;
begin
  Result := AttributeNodes['TotalRetencionesIVA'].Text;
end;

procedure TPagosV20_Totales.Set_TotalRetencionesIVA(Value: UnicodeString);
begin
  SetAttribute('TotalRetencionesIVA', Value);
end;

function TPagosV20_Totales.Get_TotalRetencionesISR: UnicodeString;
begin
  Result := AttributeNodes['TotalRetencionesISR'].Text;
end;

procedure TPagosV20_Totales.Set_TotalRetencionesISR(Value: UnicodeString);
begin
  SetAttribute('TotalRetencionesISR', Value);
end;

function TPagosV20_Totales.Get_TotalRetencionesIEPS: UnicodeString;
begin
  Result := AttributeNodes['TotalRetencionesIEPS'].Text;
end;

procedure TPagosV20_Totales.Set_TotalRetencionesIEPS(Value: UnicodeString);
begin
  SetAttribute('TotalRetencionesIEPS', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosBaseIVA16: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosBaseIVA16'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosBaseIVA16(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosBaseIVA16', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosImpuestoIVA16: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosImpuestoIVA16'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosImpuestoIVA16(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosImpuestoIVA16', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosBaseIVA8: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosBaseIVA8'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosBaseIVA8(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosBaseIVA8', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosImpuestoIVA8: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosImpuestoIVA8'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosImpuestoIVA8(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosImpuestoIVA8', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosBaseIVA0: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosBaseIVA0'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosBaseIVA0(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosBaseIVA0', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosImpuestoIVA0: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosImpuestoIVA0'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosImpuestoIVA0(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosImpuestoIVA0', Value);
end;

function TPagosV20_Totales.Get_TotalTrasladosBaseIVAExento: UnicodeString;
begin
  Result := AttributeNodes['TotalTrasladosBaseIVAExento'].Text;
end;

procedure TPagosV20_Totales.Set_TotalTrasladosBaseIVAExento(Value: UnicodeString);
begin
  SetAttribute('TotalTrasladosBaseIVAExento', Value);
end;

function TPagosV20_Totales.Get_MontoTotalPagos: UnicodeString;
begin
  Result := AttributeNodes['MontoTotalPagos'].Text;
end;

procedure TPagosV20_Totales.Set_MontoTotalPagos(Value: UnicodeString);
begin
  SetAttribute('MontoTotalPagos', Value);
end;

{ TPagosV20_Pago }

procedure TPagosV20_Pago.AfterConstruction;
begin
  RegisterChildNode('DoctoRelacionado', TPagosV20_Pago_DoctoRelacionado);
  RegisterChildNode('ImpuestosP', TPagosV20_Pago_ImpuestosP);
  FDoctoRelacionado := CreateCollection(TPagosV20_Pago_DoctoRelacionadoList, IPagosV20_Pago_DoctoRelacionado, 'DoctoRelacionado') as IPagosV20_Pago_DoctoRelacionadoList;
  inherited;
end;

function TPagosV20_Pago.Get_FechaPago: UnicodeString;
begin
  Result := AttributeNodes['FechaPago'].Text;
end;

procedure TPagosV20_Pago.Set_FechaPago(Value: UnicodeString);
begin
  SetAttribute('FechaPago', Value);
end;

function TPagosV20_Pago.Get_FormaDePagoP: UnicodeString;
begin
  Result := AttributeNodes['FormaDePagoP'].Text;
end;

procedure TPagosV20_Pago.Set_FormaDePagoP(Value: UnicodeString);
begin
  SetAttribute('FormaDePagoP', Value);
end;

function TPagosV20_Pago.Get_MonedaP: UnicodeString;
begin
  Result := AttributeNodes['MonedaP'].Text;
end;

procedure TPagosV20_Pago.Set_MonedaP(Value: UnicodeString);
begin
  SetAttribute('MonedaP', Value);
end;

function TPagosV20_Pago.Get_TipoCambioP: UnicodeString;
begin
  Result := AttributeNodes['TipoCambioP'].Text;
end;

procedure TPagosV20_Pago.Set_TipoCambioP(Value: UnicodeString);
begin
  SetAttribute('TipoCambioP', Value);
end;

function TPagosV20_Pago.Get_Monto: UnicodeString;
begin
  Result := AttributeNodes['Monto'].Text;
end;

procedure TPagosV20_Pago.Set_Monto(Value: UnicodeString);
begin
  SetAttribute('Monto', Value);
end;

function TPagosV20_Pago.Get_NumOperacion: UnicodeString;
begin
  Result := AttributeNodes['NumOperacion'].Text;
end;

procedure TPagosV20_Pago.Set_NumOperacion(Value: UnicodeString);
begin
  SetAttribute('NumOperacion', Value);
end;

function TPagosV20_Pago.Get_RfcEmisorCtaOrd: UnicodeString;
begin
  Result := AttributeNodes['RfcEmisorCtaOrd'].Text;
end;

procedure TPagosV20_Pago.Set_RfcEmisorCtaOrd(Value: UnicodeString);
begin
  SetAttribute('RfcEmisorCtaOrd', Value);
end;

function TPagosV20_Pago.Get_NomBancoOrdExt: UnicodeString;
begin
  Result := AttributeNodes['NomBancoOrdExt'].Text;
end;

procedure TPagosV20_Pago.Set_NomBancoOrdExt(Value: UnicodeString);
begin
  SetAttribute('NomBancoOrdExt', Value);
end;

function TPagosV20_Pago.Get_CtaOrdenante: UnicodeString;
begin
  Result := AttributeNodes['CtaOrdenante'].Text;
end;

procedure TPagosV20_Pago.Set_CtaOrdenante(Value: UnicodeString);
begin
  SetAttribute('CtaOrdenante', Value);
end;

function TPagosV20_Pago.Get_RfcEmisorCtaBen: UnicodeString;
begin
  Result := AttributeNodes['RfcEmisorCtaBen'].Text;
end;

procedure TPagosV20_Pago.Set_RfcEmisorCtaBen(Value: UnicodeString);
begin
  SetAttribute('RfcEmisorCtaBen', Value);
end;

function TPagosV20_Pago.Get_CtaBeneficiario: UnicodeString;
begin
  Result := AttributeNodes['CtaBeneficiario'].Text;
end;

procedure TPagosV20_Pago.Set_CtaBeneficiario(Value: UnicodeString);
begin
  SetAttribute('CtaBeneficiario', Value);
end;

function TPagosV20_Pago.Get_TipoCadPago: UnicodeString;
begin
  Result := AttributeNodes['TipoCadPago'].Text;
end;

procedure TPagosV20_Pago.Set_TipoCadPago(Value: UnicodeString);
begin
  SetAttribute('TipoCadPago', Value);
end;

function TPagosV20_Pago.Get_CertPago: UnicodeString;
begin
  Result := AttributeNodes['CertPago'].Text;
end;

procedure TPagosV20_Pago.Set_CertPago(Value: UnicodeString);
begin
  SetAttribute('CertPago', Value);
end;

function TPagosV20_Pago.Get_CadPago: UnicodeString;
begin
  Result := AttributeNodes['CadPago'].Text;
end;

procedure TPagosV20_Pago.Set_CadPago(Value: UnicodeString);
begin
  SetAttribute('CadPago', Value);
end;

function TPagosV20_Pago.Get_SelloPago: UnicodeString;
begin
  Result := AttributeNodes['SelloPago'].Text;
end;

procedure TPagosV20_Pago.Set_SelloPago(Value: UnicodeString);
begin
  SetAttribute('SelloPago', Value);
end;

function TPagosV20_Pago.Get_DoctoRelacionado: IPagosV20_Pago_DoctoRelacionadoList;
begin
  Result := FDoctoRelacionado;
end;

function TPagosV20_Pago.Get_ImpuestosP: IPagosV20_Pago_ImpuestosP;
begin
  Result := ChildNodes['ImpuestosP'] as IPagosV20_Pago_ImpuestosP;
end;

{ TPagosV20_PagoList }

function TPagosV20_PagoList.Add: IPagosV20_Pago;
begin
  Result := AddItem(-1) as IPagosV20_Pago;
end;

function TPagosV20_PagoList.Insert(const Index: Integer): IPagosV20_Pago;
begin
  Result := AddItem(Index) as IPagosV20_Pago;
end;

function TPagosV20_PagoList.Get_Item(Index: Integer): IPagosV20_Pago;
begin
  Result := List[Index] as IPagosV20_Pago;
end;

{ TPagosV20_Pago_DoctoRelacionado }

procedure TPagosV20_Pago_DoctoRelacionado.AfterConstruction;
begin
  RegisterChildNode('ImpuestosDR', TPagosV20_Pago_DoctoRelacionado_ImpuestosDR);
  inherited;
end;

function TPagosV20_Pago_DoctoRelacionado.Get_IdDocumento: UnicodeString;
begin
  Result := AttributeNodes['IdDocumento'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_IdDocumento(Value: UnicodeString);
begin
  SetAttribute('IdDocumento', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_Serie: UnicodeString;
begin
  Result := AttributeNodes['Serie'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_Serie(Value: UnicodeString);
begin
  SetAttribute('Serie', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_Folio: UnicodeString;
begin
  Result := AttributeNodes['Folio'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_Folio(Value: UnicodeString);
begin
  SetAttribute('Folio', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_MonedaDR: UnicodeString;
begin
  Result := AttributeNodes['MonedaDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_MonedaDR(Value: UnicodeString);
begin
  SetAttribute('MonedaDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_EquivalenciaDR: UnicodeString;
begin
  Result := AttributeNodes['EquivalenciaDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_EquivalenciaDR(Value: UnicodeString);
begin
  SetAttribute('EquivalenciaDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_NumParcialidad: Integer;
begin
  Result := AttributeNodes['NumParcialidad'].NodeValue;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_NumParcialidad(Value: Integer);
begin
  SetAttribute('NumParcialidad', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_ImpSaldoAnt: UnicodeString;
begin
  Result := AttributeNodes['ImpSaldoAnt'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_ImpSaldoAnt(Value: UnicodeString);
begin
  SetAttribute('ImpSaldoAnt', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_ImpPagado: UnicodeString;
begin
  Result := AttributeNodes['ImpPagado'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_ImpPagado(Value: UnicodeString);
begin
  SetAttribute('ImpPagado', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_ImpSaldoInsoluto: UnicodeString;
begin
  Result := AttributeNodes['ImpSaldoInsoluto'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_ImpSaldoInsoluto(Value: UnicodeString);
begin
  SetAttribute('ImpSaldoInsoluto', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_ObjetoImpDR: UnicodeString;
begin
  Result := AttributeNodes['ObjetoImpDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado.Set_ObjetoImpDR(Value: UnicodeString);
begin
  SetAttribute('ObjetoImpDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado.Get_ImpuestosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR;
begin
  Result := ChildNodes['ImpuestosDR'] as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR;
end;

{ TPagosV20_Pago_DoctoRelacionadoList }

function TPagosV20_Pago_DoctoRelacionadoList.Add: IPagosV20_Pago_DoctoRelacionado;
begin
  Result := AddItem(-1) as IPagosV20_Pago_DoctoRelacionado;
end;

function TPagosV20_Pago_DoctoRelacionadoList.Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado;
begin
  Result := AddItem(Index) as IPagosV20_Pago_DoctoRelacionado;
end;

function TPagosV20_Pago_DoctoRelacionadoList.Get_Item(Index: Integer): IPagosV20_Pago_DoctoRelacionado;
begin
  Result := List[Index] as IPagosV20_Pago_DoctoRelacionado;
end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR }

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR.AfterConstruction;
begin
  RegisterChildNode('RetencionesDR', TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR);
  RegisterChildNode('TrasladosDR', TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR);
  inherited;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR.Get_RetencionesDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR;
begin
  Result := ChildNodes['RetencionesDR'] as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR.Get_TrasladosDR: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR;
begin
  Result := ChildNodes['TrasladosDR'] as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR;
end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR }

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR.AfterConstruction;
begin
  RegisterChildNode('RetencionDR', TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR);
  ItemTag := 'RetencionDR';
  ItemInterface := IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
  inherited;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR.Get_RetencionDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
begin
  Result := List[Index] as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR.Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
begin
  Result := AddItem(-1) as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR.Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
begin
  Result := AddItem(Index) as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR;
end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR }

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Get_BaseDR: UnicodeString;
begin
  Result := AttributeNodes['BaseDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Set_BaseDR(Value: UnicodeString);
begin
  SetAttribute('BaseDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Get_ImpuestoDR: UnicodeString;
begin
  Result := AttributeNodes['ImpuestoDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Set_ImpuestoDR(Value: UnicodeString);
begin
  SetAttribute('ImpuestoDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Get_TipoFactorDR: UnicodeString;
begin
  Result := AttributeNodes['TipoFactorDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Set_TipoFactorDR(Value: UnicodeString);
begin
  SetAttribute('TipoFactorDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Get_TasaOCuotaDR: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuotaDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Set_TasaOCuotaDR(Value: UnicodeString);
begin
  SetAttribute('TasaOCuotaDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Get_ImporteDR: UnicodeString;
begin
  Result := AttributeNodes['ImporteDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_RetencionesDR_RetencionDR.Set_ImporteDR(Value: UnicodeString);
begin
  SetAttribute('ImporteDR', Value);
end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR }

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR.AfterConstruction;
begin
  RegisterChildNode('TrasladoDR', TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR);
  ItemTag := 'TrasladoDR';
  ItemInterface := IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
  inherited;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR.Get_TrasladoDR(Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
begin
  Result := List[Index] as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR.Add: IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
begin
  Result := AddItem(-1) as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR.Insert(const Index: Integer): IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
begin
  Result := AddItem(Index) as IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
end;

{ TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR }

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Get_BaseDR: UnicodeString;
begin
  Result := AttributeNodes['BaseDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Set_BaseDR(Value: UnicodeString);
begin
  SetAttribute('BaseDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Get_ImpuestoDR: UnicodeString;
begin
  Result := AttributeNodes['ImpuestoDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Set_ImpuestoDR(Value: UnicodeString);
begin
  SetAttribute('ImpuestoDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Get_TipoFactorDR: UnicodeString;
begin
  Result := AttributeNodes['TipoFactorDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Set_TipoFactorDR(Value: UnicodeString);
begin
  SetAttribute('TipoFactorDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Get_TasaOCuotaDR: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuotaDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Set_TasaOCuotaDR(Value: UnicodeString);
begin
  SetAttribute('TasaOCuotaDR', Value);
end;

function TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Get_ImporteDR: UnicodeString;
begin
  Result := AttributeNodes['ImporteDR'].Text;
end;

procedure TPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR.Set_ImporteDR(Value: UnicodeString);
begin
  SetAttribute('ImporteDR', Value);
end;

{ TPagosV20_Pago_ImpuestosP }

procedure TPagosV20_Pago_ImpuestosP.AfterConstruction;
begin
  RegisterChildNode('RetencionesP', TPagosV20_Pago_ImpuestosP_RetencionesP);
  RegisterChildNode('TrasladosP', TPagosV20_Pago_ImpuestosP_TrasladosP);
  inherited;
end;

function TPagosV20_Pago_ImpuestosP.Get_RetencionesP: IPagosV20_Pago_ImpuestosP_RetencionesP;
begin
  Result := ChildNodes['RetencionesP'] as IPagosV20_Pago_ImpuestosP_RetencionesP;
end;

function TPagosV20_Pago_ImpuestosP.Get_TrasladosP: IPagosV20_Pago_ImpuestosP_TrasladosP;
begin
  Result := ChildNodes['TrasladosP'] as IPagosV20_Pago_ImpuestosP_TrasladosP;
end;

{ TPagosV20_Pago_ImpuestosP_RetencionesP }

procedure TPagosV20_Pago_ImpuestosP_RetencionesP.AfterConstruction;
begin
  RegisterChildNode('RetencionP', TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP);
  ItemTag := 'RetencionP';
  ItemInterface := IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
  inherited;
end;

function TPagosV20_Pago_ImpuestosP_RetencionesP.Get_RetencionP(Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
begin
  Result := List[Index] as IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
end;

function TPagosV20_Pago_ImpuestosP_RetencionesP.Add: IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
begin
  Result := AddItem(-1) as IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
end;

function TPagosV20_Pago_ImpuestosP_RetencionesP.Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
begin
  Result := AddItem(Index) as IPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP;
end;

{ TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP }

function TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP.Get_ImpuestoP: UnicodeString;
begin
  Result := AttributeNodes['ImpuestoP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP.Set_ImpuestoP(Value: UnicodeString);
begin
  SetAttribute('ImpuestoP', Value);
end;

function TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP.Get_ImporteP: UnicodeString;
begin
  Result := AttributeNodes['ImporteP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_RetencionesP_RetencionP.Set_ImporteP(Value: UnicodeString);
begin
  SetAttribute('ImporteP', Value);
end;

{ TPagosV20_Pago_ImpuestosP_TrasladosP }

procedure TPagosV20_Pago_ImpuestosP_TrasladosP.AfterConstruction;
begin
  RegisterChildNode('TrasladoP', TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP);
  ItemTag := 'TrasladoP';
  ItemInterface := IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
  inherited;
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP.Get_TrasladoP(Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
begin
  Result := List[Index] as IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP.Add: IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
begin
  Result := AddItem(-1) as IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP.Insert(const Index: Integer): IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
begin
  Result := AddItem(Index) as IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
end;

{ TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP }

function TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Get_BaseP: UnicodeString;
begin
  Result := AttributeNodes['BaseP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Set_BaseP(Value: UnicodeString);
begin
  SetAttribute('BaseP', Value);
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Get_ImpuestoP: UnicodeString;
begin
  Result := AttributeNodes['ImpuestoP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Set_ImpuestoP(Value: UnicodeString);
begin
  SetAttribute('ImpuestoP', Value);
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Get_TipoFactorP: UnicodeString;
begin
  Result := AttributeNodes['TipoFactorP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Set_TipoFactorP(Value: UnicodeString);
begin
  SetAttribute('TipoFactorP', Value);
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Get_TasaOCuotaP: UnicodeString;
begin
  Result := AttributeNodes['TasaOCuotaP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Set_TasaOCuotaP(Value: UnicodeString);
begin
  SetAttribute('TasaOCuotaP', Value);
end;

function TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Get_ImporteP: UnicodeString;
begin
  Result := AttributeNodes['ImporteP'].Text;
end;

procedure TPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP.Set_ImporteP(Value: UnicodeString);
begin
  SetAttribute('ImporteP', Value);
end;

end.