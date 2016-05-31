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
     Classes,
     SysUtils;

function LeerXMLDePruebaEnComprobante(DeArchivoXML: String; Certificado: TFECertificado;
                                      var ComprobanteDestino: TFEComprobanteFiscal): String;
function leerArchivoEnUTF8(const aArchivo: String): WideString;

implementation

uses FeTimbreFiscalDigital,
     FacturaReglamentacion,
     Xml.XMLDoc,
     Xml.XMLIntf,
     System.DateUtils,
     FEImpuestosLocales,
     FeCFD,
     FeCFDv2,
     FeCFDv22,
     FeCFDv32;

// Creamos una rutina especial para leer el archivo de cadena original de ejemplo
  // ya que viene en UTF8 y tiene que ser leida como tal para poder compararla
function leerArchivoEnUTF8(const aArchivo: String): WideString;
var
  slArchivo: TStrings;
begin
  Assert(FileExists(aArchivo), 'No existe el archivo a leer');
  slArchivo := TStringList.Create;
  slArchivo.LoadFromFile(aArchivo);
  {$IF Compilerversion >= 20}
  Result:=Trim((slArchivo.Text));
  {$ELSE}
  Result:=Trim(UTF8Encode(slArchivo.Text));
  {$IFEND}
  FreeAndNil(slArchivo);
end;

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
  separadorDecimalAnterior: Char;

  fXMLPrueba, documentoXMLTimbre, documentoXMLImpuestosLocales: TXMLDocument;
  complementoImpuestosLocales: IFEXMLImpuestosLocales;
  nodoImpuestosLocales : IXMLNode;
  impuestoLocal : TFEImpuestoLocal;
  fXMLComprobantePrueba: IFEXMLComprobante;
  VersionCFD: TFEVersionComprobante;
  comprobanteConBloqueFolios: IFESoportaBloqueFolios;
  complementoTimbre: IFEXMLtimbreFiscalDigital;
  timbreComprobante: TFETimbre;
  {$IFDEF VER300}
  // A partir de Delphi Seattle es necesario usar esta constante
  formatSettings : TFormatSettings;
  {$ENDIF}

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

const
  _NOMBRE_NODO_TIMBRE     = 'TimbreFiscalDigital';
  _NAMESPACE_NODO_TIMBRE  = 'http://www.sat.gob.mx/TimbreFiscalDigital';
  _NOMBRE_NODO_IMPUESTOS_LOCALES    = 'ImpuestosLocales';
  _NAMESPACE_NODO_IMPUESTOS_LOCALES = 'http://www.sat.gob.mx/implocal';

begin
  Assert(FileExists(DeArchivoXML), 'El XML ' + DeArchivoXML + ' no existe!');

  try
    // Indicamos que el separador Decimal será el punto
    {$IFDEF VER300}
    separadorDecimalAnterior := formatSettings.DecimalSeparator;
    formatSettings.DecimalSeparator := '.';
    {$ELSE}
    separadorDecimalAnterior := DecimalSeparator;
    DecimalSeparator := '.';
    {$ENDIF}

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
        if IFEXMLComprobanteV32(fXMLComprobantePrueba).Complemento.ChildNodes.FindNode(_NOMBRE_NODO_TIMBRE, _NAMESPACE_NODO_TIMBRE) <> nil then
        begin
          // Creamos el documento XML solamente del timbre
          documentoXMLTimbre := TXMLDocument.Create(nil);
          documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(fXMLComprobantePrueba).Complemento.ChildNodes.FindNode(_NOMBRE_NODO_TIMBRE,
                                                                                                                    _NAMESPACE_NODO_TIMBRE).XML;
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
            // Obtenemos el XML para forzar que se asigne el XML del timbre
            ComprobanteDestino.XML;
          except
            On E:Exception do
              raise;
          end;
        end;

        // Checamos si tiene impuestos locales
        nodoImpuestosLocales := IFEXMLComprobanteV32(fXMLComprobantePrueba).Complemento.ChildNodes.FindNode(_NOMBRE_NODO_IMPUESTOS_LOCALES,
                                                                                                            _NAMESPACE_NODO_IMPUESTOS_LOCALES);

        if Assigned(nodoImpuestosLocales) then
        begin
           // Creamos el documento XML para poder leer el XML de impuestos locales con su correspondiente interfase
           documentoXMLImpuestosLocales := TXMLDocument.Create(nil);
           documentoXMLImpuestosLocales.XML.Text := nodoImpuestosLocales.XML;
           documentoXMLImpuestosLocales.Active := True;

           complementoImpuestosLocales := NuevoNodoImpuestosLocales(documentoXMLImpuestosLocales);

           for I := 0 to complementoImpuestosLocales.RetencionesLocales.Count - 1 do
           begin
              impuestoLocal.Nombre := complementoImpuestosLocales.RetencionesLocales[I].ImpLocRetenido;
              impuestoLocal.Tasa := TFEReglamentacion.DeTasaImpuesto(complementoImpuestosLocales.RetencionesLocales[I].TasadeRetencion);
              impuestoLocal.Importe := TFEReglamentacion.DeMoneda(complementoImpuestosLocales.RetencionesLocales[I].Importe);
              impuestoLocal.Tipo := tiRetenido;
              ComprobanteDestino.AgregarImpuestoLocal(impuestoLocal);
           end;

           for I := 0 to complementoImpuestosLocales.TrasladosLocales.Count - 1 do
           begin
              impuestoLocal.Nombre := complementoImpuestosLocales.TrasladosLocales[I].ImpLocTrasladado;
              impuestoLocal.Tasa := TFEReglamentacion.DeTasaImpuesto(complementoImpuestosLocales.TrasladosLocales[I].TasadeTraslado);
              impuestoLocal.Importe := TFEReglamentacion.DeMoneda(complementoImpuestosLocales.TrasladosLocales[I].Importe);
              impuestoLocal.Tipo := tiTrasladado;
              ComprobanteDestino.AgregarImpuestoLocal(impuestoLocal);
           end;

        end;

      end;
    end;

    Result:=sSello;
  finally
    {$IFDEF VER300}
    formatSettings.DecimalSeparator := separadorDecimalAnterior;
    {$ELSE}
    DecimalSeparator := separadorDecimalAnterior;
    {$ENDIF}
  end;
end;

end.
