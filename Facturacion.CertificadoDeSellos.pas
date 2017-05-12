{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.CertificadoDeSellos;

interface

uses System.SysUtils,
     OpenSSLUtils;

type

  EFECertificadoNoExisteException = class(Exception);

  ICertificadoDeSellos = Interface
    ['{C4F1BC13-8975-4944-AF8F-5FB885C155FF}']
    function GetContenidoBase64: string;
    function GetEmitidoParaNombre: string;
    function GetEmitidoParaRFC: String;
    function GetNoCertificado: string;
    function GetVigenciaFin: TDateTime;
    function GetVigenciaInicio: TDateTime;
    procedure Leer(const aRutaCertificado: TFileName);
    property ContenidoBase64: string read GetContenidoBase64;
    property EmitidoParaNombre: string read GetEmitidoParaNombre;
    property EmitidoParaRFC: String read GetEmitidoParaRFC;
    property NoCertificado: string read GetNoCertificado;
    property VigenciaFin: TDateTime read GetVigenciaFin;
    property VigenciaInicio: TDateTime read GetVigenciaInicio;
  End;

  TCertificadoDeSellos = class(TInterfacedObject, ICertificadoDeSellos)
  private
    fx509Certificado : TX509Certificate;
    fFueLeido: Boolean;
    fVigenteDesde: TDateTime;
    fVigenteHasta: TDateTime;
    fNoCertificado: string;
    FContenidoBase64: string;
    fSubjectCertificado: String;
    function GetContenidoBase64: string;
    function GetEmitidoParaNombre: string;
    function GetEmitidoParaRFC: String;
    function GetNoCertificado: string;
    function GetVigenciaFin: TDateTime;
    function GetVigenciaInicio: TDateTime;
  public
    destructor Destroy; override;
    procedure Leer(const aRutaCertificado: TFileName);
    property ContenidoBase64: string read GetContenidoBase64;
    property EmitidoParaNombre: string read GetEmitidoParaNombre;
    property EmitidoParaRFC: String read GetEmitidoParaRFC;
    property NoCertificado: string read GetNoCertificado;
    property VigenciaFin: TDateTime read GetVigenciaFin;
    property VigenciaInicio: TDateTime read GetVigenciaInicio;
  end;


implementation

{ TCertificadoDeSellos }

procedure TCertificadoDeSellos.Leer(const aRutaCertificado: TFileName);
const
  _ERROR_LECTURA_CERTIFICADO = 'Unable to read certificate';
var
  rfcDelCertificado: String;
begin
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
          {$IFDEF CODESITE}
          CodeSite.SendException(E);
          {$ENDIF}
          raise;
       end;
    end;

    FFueLeido := True;

    {$IFDEF CODESITE}
    CodeSite.AddSeparator;
    CodeSite.Send('Issuer', fx509Certificado.Issuer);
    CodeSite.Send('Subject', fx509Certificado.Subject);
    CodeSite.Send('Text', fx509Certificado.Text);
    CodeSite.AddSeparator;
    {$ENDIF}

    // Identificamos el tipo de certificado (FIEL o sellos)
    //IdentificarTipoDeCertificado(fx509Certificado.Text);

    // Leemos las propiedades
    fVigenteDesde  := fx509Certificado.NotBefore;
    fVigenteHasta  := fx509Certificado.NotAfter;
    fNoCertificado := fx509Certificado.SerialNumber;

    fSubjectCertificado := fx509Certificado.Subject;
  except
     // Pasamos la excepcion tal y como esta
     On E: Exception do
     begin
        FFueLeido := False;
        FreeAndNil(fx509Certificado);
        raise;
     end;
  end;
end;

destructor TCertificadoDeSellos.Destroy;
begin
  inherited;

  if Assigned(fx509Certificado) then
     FreeAndNil(fx509Certificado);
end;

function TCertificadoDeSellos.GetContenidoBase64: string;
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

function TCertificadoDeSellos.GetEmitidoParaNombre: string;
const
  _CADENA_INICIO_NOMBRE_EN_CERTIFICADO = '/CN=';
  _CADENA_FIN_NOMBRE_EN_CERTIFICADO    = '/name=';
begin
  { Ejemplo cadena:
  Subject = /CN=RADIOGRAFIAS INDUSTRIALES DEL CENTRO AC/name=RADIOGRAFIAS INDUSTRIALES DEL CENTRO AC/O=RADIOGRAFIAS INDUSTRIALES DEL CENTRO AC
  /x500UniqueIdentifier=VOC990129I26 / FUAB770117BXA/serialNumber= / FUAB770117MDFRNN09/OU=Prueba_CFDI
  }
  Result := Trim(Copy(fSubjectCertificado,
                      AnsiPos(_CADENA_INICIO_NOMBRE_EN_CERTIFICADO, fSubjectCertificado) + Length(_CADENA_INICIO_NOMBRE_EN_CERTIFICADO),
                      AnsiPos(_CADENA_FIN_NOMBRE_EN_CERTIFICADO, fSubjectCertificado) - StrLen(_CADENA_INICIO_NOMBRE_EN_CERTIFICADO) - 1));

  Result := UpperCase(Result);
end;

function TCertificadoDeSellos.GetEmitidoParaRFC: String;
const
  _CADENA_INICIO_RFC_EN_CERTIFICADO = 'UniqueIdentifier=';
  _LONGITUD_RFC = 13;
begin
  // Obtenemos el RFC al que pertenece el certificado
  Result := Trim(Copy(fSubjectCertificado,
                      Pos(_CADENA_INICIO_RFC_EN_CERTIFICADO, fSubjectCertificado) + Length(_CADENA_INICIO_RFC_EN_CERTIFICADO),
                      _LONGITUD_RFC));

  Result := UpperCase(Result);
end;

function TCertificadoDeSellos.GetNoCertificado: string;
begin
  Result := fNoCertificado;
end;

function TCertificadoDeSellos.GetVigenciaFin: TDateTime;
begin
  Result := fVigenteDesde;
end;

function TCertificadoDeSellos.GetVigenciaInicio: TDateTime;
begin
  Result := fVigenteHasta;
end;

end.
