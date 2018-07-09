{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.GeneradorSelloV33;

interface

uses Facturacion.Comprobante,
     Facturacion.GeneradorSello,
     Facturacion.OpenSSL;

type

  TGeneradorSelloV33 = class(TInterfacedObject, IGeneradorSello)
  private
    fInstanciaOpenSSL: IOpenSSL;
  public
    procedure Configurar(const aOpenSSL: IOpenSSL);
    function GenerarSelloDeFactura(const aCadenaOriginal: TCadenaUTF8): TCadenaUTF8;
  End;

implementation


{ TGeneradorSelloV33 }

procedure TGeneradorSelloV33.Configurar(const aOpenSSL: IOpenSSL);
begin
  fInstanciaOpenSSL := aOpenSSL;
end;

function TGeneradorSelloV33.GenerarSelloDeFactura(const aCadenaOriginal:
    TCadenaUTF8): TCadenaUTF8;
begin
  Assert(fInstanciaOpenSSL <> nil, 'La instancia fInstancia OpenSSL no debio ser nula. Favor de mandar la instancia en el metodo Configurar');
  // CFDI v3.3 utiliza SHA256

 // Nota: en Delphi 7 aCadenaOriginal ya viene codificada en UTF8 (UTFEncode),
 // por lo tanto se necesita Decodificar (UTFDecode) antes de ser pasada esta
 // función, de lo contrario se Volverá a Codificar alterando el resultado

  Result := fInstanciaOpenSSL.HacerDigestion(UTF8Decode(aCadenaOriginal), tdSHA256);
end;


end.
