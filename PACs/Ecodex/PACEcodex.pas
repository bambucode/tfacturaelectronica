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

uses HTTPSend,
     Classes,
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
     FeCFD;

type

 // Excepciones específicas de Ecodex
 EEcodexNoExisteAliasDeLlaveException = class(Exception); // Error código 1001

 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "Comercio
 ///	  Digital" (<see href="http://www.comercio-digital.com.mx" />)
 ///	</summary>
 {$ENDREGION}
 TPACEcodex = class(TProveedorAutorizadoCertificacion)
 private
  fCredenciales : TFEPACCredenciales;
  wsTimbradoEcodex: IEcodexServicioTimbrado;
  fManejadorDeSesion : TEcodexManejadorDeSesion;
  function AsignarTimbreDeRespuestaDeEcodex(const aRespuestaTimbrado:
      TEcodexRespuestaTimbrado): TFETimbre;
  procedure ProcesarCodigoDeError(aRespuestaDePAC: String);
  function getNombre() : string; override;
public
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; override;
  property Nombre : String read getNombre;
 end;

implementation

uses Soap.InvokeRegistry,
     feCFDv32,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     FacturaReglamentacion;


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

procedure TPACEcodex.AfterConstruction;
begin
  // Obtenemos una instancia del WebService de Timbrado de Ecodex
  wsTimbradoEcodex := GetWsEcodexTimbrado;
  fManejadorDeSesion := TEcodexManejadorDeSesion.Create;
end;

procedure TPACEcodex.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
  fManejadorDeSesion.AsignarCredenciales(aCredenciales);
end;

function TPACEcodex.AsignarTimbreDeRespuestaDeEcodex(const aRespuestaTimbrado:
    TEcodexRespuestaTimbrado): TFETimbre;
var
  comprobanteTimbrado: IFEXMLComprobanteV32;
  nodoXMLTimbre: IFEXMLtimbreFiscalDigital;
  documentoXMLTimbrado, documentoXMLTimbre: TXmlDocument;
begin
  Assert(aRespuestaTimbrado <> nil, 'La respuesta del servicio de timbrado fue nula');

  // Creamos el documento XML para almacenar el XML del comprobante completo que nos regresa Ecodex
  documentoXMLTimbrado := TXMLDocument.Create(nil);
  documentoXMLTimbrado.Active := True;
  documentoXMLTimbrado.Version := '1.0';
  documentoXMLTimbrado.Encoding := 'utf-8';
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
  documentoXMLTimbrado.XML.Text:=aRespuestaTimbrado.ComprobanteXML.DatosXML;
  {$ELSE}
  documentoXMLTimbrado.XML.Text:=UTF8Encode(aRespuestaTimbrado.ComprobanteXML.DatosXML);
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

procedure TPACEcodex.ProcesarCodigoDeError(aRespuestaDePAC: String);
const
  _ECODEX_FUERA_DE_SERVICIO = '(22)';
  _ECODEX_VERSION_NO_SOPORTADA = 'El driver no soporta esta version de cfdi';
  // Algunos errores no regresan código de error, los buscamos por cadena completa
  _ECODEX_RFC_NO_CORRESPONDE = 'El rfc del Documento no corresponde al del encabezado';
const
  _NO_ECONTRADO = 0;
begin
  if AnsiPos(_ECODEX_FUERA_DE_SERVICIO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise EPACServicioNoDisponibleException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_XML_INVALIDO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoXMLInvalidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_SELLO_EMISOR_INVALIDO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoSelloEmisorInvalidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoCertificadoNoCorrespondeException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_REVOCADO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoCertificadoRevocadoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoFechaEmisionSinVigenciaException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_LLAVE_NO_CORRESPONDE, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoLlaveInvalidaException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_PREVIAMENTE_TIMBRADO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoPreviamenteException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoCertificadoApocrifoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_FUERA_DE_RANGO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoFechaGeneracionMasDe72HorasException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoRegimenEmisorNoValidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoFechaEnElPasadoException.Create(aRespuestaDePAC);

  if AnsiPos(_ECODEX_RFC_NO_CORRESPONDE, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoRFCNoCorrespondeException.Create('El RFC del documento y el del emisor no corresponden');

  if AnsiPos(_ECODEX_VERSION_NO_SOPORTADA, aRespuestaDePAC) > _NO_ECONTRADO then
    raise ETimbradoVersionNoSoportadaPorPACException.Create('Esta version de CFDI no es soportada por ECODEX:' +
                                                             aRespuestaDePAC);

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  raise ETimbradoErrorGenericoException.Create(aRespuestaDePAC);
end;

function TPACEcodex.TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre;
var
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario, mensajeFalla: string;
begin
  try
    // 1. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

    // 1. Creamos la solicitud de timbrado
    solicitudTimbrado := TSolicitudTimbradoEcodex.Create;

    // 2. Asignamos el documento XML
    solicitudTimbrado.ComprobanteXML := TEcodexComprobanteXML.Create;
    solicitudTimbrado.ComprobanteXML.DatosXML := aDocumento;
    solicitudTimbrado.RFC := fCredenciales.RFC;
    solicitudTimbrado.Token := tokenDeUsuario;
    solicitudTimbrado.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;

    try
      mensajeFalla := '';

      // 3. Realizamos la solicitud de timbrado
      respuestaTimbrado := wsTimbradoEcodex.TimbraXML(solicitudTimbrado);

      // 4. Extraemos las propiedades del timbre de la respuesta del WebService
      Result := AsignarTimbreDeRespuestaDeEcodex(respuestaTimbrado)
    except
      On E:Exception do
      begin
        mensajeFalla := E.Message;

        if (E Is EFallaValidacionException) Or (E Is EFallaServicioException) then
        begin
            if (E Is EFallaValidacionException)  then
            begin
              mensajeFalla := 'EFallaValidacionException (' + IntToStr(EFallaValidacionException(E).Numero) + ') ' +
                              EFallaValidacionException(E).Descripcion;
            end;

            if (E Is EFallaServicioException)  then
            begin
              mensajeFalla := 'EFallaServicioException (' + IntToStr(EFallaServicioException(E).Numero) + ') ' +
                              EFallaServicioException(E).Descripcion;
            end;
        end;
      end;
    end;

    // Checamos si tuvimos algun mensaje de falla para lanzar nuestras propias excepciones
    if (mensajeFalla <> '') then
       ProcesarCodigoDeError(mensajeFalla);
  finally
    respuestaTimbrado.Free;
    solicitudTimbrado.Free;
  end;
end;

function TPACEcodex.CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean;
var
  timbreUUID, mensajeFalla, tokenDeUsuario: String;
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

  // 1. Iniciamos una nueva sesion solicitando un nuevo token
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    // 2. Creamos la solicitud de cancelacion
    solicitudCancelacion := TEcodexSolicitudCancelacion.Create;
    solicitudCancelacion.RFC := fCredenciales.RFC;
    solicitudCancelacion.Token := tokenDeUsuario;
    solicitudCancelacion.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;
    // Ecodex solo requiere que le enviemos el UUID del timbre anterior, lo extraemos para enviarlo
    solicitudCancelacion.UUID := ExtraerUUID(aDocumento);

    try
      mensajeFalla := '';
      respuestaCancelacion := wsTimbradoEcodex.CancelaTimbrado(solicitudCancelacion);

      Result := respuestaCancelacion.Cancelada;
    except
      On E: Exception do
      begin
         mensajeFalla := E.Message;
      end;
    end;

     if (mensajeFalla <> '') then
         ProcesarCodigoDeError(mensajeFalla);
  finally
    solicitudCancelacion.Free;
    respuestaCancelacion.Free;
  end;
end;

end.
