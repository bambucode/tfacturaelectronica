{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}
unit Facturacion.Compatibilidad;

interface
type
  // Definimos el tipo de Cadena estandard que manejaremos en toda la libreia
  // con codificacion en UTF8
 {$IF Compilerversion >= 20}
  TCadenaUTF8 = RawByteString;
 {$ELSE}
  TCadenaUTF8 = UTF8String;
  RawByteString = UTF8String;
  UnicodeString = Widestring;
  TBytes = Array of Char;
  PAnsiChar = PChar;
  AnsiChar = Char;
  AnsiString = String;
 {$IFEND}

 {$IF CompilerVersion < 23}
  XmlDomString = WideString;
 {$IFEND}

implementation

end.
