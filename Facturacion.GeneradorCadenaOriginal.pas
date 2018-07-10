{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOriginal;

interface

uses Facturacion.Comprobante,
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
      Facturacion.Tipos,
      SysUtils
{$IFEND};

type

  EXSLTNoEncontradoException = class(Exception);
  EProblemaConXSLTException = class(Exception);

  /// <summary>
  ///   Instancia base para cualquier generador de cadena original,
  ///   independiente de la versión del CFDI.
  /// </summary>
  IGeneradorCadenaOriginal = interface
    ['{EF2FF468-FD4A-45C2-8EF0-C7BC25464796}']
    /// <summary>
    ///   Se encarga de procesar el comprobante y regresar la cadena Original
    /// </summary>
    /// <param name="aComprobante">
    ///   Instancia del comprobante
    /// </param>
    /// <returns>
    ///   Cadena Original en formato UTF8
    /// </returns>
    function ObtenerCadenaOriginal(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
     /// <summary>
    ///   Se encarga de procesar el comprobante previamente timbrado y regresar la
    ///   cadena Original del Timbre Fiscal Digital
    /// </summary>
    /// <param name="aComprobante">
    ///   Instancia del comprobante timbrado
    /// </param>
    /// <returns>
    ///   Cadena Original de TFD en formato UTF8
    /// </returns>
    function ObtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
  end;

  TTransformadorDeXML = class
  protected
  {$IF Compilerversion < 20}
   fBOM_UTF8 : Array of Byte; //($EF, $BB, $BF);
   fBOM_Unicode: Array of Byte; // ($FF, $FE);
   fBOM_UTF16BE: Array of Byte; // ($FE, $FF);
  {$IFEND}
  public
    procedure AfterConstruction; override;
    function ObtenerXSLTDeRecurso(const aNombreRecurso: string): TCadenaUTF8;
    function TransformarXML(const aXMLData: UnicodeString; aXSLT: UnicodeString): TCadenaUTF8;
  end;

implementation

uses
{$IF CompilerVersion >= 23}
      System.IOUtils,
      System.Classes,
      Winapi.Windows,
      System.Win.ComObj,
      Xml.XMLIntf,
      Xml.XMLDom,
      Xml.XMLDoc
{$ELSE}
    {$IF CompilerVersion >= 20}
      IOUtils,
    {$IFEND}
      WideStrUtils,
      Classes,
      Windows,
      ComObj,
      XMLIntf,
      XMLDom,
      XMLDoc
{$IFEND};


{ TTransformadorDeXML }

procedure TTransformadorDeXML.AfterConstruction;
begin
  inherited;
 {$IF Compilerversion < 20}
  SetLength( fBOM_UTF8, 3 );
  fBOM_UTF8[0] :=  $EF;
  fBOM_UTF8[1] :=  $BB;
  fBOM_UTF8[2] :=  $BF;

  SetLength( fBOM_Unicode, 2 );
  fBOM_Unicode[0] :=  $FF;
  fBOM_Unicode[1] :=  $FE;

  SetLength( fBOM_UTF16BE, 2 );
  fBOM_UTF16BE[0] :=  $FE;
  fBOM_UTF16BE[1] :=  $FF;
 {$IFEND}
end;

function TTransformadorDeXML.ObtenerXSLTDeRecurso(const aNombreRecurso:
    string): TCadenaUTF8;
var
  Stream: TResourceStream;
{$IF Compilerversion >= 20}
  sl : TStrings;   //A partir de Delphi 2009 (Unicode) La clase TStrings Reconoce el BOM automáticamente
{$ELSE}
  LBuffer: Array of Byte;
  LStart, LCount: Integer;

 function ContieneBOM(const Buffer, Signature: Array of Byte; var Start: Integer; var Count: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if Length(Buffer) >= Length(Signature) then
    begin
      for I := 1 to Length(Signature) do
        if Buffer[I - 1] <> Signature [I - 1] then
        begin
          Result := False;
          Break;
        end;
    end
    else
      Result := False;
    if Result then
    begin
     Start := Length(Signature);
     Count := Length(Buffer)-Length(signature);
    end
    else
    begin
     Start := 0;
     Count := Length(Buffer);
    end;
  end;
 {$IFEND}
begin
  Result := '';
  try
    Stream := TResourceStream.Create(HInstance, aNombreRecurso, RT_RCDATA);
    try
      {$IF Compilerversion >= 20}
       sl := TStringList.Create;
      {$IFEND}
      try
       {$IF Compilerversion >= 20}
        sl.LoadFromStream(Stream);
        Result := sl.Text;
       {$ELSE}
        if Stream.Size > 0 then
        begin
         SetLength(LBuffer, Stream.Size);

         Stream.ReadBuffer(LBuffer[0], Stream.size);
         If not ( ContieneBOM(LBuffer, fBOM_UTF8, LStart, LCount ) or
                  ContieneBOM(LBuffer, fBOM_Unicode, LStart, LCount ) or
                  ContieneBOM(LBuffer, fBOM_UTF16BE, LStart, LCount ) ) then
         begin
          LStart := 0;
          LCount := Stream.Size;
         end;
         SetLength(Result, LCount);
         Move(LBuffer[LStart], Result[1], LCount);
        end;
       {$IFEND}
        if not IsUTF8String(Result) then
           Result := UTF8Encode(Result);
      finally
       {$IF Compilerversion >= 20}
        sl.Free
       {$IFEND}
      end;
    finally
      Stream.Free;
    end;
  except
    On E: EResNotFound do
      raise EXSLTNoEncontradoException.Create('El XSLT no fue encontrado en tu aplicación, favor de consultar: ' +
                                              'https://github.com/bambucode/tfacturaelectronica/wiki/Incluir-XSLT-de-Cadena-Original');
  end;

end;

function TTransformadorDeXML.TransformarXML(const aXMLData: UnicodeString; aXSLT:
    UnicodeString): TCadenaUTF8;
var
  xmlInput, xsltInput, xmlOutput: IXMLDocument;
  LOutput: XmlDomString;
begin
  try
    xmlInput := LoadXMLData(aXMLData);
    xsltInput := LoadXMLData(aXSLT);
    xmlOutput := NewXMLDocument;
    xmlInput.DocumentElement.TransformNode(xsltInput.DocumentElement, LOutput);
    Result := TCadenaUTF8(LOutput);
  except
    on E:EOleException do
    begin
      raise EProblemaConXSLTException.Create('No se pudo transformar con XSLT proporcionado: '+ E.Message);
    end;
  end;
end;


end.
