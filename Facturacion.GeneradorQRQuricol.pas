unit Facturacion.GeneradorQRQuricol;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
 ;

 {.$define USAR_PNGIMAGE} //Para forzar el uso de PNGImage  (Delphi 7, 2007}

 {$IF CompilerVersion >= 20}
   {$IFNDEF USAR_PNGIMAGE}
    {$define USAR_PNGIMAGE}
   {$ENDIF}
 {$IFEND}

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
       Graphics, {$IFDEF USAR_PNGIMAGE} pngimage, {$ENDIF} Jpeg;
      {$IFEND}

{ TGeneradorCBBGenerico }

procedure TGeneradorQRQuricol.GenerarQRCode(const aTexto: String; const
    aRutaAGuardar: TFileName);
var
  imgResultado: TGraphic;
  bmpCBB: TBitmap;
const
  _IMAGEN_MARGEN = 4;
  _TAMANO_PIXELES = 24;
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
      // Le asignamos el bitmap y la guardamos
      imgResultado.Assign(bmpCBB);
      imgResultado.SaveToFile(aRutaAGuardar);
    finally
      bmpCBB.Free;
    end;
  finally
    imgResultado.Free;
  end;
end;

end.
