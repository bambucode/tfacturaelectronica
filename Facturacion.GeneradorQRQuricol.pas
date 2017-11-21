unit Facturacion.GeneradorQRQuricol;

interface

uses System.SysUtils;

type

  TGeneradorQRQuricol = class
  public
    procedure GenerarQRCode(const aTexto: String;
                            const aRutaAGuardar: TFileName);
  end;

implementation

uses QuricolCode, QuricolAPI,
      {$IF Compilerversion >= 20}
       Vcl.Graphics, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;
      {$ELSE}
       Graphics, pngimage, Jpeg;
      {$IFEND}

const
  _ANCHO_QR_CODE = 1200;
  _ALTO_QR_CODE = 1200;

{ TGeneradorCBBGenerico }

procedure TGeneradorQRQuricol.GenerarQRCode(const aTexto: String; const
    aRutaAGuardar: TFileName);
var
  jpgResultado: TJpegImage;
  bmpCBB: TBitmap;
const
  _IMAGEN_MARGEN = 0;
  _TAMANO_PIXELES = 24;
  _ANCHO_ESTANDARD = 1200;
  _ALTO_ESTANDARD = 1200;
begin
  // Checamos que los parámetros esten correctos

  Assert(aRutaAGuardar <> '', 'La ruta fue vacia');

  // 2. Generamos la imagen auxiliandonos de la liberia Quaricol
  jpgResultado := TJPEGImage.Create;
  try
    bmpCBB := TQRCode.GetBitmapImage(aTexto,
                                    _ALTO_ESTANDARD, _ANCHO_ESTANDARD, _IMAGEN_MARGEN, _TAMANO_PIXELES, QualityHigh);
    try
      // La asignamos el JPG y la guardamos
      jpgResultado.Assign(bmpCBB);
      jpgResultado.SaveToFile(aRutaAGuardar);
    finally
      bmpCBB.Free;
    end;
  finally
    jpgResultado.Free;
  end;
end;

end.
