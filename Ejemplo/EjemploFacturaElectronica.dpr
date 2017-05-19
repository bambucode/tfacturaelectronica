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
  Facturacion.GeneradorCBB,
  Facturacion.GeneradorQR in '..\Facturacion.GeneradorQR.pas',
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas',
  Facturacion.ComprobanteV32 in '..\Versiones\Facturacion.ComprobanteV32.pas',
  Facturacion.TimbreFiscalDigitalV32 in '..\Versiones\Facturacion.TimbreFiscalDigitalV32.pas',
  Facturacion.GeneradorCadenaOrignalV32 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV32.pas',
  Facturacion.GeneradorSelloV32 in '..\Versiones\Facturacion.GeneradorSelloV32.pas',
  Facturacion.GeneradorCBBv32 in '..\Versiones\Facturacion.GeneradorCBBv32.pas';

var
  nuevaFactura : IComprobanteFiscal;

  // Instancias especificas para V32
  facturaCFDIv32: IComprobanteFiscalV32;
  regimen32 : IComprobanteFiscalV32_Emisor_RegimenFiscal;
  concepto32: IComprobanteFiscalV32_Conceptos_Concepto;
  iva32: IComprobanteFiscalV32_Impuestos_Traslados_Traslado;

  // Instancias especificas para V33
  facturaCFDIv33 : IComprobanteFiscalV33;
  concepto33 : IComprobanteFiscalV33_Conceptos_Concepto;
  iva33 : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA33 : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;

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
  generadorCBB: IGeneradorCBB;

const
  _URL_ECODEX_PRUEBAS_V32 = 'https://pruebas.ecodex.com.mx:2045';
  _URL_ECODEX_PRUEBAS_V33 = 'https://wsdev.ecodex.com.mx:2045';

begin
  CoInitialize(nil);
  try
    try
      openSSL := TOpenSSL.Create;
      openSSL.AsignarLlavePrivada(ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.key',
                                  '12345678a');

      certificadoSellos := TCertificadoDeSellos.Create;
      certificadoSellos.Leer(ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.cer');

      // Generamos una nueva factura
      admonFacturas := TAdministradorFacturas.Create;
      nuevaFactura := admonFacturas.Nueva('3.2');

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
          Serie     := 'V32';
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
          Receptor.Nombre := 'Juan & José & ''Niño'' & "Niña"';
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
          Serie     := 'V33';
          Randomize;
          Folio     := IntToStr(Random(999999999));
          Fecha     := TFacturacionHelper.ComoFechaISO8601(Now);

          NoCertificado := certificadoSellos.NoCertificado;
          Certificado   := certificadoSellos.ContenidoBase64;

          FormaPago     := '01';
          CondicionesDePago := 'Credito a 30 dias';
          Subtotal      := '100.00';
          Descuento     := '0.00';
          Moneda        := 'MXN';
          TipoCambio    := '1.00';
          Total         := '116.00';
          TipoDeComprobante := 'I';
          MetodoPago    := 'PUE';
          LugarExpedicion := '76030';

          Emisor.Rfc    := certificadoSellos.EmitidoParaRFC;
          Emisor.Nombre := certificadoSellos.EmitidoParaNombre;
          Emisor.RegimenFiscal := '601';

          Receptor.Rfc  := 'MTI0806042N7';
          Receptor.Nombre := 'Juan & José & ''Niño'' & "Niña"';
          Receptor.UsoCFDI := 'G01';

          concepto33 := Conceptos.Add;
          concepto33.ClaveProdServ := '52161529';
          concepto33.NoIdentificacion := '1';
          concepto33.Cantidad         := '1';
          concepto33.ClaveUnidad      := 'EA';
          concepto33.Unidad           := 'PZA';
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

          Impuestos.TotalImpuestosTrasladados  := '16.00';

          totalIVA33 := Impuestos.Traslados.Add;
          totalIVA33.Impuesto := '002';
          totalIVA33.TipoFactor := 'Tasa';
          totalIVA33.TasaOCuota := '0.160000';
          totalIVA33.Importe    := '16.00';
        end;
        {$ENDREGION}
      end;


      // Obtenemos la cadena original y sellamos la factura automaticamente
      Writeln('Sellando comprobante...');
      admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

      // 2. Si queremos obtener la Cadena Original o el Sello de forma separada:
      // cadenaOriginal := generadorCadena.obtenerCadenaOriginal(nuevaFactura);
      // Writeln(cadenaOriginal);
      //
      // selloDeLaFactura := generadorSello.GenerarSelloDeFactura(cadenaOriginal);
      // Writeln(selloDeLaFactura);

      Writeln('Creando instancia de PAC...');
      pac := TProveedorEcodex.Create;

      // Configuramos al PAC con los datos para pruebas
      credencialesPAC.RFC            := 'VOC990129I26';
      credencialesPAC.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';

      // Dependiendo de la version usamos diferente servidor de pruebas
      if nuevaFactura.Version = '3.3' then
        pac.Configurar(_URL_ECODEX_PRUEBAS_V33,
                     credencialesPAC)
      else
        pac.Configurar(_URL_ECODEX_PRUEBAS_V32,
                       credencialesPAC);

      // 4. La mandamos timbrar
      Writeln('Timbrando comprobante...');
      Randomize;

      xmlTimbre := pac.TimbrarDocumento(nuevaFactura, Random(9999));

      Writeln('Asignando Timbre Fiscal al comprobante...');
      nuevaFactura.AsignarTimbreFiscal(xmlTimbre);

      // Checamos tener el Timbre Fiscal
//      if Assigned(facturaCFDIv33.Complemento.TimbreFiscalDigital) then
//      begin
//         Writeln(facturaCFDIv33.Complemento.TimbreFiscalDigital.UUID);
//      end else
//         Writeln('**** NO SE TUVO TIMBRE ****');

      Writeln('Guardando XML...');
      admonFacturas.GuardarArchivo(nuevaFactura,
                                  ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.xml');

      Writeln('Generando CBB corespondiente');
      generadorCBB.GenerarImagenCBB(nuevaFactura,
                                    ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.jpg');

      Writeln('Generación de CFDI v' + nuevaFactura.Version + ' exitoso.');
      Readln;
    except
      on E: Exception do
      begin
        Writeln(E.ClassName, ': ', E.Message);
        Readln;
      end;
    end;
  finally
    CoInitialize(nil);
  end;
end.
