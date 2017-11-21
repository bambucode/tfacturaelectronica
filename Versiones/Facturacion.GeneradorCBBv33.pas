unit Facturacion.GeneradorCBBv33;

interface

uses System.SysUtils,
     Facturacion.Comprobante,
     Facturacion.GeneradorCBB,
     {$IFDEF GENERACION_CBB_QURICOL}
     Facturacion.GeneradorQRQuricol,
     {$ELSE}
     Facturacion.GeneradorQR,
     {$ENDIF}
     Facturacion.ComprobanteV33;

type

  TGeneradorCBBv33 = class(TInterfacedObject, IGeneradorCBB)
  private
   {$IFDEF GENERACION_CBB_QURICOL}
   fGeneradorQR: TGeneradorQRQuricol;
   {$ELSE}
   fGeneradorQR: TGeneradorQR;
   {$ENDIF}
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
                               const aRutaAGuardar: TFileName);
  end;


implementation

{ TGeneradorCBBv33 }

procedure TGeneradorCBBv33.AfterConstruction;
begin
  inherited;

end;

destructor TGeneradorCBBv33.Destroy;
begin


  inherited;
end;

procedure TGeneradorCBBv33.GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
  const aRutaAGuardar: TFileName);
var
  cadenaParaCBB, uuid, selloParcial : string;
  totalComprobante : Currency;
  facturaV33 : IComprobanteFiscalV33;
  I: Integer;
const
  _FORMATO_CBB = 'https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx&id=%s&re=%s&rr=%s&tt=%s&fe=%s';
begin
  if Not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
    raise Exception.Create('Se intentó generar un CBB de CFDI 3.3 de un comprobante que no es de dicha versión');

  Assert(facturaV33.Complemento.TimbreFiscalDigital <> nil, 'Se mando un CFDI no timbrado');

  // Ocho últimos caracteres del sello digital del emisor del comprobante.
  selloParcial := Copy(aComprobante.Sello, Length(aComprobante.Sello) - 8,
                       8);

  uuid := facturaV33.Complemento.TimbreFiscalDigital.UUID;
  totalComprobante := StrToCurr(facturaV33.Total);

  cadenaParaCBB := Format(_FORMATO_CBB,
                          [uuid,
                           facturaV33.Emisor.RFC,
                           facturaV33.Receptor.RFC,
                           // Total del comprobante máximo a 25 posiciones (18 para los enteros, 1 para carácter “.”, 6 para los decimales),
                           // se deben omitir los ceros no significativos, precedido por el texto “&tt=”
                           FloatToStrF(totalComprobante, ffFixed, 17, 6),
                           selloParcial]);

  try
    {$IFDEF GENERACION_CBB_QURICOL}
    fGeneradorQR := TGeneradorQRQuricol.Create;
    {$ELSE}
    fGeneradorQR := TGeneradorQR.Create;
    {$ENDIF}
    fGeneradorQR.GenerarQRCode(cadenaParaCBB, aRutaAGuardar);
  finally
    fGeneradorQR.Free;
  end;
end;

end.
