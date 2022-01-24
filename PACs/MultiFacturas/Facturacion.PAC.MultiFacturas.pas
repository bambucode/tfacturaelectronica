{ ******************************************************* }
{                                                         }
{ TFacturaElectronica                                     }
{                                                         }
{ Soporte del PAC MultiFacturas                           }
{                                                         }
{ ******************************************************* }

unit Facturacion.PAC.MultiFacturas;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     MultiFacturasWsTimbrado,
{$IF CompilerVersion >= 23}
   System.Types,
   System.SysUtils,
   System.Classes
{$ELSE}
   Types,
   SysUtils,
   Classes
{$IFEND}
 ;

type

   TProveedorMultiFacturas = class(TProveedorAutorizadoCertificacionBase, IProveedorAutorizadoCertificacion)
   private
      fwsTimbrado: wservicePortType;
      fDominioWebService: string;
      fCredencialesPAC: TFacturacionCredencialesPAC;
      procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
   public
      procedure AfterConstruction; override;
      destructor Destroy; override;
      procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64); override;
      function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8; overload; override;
      function TimbrarDocumento(const aXML : TCadenaUTF8; const aTransaccion : Int64): TCadenaUTF8; overload; override;
      function ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer; override;
      function CancelarDocumento(const aUUID: TSolicitudCancelacion): Boolean; overload; override;
      function CancelarDocumento(const aUUID: TCadenaUTF8; var aExtraInfo: TCadenaUTF8): Boolean; overload; override;
      function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID; override;
      function ObtenerAcuseDeCancelacion(const aUUID: string): string; override;
      function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string; override;
      function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8; override;
   end;

implementation

uses
   Facturacion.Tipos,
{$IF Compilerversion >= 23}
     System.RegularExpressions,
     Xml.xmldom,
     Xml.XMLIntf,
     Xml.Win.Msxmldom,
     Xml.XMLDoc
{$ELSE}
    {$IF Compilerversion >= 22}
     RegularExpressions,
   {$ELSE}
     PerlRegEx,
   {$IFEND}
     xmldom,
     XMLIntf,
     Msxmldom,
     XMLDoc
{$IFEND}
 , Facturacion.Helper;

{ TProveedorSolucionFactible }

procedure TProveedorMultiFacturas.AfterConstruction;
begin
  inherited;
  AsignarParametro(PAC_PARAM_SVC_CFG_MULTIPLES_URLS, PAC_VALOR_SI);
end;

function TProveedorMultiFacturas.AgregarCliente(const aRFC, aRazonSocial,
  aCorreo: String): string;
begin

end;

function TProveedorMultiFacturas.CancelarDocumento(
  const aUUID: TSolicitudCancelacion): Boolean;
var LExtraInfo: TCadenaUTF8;
begin

 result := CancelarDocumento(aUUID[0].UUID, LExtraInfo);

end;

function TProveedorMultiFacturas.CancelarDocumento(const aUUID: TCadenaUTF8;
  var aExtraInfo: TCadenaUTF8): Boolean;
var
 LRespuestaCancelacion: RespuestaCancelacion;
begin
  if ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64)='' then
     raise EPACRSACertificadoNoAsignadoException.Create('Certificado no asignado o vacío',0,0,false)
  else if ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64)='' then
     raise EPACRSALlavePrivadaNoAsignadaException.Create('Llave privada no asignada o vacía',0,0,false);

  LRespuestaCancelacion := fwsTimbrado.cancelar( fCredencialesPAC.RFC, fCredencialesPAC.Clave, aUUID,
   ObtenerParametro(PAC_PARAM_RSA_CERTIFICADO_BASE64),
   ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_BASE64),
   ''{ObtenerParametro(PAC_PARAM_RSA_LLAVEPRIVADA_CLAVE)} ); // La Clave de la Llave privada no es necesaria
  if LRespuestaCancelacion.codigo_mf_numero=0 then
  begin
   result := true;
   aExtraInfo :=  UTF8Decode(TFacturacionHelper.BytesToUTF8(TFacturacionHelper.Decode64(LRespuestaCancelacion.acuse) ) ) ;
  end
  else
  begin
   Result := false;
   aExtraInfo := Format('Error Al Cancelar CFDI: %s.  Error No. %d: "%s"',[aUUID, LRespuestaCancelacion.codigo_mf_numero, UTF8Decode( LRespuestaCancelacion.codigo_mf_texto )]);
    raise EPACException.Create(aExtraInfo,
                               0,
                               LRespuestaCancelacion.codigo_mf_numero, true);



  end;
end;

function TProveedorMultiFacturas.CancelarDocumentos(
  const aUUID: TListadoUUID): TListadoCancelacionUUID;
var LIdx: Integer;
    LExtraInfo: TCadenaUTF8;
begin
 for Lidx := Low(aUUID) to High(aUUID) do
 begin
  if not assigned(result) then
      Result := TListadoCancelacionUUID.Create;
  result.Add(aUUID[LIdx], CancelarDocumento(aUUID[LIdx], LExtraInfo));
 end;
end;

procedure TProveedorMultiFacturas.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
begin
   fDominioWebService := aWsTimbrado;
   fCredencialesPAC := aCredencialesPAC;

   // Inicializamos las instancias de los WebServices
   if ObtenerParametro(PAC_PARAM_SVC_CFG_MULTIPLES_URLS)=PAC_VALOR_SI then
      fwsTimbrado := GetwservicePortTypeRandom(False, fDominioWebService)
   else
      fwsTimbrado := GetwservicePortType(False, fDominioWebService);

  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_ID, aCredencialesPAC.RFC);
  AsignarParametro(PAC_PARAM_SESION_PAC_USUARIO_CLAVE, aCredencialesPAC.Clave);
  AsignarParametro(PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID, aCredencialesPAC.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID, aCredencialesIntegrador.RFC);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE, aCredencialesIntegrador.Clave);
  AsignarParametro(PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID, aCredencialesIntegrador.DistribuidorID);

  AsignarParametro(PAC_PARAM_SESION_TRANSACCION_INICIAL, IntToStr(aTransaccionInicial));

  AsignarParametro(PAC_PARAM_SVC_URL_API, aWsTimbrado);

  AsignarParametro(PAC_PARAM_SVC_URL_API_TIMBRADO, aWsTimbrado);
  AsignarParametro(PAC_PARAM_SVC_URL_API_CLIENTES, aWsTimbrado);
  AsignarParametro(PAC_PARAM_SVC_URL_API_CANCELACION, aWsTimbrado);

end;

destructor TProveedorMultiFacturas.Destroy;
begin
  if Assigned(fParametros) then
     FreeAndNil(fParametros);
  inherited;
end;

function TProveedorMultiFacturas.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
begin
 Result := TimbrarDocumento( UTF8Encode( aComprobante.XML ), aTransaccion );
end;

function TProveedorMultiFacturas.ObtenerAcuseDeCancelacion(
  const aUUID: string): string;
begin

end;

function TProveedorMultiFacturas.ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
var LSaldoReponse: saldoResponse;
begin
 result := -1;
 try
  LSaldoReponse := fwsTimbrado.saldo(aRFC, fCredencialesPAC.Clave);
  if LSaldoReponse.codigo_mf_numero=0 then
  begin
   Result := LSaldoReponse.saldo;
  end
  else
  begin
    raise EPACException.Create('Error al Consultar Saldo. Error No. ' +
                                IntToStr(LsaldoReponse.codigo_mf_numero) +
                                   ' / Detalle: ' +UTF8Decode( LsaldoReponse.codigo_mf_texto ),
                                   0,
                                   LSaldoReponse.codigo_mf_numero, true);
  end;

 except
 end;
end;

function TProveedorMultiFacturas.ObtenerTimbrePrevio(
  const aIdTransaccionOriginal: Int64): TCadenaUTF8;
begin

end;

procedure TProveedorMultiFacturas.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
   mensajeExcepcion: string;
   numeroErrorSAT: Integer;
begin
   mensajeExcepcion := aExcepcion.Message;
   raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TProveedorMultiFacturas.TimbrarDocumento(const aXML: TCadenaUTF8;
  const aTransaccion: Int64): TCadenaUTF8;
var
   respuestaTimbrado: Respuesta;
   sXML: TBytedynArray;
   sXMLStr: TCadenaUTF8;
   aByteArray: TByteDynArray;
   {$IF Compilerversion < 20}
     Buffer: AnsiString;
   {$ifeNd}

begin
   sXMLStr := TFacturacionHelper.Encode64( PByte(TFacturacionHelper.UTF8ToBytes( aXml )), Length(aXml) );

   if ObtenerParametroDef(PAC_PARAM_SVC_CFDI_VERSION, PAC_VALOR_CFDI_VERSION_33) = PAC_VALOR_CFDI_VERSION_33 then
      respuestaTimbrado := fwsTimbrado.timbrar33(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, ObtenerParametroDef(PAC_PARAM_SVC_CFG_MODO_PRODUCCION,PAC_VALOR_NO))
   else
      respuestaTimbrado := fwsTimbrado.timbrar32(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXMLStr, ObtenerParametroDef(PAC_PARAM_SVC_CFG_MODO_PRODUCCION,PAC_VALOR_NO));

   if respuestaTimbrado.codigo_mf_numero=0 then
   Begin
    sXMLStr := respuestaTimbrado.cfdi;
    sXMLStr := UTF8Decode( TFacturacionHelper.BytesToUTF8( TFacturacionHelper.Decode64(sXMLStr) ) );
    Result := ExtraerNodoTimbre(sXMLStr)
   End
    else
       raise EPACException.Create('Error de Timbrado CFDI. Error No. ' +
                                   IntToStr(respuestaTimbrado.codigo_mf_numero) +
                                   ' / Detalle: ' +UTF8Decode( respuestaTimbrado.codigo_mf_texto ),
                                   0,
                                   respuestaTimbrado.codigo_mf_numero, false);

end;
end.
