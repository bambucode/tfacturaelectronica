{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit EjemploFacturaElectronicaComplementoPagoMain;

interface
uses
  Forms,
  SysUtils,
  ActiveX,
  Facturacion.Administrador, Facturacion.CertificadoDeSellos,
  Facturacion.Comprobante,  Facturacion.GeneradorCadenaOriginal,
  Facturacion.GeneradorQR, Facturacion.GeneradorSello,
  Facturacion.PAC.Ecodex,
  Facturacion.PAC.MultiFacturas,
  Facturacion.PAC.FInkOk,
  Facturacion.PAC.SolucionFactible,
  Facturacion.ProveedorAutorizadoCertificacion, Facturacion.OpenSSL,
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

  procedure Ejemplo;

implementation

 procedure Ejemplo;
 var
  nuevaFactura : IComprobanteFiscal;

  // Instancias especificas para V33
  facturaCFDIv33 : IComprobanteFiscalV33;
  concepto33 : IComprobanteFiscalV33_Conceptos_Concepto;
  iva33 : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33 : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;

  // Instancia de complemento de pago v1.0 (compatible con CFDI 3.2 y 3.3)
  complementoPagoV1: IPagosV1;
  pagoComplementPagoV1: IPagos_PagoV1;
  doctoRelacionadoListV1 : IPagos_Pago_DoctoRelacionadoListV1;
  doctoRelacionadoComplementoPagoV1: IPagos_Pago_DoctoRelacionadoV1;


  // Instancias especificas para v40
  facturaCFDIv40 : IComprobanteFiscalv40;
  concepto40 : IComprobanteFiscalv40_Conceptos_Concepto;
  iva40  : IComprobanteFiscalv40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA40 : IComprobanteFiscalv40_Impuestos_Traslados_Traslado;

   // Instancia de complemento de pago v2.0 (compatible con CFDI 4.4)
  complementoPagoV2: IPagosV20;
  pagoComplementPagoV2: IPagosV20_Pago;
  doctoRelacionadoListV2 : IPagosV20_Pago_DoctoRelacionadoList;
  doctoRelacionadoComplementoPagoV2: IPagosV20_Pago_DoctoRelacionado;
  impuestosTrasladadosV2 : IPagosV20_Pago_ImpuestosP_TrasladosP_TrasladoP;
  impuestoTrasladadoDocRelacionadoV2 : IPagosV20_Pago_DoctoRelacionado_ImpuestosDR_TrasladosDR_TrasladoDR;

  // Instancia de impuestos locales v1.0 (compatible con CFDI 3.2 y 3.3)
  impuestoLocalV1: IImpuestosLocalesV1;
  trasladosImpuestosLocalesV1: IImpuestosLocalesV1_TrasladosLocales;



  // Instancias comunes independientes de la version
  cadenaOriginal : TCadenaUTF8;
  admonFacturas: IAdministradorFacturas;
  generadorCadena : IGeneradorCadenaOriginal;
  generadorSello : IGeneradorSello;
  openSSL : IOpenSSL;
  selloDeLaFactura, xmlTimbre : TCadenaUTF8;
  pac: IProveedorAutorizadoCertificacion;
  certificadoSellos: ICertificadoDeSellos;
  credencialesPAC : TFacturacionCredencialesPAC;
  credencialesIntegrador : TFacturacionCredencialesPAC;
  generadorCBB: IGeneradorCBB;
  cadenaOriginalPago : TCadenaUTF8;

  rutaCertificado, rutaLlavePrivada, claveLlavePrivada, queVersion: string;
  reintentar: Boolean;
  Url_WS: String;
 const
   _URL_ECODEX_PRUEBAS_V33        = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_v40        = 'https://pruebas-wsdex.ecodex.com.mx';
  _URL_FINKOK_PRUEBAS            = 'http://demo-facturacion.finkok.com/servicios/soap';
  _URL_COMERCIO_PRUEBAS          = 'https://pruebas.comercio-digital.mx';
  _URL_SOLUCIONFACTIBLE_PRUEBAS  = 'https://testing.solucionfactible.com/ws/services/Timbrado';
  _URL_MULTIFACTURAS_PRUEBAS     = 'http://ws.facturacionmexico.com.mx/pac/timbrarjava.php';   //SE DEBE ESPECIFICAR QUE ES MODO PRODUCCION
  _NUMERO_TRANSACCION_INICIAL    = 1;

  //Hablitar solo una de las siguientes opciones
  {$define PAC_DEMO_ECODEX}
  {.$define PAC_DEMO_FINOK}
  {.$define PAC_DEMO_COMERCIODIGITAL}
  {.$define PAC_DEMO_SOLUCIONFACTIBLE}
  {.$define PAC_DEMO_MULTIFACTURAS}

 begin
  CoInitialize(nil);
  Randomize;
  try
    try
      {
       NOTAS:
         Recuerde que para realizar pruebas con Soluci�n Factible debe registrarse con el PAC para el proceso de pruebas.
         Para realizar pruebas con Edicom, se requiere una cuenta valida registrada en el PAC
      }

      //Este certificado se usa en casi todo los PACs para realizar pruebas
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_XOJI740919U48.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_XOJI740919U48.key';
      claveLlavePrivada := '12345678a';

     // Configuramos al PAC con los datos para pruebas
     {$ifdef PAC_DEMO_ECODEX}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_XOJI740919U48.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_XOJI740919U48.key';
      claveLlavePrivada := '12345678a';

      pac := TProveedorEcodex.Create;
      credencialesPAC.RFC                   := 'XOJI740919U48';
      credencialesPAC.DistribuidorID        := '2b3a8764-d586-4543-9b7e-82834443f219';

      credencialesIntegrador.RFC            := 'BBB010101001';
      credencialesIntegrador.DistribuidorID := 'DF627BC3-A872-4806-BF37-DBD040CBAC7C';
      Url_WS := _URL_ECODEX_PRUEBAS_V33;
     {$endif}

     {$ifdef PAC_DEMO_COMERCIODIGITAL}
      pac := TProveedorComercio.Create;
      CredencialesPAC.RFC   := 'AAA010101AAA';
      CredencialesPAC.Clave := 'PWD';
      Url_WS := _URL_COMERCIO_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_FINOK}
      pac := TProveedorFinkOk.Create;
      CredencialesPAC.RFC   := 'TuUsuario';
      CredencialesPAC.Clave := 'TuPassword';
      Url_WS := _URL_FINKOK_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_SOLUCIONFACTIBLE}
      pac := TProveedorSolucionFactible.Create;
      CredencialesPAC.RFC   := 'testing@solucionfactible.com';;
      CredencialesPAC.Clave := 'timbrado.SF.16672';
      Url_WS := _URL_SOLUCIONFACTIBLE_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_MULTIFACTURAS}
      pac := TProveedorMultiFacturas.Create;
      CredencialesPAC.RFC   := 'DEMO700101XXX';
      CredencialesPAC.Clave := 'DEMO700101XXX';
      Url_WS := _URL_MULTIFACTURAS_PRUEBAS;
     {$endif}

     if not assigned(pac) then
      begin
        Writeln('El PAC no ha sido especificado,'+#10#13+
                'En la parte superior de este ejemplo, defina un PAC ({$define PAC_DEMO_XXXX}) para usar en el timbrado');

        Writeln('Presiona cualquier tecla para salir...');
        Readln;
        exit;
      end;

      openSSL := TOpenSSL.Create;
      openSSL.AsignarLlavePrivada(rutaLlavePrivada,
                                  claveLlavePrivada);

      certificadoSellos := TCertificadoDeSellos.Create;
      certificadoSellos.Leer(rutaCertificado);

      // Checamos que el certificado y la llave privada sean pareja
      WriteLn('Verificando certificado de sellos y llave privada...');
      if Not openSSL.SonPareja(rutaCertificado, rutaLlavePrivada, claveLlavePrivada) then
      begin
        Writeln('Los archivos de certificado y llave privada no son pareja. Favor de verificar');
        Exit;
      end;
      WriteLn('Certificado y llave ... OK');


      {$IFDEF FullDebugMode}
        Writeln('FastMM4 Habilitado :)');
      {$ENDIF}

      Writeln('Por favor escribe la version del CFDI con complemento de pagos que deseas generar (3.3 o 4.0):');
      //ReadLn(queVersion);
      queVersion := '4.0';
      Writeln;

      // Inicializamos la variable de re-intentar en verdadero para intentar timbrar
      // cada vez que falle el servicio del PAC
      reintentar := True;
      while reintentar do
      begin
        try
          // Generamos una nueva factura
          admonFacturas := TAdministradorFacturas.Create;
          nuevaFactura := admonFacturas.Nueva(queVersion);
          Writeln('Generando CFDI v' + nuevaFactura.Version + '...');

          {$IFDEF undef}{$REGION 'Factura V33'}{$ENDIF}
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
            generadorCBB  := TGeneradorCBBv33.Create;

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
              TipoDeComprobante  := 'P';      // De cat�logo
              LugarExpedicion    := '76030';

              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
              Emisor.RegimenFiscal := '612'; // De cat�logo

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
          {$IFDEF undef}{$ENDREGION}{$ENDIF}

          {$IFDEF undef}{$REGION 'Factura V40'}{$ENDIF}
          if nuevaFactura.Version = '4.0' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv40, facturaCFDIv40) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v4.0');
              Exit;
            end;


            // Creamos las instancias correspondientes para la v33
            generadorCadena := TGeneradorCadenaOriginalV40.Create;
            generadorSello := TGeneradorSelloV33.Create;
            generadorSello.Configurar(openSSL);
            generadorCBB  := TGeneradorCBBv33.Create;

            Writeln('Llenando comprobante CFDI v4.0...');
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
              TipoDeComprobante  := 'P';      // De cat�logo
              LugarExpedicion    := '76030';
              Exportacion        := '01';


              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
              Emisor.RegimenFiscal := '612'; // De cat�logo

              Receptor.Rfc              := Uppercase('cacx7605101p8');
              Receptor.Nombre           := 'XOTICHL CASAS CHAVEZ';
              Receptor.UsoCFDI          := 'G01';
              Receptor.DomicilioFiscalReceptor := '76030';
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

              {$IFDEF undef}{$REGION 'Complemento Pagos'}{$ENDIF}
              complementoPagoV2 := NewComplementoPagoV20;

              // El primer nodo especificado debe ser el de los totales de los abonos
              complementoPagoV2.Totales.TotalTrasladosBaseIVA16 := '100';
              complementoPagoV2.Totales.TotalTrasladosImpuestoIVA16 := '16';
              complementoPagoV2.Totales.MontoTotalPagos := '100';

              // Agregamos el pago
              pagoComplementPagoV2 := complementoPagoV2.Pago.Add;
              pagoComplementPagoV2.FechaPago        := TFacturacionHelper.ComoFechaISO8601(Now);
              pagoComplementPagoV2.FormaDePagoP     := '02';
              pagoComplementPagoV2.MonedaP          := 'MXN';
              pagoComplementPagoV2.TipoCambioP      := '1';
              pagoComplementPagoV2.Monto            := '100.00';
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
              doctoRelacionadoComplementoPagoV2.ImpSaldoAnt        := '1000.00';  //ImpPagado + impSaldoInsoluto
              doctoRelacionadoComplementoPagoV2.ImpPagado          := '100';
              doctoRelacionadoComplementoPagoV2.ImpSaldoInsoluto   := '900.00';
              doctoRelacionadoComplementoPagoV2.ObjetoImpDR        := '02';

              // Desglosamos los impuestos del abono: IVA 16%, IVA 0%, etc.
              impuestoTrasladadoDocRelacionadoV2 := doctoRelacionadoComplementoPagoV2.ImpuestosDR.TrasladosDR.Add;
              impuestoTrasladadoDocRelacionadoV2.BaseDR := '100';
              impuestoTrasladadoDocRelacionadoV2.ImpuestoDR := '002';
              impuestoTrasladadoDocRelacionadoV2.TipoFactorDR := 'Tasa';
              impuestoTrasladadoDocRelacionadoV2.TasaOCuotaDR := '0.160000';
              impuestoTrasladadoDocRelacionadoV2.ImporteDR := '16';


              // Agregamos el resumen del pago
              impuestosTrasladadosV2 := pagoComplementPagoV2.ImpuestosP.TrasladosP.Add;
              impuestosTrasladadosV2.BaseP := '100';
              impuestosTrasladadosV2.ImpuestoP := '002'; // De cat�logos
              impuestosTrasladadosV2.TipoFactorP := 'Tasa';
              impuestosTrasladadosV2.TasaOCuotaP := '0.160000';
              impuestosTrasladadosV2.ImporteP := '16';

              nuevaFactura.AgregarComplemento(complementoPagoV2,
                                              'pago20',
                                              'http://www.sat.gob.mx/Pagos20',
                                              'http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd');
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
          {$IFDEF undef}{$ENDREGION}{$ENDIF}


          // Obtenemos la cadena original y sellamos la factura automaticamente
          Writeln('Sellando comprobante...');
          admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

          admonFacturas.GuardarArchivo(nuevaFactura, ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi-pre-pago.xml');

          // 2. Si queremos obtener la Cadena Original o el Sello de forma separada:
           cadenaOriginal := generadorCadena.obtenerCadenaOriginal(nuevaFactura);
           Writeln(cadenaOriginal);

           selloDeLaFactura := generadorSello.GenerarSelloDeFactura(cadenaOriginal);
           Writeln(selloDeLaFactura);

          {
          pac.AsignarParametro(PAC_PARAM_SEGURIDAD_CERTIFICADO, certificadoSellos.ContenidoBase64);
          pac.AsignarParametro(PAC_PARAM_SEGURIDAD_LLAVEPRIVADA, openSSL.LlavePrivadaComoBase64);
          pac.AsignarParametro(PAC_PARAM_SEGURIDAD_LLAVEPRIVADA_CLAVE, claveLlavePrivada);

          }

          //Especificar que se encuentra en modo de pruebas
          pac.AsignarParametro(PAC_PARAM_SVC_CFG_MODO_PRODUCCION, PAC_VALOR_NO);
          pac.AsignarParametro(PAC_PARAM_SVC_CFG_MULTIPLES_URLS, PAC_VALOR_NO);

          if nuevaFactura.Version = '4.0' then
          begin
           pac.AsignarParametro(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_33);
           {$ifdef PAC_DEMO_ECODEX}
             Url_WS := _URL_ECODEX_PRUEBAS_V40;
           {$endif}
          end
          else
          begin
           pac.AsignarParametro(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_32);
           {$ifdef PAC_DEMO_ECODEX}
             Url_WS := _URL_ECODEX_PRUEBAS_V33;
           {$endif}
          end;

          pac.Configurar(Url_WS,
                         Url_WS,
                         Url_WS,
                         credencialesPAC,
                         credencialesIntegrador,
                         _NUMERO_TRANSACCION_INICIAL);
          // 4. La mandamos timbrar
          Writeln('Intentando timbrar comprobante...');
          xmlTimbre := pac.TimbrarDocumento(nuevaFactura, Random(9999));

          Writeln('Asignando Timbre Fiscal al comprobante...');
          nuevaFactura.AsignarTimbreFiscal(xmlTimbre);

//          // Recibimos el timbre de forma exitosa, dejamos de "reintentar"
          reintentar := False;
        except
          On E: EPACErrorGenericoException do
          begin
            Writeln('--------------------------------------------------');
            Writeln('Problema temporal al timbrar, re-intentando en 3 segundos: ', E.Message);
            Sleep(3000);
          end;
        end;
      end;

      // Checamos tener el Timbre Fiscal
//      if Assigned(facturaCFDIv33.Complemento.TimbreFiscalDigital) then
//      begin
//         Writeln(facturaCFDIv33.Complemento.TimbreFiscalDigital.UUID);
//      end else
//         Writeln('**** NO SE TUVO TIMBRE ****');

//      Writeln('Cadena Original de Timbre:');
//      Writeln(generadorCadena.obtenerCadenaOriginalDeTimbre(nuevaFactura));

      Writeln('Guardando XML...');
      admonFacturas.GuardarArchivo(nuevaFactura,
                                  ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi-pago.xml');

//      Writeln('Generando CBB corespondiente');
//      generadorCBB.GenerarImagenCBB(nuevaFactura,
//                                    ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi-pago.jpg');

      Writeln('Generacion de CFDI v' + nuevaFactura.Version + ' exitoso.');
      Writeln;
      Writeln('Presiona cualquier tecla para salir...');
      Readln;
    except
      on E: Exception do
      begin
        Writeln('** Ocurrio un error inesperado: ');
        Writeln(E.ClassName, ': ', E.Message);
        Writeln('Presiona cualquier tecla para salir...');
        Readln;
      end;
    end;
  finally
    CoInitialize(nil);
  end;
 end;
end.
