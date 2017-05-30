unit Facturacion.Helper;

interface

uses Facturacion.Comprobante;

type

  TFacturacionHelper = class
    class function ComoFechaISO8601(const aFecha: TDateTime): TCadenaUTF8;
    class function ComoMoneda(const aValor: Currency) : string;
    class procedure AgregarSchemaLocation(const aComprobante: IComprobanteFiscal; const aCadena: String);
  end;

implementation

uses System.SysUtils;

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

class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime):
    TCadenaUTF8;
begin
  Result := FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha);
end;

class function TFacturacionHelper.ComoMoneda(const aValor: Currency): string;
begin
  Result := CurrToStrF(aValor, ffFixed, 2);
end;

end.
