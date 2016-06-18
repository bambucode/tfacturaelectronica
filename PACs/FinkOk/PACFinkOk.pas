
{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la implementación para timbrado de CFDI del proveedor
  FinkOK (http://www.finkok.com)

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit PACFinkOk;

interface

uses Types,
     LibEay32Plus,
     OpenSSLUtils,
     SynaCode,
     xmldom,
     XMLIntf,
     msxmldom,
     XMLDoc,
     SysUtils,
     ProveedorAutorizadoCertificacion,
     FacturaTipos,
     FETimbreFiscalDigital,
     feCFDv32,
     FinkOkWsTimbrado,
     FacturaReglamentacion,
     FECancelaFinkOK,
     FeCFD,
     libeay32,
     ClaseOpenSSL,
     forms,/// se puso para cancelar directo en openssl eliminar al finalizar la funcion
    {$IF Compilerversion >= 20}
     System.Classes;
    {$ELSE}
      Classes;
    {$IFEND}
type


  PStringArray = ^StringArray;
 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "FinkOk"
 ///	 (<see href="http://www.finkok.com" />)
 ///	</summary>
 {$ENDREGION}

 TPACFinkOk = class(TProveedorAutorizadoCertificacion)
 Protected
  fAcuse:TUnicodeString;
  function getAcuseXML() : TUnicodeString; override;
 private
  fDominioWebService :String;
  fCredenciales : TFEPACCredenciales;
  fDocumentoXMLTimbrado : TXMLDocument;
  fDocumentoXMLCancelado : TXMLDocument;
  wsTimbradoFinkOk: IFinkOkServicioTimbrado;
  wsCancelaFinkOk: IFinkOkCancelaTimbrado;
  wsAltaClienteFinkOk: IFinkOkAltaCliente;
  function AsignarTimbreDeRespuestaDeFinkOk(const aRespuestaTimbrado: TFinkOkRespuestaTimbrado): TFETimbre;
  function ObtenerURLTimbrado: String;
  function ValidarXML(const xmlFile : TFileName) : String; //unicamente valida la estructura del xml solo se usaria para desarrollo
  procedure ProcesarCodigoDeError(aRespuestaDePAC,Mensaje: String);
public
  destructor Destroy(); override;
  constructor Create(const aDominioWebService: string); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; override;
//  Function AgregaCliente(const aRFC: String):String; override;
  function AgregaCliente(const aNuevoEmisor: TFEContribuyente):String; override;
  Function EditaCliente(const Activar: Boolean;const aRFC:String):String; override;
  Function BorraCliente(const aRFC: String):String; override;
//  property Acuse : Texto read Get;
end;

implementation

{$IF Compilerversion >= 20} uses Soap.InvokeRegistry; {$IFEND}
type
 EFINKOKAutentificacionInvalida = class(EPACException); // Error código 501
 EFINKOKRFCEmisorNoReconocidoFinkOK = class(EPACException); // Error código 702
 EFINKOKCuentaSuspendida = class(EPACException); // Error código 703
 EFINKOKErrorContrasenaLlavePrivada = class(EPACException); // Error código 704
 EFINKOKXMLEstructuraInvalida = class(EPACException); // Error código 705
 EFINKOKSocioInvalido = class(EPACException); // Error código 706
 EFINKOKXMLYaContieneNodo = class(EPACException); // Error código 707
 EFINKOKNoSeConectoSat = class(EPACException); // Error código 708
 EFINKOKErrorCertificadoCancelar = class(EPACException); // Error código 711

Procedure TPACFinkOk.ProcesarCodigoDeError(aRespuestaDePAC,Mensaje: string);
const
_ERROR_FINKON_AUTENTIFICACION_INVALIDA                 = '501';
_ERROR_FINKON_RFC_EMISOR_NO_RECONOCIDO_FINKOK          = '702';
_ERROR_FINKON_CUENTA_SUSPENDIDA                        = '703';
_ERROR_FINKON_ERROR_CONTRASENA_LLAVE_PRIVADA           = '704';
_ERROR_FINKON_XML_ESTRUCTURA_INVALIDA                  = '705';
_ERROR_FINKON_SOCIO_INVALIDO                           = '706';
_ERROR_FINKON_XML_YA_CONTIENE_NODO_TIMBRE              = '707';
_ERROR_FINKON_NO_SE_PUDO_CONECTAR_SAT                  = '708';
_ERROR_FINKON_ERROR_CERTIFICADO_AL_CANCELAR            = '711';
begin
  if aRespuestaDePAC=_ERROR_SAT_XML_INVALIDO then
   raise ETimbradoXMLInvalidoException.Create(aRespuestaDePAC+' '+Mensaje,301,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_SELLO_EMISOR_INVALIDO then
   raise ETimbradoSelloEmisorInvalidoException.Create(aRespuestaDePAC+' '+Mensaje,302,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE then
   raise ETimbradoCertificadoNoCorrespondeException.Create(aRespuestaDePAC+' '+Mensaje,303,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_CERTIFICADO_REVOCADO then
   raise ETimbradoCertificadoRevocadoException.Create(aRespuestaDePAC+' '+Mensaje,304,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA then
   raise ETimbradoFechaEmisionSinVigenciaException.Create(aRespuestaDePAC+' '+Mensaje,305,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_LLAVE_NO_CORRESPONDE then
   raise ETimbradoLlaveInvalidaException.Create(aRespuestaDePAC+' '+Mensaje,306,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_PREVIAMENTE_TIMBRADO then
   raise ETimbradoPreviamenteException.Create(aRespuestaDePAC+' '+Mensaje,307,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT then
   raise ETimbradoCertificadoApocrifoException.Create(aRespuestaDePAC+' '+Mensaje,308,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_FECHA_FUERA_DE_RANGO then
   raise ETimbradoFechaGeneracionMasDe72HorasException.Create(aRespuestaDePAC+' '+Mensaje,401,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO then
   raise ETimbradoRegimenEmisorNoValidoException.Create(aRespuestaDePAC+' '+Mensaje,402,0,False)
  Else if aRespuestaDePAC=_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO then
   raise ETimbradoFechaEnElPasadoException.Create(aRespuestaDePAC+' '+Mensaje,403,0,False)
/// errores generados de este pac
  Else if aRespuestaDePAC=_ERROR_FINKON_AUTENTIFICACION_INVALIDA then
   raise EFINKOKAutentificacionInvalida.Create(aRespuestaDePAC+' '+Mensaje,501,0,False)
  Else if aRespuestaDePAC=_ERROR_FINKON_RFC_EMISOR_NO_RECONOCIDO_FINKOK then
   raise EFINKOKRFCEmisorNoReconocidoFinkOK.Create(aRespuestaDePAC+' '+Mensaje,702,0,False)//+' Emisor no reconocido por FinkOk ')
  Else if aRespuestaDePAC=_ERROR_FINKON_CUENTA_SUSPENDIDA then
   raise EFINKOKCuentaSuspendida.Create(aRespuestaDePAC+' '+Mensaje,703,0,False)//+' Cuenta Suspendida ')
  Else if aRespuestaDePAC=_ERROR_FINKON_ERROR_CONTRASENA_LLAVE_PRIVADA then
   raise EFINKOKErrorContrasenaLlavePrivada.Create(aRespuestaDePAC+' '+Mensaje,704,0,False)//+' Contraseña invalida de la llave privada ')
  Else if aRespuestaDePAC=_ERROR_FINKON_XML_ESTRUCTURA_INVALIDA then
   raise EFINKOKXMLEstructuraInvalida.Create(aRespuestaDePAC+' '+Mensaje,705,0,False)//+' Estructura Invalida ')
  Else if aRespuestaDePAC=_ERROR_FINKON_SOCIO_INVALIDO then
   raise EFINKOKSocioInvalido.Create(aRespuestaDePAC+' '+Mensaje,706,0,False)//+' Socio Invalido ')
  Else if aRespuestaDePAC=_ERROR_FINKON_XML_YA_CONTIENE_NODO_TIMBRE then
   raise EFINKOKXMLYaContieneNodo.Create(aRespuestaDePAC+' '+Mensaje,707,0,False)//+' El XML ya contiene un nodo de timbrefiscal ')
  Else if aRespuestaDePAC=_ERROR_FINKON_NO_SE_PUDO_CONECTAR_SAT then
   raise EFINKOKNoSeConectoSat.Create(aRespuestaDePAC+' '+Mensaje,708,0,False)//+' No se pudo conectar al SAT ')
  Else if aRespuestaDePAC=_ERROR_FINKON_ERROR_CERTIFICADO_AL_CANCELAR then
   raise EFINKOKErrorCertificadoCancelar.Create(aRespuestaDePAC+' '+Mensaje,711,0,False)//+' Error con el certificado al cancelar ')
  Else
  // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
  raise EPACErrorGenericoException.Create(aRespuestaDePAC+' '+Mensaje, 0, 0, True);
end;

function TPACFinkOk.getAcuseXML() : TUnicodeString;
Begin
 Result:=fAcuse;
End;

destructor TPACFinkOk.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  inherited;
end;

constructor TPACFinkOk.Create(const aDominioWebService: string);
begin
  inherited;
  fDominioWebService := aDominioWebService;
end;

procedure TPACFinkOk.AfterConstruction();
begin
  fDocumentoXMLTimbrado := TXMLDocument.Create(nil);
  fDocumentoXMLTimbrado.Active := True;
  fDocumentoXMLCancelado := TXMLDocument.Create(nil);
  fDocumentoXMLCancelado.Active := True;
  // Obtenemos una instancia del WebService de Timbrado de FinkOk
  wsTimbradoFinkOk   := GetFinkOkTimbrado(False, fDominioWebService + '/servicios/soap/stamp');
  wsCancelaFinkOk    := GetFinkOkCancelar(False, fDominioWebService + '/servicios/soap/cancel');
  wsAltaClienteFinkOk:= GetFinkOkCliente(False, fDominioWebService + '/servicios/soap/registration');
end;


procedure TPACFinkOk.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
end;
function TPACFinkOk.AgregaCliente(const aNuevoEmisor: TFEContribuyente): String; 
//Function TPACFinkOk.AgregaCliente(const aRFC: String):String;
var
  respuestaTimbrado: IFinkOkRespuestaRegistro;
begin
  respuestaTimbrado := wsAltaClienteFinkOk.Add(fCredenciales.RFC,fCredenciales.Clave,Trim(aNuevoEmisor.RFC),'','');
  if respuestaTimbrado.success then
    Result:=respuestaTimbrado.message
  Else
   raise Exception.Create('El Cliente no se pudo agregar '+respuestaTimbrado.message);
End;

Function TPACFinkOk.EditaCliente(const Activar: Boolean;const aRFC:String):String;
var
  respuestaTimbrado: IFinkOkRespuestaRegistro;
begin
  if Activar then
   respuestaTimbrado := wsAltaClienteFinkOk.edit(fCredenciales.RFC,fCredenciales.Clave,Trim(aRFC),'A')
  Else
   respuestaTimbrado := wsAltaClienteFinkOk.edit(fCredenciales.RFC,fCredenciales.Clave,Trim(aRFC),'S');

  if respuestaTimbrado.success then
    Result:=respuestaTimbrado.message
  Else
  raise Exception.Create('El Cliente no se pudo modificar '+respuestaTimbrado.message);
End;

Function TPACFinkOk.BorraCliente(const aRFC: String):String;
var
  respuestaTimbrado: IFinkOkRespuestaRegistro;
begin
  respuestaTimbrado := wsAltaClienteFinkOk.delete(fCredenciales.RFC,fCredenciales.Clave,Trim(aRFC));
  if respuestaTimbrado.success then
    Result:=respuestaTimbrado.message
  Else
   raise Exception.Create('El Cliente no se pudo eliminar '+respuestaTimbrado.message);
End;

function TPACFinkOk.ObtenerURLTimbrado: String;
begin

end;
//unicamente valida la estructura del xml solo se usaria para desarrollo

function TPACFinkOk.ValidarXML(const xmlFile : TFileName) : String;
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

function TPACFinkOk.AsignarTimbreDeRespuestaDeFinkOk(const aRespuestaTimbrado:
    TFinkOkRespuestaTimbrado): TFETimbre;
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
  documentoXMLTimbrado.XML.Text:=aRespuestaTimbrado.xml;
  {$ELSE}
  documentoXMLTimbrado.XML.Text:=UTF8Encode(aRespuestaTimbrado.XML);
  {$IFEND}

  documentoXMLTimbrado.Active:=True;

  // Convertimos el XML a la interfase del CFD v3.2
  comprobanteTimbrado := GetComprobanteV32(documentoXMLTimbrado);

  // Extraemos solamente el nodo del timbre
  Assert(IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.HasChildNodes,
        'No se recibio correctamente el timbre');
 documentoXMLTimbre := TXMLDocument.Create(nil);
//valido si el primer nodo es timbre
 if IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes.First.NodeName='tfd:TimbreFiscalDigital' then
  Begin
   Assert(IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes.Count = 1,
        'Se debio haber tenido solo el timbre como complemento');
   // Creamos el documento XML solamente del timbre
   documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes.First.XML;
  End
 Else
  documentoXMLTimbre.XML.Text := IFEXMLComprobanteV32(comprobanteTimbrado).Complemento.ChildNodes[1].XML;
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

function TPACFinkOk.TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre;
var
  nodoXMLTimbre : IFEXMLtimbreFiscalDigital;
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
  Funciones:TFuncionesComunesPAC;
begin
  Funciones:=TFuncionesComunesPAC.Create;
  sXML := Funciones.UTF8Bytes(aDocumento);
  try
   respuestaTimbrado := wsTimbradoFinkOk.stamp(sXML,fCredenciales.RFC,fCredenciales.Clave);
  if Trim(respuestaTimbrado.CodEstatus) <> '' then
    Result := AsignarTimbreDeRespuestaDeFinkOk(respuestaTimbrado)
  else if Trim(respuestaTimbrado.CodEstatus) = '' then
   ProcesarCodigoDeError(respuestaTimbrado.Incidencias[0].CodigoError,respuestaTimbrado.Incidencias[0].MensajeIncidencia)
  except
   On E:Exception do
      begin
       if Trim(respuestaTimbrado.CodEstatus) = '' then
        ProcesarCodigoDeError(respuestaTimbrado.Incidencias[0].CodigoError,respuestaTimbrado.Incidencias[0].MensajeIncidencia)
       end else
         raise;
      end;
   Funciones.Free;
end;


function TPACFinkOk.CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean;

var
  wsResultado: IFinkOkCancelaTimbrado;
  Retorno: CancelaCFDResult;
  sKey,sCer:TByteDynArray;
  AUUID:StringArray;
  UUID:UUIDS;
  aKey,aCer:TFileName;
  NodoCancelacion: IFEXMLEnvelopeType;
  Funciones:TFuncionesComunesPAC;
  OpenSSL: TOpenSSL;
  LlaveAbierta: pPKCS8_Priv_Key_Info;
  x509Certificado : TX509Certificate;
  key: TKeyPairGenerator;
  FuncionesComunesPAC : TFuncionesComunesPAC;
begin
 Result:=True;
 FuncionesComunesPAC:=TFuncionesComunesPAC.Create;
 Result:=True;
 OpenSSL:=TOpenSSL.Create;
 Funciones:=TFuncionesComunesPAC.Create;
 UUID:=UUIDS.Create;
// obtenemos el certificado
 x509Certificado := TX509Certificate.Create;
 x509Certificado.LoadFromFile(fCredenciales.Certificado.Ruta);
 sCer:=Funciones.UTF8Bytes(X509Certificado.AsBase64);
 x509Certificado.Free;
// obtenemos la llave
 llaveAbierta := openSSL.AbrirLlavePrivada(fCredenciales.Certificado.LlavePrivada.Ruta,fCredenciales.Certificado.LlavePrivada.Clave);
 openSSL.GuardarLlavePrivadaEnPEM(llaveAbierta, fCredenciales.Certificado.LlavePrivada.Ruta+'.pem');
 OpenSSL.Free;
 key := TKeyPairGenerator.Create;
 key.KeyFileNames(fCredenciales.Certificado.LlavePrivada.Ruta+'.pem');  // crea dos archivos el .pem.key y el .pub
 key.Password := fCredenciales.Clave;                  // este atributo es requerido
// key.Password := fCredenciales.Clave;                  // este atributo es requerido
 key.GenerateRSA;
 key.free;
// sKey:=Funciones.FileToByteArray(fCredenciales.LlavePrivada+'.pem.key');

/////////////////////////////////// borrar al corregir la funcion para encriptar el key
 if Not(FileExists(ExtractFilePath(Application.ExeName)+'LLAVE.pem.key')) then
  Begin
   raise Exception.Create('Archivo LLAVE.pem.key no encontrado');
   Exit;
  End;
 sKey:=Funciones.FileToByteArray(ExtractFilePath(Application.ExeName)+'LLAVE.pem.key');
////////////////////////////////////////////////////////////////////////////////////////
 wsResultado := GetFinkOkCancelar(False, fDominioWebService + '/servicios/soap/cancel');
 SetLength(AUUID, 0);
 AUUID:=Funciones.WStringToArray(FuncionesComunesPAC.ExtraerUUID(aDocumento));
 UUID.uuids:=AUUID;
 FuncionesComunesPAC.Free;
 Retorno := wsResultado.cancel(UUID,Trim(fCredenciales.RFC),Trim(fCredenciales.Clave),
 Trim(fCredenciales.Certificado.RFCAlQuePertenece),sCer,sKey,True);
 fAcuse:=Retorno.Acuse;
 if Retorno.CodEstatus<>'' then
  Begin
   Result:=False;
   raise Exception.Create('Estatus '+Retorno.CodEstatus)
  End;
 if (Trim(Retorno.Folios[0].EstatusUUID)<>'201') and (Trim(Retorno.Folios[0].EstatusUUID)<>'202') then
  Begin
   Result:=False;
   raise Exception.Create('Estatus '+Retorno.Folios[0].EstatusUUID)
  End
 Else
  Begin
    {$IF Compilerversion >= 20}
     fDocumentoXMLCancelado.XML.Text:=Retorno.Acuse;
    {$ELSE}
     fDocumentoXMLCancelado.XML.Text:=UTF8Encode(Retorno.Acuse);
    {$IFEND}
     fDocumentoXMLCancelado.Active:=True;
     nodoCancelacion := GetEnvelope(fDocumentoXMLCancelado);
    if Trim(Retorno.CodEstatus)<>'' then
      ProcesarCodigoDeError(Retorno.CodEstatus,'');
  End;
 UUID.Free;
 Funciones.Free;
end;


end.
