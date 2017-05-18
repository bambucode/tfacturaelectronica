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
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas';

var
  nuevaFactura : IComprobanteFiscal;
  facturaCFDIv33 : IComprobanteFiscalV33;
  cadenaOriginal : TCadenaUTF8;
  concepto1 : IComprobanteFiscalV33_Conceptos_Concepto;
  iva1 : IComprobanteFiscalV33_Conceptos_Concepto_Impuestos_Traslados_Traslado;
  totalIVA : IComprobanteFiscalV33_Impuestos_Traslados_Traslado;
  admonFacturas: IAdministradorFacturas;
  generadorCadena : IGeneradorCadenaOriginal;
  generadorSello : IGeneradorSello;
  openSSL : IOpenSSL;
  selloDeLaFactura, xmlTimbre : TCadenaUTF8;
  pac: IProveedorAutorizadoCertificacion;
  certificadoSellos: ICertificadoDeSellos;
  credencialesPAC : TFacturacionCredencialesPAC;

begin
  CoInitialize(nil);
  try
    try
      openSSL := TOpenSSL.Create;
      openSSL.AsignarLlavePrivada(ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.key',
                                  '12345678a');

      certificadoSellos := TCertificadoDeSellos.Create;
      certificadoSellos.Leer(ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_VOC990129I26.cer');

      // Generamos una nueva factura v3.3
      Writeln('Generando CFDI v3.3...');
      admonFacturas := TAdministradorFacturas.Create;
      nuevaFactura := admonFacturas.Nueva('3.3');

      // Checamos que el comprobante sea v33, si lo es, usamos
      // la interfase especifica
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

      Writeln('Llenando comprobante CFDI v3.3...');
      with facturaCFDIv33 do
      begin
        Serie     := 'A';
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

        concepto1 := Conceptos.Add;
        concepto1.ClaveProdServ := '52161529';
        concepto1.NoIdentificacion := '1';
        concepto1.Cantidad         := '1';
        concepto1.ClaveUnidad      := 'EA';
        concepto1.Unidad           := 'PZA';
        concepto1.Descripcion      := 'Concepto No 1';
        concepto1.ValorUnitario    := '100.00';
        concepto1.Importe          := '100.00';
        concepto1.Descuento        := '0.00';

        iva1 := concepto1.Impuestos.Traslados.Add;
        iva1.Base        := '100.00';
        iva1.Impuesto    := '002';
        iva1.TipoFactor  := 'Tasa';
        iva1.TasaOCuota  := '0.160000';
        iva1.Importe     := '16.00';

        Impuestos.TotalImpuestosTrasladados  := '16.00';

        totalIVA := Impuestos.Traslados.Add;
        totalIVA.Impuesto := '002';
        totalIVA.TipoFactor := 'Tasa';
        totalIVA.TasaOCuota := '0.160000';
        totalIVA.Importe    := '16.00';
      end;
      {$ENDREGION}


      // Obtenemos la cadena original y sellamos la factura automaticamente
      Writeln('Sellando comprobante...');
      admonFacturas.Sellar(nuevaFactura, generadorCadena, generadorSello);

      // 2. Si queremos obtener la Cadena Original o el Sello
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

      pac.Configurar('https://wsdev.ecodex.com.mx:2045',
                     credencialesPAC);

      // 4. La mandamos timbrar
      Writeln('Timbrando comprobante...');
      Randomize;

      xmlTimbre := pac.TimbrarDocumento(nuevaFactura, Random(9999));

      Writeln('Asignando Timbre Fiscal al comprobante...');
      nuevaFactura.AsignarTimbreFiscal(xmlTimbre);

      // Checamos tener el Timbre Fiscal
      if Assigned(facturaCFDIv33.Complemento.TimbreFiscalDigital) then
      begin
         Writeln(facturaCFDIv33.Complemento.TimbreFiscalDigital.UUID);
      end else
         Writeln('**** NO SE TUVO TIMBRE ****');

      Writeln('Guardando XML...');
      admonFacturas.GuardarArchivo(nuevaFactura,
                                  ExtractFilePath(Application.ExeName) + '\ejemplo-cfdi.xml');

      Writeln('Generación de CFDI v3.3 exitoso.');
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
