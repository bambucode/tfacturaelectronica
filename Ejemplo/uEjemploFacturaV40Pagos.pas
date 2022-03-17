unit uEjemploFacturaV40Pagos;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV40Pagos(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                 generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);

implementation

uses
  Forms,
  SysUtils,
  ActiveX,
  Facturacion.Administrador,
  Facturacion.GeneradorQR,
  Facturacion.PAC.Ecodex,
  Facturacion.PAC.MultiFacturas,
  Facturacion.PAC.FInkOk,
  Facturacion.PAC.SolucionFactible,
  Facturacion.ProveedorAutorizadoCertificacion,
  Facturacion.GeneradorCBB,
  Facturacion.ComprobanteV32,
  Facturacion.GeneradorCadenaOrignalV32,
  Facturacion.GeneradorSelloV32,
  Facturacion.GeneradorCBBv32,
  Facturacion.ComprobanteV33,
  Facturacion.GeneradorCadenaOrignalV33,
  Facturacion.GeneradorSelloV33,
  Facturacion.GeneradorCBBv33,
  Facturacion.ComplementoPagoV1,

   // CFDI 4.0:
  Facturacion.ComprobanteV40,
  Facturacion.GeneradorCadenaOrignalV40,
  Facturacion.ComplementoPagoV2,

  Facturacion.Helper,
  Facturacion.GeneradorLigaVerificacion,
  Facturacion.ImpuestosLocalesV1;

procedure GenerarFacturaV40Pagos(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                  generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  facturaCFDIv40 : IComprobanteFiscalv40;
  concepto40 : IComprobanteFiscalv40_Conceptos_Concepto;
  complementoPagoV2: IPagosV20;
  pagoComplementPago1, pagoComplementPago2: IPagosV20_Pago;
  doctoRelacionadoList1, doctoRelacionadoList2 : IPagosV20_Pago_DoctoRelacionadoList;
  doctoRelacionadoComplementoPago1, doctoRelacionadoComplementoPago2: IPagosV20_Pago_DoctoRelacionado;
  impuestosTrasladados1, impuestosTrasladados2, impuestosTrasladados1b : IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
  impuestoTrasladadoDocRelacionado1, impuestoTrasladadoDocRelacionado2, impuestoTrasladadoDocRelacionado1b : IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
  montoFacturaOriginal: Currency;
  montoPago1, montoPagoIVA1, montoIEPS1, montoBaseIVA1, montoBaseIEPS1 : Currency;
  montoPago2, montoPagoIVA2, montoPagoBase2 : Currency;
  saldoAnterior, saldoPosterior : Currency;
begin
  if nuevaFactura.Version = '4.0' then
  begin
    if Not Supports(nuevaFactura, IComprobanteFiscalv40, facturaCFDIv40) then
    begin
      Writeln('nuevaFactura no fue un Comprobante Fiscal v4.0');
      Exit;
    end;

    Writeln('Llenando comprobante CFDI v4.0...');

    // La guia de llenado del comprobante de pago v2.0 se encuentra en:
    // http://omawww.sat.gob.mx/tramitesyservicios/Paginas/documentos/Guiallenadopagos311221.pdf

    with facturaCFDIv40 do
    begin
      Serie     := 'A';
      Randomize;
      Folio     := IntToStr(Random(999999999));
      Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);

      NoCertificado      := certificadoSellos.NoCertificado;
      Certificado        := certificadoSellos.ContenidoBase64;
      Subtotal           := '0';   // Cero por Definicion
      Moneda             := 'XXX';    // Cero por Definicion
      Total              := '0';   // Cero por Definicion
      TipoDeComprobante  := 'P';      // De catálogo
      LugarExpedicion    := '26015';
      Exportacion        := '01';


      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '601'; // De catálogo

      Receptor.Rfc              := Uppercase('cacx7605101p8');
      // NOTA: El nombre del receptor debe ser EXACTAMENTE como aparece en la LCO
      Receptor.Nombre           := 'XOCHILT CASAS CHAVEZ';
      Receptor.UsoCFDI          := 'G01';
      // NOTA: El CP del domicilio del receptor debe ser EXACTAMENTE como aparece en la LCO
      Receptor.DomicilioFiscalReceptor := '00000';
      Receptor.RegimenFiscalReceptor := '612';
      Receptor.UsoCFDI         := 'CP01';

      concepto40 := Conceptos.Add;
      concepto40.ClaveProdServ    := '84111506';    // Por Definicion del SAT
      concepto40.Cantidad         := '1';           // Por Definicion del SAT
      concepto40.ClaveUnidad      := 'ACT';         // Por Definicion del SAT
      concepto40.Descripcion      := 'Pago';        // Por Definicion del SAT
      concepto40.ValorUnitario    := '0';        // Por Definicion del SAT
      concepto40.Importe          := '0';        // Por Definicion del SAT
      concepto40.ObjetoImp        := '01';

      complementoPagoV2 := NewComplementoPagoV20;

      // Estos serán los datos que usaremos para llenar nuestro comprobante
      montoFacturaOriginal := 1000;

      // Monto del primer pago
      montoBaseIEPS1 := 300;
      montoIEPS1 := montoBaseIEPS1 * 0.08;
      montoBaseIVA1 := montoBaseIEPS1 + montoIEPS1;
      montoPagoIVA1 := montoBaseIVA1 * 0.16;
      montoPago1 := montoBaseIEPS1 + montoPagoIVA1 + montoIEPS1;

      // Monto del segundo pago
      montoPagoBase2 := 200;
      montoPagoIVA2 := montoPagoBase2 * 0.16;
      montoPago2 := montoPagoBase2 + montoPagoIVA2;

      // El primer nodo especificado debe ser el de los totales de los abonos
      complementoPagoV2.Totales.TotalTrasladosBaseIVA16 := TFacturacionHelper.ComoMoneda(montoBaseIVA1 + montoPagoBase2, 2);
      complementoPagoV2.Totales.TotalTrasladosImpuestoIVA16 := TFacturacionHelper.ComoMoneda(montoPagoIVA1 + montoPagoIVA2, 2);
      complementoPagoV2.Totales.MontoTotalPagos := TFacturacionHelper.ComoMoneda(montoPago1 + montoPago2, 2);

      {$REGION 'Pago 1'}
      pagoComplementPago1 := complementoPagoV2.Pago.Add;
      pagoComplementPago1.FechaPago        := TFacturacionHelper.ComoFechaISO8601(Now);
      pagoComplementPago1.FormaDePagoP     := '02';
      pagoComplementPago1.MonedaP          := 'MXN';
      pagoComplementPago1.TipoCambioP      := '1';
      pagoComplementPago1.Monto            := TFacturacionHelper.ComoMoneda(montoPago1, 2);
      pagoComplementPago1.NumOperacion     := '323232';
      //pagoComplementPagoV2.RfcEmisorCtaOrd  := 'BBA940707IE1';
      //pagoComplementPagoV2.CtaOrdenante     := '12345678901';
      //pagoComplementPagoV2.RfcEmisorCtaBen  := 'BBA830831LJ2';
      //pagoComplementPagoV2.CtaBeneficiario  := '123456789012345678';

      // Agregamos cada uno de los documentos relacionados con el pago
      doctoRelacionadoList1                   := pagoComplementPago1.DoctoRelacionado;
      doctoRelacionadoComplementoPago1        := doctoRelacionadoList1.Add;

      doctoRelacionadoComplementoPago1.IdDocumento        := 'D72829D8-ADCD-4457-935F-B7168A488851';
      doctoRelacionadoComplementoPago1.Serie              := 'A';
      doctoRelacionadoComplementoPago1.Folio              := '1';
      doctoRelacionadoComplementoPago1.MonedaDR           := 'MXN';
      doctoRelacionadoComplementoPago1.EquivalenciaDR     := '1';
      doctoRelacionadoComplementoPago1.NumParcialidad     := 1;

      saldoAnterior := montoFacturaOriginal;
      saldoPosterior := saldoAnterior - montoPago1;

      doctoRelacionadoComplementoPago1.ImpSaldoAnt        := TFacturacionHelper.ComoMoneda(saldoAnterior, 2);  //ImpPagado + impSaldoInsoluto
      doctoRelacionadoComplementoPago1.ImpPagado          := TFacturacionHelper.ComoMoneda(montoPago1, 2);
      doctoRelacionadoComplementoPago1.ImpSaldoInsoluto   := TFacturacionHelper.ComoMoneda(saldoPosterior, 2);
      doctoRelacionadoComplementoPago1.ObjetoImpDR        := '02';  // 02-sujeto a impuesto


      // Desglosamos los impuestos del abono: IVA 16%, IVA 0%, etc.
      impuestoTrasladadoDocRelacionado1 := doctoRelacionadoComplementoPago1.ImpuestosDR.TrasladosDR.Add;
      impuestoTrasladadoDocRelacionado1.BaseDR := TFacturacionHelper.ComoMoneda(montoBaseIVA1, 2);
      impuestoTrasladadoDocRelacionado1.ImpuestoDR := '002';   // 001-ISR, 002-IVA, 003-IEPS
      impuestoTrasladadoDocRelacionado1.TipoFactorDR := 'Tasa';
      impuestoTrasladadoDocRelacionado1.TasaOCuotaDR := '0.160000';
      impuestoTrasladadoDocRelacionado1.ImporteDR :=  TFacturacionHelper.ComoMoneda(montoPagoIVA1, 2);

      impuestoTrasladadoDocRelacionado1b := doctoRelacionadoComplementoPago1.ImpuestosDR.TrasladosDR.Add;
      impuestoTrasladadoDocRelacionado1b.BaseDR := TFacturacionHelper.ComoMoneda(montoBaseIEPS1, 2);
      impuestoTrasladadoDocRelacionado1b.ImpuestoDR := '003';   // 001-ISR, 002-IVA, 003-IEPS
      impuestoTrasladadoDocRelacionado1b.TipoFactorDR := 'Tasa';
      impuestoTrasladadoDocRelacionado1b.TasaOCuotaDR := '0.080000';
      impuestoTrasladadoDocRelacionado1b.ImporteDR :=  TFacturacionHelper.ComoMoneda(montoIEPS1, 2);

      // Sumarizado de impuestos para el documento relacionado
      impuestosTrasladados1 := pagoComplementPago1.ImpuestosP.TrasladosP.Add;
      impuestosTrasladados1.BaseP := TFacturacionHelper.ComoMoneda(montoBaseIVA1, 2);
      impuestosTrasladados1.ImpuestoP := '002'; // De catálogos
      impuestosTrasladados1.TipoFactorP := 'Tasa';
      impuestosTrasladados1.TasaOCuotaP := '0.160000';
      impuestosTrasladados1.ImporteP := TFacturacionHelper.ComoMoneda(montoPagoIVA1, 2);

      impuestosTrasladados1b := pagoComplementPago1.ImpuestosP.TrasladosP.Add;
      impuestosTrasladados1b.BaseP := TFacturacionHelper.ComoMoneda(montoBaseIEPS1, 2);
      impuestosTrasladados1b.ImpuestoP := '003'; // De catálogos
      impuestosTrasladados1b.TipoFactorP := 'Tasa';
      impuestosTrasladados1b.TasaOCuotaP := '0.080000';
      impuestosTrasladados1b.ImporteP := TFacturacionHelper.ComoMoneda(montoIEPS1, 2);
      {$ENDREGION}

      // Para cada subsecuente pago/abono se debe generar el siguiente bloque...

      {$REGION 'Pago 2'}
      pagoComplementPago2 := complementoPagoV2.Pago.Add;
      pagoComplementPago2.FechaPago        := TFacturacionHelper.ComoFechaISO8601(Now);
      pagoComplementPago2.FormaDePagoP     := '02';
      pagoComplementPago2.MonedaP          := 'MXN';
      pagoComplementPago2.TipoCambioP      := '1';
      pagoComplementPago2.Monto            := TFacturacionHelper.ComoMoneda(montoPago2, 2);
      pagoComplementPago2.NumOperacion     := '323233';

      doctoRelacionadoList2               := pagoComplementPago2.DoctoRelacionado;
      doctoRelacionadoComplementoPago2     := doctoRelacionadoList2.Add;

      doctoRelacionadoComplementoPago2.IdDocumento        := '32671540-5AFB-44FE-B26B-CCCCEAAC5FFD';
      doctoRelacionadoComplementoPago2.Serie              := 'A';
      doctoRelacionadoComplementoPago2.Folio              := '2';
      doctoRelacionadoComplementoPago2.MonedaDR           := 'MXN';
      doctoRelacionadoComplementoPago2.EquivalenciaDR     := '1';
      doctoRelacionadoComplementoPago2.NumParcialidad     := 2;

      saldoAnterior := saldoPosterior;
      saldoPosterior := saldoAnterior - montoPago2;

      doctoRelacionadoComplementoPago2.ImpSaldoAnt        := TFacturacionHelper.ComoMoneda(saldoAnterior, 2);  //ImpPagado + impSaldoInsoluto
      doctoRelacionadoComplementoPago2.ImpPagado          := TFacturacionHelper.ComoMoneda(montoPago2, 2);
      doctoRelacionadoComplementoPago2.ImpSaldoInsoluto   := TFacturacionHelper.ComoMoneda(saldoPosterior, 2);
      doctoRelacionadoComplementoPago2.ObjetoImpDR        := '02';  // 02-sujeto a impuesto

      // Desglosamos los impuestos del abono: IVA 16%, IVA 0%, etc.
      impuestoTrasladadoDocRelacionado2 := doctoRelacionadoComplementoPago2.ImpuestosDR.TrasladosDR.Add;
      impuestoTrasladadoDocRelacionado2.BaseDR := TFacturacionHelper.ComoMoneda(montoPagoBase2, 2);
      impuestoTrasladadoDocRelacionado2.ImpuestoDR := '002';   // 001-ISR, 002-IVA, 003-IEPS
      impuestoTrasladadoDocRelacionado2.TipoFactorDR := 'Tasa';
      impuestoTrasladadoDocRelacionado2.TasaOCuotaDR := '0.160000';
      impuestoTrasladadoDocRelacionado2.ImporteDR :=  TFacturacionHelper.ComoMoneda(montoPagoIVA2, 2);

      // Sumarizado de impuestos para el documento relacionado
      impuestosTrasladados2 := pagoComplementPago2.ImpuestosP.TrasladosP.Add;
      impuestosTrasladados2.BaseP := TFacturacionHelper.ComoMoneda(montoPagoBase2, 2);
      impuestosTrasladados2.ImpuestoP := '002'; // De catálogos
      impuestosTrasladados2.TipoFactorP := 'Tasa';
      impuestosTrasladados2.TasaOCuotaP := '0.160000';
      impuestosTrasladados2.ImporteP := TFacturacionHelper.ComoMoneda(montoPagoIVA2, 2);
      {$ENDREGION}

      nuevaFactura.AgregarComplemento(complementoPagoV2,
                                      'pago20',
                                      'http://www.sat.gob.mx/Pagos20',
                                      'http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd');

    end;

  end;
end;

end.

