{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

program EjemploFacturaElectronica;

{$APPTYPE CONSOLE}

{$R *.res}

// Incluimos el archivo de recurso .RC que contiene los XSLTs para generar las cadenas originales
{$R *.dres}

// ¿Se quiere soporte para el Debugger FASTMM?
{$IFDEF FASTMM}
  {$INCLUDE FastMM4Options.inc}
{$ENDIF}

uses
  System.SysUtils,
  activex,
  Vcl.Forms,
  Facturacion.ComprobanteV33 in '..\Versiones\Facturacion.ComprobanteV33.pas',
  Facturacion.Comprobante in '..\Versiones\Facturacion.Comprobante.pas',
  Facturacion.Administrador in '..\Facturacion.Administrador.pas',
  Facturacion.GeneradorCadenaOriginal in '..\Facturacion.GeneradorCadenaOriginal.pas',
  Facturacion.GeneradorCadenaOrignalV33 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV33.pas',
  Facturacion.GeneradorSello in '..\Facturacion.GeneradorSello.pas',
  Facturacion.OpenSSL in '..\Facturacion.OpenSSL.pas',
  Facturacion.GeneradorSelloV33 in '..\Versiones\Facturacion.GeneradorSelloV33.pas',
  FinkOkWsTimbrado in '..\PACs\FinkOK\FinkOkWsTimbrado.pas',
  Facturacion.PAC.Ecodex in '..\PACs\Ecodex\Facturacion.PAC.Ecodex.pas',
  Facturacion.ProveedorAutorizadoCertificacion in '..\Facturacion.ProveedorAutorizadoCertificacion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsClientes in '..\PACs\Ecodex\EcodexWsClientes.pas',
  EcodexWsComun in '..\PACs\Ecodex\EcodexWsComun.pas',
  EcodexWsSeguridad in '..\PACs\Ecodex\EcodexWsSeguridad.pas',
  EcodexWsTimbrado in '..\PACs\Ecodex\EcodexWsTimbrado.pas',
  Facturacion.CertificadoDeSellos in '..\Facturacion.CertificadoDeSellos.pas',
  Facturacion.Helper in '..\Facturacion.Helper.pas',
  Facturacion.ManejadorErroresComunesWebServices in '..\PACs\Facturacion.ManejadorErroresComunesWebServices.pas',
  Facturacion.GeneradorCBBv33 in '..\Versiones\Facturacion.GeneradorCBBv33.pas',
  DelphiZXIngQRCode in '..\Lib\DelphiZXIngQRCode.pas',
  Facturacion.GeneradorCBB in '..\Facturacion.GeneradorCBB.pas',
  Facturacion.GeneradorQR in '..\Facturacion.GeneradorQR.pas',
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas',
  Facturacion.ComprobanteV32 in '..\Versiones\Facturacion.ComprobanteV32.pas',
  Facturacion.TimbreFiscalDigitalV32 in '..\Versiones\Facturacion.TimbreFiscalDigitalV32.pas',
  Facturacion.GeneradorCadenaOrignalV32 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV32.pas',
  Facturacion.GeneradorSelloV32 in '..\Versiones\Facturacion.GeneradorSelloV32.pas',
  Facturacion.GeneradorCBBv32 in '..\Versiones\Facturacion.GeneradorCBBv32.pas',
  Facturacion.Tipos in '..\Facturacion.Tipos.pas',
  Facturacion.ImpuestosLocalesV1 in '..\Versiones\Facturacion.ImpuestosLocalesV1.pas',
  EcodexWsCancelacion in '..\PACs\Ecodex\EcodexWsCancelacion.pas';

var
  nuevaFactura                                                    : IComprobanteFiscal;

  // Instancias especificas para V32
  facturaCFDIv32                                                  : IComprobanteFiscalV32;
  regimen32                                                       : IComprobanteFiscalV32_Emisor_RegimenFiscal;
  concepto32                                                      : IComprobanteFiscalV32_Conceptos_Concepto;
  iva32                                                           : IComprobanteFiscalV32_Impuestos_Traslados_Traslado;

  // Instancias especificas para V33
  facturaCFDIv33                                                  : IComprobanteFiscalV33;
  concepto33                                                      : IComprobanteFiscalV33_Conceptos_Concepto;
  iva33                                                           : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33                                                      : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;

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
const
  _URL_ECODEX_PRUEBAS_V32        = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_V33        = 'https://wsdev.ecodex.com.mx:2045';
  _URL_FINKOK_PRUEBAS            = 'http://demo-facturacion.finkok.com/servicios/soap';
  _URL_COMERCIO_PRUEBAS          = 'https://pruebas.comercio-digital.mx';
  _URL_SOLUCIONFACTIBLE_PRUEBAS  = 'https://testing.solucionfactible.com/ws/services/Timbrado';
  _NUEMRO_TRANSACCION_INICIAL    = 1;

begin
  CoInitialize(nil);
  try
    try

{
 NOTAS:
         Recuerde que para realizar pruebas con Soluci�n Factible debe registrarse con el PAC para el proceso de pruebas.
         Para realizar pruebas con Edicom, se requiere una cuenta valida registrada en el PAC
}

// El primer sello es para Ecodex

      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.key';

//Este sello se usa Para finkOk
{
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_LAN7008173R5.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_LAN7008173R5.key';
}
      claveLlavePrivada := '12345678a';


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


      Writeln('Por favor escribe la version del CFDI que deseas generar (3.2 o 3.3):');
      ReadLn(queVersion);
      Writeln;

      Writeln('Creando instancia de PAC...');
      // Configuramos al PAC con los datos para pruebas

      pac := TProveedorEcodex.Create;
      credencialesPAC.RFC                   := 'VOC990129I26';
      credencialesPAC.DistribuidorID        := '2b3a8764-d586-4543-9b7e-82834443f219';

      credencialesIntegrador.RFC            := 'BBB010101001';
      credencialesIntegrador.DistribuidorID := 'DF627BC3-A872-4806-BF37-DBD040CBAC7C';

{
      pac := TProveedorComercio.Create;
      CredencialesPAC.RFC   := 'AAA010101AAA';
      CredencialesPAC.Clave := 'PWD';
}

{
      pac := TProveedorFinkOk.Create;
      CredencialesPAC.RFC   := 'TuUsuario';
      CredencialesPAC.Clave := 'TuPassword';
}

{
      pac := TProveedorSolucionFactible.Create;
      CredencialesPAC.RFC   := 'testing@solucionfactible.com';;
      CredencialesPAC.Clave := 'timbrado.SF.16672';
}

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

          // Checamos que la interfase sea de la version correcta
          if nuevaFactura.Version = '3.2' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv32, facturaCFDIv32) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v32');
              Exit;
            end;

            {$REGION 'Factura V32'}
            // Creamos las instancias correspondientes para la v33
            generadorCadena := TGeneradorCadenaOriginalV32.Create;
            generadorSello := TGeneradorSelloV32.Create;
            generadorSello.Configurar(openSSL);
            generadorCBB  := TGeneradorCBBv32.Create;

            with facturaCFDIv32 do
            begin
              Serie     := 'Ver32';
              Randomize;
              Folio     := IntToStr(Random(999999999));
              Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);

              NoCertificado := certificadoSellos.NoCertificado;
              Certificado   := certificadoSellos.ContenidoBase64;

              FormaDePago       := '01';
              CondicionesDePago := 'Credito a 30 dias';
              Subtotal          := '100.00';
              Descuento         := '0.00';
              Total             := '116.00';
              TipoDeComprobante := 'ingreso';
              MetodoDePago      := '01';
              LugarExpedicion   := 'Chihuahua, Chihuahua';

              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;

              regimen32 := Emisor.RegimenFiscal.Add;
              regimen32.Regimen := 'Regimen General de Ley';

              Receptor.Rfc  := 'MTI0806042N7';
              Receptor.Nombre := 'Juan & José & ''Niño'' & "Niña" S.A. de C.V.';
              Receptor.Domicilio.Calle := 'Mi Calle';
              Receptor.Domicilio.NoExterior := '120';
              Receptor.Domicilio.Colonia := 'Centro';
              Receptor.Domicilio.Municipio := 'Chihuahua';
              Receptor.Domicilio.Estado := 'Chihuahua';
              Receptor.Domicilio.Pais := 'Méxito';

              concepto32 := Conceptos.Add;
              concepto32.NoIdentificacion := '1';
              concepto32.Cantidad         := '1';
              concepto32.Unidad           := 'PZA';
              concepto32.Descripcion      := 'Concepto No 1';
              concepto32.ValorUnitario    := '100.00';
              concepto32.Importe          := '100.00';

              // Asignamos el total del impuesto de la factura
              iva32 := Impuestos.Traslados.Add;
              iva32.Tasa        := '16.00';
              iva32.Impuesto    := 'IVA';
              iva32.Importe     := '16.00';

              Impuestos.TotalImpuestosTrasladados  := '16.00';
            end;
            {$ENDREGION}

          end;

          if nuevaFactura.Version = '3.3' then
          begin
            if Not Supports(nuevaFactura, IComprobanteFiscalv33, facturaCFDIv33) then
            begin
              Writeln('nuevaFactura no fue un Comprobante Fiscal v33');
              Exit;
            end;

            {$REGION 'Factura V33'}
            // Creamos las instancias correspondientes para la v33
            generadorCadena := TGeneradorCadenaOriginalV33.Create;
            generadorSello := TGeneradorSelloV33.Create;
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
              FormaPago         := '01'; // De catálogo
              CondicionesDePago := 'Credito a 30 dias';
              Subtotal          := '100.00'; // Solo 2 decimales
              Descuento         := TFacturacionHelper.ComoMoneda(0);
              Moneda            := 'MXN'; // De catálogo
              TipoCambio        := '1';//TFacturacionHelper.ComoMoneda(1);
              Total             := TFacturacionHelper.ComoMoneda(117);
              TipoDeComprobante := 'I'; // De catálogo
              MetodoPago        := 'PUE';
              LugarExpedicion   := '76030';

              Emisor.Rfc           := certificadoSellos.EmitidoParaRFC;
              Emisor.Nombre        := certificadoSellos.EmitidoParaNombre;
              Emisor.RegimenFiscal := '601'; // De cat�logo

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
              concepto33.Descripcion      := 'Concepto No 1';
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
            {$ENDREGION}
          end;

          // Agregamos el impuesto local el cual se maneja de forma especial
          {$REGION 'Impuestos locales'}
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
          {$ENDREGION}

          //admonFacturas.GuardarArchivo(nuevaFactura,
          //                            ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi-pre.xml');

          // Obtenemos la cadena original y sellamos la factura automaticamente
          Writeln('Sellando comprobante...');
          admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

          // 2. Si queremos obtener la Cadena Original o el Sello de forma separada:
          // cadenaOriginal := generadorCadena.obtenerCadenaOriginal(nuevaFactura);
          // Writeln(cadenaOriginal);
          //
          // selloDeLaFactura := generadorSello.GenerarSelloDeFactura(cadenaOriginal);
          // Writeln(selloDeLaFactura);

          // Dependiendo de la version usamos diferente servidor de pruebas

// si el pac es Comercio
{        pac.Configurar(_URL_COMERCIO_PRUEBAS,
                         credencialesPAC,
                         _NUEMRO_TRANSACCION_INICIAL);

}

// si el pac es finkok
{       pac.Configurar(_URL_FINKOK_PRUEBAS,
                         credencialesPAC,
                         _NUEMRO_TRANSACCION_INICIAL);

}

// si el pac es Solucion Factible
{
       pac.Configurar(_URL_SOLUCIONFACTIBLE_PRUEBAS,
                         credencialesPAC,
                         _NUEMRO_TRANSACCION_INICIAL);
}

//     si el pac es ecodex
          if nuevaFactura.Version = '3.3' then
            pac.Configurar(_URL_ECODEX_PRUEBAS_V33,
                         credencialesPAC,
                         credencialesIntegrador,
                         _NUEMRO_TRANSACCION_INICIAL)
          else
            pac.Configurar(_URL_ECODEX_PRUEBAS_V32,
                           credencialesPAC,
                           credencialesIntegrador,
                           _NUEMRO_TRANSACCION_INICIAL);

          // 4. La mandamos timbrar
          Writeln('Intentando timbrar comprobante...');
          Randomize;
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
//      if Assigned(facturaCFDIv33.Complemento.TimbreFiscalDigital) then
//      begin
//         Writeln(facturaCFDIv33.Complemento.TimbreFiscalDigital.UUID);
//      end else
//         Writeln('**** NO SE TUVO TIMBRE ****');

      Writeln('Cadena Original de Timbre:');
      Writeln(generadorCadena.obtenerCadenaOriginalDeTimbre(nuevaFactura));

      Writeln('Guardando XML...');
      admonFacturas.GuardarArchivo(nuevaFactura,
                                  ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.xml');

      Writeln('Generando CBB corespondiente');
      generadorCBB.GenerarImagenCBB(nuevaFactura,
                                    ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.jpg');

      Writeln('Generación de CFDI v' + nuevaFactura.Version + ' exitoso.');
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
