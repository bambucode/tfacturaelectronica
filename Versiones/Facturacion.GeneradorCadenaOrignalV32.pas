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
      SysUtils,
      Facturacion.GeneradorCadenaOriginal;

type

  TGeneradorCadenaOriginalV32 = class(TInterfacedObject, IGeneradorCadenaOriginal)
  public
    function obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
    function obtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
  end;

implementation

uses  IOUtils,
      Classes,
      Windows,
      XMLIntf,
      XMLDom,
      Facturacion.ComprobanteV32,
      XMLDoc;

const
  _NOMBRE_RECURSO_CADENA_ORIGINAL     = 'XSLT_CADENAORIGINAL_V32';
  _NOMBRE_RECURSO_CADENA_ORIGINAL_TFD = 'XSLT_CADENAORIGINALTFD_V32';

{ TGeneradorCadenaOriginalV32 }

function TGeneradorCadenaOriginalV32.obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador : TTransformadorDeXML;
begin
  // Verificamos que la versi�n del comprobante sea 3.3 pues solo ser� una cadena original v�lida para dicha versi�n
  Assert(aComprobante.Version = '3.2', 'La version del CFDI no fue 3.2');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := aComprobante.XML;
    contenidoXSLTCadenaOriginal := transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL);
    // Obtenemos la Cadena originak del CFDI 3.2 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' + transformador.TransformarXML(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;


function TGeneradorCadenaOriginalV32.obtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador : TTransformadorDeXML;
  facturaV32: IComprobanteFiscalV32;
begin
  // Verificamos que la versi�n del comprobante sea 3.3 pues solo ser� una cadena original v�lida para dicha versi�n
  Assert(aComprobante.Version = '3.2', 'La version del CFDI no fue 3.2');

  if Not Supports(aComprobante, IComprobanteFiscalV32, facturaV32) then
    raise Exception.Create('El comprobante no es v3.2');

  if facturaV32.Complemento.TimbreFiscalDigital = nil then
     raise Exception.Create('El comprobante no esta timbrado, imposible generar cadena original del timbre.');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := facturaV32.Complemento.TimbreFiscalDigital.XML;
    contenidoXSLTCadenaOriginal := transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL_TFD);
    // Obtenemos la Cadena originak del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' + transformador.TransformarXML(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;

end.

