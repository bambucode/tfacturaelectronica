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
   end;

implementation

uses SOAPHTTPTrans;

class procedure TManejadorErroresComunes.LanzarExcepcionSiDetectaFallaInternet(const aExcepcion: Exception);
begin
  if aExcepcion <> nil then
  begin
    {$IFDEF CODESITE}
      CodeSite.SendError(aExcepcion);
    {$ENDIF}

    if aExcepcion Is ESOAPHttpException then
    begin
      // Lista de codigos de error estandares:
      // http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_Error
      case ESOAPHttpException(aExcepcion).StatusCode of
        502, 503, 504, 522: raise EPACProblemaConInternetException.Create('No se pudo realizar una conexion con el PAC: ' +
                                                           aExcepcion.Message, 0, 0, True);
      end;

    end;
  end;
end;

end.
