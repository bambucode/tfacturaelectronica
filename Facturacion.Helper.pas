unit Facturacion.Helper;

interface

uses Facturacion.Comprobante,
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils,
     Windows
{$IFEND};

type

  TFacturacionHelper = class
    class function ComoCantidad(const aValor: Double) : string;
    class function ComoMoneda(const aValor: Currency; const aNumeroDecimales: Integer = 2): string;
    class function ComoFechaISO8601(const aFecha: TDateTime): string;
    class function ComoTasa(const aPorcentaje: Double): String;
    class function ComoPorcentaje(const aPorcentaje: Double): String;
    class function ComoTasaImpuestoLocal(const aPorcentaje: Double): String;
    class function DesdeCantidad(const aCantidad: String): Double;
    class function DesdeFechaISO8601(const aCadenaFecha: String): TDateTime;
    class function DesdeMoneda(aMoneda: String): Currency;
    class function DesdeTasa(const aTasa: String): Double;
    class function LimpiarCaracteresInvalidos(const aCadena: string): string;
    class function VerificarImporteEnRangoDeRedondeo(const aCantidad: Double; const aValorUnitario, aImporte: Currency): Boolean;

    class procedure AgregarSchemaLocation(const aComprobante: IComprobanteFiscal; const aCadena: String);
    class procedure CorregirConfiguracionRegionalLocal;
    class procedure RegresarConfiguracionRegionalLocal;
    class procedure ReemplazarComaSiActuaComoPuntoDecimal(var aCadenaCatidad: String);
  end;

var
  separadorDecimalAnterior: Char;
  separadorDeMiles: Char;
  formatSettingsLocal : TFormatSettings;

const
  _PUNTO_DECIMAL = '.';
  _COMA_DECIMAL  = ',';

implementation

uses
{$IF CompilerVersion >= 23}
  System.Math,
  System.StrUtils,
  Soap.XSBuiltIns
{$ELSE}
  Math,
  StrUtils,
  XSBuiltIns
{$IFEND}
{$IFDEF CODESITE}
  ,CodeSiteLogging
{$ENDIF};


{ TFacturacionHelper }

class procedure TFacturacionHelper.CorregirConfiguracionRegionalLocal;
begin
  // Debido a que si el usuario en la PC tiene una configuración regional incorrecta
  // los XMLs se generan con montos y cantidades inválidas
  separadorDecimalAnterior := formatSettingsLocal.DecimalSeparator;
  separadorDeMiles         := formatSettingsLocal.ThousandSeparator;
  // Indicamos que el separador Decimal será el punto
  formatSettingsLocal.DecimalSeparator  := _PUNTO_DECIMAL;
  //formatSettingsLocal.ThousandSeparator := _COMA_DECIMAL;
end;

class procedure TFacturacionHelper.RegresarConfiguracionRegionalLocal;
begin
  formatSettingsLocal.DecimalSeparator  := separadorDecimalAnterior;
  formatSettingsLocal.ThousandSeparator := separadorDeMiles;
end;

// "Se expresa en la forma aaaa-mm-ddThh:mm:ss, de acuerdo con la especificación ISO 8601"
class procedure TFacturacionHelper.AgregarSchemaLocation(
  const aComprobante: IComprobanteFiscal; const aCadena: String);
var
  schemaLocation : String;
begin
  schemaLocation := aComprobante.Attributes['xsi:schemaLocation'];
  aComprobante.SetAttribute('xsi:schemaLocation',
                            schemaLocation + ' ' + aCadena);
  aComprobante.Resync;
end;

class function TFacturacionHelper.ComoCantidad(const aValor: Double): string;
begin
  // Anexo 20:
  // "En este campo se debe registrar la cantidad de bienes o servicios que
  // correspondan a cada concepto, puede contener de cero hasta seis decimales."
  try
    CorregirConfiguracionRegionalLocal;
    Result := FormatFloat('0.####', aValor, formatSettingsLocal); //FloatToStrF(aValor, ffFixed, 20, 4);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoTasa(const aPorcentaje: Double): String;
begin
  try
    CorregirConfiguracionRegionalLocal;
    Result := Format('%1.6f', [aPorcentaje / 100], formatSettingsLocal);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoTasaImpuestoLocal(const aPorcentaje: Double): String;
begin
  try
    CorregirConfiguracionRegionalLocal;
    Result := Format('%1.2f', [aPorcentaje], formatSettingsLocal);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoPorcentaje(const aPorcentaje: Double): String;
begin
  try
    CorregirConfiguracionRegionalLocal;
    Result := Format('%1.2f', [aPorcentaje], formatSettingsLocal);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.DesdeTasa(const aTasa: String): Double;
begin
  try
    CorregirConfiguracionRegionalLocal;
    Result := (StrToFloat(aTasa, formatSettingsLocal) * 100);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.LimpiarCaracteresInvalidos(
  const aCadena: string): string;
begin
  Result := StringReplace(aCadena, '|', '',[rfReplaceAll, rfIgnoreCase]);
end;

class function TFacturacionHelper.DesdeCantidad(const aCantidad: String): Double;
begin
  try
    CorregirConfiguracionRegionalLocal;
    Result := (StrToFloat(aCantidad, formatSettingsLocal));
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class procedure TFacturacionHelper.ReemplazarComaSiActuaComoPuntoDecimal(var aCadenaCatidad: String);
begin
  // Reemplazamos cualquier coma por el simbolo de punto
  aCadenaCatidad := StringReplace(aCadenaCatidad,
                                  _COMA_DECIMAL,
                                  _PUNTO_DECIMAL,
                                  [rfReplaceAll]);
end;

class function TFacturacionHelper.DesdeMoneda(aMoneda: String): Currency;
begin
  try
    CorregirConfiguracionRegionalLocal;
    ReemplazarComaSiActuaComoPuntoDecimal(aMoneda);
    Result := StrToCurr(aMoneda, formatSettingsLocal);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime): string;
begin
  Result := AnsiReplaceStr(FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha), {$IF CompilerVersion >=15}FormatSettings.{$IFEND}TimeSeparator, ':');
end;

class function TFacturacionHelper.ComoMoneda(const aValor: Currency; const
    aNumeroDecimales: Integer = 2): string;
begin
  // NOTA: Esta moneda es para el XML, NO debe llevar simbolo de moneda
  try
    CorregirConfiguracionRegionalLocal;
    if (Frac(aValor) = 0) And (aValor = 0) then
      Result := CurrToStrF(aValor, ffFixed, 0, formatSettingsLocal)
    else
      Result := CurrToStrF(aValor, ffFixed, aNumeroDecimales, formatSettingsLocal);
  finally
    RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.DesdeFechaISO8601(
  const aCadenaFecha: String): TDateTime;
begin
  with TXSDateTime.Create() do
  try
    XSToNative(aCadenaFecha);
    Result := AsDateTime;
  finally
    Free;
  end;
end;

class function TFacturacionHelper.VerificarImporteEnRangoDeRedondeo(const
    aCantidad: Double; const aValorUnitario, aImporte: Currency): Boolean;
var
  limiteInferior, limiteSuperior: Extended;
const
  _NUMERO_DECIMALES_MXN = 2;
  _BASE = 10;
begin
  if aCantidad <= 0 then
  begin
    Result := True;
    exit;
  end;
  // Ref: http://www.fiscalia.com/publicaciones/10414
  // http://www.sat.gob.mx/informacion_fiscal/factura_electronica/Documents/cfdv33.pdf

  // Calculamos el limite inferior de acuerdo al Anexo 20
  limiteInferior := (aCantidad - RoundTo(IntPower(_BASE, _NUMERO_DECIMALES_MXN * -1)/2, -2)) *
                    (aValorUnitario - RoundTo(IntPower(_BASE,_NUMERO_DECIMALES_MXN * -1)/2, -2));

  // Establecemos el tipo de redondeo a truncado a dos decimales para el limite inferior
  limiteInferior := Trunc(limiteInferior * 100) / 100;

  // Calculamos el limite superior de acuerdo al Anexo 20
  limiteSuperior := (aCantidad + RoundTo(IntPower(_BASE, -1 * _NUMERO_DECIMALES_MXN)/2, -2) - IntPower(_BASE,-12)) *
                    (aValorUnitario + RoundTo(IntPower(_BASE,_NUMERO_DECIMALES_MXN * -1)/2, -2) - IntPower(_BASE,-12));

  // Para el limite superior, redondeamos "hacia arriba"
  limiteSuperior := Ceil(limiteSuperior * 100) / 100;

  // ¿El importe calculado, esta dentro de rango validado por el SAT?
  Result := {$IF CompilerVersion >= 23}System.Math.{$ELSE}Math.{$IFEND}InRange(aImporte, limiteInferior, limiteSuperior);
end;

initialization
 {$IF CompilerVersion >= 17}
  formatSettingsLocal := TFormatSettings.Create;
 {$ELSE}
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, formatSettingsLocal);
 {$IFEND}

end.
