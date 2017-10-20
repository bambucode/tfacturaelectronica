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
{$IF Compilerversion >= 22.0}
      System.SysUtils,
{$ELSE}
      SysUtils,
{$IFEND}
      Facturacion.GeneradorCadenaOriginal;

type

  TGeneradorCadenaOriginalV33 = class(TInterfacedObject, IGeneradorCadenaOriginal)
  public
    function obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
    function obtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal) : TCadenaUTF8;
  end;

implementation

uses  System.IOUtils,
      Facturacion.ComprobanteV33;

const
  _NOMBRE_RECURSO_CADENA_ORIGINAL     = 'XSLT_CADENAORIGINAL_V33';
  _NOMBRE_RECURSO_CADENA_ORIGINAL_TFD = 'XSLT_CADENAORIGINALTFD_V33';

{ TGeneradorCadenaOriginalV33 }

function TGeneradorCadenaOriginalV33.obtenerCadenaOriginal(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador : TTransformadorDeXML;
begin
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.3', 'La version del CFDI no fue 3.3');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := aComprobante.XML;
    contenidoXSLTCadenaOriginal := transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL);
    // Obtenemos la Cadena originak del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' + transformador.TransformarXML(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;

function TGeneradorCadenaOriginalV33.obtenerCadenaOriginalDeTimbre(const aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador : TTransformadorDeXML;
  facturaV33: IComprobanteFiscalV33;
begin
  Assert(aComprobante <> nil, 'La instancia aComprobante no debio ser nula');
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.3', 'La version del CFDI no fue 3.3');

  if Not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
    raise Exception.Create('El comprobante no es v3.3');

  if facturaV33.Complemento.TimbreFiscalDigital = nil then
     raise Exception.Create('El comprobante no esta timbrado, imposible generar cadena original del timbre.');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := facturaV33.Complemento.TimbreFiscalDigital.XML;
    contenidoXSLTCadenaOriginal := transformador.obtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL_TFD);
    // Obtenemos la Cadena originak del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' + transformador.TransformarXML(contenidoXMLComprobante, contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;

end.

