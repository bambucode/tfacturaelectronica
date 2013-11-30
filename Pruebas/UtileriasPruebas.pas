(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)

unit UtileriasPruebas;

interface

uses FacturaTipos,
     ComprobanteFiscal,
     SysUtils;

function LeerXMLDePruebaEnComprobante(DeArchivoXML: String; Certificado: TFECertificado;
                                      var ComprobanteDestino: TFEComprobanteFiscal): String;

implementation

uses FeTimbreFiscalDigital,
     FacturaReglamentacion,
     Xml.XMLDoc,
     System.DateUtils,
     FeCFD,
     FeCFDv2,
     FeCFDv22,
     FeCFDv32;

// Funcion comun para generar el comprobante fiscal con los mismos datos
// que el XML especificado como parametro, regresa el Sello
function LeerXMLDePruebaEnComprobante(DeArchivoXML: String; Certificado: TFECertificado;
                                      var ComprobanteDestino: TFEComprobanteFiscal): String;
var
  Bloque: TFEBloqueFolios;
  I: Integer;
  Concepto: TFEConcepto;
  Emisor, Receptor: TFEContribuyente;
  ExpedidoEn: TFEExpedidoEn;
  ImpuestoTrasladado: TFEImpuestoTrasladado;
  ImpuestoRetenido: TFEImpuestoRetenido;
  subTotal: Currency;
  sSello: String;

  fXMLPrueba, documentoXMLTimbre: TXMLDocument;
  fXMLComprobantePrueba: IFEXMLComprobante;
  VersionCFD: TFEVersionComprobante;
  comprobanteConBloqueFolios: IFESoportaBloqueFolios;
  complementoTimbre: IFEXMLtimbreFiscalDigital;
  timbreComprobante: TFETimbre;

  procedure leerComprobanteXML();
  begin
    fXMLPrueba := TXMLDocument.Create(nil);
    fXMLPrueba.LoadFromFile(DeArchivoXML);

    // Que version de CFD estamos leyendo?
    if AnsiPos('version="2.0"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobante(fXMLPrueba);
      VersionCFD:=fev20;
    end;

    if AnsiPos('version="2.2"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobanteV22(fXMLPrueba);
      VersionCFD:=fev22;
    end;

    if AnsiPos('version="3.2"', fXMLPrueba.XML.Text) > 0 then
    begin
      fXMLComprobantePrueba := GetComprobanteV32(fXMLPrueba);
      VersionCFD:=fev32;
    end;
  end;

  function ConvertirFechaComprobanteADateTime(sFechaHora: String): TDateTime;
  var
    sAno, sMes, sDia, sHora, sMin, sMs: String;
  begin
    // Ejemplo: 2009-08-16T16:30:00
    sAno := Copy(sFechaHora, 1, 4);
    sMes := Copy(sFechaHora, 6, 2);
    sDia := Copy(sFechaHora, 9, 2);
    sHora := Copy(sFechaHora, 12, 2);
    sMin := Copy(sFechaHora, 15, 2);
    sMs := Copy(sFechaHora, 18, 2);
    Result := EncodeDateTime(StrToInt(sAno), StrToInt(sMes), StrToInt(sDia), StrToInt(sHora),
      StrToInt(sMin), StrToInt(sMs), 0);
  end;

  // Se encarga de recalcular el sello basado en el archivo de llave privada
  // especificado
  {function RecalcularSello(aArchivoLlavePrivada, aClaveLlavePrivada, aCadenaOriginal: String) : String;
  var
    _ARCHIVO_CADENA_TEMPORAL : String;
    _ARCHIVO_LLAVE_PEM : String;
    _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL : String;
  begin
      _ARCHIVO_CADENA_TEMPORAL := 'cadena.txt';
      _ARCHIVO_LLAVE_PEM := 'x.pem';
      _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL := 'res.txt';

      // Convertimos la llave privada a archivo PEM
      EjecutarComandoOpenSSL('pkcs8 -inform DER -in ' + aArchivoLlavePrivada +
                         ' -passin pass:' + aClaveLlavePrivada +
                         ' -out ' + fDirTemporal + _ARCHIVO_LLAVE_PEM);

      // Guardamos la cadena original en un archivo
      guardarArchivoEnUTF8(UTF8Encode(aCadenaOriginal), _ARCHIVO_CADENA_TEMPORAL);

      // Mandamos generar el sello usando OpenSSL
      EjecutarComandoOpenSSL('dgst -md5 -sign "' + fDirTemporal + _ARCHIVO_LLAVE_PEM +
        '" -out "' + fDirTemporal +
        'md5_cadena_de_prueba.bin" "' + fDirTemporal + _ARCHIVO_CADENA_TEMPORAL + '"');

      // Convertimos el resultado (archivo binario) a base64
      EjecutarComandoOpenSSL(' enc -base64 -in "' + fDirTemporal +
        'md5_cadena_de_prueba.bin" -out "' + fDirTemporal +
        _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL + '"');

      Result := QuitarRetornos(leerContenidoDeArchivo(fDirTemporal + _ARCHIVO_TEMPORAL_RESULTADO_OPENSSL));
  end;}

begin
  Assert(FileExists(DeArchivoXML), 'El XML ' + DeArchivoXML + ' no existe!');

  // Leemos el fixture de comprobante XML para obtener sus propiedades y asignarlas al comprobante
  leerComprobanteXML();
  // 1. Definimos los datos de los folios
  ComprobanteDestino.Folio := StrToInt(fXMLComprobantePrueba.Folio);
  // Si es la version de prueba, establecemos la fecha/hora para que coincida
  // con la fecha/hora en que se genero el comprobante usando MicroE
  ComprobanteDestino.FechaGeneracion := ConvertirFechaComprobanteADateTime(fXMLComprobantePrueba.Fecha);

  if Supports(fXMLComprobantePrueba, IFESoportaBloqueFolios, comprobanteConBloqueFolios) then
  begin
    Bloque.NumeroAprobacion := comprobanteConBloqueFolios.NoAprobacion;
    Bloque.AnoAprobacion := comprobanteConBloqueFolios.AnoAprobacion;
  end;

  Bloque.Serie := fXMLComprobantePrueba.Serie;
  Bloque.FolioInicial := 1;
  // Indicamos que el folio final es el folio del comprobante + 1 para que siempre este "en reango"
  Bloque.FolioFinal := StrToInt(fXMLComprobantePrueba.Folio) + 1;
  ComprobanteDestino.BloqueFolios := Bloque;

  // 2. Establecemos el certificado a usar
  ComprobanteDestino.Certificado := Certificado;

  // Leemos el metodo de pago
  ComprobanteDestino.MetodoDePago := fXMLComprobantePrueba.MetodoDePago;

  // Solo si es la v2.2 leemos el lugar de expedicion
  if VersionCFD In [fev22, fev32] then
  begin
    ComprobanteDestino.LugarDeExpedicion := IFEXMLComprobanteV22(fXMLComprobantePrueba).LugarExpedicion;
    Assert(Trim(ComprobanteDestino.MetodoDePago) <> '', 'El CFD debe tener un metodo de pago');
    Assert(Trim(ComprobanteDestino.LugarDeExpedicion) <> '', 'El CFD debe tener un lugar de expedicion');
  end;

  // 3. Establecemos el Emisor y Receptor
  case VersionCFD of
    fev20:
    begin
        with IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor do
        begin
          Emisor.Nombre := Nombre;
          Emisor.RFC := RFC;
          Emisor.Direccion.Calle := DomicilioFiscal.Calle;
          Emisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
          Emisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
          Emisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
          Emisor.Direccion.Colonia := DomicilioFiscal.Colonia;
          Emisor.Direccion.Localidad := DomicilioFiscal.Localidad;
          Emisor.Direccion.Municipio := DomicilioFiscal.Municipio;
          Emisor.Direccion.Estado := DomicilioFiscal.Estado;
          Emisor.Direccion.Pais := DomicilioFiscal.Pais;
        end;
    end;
    fev22:
    begin
        with IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor do
        begin
          Emisor.Nombre := Nombre;
          Emisor.RFC := RFC;
          Emisor.Direccion.Calle := DomicilioFiscal.Calle;
          Emisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
          Emisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
          Emisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
          Emisor.Direccion.Colonia := DomicilioFiscal.Colonia;
          Emisor.Direccion.Localidad := DomicilioFiscal.Localidad;
          Emisor.Direccion.Municipio := DomicilioFiscal.Municipio;
          Emisor.Direccion.Estado := DomicilioFiscal.Estado;
          Emisor.Direccion.Pais := DomicilioFiscal.Pais;

          // Leemos los régimenes que contiene el CFD del XML
          SetLength(Emisor.Regimenes, RegimenFiscal.Count);
          for I := 0 to RegimenFiscal.Count - 1 do
            Emisor.Regimenes[I] := RegimenFiscal[I].Regimen;
        end;
    end;
    fev32:
    begin
        with IFEXMLComprobanteV32(fXMLComprobantePrueba).Emisor do
        begin
          Emisor.Nombre := Nombre;
          Emisor.RFC := RFC;
          Emisor.Direccion.Calle := DomicilioFiscal.Calle;
          Emisor.Direccion.NoExterior := DomicilioFiscal.NoExterior;
          Emisor.Direccion.NoInterior := DomicilioFiscal.NoInterior;
          Emisor.Direccion.CodigoPostal := DomicilioFiscal.CodigoPostal;
          Emisor.Direccion.Colonia := DomicilioFiscal.Colonia;
          Emisor.Direccion.Localidad := DomicilioFiscal.Localidad;
          Emisor.Direccion.Municipio := DomicilioFiscal.Municipio;
          Emisor.Direccion.Estado := DomicilioFiscal.Estado;
          Emisor.Direccion.Pais := DomicilioFiscal.Pais;

          // Leemos los régimenes que contiene el CFD del XML
          SetLength(Emisor.Regimenes, RegimenFiscal.Count);
          for I := 0 to RegimenFiscal.Count - 1 do
            Emisor.Regimenes[I] := RegimenFiscal[I].Regimen;
        end;
    end;
  end;
  ComprobanteDestino.Emisor := Emisor;

  with fXMLComprobantePrueba.Receptor do
  begin
    Receptor.Nombre := Nombre;
    Receptor.RFC := RFC;
    Receptor.Direccion.Calle := Domicilio.Calle;
    Receptor.Direccion.NoInterior := Domicilio.NoInterior;
    Receptor.Direccion.NoExterior := Domicilio.NoExterior;
    Receptor.Direccion.CodigoPostal := Domicilio.CodigoPostal;
    Receptor.Direccion.Colonia := Domicilio.Colonia;
    Receptor.Direccion.Estado := Domicilio.Estado;
    Receptor.Direccion.Localidad := Domicilio.Localidad;
    Receptor.Direccion.Municipio := Domicilio.Municipio;
    Receptor.Direccion.Pais := Domicilio.Pais;
    ComprobanteDestino.Receptor := Receptor;
  end;

  // Tiene direccion de "Expedido En" ??
  case VersionCFD of
    fev20:
    begin
        if IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor.ExpedidoEn.Calle <> '' then
        begin
          with IFEXMLComprobanteV2(fXMLComprobantePrueba).Emisor.ExpedidoEn do
          begin
            ExpedidoEn.Calle := Calle;
            ExpedidoEn.NoExterior := NoExterior;
            ExpedidoEn.CodigoPostal := CodigoPostal;
            ExpedidoEn.Localidad := Localidad;
            ExpedidoEn.Municipio := Municipio;
            ExpedidoEn.Colonia := Colonia;
            ExpedidoEn.Estado := Estado;
            ExpedidoEn.Pais := Pais;
          end;
          ComprobanteDestino.ExpedidoEn := ExpedidoEn;
        end;
    end;
    fev22:
    begin
        if IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor.ExpedidoEn.Calle <> '' then
        begin
          with IFEXMLComprobanteV22(fXMLComprobantePrueba).Emisor.ExpedidoEn do
          begin
            ExpedidoEn.Calle := Calle;
            ExpedidoEn.NoExterior := NoExterior;
            ExpedidoEn.CodigoPostal := CodigoPostal;
            ExpedidoEn.Localidad := Localidad;
            ExpedidoEn.Municipio := Municipio;
            ExpedidoEn.Colonia := Colonia;
            ExpedidoEn.Estado := Estado;
            ExpedidoEn.Pais := Pais;
          end;
          ComprobanteDestino.ExpedidoEn := ExpedidoEn;
        end;
    end;
    fev32:
    begin
        if IFEXMLComprobanteV32(fXMLComprobantePrueba).Emisor.ExpedidoEn.Calle <> '' then
        begin
          with IFEXMLComprobanteV32(fXMLComprobantePrueba).Emisor.ExpedidoEn do
          begin
            ExpedidoEn.Calle := Calle;
            ExpedidoEn.NoExterior := NoExterior;
            ExpedidoEn.CodigoPostal := CodigoPostal;
            ExpedidoEn.Localidad := Localidad;
            ExpedidoEn.Municipio := Municipio;
            ExpedidoEn.Colonia := Colonia;
            ExpedidoEn.Estado := Estado;
            ExpedidoEn.Pais := Pais;
          end;
          ComprobanteDestino.ExpedidoEn := ExpedidoEn;
        end;
    end;
  end;

  // 4. Agregamos los conceptos
  subTotal := 0;

  for I := 0 to fXMLComprobantePrueba.Conceptos.Count - 1 do
  begin
    with fXMLComprobantePrueba.Conceptos.Concepto[I] do
    begin
      Concepto.Cantidad := StrToFloat(Cantidad);
      Concepto.NoIdentificacion := NoIdentificacion;
      Concepto.Unidad := Unidad;
      Concepto.Descripcion := Descripcion;
      Concepto.ValorUnitario := StrToFloat(ValorUnitario);
      Concepto.CuentaPredial := CuentaPredial.Numero;
      subTotal := subTotal + (Concepto.ValorUnitario * Concepto.Cantidad);
      // TODO: Leer datos de aduana si acaso los tiene
    end;
    ComprobanteDestino.AgregarConcepto(Concepto);
  end;

  // Agregamos las reteneciones
  for I := 0 to fXMLComprobantePrueba.Impuestos.Retenciones.Count - 1 do
  begin
    with fXMLComprobantePrueba.Impuestos.Retenciones do
    begin
      ImpuestoRetenido.Nombre := Retencion[I].Impuesto;
      ImpuestoRetenido.Importe := StrToFloat(Retencion[I].Importe);

      ComprobanteDestino.AgregarImpuestoRetenido(ImpuestoRetenido);
    end;
  end;

  // Agregamos los impuestos trasladados
  for I := 0 to fXMLComprobantePrueba.Impuestos.Traslados.Count - 1 do
  begin
    with fXMLComprobantePrueba.Impuestos.Traslados do
    begin
      ImpuestoTrasladado.Nombre := Traslado[I].Impuesto;
      ImpuestoTrasladado.Tasa := StrToFloat(Traslado[I].Tasa);
      ImpuestoTrasladado.Importe := StrToFloat(Traslado[I].Importe);

      ComprobanteDestino.AgregarImpuestoTrasladado(ImpuestoTrasladado);
    end;
  end;

  // Checamos si el XML proveido tiene los totales de impuestos desglosados...
  if fXMLComprobantePrueba.Impuestos.TotalImpuestosTrasladados <> '' then
    ComprobanteDestino.DesglosarTotalesImpuestos := True
  else
    ComprobanteDestino.DesglosarTotalesImpuestos := False;

  // Que forma de pago tuvo??
  // Asignamos el mismo texto de la forma de pago ya que unos usan mayusculas otros minusculas, etc.
  if AnsiPos('UNA', Uppercase(fXMLComprobantePrueba.FormaDePago)) > 0 then
  begin
    ComprobanteDestino._CADENA_PAGO_UNA_EXHIBICION := fXMLComprobantePrueba.FormaDePago;
    ComprobanteDestino.FormaDePago := fpUnaSolaExhibicion;
  end
  else
  begin
    ComprobanteDestino._CADENA_PAGO_PARCIALIDADES := fXMLComprobantePrueba.FormaDePago;
    ComprobanteDestino.FormaDePago := fpParcialidades;
  end;

  // Tipo de comprobante
  if fXMLComprobantePrueba.TipoDeComprobante = 'ingreso' then
    ComprobanteDestino.Tipo := tcIngreso;

  if fXMLComprobantePrueba.TipoDeComprobante = 'egreso' then
    ComprobanteDestino.Tipo := tcEgreso;

  if fXMLComprobantePrueba.TipoDeComprobante = 'traslado' then
    ComprobanteDestino.Tipo := tcTraslado;

  sSello := fXMLComprobantePrueba.Sello;

  // Asignamos el descuento
  if fXMLComprobantePrueba.Descuento <> '' then
    ComprobanteDestino.AsignarDescuento(StrToFloat(fXMLComprobantePrueba.Descuento), '');

  // Asignamos el subtotal de la factura
  ComprobanteDestino.SubTotal := subTotal;

  // Timbre Fiscal
  if VersionCFD In [fev32] then
  begin
    if IFEXMLComprobanteV32(fXMLComprobantePrueba).Complemento.HasChildNodes then
    begin
      // Creamos el documento XML solamente del timbre
      documentoXMLTimbre := TXMLDocument.Create(nil);
      documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(fXMLComprobantePrueba).Complemento.ChildNodes.First.XML;
      documentoXMLTimbre.Active := True;

      try
        // Convertimos el XML del nodo a la interfase del Timbre v3.2
        complementoTimbre := GetTimbreFiscalDigital(documentoXMLTimbre);

        // Asignamos las propiedades del XMl del timbre a las internas
        with timbreComprobante do
        begin
          Version := complementoTimbre.Version;
          UUID := complementoTimbre.UUID;
          FechaTimbrado := TFEReglamentacion.DeFechaHoraISO8601(complementoTimbre.FechaTimbrado);
          SelloCFD := complementoTimbre.SelloCFD;
          NoCertificadoSAT := complementoTimbre.NoCertificadoSAT;
          SelloSAT := complementoTimbre.SelloSAT;
          XML := documentoXMLTimbre.XML.Text;
        end;

        // Agregamos el timbre al CFD
        ComprobanteDestino.AsignarTimbreFiscal(timbreComprobante);
      except
        On E:Exception do
          raise;
      end;
    end;
  end;

  Result:=sSello;
end;

end.
