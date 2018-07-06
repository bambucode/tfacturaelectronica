unit Facturacion.GeneradorCBBv32;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils,
{$ELSE}
     SysUtils,
{$IFEND}
     Facturacion.Comprobante,
     Facturacion.GeneradorCBB,
     Facturacion.ComprobanteV32,
     Facturacion.GeneradorQR;

type

  TGeneradorCBBv32 = class(TInterfacedObject, IGeneradorCBB)
  private
    fGeneradorQR: TGeneradorQR;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
                               const aRutaAGuardar: TFileName);
  end;


implementation

{ TGeneradorCBBv32 }

procedure TGeneradorCBBv32.AfterConstruction;
begin
  inherited;
  fGeneradorQR := TGeneradorQR.Create;
end;

destructor TGeneradorCBBv32.Destroy;
begin
  fGeneradorQR.Free;

  inherited;
end;

procedure TGeneradorCBBv32.GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
  const aRutaAGuardar: TFileName);
var
  cadenaParaCBB : string;
  totalComprobante : Currency;
  facturaV32 : IComprobanteFiscalV32;
const
  _FORMATO_CBB = '?re=%s&rr=%s&tt=%s&id=%s';
begin
  if Not Supports(aComprobante, IComprobanteFiscalV32, facturaV32) then
    raise Exception.Create('Se intent� generar un CBB de CFDI 3.2 de un comprobante que no es de dicha versi�n');

  Assert(facturaV32.Complemento.TimbreFiscalDigital <> nil, 'Se mando un CFDI no timbrado');

  totalComprobante := StrToCurr(facturaV32.Total);

  // 1. Definimos la cadena con la que vamos a generar el CBB segun la especificacion del SAT
  // segun el rubro II.E del Anexo 20
  cadenaParaCBB := Format(_FORMATO_CBB,
                          [facturaV32.Emisor.RFC,
                           facturaV32.Receptor.RFC,
                           FloatToStrF(totalComprobante, ffFixed, 17, 6),
                           facturaV32.Complemento.TimbreFiscalDigital.UUID]);

  fGeneradorQR.GenerarQRCode(cadenaParaCBB, aRutaAGuardar);
end;

end.
