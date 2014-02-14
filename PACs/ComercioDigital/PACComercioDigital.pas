{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la implementación para timbrado de CFDI del proveedor
  Comercio Digital (http://www.comercio-digital.com.mx)

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  > 11-24-2013
  Integración con PAC creada por Ing. Pablo Torres TecSisNet.net (Cd. Juárez,
  Chihuahua)
  ***************************************************************************** *}

unit PACComercioDigital;

interface

uses HTTPSend,
     SynaCode,
     Classes,
     xmldom,
     XMLIntf,
     msxmldom,
     XMLDoc,
     SysUtils,
     ProveedorAutorizadoCertificacion,
     FacturaTipos,
     FETimbreFiscalDigital,
     ComprobanteFiscal,
     FeCFDv32,
     FeCFD,
     FECancelaComercioDigital;

type
 ECDNoPeticionVacia = class(Exception); // Error código 001
 ECDTamanoPeticionGrande = class(Exception); // Error código 002
 ECDTamanoPeticionHTTPIncorrecta = class(Exception); // Error código 003
 ECDUsuarioContrasenaInvalida = class(Exception); // Error código 700,702,703,708
 ECDRFCObligacionesInvalidas = class(Exception); // Error código 803
 ECDServicioCancelacionNoDisponible = class(Exception); // Error código 900,945,946
 ECDRespuestaIncorrectaCancelacionSat = class(Exception); // Error código 949,950
 ECDErrorInternoPac = class(Exception); // Error código 332,333,334,910,951
 ECDErrorFolioPreviamenteCancelado = class(Exception); // Error código 202
 ECDErrorFolioNoCorrespondeEmisor = class(Exception); // Error código 203
 ECDErrorFolioNoAplicaCancelacion = class(Exception); // Error código 204
 ECDErrorFolioNoExiste = class(Exception); // Error código 205

 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "Comercio
 ///	  Digital" (<see href="http://www.comercio-digital.com.mx" />)
 ///	</summary>
 {$ENDREGION}
 TPACComercioDigital = class(TProveedorAutorizadoCertificacion)
 private
  fCredenciales : TFEPACCredenciales;
  fDocumentoXMLTimbrado : TXMLDocument;
  fDocumentoXMLCancelado : TXMLDocument;
  function getNombre() : string; override;
  function ObtenerURLTimbrado: String;
  function ObtenerURLCancelacion: String;
  procedure ProcesarCodigoDeError(aRespuestaDePAC: String);
  function RealizarPeticionREST(const URL : string; const aDocumentoXML: TTipoComprobanteXML): TTipoComprobanteXML;
  function RealizarCancelacionREST(const URL : string; const aDocumentoXML: TTipoComprobanteXML): TTipoComprobanteXML;
  function ValidarXML(const xmlFile : TFileName) : String; //unicamente valida la estructura del xml solo se usaria para desarrollo
public
  constructor Create();
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; override;
  property Nombre: String read getNombre;
 end;

const
  _URL_API_TIMBRADO = 'http://pruebas.comercio-digital.mx/timbre/timbrar.aspx?rfc=%s&pwd=%s';
  _URL_API_CANCELAR = 'http://pruebas.comercio-digital.mx/cancela/uuid.aspx';
  _URL_API_CANCELAR_PRM = '?rfc=%s&pwd=%s';  
implementation

uses FacturaReglamentacion;

function TPACComercioDigital.getNombre() : string;
begin
  Result := 'Comercio Digital';
end;

destructor TPACComercioDigital.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  inherited;
end;

procedure TPACComercioDigital.AfterConstruction;
begin
  inherited;
  fDocumentoXMLTimbrado := TXMLDocument.Create(nil);
  fDocumentoXMLTimbrado.Active := True;
  fDocumentoXMLCancelado := TXMLDocument.Create(nil);
  fDocumentoXMLCancelado.Active := True;
end;


procedure TPACComercioDigital.AsignarCredenciales(const aCredenciales:
    TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
end;

function TPACComercioDigital.ObtenerURLTimbrado: String;
begin
  // TODO: Pasar por URL encode estos parametros
  Result := Format(_URL_API_TIMBRADO,
                   [fCredenciales.RFC,
                    fCredenciales.Clave]);
end;

function TPACComercioDigital.ObtenerURLCancelacion: String;
begin
  // TODO: Pasar por URL encode estos parametros
  Result := Format(_URL_API_CANCELAR+_URL_API_CANCELAR_PRM,
                   [fCredenciales.RFC,
                    fCredenciales.Clave]);
end;
//unicamente valida la estructura del xml solo se usaria para desarrollo

procedure TPACComercioDigital.ProcesarCodigoDeError(aRespuestaDePAC: String);
var
  mensajeExcepcion: string;
Const
_ERROR_CD_PETICION_VACIA                           = '001';
_ERROR_CD_TAMANO_PETICION_GRANDE                   = '002';
_ERROR_CD_PETICION_HTTP_INCORRECTA                 = '003';
_ERROR_CD_USUARIO_CONTRASENA_INVALIDA              = '700';
_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_1            = '702';
_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_3            = '703';
_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_8            = '708';
_ERROR_CD_RFC_CON_OBLIGACIONES_INVALIDAS           = '306';
_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE       = '900';
_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE_1     = '945';
_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE_2     = '946';
_ERROR_CD_RESPUESTA_INCORRECTA_CANCELACION_SAT     = '949';
_ERROR_CD_RESPUESTA_INCORRECTA_CANCELACION_SAT_1   = '950';
_ERROR_CD_ERROR_INTERNO_PAC                        = '332';
_ERROR_CD_ERROR_INTERNO_PAC_1                      = '333';
_ERROR_CD_ERROR_INTERNO_PAC_2                      = '334';
_ERROR_CD_ERROR_INTERNO_PAC_3                      = '910';
_ERROR_CD_ERROR_INTERNO_PAC_4                      = '951';
_ERROR_CD_FOLIO_PREVIAMENTE_CANCELADO              = '202';
_ERROR_CD_FOLIO_NO_CORRESPONDE_RFC_EMISOR          = '203';
_ERROR_CD_FOLIO_NO_APLICA_CANCELACION              = '204';
_ERROR_CD_FOLIO_NO_EXISTE                          = '205';

begin

//  if AnsiPos(_ECODEX_FUERA_DE_SERVICIO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise EPACServicioNoDisponibleException.Create(mensajeExcepcion, 0, True);
//
//  if AnsiPos(_ERROR_SAT_XML_INVALIDO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise  ETimbradoXMLInvalidoException.Create(mensajeExcepcion, 301, False);
//
//  if AnsiPos(_ERROR_SAT_SELLO_EMISOR_INVALIDO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoSelloEmisorInvalidoException.Create(mensajeExcepcion, 302, False);
//
//  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoCertificadoNoCorrespondeException.Create(mensajeExcepcion, 303, False);
//
//  if AnsiPos(_ERROR_SAT_CERTIFICADO_REVOCADO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoCertificadoRevocadoException.Create(mensajeExcepcion, 304, False);
//
//  if AnsiPos(_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoFechaEmisionSinVigenciaException.Create(mensajeExcepcion, 305, False);
//
//  if AnsiPos(_ERROR_SAT_LLAVE_NO_CORRESPONDE, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoLlaveInvalidaException.Create(mensajeExcepcion, 306, False);
//
//  if AnsiPos(_ERROR_SAT_PREVIAMENTE_TIMBRADO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoPreviamenteException.Create(mensajeExcepcion, 307, False);
//
//  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoCertificadoApocrifoException.Create(mensajeExcepcion, 308, False);
//
//  if AnsiPos(_ERROR_SAT_FECHA_FUERA_DE_RANGO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoFechaGeneracionMasDe72HorasException.Create(mensajeExcepcion, 401, False);
//
//  if AnsiPos(_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoRegimenEmisorNoValidoException.Create(mensajeExcepcion, 402, False);
//
//  if AnsiPos(_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO, mensajeExcepcion) > _NO_ECONTRADO then
//    raise ETimbradoFechaEnElPasadoException.Create(mensajeExcepcion, 403, False);
//
//  if AnsiPos(_ECODEX_RFC_NO_CORRESPONDE, mensajeExcepcion) > _NO_ECONTRADO then
//    raise EPACTimbradoRFCNoCorrespondeException.Create('El RFC del documento y el del emisor no corresponden', 0, False);
//
//  if AnsiPos(_ECODEX_VERSION_NO_SOPORTADA, mensajeExcepcion) > _NO_ECONTRADO then
//    raise EPACTimbradoVersionNoSoportadaPorPACException.Create('Esta version de CFDI no es soportada por ECODEX:' +
//                                                              mensajeExcepcion, 0, False);

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
//  raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, True);

/// errores generados de este pac
  if AnsiPos(_ERROR_CD_PETICION_VACIA, aRespuestaDePAC) > -1 then
    raise ECDNoPeticionVacia.Create(aRespuestaDePAC+' Petición Vacia');

  if AnsiPos(_ERROR_CD_TAMANO_PETICION_GRANDE, aRespuestaDePAC) > -1 then
    raise ECDTamanoPeticionGrande.Create(aRespuestaDePAC+' Tamaño de la petición demasiado grande');

  if AnsiPos(_ERROR_CD_PETICION_HTTP_INCORRECTA, aRespuestaDePAC) > -1 then
    raise ECDTamanoPeticionHTTPIncorrecta.Create(aRespuestaDePAC+' Petición de HTTP incorrecta');

  if AnsiPos(_ERROR_CD_USUARIO_CONTRASENA_INVALIDA, aRespuestaDePAC) > -1 then
    raise ECDUsuarioContrasenaInvalida.Create(aRespuestaDePAC+' Usuario o contraseña invalida');

  if AnsiPos(_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_1, aRespuestaDePAC) > -1 then
    raise ECDUsuarioContrasenaInvalida.Create(aRespuestaDePAC+' Usuario o contraseña invalida');

  if AnsiPos(_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_3, aRespuestaDePAC) > -1 then
    raise ECDUsuarioContrasenaInvalida.Create(aRespuestaDePAC+' Usuario o contraseña invalida');

  if AnsiPos(_ERROR_CD_USUARIO_CONTRASENA_INVALIDA_8, aRespuestaDePAC) > -1 then
    raise ECDUsuarioContrasenaInvalida.Create(aRespuestaDePAC+' Usuario o contraseña invalida');

  if AnsiPos(_ERROR_CD_RFC_CON_OBLIGACIONES_INVALIDAS, aRespuestaDePAC) > -1 then
    raise ECDRFCObligacionesInvalidas.Create(aRespuestaDePAC+' El RFC no cuenta con obligaciones validas en la Lista de Contribuyentes Obligados');

  if AnsiPos(_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE, aRespuestaDePAC) > -1 then
    raise ECDServicioCancelacionNoDisponible.Create(aRespuestaDePAC+' Servicio de cancelacion del SAT no disponible (intentar mas tarde)');

  if AnsiPos(_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE_1, aRespuestaDePAC) > -1 then
    raise ECDServicioCancelacionNoDisponible.Create(aRespuestaDePAC+' Servicio de cancelacion del SAT no disponible (intentar mas tarde)');

  if AnsiPos(_ERROR_CD_SERVICIO_CANCELACION_NO_DISPONIBLE_2, aRespuestaDePAC) > -1 then
    raise ECDServicioCancelacionNoDisponible.Create(aRespuestaDePAC+' Servicio de cancelacion del SAT no disponible (intentar mas tarde)');

  if AnsiPos(_ERROR_CD_RESPUESTA_INCORRECTA_CANCELACION_SAT, aRespuestaDePAC) > -1 then
    raise ECDRespuestaIncorrectaCancelacionSat.Create(aRespuestaDePAC+' Respuesta incompleta del servicio de cancelacion del SAT (se recomienda reintentar)');

  if AnsiPos(_ERROR_CD_RESPUESTA_INCORRECTA_CANCELACION_SAT_1, aRespuestaDePAC) > -1 then
    raise ECDRespuestaIncorrectaCancelacionSat.Create(aRespuestaDePAC+' Respuesta incompleta del servicio de cancelacion del SAT (se recomienda reintentar)');

  if AnsiPos(_ERROR_CD_ERROR_INTERNO_PAC, aRespuestaDePAC) > -1 then
    raise ECDErrorInternoPac.Create(aRespuestaDePAC+' Error Interno en el servicio de Cancelación');

  if AnsiPos(_ERROR_CD_ERROR_INTERNO_PAC_1, aRespuestaDePAC) > -1 then
    raise ECDErrorInternoPac.Create(aRespuestaDePAC+' Error Interno en el servicio de Cancelación');

  if AnsiPos(_ERROR_CD_ERROR_INTERNO_PAC_2, aRespuestaDePAC) > -1 then
    raise ECDErrorInternoPac.Create(aRespuestaDePAC+' Error Interno en el servicio de Cancelación');

  if AnsiPos(_ERROR_CD_ERROR_INTERNO_PAC_3, aRespuestaDePAC) > -1 then
    raise ECDErrorInternoPac.Create(aRespuestaDePAC+' Error Interno en el servicio de Cancelación');

  if AnsiPos(_ERROR_CD_ERROR_INTERNO_PAC_4, aRespuestaDePAC) > -1 then
    raise ECDErrorInternoPac.Create(aRespuestaDePAC+' Error Interno en el servicio de Cancelación');

  if AnsiPos(_ERROR_CD_FOLIO_PREVIAMENTE_CANCELADO, aRespuestaDePAC) > -1 then
    raise ECDErrorFolioPreviamenteCancelado.Create(aRespuestaDePAC+' Folio Fiscal Previamente cancelado');

  if AnsiPos(_ERROR_CD_FOLIO_NO_CORRESPONDE_RFC_EMISOR, aRespuestaDePAC) > -1 then
    raise ECDErrorFolioNoCorrespondeEmisor.Create(aRespuestaDePAC+' Folio Fiscal no corresponde a RFC Emisor y de quien solicita Cancelación');

  if AnsiPos(_ERROR_CD_FOLIO_NO_APLICA_CANCELACION, aRespuestaDePAC) > -1 then
    raise ECDErrorFolioNoAplicaCancelacion.Create(aRespuestaDePAC+' No aplica cancelación');

  if AnsiPos(_ERROR_CD_FOLIO_NO_EXISTE, aRespuestaDePAC) > -1 then
    raise ECDErrorFolioNoExiste.Create(aRespuestaDePAC+' Folio Fiscal no existe');

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
  raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TPACComercioDigital.ValidarXML(const xmlFile : TFileName) : String;
begin
   fDocumentoXMLTimbrado.ParseOptions := [poResolveExternals, poValidateOnParse];
   try
     fDocumentoXMLTimbrado.LoadFromFile(xmlFile) ;
     fDocumentoXMLTimbrado.Active := true; //esto valida
     result := '';
   except
     on EX : EDOMParseError do
     begin
     Result:='XML Invalido: ' + Ex.Message ;
     end;
   end;
end;
 
function TPACComercioDigital.RealizarPeticionREST(const URL: string; const aDocumentoXML:
    TTipoComprobanteXML): TTipoComprobanteXML;
var
  HTTP: THTTPSend;
  resultadoAPI : TStringStream;
  respuestaDeServidor: TStrings;
  llamadoExitoso: Boolean;
begin
  // TODO: Cambiar este codigo para no depender de Synapse
  {$IF Compilerversion >= 20}
   resultadoAPI := TStringStream.Create(aDocumentoXML,TEncoding.UTF8 );
  {$ELSE}
   resultadoAPI := TStringStream.Create(aDocumentoXML);
  {$IFEND}
  HTTP := THTTPSend.Create;
  respuestaDeServidor := TStringList.Create;
  try
    // Copiamos el documento XML al Memory Stream
    resultadoAPI.WriteString(aDocumentoXML);
    HTTP.Document.CopyFrom(resultadoAPI, 0);
    llamadoExitoso:=HTTP.HTTPMethod('POST', URL);

    if llamadoExitoso then
    begin
      respuestaDeServidor.LoadFromStream(HTTP.Document);
      Result := respuestaDeServidor.Text;
    end else
      raise Exception.Create('Error al timbrar en API:' + HTTP.ResultString);
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
  end;
end;

function TPACComercioDigital.RealizarCancelacionREST(const URL: string; const aDocumentoXML:
    TTipoComprobanteXML): TTipoComprobanteXML;
function EncodeF(const Archivo: string): {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
function MemoryStreamToString(M: TMemoryStream): UTF8string; //extraida de http://stackoverflow.com/questions/732666/converting-tmemorystream-to-string-in-delphi-2009
begin
  SetString(Result, PChar(M.Memory), M.Size div SizeOf(Char));
end;
var
 {$IF Compilerversion >= 20}
  stream : TStringStream;
 {$ELSE}
  stream : TMemoryStream;
 {$IFEND}
begin
  try
 {$IF Compilerversion >= 20}
   stream := TStringStream.Create;
   stream.LoadFromFile(Archivo);
   result :=  EncodeBase64(stream.DataString);
 {$ELSE}
   stream := TMemoryStream.Create;
   stream.LoadFromFile(Archivo);
  result :=  EncodeBase64(MemoryStreamToString(stream));
 {$IFEND}
  finally
    stream.Free;
  end;
end;
  function ExtraerUUID(const aDocumentoTimbrado: TTipoComprobanteXML) : String;
  const
    _LONGITUD_UUID = 36;
  begin
      Result:=Copy(aDocumentoTimbrado,
                   AnsiPos('UUID="', aDocumentoTimbrado) + 6,
                   _LONGITUD_UUID);
  end;
var
  HTTP: THTTPSend;
  {$IF Compilerversion >= 20}
   resultadoAPI : TStringStream;
  {$ELSE}
   resultadoAPI : TMemoryStream;
  {$IFEND}
  respuestaDeServidor: TStrings;
  llamadoExitoso: Boolean;
  Res: TStrings;
begin
  // TODO: Cambiar este codigo para no depender de Synapse
  HTTP := THTTPSend.Create;
  respuestaDeServidor := TStringList.Create;
  Res:= TStringList.Create;
  try
   res.Add('POST '+_URL_API_CANCELAR+' HTTP/1.1');
   res.Add('Content-Type: text/plain');
   res.Add('Host: pruebas.comercio-digital.mx');
   res.Add('Content-Length: 3285');
   res.Add('Connection: Keep-Alive');
   res.Add('');
   res.Add('RFC ='+EncodeURL(fCredenciales.RFC));
   res.Add('UUID='+ExtraerUUID(aDocumentoXML));
   res.Add('USER='+EncodeURL(fCredenciales.RFC));
   res.Add('PWDW='+EncodeURL(fCredenciales.Clave));
   res.Add('CERT='+EncodeF(fCredenciales.Certificado.Ruta));
   res.Add('KEYF='+EncodeF(fCredenciales.Certificado.LlavePrivada.Ruta));
   res.Add('PWDK='+EncodeURL(fCredenciales.Certificado.LlavePrivada.Clave));
   res.Add('ACUS=SI');
  {$IF Compilerversion >= 20}
   resultadoAPI := TStringStream.Create;
  {$ELSE}
   resultadoAPI := TMemoryStream.Create;
  {$IFEND}
   Res.SaveToStream(resultadoAPI);
   HTTP.Document.LoadFromStream(resultadoAPI);
   llamadoExitoso:=HTTP.HTTPMethod('POST', URL);
    if llamadoExitoso then
    begin
      respuestaDeServidor.LoadFromStream(HTTP.Document);
      Result := respuestaDeServidor.Text;
    end else
      raise Exception.Create('Error al cancelar en API:' + HTTP.ResultString);
  finally
    HTTP.Free;
    respuestaDeServidor.Free;
    resultadoAPI.Free;
    Res.Free;
  end;
end;

function TPACComercioDigital.TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre;
var
  respuestaCadena: TTipoComprobanteXML;
  nodoXMLTimbre : IFEXMLtimbreFiscalDigital;
begin
  try
    // Paso 1. Mandamos solicitar el timbre por medio del API Rest de Comercio Digital
    respuestaCadena := RealizarPeticionREST(ObtenerURLTimbrado(),
                                            aDocumento);

    // Checamos haber recibido el timbrado correctamente
    if Copy(Trim(respuestaCadena),1,4)='<tfd' then
    Begin
      {$IF Compilerversion >= 20}
      fDocumentoXMLTimbrado.XML.Text:=respuestaCadena;
      {$ELSE}
      fDocumentoXMLTimbrado.XML.Text:=UTF8Encode(respuestaCadena);
      {$IFEND}

      fDocumentoXMLTimbrado.Active:=True;
      nodoXMLTimbre := GetTimbreFiscalDigital(fDocumentoXMLTimbrado);

      // Asignamos las propiedades del Timbre que vamos a regresar
      Result.Version:=nodoXMLTimbre.Version;
      Result.UUID:=nodoXMLTimbre.UUID;
      Result.FechaTimbrado:=TFEReglamentacion.DeFechaHoraISO8601(nodoXMLTimbre.FechaTimbrado);
      Result.SelloCFD:=nodoXMLTimbre.SelloCFD;
      Result.NoCertificadoSAT:=nodoXMLTimbre.NoCertificadoSAT;
      Result.SelloSAT:=nodoXMLTimbre.SelloSAT;
      Result.XML := nodoXMLTimbre.XML;
    end else
      ProcesarCodigoDeError(respuestaCadena);
  except
    On E:Exception do
    begin
        // TODO: Procesar correctamente los diferentes tipos de errores
        raise;
    end;
  end;
end;

function TPACComercioDigital.CancelarDocumento(const aDocumento:
    TTipoComprobanteXML): Boolean;
var
  Respuesta: TTipoComprobanteXML;
  NodoCancelacion: IFEXMLAcuseType;
begin
  try
    // Paso 1. Mandamos solicitar la cancelación por medio del API Rest de Comercio Digital
    respuesta := RealizarCancelacionREST(ObtenerURLCancelacion(),aDocumento);
    // Paso 2. Checamos haber recibido la cancelación correctamente
    {$IF Compilerversion >= 20}
     fDocumentoXMLCancelado.XML.Text:=respuesta;
    {$ELSE}
     fDocumentoXMLCancelado.XML.Text:=UTF8Encode(respuesta);
    {$IFEND}
     fDocumentoXMLCancelado.Active:=True;
     nodoCancelacion := GetAcuse(fDocumentoXMLCancelado);
    // Paso 3. Validamos haber recibido la cancelación correctamente
    if nodoCancelacion.Folios.EstatusUUID<>201 then
     ProcesarCodigoDeError(IntToStr(nodoCancelacion.Folios.EstatusUUID))
    else
      Result:= True;
  except
    On E:Exception do
    begin
        // TODO: Procesar correctamente los diferentes tipos de errores
        raise;
    end;
  end;
end;


constructor TPACComercioDigital.Create;
begin
  inherited;
end;

end.
