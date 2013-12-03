//===============================================================================
// Copyright (c) Serhiy Perevoznyk.  All rights reserved.
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
// OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE.
//
// Ref: http://delphi32.blogspot.mx/2013/09/quricol-20-qr-code-generator.html
//
//===============================================================================

unit QuricolCode;

interface

uses
  Windows, SysUtils, Classes, QuricolAPI,
  {$IF Compilerversion >= 20}
   Vcl.Graphics;
  {$ELSE}
   Graphics;
  {$IFEND}



type

{ Summary
  QR Code generator
  Example
  <code lang="delphi">
  var
    bmp : TBitmap;
    MS : TMemoryStream;
  begin
    try
      //Generate Windows bitmap and save to file
      TQRCode.GenerateBitmapFile('delphi1.bmp', 'http://delphi32.blogspot.com', QualityLow);

      //Generate PNG image and save to file
      TQRCode.GeneratePngFile('delphi1.png', 'http://delphi32.blogspot.com');

      //Generate TBitmap
      bmp := TQRCode.GetBitmapImage('http://www.krento.net');
      bmp.SaveToFile('delphi2.bmp');

      //Generate PNG to the memory stream
      MS := TMemoryStream.Create;
      TQRCode.GetPngStream(MS, 'http://www.krento.net');
      MS.Position := 0;
      MS.SaveToFile('delphi2.png');
      MS.Free;

    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  </code>                                                                        }

  TQRCode = class
  private
    class function  GetBgColor : TColor; static;
    class procedure SetBgColor(Value : TColor); static;
    class function  GetFgColor : TColor; static;
    class procedure SetFgColor(Value : TColor); static;
  public
    { \ \ 
      Summary
      Specifies the background color of the image
      
      
      Description
      Use BackgroundColor property to get or set the value of the
      generated image background color                            }
    class property BackgroundColor : TColor read GetBgColor write SetBgColor;
    { \ \ 
      Summary
      Specifies the foreground color of the image
      
      
      Description
      Use ForegroundColor property to get or set the value of the
      generated image foreground color                            }
    class property ForegroundColor : TColor read GetFgColor write SetFgColor;
    { Summary
      Generates Windows Bitmap file with the text encoded as QR
      code
      Parameters
      FileName :   The name of the bitmap file<p />
      Text :       The text to encode<p />
      Margin :     The margin from the border<p />
      PixelSize :  The size of the one image point.
      Level :      The error correction level }
    class procedure GenerateBitmapFile(const FileName : string; const Text : string; Margin : integer = 4; PixelSize : integer = 3; Level : TErrorCorretion = QualityLow);
    { Summary
      Generates PNG file with the text encoded as QR code
      Parameters
      FileName :   The name of the png file<p />
      Text :       The text to encode<p />
      Margin :     The margin from the border<p />
      PixelSize :  The size of the one image point.
      Level :      The error correction level }
    class procedure GeneratePngFile(const FileName : string; const Text : string; Margin : integer = 4; PixelSize : integer = 3; Level : TErrorCorretion = QualityLow);
    { Summary
      Created Windows Bitmap image with the text encoded as QR code
      Parameters
      Text - The text to encode

      Margin - The margin from the image border

      PixelSize - The size of the one point of the image
      Level :      The error correction level }
    class function GetBitmapImage(const Text : string; Margin : integer = 4; PixelSize : integer = 3; Level : TErrorCorretion = QualityLow) : TBitmap; overload;


    class function GetBitmapImage(const Text: string; Height: Integer = 300; Width:
        Integer = 300; Margin : integer = 1; PixelSize : integer = 1; Level :
        TErrorCorretion = QualityLow): TBitmap; overload;
    { Summary
      Writes PNG image to the stream. Can be useful for web
      development
      Parameters
      Stream - The stream where image will be stored

      Text - The text to encode

      Margin - The margin from the image border

      PixelSize - The size of the one image point
      Level :      The error correction level }
    class procedure GetPngStream(Stream : TStream; const Text : string; Margin : integer = 4; PixelSize : integer = 3; Level : TErrorCorretion = QualityLow);

  end;

implementation


{ TQRCode }

class procedure TQRCode.GenerateBitmapFile(const FileName, Text: string; Margin,
  PixelSize: integer; Level : TErrorCorretion);
begin
  GenerateBMP(PChar(FileName), PChar(Text), Margin, PixelSize, ord(Level));
end;

class procedure TQRCode.GeneratePngFile(const FileName, Text: string; Margin,
  PixelSize: integer; Level : TErrorCorretion);
begin
  GeneratePNG(PChar(FileName), PChar(Text), Margin, PixelSize, ord(Level));
end;

class function TQRCode.GetBgColor: TColor;
begin
  Result := GetBackgroundColor;
end;

class function TQRCode.GetBitmapImage(const Text: string; Height, Width,
    Margin, PixelSize: integer; Level : TErrorCorretion): TBitmap;
var
  Bmp : HBITMAP;
  DIB: TDIBSection;
  ScreenDC : THandle;
  DC : THandle;
begin
  Bmp := GetHBitmap(PChar(Text), Margin, PixelSize, ord(Level));
  GetObject(Bmp, SizeOf(DIB), @DIB);
  Result := TBitmap.Create();

  if (Width > 0) then
    Result.Width := Width
  else
    Result.Width := DIB.dsBmih.biWidth;

  if (Height > 0) then
    Result.Height := Height
  else
    Result.Height := DIB.dsBmih.biHeight;

  Result.PixelFormat := pf32bit;
  ScreenDC := GetDC(0);
  DC := CreateCompatibleDC(ScreenDC);
  SelectObject(DC, Bmp);
  ReleaseDC(0, ScreenDC);
  BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, 0, 0, SRCCOPY);
  DeleteDC(DC);
  DeleteObject(Bmp);
end;

class function TQRCode.GetBitmapImage(const Text: string; Margin,
  PixelSize: integer; Level : TErrorCorretion): TBitmap;
var
  Bmp : HBITMAP;
  DIB: TDIBSection;
  ScreenDC : THandle;
  DC : THandle;
begin
  Bmp := GetHBitmap(PChar(Text), Margin, PixelSize, ord(Level));
  GetObject(Bmp, SizeOf(DIB), @DIB);
  Result := TBitmap.Create();
  Result.Width := DIB.dsBmih.biWidth;
  Result.Height := DIB.dsBmih.biHeight;
  Result.PixelFormat := pf32bit;
  ScreenDC := GetDC(0);
  DC := CreateCompatibleDC(ScreenDC);
  SelectObject(DC, Bmp);
  ReleaseDC(0, ScreenDC);
  BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, 0, 0, SRCCOPY);
  DeleteDC(DC);
  DeleteObject(Bmp);
end;

class function TQRCode.GetFgColor: TColor;
begin
   Result := GetForegroundColor;
end;

class procedure TQRCode.GetPngStream(Stream: TStream; const Text: string; Margin,
  PixelSize: integer; Level : TErrorCorretion);
var
  size : integer;
  i : integer;
  buffer : PByte;
  ps : PByte;
begin
  size := 0;
  GetPNG(PChar(Text), Margin, PixelSize, ord(Level), size, buffer);
  if (size > 0) then
   begin
     ps := buffer;
     for I := 0 to size - 1 do
       begin
         Stream.Write(ps^, 1);
         inc(ps);
       end;
      DestroyBuffer(buffer);
   end;
end;

class procedure TQRCode.SetBgColor(Value: TColor);
begin
  SetBackgroundColor(ColorToRGB(Value));
end;

class procedure TQRCode.SetFgColor(Value: TColor);
begin
  SetForegroundColor(ColorToRGB(Value));
end;


end.
