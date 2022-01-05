{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

program EjemploFacturaElectronica;

{$APPTYPE CONSOLE}

{$R *.res}

// ¿Se quiere soporte para el Debugger FASTMM?
{$IFDEF FASTMM}
  {$INCLUDE FastMM4Options.inc}
{$ENDIF}

// Incluimos el archivo de recurso .RC que contiene los XSLTs para generar las cadenas originales
{$R *.dres}

uses
  Forms,
  SysUtils,
  ActiveX,
  DelphiZXIngQRCode in '..\Lib\DelphiZXIngQRCode.pas',
  QuricolAPI in '..\Lib\QuricolAPI.pas',
  QuricolCode in '..\Lib\QuricolCode.pas',
  libeay32 in '..\OpenSSL\libeay32.pas',
  LibEay32Plus in '..\OpenSSL\LibEay32Plus.pas',
  OpenSSLUtils in '..\OpenSSL\OpenSSLUtils.pas',
  synacode in '..\Lib\synapse\synacode.pas',
  httpsend in '..\Lib\synapse\httpsend.pas',
  ssl_openssl in '..\Lib\synapse\ssl_openssl.pas',
  blcksock in '..\Lib\synapse\blcksock.pas',
  synafpc in '..\Lib\synapse\synafpc.pas',
  synsock in '..\Lib\synapse\synsock.pas',
  synautil in '..\Lib\synapse\synautil.pas',
  synaip in '..\Lib\synapse\synaip.pas',
  ssl_openssl_lib in '..\Lib\synapse\ssl_openssl_lib.pas',
  Facturacion.PAC.Ecodex in '..\PACs\Ecodex\Facturacion.PAC.Ecodex.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsClientes in '..\PACs\Ecodex\EcodexWsClientes.pas',
  EcodexWsComun in '..\PACs\Ecodex\EcodexWsComun.pas',
  EcodexWsSeguridad in '..\PACs\Ecodex\EcodexWsSeguridad.pas',
  EcodexWsTimbrado in '..\PACs\Ecodex\EcodexWsTimbrado.pas',
  Facturacion.ManejadorErroresComunesWebServices in '..\PACs\Facturacion.ManejadorErroresComunesWebServices.pas',
  EcodexWsCancelacion in '..\PACs\Ecodex\EcodexWsCancelacion.pas',
  Facturacion.PAC.SolucionFactible in '..\PACs\SolucionFactible\Facturacion.PAC.SolucionFactible.pas',
  SolucionFactibleWsTimbrado in '..\PACs\SolucionFactible\SolucionFactibleWsTimbrado.pas',
  MultiFacturasWsTimbrado in '..\PACs\MultiFacturas\MultiFacturasWsTimbrado.pas',
  Facturacion.PAC.MultiFacturas in '..\PACs\MultiFacturas\Facturacion.PAC.MultiFacturas.pas',
  MultiFacturasWsTimbradoEx in '..\PACs\MultiFacturas\MultiFacturasWsTimbradoEx.pas',
  Facturacion.Administrador in '..\Facturacion.Administrador.pas',
  Facturacion.CertificadoDeSellos in '..\Facturacion.CertificadoDeSellos.pas',
  Facturacion.GeneradorCadenaOriginal in '..\Facturacion.GeneradorCadenaOriginal.pas',
  Facturacion.GeneradorCBB in '..\Facturacion.GeneradorCBB.pas',
  Facturacion.GeneradorLigaVerificacion in '..\Facturacion.GeneradorLigaVerificacion.pas',
  Facturacion.GeneradorQR in '..\Facturacion.GeneradorQR.pas',
  Facturacion.GeneradorQRQuricol in '..\Facturacion.GeneradorQRQuricol.pas',
  Facturacion.GeneradorSello in '..\Facturacion.GeneradorSello.pas',
  Facturacion.Helper in '..\Facturacion.Helper.pas',
  Facturacion.OpenSSL in '..\Facturacion.OpenSSL.pas',
  Facturacion.ProveedorAutorizadoCertificacion in '..\Facturacion.ProveedorAutorizadoCertificacion.pas',
  Facturacion.Tipos in '..\Facturacion.Tipos.pas',
  Facturacion.ComplementoPagoV1 in '..\Versiones\Facturacion.ComplementoPagoV1.pas',
  Facturacion.Comprobante in '..\Versiones\Facturacion.Comprobante.pas',
  Facturacion.ComprobanteV32 in '..\Versiones\Facturacion.ComprobanteV32.pas',
  Facturacion.ComprobanteV33 in '..\Versiones\Facturacion.ComprobanteV33.pas',
  Facturacion.GeneradorCadenaOrignalV32 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV32.pas',
  Facturacion.GeneradorCadenaOrignalV33 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV33.pas',
  Facturacion.GeneradorCBBv32 in '..\Versiones\Facturacion.GeneradorCBBv32.pas',
  Facturacion.GeneradorCBBv33 in '..\Versiones\Facturacion.GeneradorCBBv33.pas',
  Facturacion.GeneradorSelloV32 in '..\Versiones\Facturacion.GeneradorSelloV32.pas',
  Facturacion.GeneradorSelloV33 in '..\Versiones\Facturacion.GeneradorSelloV33.pas',
  Facturacion.ImpuestosLocalesV1 in '..\Versiones\Facturacion.ImpuestosLocalesV1.pas',
  Facturacion.TimbreFiscalDigitalV32 in '..\Versiones\Facturacion.TimbreFiscalDigitalV32.pas',
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas',
  Facturacion.PAC.FInkOk in '..\PACs\FinkOK\Facturacion.PAC.FInkOk.pas',
  FinkOkWsTimbrado in '..\PACs\FinkOK\FinkOkWsTimbrado.pas',
  FinkOkWsCancelacion in '..\PACs\FinkOK\FinkOkWsCancelacion.pas',
  FinkOkWsComun in '..\PACs\FinkOK\FinkOkWsComun.pas',
  Cancelacion.PAC.Comercio in '..\PACs\ComercioDigital\Cancelacion.PAC.Comercio.pas',
  ComercioWsComun in '..\PACs\ComercioDigital\ComercioWsComun.pas',
  Facturacion.PAC.Comercio in '..\PACs\ComercioDigital\Facturacion.PAC.Comercio.pas',
  Facturacion.ComplementoComercioExteriorV11 in '..\Versiones\Facturacion.ComplementoComercioExteriorV11.pas',
  EjemploFacturaElectronicaMain in 'EjemploFacturaElectronicaMain.pas',
  Facturacion.ComprobanteV40 in '..\Versiones\Facturacion.ComprobanteV40.pas';

begin
 EjemploFacturaElectronicaMain.Ejemplo;
end.
