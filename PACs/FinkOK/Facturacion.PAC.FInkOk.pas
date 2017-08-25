{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{        Soporte del pac FinkOK TecsisNet.net           }
{                                                       }
{*******************************************************}

unit Facturacion.PAC.FInkOk;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     System.Types,
     FinkOkWsTimbrado,
     System.SysUtils;

type

  TProveedorFinkOk = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
  private
    fwsTimbradoFinkOk: IFinkOkServicioTimbrado;
    fDominioWebService : string;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    function ExtraerNodoTimbre(const aComprobanteXML : RawByteString): TCadenaUTF8;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    function UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
  public
    procedure Configurar(const aDominioWebService: string; const aCredencialesPAC:
        TFacturacionCredencialesPAC; const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
  end;

implementation

uses Classes,
     xmldom,
     Facturacion.Tipos,
     XMLIntf,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     System.RegularExpressions,
     {$IF Compilerversion >= 20}
     Xml.Win.Msxmldom,
     {$ELSE}
     msxmldom,
     {$IFEND}
     XMLDoc;

{ TProveedorFinkOk }

procedure TProveedorFinkOk.Configurar(const aDominioWebService: string; const
    aCredencialesPAC: TFacturacionCredencialesPAC; const aTransaccionInicial:
    Int64);
begin
  fDominioWebService := aDominioWebService;
  fCredencialesPAC := aCredencialesPAC;
  // Incializamos las instancias de los WebServices
  fwsTimbradoFinkOk := GetWsFinkOkTimbrado(False, fDominioWebService + '/stamp');
end;

function TProveedorFinkOk.UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
begin
{$IF Compilerversion >= 20}Assert(StringElementSize(s)=1){$ENDIF};
  SetLength(Result, Length(s));
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
end;

function TProveedorFinkOk.TimbrarDocumento(const aComprobante:
    IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
begin
  sXML := UTF8Bytes(aComprobante.XML);
  respuestaTimbrado := fwsTimbradoFinkOk.stamp(sXML,fCredencialesPAC.RFC,fCredencialesPAC.Clave);
  if Trim(respuestaTimbrado.CodEstatus) <> '' then
    Result := ExtraerNodoTimbre(respuestaTimbrado.xml);
  if Trim(respuestaTimbrado.CodEstatus) = '' then
   begin
   {$IFDEF CODESITE}
    CodeSite.Send('Falla Validacion Error No.', respuestaTimbrado.Incidencias[0].CodigoError+'/Detalle :'+respuestaTimbrado.Incidencias[0].MensajeIncidencia);
   {$ELSE}
    raise exception.Create('Falla Validacion Error No.'+ respuestaTimbrado.Incidencias[0].CodigoError+'/Detalle :'+respuestaTimbrado.Incidencias[0].MensajeIncidencia);
   {$ENDIF}
   end;
end;

function TProveedorFinkOk.ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
{var
  solicitudEdoCuenta: TEcodexSolicitudEstatusCuenta;
  respuestaEdoCuenta: TEcodexRespuestaEstatusCuenta;
  tokenDeUsuario : string;
  I: Integer;
}begin
{  Assert(Trim(aRFC) <> '', 'El RFC para la solicitud de saldo fue vacio');
  Assert(fManejadorDeSesion <> nil, 'La instancia fManejadorDeSesion no debio ser nula');
  Assert(fwsClientesEcodex <> nil, 'La instancia fwsClientesEcodex no debio ser nula');

  Result := 0;

  // 1. Creamos la solicitud del edo de cuenta
  solicitudEdoCuenta := TEcodexSolicitudEstatusCuenta.Create;

  // 2. Iniciamos una nueva sesion solicitando un nuevo token
  tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario;

  try
    solicitudEdoCuenta.RFC           := aRFC;
    solicitudEdoCuenta.Token         := tokenDeUsuario;
    solicitudEdoCuenta.TransaccionID := fManejadorDeSesion.NumeroDeTransaccion;

    try
      respuestaEdoCuenta := fwsClientesEcodex.EstatusCuenta(solicitudEdoCuenta);
      {$IFDEF CODESITE}
{        CodeSite.Send('Codigo', respuestaEdoCuenta.Estatus.Codigo);
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
{      Result := respuestaEdoCuenta.Estatus.TimbresDisponibles;
    except
      On E:Exception do
         if Not (E Is EPACException) then
          ProcesarExcepcionDePAC(E)
        else
          raise;
    end;
  finally
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsClientes;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsClientes;
    solicitudEdoCuenta.Free;
  end;
}end;

function TProveedorFinkOk.ExtraerNodoTimbre(const aComprobanteXML : RawByteString): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
begin
  Assert(aComprobanteXML <> '', 'La respuesta del servicio de timbrado fue nula');
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
  contenidoComprobanteXML := aComprobanteXML;
  {$ELSE}
  contenidoComprobanteXML := UTF8Encode(aComprobanteXML);
  {$IFEND}

  Result := TRegEx.Match(contenidoComprobanteXML, '<tfd:TimbreFiscalDigital.*?/>').Value;
  Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

procedure TProveedorFinkOk.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion : string;
  numeroErrorSAT: Integer;
begin
  mensajeExcepcion := aExcepcion.Message;
{ if (aExcepcion Is EFinkOkFallaValidacionException) Or
     (aExcepcion Is EFinkOkFallaServicioException) Or
     (aExcepcion is EFinkOkFallaSesionException) then
  begin
      if (aExcepcion Is EFinkOkFallaValidacionException)  then
      begin
        mensajeExcepcion := EFinkOkFallaValidacionException(aExcepcion).Descripcion;

        numeroErrorSAT := EFinkOkFallaValidacionException(aExcepcion).Numero;

        case numeroErrorSAT of
          33101: raise ESATFechaIncorrectaException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33102: raise ESATSelloIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33104: raise ESATFormaPagoSinValorDeCatalogoException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33105: raise ESATCertificadoIncorrectoException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33125: raise ESATLugarDeExpedicionNoValidoException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33132: raise ESATRFCReceptorNoEnListaValidosException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33142: raise ESATClaveProdServNoValidaException.Create(mensajeExcepcion, numeroErrorSAT, False);
          33196: raise ESATNoIdentificadoException.Create(mensajeExcepcion, numeroErrorSAT, False);
        else
          raise ESATErrorGenericoException.Create('EFallaValidacionException (' + IntToStr(EFinkOkFallaValidacionException(aExcepcion).Numero) + ') ' +
                                                  mensajeExcepcion, numeroErrorSAT, False);
        end;
      end;

      if (aExcepcion Is EFinkOkFallaServicioException)  then
      begin
        mensajeExcepcion := 'EFallaServicioException (' + IntToStr(EFinkOkFallaServicioException(aExcepcion).Numero) + ') ' +
                        EFinkOkFallaServicioException(aExcepcion).Descripcion;
      end;

       if (aExcepcion Is EFinkOkFallaSesionException)  then
      begin
        mensajeExcepcion := 'EEcodexFallaSesionException (' + IntToStr(EFinkOkFallaSesionException(aExcepcion).Estatus) + ') ' +
                            EFinkOkFallaSesionException(aExcepcion).Descripcion;
      end;
}
     // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error gen�rico de PAC
     // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
     raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
//  end;
end;

end.
