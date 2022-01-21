unit uEjemploFacturaV40;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV40(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
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

procedure GenerarFacturaV40(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                  generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  // Instancias especificas para v40
  facturaCFDIv40 : IComprobanteFiscalv40;
  concepto40 : IComprobanteFiscalv40_Conceptos_Concepto;
  iva40  : IComprobanteFiscalv40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA40 : IComprobanteFiscalv40_Impuestos_Traslados_Traslado;

  impuestoLocalV1 : IImpuestosLocalesV1;
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

    // La guia de llenado del comprobante de pago v2.0 se encuentra en:
    // http://omawww.sat.gob.mx/tramitesyservicios/Paginas/documentos/Guiallenadopagos311221.pdf

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
      CondicionesDePago := 'Crédito a 30 días';
      Subtotal          := '100.00'; // Solo 2 decimales
      Descuento         := TFacturacionHelper.ComoMoneda(0);
      Moneda            := 'MXN'; // De catalogo
      TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
      Total             := TFacturacionHelper.ComoMoneda(100 + 16);
      TipoDeComprobante := 'I'; // De catalogo
      MetodoPago        := 'PUE';
      LugarExpedicion   := '26015';

      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '601'; // De catalogo

      {$REGION 'Receptor normal'}
      Receptor.Rfc              := Uppercase('aabf800614hi0');
      // NOTA: Al parecer el SAT espera los nombres sean en mayusculas y exactamente
      // como están en la LCO
      Receptor.Nombre           := Uppercase('FELIX MANUEL ANDRADE BALLADO');
      Receptor.UsoCFDI          := 'G03';
      Receptor.DomicilioFiscalReceptor := '86400';
      Receptor.RegimenFiscalReceptor := '612';
      {$ENDREGION}

      {$REGION 'Receptor con RFC de publico en general'}
//      Receptor.Rfc              := Uppercase('XAXX010101000');
//      Receptor.Nombre           := Uppercase('Juan Perez Perez');
//      Receptor.UsoCFDI          := 'S01'; // Sin efectos fiscales para extranjeros
//      Receptor.DomicilioFiscalReceptor := LugarExpedicion;
//      Receptor.RegimenFiscalReceptor := '616'; // Sin obligaciones para extranjeros
      {$ENDREGION}

      {$REGION 'Receptor con RFC extranjero'}
//      Receptor.Rfc              := Uppercase('XEXX010101000');
//      Receptor.Nombre           := Uppercase('Joseph Biden');
//      Receptor.UsoCFDI          := 'S01'; // Sin efectos fiscales para extranjeros
//      Receptor.DomicilioFiscalReceptor := LugarExpedicion;
//      Receptor.RegimenFiscalReceptor := '616'; // Sin obligaciones para extranjeros
//      Receptor.ResidenciaFiscal := 'USA'; // De catalogo
//      // Solo para cliente extranjero
//      Receptor.NumRegIdTrib     := '123456789'; // "formatoDeRegistroDeIdentidadTributaria": "[0-9]{9}",
      {$ENDREGION}

      concepto40 := Conceptos.Add;
      concepto40.ClaveProdServ    := '52161529';  // De catalogo
      concepto40.NoIdentificacion := '1';
      concepto40.Cantidad         := '1';
      concepto40.ClaveUnidad      := 'EA';
      concepto40.Unidad           := 'PZA';
      concepto40.Descripcion      := 'Algodón 50gr áéíúó';
      concepto40.ValorUnitario    := '100.00';
      concepto40.Importe          := '100.00';
      concepto40.Descuento        := '0.00';

      {$REGION 'Con IVA 16%'}
      concepto40.ObjetoImp        := '02';

      iva40 := concepto40.Impuestos.Traslados.Add;
      iva40.Base        := '100.00';
      iva40.Impuesto    := '002';
      iva40.TipoFactor  := 'Tasa';
      iva40.TasaOCuota  := '0.160000';
      iva40.Importe     := '16.00';
//
        Impuestos.TotalImpuestosTrasladados  := '16.00';

        totalIVA40 := Impuestos.Traslados.Add;
        totalIVA40.Base     := '100';
        totalIVA40.Impuesto := '002';
        totalIVA40.TipoFactor := 'Tasa';
        totalIVA40.TasaOCuota := '0.160000';
        totalIVA40.Importe    := '16.00';
      {$ENDREGION}

//      {$REGION 'Con IVA exento'}
//      concepto40.ObjetoImp        := '02';
//      iva40 := concepto40.Impuestos.Traslados.Add;
//      iva40.Base        := '100.00';
//      iva40.Impuesto    := '002';
//      iva40.TipoFactor  := 'Exento';
//      //iva40.TasaOCuota  := '0.160000';
//      //iva40.Importe     := '16.00';
//
//      //Impuestos.TotalImpuestosTrasladados  := '0.00';
//
//      totalIVA40 := Impuestos.Traslados.Add;
//      totalIVA40.Base     := '100';
//      totalIVA40.Impuesto := '002';
//      totalIVA40.TipoFactor := 'Exento';
//      //totalIVA40.Importe  := '0.00';
//      {$ENDREGION}

      // NOTA: Agregamos el numero cuenta predial justo despues de indicar
      // los impuestos del concepto pues el orden importa.
      //concepto33.CuentaPredial.Numero := '234989';


    end;

//    // Agregamos el impuesto local el cual se maneja de forma especial
//    impuestoLocalv1 := NewImpuestosLocalesV1;
//    impuestoLocalv1.TotaldeTraslados   := TFacturacionHelper.ComoMoneda(1);
//    impuestoLocalv1.TotaldeRetenciones := TFacturacionHelper.ComoMoneda(0);
//    trasladosImpuestosLocalesv1 := impuestoLocalv1.TrasladosLocales.Add;
//    trasladosImpuestosLocalesv1.ImpLocTrasladado := 'Otro';
//    trasladosImpuestosLocalesv1.TasadeTraslado   := '0.01';
//    trasladosImpuestosLocalesv1.Importe          := '1.00';
//
//    nuevaFactura.AgregarComplemento(impuestoLocalv1,
//                                    'implocal',
//                                    'http://www.sat.gob.mx/implocal',
//                                    'http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd');

  end;
end;

end.


