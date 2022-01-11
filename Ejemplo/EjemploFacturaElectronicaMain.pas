{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit EjemploFacturaElectronicaMain;

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
  Facturacion.PAC.Comercio,
  Facturacion.ProveedorAutorizadoCertificacion, Facturacion.OpenSSL,
  Facturacion.GeneradorCBB,

  // CFDI 3.3
  Facturacion.GeneradorCBBv32,
  Facturacion.ComprobanteV33,
  Facturacion.GeneradorCadenaOrignalV33,
  Facturacion.GeneradorSelloV33,
  Facturacion.GeneradorCBBv33,

  // CFDI 4.0:
  Facturacion.ComprobanteV40,
  Facturacion.GeneradorCadenaOrignalV40,
  Facturacion.Helper,
  Facturacion.GeneradorLigaVerificacion,
  Facturacion.ImpuestosLocalesV1,
  Facturacion.ComplementoPagoV1;

  procedure Ejemplo;

implementation
 procedure Ejemplo;
 var
  nuevaFactura                                                    : IComprobanteFiscal;

  facturaCFDIv33                                                  : IComprobanteFiscalv33;
  concepto33                                                      : IComprobanteFiscalv33_Conceptos_Concepto;
  iva33                                                           : IComprobanteFiscalv33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33                                                      : IComprobanteFiscalv33_Impuestos_Traslados_Traslado;

  // Instancias especificas para v40
  facturaCFDIv40                                                  : IComprobanteFiscalv40;
  concepto40                                                      : IComprobanteFiscalv40_Conceptos_Concepto;
  iva40                                                           : IComprobanteFiscalv40_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA40                                                      : IComprobanteFiscalv40_Impuestos_Traslados_Traslado;

  // Instancia de impuestos locales v1.0 (compatible con CFDI 3.2 y 3.3)
  impuestoLocalV1                                                 : IImpuestosLocalesV1;
  trasladosImpuestosLocalesV1                                     : IImpuestosLocalesV1_TrasladosLocales;

  // Instancias comunes independientes de la version
  admonFacturas                                                   : IAdministradorFacturas;
  generadorCadena                                                 : IGeneradorCadenaOriginal;
  generadorSello                                                  : IGeneradorSello;
  openSSL                                                         : IOpenSSL;
  xmlTimbre                                                       : TCadenaUTF8;
  pac                                                             : IProveedorAutorizadoCertificacion;
  certificadoSellos                                               : ICertificadoDeSellos;
  credencialesPAC                                                 : TFacturacionCredencialesPAC;
  credencialesIntegrador                                          : TFacturacionCredencialesPAC;
  generadorCBB                                                    : IGeneradorCBB;

  queVersion, rutaCertificado, rutaLlavePrivada, claveLlavePrivada: string;
  reintentar                                                      : Boolean;
  Url_WS                                                          : String;
  cadenaOriginal, selloDeLaFactura : String;
 const
  _URL_ECODEX_PRUEBAS_V33        = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_v40        = 'https://pruebas-wsdex.ecodex.com.mx';
  _URL_FINKOK_TIMBRADO_PRUEBAS      = 'https://demo-facturacion.finkok.com/servicios/soap/stamp.wsdl';
  _URL_FINKOK_CANCELACION_PRUEBAS   = 'https://demo-facturacion.finkok.com/servicios/soap/cancel.wsdl';
  _URL_COMERCIO_PRUEBAS             = 'https://pruebas.comercio-digital.mx';
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
      Url_WS := _URL_ECODEX_PRUEBAS_v40;
     {$endif}

     {$ifdef PAC_DEMO_COMERCIODIGITAL}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.key';
      claveLlavePrivada := '12345678a';

      pac := TProveedorComercio.Create;
      CredencialesPAC.RFC   := 'AAA010101AAA';
      CredencialesPAC.Clave := 'PWD';
      Url_WS := _URL_COMERCIO_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_FINOK}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.key';
      claveLlavePrivada := '12345678a';
      
	  pac := TProveedorFinkOk.Create;
      CredencialesPAC.RFC   := 'TuUsuario';
      CredencialesPAC.Clave := 'TuPassword';
      Url_WS := _URL_FINKOK_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_SOLUCIONFACTIBLE}
      pac := TProveedorSolucionFactible.Create;
      CredencialesPAC.RFC   := 'testing@solucionfactible.com';
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
      Writeln( 'LLave Privada PEM Base64' );
      Writeln( openSSL.LlavePrivadaComoPEM );
      Writeln( '' );
      Writeln( 'Certificado PEM Base64' );
      Writeln( certificadoSellos.ContenidoPEM );
      Writeln( '' );

      // Checamos que el certificado y la llave privada sean pareja
      WriteLn('Verificando certificado de sellos y llave privada...');
      if Not openSSL.SonPareja(rutaCertificado, rutaLlavePrivada, claveLlavePrivada) then
      begin
        Writeln('Los archivos de certificado y llave privada no son pareja. Favor de verificar');
        Exit;
      end;
      WriteLn('Certificado y llave ... OK');


      //queVersion := '4.0';
      Writeln('Por favor escribe la version del CFDI que deseas generar (3.3 o 4.0):');
      ReadLn(queVersion);
      Writeln;

      Writeln('Creando instancia de PAC...');

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


          {$REGION 'CFDI 3.3'}
          if nuevaFactura.Version = '3.3' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv33, facturaCFDIv33) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v33');
              Exit;
            end;


            // Creamos las instancias correspondientes para la v33
            generadorCadena := TGeneradorCadenaOriginalv33.Create;
            generadorSello := TGeneradorSellov33.Create;
            generadorSello.Configurar(openSSL);
            generadorCBB  := TGeneradorCBBv33.Create;

            Writeln('Llenando comprobante CFDI v3.3...');
            with facturaCFDIv33 do
            begin
              Serie     := 'Ver33';
              Randomize;
              Folio     := IntToStr(Random(999999999));
              Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);

              NoCertificado := certificadoSellos.NoCertificado;
              Certificado   := certificadoSellos.ContenidoBase64;
              FormaPago         := '01'; // De catalogo
              CondicionesDePago := 'Crédito a 30 días';
              Subtotal          := '100.00'; // Solo 2 decimales
              Descuento         := TFacturacionHelper.ComoMoneda(0);
              Moneda            := 'MXN'; // De catalogo
              TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
              Total             := TFacturacionHelper.ComoMoneda(116);
              TipoDeComprobante := 'I'; // De catalogo
              MetodoPago        := 'PUE';
              LugarExpedicion   := '76030';

              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
              Emisor.RegimenFiscal := '612'; // De catalogo

              Receptor.Rfc              := Uppercase('cacx7605101p8');
              Receptor.Nombre           := 'XOTICHL CASAS CHAVEZ';
              Receptor.UsoCFDI          := 'G01';

              //Receptor.ResidenciaFiscal := 'USA'; // De cat�logo
              // Solo para cliente extranjero
              //Receptor.NumRegIdTrib     := '123456789'; // "formatoDeRegistroDeIdentidadTributaria": "[0-9]{9}",

              concepto33 := Conceptos.Add;
              concepto33.ClaveProdServ    := '52161529';  // De cat�logo
              concepto33.NoIdentificacion := '1';
              concepto33.Cantidad         := '1';
              concepto33.ClaveUnidad      := 'EA';  // De catalogo
              concepto33.Unidad           := 'PZA'; // De catalogo
              concepto33.Descripcion      := 'ALGODÃ“N 50 GR';
              concepto33.ValorUnitario    := '100.00';
              concepto33.Importe          := '100.00';
              concepto33.Descuento        := '0.00';

              iva33 := concepto33.Impuestos.Traslados.Add;
              iva33.Base        := '100.00';
              iva33.Impuesto    := '002';
              iva33.TipoFactor  := 'Tasa';
              iva33.TasaOCuota  := '0.160000';
              iva33.Importe     := '16.00';

              // NOTA: Agregamos el numero cuenta predial justo despu�s de indicar
              // los impuestos del concepto pues el orden importa.
              //concepto33.CuentaPredial.Numero := '234989';

              Impuestos.TotalImpuestosTrasladados  := '16.00';

              totalIVA33 := Impuestos.Traslados.Add;
              totalIVA33.Impuesto := '002';
              totalIVA33.TipoFactor := 'Tasa';
              totalIVA33.TasaOCuota := '0.160000';
              totalIVA33.Importe    := '16.00';

            end;
          end;

          {$ENDREGION}

          {$REGION 'CFDI 4.0'}
          if nuevaFactura.Version = '4.0' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv40, facturaCFDIv40) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v40');
              Exit;
            end;


            // Creamos las instancias correspondientes para la v40
            generadorCadena := TGeneradorCadenaOriginalv40.Create;
            generadorSello := TGeneradorSellov33.Create;
            generadorSello.Configurar(openSSL);
            generadorCBB  := TGeneradorCBBv33.Create;

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
              FormaPago         := '01'; // De cat�logo
              CondicionesDePago := 'Crédito a 30 días';
              Subtotal          := '100.00'; // Solo 2 decimales
              Descuento         := TFacturacionHelper.ComoMoneda(0);
              Moneda            := 'MXN'; // De catalogo
              TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
              Total             := TFacturacionHelper.ComoMoneda(116);
              TipoDeComprobante := 'I'; // De catalogo
              MetodoPago        := 'PUE';
              LugarExpedicion   := '76030';

              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
              Emisor.RegimenFiscal := '612'; // De catalogo

              Receptor.Rfc              := Uppercase('aabf800614hi0');
              Receptor.Nombre           := 'FELIX MANUEL ANDRADE BALLADO';
              Receptor.UsoCFDI          := 'S01';

              Receptor.DomicilioFiscalReceptor := '86400';
              Receptor.RegimenFiscalReceptor := '616';
			  
              //Receptor.ResidenciaFiscal := 'USA'; // De cat�logo
              // Solo para cliente extranjero
              //Receptor.NumRegIdTrib     := '123456789'; // "formatoDeRegistroDeIdentidadTributaria": "[0-9]{9}",

              concepto40 := Conceptos.Add;
              concepto40.ClaveProdServ    := '52161529';  // De catalogo
              concepto40.NoIdentificacion := '1';
              concepto40.Cantidad         := '1';
              concepto40.ClaveUnidad      := 'EA';  // De cat�logo
              concepto40.Unidad           := 'PZA'; // De cat�logo
              concepto40.Descripcion      := 'ALGODÃ“N 50 GR';
              concepto40.ValorUnitario    := '100.00';
              concepto40.Importe          := '100.00';
              concepto40.Descuento        := '0.00';

              concepto40.ObjetoImp        := '02';

              iva40 := concepto40.Impuestos.Traslados.Add;
              iva40.Base        := '100.00';
              iva40.Impuesto    := '002';
              iva40.TipoFactor  := 'Tasa';
              iva40.TasaOCuota  := '0.160000';
              iva40.Importe     := '16.00';

              // NOTA: Agregamos el numero cuenta predial justo despu�s de indicar
              // los impuestos del concepto pues el orden importa.
              //concepto33.CuentaPredial.Numero := '234989';

              Impuestos.TotalImpuestosTrasladados  := '16.00';

              totalIVA40 := Impuestos.Traslados.Add;
              totalIVA40.Base     := '100';
              totalIVA40.Impuesto := '002';
              totalIVA40.TipoFactor := 'Tasa';
              totalIVA40.TasaOCuota := '0.160000';
              totalIVA40.Importe    := '16.00';

            end;
          end;

          {$ENDREGION}

          // Agregamos el impuesto local el cual se maneja de forma especial
          {$IFDEF undef}{$REGION 'Impuestos locales'}{$ENDIF}
//          impuestoLocalv1 := NewImpuestosLocalesV1;
//          impuestoLocalv1.TotaldeTraslados   := TFacturacionHelper.ComoMoneda(1);
//          impuestoLocalv1.TotaldeRetenciones := TFacturacionHelper.ComoMoneda(0);
//          trasladosImpuestosLocalesv1 := impuestoLocalv1.TrasladosLocales.Add;
//          trasladosImpuestosLocalesv1.ImpLocTrasladado := 'Otro';
//          trasladosImpuestosLocalesv1.TasadeTraslado   := '0.01';
//          trasladosImpuestosLocalesv1.Importe          := '1.00';
//
//          nuevaFactura.AgregarComplemento(impuestoLocalv1,
//                                          'implocal',
//                                          'http://www.sat.gob.mx/implocal',
//                                          'http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd');
          {$IFDEF undef}{$ENDREGION}{$ENDIF}

          admonFacturas.GuardarArchivo(nuevaFactura,
                                      ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.xml');

          // Obtenemos la cadena original y sellamos la factura automaticamente
          Writeln('Sellando comprobante...');
          admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

          // 2. Si queremos obtener la Cadena Original o el Sello de forma separada:
          cadenaOriginal := generadorCadena.obtenerCadenaOriginal(nuevaFactura);
          Writeln(cadenaOriginal);
          //
          selloDeLaFactura := generadorSello.GenerarSelloDeFactura(cadenaOriginal);
          Writeln(selloDeLaFactura);

          // Dependiendo de la version usamos diferente servidor de pruebas

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
           pac.AsignarParametro(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_40);
           {$ifdef PAC_DEMO_ECODEX}
             Url_WS := _URL_ECODEX_PRUEBAS_v40;
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

          // Recibimos el timbre de forma exitosa, dejamos de "reintentar"
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
//      if Assigned(facturaCFDIv40.Complemento.TimbreFiscalDigital) then
//      begin
//         Writeln(facturaCFDIv40.Complemento.TimbreFiscalDigital.UUID);
//      end else
//         Writeln('**** NO SE TUVO TIMBRE ****');

      Writeln('Cadena Original de Timbre:');
      Writeln(generadorCadena.obtenerCadenaOriginalDeTimbre(nuevaFactura));

      if nuevaFactura.Version = '4.0' then
      begin
       Writeln('XML del Timbre');
       facturaCFDIv40.Complemento.TimbreFiscalDigital.Leyenda := '';
       Writeln( facturaCFDIv40.Complemento.TimbreFiscalDigital.XML );

       if facturaCFDIv40.Complemento.TimbreFiscalDigital.FechaTimbrado<>
          FormatDateTime('yyyy-mm-dd"T"HH:nn:ss', TFacturacionHelper.DesdeFechaISO8601( facturaCFDIv40.Complemento.TimbreFiscalDigital.FechaTimbrado ) ) then
       begin
        Writeln('La conversi�n de la Fecha Del Timbre es incorrecta');
        Writeln(' Fecha del Timbre (Original)  : '+facturaCFDIv40.Complemento.TimbreFiscalDigital.FechaTimbrado);
        Writeln(' Fecha del Timbre (Conversi�n): '+ FormatDateTime('yyyy-mm-dd"T"HH:nn:ss', TFacturacionHelper.DesdeFechaISO8601( facturaCFDIv40.Complemento.TimbreFiscalDigital.FechaTimbrado )) );
       end;
       //Agregamos una Addenda de ejemplo
       WriteLn('Agregando Addenda CFDI v4.0...');
       facturaCFDIv40.Addenda.AddChild('Ejemplo_Addenda').Attributes['observaciones'] := 'Linea 01'+sLineBreak+'Linea 02';
      end;

      Writeln('Guardando XML...');
      admonFacturas.GuardarArchivo(nuevaFactura,
                                   ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.xml');

      Writeln('Generando CBB corespondiente');
      generadorCBB.GenerarImagenCBB(nuevaFactura,
                                    ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.jpg');

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
