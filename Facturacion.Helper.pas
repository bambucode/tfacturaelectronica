unit Facturacion.Helper;

interface

uses Facturacion.Comprobante;

type

  TFacturacionHelper = class
    class function ComoFechaISO8601(const aFecha: TDateTime): TCadenaUTF8;
    class function DesdeFechaISO8601(const aCadenaFecha: String): TDateTime;
    class function ComoMoneda(const aValor: Currency) : string;
    class function ComoCantidad(const aValor: Double) : string;
    class procedure AgregarSchemaLocation(const aComprobante: IComprobanteFiscal; const aCadena: String);
  end;

implementation

uses SysUtils,
     XSBuiltIns;

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
  Result := FloatToStr(aValor);
end;

class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime):
    TCadenaUTF8;
begin
  Result := FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha);
end;

class function TFacturacionHelper.ComoMoneda(const aValor: Currency): string;
begin
  // NOTA: Esta moneda es para el XML, NO debe llevar simbolo de moneda
  Result := CurrToStrF(aValor, ffFixed, 2);
end;

class function TFacturacionHelper.DesdeFechaISO8601(
  const aCadenaFecha: String): TDateTime;
begin
  with TXSDate.Create() do
  try
    XSToNative(aCadenaFecha); // convert from WideString
    Result := AsDate; // convert to TDateTime
  finally
    Free;
  end;
end;

end.
