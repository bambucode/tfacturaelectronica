unit uEjemploFacturaGlobalV40;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV40Global(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
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

   // CFDI 4.0:
  Facturacion.ComprobanteV40,
  Facturacion.GeneradorCadenaOrignalV40,

  Facturacion.Helper,
  Facturacion.GeneradorLigaVerificacion,
  Facturacion.ImpuestosLocalesV1;

procedure GenerarFacturaV40Global(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                  generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  // Instancias especificas para v40
  facturaCFDIv40 : IComprobanteFiscalv40;
  concepto40 : IComprobanteFiscalv40_Conceptos_Concepto;
  iva40  : IComprobanteFiscalv40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA40 : IComprobanteFiscalv40_Impuestos_Traslados_Traslado;
begin
  if nuevaFactura.Version = '4.0' then
  begin
    if Not Supports(nuevaFactura, IComprobanteFiscalv40, facturaCFDIv40) then
    begin
      Writeln('nuevaFactura no fue un Comprobante Fiscal v4.0');
      Exit;
    end;

    {***********************************************************************************************
    La guia de llenado de una factura global esta en:
    http://omawww.sat.gob.mx/tramitesyservicios/Paginas/documentos/GuiallenadoCFDIglobal311221.pdf
    ***********************************************************************************************}

    with facturaCFDIv40 do
    begin
      Serie     := 'Ver40';
      Randomize;
      Folio     := IntToStr(Random(999999999));
      Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);
      Exportacion := '01';

      NoCertificado := certificadoSellos.NoCertificado;
      Certificado   := certificadoSellos.ContenidoBase64;
      FormaPago         := '01'; //
      //CondicionesDePago := 'Crédito a 30 días';
      Subtotal          := '100.00'; // Solo 2 decimales
      //Descuento         := TFacturacionHelper.ComoMoneda(0);
      Moneda            := 'MXN'; // De catalogo
      TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
      Total             := TFacturacionHelper.ComoMoneda(116);
      TipoDeComprobante := 'I'; // De catalogo
      MetodoPago        := 'PUE';
      LugarExpedicion   := '76030';

      {$REGION '**** ESPECIFICO DE CFDI GLOBAL ********'}
      InformacionGlobal.Periodicidad := '04'; // 01-Diario, 02-Semanal, 03-Quincencal, 04-Mensual, 05-Bimestral
      InformacionGlobal.Meses := '01'; // Enero
      InformacionGlobal.Año := 2022;

      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '612'; // De catalogo

      // Deben ser estos datos para la factura global
      Receptor.Nombre           := 'PUBLICO EN GENERAL';
      Receptor.Rfc              := 'XAXX010101000';

      // Este valor debe ser el mismo que el de "LugarExpedicion"
      Receptor.DomicilioFiscalReceptor := LugarExpedicion;
      // Debe ser siempre 616
      Receptor.RegimenFiscalReceptor := '616';
      Receptor.UsoCFDI               := 'S01';
      {$ENDREGION}

      concepto40 := Conceptos.Add;
      concepto40.ClaveProdServ    := '01010101';  // De catalogo
      concepto40.NoIdentificacion := '1';
      concepto40.Cantidad         := '1';
      concepto40.ClaveUnidad      := 'ACT';
      concepto40.Descripcion      := 'Venta';
      concepto40.ValorUnitario    := '100.00';
      concepto40.Importe          := '100.00';
      //concepto40.Descuento        := '0.00';
      concepto40.ObjetoImp        := '02';

      iva40 := concepto40.Impuestos.Traslados.Add;
      iva40.Base        := '100.00';
      iva40.Impuesto    := '002';
      iva40.TipoFactor  := 'Tasa';
      iva40.TasaOCuota  := '0.160000';
      iva40.Importe     := '16.00';

      Impuestos.TotalImpuestosTrasladados  := '16.00';

      totalIVA40 := Impuestos.Traslados.Add;
      totalIVA40.Base     := '100';
      totalIVA40.Impuesto := '002';
      totalIVA40.TipoFactor := 'Tasa';
      totalIVA40.TasaOCuota := '0.160000';
      totalIVA40.Importe    := '16.00';
    end;

  end;
end;

end.

