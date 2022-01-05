unit Facturacion.GeneradorLigaVerificacion;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils,
{$ELSE}
     SysUtils,
{$IFEND}
     Facturacion.Comprobante,
     Facturacion.ComprobanteV33,
     Facturacion.ComprobanteV40;

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
  facturaV40 : IComprobanteFiscalV40;
  rfcEmisor, rfcReceptor: String;
const
  _FORMATO_CBB    = 'https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx?id=%s&re=%s&rr=%s&tt=%s&fe=%s';
  _LONGITUD_SELLO = 8;
begin
  if Not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
  begin
    if Not Supports(aComprobante, IComprobanteFiscalV40, facturaV40) then
      raise Exception.Create('Se intentó generar una liga de verificacion de CFDI 3.3/4.0 de un comprobante que no es de estas versiones');
  end;

  if Assigned(facturaV40) then
  begin
    uuid             := Lowercase(facturaV40.Complemento.TimbreFiscalDigital.UUID);
    totalComprobante := TFacturacionHelper.DesdeMoneda(facturaV40.Total);
    rfcEmisor := facturaV40.Emisor.RFC;
    rfcReceptor := facturaV40.Receptor.RFC;
  end else
  begin
    // Version 3.3
    Assert(facturaV33.Complemento.TimbreFiscalDigital <> nil, 'Se mando un CFDI no timbrado');
    uuid             := Lowercase(facturaV33.Complemento.TimbreFiscalDigital.UUID);
    totalComprobante := TFacturacionHelper.DesdeMoneda(facturaV33.Total);
    rfcEmisor := facturaV33.Emisor.RFC;
    rfcReceptor := facturaV33.Receptor.RFC;
  end;

  // Ocho últimos caracteres del sello digital del emisor del comprobante.
  selloParcial     := Copy(aComprobante.Sello, Length(aComprobante.Sello) - _LONGITUD_SELLO + 1,
                           _LONGITUD_SELLO);

  Result := Format(_FORMATO_CBB,
                  [uuid,
                   rfcEmisor,
                   rfcReceptor,
                   // Total del comprobante máximo a 25 posiciones (18 para los enteros, 1 para carácter “.”, 6 para los decimales),
                   // se deben omitir los ceros no significativos, precedido por el texto “&tt=”
                   FloatToStrF(totalComprobante, ffFixed, 17, 6, TFacturacionHelper.ObtenerConfiguracionRegionalLocal),
                   selloParcial]);
end;

end.
