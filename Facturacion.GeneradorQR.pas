unit Facturacion.GeneradorQR;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
 ;
type

  TGeneradorQR = class
  public
    procedure GenerarQRCode(const aTexto: String;
                            const aRutaAGuardar: TFileName);
  end;

implementation

uses DelphiZXingQRCode,
{$IF CompilerVersion >= 23}
     Vcl.Imaging.pngimage,
     Vcl.Imaging.jpeg,
     System.Classes,
     Vcl.Graphics
{$ELSE}
     {$IF CompilerVersion >= 20}
      pngimage,
     {$IFEND}
     jpeg,
     Classes,
     Graphics
{$IFEND}
 ;

const
  _ANCHO_QR_CODE = 1200;
  _ALTO_QR_CODE = 1200;

{ TGeneradorCBBGenerico }

procedure TGeneradorQR.GenerarQRCode(const aTexto: String; const
    aRutaAGuardar: TFileName);
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
  QRCodeBitmap, bmpFinal: TBitmap;
  jpgResultado : TJPEGImage;
  Scale: Double;
begin
  QRCodeBitmap := TBitmap.Create;

  bmpFinal     := TBitmap.Create;
  bmpFinal.Width := _ANCHO_QR_CODE;
  bmpFinal.Height := _ALTO_QR_CODE;

  QRCode := TDelphiZXingQRCode.Create;

  try
    QRCode.Data         := aTexto;
    QRCode.Encoding     := qrAuto;
    // Margen del QR Code
    QRCode.QuietZone    := 1;
    {$IF CompilerVersion >= 20}
      QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    {$ELSE}
      QRCodeBitmap.Height := QRCode.Rows;
      QRCodeBitmap.Width := QRCode.Columns;
    {$IFEND}

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;

    // Re-dimensionamos el Bitmap del QR a las dimensiones finales de nuestro QR Code
    if (bmpFinal.Width < QRCodeBitmap.Height) then
      Scale := bmpFinal.Width / QRCodeBitmap.Width
    else
      Scale := bmpFinal.Height / QRCodeBitmap.Height;

    // Transferimos el QR redimensionado al BMP "final"
    bmpFinal.Canvas.StretchDraw(Rect(0, 0, Trunc(Scale * QRCodeBitmap.Width), Trunc(Scale * QRCodeBitmap.Height)), QRCodeBitmap);
  finally
    QRCode.Free;
  end;

  // 2. Generamos la imagen pero en formato JPG
  jpgResultado := TJPEGImage.Create;
  try
    try
      // La asignamos el JPG y la guardamos
      jpgResultado.Assign(bmpFinal);
      jpgResultado.SaveToFile(aRutaAGuardar);
    finally
      QRCodeBitmap.Free;
    end;
  finally
    jpgResultado.Free;
    bmpFinal.Free;
  end;
end;

end.
