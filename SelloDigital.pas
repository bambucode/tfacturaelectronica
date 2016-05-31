{******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Clase usada para generar el Sello Digital de una Cadena Original proveniente
 de una factura electrónica. Aqui se especifican todas las reglas especificadas
 por el SAT para la generación del mismo.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************}

unit SelloDigital;

interface

uses  Windows, FacturaTipos, ClaseOpenSSL;

type

///<summary>Representa el Sello Digital con el cual debemos de
/// 'sellar' la factura electrónica.
///</summary>
TSelloDigital = class
private
    fCadenaOriginal: TStringCadenaOriginal;
    fDigestion: TTipoDigestionOpenSSL;
    fOpenSSL: TOpenSSL;
    fCertificado: TFECertificado;
    fLlavePrivada: String;
    function calcularSello(): WideString;
public
    constructor Create(sCadenaOriginal: TStringCadenaOriginal; Certificado: TFECertificado; TipoDigestion: TTipoDigestionOpenSSL);
    destructor Destroy; override;
    property SelloCalculado : WideString read calcularSello;
end;

implementation

uses Sysutils, StrUtils;

constructor TSelloDigital.Create(sCadenaOriginal: TStringCadenaOriginal; Certificado: TFECertificado; TipoDigestion: TTipoDigestionOpenSSL);
begin
  inherited Create;
  // Creamos nuestra clase OpenSSL usada para hacer la digestión
  fOpenSSL:=TOpenSSL.Create();
  fCadenaOriginal:=sCadenaOriginal;
  fDigestion:=TipoDigestion;
  fCertificado:=Certificado;
end;

destructor TSelloDigital.Destroy;
begin
    FreeAndNil(fOpenSSL);
    inherited Destroy;
end;

// Calcula el Sello Digital para la Cadena Original preparada en el constructor
function TSelloDigital.calcularSello : WideString;
begin
  // Realizamos la digestion de la cadena original usando el certificado
  // indicado y el modo de digestion
  Result:=fOpenSSL.HacerDigestion(fCertificado.LlavePrivada.Ruta,
                                  fCertificado.LlavePrivada.Clave,
                                  fCadenaOriginal,
                                  fDigestion);
end;

end.
