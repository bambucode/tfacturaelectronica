  { ******************************************************* }
{                                                         }
{ TFacturaElectronica                                     }
{                                                         }
{ Copyright (C) 2022 Bambu Code SA de CV                  }
{                                                         }
{ ******************************************************* }

unit Facturacion.PAC.Ecodex;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
  Facturacion.Comprobante,
  EcodexWsComun,
  EcodexWsTimbrado,
  EcodexWsClientes,
  PAC.Ecodex.ManejadorDeSesion,
{$IF CompilerVersion >= 23}
  Soap.SOAPHTTPTrans, System.Net.HttpClient,
  System.Generics.Collections,
  System.Classes,
  System.SysUtils
{$ELSE}
  {$IF CompilerVersion >= 23}
   Generics.Collections,
  {$IFEND}
  Classes,
  SysUtils
{$IFEND}
  ;

type

  TProveedorEcodex = class(TProveedorAutorizadoCertificacionBase, IProveedorAutorizadoCertificacion)
  private
    fCredencialesPAC: TFacturacionCredencialesPAC;
    fCredencialesIntegrador: TFacturacionCredencialesPAC;
    fDistribuidorIDCancelaciones: string;
    fDominioWebService: string;
    fManejadorDeSesion: TEcodexManejadorDeSesion;
    fwsClientesEcodex: IEcodexServicioClientes;
    fwsTimbradoEcodex: IEcodexServicioTimbrado;
    fWsVerificarTimbradoEcodex : IEcodexServicioTimbrado;
    fParametros: TStrings;
    fURLServicioRestCancelacion: string;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    procedure ProcesarFallasEspecificasDeEcodex(const aExcepcion: Exception);
    function TimbrarDocumentoPrimeraVez(const aComprobante : IComprobanteFiscal;
                                        const aTransaccion: Int64): TCadenaUTF8; overload;
    function TimbrarDocumentoPrimeraVez(const aXML : TCadenaUTF8;
                                        const aTransaccion: Int64): TCadenaUTF8; overload;

     {$IF CompilerVersion >= 23}
    procedure ManejarHttpSoapError(const HTTPReqResp: THTTPReqResp;
                                   const HTTPResponse: IHTTPResponse; const Error: ESOAPHTTPException;
                                   var Action: TSOAPHttpErrorAction);
    function ObtenerTokenParaCancelacion: String;
    {$IFEND}
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
        const aCredencialesPAC, aCredencialesIntegrador:
        TFacturacionCredencialesPAC; const aTransaccionInicial: Int64); override;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer; override;
    function CancelarDocumento(const aSolicitudCancelacion: TSolicitudCancelacionCFD;
                               const aArchivoCertificado : String = '';
                               const aArchivoLLavePrivada : String = '';
                               const aContrasenaLlavePrivada: String = ''): Boolean; override;
    function CancelarDocumentos(const aUUIDS: TListadoUUID):
        TListadoCancelacionUUID; override;
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aIdTransaccionAUsar: Int64): TCadenaUTF8; overload; override;
    function TimbrarDocumento(const aXML : TCadenaUTF8; const aIdTransaccionAUsar : Int64): TCadenaUTF8; overload; override;
    function ObtenerAcuseDeCancelacion(const aSolicitudAcuse: TSolicitudAcuseCancelacionCFD): string; override;
    function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string; override;
    function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8; override;
    property DistribuidorIDCancelaciones: string read FDistribuidorIDCancelaciones
        write FDistribuidorIDCancelaciones;
  end;

const
  _LONGITUD_UUID = 36;

implementation

uses
  Facturacion.Tipos,
  Facturacion.FirmaCancelacion,
  REST.Client,
  Facturacion.Helper,
  REST.Types,
  REST.Authenticator.Basic,
  System.DateUtils,
  System.Hash,
{$IFDEF CODESITE}
  CodeSiteLogging,
{$ENDIF}

{$IF Compilerversion >= 23}
  Soap.XSBuiltIns,
  System.RegularExpressions,
  Xml.xmldom,
  Xml.XMLIntf,
  Xml.Win.Msxmldom,
  Xml.XMLDoc
{$ELSE}
  xmldom,
  XSBuiltIns,
  XMLIntf,
  Msxmldom,
  XMLDoc,
  {$IF Compilerversion >= 22}
   RegularExpressions
  {$ELSE}
   PerlRegEx
  {$IFEND}
{$IFEND}
  ;

destructor TProveedorEcodex.Destroy;
begin
  if Assigned(fManejadorDeSesion) then
    FreeAndNil(fManejadorDeSesion);
  inherited;
end;

procedure TProveedorEcodex.AfterConstruction;
begin
  inherited;

  // Insertamos un manejador de errores generico para requests SOAP
  // Ref: https://stackoverflow.com/questions/59666531/how-to-get-at-response-headers-from-thttpreqresp
  // NOTA: Solo funciona Delphi 10.3 o mayores
  {$IF Compilerversion >= 23}
    {$IFNDEF ELEVENTA}
      SetOnHttpError(ManejarHttpSoapError);
    {$ENDIF}
  {$IFEND}
end;

{$IF Compilerversion >= 23}
procedure TProveedorEcodex.ManejarHttpSoapError(const HTTPReqResp: THTTPReqResp;
  const HTTPResponse: IHTTPResponse; const Error: ESOAPHTTPException;
  var Action: TSOAPHttpErrorAction);
var
  respuestaWebService : String;
  exValidacion : EEcodexFallaValidacionException;
  exSesion     : EEcodexFallaSesionException;

  function ExtraerTextoEntreTags(const aTexto, aTagInicial, aTagFinal: String) : String;
  begin
    Result := Copy(aTexto,
                   AnsiPos(aTagInicial,aTexto) + Length(aTagInicial),
                   AnsiPos(aTagFinal,aTexto) - AnsiPos(aTagInicial,aTexto)-Length(aTagInicial))
  end;
begin
  respuestaWebService := HTTPResponse.ContentAsString();

  {$IFDEF CODESITE}
  CodeSite.Send('Error', Error.Message);
  CodeSite.Send('StatusText', HTTPResponse.StatusText);
  CodeSite.Send('StatusCode', HTTPResponse.StatusCode);
  CodeSite.Send('Content', respuestaWebService);
  {$ENDIF}

  // HACK: Convertimos el contenido de la respuesta del WebService
  // en su respectiva excepcion
  if AnsiPos('FallaValidacion', respuestaWebService) > 0 then
  begin
    exValidacion :=  EEcodexFallaValidacionException.Create;
    exValidacion.Numero      := StrToInt(ExtraerTextoEntreTags(respuestaWebService, '<Numero>', '</Numero>'));
    exValidacion.Descripcion := ExtraerTextoEntreTags(respuestaWebService, '<Descripcion>', '</Descripcion>');
    exValidacion.RFC         := ExtraerTextoEntreTags(respuestaWebService, '<RFC>', '</RFC>');
    raise exValidacion;
  end;

  if AnsiPos('FallaSesion', respuestaWebService) > 0 then
  begin
    exSesion :=  EEcodexFallaSesionException.Create;
    exSesion.Estatus      := StrToInt(ExtraerTextoEntreTags(respuestaWebService, '<Estatus>', '</Estatus>'));
    exSesion.Descripcion := ExtraerTextoEntreTags(respuestaWebService, '<Descripcion>', '</Descripcion>');
    exSesion.RFC         := ExtraerTextoEntreTags(respuestaWebService, '<RFC>', '</RFC>');
    if LowerCase(exSesion.Descripcion).Contains('aun no tiene folios asignados') then
      exSesion.Descripcion := exSesion.Descripcion + ' o vencieron';

    raise exSesion;
  end;
end;
{$IFEND}


{ TProveedorEcodex }

procedure TProveedorEcodex.Configurar(
    const aWsTimbrado, aWsClientes, aWsCancelacion: string;
    const aCredencialesPAC, aCredencialesIntegrador: TFacturacionCredencialesPAC;
    const aTransaccionInicial: Int64);
begin
  Assert(aWsTimbrado <> '', 'La instancia aWsTimbrado no debio ser vacia');
  fDominioWebService      := aWsTimbrado;
  fCredencialesPAC        := aCredencialesPAC;
  fCredencialesIntegrador := aCredencialesIntegrador;
  // Por default será el mismo
  fDistribuidorIDCancelaciones := fCredencialesIntegrador.DistribuidorID;

  // En produccion, el WebService de seguridad es distinto al de timbrado (2022)
  fManejadorDeSesion := TEcodexManejadorDeSesion.Create(aWsClientes, aTransaccionInicial);
  fManejadorDeSesion.AsignarCredenciales(fCredencialesPAC);

  // Incializamos las instancias de los WebServices
  fwsTimbradoEcodex := GetWsEcodexTimbrado(False, aWsTimbrado +
    '/ServicioTimbrado.svc');
  fwsClientesEcodex := GetWsEcodexClientes(False, aWsClientes +
    '/ServicioClientes.svc');

  // Creamos una copia del WS de timbrado especificar para consultar
  // timbres previos, ya que el servidor de produccion de timbrado solo
  // soporta el metodo TimbraXML
  fWsVerificarTimbradoEcodex := GetWsEcodexTimbrado(False, aWsClientes +
    '/ServicioTimbrado.svc');

  fURLServicioRestCancelacion := aWsCancelacion;

  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_ID, aCredencialesPAC.RFC);
  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_CLAVE, aCredencialesPAC.Clave);
  AsignarParametro(PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID, aCredencialesPAC.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID, aCredencialesIntegrador.RFC);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE, aCredencialesIntegrador.Clave);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID, aCredencialesIntegrador.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_TRANSACCION_INICIAL, IntToStr(aTransaccionInicial));

  AsignarParametro(PAC_PARAM_SVC_URL_API, aWsTimbrado);

  AsignarParametro(PAC_PARAM_SVC_URL_API_TIMBRADO, aWsTimbrado+
    '/ServicioTimbrado.svc');
  AsignarParametro(PAC_PARAM_SVC_URL_API_CLIENTES, aWsTimbrado+
    '/ServicioClientes.svc');
end;

function TProveedorEcodex.ObtenerSaldoTimbresDeCliente
  (const aRFC: String): Integer;
var
  solicitudEdoCuenta: TEcodexSolicitudEstatusCuenta;
  respuestaEdoCuenta: TEcodexRespuestaEstatusCuenta;
  tokenDeUsuario: string;
  I: Integer;
begin
  Assert(fDominioWebService <> '', 'EL dominio no puede estar vacio');
  Assert(Trim(aRFC) <> '', 'El RFC para la solicitud de saldo fue vacio');
  Assert(fManejadorDeSesion <> nil,
    'La instancia fManejadorDeSesion no debio ser nula');
  Assert(fwsClientesEcodex <> nil,
    'La instancia fwsClientesEcodex no debio ser nula');

  Result := 0;

  // 1. Creamos la solicitud del edo de cuenta
  solicitudEdoCuenta := TEcodexSolicitudEstatusCuenta.Create;

  // 2. Iniciamos una nueva sesion solicitando un nuevo token
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    solicitudEdoCuenta.RFC := aRFC;
    solicitudEdoCuenta.Token := tokenDeUsuario;
    solicitudEdoCuenta.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;

    try
      respuestaEdoCuenta := fwsClientesEcodex.EstatusCuenta(solicitudEdoCuenta);
      {$IFDEF CODESITE}
      CodeSite.Send('Codigo', respuestaEdoCuenta.Estatus.Codigo);
      CodeSite.Send('Descripcion', respuestaEdoCuenta.Estatus.Descripcion);
      CodeSite.Send('Fecha de Inicio', respuestaEdoCuenta.Estatus.FechaInicio);
      CodeSite.Send('Fecha de fin', respuestaEdoCuenta.Estatus.FechaFin);
      CodeSite.Send('Timbres asignados',
        respuestaEdoCuenta.Estatus.TimbresAsignados);
      CodeSite.Send('Timbres disponibles',
        respuestaEdoCuenta.Estatus.TimbresDisponibles);
      CodeSite.Send('Num certificados cargados',
        Length(respuestaEdoCuenta.Estatus.Certificados));
      // Mostramos los certificados cargados
      for I := 0 to Length(respuestaEdoCuenta.Estatus.Certificados) - 1 do
      begin
        CodeSite.Send('Certificado cargado Num. ' + IntToStr(I),
          respuestaEdoCuenta.Estatus.Certificados[I]);
      end;
      {$ENDIF}
      // 3. Regresamos los timbres disponibles y no los asignados
      Result := respuestaEdoCuenta.Estatus.TimbresDisponibles;
    except
      On E: Exception do
        if Not(E Is EPACException) then
          ProcesarExcepcionDePAC(E)
        else
          raise;
    end;
  finally
    // fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsClientes;
    // fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsClientes;
    solicitudEdoCuenta.Free;
  end;
end;

procedure TProveedorEcodex.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion: string;
  numeroErrorSAT: Integer;
const
  _ERROR_RFC_FRANJA_FRONTERIZA           = 'CFDI33196 El RFC no se encuentra registrado para aplicar el Est';
  _ERROR_CODIGO_POSTAL_FRANJA_FRONTERIZA = 'postal no corresponde a Franja Fronteriza.';
  _ERROR_CLAVE_PROD_FRANJA_FRONTERIZA    = 'Franja Fronteriza para la clave de producto o servicio';
begin
  mensajeExcepcion := aExcepcion.Message;

  if (aExcepcion Is EEcodexFallaValidacionException) Or
     (aExcepcion Is EEcodexFallaServicioException) Or
     (aExcepcion is EEcodexFallaSesionException) then
  begin
    if (aExcepcion Is EEcodexFallaValidacionException) then
    begin
      mensajeExcepcion := EEcodexFallaValidacionException(aExcepcion).Descripcion;

      numeroErrorSAT   := EEcodexFallaValidacionException(aExcepcion).Numero;

      case numeroErrorSAT of
        0..32999:
        begin
          // Estos son errores que no son del SAT, asumimos son del PAC:
          ProcesarFallasEspecificasDeEcodex(aExcepcion);
        end;
        // Errores técnicos donde la librería no creo bien el XML
        33101, 33102, 33106, 33111, 33116, 33126, 33127, 33128,
          33139, 33143, 33150:
          raise ESATErrorTecnicoXMLException.Create(mensajeExcepcion,
            numeroErrorSAT, False);

        33105:
          raise ESATErrorEnCertificadoException.Create(mensajeExcepcion, numeroErrorSAT, False);

        // Algun valor que debía venir de un catálogo no fue correcto
        33104, 33112, 33120, 33121, 33125, 33130, 33136, 33140, 33142, 33145,
          33156, 33164, 33165, 33172, 33185:
          raise ESATValorNoEnCatalogoException.Create(mensajeExcepcion,
            numeroErrorSAT, False);

        // Problema donde los datos del emisor no son correctos
        33131:
          raise ESATDatoEmisorIncorrectoException.Create(mensajeExcepcion,
            numeroErrorSAT, False);

        // Problema donde los datos del receptor no son correctos
        33132, 33133, 33134, 33135:
          raise ESATDatoReceptorIncorrectoException.Create(mensajeExcepcion,
            numeroErrorSAT, False);

        33155, 33159: raise ESAImpuestoTasaIncorrectaException.Create(mensajeExcepcion, numeroErrorSAT, False);

        33141: raise EUsoCFDIIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, False);

        // Errores de validacion, reglas de negocio, etc.
        33107, 33108, 33109, 33110, 33113, 33114, 33115, 33118, 33122, 33123,
          33124, 33137, 33138, 33144, 33147, 33149, 33152, 33154,
          33157, 33158, 33161, 33166, 33167, 33169, 33170, 33171, 33174,
          33176, 33177, 33178, 33103, 33179, 33180, 33181, 33182, 33183, 33184,
          33186, 33187, 33189, 33190, 33192, 33193, 33195:
          raise ESATProblemaDeLlenadoException.Create(mensajeExcepcion,
            numeroErrorSAT, False);

        // Errores posibles con el mismo codigo:
        // 1. El RFC no se encuentra registrado para aplicar el Estímulo Franja Fronteriza.
        // 2. No aplica Estímulo Franja Fronteriza para la clave de producto o servicio
        // 3. El código postal no corresponde a Franja Fronteriza.
        33196:
        begin
          if mensajeExcepcion.Contains(_ERROR_RFC_FRANJA_FRONTERIZA) then
            raise ESATRFCNoPerteneceFronteraException.Create(mensajeExcepcion, numeroErrorSAT, False)
          else if mensajeExcepcion.Contains(_ERROR_CODIGO_POSTAL_FRANJA_FRONTERIZA) then
            raise ESATCodigoPostalNoPerteneceFronteraException.Create(mensajeExcepcion, numeroErrorSAT, False)
          else if mensajeExcepcion.Contains(_ERROR_CLAVE_PROD_FRANJA_FRONTERIZA) then
            raise ESATEstimuloFronteraNoAplicaAlProductoException.Create(mensajeExcepcion, numeroErrorSAT, False)
          else
            raise ESATNoIdentificadoException.Create(mensajeExcepcion, numeroErrorSAT, False);
        end;
        40138: raise ESATNombreEmisorIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, True);
        40145:
        begin
          raise ESATNombreReceptorIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, True);
        end;
        40148:
        begin
          raise ESATDomicilioFiscalReceptorIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, True);
        end;
        40158:
        begin
          raise ESATRegimenFiscalReceptorNoCorrespondeException.Create(mensajeExcepcion, numeroErrorSAT, False);
        end;
        40141:
        begin
          raise ESATRegimenFiscalEmisorNoCorrespondeException.Create(mensajeExcepcion, numeroErrorSAT, False);
        end;
        40161:
        begin
          raise ESATUsoCFDIReceptorNoCorrespondeRegimen.Create(mensajeExcepcion, numeroErrorSAT, False);
        end;
        40143:
        begin
          raise ESATReceptorRFCNoExisteEnLCO.Create(mensajeExcepcion, numeroErrorSAT, False);
        end;
      else
        raise ESATErrorGenericoException.Create('ESATErrorGenericoException (' +
          IntToStr(EEcodexFallaValidacionException(aExcepcion).Numero) + ') ' +
          mensajeExcepcion, numeroErrorSAT, False);
      end;
    end;

    ProcesarFallasEspecificasDeEcodex(aExcepcion);

    if (aExcepcion Is EEcodexFallaServicioException) then
    begin
      mensajeExcepcion := 'EFallaServicioException (' +
        IntToStr(EEcodexFallaServicioException(aExcepcion).Numero) + ') ' +
        EEcodexFallaServicioException(aExcepcion).Descripcion;
    end;

    if (aExcepcion Is EEcodexFallaSesionException) then
    begin
      mensajeExcepcion := 'EEcodexFallaSesionException (' +
        IntToStr(EEcodexFallaSesionException(aExcepcion).Estatus) + ') ' +
        EEcodexFallaSesionException(aExcepcion).Descripcion;
    end;
  end;

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
  raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TProveedorEcodex.TimbrarDocumentoPrimeraVez(const aComprobante
  : IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario: string;
  mensajeFalla: string;
begin
  if fwsTimbradoEcodex = nil then
    raise EPACNoConfiguradoException.Create
      ('No se ha configurado el PAC, favor de configurar con metodo Configurar');

  // 1. Creamos la solicitud de timbrado
  solicitudTimbrado := TSolicitudTimbradoEcodex.Create;

  try
    // 2. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

    AsignarParametro(PAC_PARAM_SESION_ID,tokenDeUsuario);

    // 3. Asignamos el documento XML
    solicitudTimbrado.ComprobanteXML          := TEcodexComprobanteXML.Create;
    solicitudTimbrado.ComprobanteXML.DatosXML := aComprobante.Xml;
    solicitudTimbrado.RFC                     := fCredencialesPAC.RFC;
    solicitudTimbrado.Token                   := tokenDeUsuario;
    solicitudTimbrado.TransaccionID           := aTransaccion;

    try
      mensajeFalla := '';

      // 4. Realizamos la solicitud de timbrado
      respuestaTimbrado := fwsTimbradoEcodex.TimbraXML(solicitudTimbrado);

      Result := ExtraerNodoTimbre(respuestaTimbrado.ComprobanteXML.DatosXML);
      respuestaTimbrado.Free;
    except
      On E: Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudTimbrado) then
      solicitudTimbrado.Free;
  end;

end;

function TProveedorEcodex.TimbrarDocumentoPrimeraVez(const aXML : TCadenaUTF8;
                                    const aTransaccion: Int64): TCadenaUTF8;
var
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario: string;
  mensajeFalla: string;
begin
  if fwsTimbradoEcodex = nil then
    raise EPACNoConfiguradoException.Create
      ('No se ha configurado el PAC, favor de configurar con metodo Configurar');

  // 1. Creamos la solicitud de timbrado
  solicitudTimbrado := TSolicitudTimbradoEcodex.Create;

  try
    // 2. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

    // 3. Asignamos el documento XML
    solicitudTimbrado.ComprobanteXML          := TEcodexComprobanteXML.Create;
    solicitudTimbrado.ComprobanteXML.DatosXML := aXml;
    solicitudTimbrado.RFC                     := fCredencialesPAC.RFC;
    solicitudTimbrado.Token                   := tokenDeUsuario;
    solicitudTimbrado.TransaccionID           := aTransaccion;

    try
      mensajeFalla := '';

      // 4. Realizamos la solicitud de timbrado
      respuestaTimbrado := fwsTimbradoEcodex.TimbraXML(solicitudTimbrado);

      Result := ExtraerNodoTimbre(respuestaTimbrado.ComprobanteXML.DatosXML);
      respuestaTimbrado.Free;
    except
      On E: Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudTimbrado) then
      solicitudTimbrado.Free;
  end;

end;

function TProveedorEcodex.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aIdTransaccionAUsar: Int64): TCadenaUTF8;
var
  documentoTimbradoPreviamente : Boolean;
const
  _ECODEX_DOCUMENTO_TIMBRADO_NO_ENCONTRADO = 'EFallaValidacionException (505)';
begin
  documentoTimbradoPreviamente := False;

  try
    try
      Result := TimbrarDocumentoPrimeraVez(aComprobante, aIdTransaccionAUsar);
    except
      // Si es una falla de timbrado previo, la evitamos lanzar, cualquier otra falla la re-lanzamos
      On E:EPACTimbradoPreviamenteException do
      begin
        {$IFDEF CODESITE}
        CodeSite.SendWarning('Se detectó documento timbrado previamente, obteniendo timbre previo...');
        {$ENDIF}
        documentoTimbradoPreviamente := True;
      end else
        raise;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsTimbrado;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsTimbrado;
  end;

  try
    // Si hubo una falla porque ya habiamos timbrado el documento previamente, tratamos de obtener
    // el timbre previo
    if documentoTimbradoPreviamente then
    begin
      try
        Result := ObtenerTimbrePrevio(aIdTransaccionAUsar);
      except
        On E:Exception do
        begin
          // Como fallamos al obtener el timbre previo re-lanzamos la excepcion de timbrado previamente
          if AnsiPos(_ECODEX_DOCUMENTO_TIMBRADO_NO_ENCONTRADO, E.Message) > 0 then
             raise EPACTimbradoPreviamenteException.Create(E.Message, 0, 505, False)
          else
            raise;
        end;
      end;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsTimbrado;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsTimbrado;
  end;
end;


function TProveedorEcodex.TimbrarDocumento(const aXML : TCadenaUTF8; const aIdTransaccionAUsar : Int64): TCadenaUTF8;
var
  documentoTimbradoPreviamente : Boolean;
const
  _ECODEX_DOCUMENTO_TIMBRADO_NO_ENCONTRADO = 'EFallaValidacionException (505)';
begin
  documentoTimbradoPreviamente := False;

  try
    try
      Result := TimbrarDocumentoPrimeraVez(aXML, aIdTransaccionAUsar);
    except
      // Si es una falla de timbrado previo, la evitamos lanzar, cualquier otra falla la re-lanzamos
      On E:EPACTimbradoPreviamenteException do
      begin
        {$IFDEF CODESITE}
        CodeSite.SendWarning('Se detectó documento timbrado previamente, obteniendo timbre previo...');
        {$ENDIF}
        documentoTimbradoPreviamente := True;
      end else
        raise;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsTimbrado;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsTimbrado;
  end;

  try
    // Si hubo una falla porque ya habiamos timbrado el documento previamente, tratamos de obtener
    // el timbre previo
    if documentoTimbradoPreviamente then
    begin
      try
        Result := ObtenerTimbrePrevio(aIdTransaccionAUsar);
      except
        On E:Exception do
        begin
          // Como fallamos al obtener el timbre previo re-lanzamos la excepcion de timbrado previamente
          if AnsiPos(_ECODEX_DOCUMENTO_TIMBRADO_NO_ENCONTRADO, E.Message) > 0 then
             raise EPACTimbradoPreviamenteException.Create(E.Message, 0, 505, False)
          else
            raise;
        end;
      end;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsTimbrado;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsTimbrado;
  end;

end;

function TProveedorEcodex.ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8;
var
  solicitudObtenerTimbre: TEcodexSolicitudObtenerTimbrado;
  respuestaObtenerTimbre: TEcodexRespuestaObtenerTimbrado;
  tokenDeUsuario: string;
begin
  Assert(fWsTimbradoEcodex <> nil, 'La instancia fWsTimbradoEcodex no debio ser nula');
  // 1. Creamos la solicitud de obtener timbrado
  solicitudObtenerTimbre := TEcodexSolicitudObtenerTimbrado.Create;

  // 2. Generamos un nuevo token para esta peticion
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    //4. Asignamos los datos de la solicitud usando el ultimo token y transaccion usada
    solicitudObtenerTimbre.TransaccionOriginal := aIdTransaccionOriginal;
    solicitudObtenerTimbre.RFC                 := fCredencialesPAC.RFC;
    solicitudObtenerTimbre.Token               := tokenDeUsuario;
    solicitudObtenerTimbre.TransaccionID       := fManejadorDeSesion.NumeroDeTransaccion;


    try
      // 5. Realizamos la solicitud de timbre previo
      respuestaObtenerTimbre := fWsVerificarTimbradoEcodex.ObtenerTimbrado(solicitudObtenerTimbre);

      // 5. Extraemos las propiedades del timbre de la respuesta del WebService
      Result := ExtraerNodoTimbre(respuestaObtenerTimbre.ComprobanteXML.DatosXML);

      respuestaObtenerTimbre.Free;
    except
      On E:Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudObtenerTimbre) then
      solicitudObtenerTimbre.Free;
  end;
end;

function TProveedorEcodex.AgregarCliente(const aRFC, aRazonSocial, aCorreo:
    String): string;
var
  nuevoEmisor : TEcodexNuevoEmisor;
  solicitudRegistroCliente : TEcodexSolicitudRegistroCliente;
  respuestaRegistroCliente: TEcodexRespuestaRegistro;
  tokenDeAltaDeEmisores : String;
const
  // Segun documento "Guia de integracion con Ecodex_v2.0.1.pdf"
  _CADENA_ALTA_EXITOSA = 'Activo';
begin
  Assert(fManejadorDeSesion <> nil, 'El manejador de sesion de Ecodex es nulo');
  Assert(fWsClientesEcodex <> nil, 'La referencia al servicio de Ecodex de clientes fue nula');
  Assert(fCredencialesIntegrador.RFC <> '', 'El RFC del integrador estuvo vacio');
  Assert(aRFC <> '', 'El RFC del nuevo emisor estuvo vacio');
  Assert(aRazonSocial <> '', 'La razon social del nuevo emisor estuvo vacia');

  solicitudRegistroCliente := TEcodexSolicitudRegistroCliente.Create;
  try
    try
      // Mandamos los dos IDs del integrador y el ID de alta de emisores
      tokenDeAltaDeEmisores := fManejadorDeSesion.ObtenerNuevoTokenAltaEmisores(fCredencialesIntegrador.RFC,
                                                                                fCredencialesPAC.DistribuidorID,
                                                                                fCredencialesIntegrador.DistribuidorID);

      // Creamos el objeto Emisor que enviaremos
      nuevoEmisor := TEcodexNuevoEmisor.Create;
      // Al convertir el RFC a mayusculas nos evitamos errores de validación del WebService de Ecodex
      nuevoEmisor.RFC                        := UpperCase(aRFC);
      nuevoEmisor.RazonSocial                := aRazonSocial;
      // Al convertir el correo a minúsculas nos evitamos errores de validación del WebService de Ecodex
      nuevoEmisor.CorreoElectronico          := LowerCase(aCorreo);

      // Creamos la solicitud de registro de emisor
      solicitudRegistroCliente.Token         := tokenDeAltaDeEmisores;
      solicitudRegistroCliente.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;
      solicitudRegistroCliente.Emisor        := nuevoEmisor;
      solicitudRegistroCliente.RfcIntegrador := fCredencialesIntegrador.RFC;

      // Mandamos registrar al emisor
      respuestaRegistroCliente := fWsClientesEcodex.Registrar(solicitudRegistroCliente);

      Assert(respuestaRegistroCliente.Respuesta <> nil, 'La respuesta de registro de emisor fue nula!');

      {$IFDEF CODESITE}
      CodeSite.Send('Respuesta registro emisor', respuestaRegistroCliente.Respuesta.Estatus);
      CodeSite.Send('Clave certificado', respuestaRegistroCliente.Respuesta.ClaveCertificado);
      {$ENDIF}

      // Si fue exitosa regresamos el token para la alta de certificados
      Result := respuestaRegistroCliente.Respuesta.ClaveCertificado;
      respuestaRegistroCliente.Free;
    except
      // Si ocurrio cualquier error procesamos la excepcion
      On E:Exception do
        if Not (E Is EPACException) then
          ProcesarExcepcionDePAC(E)
        else
          raise;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsClientes;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsClientes;
    if Assigned(solicitudRegistroCliente) then
      solicitudRegistroCliente.Free;
  end;

end;


function TProveedorEcodex.ObtenerTokenParaCancelacion: String;
var
  fechaUTC: TDateTime;

  function GetUTC(dt: TDateTime): TDateTime;
  begin
    result := TTimeZone.Local.ToUniversalTime(dt);
  end;

begin

  {El servicio requiere de autenticación tipo ‘basic’ mediante la cabecera ‘Authorization’ y el
   valor debe ser el valor base64 del Rfc del integrador, dos puntos: y el valor generado mediante
   una digestión sha256 del id privado del integrador, un caracter pipe | y la fecha actual (UTC)
   en formato yyyyMMdd|HHmm. Cada token generado tiene una vigencia de 10 minutos.}
  fechaUTC := GetUTC(Now());

  Result := System.Hash.THashSHA2.GetHashString(Format('%s|%s|%s',
                                                  [fCredencialesPAC.DistribuidorID,
                                                   FormatDateTime('yyyymmdd', fechaUTC),
                                                   FormatDateTime('hhnn', fechaUTC)]),
                                                   THashSHA2.TSHA2Version.SHA256);
end;

function TProveedorEcodex.CancelarDocumento(const aSolicitudCancelacion: TSolicitudCancelacionCFD;
                                           const aArchivoCertificado : String = '';
                                           const aArchivoLLavePrivada : String = '';
                                           const aContrasenaLlavePrivada: String = ''): Boolean;
var
  firmaCancelacion: IFirmaCancelacion;
  xmlFirmaCancelacion : TCadenaUTF8;
  restClient: TRESTClient;
  restRequest: TRESTRequest;
  restAuth: THTTPBasicAuthenticator;
  tokenAuth, rfcEmisor: String;
const
  _CODIGO_ERROR_CANCELACION_DUPLICADA = 'API122';
begin
  // Validamos la solicitud
  Assert(aSolicitudCancelacion.RFCEmisor <> '', 'Por favor especifica el RFC del emisor que esta cancelando');
  Assert(Length(aSolicitudCancelacion.UUID) = _LONGITUD_UUID, 'La longitud del UUID a cancelar debio de ser de ' + IntToStr(_LONGITUD_UUID));
  Assert(aSolicitudCancelacion.Motivo <> '', 'El motivo de cancelacion no puede estar vacio');

  firmaCancelacion := TFirmaCancelacion.Create;

  firmaCancelacion.Configurar(aArchivoCertificado,
                             aArchivoLLavePrivada,
                             aContrasenaLlavePrivada);


  rfcEmisor := aSolicitudCancelacion.RFCEmisor;
  // 1. Generamos la firma de cancelacion
  xmlFirmaCancelacion := firmaCancelacion.GenerarFirmaCancelacion(rfcEmisor,
                                                                   TFacturacionHelper.ComoFechaISO8601(Now),
                                                                   aSolicitudCancelacion.UUID,
                                                                   aSolicitudCancelacion.Motivo,
                                                                   aSolicitudCancelacion.UUIDSustituto);


  try
    restAuth := THTTPBasicAuthenticator.Create(fCredencialesIntegrador.RFC, // Usuario
                                               ObtenerTokenParaCancelacion()); // Contraseña


    restClient :=TRESTClient.Create(nil);
    with restClient do
    begin
      Authenticator := restAuth;
      Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
      AcceptCharset := 'utf-8, *;q=0.8';
      BaseURL := fURLServicioRestCancelacion + '/v1/cancelaciones/enviar/' + rfcEmisor;
      ContentType := 'application/x-www-form-urlencoded';
    end;

    restRequest := TRESTRequest.Create(nil);
    with restRequest do
    begin
      Client := restClient;
      Method := rmPOST;
      SynchronizedEvents := False
    end;

    // Agregamos al cuerpo del mensaje el XML de la firma de cancelacion
    restRequest.Body.Add (xmlFirmaCancelacion, ctAPPLICATION_XML);
    restRequest.Execute;

    {$IFDEF CODESITE}
    CodeSite.Send('',restRequest.Response.StatusCode);
    CodeSite.Send(restRequest.Response.StatusText);
    CodeSite.Send(restRequest.Response.content);
    {$ENDIF}

    Result := False;

    // ToDO: Falta documentar muchos mas errores y excepciones
    case restRequest.Response.StatusCode of
      202: Result := True; // Exitosa
      401:
        raise EPACCredencialesIncorrectasException.Create(restRequest.Response.content,
                                                          0, 0, False);
      403: // Integrador sin acceso al API
        raise Exception.Create(restRequest.Response.StatusText);
      404: // Posiblemente cancelacion duplicada
        begin
          if restRequest.Response.content.Contains(_CODIGO_ERROR_CANCELACION_DUPLICADA) then
            raise EPACCancelacionPeticionDuplicadaException.Create(restRequest.Response.content, 0, 0, False)
          else
            raise EPACErrorGenericoException.Create(restRequest.Response.content, 0, 0, False);
        end;
      305: // Certificado no valido para RfcEmisor?
        raise Exception.Create(restRequest.Response.StatusText);
    end;
  finally
    restAuth.Free;
    restClient.Free;
    restRequest.Free;
  end;

end;

function TProveedorEcodex.ObtenerAcuseDeCancelacion(const aSolicitudAcuse: TSolicitudAcuseCancelacionCFD):
    string;
var
  restClient: TRESTClient;
  restRequest: TRESTRequest;
  restAuth: THTTPBasicAuthenticator;
  tokenAuth: String;
begin
  // Validamos la solicitud
  Assert(aSolicitudAcuse.RFCEmisor <> '', 'Por favor especifica el RFC del emisor');
  Assert(Length(aSolicitudAcuse.UUID) = _LONGITUD_UUID, 'La longitud del UUID a obtener acuse debio de ser de ' + IntToStr(_LONGITUD_UUID));

  try
    restAuth := THTTPBasicAuthenticator.Create(fCredencialesIntegrador.RFC, // Usuario
                                               ObtenerTokenParaCancelacion()); // Contraseña


    restClient :=TRESTClient.Create(nil);
    with restClient do
    begin
      Authenticator := restAuth;
      Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
      AcceptCharset := 'utf-8, *;q=0.8';
      BaseURL := Format(fURLServicioRestCancelacion + '/v1/cancelaciones/acuse/%s/%s',
                        [aSolicitudAcuse.RFCEmisor,
                         aSolicitudAcuse.UUID]);
    end;

    restRequest := TRESTRequest.Create(nil);
    with restRequest do
    begin
      Client := restClient;
      Method := rmGET;
      SynchronizedEvents := False
    end;

    restRequest.Execute;

    {$IFDEF CODESITE}
    CodeSite.Send('',restRequest.Response.StatusCode);
    CodeSite.Send(restRequest.Response.StatusText);
    CodeSite.Send(restRequest.Response.content);
    {$ENDIF}

    case restRequest.Response.StatusCode of
      200:
        // Recibimos el XML del documento cancelado
        Result := restRequest.Response.content;

      201: // El acuse aun no se genera ...
        raise EPACCancelacionAcuseNoDisponibleAunException.Create(restRequest.Response.content,
                                                                  0,
                                                                  restRequest.Response.StatusCode,
                                                                  True);

      404:
        raise EPACAcuseNoEncontradoException.Create(restRequest.Response.content,
                                                    0,
                                                    restRequest.Response.StatusCode,
                                                    False);
    else
        // Cualquier otro error lo manejamos como genérico
        raise EPACErrorGenericoException.Create(restRequest.Response.content,
                                                0,
                                                restRequest.Response.StatusCode,
                                                False);
    end;
  finally
    restAuth.Free;
    restClient.Free;
    restRequest.Free;
  end;
end;

function TProveedorEcodex.CancelarDocumentos(const aUUIDS: TListadoUUID):
    TListadoCancelacionUUID;
begin
  raise Exception.Create('No implementado');
end;

procedure TProveedorEcodex.ProcesarFallasEspecificasDeEcodex(const aExcepcion:
    Exception);
var
  mensajeExcepcion: String;
const
  _ECODEX_ACUSE_NO_ENCONTRADO             = 'Acuse de cancelacion del documento no encontrado';
  _ECODEX_NO_EXISTE_SOLICITUD             = 'No existe solicitud, no es posible recuperar el acuse';
  _ECODEX_ALTA_EMISOR_CORREO_USADO        = '(97)';
  _ECODEX_ALTA_EMISOR_REPETIDO            = '(98)';
  _ECODEX_ALTA_EMISOR_RFC_INVALIDO        = '(890)';
  _ECODEX_ALTA_EMISOR_CORREO_INVALIDO     = '(891)';
  _ECODEX_SERVICIO_NO_DISPONIBLE          = 'Servicio no disponible';
  _ECODEX_VERSION_NO_SOPORTADA            = 'El driver no soporta esta version de cfdi';
  _ECODEX_EMISOR_PREVIAMENTE_DADO_DE_ALTA = 'El emisor ya se encuentra dado de alta con un integrador';
  _ECODEX_SIN_FOLIOS                      = 'El contribuyente aun no tiene folios asignados';
  _ECODEX_DOCUMENTO_CANCELAR_NO_ENCONTRADO= 'NO SE ENCONTRO ALGUN DOCUMENTO A CANCELAR';

  _ECODEX_ERROR_OBTENIENDO_ACUSE          = 33;

  _NO_ENCONTRADO                          = 0;
  _ERR_SIN_CERTIFICADO_CARGADO            = 29;
  _ERR_FUERA_DE_SERVICIO2                 = 18;
  _ERR_FUERA_DE_SERVICIO                  = 22;
  _ERR_SIN_FOLIOS_DISPONIBLES             = 800;
  _ERR_LCO_FUERA_DE_LINEA                 = 1000;

  // Errores exclusivos de la alta
  _ERR_TIMBRADO_PREVIAMENTE               = 96;
  _ERR_CORREO_USADO_PREVIAMENTE           = 97;
  _ERR_EMISOR_EXISTENTE                   = 98;
  _ERR_XML_MAL_FORMADO                    = 301;
  _ERR_FECHA_INVALIDA                     = 401;
  _ERR_SIN_CERTIFICADO_VIG_CANCELAR       = 402;
  _ERR_UUID_NO_ENCONTRADO                 = 505;
begin
  mensajeExcepcion := aExcepcion.Message;

  if AnsiPos(_ECODEX_VERSION_NO_SOPORTADA, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoVersionNoSoportadaPorPACException.Create('Esta version de CFDI no es soportada por ECODEX:' +
                                                              mensajeExcepcion, 0, 0, False);


  if (aExcepcion Is EEcodexFallaValidacionException) then
  begin
    case EEcodexFallaValidacionException(aExcepcion).Numero of
      _ERR_CORREO_USADO_PREVIAMENTE : raise EPACCorreoUsadoPreviamenteException.Create(mensajeExcepcion, 0, _ERR_CORREO_USADO_PREVIAMENTE, False);
      _ERR_EMISOR_EXISTENTE         : raise EPACEmisorYaExistenteException.Create(mensajeExcepcion, 0, _ERR_EMISOR_EXISTENTE, True);
      _ERR_TIMBRADO_PREVIAMENTE     : raise EPACTimbradoPreviamenteException.Create(mensajeExcepcion, 0, _ERR_TIMBRADO_PREVIAMENTE, True);
      _ERR_UUID_NO_ENCONTRADO       : raise EPACDocumentoNoEncontradoException.Create(mensajeExcepcion, 0, _ERR_UUID_NO_ENCONTRADO, True);
      _ERR_XML_MAL_FORMADO          : raise EPACXMLMalFormadoException.Create(mensajeExcepcion, 0, _ERR_XML_MAL_FORMADO, False);
      _ERR_FECHA_INVALIDA           : raise EPACFechaInvalida.Create(mensajeExcepcion, 0, _ERR_FECHA_INVALIDA, False);
      _ERR_LCO_FUERA_DE_LINEA       : raise EPACLCOFueraDeLinea.Create(mensajeExcepcion, 0, _ERR_LCO_FUERA_DE_LINEA, False);
      _ERR_SIN_CERTIFICADO_VIG_CANCELAR : raise EPACCancelacionFallidaCertificadoNoCargadoException.Create(mensajeExcepcion, 0, _ERR_SIN_CERTIFICADO_VIG_CANCELAR, False);
    end;
  end;

  if AnsiPos(_ECODEX_SIN_FOLIOS, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoSinFoliosDisponiblesException.Create(_ECODEX_SIN_FOLIOS, 0, EEcodexFallaValidacionException(aExcepcion).Numero, False);

   if AnsiPos(_ECODEX_NO_EXISTE_SOLICITUD, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACNoExisteSolicitudCancelacionException.Create(_ECODEX_NO_EXISTE_SOLICITUD, 0, EEcodexFallaValidacionException(aExcepcion).Numero, False);

  if AnsiPos(_ECODEX_ACUSE_NO_ENCONTRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACAcuseNoEncontradoException.Create(_ECODEX_ACUSE_NO_ENCONTRADO, 0, EEcodexFallaValidacionException(aExcepcion).Numero, False);

  if AnsiPos(_ECODEX_DOCUMENTO_CANCELAR_NO_ENCONTRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACCancelacionFallidaDocumentoNoEncontradoException.Create(_ECODEX_DOCUMENTO_CANCELAR_NO_ENCONTRADO, 0,
                                                                     EEcodexFallaValidacionException(aExcepcion).Numero, False);

  if (aExcepcion Is EEcodexFallaServicioException) then
  begin
    case EEcodexFallaServicioException(aExcepcion).Numero of
      _ERR_FUERA_DE_SERVICIO, _ERR_FUERA_DE_SERVICIO2
                                    : raise EPACServicioNoDisponibleException.Create(mensajeExcepcion, 0, _ERR_FUERA_DE_SERVICIO, True);
      _ERR_SIN_CERTIFICADO_CARGADO  : raise EPACCancelacionFallidaCertificadoNoCargadoException.Create(EEcodexFallaServicioException(aExcepcion).Descripcion,
                                                                           0,
                                                                           EEcodexFallaServicioException(aExcepcion).Numero,
                                                                           False);  // NO es reintentable, al menos inmediatamente
      _ERR_SIN_FOLIOS_DISPONIBLES   : raise EPACTimbradoSinFoliosDisponiblesException.Create(mensajeExcepcion, 0, _ERR_SIN_FOLIOS_DISPONIBLES, False);
    end;
  end;

end;

end.
