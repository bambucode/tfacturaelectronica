{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOrignalV32;

interface

uses  Facturacion.Comprobante,
      System.SysUtils,
      Facturacion.GeneradorCadenaOriginal;

type

  TGeneradorCadenaOriginalV32 = class(TInterfacedObject, IGeneradorCadenaOriginal)
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
  _NOMBRE_RECURSO = 'XSLT_CADENAORIGINAL_V32';

{ TGeneradorCadenaOriginalV32 }

function TGeneradorCadenaOriginalV32.obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador : TTransformadorDeXML;
begin
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.2', 'La version del CFDI no fue 3.2');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := aComprobante.XML;
    contenidoXSLTCadenaOriginal := transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO);
    // Obtenemos la Cadena originak del CFDI 3.2 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' + transformador.TransformarXML(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;


end.

