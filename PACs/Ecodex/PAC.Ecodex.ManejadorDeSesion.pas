{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit PAC.Ecodex.ManejadorDeSesion;

interface

uses EcodexWsSeguridad,
     Facturacion.Comprobante,
     SysUtils;

type

  TEcodexManejadorDeSesion = class
  private
    fDominioWebService: String;
    fCredenciales: TFacturacionCredencialesPAC;
    wsSeguridad : IEcodexServicioSeguridad;
    fNumeroTransaccion: Int64;
    function GetNumeroDeTransaccion: Int64;
    function ObtenerNuevoTokenDeServicio(const aRFC: String): String;
    procedure ProcesarFallaEcodex(const aExcepcion: Exception);
  public
    constructor Create(const aDominioWebService: String; const
        aIdTransaccionInicial: Integer);
    procedure AfterConstruction; override;
    procedure AsignarCredenciales(const aCredenciales: TFacturacionCredencialesPAC);
    function ObtenerNuevoTokenAltaEmisores(const aRFC, aIdIntegrador,
        aIdAltaEmisores: String): String;
    function ObtenerNuevoTokenDeUsuario: String;
    property NumeroDeTransaccion: Int64 read GetNumeroDeTransaccion;
  end;

implementation

uses IdHash,
     Facturacion.ManejadorErroresComunesWebServices,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     Facturacion.ProveedorAutorizadoCertificacion;

constructor TEcodexManejadorDeSesion.Create(const aDominioWebService: String;
    const aIdTransaccionInicial: Integer);
begin
  fDominioWebService := aDominioWebService;
  // Establecemos el numero de transaccion con que comenzaremos para que sea un consecutivo
  fNumeroTransaccion := aIdTransaccionInicial;
end;

procedure TEcodexManejadorDeSesion.AfterConstruction;
begin
  inherited;
  // Obtenemos la instancia del WebService de Sesion usando el dominio especificado por el usuario
  wsSeguridad := GetWsEcodexSeguridad(False, fDominioWebService + '/ServicioSeguridad.svc');
end;

procedure TEcodexManejadorDeSesion.AsignarCredenciales(const aCredenciales: TFacturacionCredencialesPAC);
begin
  Assert(aCredenciales.RFC <> '', 'El RFC de las credenciales estuvo vac�o');
  Assert(aCredenciales.DistribuidorID <> '', 'El ID de Integrador estuvo vac�o');

  fCredenciales := aCredenciales;
end;

function TEcodexManejadorDeSesion.GetNumeroDeTransaccion: Int64;
begin
  Result := fNumeroTransaccion;
end;

function TEcodexManejadorDeSesion.ObtenerNuevoTokenDeServicio(const aRFC:
    String): String;
var
  nuevaSolicitudDeToken: TEcodexSolicitudDeToken;
  respuestaSolicitudDeToken: TEcodexRespuestaObtenerToken;
begin
  Assert(fCredenciales.RFC <> '', 'Las credenciales del PAC no fueron asignadas');
  {$IFDEF CODESITE} CodeSite.EnterMethod('ObtenerNuevoTokenDeServicio'); {$ENDIF}
  nuevaSolicitudDeToken := TEcodexSolicitudDeToken.Create;
  try
    nuevaSolicitudDeToken.RFC := aRFC;
    nuevaSolicitudDeToken.TransaccionID := fNumeroTransaccion;

    try
      respuestaSolicitudDeToken := wsSeguridad.ObtenerToken(nuevaSolicitudDeToken);
      {$IFDEF CODESITE} CodeSite.Send('Token de servicio obtenido', respuestaSolicitudDeToken.Token); {$ENDIF}
      Result := respuestaSolicitudDeToken.Token;
    except
      on E:Exception do
       ProcesarFallaEcodex(E);
    end;
  finally
    nuevaSolicitudDeToken.Free;
    {$IFDEF CODESITE} CodeSite.ExitMethod('ObtenerNuevoTokenDeServicio'); {$ENDIF}
  end;
end;

function TEcodexManejadorDeSesion.ObtenerNuevoTokenDeUsuario: String;
var
  tokenDeServicio: string;
begin
  Assert(fCredenciales.RFC <> '', 'Las credenciales del PAC no fueron asignadas');

  // Incrementamos el numero de transaccion
  Inc(fNumeroTransaccion);

  try
     tokenDeServicio := ObtenerNuevoTokenDeServicio(fCredenciales.RFC);

     // El token de usuario ser� la combinacion del token de servicio y el ID del integrador
     // concatenados por un "pipe" codificados con el agoritmo SHA1
     Result:= TIdHash.HashString(fCredenciales.DistribuidorID + '|' + tokenDeServicio, GetDefault); //THashSHA1.GetHashString(fCredenciales.DistribuidorID + '|' + tokenDeServicio);
  except
    On E:Exception do
      raise;
  end;
end;

function TEcodexManejadorDeSesion.ObtenerNuevoTokenAltaEmisores(const aRFC,
    aIdIntegrador, aIdAltaEmisores: String): String;
var
  tokenDeServicio: string;
begin
  Assert(fCredenciales.RFC <> '', 'Las credenciales del PAC no fueron asignadas');

  // Incrementamos el numero de transaccion
  Inc(fNumeroTransaccion);

  try
     tokenDeServicio := ObtenerNuevoTokenDeServicio(aRFC);

     // El token de alta de emisores ser� la combinacion de:
     // - El ID del integrador
     // - El ID de alta de emisores (en mayusculas forzosamente)
     // - El token de servicio
     // Todos concatenados con un pipe (|) y codificados con el agoritmo SHA1

     Result:= TIdHash.HashString(aIdIntegrador + '|' +                        //THashSHA1.GetHashString(aIdIntegrador + '|' +
                                 Uppercase(aIdAltaEmisores) + '|' +                                   //Uppercase(aIdAltaEmisores) + '|' +
                                 tokenDeServicio, GetDefault);                                                    //tokenDeServicio);
  except
    On E:Exception do
      raise;
  end;
end;

procedure TEcodexManejadorDeSesion.ProcesarFallaEcodex(const aExcepcion:
    Exception);
var
  mensajeFalla: string;
const
  _NO_ECONTRADO = 0;
  _ERROR_ECODEX_EMISOR_NO_INSCRITO = 'Emisor no encontrado';
begin
  mensajeFalla := aExcepcion.Message;

  if AnsiPos(_ERROR_ECODEX_EMISOR_NO_INSCRITO, mensajeFalla) > _NO_ECONTRADO then
    raise EPACEmisorNoInscritoException.Create(mensajeFalla, 0, 0, False);

  TManejadorErroresComunesHelper.LanzarExcepcionSiDetectaFallaInternet(aExcepcion);

  // Si llegamos aqui y no se proceso ningun otro error generamos un error gen�rico de credenciales
  raise EPACErrorGenericoDeAccesoException.Create('Error al acceder a Ecodex:' + mensajeFalla, 0, 0, True);
end;



end.
