{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOrignalV33;

interface

uses  Facturacion.Comprobante,
      System.SysUtils,
      Facturacion.GeneradorCadenaOriginal;

type

  EXSLTNoEncontradoException = class(Exception);

  TGeneradorCadenaOriginalV33 = class(TInterfacedObject, IGeneradorCadenaOriginal)
  private
    function obtenerXSLTDeRecurso: TCadenaUTF8;
    function Transform(const aXMLData: string; aXSLT: string): TCadenaUTF8;
  public
    function obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
  end;

implementation

uses  System.IOUtils,
      System.Classes,
      Winapi.Windows,
      Xml.XMLIntf,
      Xml.XMLDom,
      Xml.XMLDoc;

const
  _NOMBRE_RECURSO = 'XSLT_CADENAORIGINAL_V33';

{ TGeneradorCadenaOriginalV33 }

function TGeneradorCadenaOriginalV33.obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
begin
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.3', 'La version del CFDI no fue 3.3');

  contenidoXMLComprobante := aComprobante.XML;
  contenidoXSLTCadenaOriginal := obtenerXSLTDeRecurso;
  // Obtenemos la Cadena originak del CFDI 3.3 usando el archivo XSLT proveido por el SAT
  Result := UTF8Encode('|' + Transform(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
end;


function TGeneradorCadenaOriginalV33.Transform(const aXMLData: string; aXSLT: string): TCadenaUTF8;
var
  xmlInput, xsltInput, xmlOutput: IXMLDocument;
  LOutput: XmlDomString;
begin
  xmlInput := LoadXMLData(aXMLData);
  xsltInput := LoadXMLData(aXSLT);
  xmlOutput := NewXMLDocument;
  xmlInput.DocumentElement.TransformNode(xsltInput.DocumentElement, LOutput);
  Result := TCadenaUTF8(LOutput);
end;

function TGeneradorCadenaOriginalV33.obtenerXSLTDeRecurso: TCadenaUTF8;
var
  Stream: TResourceStream;
  sl: TStringList;
begin
  try
    Stream := TResourceStream.Create(HInstance, _NOMBRE_RECURSO, RT_RCDATA);
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


end.
