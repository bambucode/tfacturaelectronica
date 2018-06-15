unit Facturacion.GeneradorLigaVerificacion;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils,
{$ELSE}
     SysUtils,
{$IFEND}
     Facturacion.Comprobante,
     Facturacion.ComprobanteV33;

type

  IGeneradorLigaVerificacion = Interface
    ['{C0642BB5-0239-410F-8631-80366EA96173}']
    function ObtenerLigaVerificacion(const aComprobante: IComprobanteFiscal) : String;
  End;


  TGeneradorLigaVerificacion = class(TInterfacedObject, IGeneradorLigaVerificacion)
  public
    function ObtenerLigaVerificacion(const aComprobante: IComprobanteFiscal) : String;
  end;


implementation

uses Facturacion.Helper;

{ TGeneradorLigaVerificacion }

function TGeneradorLigaVerificacion.ObtenerLigaVerificacion(const aComprobante: IComprobanteFiscal) : String;
var
  uuid, selloParcial : string;
  totalComprobante : Currency;
  facturaV33 : IComprobanteFiscalV33;
const
  _FORMATO_CBB    = 'https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx?id=%s&re=%s&rr=%s&tt=%s&fe=%s';
  _LONGITUD_SELLO = 8;
begin
  if Not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
    raise Exception.Create('Se intentó generar una liga de verificacion de CFDI 3.3 de un comprobante que no es de dicha versión');

  Assert(facturaV33.Complemento.TimbreFiscalDigital <> nil, 'Se mando un CFDI no timbrado');

  // Ocho últimos caracteres del sello digital del emisor del comprobante.
  selloParcial     := Copy(aComprobante.Sello, Length(aComprobante.Sello) - _LONGITUD_SELLO + 1,
                           _LONGITUD_SELLO);
  uuid             := Lowercase(facturaV33.Complemento.TimbreFiscalDigital.UUID);
  totalComprobante := TFacturacionHelper.DesdeMoneda(facturaV33.Total);

  Result := Format(_FORMATO_CBB,
                  [uuid,
                   facturaV33.Emisor.RFC,
                   facturaV33.Receptor.RFC,
                   // Total del comprobante máximo a 25 posiciones (18 para los enteros, 1 para carácter “.”, 6 para los decimales),
                   // se deben omitir los ceros no significativos, precedido por el texto “&tt=”
                   FloatToStrF(totalComprobante, ffFixed, 17, 6, Facturacion.Helper.formatSettingsLocal),
                   selloParcial]);
end;

end.
