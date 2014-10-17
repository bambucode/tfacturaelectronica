{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase se encarga de convertir las excepciones por falla de internet de
  Delphi a excepciones propias para que sea mas claro el error ante el usuario

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit ManejadorDeErroresComunes;

interface

uses
  SysUtils,
  {$IFDEF CODESITE} CodeSiteLogging, {$ENDIF}
  FacturaTipos;

type

   TManejadorErroresComunes = class
      class procedure LanzarExcepcionSiDetectaFallaInternet(const aExcepcion: Exception);
  private
    class procedure DetectarErroresConocidos(const aExcepcion: Exception);
   end;

implementation

uses SOAPHTTPTrans;

class procedure TManejadorErroresComunes.LanzarExcepcionSiDetectaFallaInternet(const aExcepcion: Exception);
begin
  if aExcepcion <> nil then
  begin
    {$IFDEF CODESITE}
      CodeSite.SendException(aExcepcion);
    {$ENDIF}

    if aExcepcion Is ESOAPHttpException then
    begin
      // Lista de codigos de error estandares:
      // http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_Error
      case ESOAPHttpException(aExcepcion).StatusCode of
        502, 503, 504, 522: raise EPACProblemaConInternetException.Create('No se pudo realizar una conexion con el PAC: ' +
                                                           aExcepcion.Message, 0, 0, True);
        505: raise EPACErrorGenericoException.Create('Hubo un error al procesar tu factura: ' +
                                                     aExcepcion.Message, 0, ESOAPHttpException(aExcepcion).StatusCode, False);
      else
        DetectarErroresConocidos(aExcepcion);
      end;
    end else
      DetectarErroresConocidos(aExcepcion);
  end;
end;

class procedure TManejadorErroresComunes.DetectarErroresConocidos(const aExcepcion: Exception);
const
  _SIN_INTERNET = 'No se pudo establecer una conexi';
  _SIN_INTERNET_INGLES = 'A connection with the server could not be established ';
  _CADENA_ERROR_DNS_ESPANOL                  = 'resolver el nombre de servidor';
  _CADENA_ERROR_DNS_INGLES                   = 'address could not be resolved';
  _CADENA_TIMEOUT_GENERICO_ESPANOL           = 'el tiempo de espera para la operaci';
  _CADENA_TIMEOUT_GENERICO_INGLES            = 'timed out';
begin
  if (AnsiPos(_SIN_INTERNET, aExcepcion.Message) > 0) or (AnsiPos(_SIN_INTERNET_INGLES, aExcepcion.Message) > 0) then
    raise EPACProblemaConInternetException.Create('No se pudo realizar una conexion con el PAC: ' + aExcepcion.Message, 0, 0, True)
  else if (AnsiPos(_CADENA_ERROR_DNS_ESPANOL, aExcepcion.Message) > 0) or (AnsiPos(_CADENA_ERROR_DNS_INGLES, aExcepcion.Message) > 0) then
    raise EPACProblemaConInternetException.Create('No se pudo realizar una conexion con el PAC: ' + aExcepcion.Message, 0, 0, True)
  else if (AnsiPos(AnsiUpperCase(_CADENA_TIMEOUT_GENERICO_ESPANOL), AnsiUpperCase(aExcepcion.Message)) > 0) or (AnsiPos(AnsiUpperCase(_CADENA_TIMEOUT_GENERICO_INGLES), AnsiUpperCase(aExcepcion.Message)) > 0) then
    raise EPACProblemaTimeoutException.Create('No se pudo realizar una conexion con el PAC: ' + aExcepcion.Message, 0, 0, True)
  else
    raise EPACProblemaConInternetException.Create('No se pudo realizar una conexion con el PAC: ' + aExcepcion.Message, 0, 0, True);
end;

end.
