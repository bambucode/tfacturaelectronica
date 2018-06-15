unit Facturacion.GeneradorQRQuricol;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
 ;
type

  TGeneradorQRQuricol = class
  public
    procedure GenerarQRCode(const aTexto: String;
                            const aRutaAGuardar: TFileName);
  end;

implementation

uses QuricolCode, QuricolAPI,
      {$IF Compilerversion >= 23}
       Vcl.Graphics, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;
      {$ELSE}
       Graphics, {$IF Compilerversion >= 20} pngimage, {$IFEND} Jpeg;
      {$IFEND}

{ TGeneradorCBBGenerico }

procedure TGeneradorQRQuricol.GenerarQRCode(const aTexto: String; const
    aRutaAGuardar: TFileName);
var
  jpgResultado: TJpegImage;
  bmpCBB: TBitmap;
const
  _IMAGEN_MARGEN = 4;
  _TAMANO_PIXELES = 24;
begin
  // Checamos que los par�metros esten correctos
  Assert(aRutaAGuardar <> '', 'La ruta fue vacia');

  // 2. Generamos la imagen auxiliandonos de la liberia Quaricol
  jpgResultado := TJPEGImage.Create;
  try
    {$IF Compilerversion >= 20}
     bmpCBB := TQRCode.GetBitmapImage(aTexto, _IMAGEN_MARGEN, _TAMANO_PIXELES, QualityHigh);
    {$ELSE}
     with TQRCode.Create do
     begin
      try
       bmpCBB := GetBitmapImage(aTexto, _IMAGEN_MARGEN, _TAMANO_PIXELES, QualityHigh);
      finally
       Free;
      end;
     end;
    {$IFEND}

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
