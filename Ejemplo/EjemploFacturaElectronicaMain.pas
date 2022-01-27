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
  Facturacion.ProveedorAutorizadoCertificacion, Facturacion.OpenSSL,
  Facturacion.GeneradorCBB,
  Facturacion.GeneradorCadenaOrignalV33, Facturacion.GeneradorSelloV33, Facturacion.GeneradorCBBv33,
  Facturacion.GeneradorCadenaOrignalV40,
  Facturacion.Helper,
  Facturacion.GeneradorLigaVerificacion,
  Facturacion.ImpuestosLocalesV1,
  uEjemploCancelacion,
  uEjemploFacturaV33,
  uEjemploFacturaV33Pagos,
  uEjemploFacturaV40Pagos,
  uEjemploFacturaV40,
  uEjemploFacturaV40Frontera,
  uEjemploFacturaGlobalV40;

  procedure Ejemplo;

implementation

 procedure Ejemplo;
 var
  nuevaFactura : IComprobanteFiscal;

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

  rutaCertificado, rutaLlavePrivada, claveLlavePrivada, queOpcion: string;
  reintentar: Boolean;
  Url_WS, URLServicioCancelaciones: String;
 const
  _URL_ECODEX_PRUEBAS_V33           = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_v40           = 'https://pruebas-wsdex.ecodex.com.mx';
  _URL_FINKOK_TIMBRADO_PRUEBAS      = 'https://demo-facturacion.finkok.com/servicios/soap/stamp.wsdl';
  _URL_FINKOK_CANCELACION_PRUEBAS   = 'https://demo-facturacion.finkok.com/servicios/soap/cancel.wsdl';
  _URL_COMERCIO_PRUEBAS             = 'https://pruebas.comercio-digital.mx';
  _URL_SOLUCIONFACTIBLE_PRUEBAS     = 'https://testing.solucionfactible.com/ws/services/Timbrado';
  _URL_MULTIFACTURAS_PRUEBAS        = 'http://ws.facturacionmexico.com.mx/pac/timbrarjava.php';   //SE DEBE ESPECIFICAR QUE ES MODO PRODUCCION
  _NUMERO_TRANSACCION_INICIAL       = 1;

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
         Recuerde que para realizar pruebas con Solución Factible debe registrarse con el PAC para el proceso de pruebas.
         Para realizar pruebas con Edicom, se requiere una cuenta valida registrada en el PAC
      }

      //Este certificado se usa en casi todo los PACs para realizar pruebas
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.key';
      claveLlavePrivada := '12345678a';

     // Configuramos al PAC con los datos para pruebas
     {$ifdef PAC_DEMO_ECODEX}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.key';
      claveLlavePrivada := '12345678a';

      URLServicioCancelaciones := 'https://wsdevapicancelaciones.ecodex.com.mx';

      pac := TProveedorEcodex.Create;
      credencialesPAC.RFC                   := 'EKU9003173C9';
      credencialesPAC.DistribuidorID        := '2b3a8764-d586-4543-9b7e-82834443f219';

      credencialesIntegrador.RFC            := 'BBB010101001';
      //credencialesIntegrador.DistribuidorID := 'DF627BC3-A872-4806-BF37-DBD040CBAC7C';
      credencialesIntegrador.DistribuidorID := '0BBC2E82-95D8-4751-A0A1-A8AE6F50F1CB';
      Url_WS := _URL_ECODEX_PRUEBAS_V33;
     {$endif}

     {$ifdef PAC_DEMO_COMERCIODIGITAL}
      pac := TProveedorComercio.Create;
      CredencialesPAC.RFC   := 'AAA010101AAA';
      CredencialesPAC.Clave := 'PWD';
      Url_WS := _URL_COMERCIO_PRUEBAS;
      URLServicioCancelaciones := Url_WS;
     {$endif}

     {$ifdef PAC_DEMO_FINOK}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.key';
      claveLlavePrivada := '12345678a';

      pac := TProveedorFinkOk.Create;
      CredencialesPAC.RFC   := 'TuUsuario';
      CredencialesPAC.Clave := 'TuContraseña';
      Url_WS := _URL_FINKOK_TIMBRADO_PRUEBAS;
      URLServicioCancelaciones := _URL_FINKOK_CANCELACION_PRUEBAS;
     {$endif}

     {$ifdef PAC_DEMO_SOLUCIONFACTIBLE}
      pac := TProveedorSolucionFactible.Create;
      CredencialesPAC.RFC   := 'testing@solucionfactible.com';;
      CredencialesPAC.Clave := 'timbrado.SF.16672';
      Url_WS := _URL_SOLUCIONFACTIBLE_PRUEBAS;
      URLServicioCancelaciones := Url_WS;
     {$endif}

     {$ifdef PAC_DEMO_MULTIFACTURAS}
      pac := TProveedorMultiFacturas.Create;
      CredencialesPAC.RFC   := 'DEMO700101XXX';
      CredencialesPAC.Clave := 'DEMO700101XXX';
      Url_WS := _URL_MULTIFACTURAS_PRUEBAS;
      URLServicioCancelaciones := Url_WS;
     {$endif}

     if not assigned(pac) then
      begin
        Writeln('El PAC no ha sido especificado,'+#10#13+
                'En la parte superior de este ejemplo, defina un PAC ({$define PAC_DEMO_XXXX}) para usar en el timbrado');

        Writeln('Presiona cualquier tecla para salir...');
        Readln;
        exit;
      end;

      pac.Configurar(Url_WS,
                     Url_WS,
                     URLServicioCancelaciones,
                     credencialesPAC,
                     credencialesIntegrador,
                     _NUMERO_TRANSACCION_INICIAL);


      {$IFDEF FullDebugMode}
        Writeln('FastMM4 Habilitado :)');
      {$ENDIF}

      Writeln('Por favor ingresa el numero de opción del ejemplo que deseas ejecutar:');
      Writeln;
      Writeln('1. Ejemplo CFDI 3.3');
      Writeln('2. Ejemplo CFDI 3.3 con complemento de pagos');
      Writeln('3. Ejemplo CFDI 4.0');
      Writeln('4. Ejemplo CFDI 4.0 con complemento de pagos');
      Writeln('5. Ejemplo CFDI 4.0 factura global');
      Writeln('6. Ejemplo CFDI 4.0 de Franja Fronteriza');
      Writeln('7. Solicitud de cancelación CFDI 2022');
      Writeln('8. Obtener acuse de cancelación CFDI 2022');
      WriteLn;
      WriteLn('>');
      ReadLn(queOpcion);
      //queOpcion := '5';
      Writeln;
      Writeln;

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


      admonFacturas := TAdministradorFacturas.Create;

      // Creamos las instancias comunes segun la versión
      case StrToInt(queOpcion) of
        1,2:
        begin
          // Crear instancias de CFDI 3.3
          generadorCadena := TGeneradorCadenaOriginalV33.Create;
          generadorSello := TGeneradorSelloV33.Create;
          generadorSello.Configurar(openSSL);
          generadorCBB  := TGeneradorCBBv33.Create;
        end;
        3,4,5,6: // Instancias de CFDI 4.0
        begin
          // Creamos las instancias correspondientes para la v40
          generadorCadena := TGeneradorCadenaOriginalV40.Create;
          generadorSello := TGeneradorSelloV33.Create;
          generadorSello.Configurar(openSSL);
          generadorCBB  := TGeneradorCBBv33.Create;
        end;
      end;

      // Inicializamos la variable de re-intentar en verdadero para intentar timbrar
      // cada vez que falle el servicio del PAC
      reintentar := True;
      while reintentar do
      begin
        try
          // Corremos el ejemplo que seleccionó el usuario
          case StrToInt(queOpcion) of
            1:
            begin
              WriteLn('Generando factura CFDI 3.3 normal');
              nuevaFactura := admonFacturas.Nueva('3.3');
              GenerarFacturaV33(nuevaFactura,
                               openSSL,
                               certificadoSellos,
                               generadorCadena,
                               generadorSello
                               );
            end;
            2: // Factura CFDI 4.0 con complemento de pagos
            begin
              WriteLn('Generando factura CFDI 3.3 con complemento de pagos');
              nuevaFactura := admonFacturas.Nueva('3.3');
              GenerarFacturaV33Pagos(nuevaFactura,
                                     openSSL,
                                     certificadoSellos,
                                     generadorCadena,
                                     generadorSello
                                     );
            end;
            3: // Factura CFDI 4.0 con complemento de pagos
            begin
              WriteLn('Generando factura CFDI 4.0 normal');
              nuevaFactura := admonFacturas.Nueva('4.0');
              GenerarFacturaV40(nuevaFactura,
                               openSSL,
                               certificadoSellos,
                               generadorCadena,
                               generadorSello
                               );
            end;
            4: // Factura CFDI 4.0 con complemento de pagos
            begin
              WriteLn('Generando factura CFDI 4.0 con complemento de pagos');
              nuevaFactura := admonFacturas.Nueva('4.0');
              GenerarFacturaV40Pagos(nuevaFactura,
                                     openSSL,
                                     certificadoSellos,
                                     generadorCadena,
                                     generadorSello
                                     );
            end;
            5: // Factura CFDI 4.0 global
            begin
               WriteLn('Generando factura CFDI 4.0 global');
               nuevaFactura := admonFacturas.Nueva('4.0');
               GenerarFacturaV40Global(nuevaFactura,
                                     openSSL,
                                     certificadoSellos,
                                     generadorCadena,
                                     generadorSello
                                     );
            end;
            6: // Factura CFDI 4.0 global
            begin
               WriteLn('Generando factura CFDI 4.0 Franja Fronteriza');
               nuevaFactura := admonFacturas.Nueva('4.0');
               GenerarFacturaV40Frontera(nuevaFactura,
                                         openSSL,
                                         certificadoSellos,
                                         generadorCadena,
                                         generadorSello
                                         );

               // Modificamos el RFC login Ecodex ya que usamos otro
               {$ifdef PAC_DEMO_ECODEX}
                credencialesPAC.RFC := 'EKU9003173C9';
               {$endif}
            end;
            7:
            begin
               WriteLn('Realizando cancelación con esquema 2022');
               CancelarCFDI(pac);
               // Nos salimos para no "mandar sellar" nada pues no estamos generando facturas
               Readln;
               Exit;
            end;
            8:
            begin
               WriteLn('Solicitando acuse de cancelación con esquema 2022');
               ObtenerAcuseCFDI(pac);
               // Nos salimos para no "mandar sellar" nada pues no estamos generando facturas
               Readln;
               Exit;
            end
          else
            WriteLn('Opción inválida');
          end;


          // Obtenemos la cadena original y sellamos la factura automaticamente
          Writeln('Sellando comprobante...');
          admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

          admonFacturas.GuardarArchivo(nuevaFactura, ExtractFilePath(Application.ExeName) + '\ejemplo.xml');

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
                                  ExtractFilePath(Application.ExeName) + '\ejemplo.xml');

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