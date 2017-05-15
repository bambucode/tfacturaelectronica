program LeerCFDI;

uses
  Vcl.Forms,
  uPrin in 'uPrin.pas' {frmPrin},
  Facturacion.ComprobanteV33 in '..\..\Versiones\Facturacion.ComprobanteV33.pas',
  Facturacion.Comprobante in '..\..\Versiones\Facturacion.Comprobante.pas',
  Facturacion.Administrador in '..\..\Facturacion.Administrador.pas',
  Facturacion.GeneradorCadenaOriginal in '..\..\Facturacion.GeneradorCadenaOriginal.pas',
  Facturacion.GeneradorCadenaOrignalV33 in '..\..\Versiones\Facturacion.GeneradorCadenaOrignalV33.pas',
  Facturacion.GeneradorSello in '..\..\Facturacion.GeneradorSello.pas',
  Facturacion.OpenSSL in '..\..\Facturacion.OpenSSL.pas',
  Facturacion.GeneradorSelloV33 in '..\..\Versiones\Facturacion.GeneradorSelloV33.pas',
  Facturacion.PAC.Ecodex in '..\..\PACs\Ecodex\Facturacion.PAC.Ecodex.pas',
  Facturacion.ProveedorAutorizadoCertificacion in '..\..\Facturacion.ProveedorAutorizadoCertificacion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsClientes in '..\..\PACs\Ecodex\EcodexWsClientes.pas',
  EcodexWsComun in '..\..\PACs\Ecodex\EcodexWsComun.pas',
  EcodexWsSeguridad in '..\..\PACs\Ecodex\EcodexWsSeguridad.pas',
  EcodexWsTimbrado in '..\..\PACs\Ecodex\EcodexWsTimbrado.pas',
  Facturacion.CertificadoDeSellos in '..\..\Facturacion.CertificadoDeSellos.pas',
  Facturacion.Helper in '..\..\Facturacion.Helper.pas',
  Facturacion.ManejadorErroresComunesWebServices in '..\..\PACs\Facturacion.ManejadorErroresComunesWebServices.pas' {$R *.res},
  libeay32 in '..\..\OpenSSL\libeay32.pas',
  LibEay32Plus in '..\..\OpenSSL\LibEay32Plus.pas',
  OpenSSLUtils in '..\..\OpenSSL\OpenSSLUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrin, frmPrin);
  Application.Run;
end.
