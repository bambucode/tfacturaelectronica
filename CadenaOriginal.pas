unit CadenaOriginal;

interface

uses FacturaTipos, FeCFDv2,
     XmlDom, XMLIntf, MsXmlDom, XMLDoc, XSLProd;

type

  // Generamos la estructura "Cadena Original" de acuerdo a las reglas del SAT
  // definidas en: http://www.sat.gob.mx/sitio_internet/e_sat/comprobantes_fiscales/15_6543.html
  TCadenaOriginal = class
  private
      fXMLComprobante: IFEXMLComprobante;
      fDesglosarTotalesImpuestos : Boolean;
      Resultado: TStringCadenaOriginal;
      const _PIPE = '|';
      function RemoverExcesoEspacios(const s: string): String;
      function LimpiaCampo(sTexto: String): String;
      procedure AgregarAtributo(NodoPadre: IXMLNode; sNombreAtributo: String);
      procedure AgregarUbicacion(Ubicacion: IFEXmlT_Ubicacion);
      procedure AgregarUbicacionFiscal(Ubicacion: IFEXmlT_UbicacionFiscal);
  public
      constructor Create(Comprobante: IFEXMLComprobante; DesglosarImpuestos : Boolean); overload;
      function Calcular() : TStringCadenaOriginal;
  end;


implementation

uses SysUtils, StrUtils, FacturaReglamentacion;

// Debemos de recibir el XML del comprobante con todas sus propiedades debidamente
// llenas
constructor TCadenaOriginal.Create(Comprobante: IFEXMLComprobante; DesglosarImpuestos : Boolean);
begin
    fXMLComprobante:=Comprobante;
    fDesglosarTotalesImpuestos:=DesglosarImpuestos;
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
      if (s[I] in [#10, #13, #32]) then
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
        Resultado := Resultado + sValor + _PIPE;
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
  I: Integer;
begin
      Resultado := '';
      {$IFDEF VER220} CodeSite.EnterMethod('Calcular'); {$ENDIF}

      // 2. El inicio de la cadena original se encuentra marcado mediante una secuencia de caracteres || (doble “pipe”).
      Resultado := _PIPE + _PIPE;
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
      // 2) Datos del emisor
      AgregarAtributo(fXmlComprobante.Emisor, 'rfc');
      AgregarAtributo(fXmlComprobante.Emisor, 'nombre');
      // 3) Datos del domicilio fiscal del emisor
      AgregarUbicacionFiscal(fXmlComprobante.Emisor.DomicilioFiscal);
      // 4) Datos del Domicilio de Expedición del Comprobante
      if fXmlComprobante.HasAttribute('Emisor') then
        if fXmlComprobante.Attributes['Emisor'].HasAttribute('ExpedidoEn') then
          AgregarUbicacion(fXmlComprobante.Emisor.ExpedidoEn);

      // 5) Datos del Receptor
      AgregarAtributo(fXmlComprobante.Receptor, 'rfc');
      AgregarAtributo(fXmlComprobante.Receptor, 'nombre');
      // 6) Datos del domicilio fiscal del Receptor
      AgregarUbicacion(fXmlComprobante.Receptor.Domicilio);
      // 7) Datos de Cada Concepto Relacionado en el Comprobante
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

          // TODO: Agregar soporte para informacion aduanera ya que se repiten los nodos
          { if Concepto[I].InformacionAduanera.HasAttribute('numero') then
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['numero']);

            if Concepto[I].InformacionAduanera.HasAttribute('fecha') then
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['fecha']);

            if Concepto[I].InformacionAduanera.HasAttribute('aduana') then
            AgregarAtributo(Concepto[I].InformacionAduanera.Attributes['aduana']); }

          AgregarAtributo(Concepto[I], 'CuentaPredial.numero');
        end;
      end;

      // TODO: Agregar los "ComplementoConcepto" regla 9 del Anexo 20
      // TODO: Arreglar nodo Complemento segun la regla 10

      // 8) Datos de Cada Retención de Impuestos
      // Solo accedemos al nodo XML si hubo retenciones
      if fXmlComprobante.HasAttribute('Impuestos') then
          if fXmlComprobante.HasAttribute('Retenciones') then
              for I := 0 to fXmlComprobante.Impuestos.Retenciones.Count - 1 do
              begin
                with fXmlComprobante.Impuestos.Retenciones do
                begin
                  AgregarAtributo(Retencion[I], 'impuesto');
                  AgregarAtributo(Retencion[I], 'importe');
                end;
              end;

      if fDesglosarTotalesImpuestos = True then
        AgregarAtributo(fXmlComprobante.Impuestos, 'totalImpuestosRetenidos');

      // 9) Datos de Cada Traslado de Impuestos
      if fXmlComprobante.HasAttribute('Impuestos') then
          if fXmlComprobante.HasAttribute('Traslados') then
              for I := 0 to fXmlComprobante.Impuestos.Traslados.Count - 1 do
              begin
                with fXmlComprobante.Impuestos.Traslados do
                begin
                  AgregarAtributo(Traslado[I], 'impuesto');
                  AgregarAtributo(Traslado[I], 'tasa');
                  AgregarAtributo(Traslado[I], 'importe');
                end;
              end;

      if fDesglosarTotalesImpuestos = True then
        AgregarAtributo(fXmlComprobante.Impuestos, 'totalImpuestosTrasladados');

      // 6. El final de la cadena original será expresado mediante una cadena de caracteres || (doble “pipe”).
      // 7. Toda la cadena de original se encuentra expresada en el formato de codificación UTF-8.
      // Solo agregamos un PIPE mas porque el ultimo atributo tiene al final su pipe.
      Result:=UTF8Encode(Resultado + _PIPE);
      {$IFDEF VER220} CodeSite.Send(Result,'Resultado'); {$ENDIF}
      {$IFDEF VER220} CodeSite.ExitMethod('getCadenaOriginal'); {$ENDIF}
end;

end.
