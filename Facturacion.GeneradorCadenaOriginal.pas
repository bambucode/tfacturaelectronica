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
     System.SysUtils;

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
    function obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
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
    function obtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
  end;

  TTransformadorDeXML = class
  public
    function obtenerXSLTDeRecurso(const aNombreRecurso: string): TCadenaUTF8;
    function TransformarXML(const aXMLData: string; aXSLT: string): TCadenaUTF8;
  end;

implementation

uses  System.IOUtils,
      System.Classes,
      Winapi.Windows,
      System.Win.ComObj,
      Xml.XMLIntf,
      Xml.XMLDom,
      Xml.XMLDoc;

{ TTransformadorDeXML }

function TTransformadorDeXML.obtenerXSLTDeRecurso(const aNombreRecurso:
    string): TCadenaUTF8;
var
  Stream: TResourceStream;
  sl: TStringList;
begin
  try
    Stream := TResourceStream.Create(HInstance, aNombreRecurso, RT_RCDATA);
    try
      sl := TStringList.Create;
      try
        sl.LoadFromStream(Stream);
        Result := sl.Text;
      finally
        sl.Free;
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

function TTransformadorDeXML.TransformarXML(const aXMLData: string; aXSLT:
    string): TCadenaUTF8;
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
