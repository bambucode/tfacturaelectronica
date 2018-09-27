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
{.$define USAR_PNGIMAGE} //Para forzar el uso de PNGImage  (Delphi 7, 2007}

 {$IF CompilerVersion >= 20}
   {$IFNDEF USAR_PNGIMAGE}
    {$define USAR_PNGIMAGE}
   {$ENDIF}
 {$IFEND}

uses DelphiZXingQRCode,
{$IF CompilerVersion >= 23}
     Vcl.Imaging.pngimage,
     Vcl.Imaging.jpeg,
     System.Classes,
     Vcl.Graphics
{$ELSE}
     {$IFDEF USAR_PNGIMAGE}
       pngimage,
     {$ENDIF}
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
  imgResultado: TGraphic;
  Scale: Double;
begin
  // Checamos que los parámetros esten correctos
  Assert(aRutaAGuardar <> '', 'La ruta fue vacia');

  // 2. Generamos la imagen auxiliándonos de la liberia Quaricol
  if SameText( ExtractFileExt(aRutaAGuardar), '.bmp')   then
     imgResultado := TBitmap.Create
  else if SameText( ExtractFileExt(aRutaAGuardar), '.jpg') or
          SameText( ExtractFileExt(aRutaAGuardar), '.jpeg')   then
     imgResultado := TJPEGImage.Create
 {$IFDEF USAR_PNGIMAGE}
   else if SameText( ExtractFileExt(aRutaAGuardar), '.png')   then
     imgResultado := TPngImage.Create
 {$ENDIF}
   else if SameText( ExtractFileExt(aRutaAGuardar), '.wmf')   then
     imgResultado := TMetafile.Create
   else
     raise Exception.Create('No se pudo determinar la clase gráfica para el archivo: '+ExtractFileName(aRutaAGuardar));

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
    try
      // Le asignamos el bitmap y la guardamos
     imgResultado.Assign(bmpFinal);
     imgResultado.SaveToFile(aRutaAGuardar);
    finally
    end;
  finally
    QRCode.Free;
    bmpFinal.Free;
    imgResultado.Free;
  end;
end;

end.
