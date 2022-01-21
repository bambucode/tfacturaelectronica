unit uEjemploFacturaV33;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL,
     Facturacion.GeneradorSello,
     Facturacion.GeneradorCadenaOriginal,
     Facturacion.CertificadoDeSellos;

procedure GenerarFacturaV33(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
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

procedure GenerarFacturaV33(var nuevaFactura: IComprobanteFiscal; openSSL: IOpenSSL; certificadoSellos: ICertificadoDeSellos;
                                  generadorCadena : IGeneradorCadenaOriginal; generadorSello : IGeneradorSello);
var
  // Instancias especificas para V33
  facturaCFDIv33 : IComprobanteFiscalV33;
  concepto33 : IComprobanteFiscalV33_Conceptos_Concepto;
  iva33 : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33 : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
  // Instancia de impuestos locales v1.0 (compatible con CFDI 3.2 y 3.3)
  impuestoLocalV1 : IImpuestosLocalesV1;
  trasladosImpuestosLocalesV1 : IImpuestosLocalesV1_TrasladosLocales;
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
      Serie     := 'Ver33';
      Randomize;
      Folio     := IntToStr(Random(999999999));
      Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);

      NoCertificado := certificadoSellos.NoCertificado;
      Certificado   := certificadoSellos.ContenidoBase64;
      FormaPago         := '01'; // De catálogo
      CondicionesDePago := 'Crédito a 30 días';
      Subtotal          := '100.00'; // Solo 2 decimales
      Descuento         := TFacturacionHelper.ComoMoneda(0);
      Moneda            := 'MXN'; // De catálogo
      TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
      Total             := TFacturacionHelper.ComoMoneda(117);
      TipoDeComprobante := 'I'; // De catálogo
      MetodoPago        := 'PUE';
      LugarExpedicion   := '26015';

      Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
      Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
      Emisor.RegimenFiscal := '601'; // De catálogo

      //Receptor.Rfc              := 'MTI0806042N7';
      Receptor.Rfc              := 'XEXX010101000';
      Receptor.Nombre           := 'Juan & José & ''Niño'' & "Niña"';
      Receptor.UsoCFDI          := 'G01';

      Receptor.ResidenciaFiscal := 'USA'; // De catálogo
      // Solo para cliente extranjero
      Receptor.NumRegIdTrib     := '123456789'; // "formatoDeRegistroDeIdentidadTributaria": "[0-9]{9}",

      concepto33 := Conceptos.Add;
      concepto33.ClaveProdServ    := '52161529';  // De catálogo
      concepto33.NoIdentificacion := '1';
      concepto33.Cantidad         := '1';
      concepto33.ClaveUnidad      := 'EA';  // De catálogo
      concepto33.Unidad           := 'PZA'; // De catálogo
      concepto33.Descripcion      := TFacturacionHelper.LimpiarCaracteresInvalidos('ÑñáÁéÉíÍóÓúÚü & "`''Concepto No 1');
      concepto33.ValorUnitario    := '100.00';
      concepto33.Importe          := '100.00';
      concepto33.Descuento        := '0.00';

      iva33 := concepto33.Impuestos.Traslados.Add;
      iva33.Base        := '100.00';
      iva33.Impuesto    := '002';
      iva33.TipoFactor  := 'Tasa';
      iva33.TasaOCuota  := '0.160000';
      iva33.Importe     := '16.00';

      // NOTA: Agregamos el numero cuenta predial justo después de indicar
      // los impuestos del concepto pues el orden importa.
      concepto33.CuentaPredial.Numero := '234989';

      Impuestos.TotalImpuestosTrasladados  := '16.00';

      totalIVA33 := Impuestos.Traslados.Add;
      totalIVA33.Impuesto := '002';
      totalIVA33.TipoFactor := 'Tasa';
      totalIVA33.TasaOCuota := '0.160000';
      totalIVA33.Importe    := '16.00';

    end;
    {$IFDEF undef}{$ENDREGION}{$ENDIF}

    // Agregamos el impuesto local el cual se maneja de forma especial
    {$IFDEF undef}{$REGION 'Impuestos locales'}{$ENDIF}
    impuestoLocalv1 := NewImpuestosLocalesV1;
    impuestoLocalv1.TotaldeTraslados   := TFacturacionHelper.ComoMoneda(1);
    impuestoLocalv1.TotaldeRetenciones := TFacturacionHelper.ComoMoneda(0);
    trasladosImpuestosLocalesv1 := impuestoLocalv1.TrasladosLocales.Add;
    trasladosImpuestosLocalesv1.ImpLocTrasladado := 'Otro';
    trasladosImpuestosLocalesv1.TasadeTraslado   := '0.01';
    trasladosImpuestosLocalesv1.Importe          := '1.00';

    nuevaFactura.AgregarComplemento(impuestoLocalv1,
                                    'implocal',
                                    'http://www.sat.gob.mx/implocal',
                                    'http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd');

  end;
end;

end.


