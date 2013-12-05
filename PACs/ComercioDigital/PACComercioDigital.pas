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
     FeCFD;

type

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
  function getNombre() : string; override;
  function ObtenerURLTimbrado: String;
  procedure ProcesarCodigoDeError(aRespuestaDePAC: String);
  function RealizarPeticionREST(const URL : string; const aDocumentoXML: TTipoComprobanteXML): TTipoComprobanteXML;
  function ValidarXML(const xmlFile : TFileName) : String; //unicamente valida la estructura del xml solo se usaria para desarrollo
public
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; override;
  property Nombre: String read getNombre;
 end;

const
  _URL_API_TIMBRADO = 'http://pruebas.comercio-digital.mx/timbre/timbrar.aspx?rfc=%s&pwd=%s';

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
//unicamente valida la estructura del xml solo se usaria para desarrollo

procedure TPACComercioDigital.ProcesarCodigoDeError(aRespuestaDePAC: String);
begin
  if AnsiPos(_ERROR_SAT_XML_INVALIDO, aRespuestaDePAC) > -1 then
    raise ETimbradoXMLInvalidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_SELLO_EMISOR_INVALIDO, aRespuestaDePAC) > -1 then
    raise ETimbradoSelloEmisorInvalidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE, aRespuestaDePAC) > -1 then
    raise ETimbradoCertificadoNoCorrespondeException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_REVOCADO, aRespuestaDePAC) > -1 then
    raise ETimbradoCertificadoRevocadoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA, aRespuestaDePAC) > -1 then
    raise ETimbradoFechaEmisionSinVigenciaException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_LLAVE_NO_CORRESPONDE, aRespuestaDePAC) > -1 then
    raise ETimbradoLlaveInvalidaException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_PREVIAMENTE_TIMBRADO, aRespuestaDePAC) > -1 then
    raise ETimbradoPreviamenteException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT, aRespuestaDePAC) > -1 then
    raise ETimbradoCertificadoApocrifoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_FUERA_DE_RANGO, aRespuestaDePAC) > -1 then
    raise ETimbradoFechaGeneracionMasDe72HorasException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO, aRespuestaDePAC) > -1 then
    raise ETimbradoRegimenEmisorNoValidoException.Create(aRespuestaDePAC);

  if AnsiPos(_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO, aRespuestaDePAC) > -1 then
    raise ETimbradoFechaEnElPasadoException.Create(aRespuestaDePAC);

  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  raise ETimbradoErrorGenericoException.Create(aRespuestaDePAC);
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
begin
  // TODO: TPACComercioDigital.CancelarDocumento
end;


end.
