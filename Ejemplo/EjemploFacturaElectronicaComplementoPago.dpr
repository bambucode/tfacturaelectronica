{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

program EjemploFacturaElectronicaComplementoPago;

{$APPTYPE CONSOLE}

{$R *.res}

// Incluimos el archivo de recurso .RC que contiene los XSLTs para generar las cadenas originales


// �Se quiere soporte para el Debugger FASTMM?
{$IFDEF FASTMM}
  {$INCLUDE FastMM4Options.inc}
{$ENDIF}

{$R *.dres}
uses
  activex,
  SysUtils,
  Forms,
  Facturacion.ComprobanteV33 in '..\Versiones\Facturacion.ComprobanteV33.pas',
  Facturacion.Comprobante in '..\Versiones\Facturacion.Comprobante.pas',
  Facturacion.Administrador in '..\Facturacion.Administrador.pas',
  Facturacion.GeneradorCadenaOriginal in '..\Facturacion.GeneradorCadenaOriginal.pas',
  Facturacion.GeneradorCadenaOrignalV33 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV33.pas',
  Facturacion.GeneradorSello in '..\Facturacion.GeneradorSello.pas',
  Facturacion.OpenSSL in '..\Facturacion.OpenSSL.pas',
  Facturacion.GeneradorSelloV33 in '..\Versiones\Facturacion.GeneradorSelloV33.pas',
  Facturacion.PAC.Ecodex in '..\PACs\Ecodex\Facturacion.PAC.Ecodex.pas',
  Facturacion.ProveedorAutorizadoCertificacion in '..\Facturacion.ProveedorAutorizadoCertificacion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsClientes in '..\PACs\Ecodex\EcodexWsClientes.pas',
  EcodexWsComun in '..\PACs\Ecodex\EcodexWsComun.pas',
  EcodexWsSeguridad in '..\PACs\Ecodex\EcodexWsSeguridad.pas',
  EcodexWsTimbrado in '..\PACs\Ecodex\EcodexWsTimbrado.pas',
  EcodexWsCancelacion in '..\PACs\Ecodex\EcodexWsCancelacion.pas',
  Facturacion.GeneradorCBB in '..\Facturacion.GeneradorCBB.pas',
  Facturacion.GeneradorQRQuricol in '..\Facturacion.GeneradorQRQuricol.pas',
  Facturacion.GeneradorLigaVerificacion in '..\Facturacion.GeneradorLigaVerificacion.pas',
  Facturacion.PAC.FInkOk in '..\PACs\FinkOK\Facturacion.PAC.FInkOk.pas',
  FinkOkWsTimbrado in '..\PACs\FinkOK\FinkOkWsTimbrado.pas',
  Facturacion.PAC.SolucionFactible in '..\PACs\SolucionFactible\Facturacion.PAC.SolucionFactible.pas',
  SolucionFactibleWsTimbrado in '..\PACs\SolucionFactible\SolucionFactibleWsTimbrado.pas',
  Facturacion.PAC.MultiFacturas in '..\PACs\MultiFacturas\Facturacion.PAC.MultiFacturas.pas',
  MultiFacturasWsTimbrado in '..\PACs\MultiFacturas\MultiFacturasWsTimbrado.pas',
  Facturacion.CertificadoDeSellos in '..\Facturacion.CertificadoDeSellos.pas',
  Facturacion.Helper in '..\Facturacion.Helper.pas',
  Facturacion.ManejadorErroresComunesWebServices in '..\PACs\Facturacion.ManejadorErroresComunesWebServices.pas',
  Facturacion.GeneradorCBBv33 in '..\Versiones\Facturacion.GeneradorCBBv33.pas',
  DelphiZXIngQRCode in '..\Lib\DelphiZXIngQRCode.pas',
  Facturacion.GeneradorQR in '..\Facturacion.GeneradorQR.pas',
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas',
  Facturacion.ComprobanteV32 in '..\Versiones\Facturacion.ComprobanteV32.pas',
  Facturacion.TimbreFiscalDigitalV32 in '..\Versiones\Facturacion.TimbreFiscalDigitalV32.pas',
  Facturacion.GeneradorCadenaOrignalV32 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV32.pas',
  Facturacion.GeneradorSelloV32 in '..\Versiones\Facturacion.GeneradorSelloV32.pas',
  Facturacion.GeneradorCBBv32 in '..\Versiones\Facturacion.GeneradorCBBv32.pas',
  Facturacion.Tipos in '..\Facturacion.Tipos.pas',
  Facturacion.ImpuestosLocalesV1 in '..\Versiones\Facturacion.ImpuestosLocalesV1.pas',
  Facturacion.ComplementoPagoV1 in '..\Versiones\Facturacion.ComplementoPagoV1.pas';

var
  nuevaFactura : IComprobanteFiscal;

  // Instancias especificas para V33
  facturaCFDIv33 : IComprobanteFiscalV33;
  concepto33 : IComprobanteFiscalV33_Conceptos_Concepto;
  iva33 : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33 : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;

  // Instancia de impuestos locales v1.0 (compatible con CFDI 3.2 y 3.3)
  impuestoLocalV1: IImpuestosLocalesV1;
  trasladosImpuestosLocalesV1: IImpuestosLocalesV1_TrasladosLocales;

  // Instancia de complemento de pago v1.0 (compatible con CFDI 3.2 y 3.3)
  complementoPagoV1: IPagosV1;
  pagoComplementPagoV1: IPagos_PagoV1;
  doctoRelacionadoListV1 : IPagos_Pago_DoctoRelacionadoListV1;
  doctoRelacionadoComplementoPagoV1: IPagos_Pago_DoctoRelacionadoV1;

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

  rutaCertificado, rutaLlavePrivada, claveLlavePrivada: string;
  reintentar: Boolean;
  Url_WS: String;
const
  _URL_ECODEX_PRUEBAS_V32        = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_V33        = 'https://wsdev.ecodex.com.mx:2045';
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
  try
    try
      {
       NOTAS:
         Recuerde que para realizar pruebas con Soluci�n Factible debe registrarse con el PAC para el proceso de pruebas.
         Para realizar pruebas con Edicom, se requiere una cuenta valida registrada en el PAC
      }

      //Este certificado se usa en casi todo los PACs para realizar pruebas
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_LAN7008173R5.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_LAN7008173R5.key';
      claveLlavePrivada := '12345678a';

     // Configuramos al PAC con los datos para pruebas
     {$ifdef PAC_DEMO_ECODEX}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.key';
      claveLlavePrivada := '12345678a';

      pac := TProveedorEcodex.Create;
      credencialesPAC.RFC                   := 'VOC990129I26';
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

      Writeln('Este ejemplo solo genera y timbrar un CFDI 3.3 con complemento de pagos, presiona cualquier tecla para continuar...');
      ReadLn;
      Writeln;

      // Inicializamos la variable de re-intentar en verdadero para intentar timbrar
      // cada vez que falle el servicio del PAC
      reintentar := True;
      while reintentar do
      begin
        try
          // Generamos una nueva factura
          admonFacturas := TAdministradorFacturas.Create;
          nuevaFactura := admonFacturas.Nueva('3.3');
          Writeln('Generando CFDI v' + nuevaFactura.Version + '...');

          if nuevaFactura.Version = '3.3' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv33, facturaCFDIv33) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v33');
              Exit;
            end;

            {$IFDEF undef}{$REGION 'Factura V33'}{$ENDIF}
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
              Emisor.RegimenFiscal := '601'; // De cat�logo

              Receptor.Rfc         := 'MTI0806042N7';
              Receptor.Nombre      := 'Juan & Jos� & ''Ni�o'' & "Ni�a"';
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
            {$IFDEF undef}{$ENDREGION}{$ENDIF}
          end;


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

          if nuevaFactura.Version = '3.3' then
          begin
           pac.AsignarParametro(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_33);
           {$ifdef PAC_DEMO_ECODEX}
             Url_WS := _URL_ECODEX_PRUEBAS_V33;
           {$endif}
          end
          else
          begin
           pac.AsignarParametro(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_32);
           {$ifdef PAC_DEMO_ECODEX}
             Url_WS := _URL_ECODEX_PRUEBAS_V32;
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
          Randomize;
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
end.
