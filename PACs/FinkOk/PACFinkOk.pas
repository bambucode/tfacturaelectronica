{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la implementación para timbrado de CFDI del proveedor
  Ecodex (http://www.finkok.com)

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit PACFinkOk;

interface

uses Types,
     xmldom,
     XMLIntf,
     msxmldom,
     XMLDoc,
     SysUtils,
     ProveedorAutorizadoCertificacion,
     FacturaTipos,
     FETimbreFiscalDigital,
     Math,
     feCFDv32,
     FinkOkWsTimbrado,
     FacturaReglamentacion,
     FeCFD;

type


  PStringArray = ^StringArray;
 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "FinkOk"
 ///	 (<see href="http://www.finkok.com" />)
 ///	</summary>
 {$ENDREGION}

 TPACFinkOk = class(TProveedorAutorizadoCertificacion)
 private
  fCredenciales : TFEPACCredenciales;
  fDocumentoXMLTimbrado : TXMLDocument;
  wsTimbradoFinkOk: IFinkOkServicioTimbrado;
  wsCancelaFinkOk: IFinkOkCancelaTimbrado;
  wsAltaClienteFinkOk: IFinkOkAltaCliente;
  function AsignarTimbreDeRespuestaDeFinkOk(const aRespuestaTimbrado: TFinkOkRespuestaTimbrado): TFETimbre;
  function ObtenerURLTimbrado: String;
  function ValidarXML(const xmlFile : TFileName) : String; //unicamente valida la estructura del xml solo se usaria para desarrollo
  function UTF8Bytes(const s: UTF8String): TBytedynArray;
public
  destructor Destroy(); override;
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); override;
  function CancelarDocumento(const aDocumento: String): Boolean; override;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; override;
  Function AgregaCliente(const aRFC: String):String; override;
  Function EditaCliente(const Activar: Boolean;const aRFC:String):String; override;
  Function BorraCliente(const aRFC: String):String; override;
end;

implementation

uses {$IF Compilerversion >= 20} Soap.InvokeRegistry, {$IFEND}
     CodeSiteLogging;

function TPACFinkOk.UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
begin
{$IF Compilerversion >= 20}Assert(StringElementSize(s)=1){$IFEND};
  SetLength(Result, Length(s));
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
end;

destructor TPACFinkOk.Destroy();
begin
  // Al ser una interface el objeto TXMLDocument se libera automaticamente por Delphi al dejar de ser usado
  // aunque para asegurarnos hacemos lo siguiente:
  inherited;
end;

procedure TPACFinkOk.AfterConstruction;
begin
  fDocumentoXMLTimbrado := TXMLDocument.Create(nil);
  fDocumentoXMLTimbrado.Active := True;
  // Obtenemos una instancia del WebService de Timbrado de FinkOk
  wsTimbradoFinkOk   := GetFinkOkTimbrado(False,'',nil);
  wsCancelaFinkOk    := GetFinkOkCancelar(False,'',nil);
  wsAltaClienteFinkOk:= GetFinkOkCliente(False,'',nil);
end;


procedure TPACFinkOk.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  fCredenciales := aCredenciales;
end;

Function TPACFinkOk.AgregaCliente(const aRFC: String):String;
var
  respuestaTimbrado: IFinkOkRespuestaRegistro;
begin
  respuestaTimbrado := wsAltaClienteFinkOk.Add(fCredenciales.RFC,fCredenciales.Clave,Trim(aRFC),'','');
  if respuestaTimbrado.success then
    Result:=respuestaTimbrado.message
  Else
   CodeSite.Send('El Cliente no se pudo agregar '+respuestaTimbrado.message);
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
   CodeSite.Send('El Cliente no se pudo modificar '+respuestaTimbrado.message);
End;

Function TPACFinkOk.BorraCliente(const aRFC: String):String;
var
  respuestaTimbrado: IFinkOkRespuestaRegistro;
begin
  respuestaTimbrado := wsAltaClienteFinkOk.delete(fCredenciales.RFC,fCredenciales.Clave,Trim(aRFC));
  if respuestaTimbrado.success then
    Result:=respuestaTimbrado.message
  Else
   CodeSite.Send('El Cliente no se pudo eliminar '+respuestaTimbrado.message);
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

function TPACFinkOk.TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre;
var
  nodoXMLTimbre : IFEXMLtimbreFiscalDigital;
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
begin
  sXML := UTF8Bytes(aDocumento);
  try
   respuestaTimbrado := wsTimbradoFinkOk.stamp(sXML,fCredenciales.RFC,fCredenciales.Clave);
  if Trim(respuestaTimbrado.CodEstatus) <> '' then
    Result := AsignarTimbreDeRespuestaDeFinkOk(respuestaTimbrado)
  except
   On E:Exception do
      begin
       if Trim(respuestaTimbrado.CodEstatus) = '' then
        begin
         CodeSite.Send('Falla Validacion Error No.', respuestaTimbrado.Incidencias[0].CodigoError);
         CodeSite.Send('Falla Validacion Desc:', respuestaTimbrado.Incidencias[0].MensajeIncidencia);
        end;
        end else
          raise;
      end;
end;

function TPACFinkOk.CancelarDocumento(const aDocumento: string): Boolean;
begin
  // TODO: TPACComercioDigital.CancelarDocumento
  // TODO: TPACFinkOk.CancelarDocumento
  // TODO: TPACFinkOk.CancelarDocumento
end;

end.
