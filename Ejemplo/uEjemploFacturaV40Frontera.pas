unit uEjemploFacturaV40Frontera;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV40Frontera(var nuevaFactura: IComprobanteFiscal;
    openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
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

procedure GenerarFacturaV40Frontera(var nuevaFactura: IComprobanteFiscal;
         openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
        generadorCadena: IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  // Instancias especificas para v40
  facturaCFDIv40 : IComprobanteFiscalv40;
  concepto40 : IComprobanteFiscalv40_Conceptos_Concepto;
  iva40  : IComprobanteFiscalv40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA40 : IComprobanteFiscalv40_Impuestos_Traslados_Traslado;
  trasladosImpuestosLocalesV1 : IImpuestosLocalesV1_TrasladosLocales;
begin

  if nuevaFactura.Version = '4.0' then
  begin
    if Not Supports(nuevaFactura, IComprobanteFiscalv40, facturaCFDIv40) then
    begin
      Writeln('nuevaFactura no fue un Comprobante Fiscal v4.0');
      Exit;
    end;

    Writeln('Llenando comprobante CFDI v4.0...');

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
      Subtotal          := '100.00'; // Solo 2 decimales
      Descuento         := TFacturacionHelper.ComoMoneda(0);
      Moneda            := 'MXN'; // De catalogo
      TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
      Total             := TFacturacionHelper.ComoMoneda(108);
      TipoDeComprobante := 'I'; // De catalogo
      MetodoPago        := 'PUE';
      LugarExpedicion   := '26015';

      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '601'; // De catalogo

      {$REGION 'Receptor normal'}
      Receptor.Rfc              := Uppercase('aabf800614hi0');
      // NOTA: Al parecer el SAT espera los nombres sean en mayusculas y exactamente
      // como est�n en la LCO
      Receptor.Nombre           := Uppercase('FELIX MANUEL ANDRADE BALLADO');
      Receptor.UsoCFDI          := 'G03';
      Receptor.DomicilioFiscalReceptor := '86400';
      Receptor.RegimenFiscalReceptor := '612';
      {$ENDREGION}

      concepto40 := Conceptos.Add;
      concepto40.ClaveProdServ    := '52161529';  // De catalogo
      concepto40.NoIdentificacion := '1';
      concepto40.Cantidad         := '1';
      concepto40.ClaveUnidad      := 'EA';
      concepto40.Unidad           := 'PZA';
      concepto40.Descripcion      := 'Algodon';
      concepto40.ValorUnitario    := '100.00';
      concepto40.Importe          := '100.00';
      concepto40.Descuento        := '0.00';

      concepto40.ObjetoImp        := '02';

      iva40 := concepto40.Impuestos.Traslados.Add;
      iva40.Base        := '100.00';
      iva40.Impuesto    := '002';
      iva40.TipoFactor  := 'Tasa';
      iva40.TasaOCuota  := '0.080000';
      iva40.Importe     := '8.00';

      // NOTA: Agregamos el numero cuenta predial justo despues de indicar
      // los impuestos del concepto pues el orden importa.
      //concepto33.CuentaPredial.Numero := '234989';

      Impuestos.TotalImpuestosTrasladados  := '8.00';

      totalIVA40 := Impuestos.Traslados.Add;
      totalIVA40.Base     := '100';
      totalIVA40.Impuesto := '002';
      totalIVA40.TipoFactor := 'Tasa';
      totalIVA40.TasaOCuota := '0.080000';
      totalIVA40.Importe    := '8.00';
    end;
  end;

end;

end.


