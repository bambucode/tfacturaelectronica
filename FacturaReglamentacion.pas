(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Metodos para validar los diferentes tipos de datos y como deben de estar
 especificados en el archivo XML.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit FacturaReglamentacion;

interface

type

  TFEReglamentacion = class
  private
      class procedure CorregirConfiguracionRegionalLocal;
      class procedure ReemplazarComaSiActuaComoPuntoDecimal(var aCadenaCatidad:
          String);
      class procedure RegresarConfiguracionRegionalLocal;
  public
      /// <summary>Convierte el valor de moneda al formato de dinero requerido por el SAT
      /// </summary>
      /// <param name="Monto">Monto a convertir al formato aceptado por el SAT</param>
      class function ComoMoneda(aMonto: Currency; const aDecimalesDefault: Integer
          = 2): String;
      class function ComoCadena(sCadena: String) : String;
      class function ComoCantidad(dCantidad: Double; const aNumeroDecimales: Integer
          = 2): String;
      class function ComoFechaHora(dtFecha: TDateTime) : String;
      class function DeFechaHoraISO8601(const aFechaISO8601: String) : TDateTime;
      class function ComoFechaAduanera(dtFecha: TDateTime) : String;
      class function ComoTasaImpuesto(dTasa: Double; const aDecimalesDefault: Integer
          = 2): String;
      class function ComoDateTime(sFechaISO8601: String): TDateTime;
      class function ComoFechaHoraInforme(dtFecha: TDateTime) : String;
      /// <summary>
      ///   Se encarga de convertir una cadena de método de pago al número del
      ///   catálogo del SAT. Referencia:
      ///   http://www.sat.gob.mx/fichas_tematicas/buzon_tributario/Documents/catalogo_metodos_pago.pdf
      /// </summary>
      /// <param name="aCadenaMetodoDePago">
      ///   Cadena, Ejemplo: Efectivo, Vales de Despensa, etc.
      /// </param>
      /// <returns>
      ///   Regresa el numero del catálogo del SAT oficial o cadena vacía si la
      ///   cadena no fue encontrada dentro del catálogo oficial.
      /// </returns>
      class function ConvertirCadenaMetodoDePagoANumeroCatalogo(const
          aCadenaMetodoDePago: string): String;
      class function DeTasaImpuesto(const aCadenaTasa: String) : Double;
      class function DeCantidad(aCadenaCatidad: String): Double;
      class function DeMoneda(aMoneda: String): Currency;
  end;

var
  separadorDecimalAnterior: Char;

const
  _PUNTO_DECIMAL = '.';
  _COMA_DECIMAL  = ',';

implementation

uses DateUtils,
     {$IF Compilerversion >= 20}
     Soap.XSBuiltIns,
     {$ELSE}
     XSBuiltIns,
     {$IFEND}
     SysUtils, Windows;

var
  formatSettingsLocal : TFormatSettings;

class procedure TFEReglamentacion.CorregirConfiguracionRegionalLocal;
begin
  // Debido a que si el usuario en la PC tiene una configuración regional incorrecta
  // los XMLs se generan con montos y cantidades inválidas
  separadorDecimalAnterior := formatSettingsLocal.DecimalSeparator;
  // Indicamos que el separador Decimal será el punto
  formatSettingsLocal.DecimalSeparator := _PUNTO_DECIMAL;
end;

class procedure TFEReglamentacion.RegresarConfiguracionRegionalLocal;
begin
  formatSettingsLocal.DecimalSeparator := separadorDecimalAnterior;
end;

// Segun las reglas del SAT:
// "Se expresa en la forma aaaa-mm-ddThh:mm:ss, de acuerdo con la especificación ISO 8601"
class function TFEReglamentacion.ComoFechaHora(dtFecha: TDateTime) : String;
begin
  Result := FormatDateTime('yyyy-mm-dd', dtFecha) + 'T' + FormatDateTime('hh:nn:ss', dtFecha);
end;

class function TFEReglamentacion.DeFechaHoraISO8601(const aFechaISO8601: String) : TDateTime;
begin
  // Ref: http://stackoverflow.com/questions/6651829/how-do-i-convert-an-iso-8601-string-to-a-delphi-tdate
  with TXSDateTime.Create() do
  try
    XSToNative(aFechaISO8601);
    Result := AsUTCDateTime;
  finally
    Free;
  end;
end;

// Regresa la fecha/hora en el formato del Informe Mensual
class function TFEReglamentacion.ComoFechaHoraInforme(dtFecha: TDateTime) : String;
begin
  Result := FormatDateTime('dd/mm/yyyy', dtFecha) + ' ' + FormatDateTime('hh:nn:ss', dtFecha);
  {$IFDEF DEBUG}
      Assert(Length(Result) = 19, 'La longitud de la fecha del informe no fue de 19 caracteres!');
  {$ENDIF}
end;

// Convierte una fecha de ISO 8601 (formato del XML) a TDateTime usado en Delphi.
class function TFEReglamentacion.ComoDateTime(sFechaISO8601: String): TDateTime;
var
    sAno, sMes, sDia, sHora, sMin, sMs: String;
begin
    // Ejemplo: 2009-08-16T16:30:00
    sAno := Copy(sFechaISO8601, 1, 4);
    sMes := Copy(sFechaISO8601, 6, 2);
    sDia := Copy(sFechaISO8601, 9, 2);
    sHora := Copy(sFechaISO8601, 12, 2);
    sMin := Copy(sFechaISO8601, 15, 2);
    sMs := Copy(sFechaISO8601, 18, 2);
    Result := EncodeDateTime(StrToInt(sAno), StrToInt(sMes), StrToInt(sDia), StrToInt(sHora),
                              StrToInt(sMin), StrToInt(sMs), 0);
end;

class function TFEReglamentacion.ComoFechaAduanera(dtFecha: TDateTime) : String;
begin
   // Formato sacado del CFDv2.XSD: "Atributo requerido para expresar la fecha de expedición
   // del documento aduanero que ampara la importación del bien. Se expresa en el formato aaaa-mm-dd"
   Result := FormatDateTime('yyyy-mm-dd', dtFecha);
end;

class function TFEReglamentacion.ComoMoneda(aMonto: Currency; const
    aDecimalesDefault: Integer = 2): String;
begin
   // Regresamos los montos de monedas con 6 decimales (maximo permitido en el XSD)
   // http://www.sat.gob.mx/cfd/3/cfdv32.xsd
   // http://www.sat.gob.mx/cfd/2/cfdv22.xsd
   try
      CorregirConfiguracionRegionalLocal;
      Result:=FloatToStrF(aMonto, ffFixed, 10, aDecimalesDefault);
   finally
      RegresarConfiguracionRegionalLocal;
   end;
end;

class function TFEReglamentacion.ComoTasaImpuesto(dTasa: Double; const
    aDecimalesDefault: Integer = 2): String;
begin
   // Regresamos los montos de monedas con 6 decimales (maximo permitido en el XSD)
   // http://www.sat.gob.mx/cfd/3/cfdv32.xsd
   // http://www.sat.gob.mx/cfd/2/cfdv22.xsd
   try
     CorregirConfiguracionRegionalLocal;
     Result:=FloatToStrF(dTasa,ffFixed, 10, aDecimalesDefault);
   finally
     RegresarConfiguracionRegionalLocal;
   end;
end;

class function TFEReglamentacion.DeTasaImpuesto(const aCadenaTasa: String) : Double;
begin
  Result := TFEReglamentacion.DeCantidad(aCadenaTasa);
end;

class function TFEReglamentacion.DeCantidad(aCadenaCatidad: String): Double;
begin
  try
     CorregirConfiguracionRegionalLocal;
     ReemplazarComaSiActuaComoPuntoDecimal(aCadenaCatidad);
     Result:=StrToFloat(aCadenaCatidad);
  finally
     RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFEReglamentacion.DeMoneda(aMoneda: String): Currency;
begin
  try
     CorregirConfiguracionRegionalLocal;
     ReemplazarComaSiActuaComoPuntoDecimal(aMoneda);
     Result:=StrToCurr(aMoneda);
  finally
     RegresarConfiguracionRegionalLocal;
  end;
end;

// Las cadenas usadas en el XML deben de escapar caracteres incorrectos
// Ref: http://dof.gob.mx/nota_detalle.php?codigo=5146699&fecha=15/06/2010
class function TFEReglamentacion.ComoCadena(sCadena: String) : String;
var
   sCadenaEscapada: String;
begin
    sCadenaEscapada:=sCadena;
    // Las siguientes validaciones las omitimos ya que las mismas clases
    // de Delphi lo hacen por nosotros:
    // En el caso del & se deberá usar la secuencia &amp;
    // En el caso del “ se deberá usar la secuencia &quot;
    // En el caso del < se deberá usar la secuencia &lt;
    // En el caso del > se deberá usar la secuencia &gt;
    // En el caso del ‘ se deberá usar la secuencia &apos;

    // No es permitido el caracter de | en las cadenas (entra en conflicto con la generación de la Cadena Original)
    sCadenaEscapada := StringReplace(sCadenaEscapada, '|', '', [rfReplaceAll]);

    // Si se presentan nuevas reglas para los Strings en el XML, incluirlas aqui

    Result:=sCadenaEscapada;
end;

class function TFEReglamentacion.ComoCantidad(dCantidad: Double; const
    aNumeroDecimales: Integer = 2): String;
begin
   // Las cantidades cerradas las regresamos sin decimales
   // las que tienen fracciones con 6 digitos decimales para respetar la especificacion
   // del Anexo 20 respecto al tipo xs:decimal
   try
     CorregirConfiguracionRegionalLocal;
     if Frac(dCantidad) > 0 then
        Result:=FloatToStrF(dCantidad,ffFixed, 10, aNumeroDecimales)
     else
        Result:=IntToStr(Round(dCantidad));
   finally
     RegresarConfiguracionRegionalLocal;
   end;
end;


class function TFEReglamentacion.ConvertirCadenaMetodoDePagoANumeroCatalogo(
    const aCadenaMetodoDePago: string): String;
var
  cadenaSinAcentos: string;
begin
  Result := '';

  cadenaSinAcentos := UpperCase(aCadenaMetodoDePago);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'Á', 'A', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'É', 'E', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'Í', 'I', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'Ó', 'O', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'Ú', 'U', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'á', 'A', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'é', 'E', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'í', 'I', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'ó', 'O', [rfReplaceAll]);
  cadenaSinAcentos := StringReplace(cadenaSinAcentos, 'ú', 'U', [rfReplaceAll]);

  if cadenaSinAcentos = 'EFECTIVO' then
    Result := '01';

  if cadenaSinAcentos = 'CHEQUE' then
    Result := '02';

  if AnsiPos('TRANSFERENCIA', cadenaSinAcentos) > 0 then
    Result := '03';

  if (cadenaSinAcentos = 'TARJETA DE CREDITO') or
     (cadenaSinAcentos = 'TARJETAS DE CREDITO' ) then
    Result := '04';

  if AnsiPos('MONEDERO', cadenaSinAcentos) > 0 then
    Result := '05';

  if (cadenaSinAcentos = 'DINERO ELECTRONICO') then
    Result := '06';

  // Se omite el 07

  if AnsiPos('VALE', cadenaSinAcentos) > 0 then
    Result := '08';

  if (cadenaSinAcentos = 'TARJETA DE DEBITO') or
     (cadenaSinAcentos = 'TARJETAS DE DEBITO' ) then
    Result := '28';

  if (cadenaSinAcentos = 'TARJETA DE SERVICIO') or
     (cadenaSinAcentos = 'TARJETAS DE SERVICIO' ) then
    Result := '29';

  if ((cadenaSinAcentos = 'NA') or
     (cadenaSinAcentos = 'NO APLICA') or
     (cadenaSinAcentos = 'NO IDENTIFICADO') or
     (cadenaSinAcentos = 'OTROS')) then
    Result := '99';

end;

class procedure TFEReglamentacion.ReemplazarComaSiActuaComoPuntoDecimal(var
    aCadenaCatidad: String);
begin
  // Reemplazamos cualquier coma por el simbolo de punto
  aCadenaCatidad := StringReplace(aCadenaCatidad,
                                  _COMA_DECIMAL,
                                  _PUNTO_DECIMAL,
                                  [rfReplaceAll]);
end;

initialization
  formatSettingsLocal := TFormatSettings.Create;
end.