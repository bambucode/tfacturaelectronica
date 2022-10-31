unit uEjemploFacturaV33Pagos;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV33Pagos(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                 generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);

implementation

uses
  Forms,
  SysUtils,
  ActiveX,
  Facturacion.Administrador,
  Facturacion.GeneradorQR,
  Facturacion.PAC.Ecodex,
  Facturacion.ProveedorAutorizadoCertificacion,
  Facturacion.GeneradorCBB,

  // CFDI 3.3
  Facturacion.ComprobanteV33,
  Facturacion.GeneradorCadenaOrignalV33,
  Facturacion.GeneradorSelloV33,
  Facturacion.GeneradorCBBv33,
  Facturacion.ComplementoPagoV1,

  Facturacion.Helper,
  Facturacion.GeneradorLigaVerificacion,
  Facturacion.ImpuestosLocalesV1;

procedure GenerarFacturaV33Pagos(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                  generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  // Instancias especificas para V33
  facturaCFDIv33 : IComprobanteFiscalV33;
  concepto33 : IComprobanteFiscalV33_Conceptos_Concepto;

  // Instancia de complemento de pago v1.0 (compatible con CFDI 3.2 y 3.3)
  complementoPagoV1: IPagosV1;
  pagoComplementPagoV1: IPagos_PagoV1;
  doctoRelacionadoListV1 : IPagos_Pago_DoctoRelacionadoListV1;
  doctoRelacionadoComplementoPagoV1: IPagos_Pago_DoctoRelacionadoV1;
begin
  if nuevaFactura.Version = '3.3' then
  begin
    if Not Supports(nuevaFactura, IComprobanteFiscalv33, facturaCFDIv33) then
    begin
      Writeln('nuevaFactura no fue un Comprobante Fiscal v33');
      Exit;
    end;


    // Creamos las instancias correspondientes para la v33
    generadorCadena := TGeneradorCadenaOriginalV33.Create;
    generadorSello := TGeneradorSelloV33.Create;
    generadorSello.Configurar(openSSL);

    Writeln('Llenando comprobante CFDI v3.3...');
    with facturaCFDIv33 do
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

      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '601'; // De catálogo

      Receptor.Rfc         := Uppercase('cacx7605101p8');
      Receptor.Nombre      := 'XOTICHL CASAS CHAVEZ';
      Receptor.UsoCFDI     := 'P01';    // Por Definicion del SAT

      concepto33 := Conceptos.Add;
      concepto33.ClaveProdServ    := '84111506';    // Por Definicion del SAT
      concepto33.Cantidad         := '1';           // Por Definicion del SAT
      concepto33.ClaveUnidad      := 'ACT';         // Por Definicion del SAT
      concepto33.Descripcion      := 'Pago';        // Por Definicion del SAT
      concepto33.ValorUnitario    := '0';        // Por Definicion del SAT
      concepto33.Importe          := '0';        // Por Definicion del SAT

      {$IFDEF undef}{$REGION 'Complemento Pagos'}{$ENDIF}
      complementoPagoV1 := NewComplementoPagoV1;
      pagoComplementPagoV1 := complementoPagoV1.Add;

      pagoComplementPagoV1.FechaPago        := TFacturacionHelper.ComoFechaISO8601(Now);
      pagoComplementPagoV1.FormaDePagoP     := '02';
      pagoComplementPagoV1.MonedaP          := 'MXN';
      //pagoComplementPagoV1.TipoCambioP      := '1.00';  // Ecodex no valida la inclusion de TipoCambioP
      pagoComplementPagoV1.Monto            := '100.00';
      pagoComplementPagoV1.NumOperacion     := '323232';
      //pagoComplementPagoV1.RfcEmisorCtaOrd  := 'BBA940707IE1';
      //pagoComplementPagoV1.CtaOrdenante     := '12345678901';
      //pagoComplementPagoV1.RfcEmisorCtaBen  := 'BBA830831LJ2';
      //pagoComplementPagoV1.CtaBeneficiario  := '123456789012345678';

      doctoRelacionadoListV1                   := pagoComplementPagoV1.DoctoRelacionado;
      doctoRelacionadoComplementoPagoV1        := doctoRelacionadoListV1.Add;

      doctoRelacionadoComplementoPagoV1.IdDocumento        := 'D72829D8-ADCD-4457-935F-B7168A488851';
      doctoRelacionadoComplementoPagoV1.Serie              := 'A';
      doctoRelacionadoComplementoPagoV1.Folio              := '1';
      doctoRelacionadoComplementoPagoV1.MonedaDR           := 'MXN';
      //doctoRelacionadoComplementoPagoV1.TipoCambioDR       := '0.05';
      doctoRelacionadoComplementoPagoV1.MetodoDePagoDR     := 'PPD';
      doctoRelacionadoComplementoPagoV1.NumParcialidad     := 1;
      doctoRelacionadoComplementoPagoV1.ImpSaldoAnt        := '1000.00';  //ImpPagado + impSaldoInsoluto
      doctoRelacionadoComplementoPagoV1.ImpPagado          := '100.00';
      doctoRelacionadoComplementoPagoV1.ImpSaldoInsoluto   := '900.00';

      nuevaFactura.AgregarComplemento(complementoPagoV1,
                                      'pago10',
                                      'http://www.sat.gob.mx/Pagos',
                                      'http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd');
      {$IFDEF undef}{$ENDREGION}{$ENDIF}

      // Agregamos el impuesto local el cual se maneja de forma especial
      {$IFDEF undef}{$REGION 'Impuestos locales'}{$ENDIF}
      {impuestoLocalv1 := NewImpuestosLocalesV1;
      impuestoLocalv1.TotaldeTraslados   := TFacturacionHelper.ComoMoneda(1);
      impuestoLocalv1.TotaldeRetenciones := TFacturacionHelper.ComoMoneda(0);
      trasladosImpuestosLocalesv1 := impuestoLocalv1.TrasladosLocales.Add;
      trasladosImpuestosLocalesv1.ImpLocTrasladado := 'Otro';
      trasladosImpuestosLocalesv1.TasadeTraslado   := '0.01';
      trasladosImpuestosLocalesv1.Importe          := '1.00';

      nuevaFactura.AgregarComplemento(impuestoLocalv1,
                                      'implocal',
                                      'http://www.sat.gob.mx/implocal',
                                      'http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd'); }
      {$IFDEF undef}{$ENDREGION}{$ENDIF}
    end;

  end;
end;

end.


