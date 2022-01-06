{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2022 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

program EjemploFacturaElectronicaComplementoPago;

{$APPTYPE CONSOLE}

{$R *.res}

// Incluimos el archivo de recurso .RC que contiene los XSLTs para generar las cadenas originales


// ¿Se quiere soporte para el Debugger FASTMM?
{$IFDEF FASTMM}
  {$INCLUDE FastMM4Options.inc}
{$ENDIF}

{$R *.dres}
uses
  activex,
  SysUtils,
  Forms,
  Facturacion.ComprobanteV33 in '..\Versiones\Facturacion.ComprobanteV33.pas',
  Facturacion.Comprobante in '..\Versiones\Facturacion.Comprobante.pas',
  Facturacion.Administrador in '..\Facturacion.Administrador.pas',
  Facturacion.GeneradorCadenaOriginal in '..\Facturacion.GeneradorCadenaOriginal.pas',
  Facturacion.GeneradorCadenaOrignalV33 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV33.pas',
  Facturacion.GeneradorSello in '..\Facturacion.GeneradorSello.pas',
  Facturacion.OpenSSL in '..\Facturacion.OpenSSL.pas',
  Facturacion.GeneradorSelloV33 in '..\Versiones\Facturacion.GeneradorSelloV33.pas',
  Facturacion.PAC.Ecodex in '..\PACs\Ecodex\Facturacion.PAC.Ecodex.pas',
  Facturacion.ProveedorAutorizadoCertificacion in '..\Facturacion.ProveedorAutorizadoCertificacion.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  EcodexWsClientes in '..\PACs\Ecodex\EcodexWsClientes.pas',
  EcodexWsComun in '..\PACs\Ecodex\EcodexWsComun.pas',
  EcodexWsSeguridad in '..\PACs\Ecodex\EcodexWsSeguridad.pas',
  EcodexWsTimbrado in '..\PACs\Ecodex\EcodexWsTimbrado.pas',
  EcodexWsCancelacion in '..\PACs\Ecodex\EcodexWsCancelacion.pas',
  Facturacion.GeneradorCBB in '..\Facturacion.GeneradorCBB.pas',
  Facturacion.GeneradorQRQuricol in '..\Facturacion.GeneradorQRQuricol.pas',
  Facturacion.GeneradorLigaVerificacion in '..\Facturacion.GeneradorLigaVerificacion.pas',
  Facturacion.PAC.SolucionFactible in '..\PACs\SolucionFactible\Facturacion.PAC.SolucionFactible.pas',
  SolucionFactibleWsTimbrado in '..\PACs\SolucionFactible\SolucionFactibleWsTimbrado.pas',
  Facturacion.PAC.MultiFacturas in '..\PACs\MultiFacturas\Facturacion.PAC.MultiFacturas.pas',
  MultiFacturasWsTimbrado in '..\PACs\MultiFacturas\MultiFacturasWsTimbrado.pas',
  Facturacion.CertificadoDeSellos in '..\Facturacion.CertificadoDeSellos.pas',
  Facturacion.Helper in '..\Facturacion.Helper.pas',
  Facturacion.ManejadorErroresComunesWebServices in '..\PACs\Facturacion.ManejadorErroresComunesWebServices.pas',
  Facturacion.GeneradorCBBv33 in '..\Versiones\Facturacion.GeneradorCBBv33.pas',
  DelphiZXIngQRCode in '..\Lib\DelphiZXIngQRCode.pas',
  Facturacion.GeneradorQR in '..\Facturacion.GeneradorQR.pas',
  Facturacion.TimbreFiscalDigitalV33 in '..\Versiones\Facturacion.TimbreFiscalDigitalV33.pas',
  Facturacion.ComprobanteV32 in '..\Versiones\Facturacion.ComprobanteV32.pas',
  Facturacion.TimbreFiscalDigitalV32 in '..\Versiones\Facturacion.TimbreFiscalDigitalV32.pas',
  Facturacion.GeneradorCadenaOrignalV32 in '..\Versiones\Facturacion.GeneradorCadenaOrignalV32.pas',
  Facturacion.GeneradorSelloV32 in '..\Versiones\Facturacion.GeneradorSelloV32.pas',
  Facturacion.GeneradorCBBv32 in '..\Versiones\Facturacion.GeneradorCBBv32.pas',
  Facturacion.Tipos in '..\Facturacion.Tipos.pas',
  Facturacion.ImpuestosLocalesV1 in '..\Versiones\Facturacion.ImpuestosLocalesV1.pas',
  Facturacion.ComplementoPagoV1 in '..\Versiones\Facturacion.ComplementoPagoV1.pas',
  Facturacion.PAC.FInkOk in '..\PACs\FinkOK\Facturacion.PAC.FInkOk.pas',
  FinkOkWsCancelacion in '..\PACs\FinkOK\FinkOkWsCancelacion.pas',
  FinkOkWsComun in '..\PACs\FinkOK\FinkOkWsComun.pas',
  FinkOkWsTimbrado in '..\PACs\FinkOK\FinkOkWsTimbrado.pas',
  EjemploFacturaElectronicaComplementoPagoMain in 'EjemploFacturaElectronicaComplementoPagoMain.pas';

begin
 EjemploFacturaElectronicaComplementoPagoMain.Ejemplo;
end.
