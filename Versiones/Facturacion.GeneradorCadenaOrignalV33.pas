{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOrignalV33;

interface

uses Facturacion.Comprobante,
  Facturacion.GeneradorCadenaOriginal,
{$IF CompilerVersion >= 23}
  System.SysUtils
{$ELSE}
  SysUtils
{$IFEND};

type

  TGeneradorCadenaOriginalV33 = class(TInterfacedObject,
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
  Facturacion.ComprobanteV33;

const
  _NOMBRE_RECURSO_CADENA_ORIGINAL = 'XSLT_CADENAORIGINAL_V33';
  _NOMBRE_RECURSO_CADENA_ORIGINAL_TFD = 'XSLT_CADENAORIGINALTFD_V33';

  { TGeneradorCadenaOriginalV33 }

function TGeneradorCadenaOriginalV33.ObtenerCadenaOriginal(const aComprobante:
  IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador: TTransformadorDeXML;
begin
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.3', 'La version del CFDI no fue 3.3');

  transformador := TTransformadorDeXML.Create;
  try
    contenidoXMLComprobante := aComprobante.XML;
    contenidoXSLTCadenaOriginal :=
      transformador.ObtenerXSLTDeRecurso(_NOMBRE_RECURSO_CADENA_ORIGINAL);
    // Obtenemos la Cadena originak del CFDI 3.3 usando el archivo XSLT proveido por el SAT
    Result := UTF8Encode('|' +
      transformador.TransformarXML(contenidoXMLComprobante,
      contenidoXSLTCadenaOriginal) + '||');
  finally
    FreeAndNil(transformador);
  end;
end;

function TGeneradorCadenaOriginalV33.ObtenerCadenaOriginalDeTimbre(const
  aComprobante: IComprobanteFiscal): TCadenaUTF8;
var
  contenidoXMLComprobante: TCadenaUTF8;
  contenidoXSLTCadenaOriginal: TCadenaUTF8;
  transformador: TTransformadorDeXML;
  facturaV33: IComprobanteFiscalV33;
  nodoLeyenda: IXMLNode;
begin
  Assert(aComprobante <> nil, 'La instancia aComprobante no debio ser nula');
  // Verificamos que la versión del comprobante sea 3.3 pues solo será una cadena original válida para dicha versión
  Assert(aComprobante.Version = '3.3', 'La version del CFDI no fue 3.3');

  if not Supports(aComprobante, IComprobanteFiscalV33, facturaV33) then
    raise Exception.Create('El comprobante no es v3.3');

  if facturaV33.Complemento.TimbreFiscalDigital = nil then
    raise
      Exception.Create('El comprobante no esta timbrado, imposible generar cadena original del timbre.');

  transformador := TTransformadorDeXML.Create;
  try
    // Existe un error en el XSLT del Timbre fiscal donde si el Nodo Leyenda se auto-agregó al final
    //  Ej: cuando se consulta el valor de 'TimbreFiscalDigitalV33.Leyenda'
    // la transformación incluirá un CHR(10)+Chr(13) o #$D#$A entre el RFC y la Leyenda
    // Por la tanto si el nodo de la Leyenda se auto-agregó después del timbrado se moverá o
    // se eliminará si el nodo está o no vacío para evitar ese error:

    //Ejemplo:
    // Sin Leyenda              : '|1.1|4ab11a49-cdcf-4e42-8278-3b89219431ca|2018-09-11T15:53:23|AAA010101AAA|ghabiW....Bxl7Q==|20001000000300022323'
    // Con Leyenda ('' ó 'XX..'): '|1.1|4ab11a49-cdcf-4e42-8278-3b89219431ca|2018-09-11T15:53:23|AAA010101AAA'+'#$D#$A'+'||ghabiW....Bxl7Q==|20001000000300022323'

    nodoLeyenda := facturaV33.Complemento.TimbreFiscalDigital.AttributeNodes.FindNode('Leyenda');
    if Assigned( nodoLeyenda ) and
      (trim(nodoLeyenda.Text)='') and
      (facturaV33.Complemento.TimbreFiscalDigital.AttributeNodes.IndexOf('Leyenda') =
      (facturaV33.Complemento.TimbreFiscalDigital.AttributeNodes.Count-1) ) Then
    begin
     {Si La posición de Leyenda es la última del nodo, quiere decir que se agregó después del timbrado}
     facturaV33.Complemento.TimbreFiscalDigital.AttributeNodes.Delete('Leyenda');
    end;

    contenidoXMLComprobante := facturaV33.Complemento.TimbreFiscalDigital.XML;
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

