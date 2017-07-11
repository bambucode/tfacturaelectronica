{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.PAC.Ecodex;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     EcodexWsComun,
     EcodexWsTimbrado,
     EcodexWsClientes,
     PAC.Ecodex.ManejadorDeSesion,
     System.SysUtils;

type

  TProveedorEcodex = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
  private
    fwsTimbradoEcodex: IEcodexServicioTimbrado;
    fwsClientesEcodex : IEcodexServicioClientes;
    fManejadorDeSesion : TEcodexManejadorDeSesion;
    fDominioWebService : string;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    function ExtraerNodoTimbre(const aComprobanteXML : TEcodexComprobanteXML): TCadenaUTF8;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
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

{ TProveedorEcodex }

procedure TProveedorEcodex.Configurar(const aDominioWebService: string; const
    aCredencialesPAC: TFacturacionCredencialesPAC; const aTransaccionInicial:
    Int64);
begin
  fDominioWebService := aDominioWebService;
  fCredencialesPAC := aCredencialesPAC;

  fManejadorDeSesion := TEcodexManejadorDeSesion.Create(fDominioWebService, aTransaccionInicial);
  fManejadorDeSesion.AsignarCredenciales(fCredencialesPAC);

  // Incializamos las instancias de los WebServices
  fwsTimbradoEcodex := GetWsEcodexTimbrado(False, fDominioWebService + '/ServicioTimbrado.svc');
  fwsClientesEcodex := GetWsEcodexClientes(False, fDominioWebService + '/ServicioClientes.svc');
end;

function TProveedorEcodex.TimbrarDocumento(const aComprobante:
    IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  solicitudTimbrado: TSolicitudTimbradoEcodex;
  respuestaTimbrado: TEcodexRespuestaTimbrado;
  tokenDeUsuario: string;
  mensajeFalla: string;
begin
  if fwsTimbradoEcodex = nil then
    raise EPACNoConfiguradoException.Create('No se ha configurado el PAC, favor de configurar con metodo Configurar');

  // 1. Creamos la solicitud de timbrado
  solicitudTimbrado := TSolicitudTimbradoEcodex.Create;

  try
    // 2. Iniciamos una nueva sesion solicitando un nuevo token
    tokenDeUsuario := fManejadorDeSesion.ObtenerNuevoTokenDeUsuario();

    // 3. Asignamos el documento XML
    solicitudTimbrado.ComprobanteXML          := TEcodexComprobanteXML.Create;
    solicitudTimbrado.ComprobanteXML.DatosXML := aComprobante.XML;
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
      On E:Exception do
         ProcesarExcepcionDePAC(E);
    end;
  finally
    if Assigned(solicitudTimbrado) then
      solicitudTimbrado.Free;
  end;

end;


function TProveedorEcodex.ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
var
  solicitudEdoCuenta: TEcodexSolicitudEstatusCuenta;
  respuestaEdoCuenta: TEcodexRespuestaEstatusCuenta;
  tokenDeUsuario : string;
  I: Integer;
begin
  Assert(Trim(aRFC) <> '', 'El RFC para la solicitud de saldo fue vacio');
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
    //fUltimoXMLEnviado := GetUltimoXMLEnviadoEcodexWsClientes;
    //fUltimoXMLRecibido := GetUltimoXMLRecibidoEcodexWsClientes;
    solicitudEdoCuenta.Free;
  end;
end;

function TProveedorEcodex.ExtraerNodoTimbre(const aComprobanteXML : TEcodexComprobanteXML): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
begin
  Assert(aComprobanteXML <> nil, 'La respuesta del servicio de timbrado fue nula');
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
  contenidoComprobanteXML := aComprobanteXML.DatosXML;
  {$ELSE}
  contenidoComprobanteXML := UTF8Encode(aComprobanteXML.DatosXML);
  {$IFEND}

  Result := TRegEx.Match(contenidoComprobanteXML, '<tfd:TimbreFiscalDigital.*?/>').Value;
  Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

procedure TProveedorEcodex.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion : string;
  numeroErrorSAT: Integer;
begin
  mensajeExcepcion := aExcepcion.Message;

 if (aExcepcion Is EEcodexFallaValidacionException) Or
     (aExcepcion Is EEcodexFallaServicioException) Or
     (aExcepcion is EEcodexFallaSesionException) then
  begin
      if (aExcepcion Is EEcodexFallaValidacionException)  then
      begin
        mensajeExcepcion := EEcodexFallaValidacionException(aExcepcion).Descripcion;

        numeroErrorSAT := EEcodexFallaValidacionException(aExcepcion).Numero;

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
          raise ESATErrorGenericoException.Create('EFallaValidacionException (' + IntToStr(EEcodexFallaValidacionException(aExcepcion).Numero) + ') ' +
                                                  mensajeExcepcion, numeroErrorSAT, False);
        end;
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

     // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
     // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
     raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
  end;
end;

end.
