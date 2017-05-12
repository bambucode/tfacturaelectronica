unit Facturacion.Helper;

interface

uses Facturacion.Comprobante;

type

  TFacturacionHelper = class
    class function ComoFechaISO8601(const aFecha: TDateTime): TCadenaUTF8;
  end;

implementation

uses System.SysUtils;

{ TFacturacionHelper }

// "Se expresa en la forma aaaa-mm-ddThh:mm:ss, de acuerdo con la especificación ISO 8601"
class function TFacturacionHelper.ComoFechaISO8601(const aFecha: TDateTime):
    TCadenaUTF8;
begin
  Result := FormatDateTime('yyyy-mm-dd', aFecha) + 'T' + FormatDateTime('hh:nn:ss', aFecha);
end;

end.
