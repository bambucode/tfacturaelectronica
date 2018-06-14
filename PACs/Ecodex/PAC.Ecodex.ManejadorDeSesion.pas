{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit PAC.Ecodex.ManejadorDeSesion;

interface

//Habilitita o Deshabilita el uso de la Clase TOpenSSL Para Generar el Hash SHA1
{$DEFINE OpenSSL}

uses EcodexWsSeguridad,
     Facturacion.Comprobante,
{$IF CompilerVersion >= 23}
     {$UNDEF OpenSSL}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND}
{$IFDEF OpenSSL}
     ,Facturacion.OpenSSL
{$ENDIF}
;

type

  TEcodexManejadorDeSesion = class
  private
    fDominioWebService: String;
    fCredenciales: TFacturacionCredencialesPAC;
    wsSeguridad : IEcodexServicioSeguridad;
    fNumeroTransaccion: Int64;
  {$IFDEF OpenSSL}
    fOpenSSL: IOpenSSL;
  {$ENDIF}
    function GetNumeroDeTransaccion: Int64;
    function ObtenerNuevoTokenDeServicio(const aRFC: String): String;
    procedure ProcesarFallaEcodex(const aExcepcion: Exception);
   {$IFDEF OpenSSL}
    function GetOpenSSL: IOpenSSL;
   {$ENDIF}
  public
    constructor Create(const aDominioWebService: String; const
        aIdTransaccionInicial: Integer);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure AsignarCredenciales(const aCredenciales: TFacturacionCredencialesPAC);
    function ObtenerNuevoTokenAltaEmisores(const aRFC, aIdIntegrador,
        aIdAltaEmisores: String): String;
    function ObtenerNuevoTokenDeUsuario: String;
    property NumeroDeTransaccion: Int64 read GetNumeroDeTransaccion;
  {$IFDEF OpenSSL}
    property OpenSSL: IOpenSSL read GetOpenSSL;
  {$ENDIF}
  end;

implementation

uses
{$IF CompilerVersion >= 23}
    System.Hash,
{$IFEND}
    Facturacion.ManejadorErroresComunesWebServices,
{$IFDEF CODESITE}
    CodeSiteLogging,
{$ENDIF}
     Facturacion.ProveedorAutorizadoCertificacion;

constructor TEcodexManejadorDeSesion.Create(const aDominioWebService: String;
    const aIdTransaccionInicial: Integer);
begin
  Assert(aDominioWebService <> '', 'La instancia aDominioWebService no debio ser vacia');
  fDominioWebService := aDominioWebService;
  // Establecemos el numero de transaccion con que comenzaremos para que sea un consecutivo
  fNumeroTransaccion := aIdTransaccionInicial;
end;

destructor TEcodexManejadorDeSesion.Destroy;
begin
{$IFDEF OpenSSL}
 fOpenSSL := nil;
{$ENDIF}
 inherited;
end;

procedure TEcodexManejadorDeSesion.AfterConstruction;
begin
  inherited;
  // Obtenemos la instancia del WebService de Sesion usando el dominio especificado por el usuario
  wsSeguridad := GetWsEcodexSeguridad(False, fDominioWebService + '/ServicioSeguridad.svc');
end;

procedure TEcodexManejadorDeSesion.AsignarCredenciales(const aCredenciales: TFacturacionCredencialesPAC);
begin
  Assert(aCredenciales.RFC <> '', 'El RFC de las credenciales estuvo vacío');
  Assert(aCredenciales.DistribuidorID <> '', 'El ID de Integrador estuvo vacío');

  fCredenciales := aCredenciales;
end;

function TEcodexManejadorDeSesion.GetNumeroDeTransaccion: Int64;
begin
  Result := fNumeroTransaccion;
end;

{$IFDEF OpenSSL}
function TEcodexManejadorDeSesion.GetOpenSSL: IOpenSSL;
begin
 if not Assigned(fOpenSSL) then
    fOpenSSL := TOpenSSL.Create;
 result := fOpenSSL;
end;
{$ENDIF}

function TEcodexManejadorDeSesion.ObtenerNuevoTokenDeServicio(const aRFC:
    String): String;
var
  nuevaSolicitudDeToken: TEcodexSolicitudDeToken;
  respuestaSolicitudDeToken: TEcodexRespuestaObtenerToken;
begin
  Assert(fCredenciales.RFC <> '', 'Las credenciales del PAC no fueron asignadas');
  {$IFDEF CODESITE}
  CodeSite.EnterMethod('ObtenerNuevoTokenDeServicio');
  CodeSite.Send('Usando servidor: ' + fDominioWebService);
  {$ENDIF}
  nuevaSolicitudDeToken := TEcodexSolicitudDeToken.Create;
  try
    nuevaSolicitudDeToken.RFC := aRFC;
    nuevaSolicitudDeToken.TransaccionID := fNumeroTransaccion;

    try
      respuestaSolicitudDeToken := nil;
      respuestaSolicitudDeToken := wsSeguridad.ObtenerToken(nuevaSolicitudDeToken);
      {$IFDEF CODESITE} CodeSite.Send('Token de servicio obtenido', respuestaSolicitudDeToken.Token); {$ENDIF}
      Result := respuestaSolicitudDeToken.Token;
    except
      on E:Exception do
       ProcesarFallaEcodex(E);
    end;
  finally
    if Assigned(nuevaSolicitudDeToken) then
      FreeAndNil(nuevaSolicitudDeToken);

    if Assigned(respuestaSolicitudDeToken) then
      FreeAndNil(respuestaSolicitudDeToken);

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

     // El token de usuario será la combinacion del token de servicio y el ID del integrador
     // concatenados por un "pipe" codificados con el agoritmo SHA1
  {$IFDEF OpenSSL}
    Result := OpenSSL.CalcularSHA1( fCredenciales.DistribuidorID + '|' + tokenDeServicio );
  {$ELSE}
   {$IF CompilerVersion >= 23}
      Result := THashSHA1.GetHashString(fCredenciales.DistribuidorID + '|' + tokenDeServicio);
   {$ELSE}
     // NOTA: Soporte Nativo de SHA1 no está disponible en versiones anteriores a XE2
     // Se recomienda usar OpenSSL ($DEFINE OpenSSL}) ó el método
     // TIdHashSHA1.HashStringAsHex (Indy v10.5.x)
     // Ejemplo:
     // uses IdGlobal, IdHashSHA
     // ...
     // ...
     // var LHashSHA1: TIdHashSHA1;
     // begin
     //  LHashSHA1 := TIdHashSHA1.Create;
     //  try
     //   Result:= LHashSHA1.HashStringAsHex(fCredenciales.DistribuidorID + '|' +
     //                                      tokenDeServicio,
     //                                      {$IF CompilerVersion >= 25}IndyTextEncoding_UTF8 {$ELSE} TIdTextEncoding.UTF8{$IFEND});
     //  finally
     //   LHashSHA1.Free;
     //  end;
     // end;
      raise Exception.Create('Soporte SHA1 nativo para versiones anteriores no implementado');
   {$IFEND}
  {$ENDIF}
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

     // El token de alta de emisores será la combinacion de:
     // - El ID del integrador
     // - El ID de alta de emisores (en mayusculas forzosamente)
     // - El token de servicio
     // Todos concatenados con un pipe (|) y codificados con el agoritmo SHA1
  {$IFDEF OpenSSL}
    Result := OpenSSL.CalcularSHA1( aIdIntegrador + '|' +
                                       Uppercase(aIdAltaEmisores) + '|' +
                                       tokenDeServicio );
  {$ELSE}
   {$IF CompilerVersion >= 23}
      Result := THashSHA1.GetHashString(aIdIntegrador + '|' +
                                       Uppercase(aIdAltaEmisores) + '|' +
                                       tokenDeServicio);
   {$ELSE}
     // NOTA: Soporte Nativo de SHA1 no está disponible en versiones anteriores a XE2
     // Se recomienda usar OpenSSL ($DEFINE OpenSSL}) ó el método
     // TIdHashSHA1.HashStringAsHex (Indy v10.5.x)
     // Ejemplo:
     // uses IdGlobal, IdHashSHA
     // ...
     // ...
     // var LHashSHA1: TIdHashSHA1;
     // begin
     //  LHashSHA1 := TIdHashSHA1.Create;
     //  try
     //   Result:= LHashSHA1.HashStringAsHex(aIdIntegrador + '|' +
     //                                      Uppercase(aIdAltaEmisores) + '|' +
     //                                      tokenDeServicio,
     //                                      {$IF CompilerVersion >= 25}IndyTextEncoding_UTF8 {$ELSE} TIdTextEncoding.UTF8{$IFEND});
     //  finally
     //   LHashSHA1.Free;
     //  end;
     // end;
      raise Exception.Create('Soporte SHA1 nativo para versiones anteriores no implementado');
   {$IFEND}
  {$ENDIF}
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
  _ERROR_ECODEX_EMISOR_NO_INSCRITO           = 'Emisor no encontrado';
begin
  mensajeFalla := aExcepcion.Message;

  if AnsiPos(_ERROR_ECODEX_EMISOR_NO_INSCRITO, mensajeFalla) > _NO_ECONTRADO then
    raise EPACEmisorNoInscritoException.Create(mensajeFalla, 0, 0, False);

  TManejadorErroresComunesHelper.LanzarExcepcionSiDetectaFallaInternet(aExcepcion);

  // Si llegamos aqui y no se proceso ningun otro error generamos un error genérico de credenciales
  raise EPACErrorGenericoDeAccesoException.Create('Error al acceder a Ecodex:' + mensajeFalla, 0, 0, True);
end;



end.
