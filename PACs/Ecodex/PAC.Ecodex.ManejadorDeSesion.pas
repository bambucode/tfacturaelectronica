unit PAC.Ecodex.ManejadorDeSesion;

interface

uses EcodexWsSeguridad,
     FacturaTipos;

type

  TEcodexManejadorDeSesion = class
  private
    fCredenciales: TFEPACCredenciales;
    wsSeguridad : IEcodexServicioSeguridad;
    fNumeroTransaccion: Integer;
    function GetNumeroDeTransaccion: Integer;
    function ObtenerNuevoTokenDeServicio: String;
    procedure ProcesarFallaEcodex(const aMensajeFalla: String);
  public
    procedure AfterConstruction; override;
    procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
    function ObtenerNuevoTokenDeUsuario: String;
    property NumeroDeTransaccion: Integer read GetNumeroDeTransaccion;
  end;

implementation

uses SysUtils,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     FacturacionHashes;

procedure TEcodexManejadorDeSesion.AfterConstruction;
begin
  inherited;
  wsSeguridad := GetWsEcodexSeguridad();

  // El numero de transacción comenzará como un numero aleatorio
  // (excepto en las pruebas de unidad)
  Randomize;
  fNumeroTransaccion := Random(10000);
end;

procedure TEcodexManejadorDeSesion.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  Assert(aCredenciales.RFC <> '', 'El RFC de las credenciales estuvo vacío');
  Assert(aCredenciales.Clave <> '', 'La clave de las credenciales estuvo vacía');
  Assert(aCredenciales.DistribuidorID <> '', 'El ID de Integrador estuvo vacío');

  fCredenciales := aCredenciales;
end;

function TEcodexManejadorDeSesion.GetNumeroDeTransaccion: Integer;
begin
  Result := fNumeroTransaccion;
end;

function TEcodexManejadorDeSesion.ObtenerNuevoTokenDeServicio: String;
var
  nuevaSolicitudDeToken: TEcodexSolicitudDeToken;
  respuestaSolicitudDeToken: TEcodexRespuestaObtenerToken;
  mensajeFalla: string;
begin
  Assert(fCredenciales.RFC <> '', 'Las credenciales del PAC no fueron asignadas');
  {$IFDEF CODESITE} CodeSite.EnterMethod('ObtenerNuevoTokenDeServicio'); {$ENDIF}
  try
    nuevaSolicitudDeToken := TEcodexSolicitudDeToken.Create;
    nuevaSolicitudDeToken.RFC := fCredenciales.RFC;
    nuevaSolicitudDeToken.TransaccionID := fNumeroTransaccion;

    try
      respuestaSolicitudDeToken := wsSeguridad.ObtenerToken(nuevaSolicitudDeToken);
      {$IFDEF CODESITE} CodeSite.Send('Token de servicio obtenido', respuestaSolicitudDeToken.Token); {$ENDIF}
      Result := respuestaSolicitudDeToken.Token;
    except
      on E:Exception do
        mensajeFalla := E.Message;
    end;

    if (mensajeFalla <> '') then
      ProcesarFallaEcodex(mensajeFalla);
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
     tokenDeServicio := ObtenerNuevoTokenDeServicio();

     // El token de usuario será la combinacion del token de servicio y el ID del integrador
     // concatenados por un "pipe" codificados con el agoritmo SHA1
     Result := TFacturacionHashing.CalcularHash(fCredenciales.DistribuidorID + '|' + tokenDeServicio,
                                                haSHA1)
  except
    On E:Exception do
      raise;
  end;
end;

procedure TEcodexManejadorDeSesion.ProcesarFallaEcodex(const aMensajeFalla:
    String);
const
  _NO_ECONTRADO = 0;
  _ERROR_ECODEX_EMISOR_NO_INSCRITO = 'Emisor no encontrado';
begin
   if AnsiPos(_ERROR_ECODEX_EMISOR_NO_INSCRITO, aMensajeFalla) > _NO_ECONTRADO then
    raise EPACEmisorNoInscritoException.Create(aMensajeFalla);

   // Si llegamos aqui y no se proceso ningun otro error generamos un error genérico de credenciales
   raise EPACErrorGenericoDeAccesoException.Create('Error al acceder a Ecodex:' + aMensajeFalla);
end;



end.
