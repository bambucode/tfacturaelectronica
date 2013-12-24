(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Representa a un certificado (.CER) generado por el SAT

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)

unit ClaseCertificadoSAT;

interface

uses FacturaTipos,
     OpenSSLUtils;

type

  TCertificadoSAT = class
  private
    fx509Certificado : TX509Certificate;
    fCertificadoFacturas: TFECertificado;
    function GetComoBase64: String;
    function GetVigente: Boolean;
  public
    constructor Create(const aRutaCertificado: String);
    destructor Destroy; override;
    property ComoBase64: String read GetComoBase64;
    property paraFacturar: TFECertificado read fCertificadoFacturas;
    property Vigente: Boolean read GetVigente;

  end;

implementation

uses SysUtils;

constructor TCertificadoSAT.Create(const aRutaCertificado: String);
const
  _ERROR_LECTURA_CERTIFICADO = 'Unable to read certificate';
  _CADENA_INICIO_RFC_EN_CERTIFICADO = 'UniqueIdentifier=';
  _LONGITUD_RFC = 13;
var
  rfcDelCertificado: String;
begin
  fx509Certificado := TX509Certificate.Create;
  try
    if Not FileExists(aRutaCertificado) then
      raise EFECertificadoNoExisteException.Create('No existe el archivo del certificado: ' + aRutaCertificado)
    else
      fx509Certificado.LoadFromFile(aRutaCertificado);

    fCertificadoFacturas.Ruta := aRutaCertificado;

    // Leemos las propiedades
    fCertificadoFacturas.VigenciaInicio := fx509Certificado.NotBefore;
    fCertificadoFacturas.VigenciaFin := fx509Certificado.NotAfter;

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
        FreeAndNil(fx509Certificado);
        // Checamos los posibles errores
        if AnsiPos(_ERROR_LECTURA_CERTIFICADO, E.Message) > 0 then
            raise EFECertificadoNoFueLeidoException.Create('No fue posible leer el certificado: ' + E.Message)
        else
            raise;
     end;
  end;
end;

destructor TCertificadoSAT.Destroy;
begin
  inherited;

  if Assigned(fx509Certificado) then
     FreeAndNil(fx509Certificado);
end;

function TCertificadoSAT.GetComoBase64: String;
const
  _CADENA_INICIO_CERTIFICADO = '-----BEGIN CERTIFICATE-----';
  _CADENA_FIN_CERTIFICADO    = '-----END CERTIFICATE-----';
var
  sCertificadoBase64: string;
begin
  Assert(fx509Certificado <> nil, 'El certificado interno X509 fue nulo');

  sCertificadoBase64 := fx509Certificado.AsBase64;
  // Quita los encabezados, pie y retornos de carro del certificado
  sCertificadoBase64:=StringReplace(sCertificadoBase64, #13, '', [rfReplaceAll, rfIgnoreCase]);
  sCertificadoBase64:=StringReplace(sCertificadoBase64, #10, '', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos encabezado del certificado
  sCertificadoBase64:=StringReplace(sCertificadoBase64, _CADENA_INICIO_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos el pie del certificado
  Result:=StringReplace(sCertificadoBase64, _CADENA_FIN_CERTIFICADO, '', [rfReplaceAll, rfIgnoreCase]);
end;

function TCertificadoSAT.GetVigente: Boolean;
begin
  {Result := ((Now >= fCertificadoFacturas.VigenciaInicio) And
             (Now <= fCertificadoFacturas.VigenciaFin));}

  // De momento solo checamos que la fecha de vigencia sea mayor a hoy
  Result := (Now <= fCertificadoFacturas.VigenciaFin);
end;

end.
