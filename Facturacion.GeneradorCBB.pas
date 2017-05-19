unit Facturacion.GeneradorCBB;

interface

uses System.SysUtils,
     Facturacion.Comprobante;

type

  IGeneradorCBB = interface
    procedure GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
                               const aRutaAGuardar: TFileName);
  end;

implementation

end.
