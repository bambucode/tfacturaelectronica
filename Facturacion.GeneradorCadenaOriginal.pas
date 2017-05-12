{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorCadenaOriginal;

interface

uses Facturacion.Comprobante;

type

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
  end;

implementation

end.
