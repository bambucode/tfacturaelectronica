unit Facturacion.GeneradorCBBv33;

interface

uses System.SysUtils,
     Facturacion.Comprobante,
     Facturacion.GeneradorCBB,
     {$IFDEF GENERACION_CBB_NATIVA}
     Facturacion.GeneradorQR,
     {$ELSE}
     Facturacion.GeneradorQRQuricol,
     {$ENDIF}
     Facturacion.GeneradorLigaVerificacion,
     Facturacion.ComprobanteV33;

type

  TGeneradorCBBv33 = class(TInterfacedObject, IGeneradorCBB)
  private
   {$IFDEF GENERACION_CBB_NATIVA}
   fGeneradorQR: TGeneradorQR;
   {$ELSE}
   fGeneradorQR: TGeneradorQRQuricol;
   {$ENDIF}
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
                               const aRutaAGuardar: TFileName);
  end;


implementation

uses Facturacion.Helper;

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
  cadenaParaCBB : string;
  generadorLigaVerificacion: IGeneradorLigaVerificacion;
  facturaV33 : IComprobanteFiscalV33;
begin
  if Not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
    raise Exception.Create('Se intent� generar un CBB de CFDI 3.3 de un comprobante que no es de dicha versi�n');

  // Obtenemos la liga de verificaci�n del SAT
  generadorLigaVerificacion := TGeneradorLigaVerificacion.Create;
  cadenaParaCBB             := generadorLigaVerificacion.ObtenerLigaVerificacion(aComprobante);

  try
    {$IFDEF GENERACION_CBB_NATIVA}
    fGeneradorQR := TGeneradorQR.Create;
    {$ELSE}
    fGeneradorQR := TGeneradorQRQuricol.Create;
    {$ENDIF}
    fGeneradorQR.GenerarQRCode(cadenaParaCBB, aRutaAGuardar);
  finally
    fGeneradorQR.Free;
  end;
end;

end.
