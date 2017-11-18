//===============================================================================
// Copyright (c) Serhiy Perevoznyk.  All rights reserved.
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
// OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE.
//
// Ref: http://delphi32.blogspot.mx/2013/09/quricol-20-qr-code-generator.html
//===============================================================================

{$I Quricol.inc}

unit QuricolAPI;

interface

uses
  WIndows, SysUtils, Classes;

type
  { Summary
    The error correction level
  }
  TErrorCorretion = (QualityLow, QualityMedium, QualityStandard, QualityHigh);

procedure GeneratePNG(FileName : PChar;  Text : PChar;  Margin : integer; Size : integer; Level : integer); stdcall;
procedure GeneratePNGW(FileName: PWideChar; Text : PWideChar; Margin : integer; Size : integer; Level : integer); stdcall;
procedure GeneratePNGA(FileName: PAnsiChar; Text : PAnsiChar; Margin : integer; Size : integer; Level : integer); stdcall;

function GetHBitmap(Text : PChar;  Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall;
function GetHBitmapW(Text: PWideChar; Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall;
function GetHBitmapA(Text: PAnsiChar; Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall;

procedure GenerateBMP(FileName : PChar;  Text : PChar; Margin : integer; Size : integer; Level : integer); stdcall;
procedure GenerateBMPW(FileName: PWideChar; Text : PWideChar; Margin : integer; Size : integer; Level : integer); stdcall;
procedure GenerateBMPA(FileName: PAnsiChar; Text : PAnsiChar; Margin : integer; Size : integer; Level : integer); stdcall;

procedure GetPNG(Text : PChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall;
procedure GetPNGW(Text: PWideChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall;
procedure GetPNGA(Text: PAnsiChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall;

procedure DestroyBuffer(Buffer : PByte); stdcall;
function  GetBackgroundColor : COLORREF; stdcall;
function  GetForegroundColor : COLORREF; stdcall;
procedure SetBackgroundColor(Value : COLORREF); stdcall;
procedure SetForegroundColor(Value : COLORREF); stdcall;

implementation

const
{$IFDEF CPUX64}
  QuricolLib = 'quricol64.dll';
{$ELSE}
  QuricolLib = 'quricol32.dll'; // ExtractFilePath(Application.ExeName) + 'quricol32.dll';
{$ENDIF}


{$IFDEF UNICODE}
procedure GeneratePNG(FileName : PChar;  Text : PChar;  Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib name 'GeneratePNGW' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ELSE}
procedure GeneratePNG(FileName : PChar;  Text : PChar;  Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib name 'GeneratePNGA' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ENDIF}

procedure GeneratePNGW(FileName: PWideChar; Text : PWideChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
procedure GeneratePNGA(FileName: PAnsiChar; Text : PAnsiChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};

{$IFDEF UNICODE}
function GetHBitmap(Text : PChar;  Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall; external QuricolLib name 'GetHBitmapW' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ELSE}
function GetHBitmap(Text : PChar;  Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall; external QuricolLib name 'GetHBitmapA' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ENDIF}

function GetHBitmapW(Text: PWideChar; Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
function GetHBitmapA(Text: PAnsiChar; Margin : integer; Size : integer; Level : integer) : HBITMAP; stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};

{$IFDEF UNICODE}
procedure GenerateBMP(FileName : PChar;  Text : PChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib name 'GenerateBMPW' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ELSE}
procedure GenerateBMP(FileName : PChar;  Text : PChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib name 'GenerateBMPA' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ENDIF}

procedure GenerateBMPW(FileName: PWideChar; Text : PWideChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
procedure GenerateBMPA(FileName: PAnsiChar; Text : PAnsiChar; Margin : integer; Size : integer; Level : integer); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};

{$IFDEF UNICODE}
procedure GetPNG(Text : PChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall; external QuricolLib name 'GetPNGW' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ELSE}
procedure GetPNG(Text : PChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall; external QuricolLib name 'GetPNGA' {$IFDEF DELPHI2010}delayed{$ENDIF};
{$ENDIF}
procedure GetPNGW(Text : PWideChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
procedure GetPNGA(Text : PAnsiChar; Margin : integer; Size : integer; Level : integer; var BufSize : integer; out ppvBits : PByte); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};

procedure DestroyBuffer(Buffer : PByte); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
function  GetBackgroundColor : COLORREF; stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
function  GetForegroundColor : COLORREF; stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
procedure SetBackgroundColor(Value : COLORREF); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};
procedure SetForegroundColor(Value : COLORREF); stdcall; external QuricolLib {$IFDEF DELPHI2010}delayed{$ENDIF};


end.
