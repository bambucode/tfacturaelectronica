unit Facturacion.Helper;

interface

uses Facturacion.Comprobante;

type

  TFacturacionHelper = class
    class function ComoFechaISO8601(const aFecha: TDateTime): string;
    class function DesdeFechaISO8601(const aCadenaFecha: String): TDateTime;
    class function ComoMoneda(const aValor: Currency; const aNumeroDecimales:
        Integer = 2): string;
    class function ComoCantidad(const aValor: Double) : string;
    class procedure AgregarSchemaLocation(const aComprobante: IComprobanteFiscal; const aCadena: String);
    class function VerificarImporteEnRangoDeRedondeo(const aCantidad: Double; const
        aValorUnitario, aImporte: Currency): Boolean;
  end;

implementation

uses System.SysUtils,
     System.Math,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     Soap.XSBuiltIns;

{ TFacturacionHelper }

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
  Result := FormatFloat('0.####', aValor); //FloatToStrF(aValor, ffFixed, 20, 4);
end;

class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime):
    string;
begin
  Result := FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha);
end;

class function TFacturacionHelper.ComoMoneda(const aValor: Currency; const
    aNumeroDecimales: Integer = 2): string;
begin
  // NOTA: Esta moneda es para el XML, NO debe llevar simbolo de moneda
  Result := CurrToStrF(aValor, ffFixed, aNumeroDecimales);
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
  // Ref: http://www.fiscalia.com/publicaciones/10414
  // http://www.sat.gob.mx/informacion_fiscal/factura_electronica/Documents/cfdv33.pdf

  // Calculamos el limite inferior de acuerdo al Anexo 20
  limiteInferior := (aCantidad - IntPower(_BASE, _NUMERO_DECIMALES_MXN * -1)/2) *
                    (aValorUnitario - IntPower(_BASE,_NUMERO_DECIMALES_MXN * -1)/2);

  // Establecemos el tipo de redondeo a truncado a dos decimales para el limite inferior
  limiteInferior := Trunc(limiteInferior * 100) / 100;

  // Calculamos el limite superior de acuerdo al Anexo 20
  limiteSuperior := (aCantidad + IntPower(_BASE, -1 * _NUMERO_DECIMALES_MXN)/2 - IntPower(_BASE,-12)) *
                    (aValorUnitario + IntPower(_BASE,_NUMERO_DECIMALES_MXN * -1)/2 - IntPower(_BASE,-12));

  // Para el limite superior, redondeamos "hacia arriba"
  limiteSuperior := Ceil(limiteSuperior * 100) / 100;

  // ¿El importe calculado, esta dentro de rango validado por el SAT?
  Result := System.Math.InRange(aImporte, limiteInferior, limiteSuperior);
end;

end.
