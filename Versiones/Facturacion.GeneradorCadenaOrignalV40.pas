{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOrignalV40;

interface

uses Facturacion.Comprobante,
  Facturacion.GeneradorCadenaOriginal,
{$IF CompilerVersion >= 23}
  System.SysUtils
{$ELSE}
  SysUtils
{$IFEND};

type

  TGeneradorCadenaOriginalV40 = class(TInterfacedObject,
    IGeneradorCadenaOriginal)
  public
    function ObtenerCadenaOriginal(const aComprobante: IComprobanteFiscal):
      TCadenaUTF8;
    function ObtenerCadenaOriginalDeTimbre(const aComprobante:
      IComprobanteFiscal): TCadenaUTF8;
  end;

implementation

uses
{$IF CompilerVersion >= 23}
  System.IOUtils,
{$ELSE}
  {$IF CompilerVersion >= 20}
      IOUtils,
  {$IFEND}
{$IFEND}
  XMLIntf,
  Facturacion.ComprobanteV40;

const
  _NOMBRE_RECURSO_CADENA_ORIGINAL = 'XSLT_CADENAORIGINAL_V40';
  _NOMBRE_RECURSO_CADENA_ORIGINAL_TFD = 'XSLT_CADENAORIGINALTFD_V11';

  { TGeneradorCadenaOriginalV40 }

function TGeneradorCadenaOriginalV40.ObtenerCadenaOriginal(const aComprobante:
  IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador: TTransformadorDeXML;
begin
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '4.0', 'La version del CFDI no fue 4.0');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := aComprobante.XML;
    contenidoXSLTCadenaOriginal :=
      transformador.ObtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL);

    // Obtenemos la Cadena original del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' +
      transformador.TransformarXML(contenidoXMLComprobante,
      contenidoXSLTCadenaOriginal) + '||');

    Assert(Result <> '|||', 'La cadena original no se genero correctamente, favor de verificar XSLT');
  finally
    FreeAndNil(transformador);
  end;
end;

function TGeneradorCadenaOriginalV40.ObtenerCadenaOriginalDeTimbre(const
  aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador: TTransformadorDeXML;
  facturaV40: IComprobanteFiscalV40;
begin
  Assert(aComprobante <> nil, 'La instancia aComprobante no debio ser nula');
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '4.0', 'La version del CFDI no fue 4.0');

  if not Supports(aComprobante, IComprobanteFiscalV40, facturaV40) then
    raise Exception.Create('El comprobante no es v4.0');

  if facturaV40.Complemento.TimbreFiscalDigital = nil then
    raise
      Exception.Create('El comprobante no esta timbrado, imposible generar cadena original del timbre.');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := facturaV40.Complemento.TimbreFiscalDigital.XML;
    contenidoXSLTCadenaOriginal :=
      transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL_TFD);
    // Obtenemos la Cadena original del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' +
      transformador.TransformarXML(contenidoXMLComprobante,
      contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;

end.

