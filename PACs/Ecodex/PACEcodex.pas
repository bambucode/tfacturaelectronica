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
  fDocumentoXMLTimbrado : TXMLDocument;
  wsTimbradoEcodex: IEcodexServicioTimbrado;
  fManejadorDeSesion : TEcodexManejadorDeSesion;
  function ObtenerURLTimbrado: String;
  procedure ProcesarCodigoDeError(aRespuestaDePAC: String);
  function ValidarXML(const xmlFile : TFileName) : String; //unicamente valida la estructura del xml solo se usaria para desarrollo
public
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: String): Boolean; override;
  function TimbrarDocumento(const aDocumento: String): TFETimbre; override;
 end;

implementation

uses Soap.InvokeRegistry,
     CodeSiteLogging;

destructor TPACEcodex.Destroy();
begin
  FreeAndNil(fManejadorDeSesion);
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  inherited;
end;

procedure TPACEcodex.AfterConstruction;
begin
  fDocumentoXMLTimbrado := TXMLDocument.Create(nil);
  fDocumentoXMLTimbrado.Active := True;

  // Obtenemos una instancia del WebService de Timbrado de Ecodex
  wsTimbradoEcodex := GetWsEcodexTimbrado;
  fManejadorDeSesion := TEcodexManejadorDeSesion.Create;
end;


procedure TPACEcodex.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
  fManejadorDeSesion.AsignarCredenciales(aCredenciales);
end;

{
Procedure TPACComercioDigital.AgregaTimbreFiscal(sXML:String);
Procedure TPACEcodexç.AgregaTimbreFiscal(sXML:String);
Procedure TPACEcodex.AgregaTimbreFiscal(sXML:String);
  if FileExists(sXML) then
   Begin
    FileName:=TStringList.Create;
    FileName.LoadFromFile(sXML);
    FileName.Text:=UTF8Encode(StringReplace(FileName.Text,'</cfdi:Comprobante>',
                              '<cfdi:Complemento>'+fDocumentoXML.XML.Text+'</cfdi:Complemento></cfdi:Comprobante>',[rfReplaceAll]));
    FileName.SaveToFile(sXML);
    FileName.Free;
   End;
End;
           }


function TPACEcodex.ObtenerURLTimbrado: String;
begin
 
end;
//unicamente valida la estructura del xml solo se usaria para desarrollo

procedure TPACEcodex.ProcesarCodigoDeError(aRespuestaDePAC: String);
begin
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

function TPACEcodex.ValidarXML(const xmlFile : TFileName) : String;
begin
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


function TPACEcodex.TimbrarDocumento(const aDocumento: String): TFETimbre;
var
  nodoXMLTimbre : IFEXMLtimbreFiscalDigital;
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario: string;
const
  _ECODEX_FUERA_DE_SERVICIO = 22;
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

    // 3. Realizamos la solicitud de timbrado
    try
      respuestaTimbrado := wsTimbradoEcodex.TimbraXML(solicitudTimbrado);

      // 4. Asignamos las propiedades del Timbre que vamos a regresar
      fDocumentoXMLTimbrado.XML.Text:=UTF8Encode(respuestaTimbrado.ComprobanteXML.DatosXML);
      fDocumentoXMLTimbrado.Active:=True;
      nodoXMLTimbre := GetTimbreFiscalDigital(fDocumentoXMLTimbrado);

      Result.Version:=nodoXMLTimbre.Version;
      Result.UUID:=nodoXMLTimbre.UUID;
      //Result.FechaTimbrado:=nodoXMLTimbre.FechaTimbrado;
      Result.SelloCFD:=nodoXMLTimbre.SelloCFD;
      Result.NoCertificadoSAT:=nodoXMLTimbre.NoCertificadoSAT;
      Result.SelloSAT:=nodoXMLTimbre.SelloSAT;
      Result.XML := nodoXMLTimbre.XML;
    except
      On E:Exception do
      begin
        if (E Is EFallaValidacionException) Or (E Is EFallaServicioException) then
        begin
            if (E Is EFallaValidacionException)  then
            begin
              CodeSite.Send('Falla Validacion Error No.', EFallaValidacionException(E).Numero);
              CodeSite.Send('Falla Validacion Desc:', EFallaValidacionException(E).Descripcion);
              CodeSite.Send('Sugerencia:', EFallaValidacionException(E).Sugerencia);
            end;

            if (E Is EFallaServicioException)  then
            begin
              CodeSite.Send('Falla Servicio Error No.', EFallaServicioException(E).Numero);
              CodeSite.Send('Falla Servicio Desc:', EFallaServicioException(E).Descripcion);
              CodeSite.Send('Sugerencia:', EFallaServicioException(E).FaultCode);

              if EFallaServicioException(E).Numero = _ECODEX_FUERA_DE_SERVICIO then


              raise EPACServicioNoDisponibleException.Create(E.Message);
            end;
            ProcesarCodigoDeError(E.Message);
        end else
          raise;
      end;
    end;
  finally
    solicitudTimbrado.Free;
  end;
end;

function TPACEcodex.CancelarDocumento(const aDocumento: string): Boolean;
begin
  // TODO: TPACComercioDigital.CancelarDocumento
  // TODO: TPACEcodexç.CancelarDocumento
  // TODO: TPACEcodex.CancelarDocumento
end;

end.
