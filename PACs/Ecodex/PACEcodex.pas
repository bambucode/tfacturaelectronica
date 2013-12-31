{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la implementación para timbrado de CFDI del proveedor
  Ecodex (http://www.ecodex.com.mx)

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit PACEcodex;

interface

uses Classes,
     xmldom,
     XMLIntf,
     msxmldom,
     XMLDoc,
     SysUtils,
     ProveedorAutorizadoCertificacion,
     FacturaTipos,
     FETimbreFiscalDigital,
     PAC.Ecodex.ManejadorDeSesion,
     EcodexWsTimbrado,
     EcodexWsClientes,
     FeCFD;

type

 // Excepciones específicas de Ecodex
 EEcodexNoExisteAliasDeLlaveException = class(EPACException); // Error código 1001

 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Se lanza cuando se intenta dar de alta a un emisor(cliente) que
 ///	  previamente fue dado de alta.
 ///	</summary>
 {$ENDREGION}
 EEcodexAltaEmisorExistenteException = class(EPACException);
 EEcodexAltaEmisorCorreoUsadoException = class(EPACException);
 EEcodexAltaEmisorRFCInvalidoException = class(EPACException);
 EECodexAltaEmisorCorreoInvalidoException = class(EPACException);

 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "Comercio
 ///	  Digital" (<see href="http://www.comercio-digital.com.mx" />)
 ///	</summary>
 {$ENDREGION}
 TPACEcodex = class(TProveedorAutorizadoCertificacion)
 private
  fDominioWebService : string;
  fIdTransaccionInicial: Integer;
  fCredenciales : TFEPACCredenciales;
  fCredencialesIntegrador : TFEPACCredenciales;
  wsClientesEcodex : IEcodexServicioClientes;
  wsTimbradoEcodex: IEcodexServicioTimbrado;
  fManejadorDeSesion : TEcodexManejadorDeSesion;
  function AsignarTimbreDeRespuestaDeEcodex(const aComprobanteTimbrado: TEcodexComprobanteXML): TFETimbre;
  procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
  function TimbrarPorPrimeraVez(const aDocumento: TTipoComprobanteXML; const
      aIdTransaccionAUsar: Integer): TFETimbre;
protected
  function getNombre() : string; override;
public
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales, aCredencialesIntegrador: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; overload; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML; const aIdTransaccionAUsar: Integer): TFETimbre; overload;
  function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Integer): TFETimbre;
  function AgregaCliente(const aNuevoEmisor: TFEContribuyente): string; override;
  function SaldoCliente(const aRFC: String) : Integer; override;
  property Nombre : String read getNombre;
  constructor Create(const aDominioWebService : String); overload;
  constructor Create(const aDominioWebService : String; const aIdTransaccionInicial: Integer); overload;
end;

implementation

uses {$IF Compilerversion >= 20} Soap.InvokeRegistry, {$IFEND}
     EcodexWsComun,
     ManejadorDeErroresComunes,
     feCFDv32,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     FacturaReglamentacion;

constructor TPACEcodex.Create(const aDominioWebService : String);
begin
  inherited;

  // Obtenemos el dominio del WS que usaremos
  fDominioWebService := aDominioWebService;
end;

constructor TPACEcodex.Create(const aDominioWebService : String; const aIdTransaccionInicial: Integer);
begin
  Create(aDominioWebService);
  // Establecemos el id de transaccion inicial para todas las operaciones
  fIdTransaccionInicial := aIdTransaccionInicial;
end;

procedure TPACEcodex.AfterConstruction;
begin
  // Obtenemos una instancia del WebService de Timbrado de Ecodex
  wsTimbradoEcodex := GetWsEcodexTimbrado(False, fDominioWebService + '/ServicioTimbrado.svc');
  wsClientesEcodex := GetWsEcodexClientes(False, fDominioWebService + '/ServicioClientes.svc');
  fManejadorDeSesion := TEcodexManejadorDeSesion.Create(fDominioWebService, fIdTransaccionInicial);
end;

function TPACEcodex.getNombre() : string;
begin
  Result := 'Ecodex';
end;

destructor TPACEcodex.Destroy();
begin
  FreeAndNil(fManejadorDeSesion);
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  inherited;
end;

procedure TPACEcodex.AsignarCredenciales(const aCredenciales,
    aCredencialesIntegrador: TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
  fCredencialesIntegrador := aCredencialesIntegrador;
  fManejadorDeSesion.AsignarCredenciales(aCredenciales);
end;

function TPACEcodex.AsignarTimbreDeRespuestaDeEcodex(const
    aComprobanteTimbrado: TEcodexComprobanteXML): TFETimbre;
var
  comprobanteTimbrado: IFEXMLComprobanteV32;
  nodoXMLTimbre: IFEXMLtimbreFiscalDigital;
  documentoXMLTimbrado, documentoXMLTimbre: TXmlDocument;
begin
  Assert(aComprobanteTimbrado <> nil, 'La respuesta del servicio de timbrado fue nula');

  // Creamos el documento XML para almacenar el XML del comprobante completo que nos regresa Ecodex
  documentoXMLTimbrado := TXMLDocument.Create(nil);
  documentoXMLTimbrado.Active := True;
  documentoXMLTimbrado.Version := '1.0';
  documentoXMLTimbrado.Encoding := 'utf-8';
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
  documentoXMLTimbrado.XML.Text:=aComprobanteTimbrado.DatosXML;
  {$ELSE}
  documentoXMLTimbrado.XML.Text:=UTF8Encode(aComprobanteTimbrado.DatosXML);
  {$IFEND}

  documentoXMLTimbrado.Active:=True;

  // Convertimos el XML a la interfase del CFD v3.2
  comprobanteTimbrado := GetComprobanteV32(documentoXMLTimbrado);

  // Extraemos solamente el nodo del timbre
  Assert(IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.HasChildNodes,
        'No se recibio correctamente el timbre');
  Assert(IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes.Count = 1,
        'Se debio haber tenido solo el timbre como complemento');

  // Creamos el documento XML solamente del timbre
  documentoXMLTimbre := TXMLDocument.Create(nil);
  documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes.First.XML;
  documentoXMLTimbre.Active := True;

  // Convertimos el XML del nodo a la interfase del Timbre v3.2
  nodoXMLTimbre := GetTimbreFiscalDigital(documentoXMLTimbre);

  // Extraemos las propiedades del timbre para regresarlas en el tipo TFETimbre
  Result.Version:=nodoXMLTimbre.Version;
  Result.UUID:=nodoXMLTimbre.UUID;
  Result.FechaTimbrado:=TFEReglamentacion.DeFechaHoraISO8601(nodoXMLTimbre.FechaTimbrado);
  Result.SelloCFD:=nodoXMLTimbre.SelloCFD;
  Result.NoCertificadoSAT:=nodoXMLTimbre.NoCertificadoSAT;
  Result.SelloSAT:=nodoXMLTimbre.SelloSAT;
  Result.XML := nodoXMLTimbre.XML;
end;

procedure TPACEcodex.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion: string;
const
  // Cadena del error: "no existen Folios disponibles para el contribuyente"
  _ECODEX_SIN_FOLIOS_DISPONIBLES = '(800)';

  _ECODEX_FUERA_DE_SERVICIO = '(22)';
  _ERROR_ECODEX_PREVIAMENTE_TIMBRADO = '(96)';
  _ECODEX_ALTA_EMISOR_CORREO_USADO = '(97)';
  _ECODEX_ALTA_EMISOR_REPETIDO = '(98)';
  // El rfc del Documento no corresponde al del encabezado.
  _ECODEX_RFC_NO_CORRESPONDE = '(500)';
  _ECODEX_ALTA_EMISOR_RFC_INVALIDO = '(890)';
  _ECODEX_ALTA_EMISOR_CORREO_INVALIDO = '(891)';
  _ECODEX_SERVICIO_NO_DISPONIBLE = 'Servicio no disponible';
  _ECODEX_VERSION_NO_SOPORTADA = 'El driver no soporta esta version de cfdi';
  _NO_ENCONTRADO = 0;
begin
  mensajeExcepcion := aExcepcion.Message;

  if (aExcepcion Is EEcodexFallaValidacionException) Or
     (aExcepcion Is EEcodexFallaServicioException) Or
     (aExcepcion is EEcodexFallaSesionException) then
  begin
      if (aExcepcion Is EEcodexFallaValidacionException)  then
      begin
        mensajeExcepcion := 'EFallaValidacionException (' + IntToStr(EEcodexFallaValidacionException(aExcepcion).Numero) + ') ' +
                        EEcodexFallaValidacionException(aExcepcion).Descripcion;
      end;

      if (aExcepcion Is EEcodexFallaServicioException)  then
      begin
        mensajeExcepcion := 'EFallaServicioException (' + IntToStr(EEcodexFallaServicioException(aExcepcion).Numero) + ') ' +
                        EEcodexFallaServicioException(aExcepcion).Descripcion;
      end;

       if (aExcepcion Is EEcodexFallaSesionException)  then
      begin
        mensajeExcepcion := 'EEcodexFallaSesionException (' + IntToStr(EEcodexFallaSesionException(aExcepcion).Estatus) + ') ' +
                            EEcodexFallaSesionException(aExcepcion).Descripcion;
      end;
  end;

  if AnsiPos(_ECODEX_FUERA_DE_SERVICIO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACServicioNoDisponibleException.Create(mensajeExcepcion, 0, 22, True);

  if AnsiPos(_ERROR_SAT_XML_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise  ETimbradoXMLInvalidoException.Create(mensajeExcepcion, 301, 0, False);

  if AnsiPos(_ERROR_SAT_SELLO_EMISOR_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoSelloEmisorInvalidoException.Create(mensajeExcepcion, 302, 0, False);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoCertificadoNoCorrespondeException.Create(mensajeExcepcion, 303, 0, False);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_REVOCADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoCertificadoRevocadoException.Create(mensajeExcepcion, 304, 0, False);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoFechaEmisionSinVigenciaException.Create(mensajeExcepcion, 305, 0, False);

  if AnsiPos(_ERROR_SAT_LLAVE_NO_CORRESPONDE, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoLlaveInvalidaException.Create(mensajeExcepcion, 306, 0, False);

  if AnsiPos(_ERROR_SAT_PREVIAMENTE_TIMBRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoPreviamenteException.Create(mensajeExcepcion, 307, 0, False);

  if AnsiPos(_ERROR_ECODEX_PREVIAMENTE_TIMBRADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoPreviamenteException.Create(mensajeExcepcion, 0, 96, False);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoCertificadoApocrifoException.Create(mensajeExcepcion, 308, 0, False);

  if AnsiPos(_ERROR_SAT_FECHA_FUERA_DE_RANGO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoFechaGeneracionMasDe72HorasException.Create(mensajeExcepcion, 401, 0, False);

  if AnsiPos(_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoRegimenEmisorNoValidoException.Create(mensajeExcepcion, 402, 0, False);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise ETimbradoFechaEnElPasadoException.Create(mensajeExcepcion, 403, 0, False);

  if AnsiPos(_ECODEX_RFC_NO_CORRESPONDE, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoRFCNoCorrespondeException.Create('El RFC del documento y el del emisor no corresponden', 0, 500,
                                                      False);

  if AnsiPos(_ECODEX_VERSION_NO_SOPORTADA, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoVersionNoSoportadaPorPACException.Create('Esta version de CFDI no es soportada por ECODEX:' +
                                                              mensajeExcepcion, 0, 0, False);

  if AnsiPos(_ECODEX_SIN_FOLIOS_DISPONIBLES, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EPACTimbradoSinFoliosDisponiblesException.Create(mensajeExcepcion, 0, 800, True);

  {$REGION 'Excepciones de alta de emisores'}

  if AnsiPos(_ECODEX_ALTA_EMISOR_CORREO_USADO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorCorreoUsadoException.Create('El correo asignado ya está en uso por otro emisor', 0, 97, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_REPETIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorExistenteException.Create('El emisor ya está dado de alta', 0, 98, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_RFC_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorRFCInvalidoException.Create('El RFC del emisor no es válido', 0, 890, False);

  if AnsiPos(_ECODEX_ALTA_EMISOR_CORREO_INVALIDO, mensajeExcepcion) > _NO_ENCONTRADO then
    raise EEcodexAltaEmisorCorreoInvalidoException.Create('El correo del emisor no es válido', 0, 891, False);

  {$ENDREGION}

  TManejadorErroresComunes.LanzarExcepcionSiDetectaFallaInternet(aExcepcion);

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
  raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TPACEcodex.CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean;
var
  mensajeFalla, tokenDeUsuario: String;
  solicitudCancelacion : TEcodexSolicitudCancelacion;
  respuestaCancelacion : TEcodexRespuestaCancelacion;

  function ExtraerUUID(const aDocumentoTimbrado: TTipoComprobanteXML) : String;
  const
    _LONGITUD_UUID = 36;
  begin
      Result:=Copy(aDocumentoTimbrado,
                   AnsiPos('UUID="', aDocumentoTimbrado) + 6,
                   _LONGITUD_UUID);
  end;

begin
  Result := False;

  // 1. Creamos la solicitud de cancelacion
  solicitudCancelacion := TEcodexSolicitudCancelacion.Create;

  // 2. Iniciamos una nueva sesion solicitando un nuevo token
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    solicitudCancelacion.RFC := fCredenciales.RFC;
    solicitudCancelacion.Token := tokenDeUsuario;
    solicitudCancelacion.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;

    // Ecodex solo requiere que le enviemos el UUID del timbre anterior, lo extraemos para enviarlo
    solicitudCancelacion.UUID := ExtraerUUID(aDocumento);

    try
      mensajeFalla := '';
      respuestaCancelacion := wsTimbradoEcodex.CancelaTimbrado(solicitudCancelacion);

      Result := respuestaCancelacion.Cancelada;
      respuestaCancelacion.Free;
    except
      On E:Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudCancelacion) then
      solicitudCancelacion.Free;
  end;
end;

function TPACEcodex.SaldoCliente(const aRFC: String) : Integer;
var
  solicitudEdoCuenta: TEcodexSolicitudEstatusCuenta;
  respuestaEdoCuenta: TEcodexRespuestaEstatusCuenta;
  tokenDeUsuario : string;
  I: Integer;
begin
  Assert(Trim(aRFC) <> '', 'El RFC para la solicitud de saldo fue vacio');

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
      respuestaEdoCuenta := wsClientesEcodex.EstatusCuenta(solicitudEdoCuenta);
      {$IFDEF CODESITE}
        CodeSite.Send('Codigo', respuestaEdoCuenta.Estatus.Codigo);
        CodeSite.Send('Descripcion', respuestaEdoCuenta.Estatus.Descripcion);
        CodeSite.Send('Fecha de Inicio', respuestaEdoCuenta.Estatus.FechaInicio);
        CodeSite.Send('Fecha de fin', respuestaEdoCuenta.Estatus.FechaFin);
        CodeSite.Send('Timbres asignados', respuestaEdoCuenta.Estatus.TimbresAsignados);
        CodeSite.Send('Timbres disponibles', respuestaEdoCuenta.Estatus.TimbresDisponibles);
        CodeSite.Send('Num certificados cargados', Length(respuestaEdoCuenta.Estatus.Certificados));
        // Mostramos los certificados cargados
        for I := 0 to Length(respuestaEdoCuenta.Estatus.Certificados) - 1 do
        begin
          CodeSite.Send('Certificado cargado Num. ' + IntToStr(I), respuestaEdoCuenta.Estatus.Certificados[I]);
        end;
      {$ENDIF}

      // 3. Regresamos los timbres disponibles y no los asignados
      Result := respuestaEdoCuenta.Estatus.TimbresDisponibles;
    except
      On E:Exception do
         if Not (E Is EPACException) then
          ProcesarExcepcionDePAC(E)
        else
          raise;
    end;
  finally
    solicitudEdoCuenta.Free;
  end;
end;

function TPACEcodex.AgregaCliente(const aNuevoEmisor: TFEContribuyente): string;
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
  Assert(wsClientesEcodex <> nil, 'La referencia al servicio de Ecodex de clientes fue nula');
  Assert(fCredencialesIntegrador.RFC <> '', 'El RFC del integrador estuvo vacio');
  Assert(aNuevoEmisor.RFC <> '', 'El RFC del nuevo emisor estuvo vacio');
  Assert(aNuevoEmisor.Nombre <> '', 'La razon social del nuevo emisor estuvo vacia');

  solicitudRegistroCliente := TEcodexSolicitudRegistroCliente.Create;
  try
    try
      // Mandamos los dos IDs del integrador y el ID de alta de emisores
      tokenDeAltaDeEmisores := fManejadorDeSesion.ObtenerNuevoTokenAltaEmisores(fCredencialesIntegrador.RFC,
                                                                                fCredenciales.DistribuidorID,
                                                                                fCredencialesIntegrador.DistribuidorID);

      // Creamos el objeto Emisor que enviaremos
      nuevoEmisor := TEcodexNuevoEmisor.Create;
      // Al convertir el RFC a mayusculas nos evitamos errores de validación del WebService de Ecodex
      nuevoEmisor.RFC := UpperCase(aNuevoEmisor.RFC);
      nuevoEmisor.RazonSocial := aNuevoEmisor.Nombre;
      // Al convertir el correo a minúsculas nos evitamos errores de validación del WebService de Ecodex
      // ToDO: Validar con algun RegEx que el correo sea valido para evitar mandarlo al WebService si podemos
      // checar su validez antes
      nuevoEmisor.CorreoElectronico := LowerCase(aNuevoEmisor.CorreoElectronico);

      // Creamos la solicitud de registro de emisor
      solicitudRegistroCliente.Token := tokenDeAltaDeEmisores;
      solicitudRegistroCliente.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;
      solicitudRegistroCliente.Emisor := nuevoEmisor;
      solicitudRegistroCliente.RfcIntegrador := fCredencialesIntegrador.RFC;

      // Mandamos registrar al emisor
      respuestaRegistroCliente := wsClientesEcodex.Registrar(solicitudRegistroCliente);

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
    if Assigned(solicitudRegistroCliente) then
      solicitudRegistroCliente.Free;
  end;
end;

function TPACEcodex.ObtenerTimbrePrevio(const aIdTransaccionOriginal: Integer):
    TFETimbre;
var
  solicitudObtenerTimbre: TEcodexSolicitudObtenerTimbrado;
  respuestaObtenerTimbre: TEcodexRespuestaObtenerTimbrado;
  tokenDeUsuario: string;
begin
  // 1. Creamos la solicitud de obtener timbrado
  solicitudObtenerTimbre := TEcodexSolicitudObtenerTimbrado.Create;

  // 2. Generamos un nuevo token para esta peticion
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    //4. Asignamos los datos de la solicitud usando el ultimo token y transaccion usada
    solicitudObtenerTimbre.TransaccionOriginal := aIdTransaccionOriginal;
    solicitudObtenerTimbre.RFC := fCredenciales.RFC;
    solicitudObtenerTimbre.Token := tokenDeUsuario;
    solicitudObtenerTimbre.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;
    // Dejamos vacio el UUID pues vamos a obtener el timbre por transaccion
    //solicitudObtenerTimbre.UUID := '';

    try
      // 5. Realizamos la solicitud de timbre previo
      respuestaObtenerTimbre := wsTimbradoEcodex.ObtenerTimbrado(solicitudObtenerTimbre);

      // 5. Extraemos las propiedades del timbre de la respuesta del WebService
      Result := AsignarTimbreDeRespuestaDeEcodex(respuestaObtenerTimbre.ComprobanteXML);
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

function TPACEcodex.TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre;
begin
  // Si se uso este metodo obtenemos el siguiente numero de transaccion del manejador de sesion
  Result := TimbrarDocumento(aDocumento, fManejadorDeSesion.NumeroDeTransaccion);
end;

function TPACEcodex.TimbrarDocumento(const aDocumento: TTipoComprobanteXML; const aIdTransaccionAUsar: Integer): TFETimbre;
var
  documentoTimbradoPreviamente : Boolean;
const
  _ECODEX_DOCUMENTO_TIMBRADO_NO_ENCONTRADO = 'EFallaValidacionException (505)';
begin
  documentoTimbradoPreviamente := False;
  try
    Result := TimbrarPorPrimeraVez(aDocumento, aIdTransaccionAUsar);
  except
    // Si es una falla de timbrado previo, la evitamos lanzar, cualquier otra falla la re-lanzamos
    On E:ETimbradoPreviamenteException do
      documentoTimbradoPreviamente := True
    else
      raise;
  end;

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
           raise ETimbradoPreviamenteException.Create(E.Message, 0, 505, False)
        else
          raise;
      end;
    end;
  end;
end;

function TPACEcodex.TimbrarPorPrimeraVez(const aDocumento: TTipoComprobanteXML;
    const aIdTransaccionAUsar: Integer): TFETimbre;
var
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario: string;
  mensajeFalla: string;
begin
  // 1. Creamos la solicitud de timbrado
  solicitudTimbrado := TSolicitudTimbradoEcodex.Create;

  try
    // 2. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

    // 3. Asignamos el documento XML
    solicitudTimbrado.ComprobanteXML := TEcodexComprobanteXML.Create;
    solicitudTimbrado.ComprobanteXML.DatosXML := aDocumento;
    solicitudTimbrado.RFC := fCredenciales.RFC;
    solicitudTimbrado.Token := tokenDeUsuario;
    solicitudTimbrado.TransaccionID := aIdTransaccionAUsar;

    try
      mensajeFalla := '';

      // 4. Realizamos la solicitud de timbrado
      respuestaTimbrado := wsTimbradoEcodex.TimbraXML(solicitudTimbrado);

      // 5. Extraemos las propiedades del timbre de la respuesta del WebService
      Result := AsignarTimbreDeRespuestaDeEcodex(respuestaTimbrado.ComprobanteXML);
      respuestaTimbrado.Free;
    except
      On E:Exception do
        ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudTimbrado) then
      solicitudTimbrado.Free;
  end;
end;

end.
