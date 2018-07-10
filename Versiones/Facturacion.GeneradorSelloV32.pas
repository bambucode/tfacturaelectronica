{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorSelloV32;

interface

uses Facturacion.Comprobante,
     Facturacion.GeneradorSello,
     Facturacion.OpenSSL;

type

  TGeneradorSelloV32 = class(TInterfacedObject, IGeneradorSello)
  private
    fInstanciaOpenSSL: IOpenSSL;
  public
    procedure Configurar(const aOpenSSL: IOpenSSL);
    function GenerarSelloDeFactura(const aCadenaOriginal: TCadenaUTF8): TCadenaUTF8;
  End;

implementation

{ TGeneradorSelloV32 }

procedure TGeneradorSelloV32.Configurar(const aOpenSSL: IOpenSSL);
begin
  fInstanciaOpenSSL := aOpenSSL;
end;

function TGeneradorSelloV32.GenerarSelloDeFactura(const aCadenaOriginal:
    TCadenaUTF8): TCadenaUTF8;
begin
  Assert(fInstanciaOpenSSL <> nil, 'La instancia fInstanciaOpenSSL no debio ser nula. Favor de mandar la instancia en el metodo Configurar');
  // CFDI v3.2 utiliza SHA1

  Result := fInstanciaOpenSSL.HacerDigestion(aCadenaOriginal, tdSHA1)
end;


end.
