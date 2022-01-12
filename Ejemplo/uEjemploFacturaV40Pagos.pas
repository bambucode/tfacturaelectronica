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
  pagoComplementPagoV2: IPagosV20_Pago;
  doctoRelacionadoListV2 : IPagosV20_Pago_DoctoRelacionadoList;
  doctoRelacionadoComplementoPagoV2: IPagosV20_Pago_DoctoRelacionado;
  impuestosTrasladadosV2 : IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
  impuestoTrasladadoDocRelacionadoV2 : IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;
  montoFacturaOriginal, montoPago, montoPagoIVA, montoPagoBase : Currency;
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
      LugarExpedicion    := '76030';
      Exportacion        := '01';


      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '612'; // De catálogo

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

      montoPagoBase := 100;
      montoPagoIVA := montoPagoBase * 0.16;
      montoPago := montoPagoBase + montoPagoIVA;


      // El primer nodo especificado debe ser el de los totales de los abonos
      complementoPagoV2.Totales.TotalTrasladosBaseIVA16 := TFacturacionHelper.ComoMoneda(montoPagoBase, 2);
      complementoPagoV2.Totales.TotalTrasladosImpuestoIVA16 := TFacturacionHelper.ComoMoneda(montoPagoIVA, 2);
      complementoPagoV2.Totales.MontoTotalPagos := TFacturacionHelper.ComoMoneda(montoPago, 2);

      // Agregamos el pago
      pagoComplementPagoV2 := complementoPagoV2.Pago.Add;
      pagoComplementPagoV2.FechaPago        := TFacturacionHelper.ComoFechaISO8601(Now);
      pagoComplementPagoV2.FormaDePagoP     := '02';
      pagoComplementPagoV2.MonedaP          := 'MXN';
      pagoComplementPagoV2.TipoCambioP      := '1';
      pagoComplementPagoV2.Monto            := TFacturacionHelper.ComoMoneda(montoPago, 2);
      pagoComplementPagoV2.NumOperacion     := '323232';
      //pagoComplementPagoV2.RfcEmisorCtaOrd  := 'BBA940707IE1';
      //pagoComplementPagoV2.CtaOrdenante     := '12345678901';
      //pagoComplementPagoV2.RfcEmisorCtaBen  := 'BBA830831LJ2';
      //pagoComplementPagoV2.CtaBeneficiario  := '123456789012345678';


      // Agregamos cada uno de los documentos relacionados con el pago
      doctoRelacionadoListV2                   := pagoComplementPagoV2.DoctoRelacionado;
      doctoRelacionadoComplementoPagoV2        := doctoRelacionadoListV2.Add;

      doctoRelacionadoComplementoPagoV2.IdDocumento        := 'D72829D8-ADCD-4457-935F-B7168A488851';
      doctoRelacionadoComplementoPagoV2.Serie              := 'A';
      doctoRelacionadoComplementoPagoV2.Folio              := '1';
      doctoRelacionadoComplementoPagoV2.MonedaDR           := 'MXN';
      doctoRelacionadoComplementoPagoV2.EquivalenciaDR     := '1';
      //doctoRelacionadoComplementoPagoV2.TipoCambioDR       := '0.05';
      //doctoRelacionadoComplementoPagoV2.MetodoDePagoDR     := 'PPD';
      doctoRelacionadoComplementoPagoV2.NumParcialidad     := 1;
      doctoRelacionadoComplementoPagoV2.ImpSaldoAnt        := TFacturacionHelper.ComoMoneda(montoPago, 2);  //ImpPagado + impSaldoInsoluto
      doctoRelacionadoComplementoPagoV2.ImpPagado          := TFacturacionHelper.ComoMoneda(montoPago, 2);
      doctoRelacionadoComplementoPagoV2.ImpSaldoInsoluto   := TFacturacionHelper.ComoMoneda(0, 2);
      doctoRelacionadoComplementoPagoV2.ObjetoImpDR        := '02';  // 02-sujeto a impuesto


      // Desglosamos los impuestos del abono: IVA 16%, IVA 0%, etc.
      impuestoTrasladadoDocRelacionadoV2 := doctoRelacionadoComplementoPagoV2.ImpuestosDR.TrasladosDR.Add;
      impuestoTrasladadoDocRelacionadoV2.BaseDR := TFacturacionHelper.ComoMoneda(montoPagoBase, 2);
      impuestoTrasladadoDocRelacionadoV2.ImpuestoDR := '002';   // 001-ISR, 002-IVA, 003-IEPS
      impuestoTrasladadoDocRelacionadoV2.TipoFactorDR := 'Tasa';
      impuestoTrasladadoDocRelacionadoV2.TasaOCuotaDR := '0.160000';
      impuestoTrasladadoDocRelacionadoV2.ImporteDR :=  TFacturacionHelper.ComoMoneda(montoPagoIVA, 2);

       // Agregamos el resumen del pago
      impuestosTrasladadosV2 := pagoComplementPagoV2.ImpuestosP.TrasladosP.Add;
      impuestosTrasladadosV2.BaseP := TFacturacionHelper.ComoMoneda(montoPagoBase, 2);
      impuestosTrasladadosV2.ImpuestoP := '002'; // De catálogos
      impuestosTrasladadosV2.TipoFactorP := 'Tasa';
      impuestosTrasladadosV2.TasaOCuotaP := '0.160000';
      impuestosTrasladadosV2.ImporteP := TFacturacionHelper.ComoMoneda(montoPagoIVA, 2);

      nuevaFactura.AgregarComplemento(complementoPagoV2,
                                      'pago20',
                                      'http://www.sat.gob.mx/Pagos20',
                                      'http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd');

    end;

  end;
end;

end.
