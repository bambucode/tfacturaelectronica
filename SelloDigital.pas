{******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

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
    fCadenaOriginal: TStringCadenaOriginal;
    fDigestion: TTipoDigestionOpenSSL;
    fOpenSSL: TOpenSSL;
    fCertificado: TFECertificado;
    fLlavePrivada: String;
private
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
  // TODO: Checar que la cadena original este validada (este codificada con UTF8, etc)
  Result:=fOpenSSL.HacerDigestion(fCertificado.LlavePrivada.Ruta,
                                  fCertificado.LlavePrivada.Clave,
                                  fCadenaOriginal,
                                  fDigestion);
  // TODO: Checar
  // El Data Binding del cfdv2.xsl se genera muy bien pero aveces resulta que, por ejemplo, el
  // cliente NO tiene "Numero Interior" o "Colonia" es por eso que en la unidad cfdv2.pas te recomiendo
  // hacer una busqueda y remplazo de :
end;

end.
