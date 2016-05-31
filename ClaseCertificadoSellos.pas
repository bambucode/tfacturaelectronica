(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Representa a un certificado (.CER) generado por el SAT

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)

unit ClaseCertificadoSellos;

interface

uses FacturaTipos,
     OpenSSLUtils;

type

  TCertificadoSellos = class
  private
    fx509Certificado : TX509Certificate;
    fTipoCertificado : TFETipoCertificado;
    fCertificadoFacturas: TFECertificado;
    FFueLeido: Boolean;
    FRazonNoLeido: String;
    FVigenteDesde: TDateTime;
    FVigenteHasta: TDateTime;
    function GetComoBase64: String;
    function GetEsValido: Boolean;
    function GetTipo: TFETipoCertificado;
    function GetVigente: Boolean;
    procedure IdentificarTipoDeCertificado(const aContenidoCertificado: String);
  public
    constructor Create(const aRutaCertificado: String);
    destructor Destroy; override;
    function esParejaDe(const aLlavePrivada: TFELlavePrivada): Boolean;
    property ComoBase64: String read GetComoBase64;
    property paraFacturar: TFECertificado read fCertificadoFacturas;
    property Tipo: TFETipoCertificado read GetTipo;
    property Vigente: Boolean read GetVigente;
    property VigenteDesde: TDateTime read FVigenteDesde;
    property VigenteHasta: TDateTime read FVigenteHasta;
    property FueLeido: Boolean read FFueLeido;
    property RazonNoLeido: String read FRazonNoLeido;
  end;

implementation

uses SysUtils,
     {.$IFDEF CODESITE}
     CodeSiteLogging,
     {.$ENDIF}
     ClaseOpenSSL;

constructor TCertificadoSellos.Create(const aRutaCertificado: String);
const
  _ERROR_LECTURA_CERTIFICADO = 'Unable to read certificate';
  _CADENA_INICIO_RFC_EN_CERTIFICADO = 'UniqueIdentifier=';
  _LONGITUD_RFC = 13;
var
  rfcDelCertificado: String;
begin
  fRazonNoLeido := '';
  AppStartup;
  fx509Certificado := TX509Certificate.Create;
  try
    if Not FileExists(aRutaCertificado) then
      raise EFECertificadoNoExisteException.Create('No existe el archivo del certificado: ' + aRutaCertificado);

    try
       fx509Certificado.LoadFromFile(aRutaCertificado);
    except
       On E:Exception do
       begin
          fRazonNoLeido := E.Message;
          CodeSite.SendException(E);
          raise;
       end;
    end;

    FFueLeido := True;

    fCertificadoFacturas.Ruta := aRutaCertificado;

    {$IFDEF CODESITE}
    CodeSite.AddSeparator;
    CodeSite.Send('Issuer', fx509Certificado.Issuer);
    CodeSite.Send('Subject', fx509Certificado.Subject);
    CodeSite.Send('Text', fx509Certificado.Text);
    CodeSite.AddSeparator;
    {$ENDIF}

    // Identificamos el tipo de certificado (FIEL o sellos)
    IdentificarTipoDeCertificado(fx509Certificado.Text);

    // Leemos las propiedades
    fVigenteDesde := fx509Certificado.NotBefore;
    fCertificadoFacturas.VigenciaInicio := fVigenteDesde;
    fVigenteHasta := fx509Certificado.NotAfter;
    fCertificadoFacturas.VigenciaFin := fVigenteHasta;

    fCertificadoFacturas.NumeroSerie := fx509Certificado.SerialNumber;

    // Obtenemos el RFC al que pertenece el certificado
    rfcDelCertificado := Trim(Copy(fx509Certificado.Subject,
                              Pos(_CADENA_INICIO_RFC_EN_CERTIFICADO, fx509Certificado.Subject) + Length(_CADENA_INICIO_RFC_EN_CERTIFICADO),
                              _LONGITUD_RFC));

    fCertificadoFacturas.RFCAlQuePertenece := Uppercase(rfcDelCertificado);
  except
     // Pasamos la excepcion tal y como esta
     On E: Exception do
     begin
        FFueLeido := False;
        FreeAndNil(fx509Certificado);
        // Checamos los posibles errores
        fRazonNoLeido := E.Message + ' (' + GetErrorMessage() + ')';
     end;
  end;
end;

destructor TCertificadoSellos.Destroy;
begin
  inherited;

  if Assigned(fx509Certificado) then
     FreeAndNil(fx509Certificado);
end;

function TCertificadoSellos.esParejaDe(const aLlavePrivada: TFELlavePrivada):
    Boolean;
var
  openSSL: TOpenSSL;
  moduloLlavePrivada, moduloCertificado: string;
begin
  Result := False;

  if Not FileExists(aLlavePrivada.Ruta) then
    raise Exception.Create('El archivo de llave privada no existe');

  try
    openSSL := TOpenSSL.Create;

    moduloLlavePrivada := openSSL.ObtenerModulusDeLlavePrivada(aLlavePrivada.Ruta, aLlavePrivada.Clave);
    moduloCertificado := openSSL.ObtenerModulusDeCertificado(fCertificadoFacturas.Ruta);

    {$IFDEF CODESITE}
    CodeSite.Send('Modulus Llave Privada', moduloLlavePrivada);
    CodeSite.Send('Modulus Certificado', moduloCertificado);
    CodeSite.Send('¿Son Pareja?', moduloCertificado = moduloLlavePrivada);
    {$ENDIF}

    Result := (moduloLlavePrivada = moduloCertificado);
  finally
    openSSL.Free;
  end;
end;

function TCertificadoSellos.GetComoBase64: String;
const
  _CADENA_INICIO_CERTIFICADO = '-----BEGIN CERTIFICATE-----';
  _CADENA_FIN_CERTIFICADO    = '-----END CERTIFICATE-----';
var
  sCertificadoBase64: string;
begin
  Assert(fx509Certificado <> nil, 'El certificado interno X509 fue nulo');

  sCertificadoBase64 := fx509Certificado.AsBase64;
  Assert(Pos(_CADENA_INICIO_CERTIFICADO, sCertificadoBase64) > 0, 'No se tuvo cadena de inicio de certificado');
  Assert(Pos(_CADENA_FIN_CERTIFICADO, sCertificadoBase64) > 0, 'No se tuvo cadena de fin de certificado');

  // Quita los encabezados, pie y retornos de carro del certificado
  sCertificadoBase64:=StringReplace(sCertificadoBase64, #13, '', [rfReplaceAll, rfIgnoreCase]);
  sCertificadoBase64:=StringReplace(sCertificadoBase64, #10, '', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos encabezado del certificado
  sCertificadoBase64:=StringReplace(sCertificadoBase64, _CADENA_INICIO_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos el pie del certificado
  Result:=StringReplace(sCertificadoBase64, _CADENA_FIN_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
end;

function TCertificadoSellos.GetEsValido: Boolean;
begin
  Result := True;
end;

function TCertificadoSellos.GetTipo: TFETipoCertificado;
begin
  Result := fTipoCertificado;
end;

function TCertificadoSellos.GetVigente: Boolean;
begin
  Result := ((Now >= fCertificadoFacturas.VigenciaInicio) And
             (Now <= fCertificadoFacturas.VigenciaFin));
end;

procedure TCertificadoSellos.IdentificarTipoDeCertificado(const
    aContenidoCertificado: String);
const
  // Las siguientes cadenas solo se encuentran en un certificado de FIEL
  // despues de X509v3 Key Usage
  _CADENA_USO_X509V3_CIFRADO = 'Data Encipherment';
  _CADENA_USO_X509V3_LLAVE = 'Key Agreement';
begin
  if ((AnsiPos(_CADENA_USO_X509V3_CIFRADO, aContenidoCertificado) > 0) And
     (AnsiPos(_CADENA_USO_X509V3_LLAVE, aContenidoCertificado) > 0)) then
    fTipoCertificado := tcFIEL
  else
    fTipoCertificado := tcSellos;
end;

end.
