unit Facturacion.GeneradorCBB;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils,
{$ELSE}
     SysUtils,
{$IFEND}
     Facturacion.Comprobante;

type

  IGeneradorCBB = interface
    procedure GenerarImagenCBB(const aComprobante: IComprobanteFiscal;
                               const aRutaAGuardar: TFileName);
  end;

implementation

end.
