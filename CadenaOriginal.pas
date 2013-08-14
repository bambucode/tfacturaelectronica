unit CadenaOriginal;

interface

uses FacturaTipos, FeCFD, FeCFDv22, FeCFDv2,
     XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd;

type

  // Generamos la estructura "Cadena Original" de acuerdo a las reglas del SAT
  // definidas en: http://www.sat.gob.mx/sitio_internet/e_sat/comprobantes_fiscales/15_6543.html
  TCadenaOriginal = class
  private
      fXMLComprobante: IFEXMLComprobante;
      fResultado: TStringCadenaOriginal;
      fVersionCFD: TFEVersionComprobante;
      const _PIPE = '|';
      function RemoverExcesoEspacios(const s: string): String;
      function LimpiaCampo(sTexto: String): String;

      {$REGION 'Documentation'}
      ///	<summary>
      ///	  Se encarga de agregar un atributo del XML a la cadena original de
      ///	  acuerdo a la especificación.
      ///	</summary>
      ///	<param name="NodoPadre">
      ///	  Nodo padre de donde obtendremos el atributo
      ///	</param>
      ///	<param name="sNombreAtributo">
      ///	  Nombre del atributo a obtener
      ///	</param>
      {$ENDREGION}
      procedure AgregarAtributo(NodoPadre: IXMLNode; sNombreAtributo: String);
      procedure AgregarRegimenesFiscales(const aRegimenesFiscales: IXMLComprobante_Emisor_RegimenFiscalList);
      procedure AgregarUbicacion(Ubicacion: IFEXmlT_Ubicacion);
      procedure AgregarUbicacionFiscal(Ubicacion: IFEXmlT_UbicacionFiscal);
  public
      constructor Create(Comprobante: IFEXMLComprobante; aVersionCFD:
          TFEVersionComprobante); overload;
      function Calcular() : TStringCadenaOriginal;
  end;


implementation

uses SysUtils, StrUtils, FacturaReglamentacion;

// Debemos de recibir el XML del comprobante con todas sus propiedades debidamente
// llenas
constructor TCadenaOriginal.Create(Comprobante: IFEXMLComprobante; aVersionCFD:
    TFEVersionComprobante);
begin
    inherited Create;
    fXMLComprobante:=Comprobante;
    fVersionCFD:=aVersionCFD;
end;

// Funcion usada para remover los espacios internos
// Credito: http://www.delphipages.com/forum/showthread.php?t=160663 usuario chris_w
function TCadenaOriginal.RemoverExcesoEspacios(const s: string): string;
var
  I, n: Integer;
begin
  SetLength(result, Length(s));
  if s <> '' then
  begin
    n := 0;
    for I := 1 to Length(s) do
    begin
      {$IF Compilerversion >= 20}
       if CharInSet(S[I], [#10, #13, #32]) then
      {$ELSE}
       if (s[I] in [#10, #13, #32]) then
      {$IFEND}
      begin
        if (n < 1) or (result[n] <> #32) then
        begin
          Inc(n);
          result[n] := #32;
        end;
      end
      else
      begin
        Inc(n);
        result[n] := s[I];
      end;
    end;

    while (n > 1) and (result[n] = #32) do
      Dec(n);

    SetLength(result, n);
    result := result;
  end;
end;

function TCadenaOriginal.LimpiaCampo(sTexto: String): String;
begin
    // 1. Ninguno de los atributos que conforman al comprobante fiscal digital deberá contener el caracter | (“pipe”)
    // debido a que este será utilizado como caracter de control en la formación de la cadena original.
    sTexto := AnsiReplaceStr(sTexto, _PIPE, '');
    // Quitamos los retornos de carro
    // Reemplazamos los TABs, retornos de carro por espacios  (Regla 5.a) del Anexo 20
    sTexto := AnsiReplaceStr(sTexto, #13, ' ');
    sTexto := AnsiReplaceStr(sTexto, #10, ' ');
    sTexto := AnsiReplaceStr(sTexto, #9, ' ');
    // Quitamos los espacios iniciales, finales e intermedios (mayores a 2)
    sTexto := RemoverExcesoEspacios(Trim(sTexto));
    result := sTexto;
end;

procedure TCadenaOriginal.AgregarAtributo(NodoPadre: IXMLNode; sNombreAtributo: String);
var
  sValor: String;
begin
  // 5. Los datos opcionales no expresados, no aparecerán en la cadena original y no tendrán delimitador alguno.
  // Si se nos fue especificado un nodo "padre" checamos si tiene al atributo hijo
  // si no, ni siquiera lo "consultamos" ya que lo agregaria al XML con valores vacios
  if Assigned(NodoPadre) then
    if NodoPadre.HasAttribute(sNombreAtributo) then
    begin
      sValor:=LimpiaCampo(NodoPadre.AttributeNodes[sNombreAtributo].Text);
      // Checamos que no sea vacio el valor...
      if Trim(sValor) <> '' then
        // Lo agregamos a la variable interna de la clase
        fResultado := fResultado + sValor + _PIPE;
    end;
end;

procedure TCadenaOriginal.AgregarRegimenesFiscales(const aRegimenesFiscales:
    IXMLComprobante_Emisor_RegimenFiscalList);
var
  I: Integer;
  NombreRegimen: String;
begin
  //Assert(fXmlComprobante Is IFEXMLComprobanteV22, 'El CFD debe ser v2.2 para soportar regimenes');
  for I := 0 to IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal.Count - 1 do
  begin
      AgregarAtributo(IFEXMLComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal[I], 'Regimen');
  end;
end;

procedure TCadenaOriginal.AgregarUbicacion(Ubicacion: IFEXmlT_Ubicacion);
begin
  AgregarAtributo(Ubicacion, 'calle');
  AgregarAtributo(Ubicacion, 'noExterior');
  AgregarAtributo(Ubicacion, 'noInterior');
  AgregarAtributo(Ubicacion, 'colonia');
  AgregarAtributo(Ubicacion, 'localidad');
  AgregarAtributo(Ubicacion, 'referencia');
  AgregarAtributo(Ubicacion, 'municipio');
  AgregarAtributo(Ubicacion, 'estado');
  AgregarAtributo(Ubicacion, 'pais');
  AgregarAtributo(Ubicacion, 'codigoPostal');
end;

procedure TCadenaOriginal.AgregarUbicacionFiscal(Ubicacion: IFEXmlT_UbicacionFiscal);
begin
  AgregarAtributo(Ubicacion, 'calle');
  AgregarAtributo(Ubicacion, 'noExterior');
  AgregarAtributo(Ubicacion, 'noInterior');
  AgregarAtributo(Ubicacion, 'colonia');
  AgregarAtributo(Ubicacion, 'localidad');
  AgregarAtributo(Ubicacion, 'referencia');
  AgregarAtributo(Ubicacion, 'municipio');
  AgregarAtributo(Ubicacion, 'estado');
  AgregarAtributo(Ubicacion, 'pais');
  AgregarAtributo(Ubicacion, 'codigoPostal');
end;

function TCadenaOriginal.Calcular(): TStringCadenaOriginal;
var
  I, J: Integer;
begin
      fResultado := '';
  
      // 2. El inicio de la cadena original se encuentra marcado mediante una secuencia de caracteres || (doble “pipe”).
      fResultado := _PIPE + _PIPE;
      // 1) Datos del comprobante

      // NOTA IMPORTANTE: El parametro nombre de atributo tiene que ser exactamente igual que el de la definicion
      // del XSD (minusculas y mayusculas) ya que es sensible a ello.
      AgregarAtributo(fXmlComprobante, 'version');
      AgregarAtributo(fXmlComprobante, 'serie');
      AgregarAtributo(fXmlComprobante, 'folio');
      AgregarAtributo(fXmlComprobante, 'fecha');
      AgregarAtributo(fXmlComprobante, 'noAprobacion');
      AgregarAtributo(fXmlComprobante, 'anoAprobacion');
      AgregarAtributo(fXmlComprobante, 'tipoDeComprobante');
      AgregarAtributo(fXmlComprobante, 'formaDePago');
      AgregarAtributo(fXmlComprobante, 'condicionesDePago');

      AgregarAtributo(fXmlComprobante, 'subTotal');
      AgregarAtributo(fXmlComprobante, 'descuento');
      AgregarAtributo(fXmlComprobante, 'total');

      // Nuevos atributos requeridos de la v2.2:
      case fVersionCFD of
        fev20:
        begin
           // 2) Datos del emisor
           AgregarAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor, 'rfc');
           AgregarAtributo(IFEXmlComprobanteV2(fXmlComprobante).Emisor, 'nombre');
           // 3) Datos del domicilio fiscal del emisor
           AgregarUbicacionFiscal(IFEXmlComprobanteV2(fXmlComprobante).Emisor.DomicilioFiscal);
           // 4) Datos del Domicilio de Expedición del Comprobante
           if Assigned(fXmlComprobante.ChildNodes.FindNode('Emisor')) then
             if Assigned(fXmlComprobante.ChildNodes.FindNode('Emisor').ChildNodes.FindNode('ExpedidoEn')) then
               AgregarUbicacion(IFEXmlComprobanteV2(fXmlComprobante).Emisor.ExpedidoEn);
        end;
        fev22:
        begin
           AgregarAtributo(fXmlComprobante, 'metodoDePago');  // Requerido
           AgregarAtributo(fXmlComprobante, 'LugarExpedicion'); // Requerido
           AgregarAtributo(IFEXmlComprobanteV22(fXmlComprobante), 'NumCtaPago');

          { if Assigned(fXmlComprobante.ChildNodes.FindNode('TipoCambio')) then
              AgregarAtributo(IFEXmlComprobanteV22(fXmlComprobante), 'TipoCambio');

           if Assigned(fXmlComprobante.ChildNodes.FindNode('Moneda')) then
              AgregarAtributo(IFEXmlComprobanteV22(fXmlComprobante), 'Moneda'); }

           AgregarAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor, 'rfc');
           AgregarAtributo(IFEXmlComprobanteV22(fXmlComprobante).Emisor, 'nombre');
           // 3) Datos del domicilio fiscal del emisor
           AgregarUbicacionFiscal(IFEXmlComprobanteV22(fXmlComprobante).Emisor.DomicilioFiscal);
           // 4) Datos del Domicilio de Expedición del Comprobante
           if Assigned(fXmlComprobante.ChildNodes.FindNode('Emisor')) then
             if Assigned(fXmlComprobante.ChildNodes.FindNode('Emisor').ChildNodes.FindNode('ExpedidoEn')) then
               AgregarUbicacion(IFEXmlComprobanteV22(fXmlComprobante).Emisor.ExpedidoEn);

           // 5) Datos del Regimen Fiscal
           if Assigned(IFEXmlComprobanteV22(fXmlComprobante).ChildNodes.FindNode('Emisor').ChildNodes.FindNode('RegimenFiscal')) then
              AgregarRegimenesFiscales(IFEXmlComprobanteV22(fXmlComprobante).Emisor.RegimenFiscal);
        end;
      end;

      // 6) Datos del Receptor
      AgregarAtributo(fXmlComprobante.Receptor, 'rfc');

      // Checamos si es una factura al publico en general
      // si lo es, NO incluimos el nombre
      if ((fXmlComprobante.Receptor.Rfc <> _RFC_VENTA_PUBLICO_EN_GENERAL)
          And (fXmlComprobante.Receptor.Rfc <> _RFC_VENTA_EXTRANJEROS)) then
              AgregarAtributo(fXmlComprobante.Receptor, 'nombre');
      
      // 7) Datos del domicilio fiscal del Receptor
      AgregarUbicacion(fXmlComprobante.Receptor.Domicilio);

      // 8) Datos de Cada Concepto Relacionado en el Comprobante
      for I := 0 to fXmlComprobante.Conceptos.Count - 1 do
      begin
          with fXmlComprobante.Conceptos do
          begin
              AgregarAtributo(Concepto[I], 'cantidad');
              AgregarAtributo(Concepto[I], 'unidad');
              AgregarAtributo(Concepto[I], 'noIdentificacion');
              AgregarAtributo(Concepto[I], 'descripcion');
              AgregarAtributo(Concepto[I], 'valorUnitario');
              AgregarAtributo(Concepto[I], 'importe');

              // Agregamos la informacion aduanera a la cadena original
              // Codigo agregado por usuario pimentelflores - https://github.com/pimentelflores
              if Assigned(Concepto[I].ChildNodes.FindNode('InformacionAduanera')) then
              begin
                for J := 0 to Concepto[i].InformacionAduanera.Count - 1 do
                begin
                    with Concepto[i].InformacionAduanera do
                    begin
                      agregaratributo(Concepto[i].InformacionAduanera[J],'numero');
                      agregaratributo(Concepto[i].InformacionAduanera[J],'fecha');
                      agregaratributo(Concepto[i].InformacionAduanera[J],'aduana');
                    end;
                end;
              end;

              AgregarAtributo(Concepto[I], 'CuentaPredial.numero');
          end;
      end;

      // TODO: Agregar los "ComplementoConcepto" regla 9 del Anexo 20
      // TODO: Arreglar nodo Complemento segun la regla 10

      // 9) Datos de Cada Retención de Impuestos
      // Solo accedemos al nodo XML si hubo retenciones
      //fXmlComprobante.HasAttribute()
      if Assigned(fXmlComprobante.ChildNodes.FindNode('Impuestos')) then
          if Assigned(fXmlComprobante.ChildNodes.FindNode('Impuestos').ChildNodes.FindNode('Retenciones')) then
              for I := 0 to fXmlComprobante.Impuestos.Retenciones.Count - 1 do
              begin
                with fXmlComprobante.Impuestos.Retenciones do
                begin
                  AgregarAtributo(Retencion[I], 'impuesto');
                  AgregarAtributo(Retencion[I], 'importe');
                end;
              end;

      AgregarAtributo(fXmlComprobante.Impuestos, 'totalImpuestosRetenidos');

      // 10) Datos de Cada Traslado de Impuestos
      if Assigned(fXmlComprobante.ChildNodes.FindNode('Impuestos')) then
          if Assigned(fXmlComprobante.ChildNodes.FindNode('Impuestos').ChildNodes.FindNode('Traslados')) then
              for I := 0 to fXmlComprobante.Impuestos.Traslados.Count - 1 do
              begin
                with fXmlComprobante.Impuestos.Traslados do
                begin
                  AgregarAtributo(Traslado[I], 'impuesto');
                  AgregarAtributo(Traslado[I], 'tasa');
                  AgregarAtributo(Traslado[I], 'importe');
                end;
              end;


     AgregarAtributo(fXmlComprobante.Impuestos, 'totalImpuestosTrasladados');

      // 6. El final de la cadena original será expresado mediante una cadena de caracteres || (doble “pipe”).
      // 7. Toda la cadena de original se encuentra expresada en el formato de codificación UTF-8.
      // Solo agregamos un PIPE mas porque el ultimo atributo tiene al final su pipe.
      Result:=UTF8Encode(fResultado + _PIPE);
end;


// TODO:
// Incluimos los archivos XSLT como recursos (.RES) para no tener que distribuirlos
// manualmente en el EXE
// Mas Info en: http://delphi.about.com/od/objectpascalide/a/embed_resources.htm
// Regresamos la Cadena Original de este comprobante fiscal segun las reglas
// definidas previamente...
{
  function TFEComprobanteFiscal.getCadenaOriginalOld(): WideString;
  var
  XSLTransformador: TXSLPageProducer;
  begin
  // La cadena original tambien puede ser generada usando un componente de transformacion
  // XSLT y usando los archivos para dicho proposito, sin embargo se decidio
  // hacerlo manualmente para evitar multiples dependencias de librerias DLL para su funcionamiento

  // Primero, extraemos los archivos XSLT para realizar la transformacion de los archivos .RES
  // TODO: Extraer de los RES



  XSLTransformador := TXSLPageProducer.Create(nil);
  XSLTransformador.ParseOptions := [poResolveExternals, poValidateOnParse];
  // XMLDocument1.Active := False; // just in case
  XSLTransformador.FileName :='C:\Delphi\Otros\bc_facturacionelectronica\Resources\cadenaoriginal_2_0_l.xslt';
  XSLTransformador.XMLData := fDocumentoXML;
  // XMLDocument1.Active := True;
  // Al ejecutar la siguiente lienea, el transformador usa la plantilla XSLT del SAT
  // para convertir el XML en la CadenaOriginal usando precisamente, las reglas de validacion
  // y presentacion definidas en los documentos XSLT.
  try
  sCadenaOriginal := XSLTransformador.Content;
  // XMLDocument1.Active := False;
  // TODO: Codificar en UTF8??? o ya viene asi del XSLT????
  // NOTA: Al obtenerlo para desplegarlo hay que descodificarlo de UTF8, por ejemplo para un Memo edit.
  Result := sCadenaOriginal;
  except
  // Manejar los diversos errores de validacion que se pueden generar...
  On E: Exception do
  begin
  ShowMessage(E.Message);
  Result := '';
  end;
  end;

  FreeAndNil(XSLTransformador);
  end;
}

end.
