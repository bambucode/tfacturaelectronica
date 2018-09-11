unit Facturacion.Helper;

interface

uses Facturacion.Comprobante,
{$IF CompilerVersion >= 23}
     System.SysUtils,
     System.Types
{$ELSE}
     SysUtils,
     Types
{$IFEND};

const
  SB64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  IB64: array[#0..#255] of integer = (
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3E, $FF, $FF, $FF, $3F,
    $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $FF, $FF, $FF, $FF, $FF,
    $FF, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28,
    $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
  );
type
  SAByte = Array[0..0] of Byte;
  PSAByte = ^SAByte;

  TFacturacionHelper = class
    class function UTF8ToBytes(const s: TCadenaUTF8): TByteDynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
    class function BytesToUTF8(const ABytes: TByteDynArray): TCadenaUTF8; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
    class function Decode64(S: String): TByteDynArray;  // http://delphiaccess.com/foros/index.php/topic/11984-base64/
    class function Encode64(Bin: PByte; Count: integer): String; // http://delphiaccess.com/foros/index.php/topic/11984-base64/
    class function FileToByteArray( const FileName : string ) : TByteDynArray;
    class function FixedWideStringToArray(const aFixedWideString: WideString; const aElementFixedSize: Integer): TStringDynArray;

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
    class procedure CorregirConfiguracionRegionalLocal; deprecated; // ya no son necesarias en Delphi7 o superior
    class procedure RegresarConfiguracionRegionalLocal; deprecated; // ya no son necesarias en Delphi7 o superior
    class procedure ReemplazarComaSiActuaComoPuntoDecimal(var aCadenaCatidad: String);
  end;

var
  separadorDecimalAnterior: Char;
  separadorDeMiles: Char;
  formatSettingsLocal : TFormatSettings;
  formatSettingsLocalISO8601 : TFormatSettings;

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

// sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
class function TFacturacionHelper.UTF8ToBytes(
  const s: TCadenaUTF8): TByteDynArray;
begin
    {$IF Compilerversion >= 20}
   Assert(StringElementSize(s) = 1)
   {$IFEND};
   SetLength(Result, Length(s));
   if Length(Result) > 0 then
      Move(s[1], Result[0], Length(s));
end;

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

class function TFacturacionHelper.BytesToUTF8(
  const ABytes: TByteDynArray): TCadenaUTF8;
begin
   SetLength(Result, Length(ABytes));
   if Length(Result) > 0 then
      Move(abytes[0], Result[1], Length(ABytes));
end;

class function TFacturacionHelper.ComoCantidad(const aValor: Double): string;
begin
  // Anexo 20:
  // "En este campo se debe registrar la cantidad de bienes o servicios que
  // correspondan a cada concepto, puede contener de cero hasta seis decimales."
  try
    //CorregirConfiguracionRegionalLocal;
    Result := FormatFloat('0.####', aValor, formatSettingsLocal); //FloatToStrF(aValor, ffFixed, 20, 4);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoTasa(const aPorcentaje: Double): String;
begin
  try
    //CorregirConfiguracionRegionalLocal;
    Result := Format('%1.6f', [aPorcentaje / 100], formatSettingsLocal);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoTasaImpuestoLocal(const aPorcentaje: Double): String;
begin
  try
    //CorregirConfiguracionRegionalLocal;
    Result := Format('%1.2f', [aPorcentaje], formatSettingsLocal);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.ComoPorcentaje(const aPorcentaje: Double): String;
begin
  try
    //CorregirConfiguracionRegionalLocal;
    Result := Format('%1.2f', [aPorcentaje], formatSettingsLocal);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.DesdeTasa(const aTasa: String): Double;
begin
  try
    //CorregirConfiguracionRegionalLocal;
    Result := (StrToFloat(aTasa, formatSettingsLocal) * 100);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.Encode64(Bin: PByte; Count: integer): String;
var
  B0, B1, B2: BYTE;
  ABin: PSAByte;
  L, n, i: integer;
begin
  if Count = 0 then exit;
  ABin:= PSAByte(Bin);
  n:= 0;
  i:=1;
  L:= ((Count+2) div 3)*4;
  SetLength(Result, L);
  repeat
    B0:= ABin^[n];
    B1:= 0; B2:= 0;
    if (Count - n) > 0 then B1:= ABin^[n+1];
    if (Count - n) > 1 then B2:= ABin^[n+2];
    Result[i]:=   SB64[(B0 shr 2) and $003F +1];
    Result[i+1]:= SB64[((B0 shl 4) or (B1 shr 4)) and $3F +1];
    Result[i+2]:= SB64[((B1 shl 2) or (B2 shr 6)) and $3F +1];
    Result[i+3]:= SB64[(B2 and $3F) +1];
    inc(n,3);
    inc(i,4);
  until n >= Count;
  if n - Count >= 1 then Result[L]:=   '=';
  if n - Count = 2  then Result[L-1]:= '=';
end;

class function TFacturacionHelper.FileToByteArray(
  const FileName: string): TByteDynArray;
const BLOCK_SIZE=1024;
var BytesRead, BytesToWrite, Count : integer;
 F : FIle of Byte;
 pTemp : Pointer;
begin
 AssignFile( F, FileName );
 Reset(F);
try
 Count := FileSize( F );
 SetLength(Result, Count );
 pTemp := @Result[0];
 BytesRead := BLOCK_SIZE;
 while (BytesRead = BLOCK_SIZE ) do
 begin
  BytesToWrite := Min(Count, BLOCK_SIZE);
  BlockRead(F, pTemp^, BytesToWrite , BytesRead );
   pTemp := Pointer(LongInt(pTemp) + BLOCK_SIZE);
  Count := Count-BytesRead;
 end;
finally
  CloseFile( F );
 end;
end;

class function TFacturacionHelper.FixedWideStringToArray(
  const aFixedWideString: WideString;
  const aElementFixedSize: Integer): TStringDynArray;
var
i : integer;
begin
 SetLength(result, Length(aFixedWideString) div aElementFixedSize);
 if Length(aFixedWideString) > 0 then
 begin
  for i := 1 to Length(aFixedWideString) div aElementFixedSize do
  begin
   SetLength(result[i-1], Length(aFixedWideString));
   result[i-1] := aFixedWideString;
  end;
 end;
end;

class function TFacturacionHelper.LimpiarCaracteresInvalidos(
  const aCadena: string): string;
begin
  Result := StringReplace(aCadena, '|', '',[rfReplaceAll, rfIgnoreCase]);
end;

class function TFacturacionHelper.Decode64(S: String): TByteDynArray;
var
  B: array[0..3] of BYTE;
  L, n, i, j: integer;
begin
  n:= 1;
  i:= 0;
  L:= Length(S);
  if L < 4 then exit;
  while S[L] = '=' do dec(L);
  SetLength(Result, (L*3) div 4);
  repeat
    for j:= 0 to 3 do
    begin
      while (n < L) and (IB64[S[n]] = $FF) do inc(n); B[j]:= IB64[S[n]]; inc(n);
    end;
    Result[i]:=   (B[0] shl 2) or (B[1] shr 4);
    if B[2] = 255 then break;
    Result[i+1]:= (B[1] shl 4) or (B[2] shr 2);
    if B[3] = 255 then break;
    Result[i+2]:= (B[2] shl 6) or B[3];
    inc(i, 3);
  until n > L;
end;

class function TFacturacionHelper.DesdeCantidad(const aCantidad: String): Double;
begin
  try
    //CorregirConfiguracionRegionalLocal;
    Result := (StrToFloat(aCantidad, formatSettingsLocal));
  finally
    //RegresarConfiguracionRegionalLocal;
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
    //CorregirConfiguracionRegionalLocal;
    ReemplazarComaSiActuaComoPuntoDecimal(aMoneda);
    Result := StrToCurr(aMoneda, formatSettingsLocal);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

// "Se expresa en la forma aaaa-mm-ddThh:mm:ss, de acuerdo con la especificación ISO 8601"
class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime): string;
begin
  Result := AnsiReplaceStr(FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha), {$IF CompilerVersion >=15}FormatSettingsLocal.{$IFEND}TimeSeparator, ':');
end;

class function TFacturacionHelper.ComoMoneda(const aValor: Currency; const
    aNumeroDecimales: Integer = 2): string;
begin
  // NOTA: Esta moneda es para el XML, NO debe llevar simbolo de moneda
  try
    //CorregirConfiguracionRegionalLocal;
    if (Frac(aValor) = 0) And (aValor = 0) then
      Result := CurrToStrF(aValor, ffFixed, 0, formatSettingsLocal)
    else
      Result := CurrToStrF(aValor, ffFixed, aNumeroDecimales, formatSettingsLocal);
  finally
    //RegresarConfiguracionRegionalLocal;
  end;
end;

class function TFacturacionHelper.DesdeFechaISO8601(
  const aCadenaFecha: String): TDateTime;
begin
  {  Hay un error en la conversión (Al menos en D7 y XE1),
     la cual resta o suma N horas (según zona horaria) a la hora
     especificada en aCadenaFecha, aún  cuando la Z no esté
     especificada en aCadenaFecha.
     Ref: https://es.wikipedia.org/wiki/ISO_8601
  }

  {with TXSDateTime.Create() do
  try
    XSToNative(aCadenaFecha);
    Result := AsDateTime;
  finally
    Free;
  end;}

  result := StrToDateTime( AnsiReplaceStr(aCadenaFecha,'T',' '), formatSettingsLocalISO8601 );
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
  formatSettingsLocalISO8601 := TFormatSettings.Create;
 {$ELSE}
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, formatSettingsLocal);
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, formatSettingsLocalISO8601);
 {$IFEND}
  formatSettingsLocal.DecimalSeparator  := _PUNTO_DECIMAL;
  formatSettingsLocalISO8601.DecimalSeparator   := _PUNTO_DECIMAL;
  formatSettingsLocalISO8601.ThousandSeparator  := _COMA_DECIMAL;
  formatSettingsLocalISO8601.DateSeparator    := '-';
  formatSettingsLocalISO8601.TimeSeparator    := ':';
  formatSettingsLocalISO8601.ShortDateFormat  := 'yyyy-mm-dd';
  formatSettingsLocalISO8601.ShortTimeFormat  := 'HH:mm:ss.sss';
end.
