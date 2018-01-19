{ ******************************************************* }
{ }
{ TFacturaElectronica }
{ }
{ Copyright (C) 2017 Bambu Code SA de CV }
{ }
{ ******************************************************* }

unit Facturacion.PAC.Ecodex;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
  Facturacion.Comprobante,
  EcodexWsComun,
  EcodexWsTimbrado,
  EcodexWsClientes,
  EcodexWsCancelacion,
  PAC.Ecodex.ManejadorDeSesion,
  System.Generics.Collections,
  System.SysUtils;

type

  TProveedorEcodex = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
  private
    fCredencialesPAC: TFacturacionCredencialesPAC;
    fCredencialesIntegrador: TFacturacionCredencialesPAC;
    fDominioWebService: string;
    fManejadorDeSesion: TEcodexManejadorDeSesion;
    fwsClientesEcodex: IEcodexServicioClientes;
    fwsTimbradoEcodex: IEcodexServicioTimbrado;
    fwsCancelacionEcodex: IEcodexServicioCancelacion;
    function ExtraerNodoTimbre(const aComprobanteXML: TEcodexComprobanteXML)
      : TCadenaUTF8;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    procedure ProcesarFallasEspecificasDeEcodex(const aExcepcion: Exception);
    function TimbrarDocumentoPrimeraVez(const aComprobante : IComprobanteFiscal;
                                        const aTransaccion: Int64): TCadenaUTF8; overload;
    function TimbrarDocumentoPrimeraVez(const aXML : TCadenaUTF8;
                                        const aTransaccion: Int64): TCadenaUTF8; overload;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
        const aCredencialesPAC, aCredencialesIntegrador:
        TFacturacionCredencialesPAC; const aTransaccionInicial: Int64);
    function ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
    function CancelarDocumento(const aUUID: TCadenaUTF8): Boolean;
    function CancelarDocumentos(const aUUIDS: TListadoUUID):
        TListadoCancelacionUUID;
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aIdTransaccionAUsar: Int64): TCadenaUTF8; overload;
    function TimbrarDocumento(const aXML : TCadenaUTF8; const aIdTransaccionAUsar : Int64): TCadenaUTF8; overload;
    function ObtenerAcuseDeCancelacion(const aUUID: string): string;
    function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string;
    function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8;
  end;

const
  _LONGITUD_UUID = 36;

implementation

uses Classes,
  xmldom,
  Facturacion.Tipos,
  Soap.XSBuiltIns,
  XMLIntf,
{$IFDEF CODESITE}
  CodeSiteLogging,
{$ENDIF}
  System.RegularExpressions,
{$IF Compilerversion >= 20}
  Xml.Win.Msxmldom,
{$ELSE}
  Msxmldom,
{$IFEND}
  XMLDoc;

destructor TProveedorEcodex.Destroy;
begin
  if Assigned(fManejadorDeSesion) then
    FreeAndNil(fManejadorDeSesion);

  inherited;
end;

procedure TProveedorEcodex.AfterConstruction;
begin
  inherited;
  {$IFDEF CODESITE}
  CodeSite.Send('Se creo instancia de PAC Ecodex');
  {$ENDIF}
end;

{ TProveedorEcodex }

procedure TProveedorEcodex.Configurar(const aWsTimbrado, aWsClientes,
    aWsCancelacion: string; const aCredencialesPAC, aCredencialesIntegrador:
    TFacturacionCredencialesPAC; const aTransaccionInicial: Int64);
begin
  Assert(aWsTimbrado <> '', 'La instancia aWsTimbrado no debio ser vacia');
  fDominioWebService      := aWsTimbrado;
  fCredencialesPAC        := aCredencialesPAC;
  fCredencialesIntegrador := aCredencialesIntegrador;

  fManejadorDeSesion := TEcodexManejadorDeSesion.Create(fDominioWebService,
    aTransaccionInicial);
  fManejadorDeSesion.AsignarCredenciales(fCredencialesPAC);

  // Incializamos las instancias de los WebServices
  fwsTimbradoEcodex := GetWsEcodexTimbrado(False, aWsTimbrado +
    '/ServicioTimbrado.svc');
  fwsClientesEcodex := GetWsEcodexClientes(False, aWsClientes +
    '/ServicioClientes.svc');
  fwsCancelacionEcodex := GetWsEcodexCancelacion(False, aWsCancelacion +
    '/ServicioCancelacion.svc');
end;

function TProveedorEcodex.ExtraerNodoTimbre(const aComprobanteXML
  : TEcodexComprobanteXML): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
const
  _REGEX_TIMBRE = '<tfd:TimbreFiscalDigital.*?/>';
begin
  Assert(aComprobanteXML <> nil,
    'La respuesta del servicio de timbrado fue nula');
{$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
  contenidoComprobanteXML := aComprobanteXML.DatosXML;
{$ELSE}
  contenidoComprobanteXML := UTF8Encode(aComprobanteXML.DatosXML);
{$IFEND}
  Result := TRegEx.Match(contenidoComprobanteXML, _REGEX_TIMBRE).Value;
  Assert(Result <> '', 'El XML del timbre estuvo vacio');
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

        33196:
          raise ESATNoIdentificadoException.Create(mensajeExcepcion,
            numeroErrorSAT, False);
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

    // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
    // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
    raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
  end;
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

      Result := ExtraerNodoTimbre(respuestaTimbrado.ComprobanteXML);
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

      Result := ExtraerNodoTimbre(respuestaTimbrado.ComprobanteXML);
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


function TProveedorEcodex.TimbrarDocumento(const aXML : string; const aIdTransaccionAUsar : Int64): TCadenaUTF8;
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
      respuestaObtenerTimbre := fWsTimbradoEcodex.ObtenerTimbrado(solicitudObtenerTimbre);

      // 5. Extraemos las propiedades del timbre de la respuesta del WebService
      Result := ExtraerNodoTimbre(respuestaObtenerTimbre.ComprobanteXML);

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

function TProveedorEcodex.CancelarDocumento(const aUUID: TCadenaUTF8): Boolean;
var
  arregloUUIDs: TListadoUUID;
  resultadoCancelacion : TListadoCancelacionUUID;
  solicitudCancelacion: TEcodexSolicitudCancelacion;
  respuestaCancelacion: TEcodexRespuestaCancelacion;
  tokenDeUsuario : String;
begin
  Assert(Length(aUUID) = _LONGITUD_UUID, 'La longitud del UUID debio de ser de ' + IntToStr(_LONGITUD_UUID));
  tokenDeUsuario                     := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

  SetLength(arregloUUIDs, 1);
  arregloUUIDs[0] := aUUID;
  resultadoCancelacion := Self.CancelarDocumentos(arregloUUIDs);
  Result := resultadoCancelacion.Items[aUUID];
end;

function TProveedorEcodex.ObtenerAcuseDeCancelacion(const aUUID: string):
    string;
var
  tokenDeUsuario: String;
  solicitudAcuse : TEcodexSolicitudAcuse;
  respuestaAcuse : TEcodexRespuestaRecuperarAcuse;
begin
  Assert(Length(aUUID) = _LONGITUD_UUID, 'La longitud del UUID debio de ser de ' + IntToStr(_LONGITUD_UUID));
  Result := '';

  // 1. Creamos la solicitud de cancelacion
  solicitudAcuse := TEcodexSolicitudAcuse.Create;

  // 2. Iniciamos una nueva sesion solicitando un nuevo token
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    try
      solicitudAcuse.UUID          := aUUID;
      solicitudAcuse.RFC           := fCredencialesPAC.RFC;
      solicitudAcuse.Token         := tokenDeUsuario;
      solicitudAcuse.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;

      respuestaAcuse := fwsCancelacionEcodex.RecuperarAcuses(solicitudAcuse);
      Result := respuestaAcuse.AcuseXML;
      respuestaAcuse.Free;
    except
      On E:Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudAcuse) then
      solicitudAcuse.Free;
  end;
end;

function TProveedorEcodex.CancelarDocumentos(const aUUIDS: TListadoUUID):
    TListadoCancelacionUUID;
var
  solicitudCancelacion: TEcodexSolicitudCancelaMultiple;
  respuestaCancelacion: TEcodexRespuestaCancelaMultiple;
  tokenDeUsuario: string;
  mensajeFalla: string;
  uuidPorCancelar, estado: String;
  I: Integer;
  arregloGuids : Array_Of_guid;
const
  // Ref: Pagina 15 de "Guia de integracion Ecodex".
  _CADENA_CANCELADO = 'Cancelado';
begin
  Assert(fwsCancelacionEcodex <> nil, 'La instancia fwsCancelacionEcodex no debio ser nula');

  if fwsTimbradoEcodex = nil then
    raise EPACNoConfiguradoException.Create
      ('No se ha configurado el PAC, favor de configurar con metodo Configurar');

  // 1. Creamos la solicitud de timbrado
  solicitudCancelacion := TEcodexSolicitudCancelaMultiple.Create;
  Result               := TDictionary<String, Boolean>.Create;

  try
    // 2. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

    // 3. Asignamos los parametros de cancelacion
    SetLength(arregloGuids, Length(aUUIDS));
    for I := 0 to Length(aUUIDS) - 1 do
    begin
      uuidPorCancelar := Uppercase(aUUIDS[I]);
      arregloGuids[I] := uuidPorCancelar;
    end;

    solicitudCancelacion.ListaCancelar := TEcodexListaCancelar2.Create;
    solicitudCancelacion.ListaCancelar.guid := arregloGuids;
    solicitudCancelacion.RFC := TXSString.Create;
    solicitudCancelacion.RFC.XSToNative(fCredencialesPAC.RFC);

    solicitudCancelacion.Token := TXSString.Create;
    solicitudCancelacion.Token.XSToNative(tokenDeUsuario);

    solicitudCancelacion.TransaccionID             := fManejadorDeSesion.NumeroDeTransaccion;

    try
      mensajeFalla := '';

      // 4. Realizamos la solicitud de cancelacion
      respuestaCancelacion := fwsCancelacionEcodex.CancelaMultiple(solicitudCancelacion);

      // Convertir el array que regresa Ecodex al dictionary que
      // estamos regresando
      for I := 0 to Length(respuestaCancelacion.Resultado.ResultadoCancelacion) - 1 do
      begin
        estado := respuestaCancelacion.Resultado.ResultadoCancelacion[I].Estatus.NativeToXS;
        Result.Add(Uppercase(respuestaCancelacion.Resultado.ResultadoCancelacion[I].UUID),
                   estado = _CADENA_CANCELADO);
      end;


      respuestaCancelacion.Free;
    except
      On E: Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudCancelacion) then
      solicitudCancelacion.Free;
  end;
end;

procedure TProveedorEcodex.ProcesarFallasEspecificasDeEcodex(const aExcepcion:
    Exception);
var
  mensajeExcepcion: String;
const
  _ECODEX_ACUSE_NO_ENCONTRADO             = 'Acuse de cancelacion del documento no encontrado';
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
    end;
  end;

  if AnsiPos(_ECODEX_SIN_FOLIOS, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoSinFoliosDisponiblesException.Create(_ECODEX_SIN_FOLIOS, 0, EEcodexFallaValidacionException(aExcepcion).Numero, False);

  if AnsiPos(_ECODEX_ACUSE_NO_ENCONTRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACAcuseNoEncontradoException.Create(_ECODEX_ACUSE_NO_ENCONTRADO, 0, EEcodexFallaValidacionException(aExcepcion).Numero, False);

  if AnsiPos(_ECODEX_DOCUMENTO_CANCELAR_NO_ENCONTRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise PACCancelacionFallidaDocumentoNoEncontradoException.Create(_ECODEX_DOCUMENTO_CANCELAR_NO_ENCONTRADO, 0,
                                                                     EEcodexFallaValidacionException(aExcepcion).Numero, False);

  // TBD: https://github.com/bambucode/eleventa/issues/1721
 { if AnsiPos(_ECODEX_ALTA_EMISOR_CORREO_USADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorCorreoUsadoException.Create('El correo asignado ya está en uso por otro emisor.', 0, 97, False);

  if AnsiPos(_ECODEX_EMISOR_PREVIAMENTE_DADO_DE_ALTA, mensajeExcepcion) > 0 then
    raise EEcodexAltaEmisorExistenteException.Create('El emisor ya está dado de alta con un integrador.', 0, 98, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_REPETIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorExistenteException.Create('El emisor ya está dado de alta.', 0, 98, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_RFC_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorRFCInvalidoException.Create('El RFC del emisor no es válido.', 0, 890, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_CORREO_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorCorreoInvalidoException.Create('El correo del emisor no es válido.', 0, 891, False);        }


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
