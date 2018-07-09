{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorSello;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL;

type

  /// <summary>
  ///   Instancia base encargada de generar el sello del comprobante
  ///   independientemente de la versión.
  /// </summary>
  IGeneradorSello = Interface
    ['{28111CB2-59C9-4D2C-89F9-09E3CD447668}']
    /// <summary>
    ///   Instancia de OpenSSL usada para la encripción.
    /// </summary>
    procedure Configurar(const aOpenSSL: IOpenSSL);
    /// <summary>
    ///   Se encarga de generar el respectivo sello según la encripción de la
    ///   versión implementada
    /// </summary>
    /// <param name="aCadenaOriginal">
    ///   Cadena Original del CFDI previamente generada
    /// </param>
    function GenerarSelloDeFactura(const aCadenaOriginal: TCadenaUTF8): TCadenaUTF8;
  End;

implementation

end.
