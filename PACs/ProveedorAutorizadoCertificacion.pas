{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la estructura de un PAC para basarse en ella
  y poder implementar a un nuevo PAC. Se deben de implementar los métodos
  definidos en esta clase.

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit ProveedorAutorizadoCertificacion;

interface

uses Classes,
     SysUtils,
     FacturaTipos;

type

// Definimos el tipo nativo en Delphi para enviar el XML al PAC
TTipoComprobanteXML = String;

{$REGION 'Documentation'}
///	<summary>
///	  Clase padre abstracta que representa a un proveedor autorizado de certificacion
///	  (PAC) y los métodos de timbrado y cancelación que todos deben de
///	  soportar. Todas las implementaciones de PAC deben heredar esta clase
///	</summary>
{$ENDREGION}
 TProveedorAutorizadoCertificacion = class
 protected
  function getNombre() : String; virtual; abstract;
 public
  property Nombre : String read getNombre;
  constructor Create(const aDominioWebService: string; const
      aDominioWebServiceSeguridad: String = ''; const aDominioWebServiceRespaldo:
      String = ''; const aDominioWebServiceCancelacion: string = ''); virtual;
      abstract;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); overload; virtual; abstract;
  procedure AsignarCredenciales(const aCredenciales, aCredencialesIntegrador: TFEPACCredenciales); overload; virtual; abstract;
  function ObtenerAcuseDeCancelacion(const aDocumento: TTipoComprobanteXML): string; virtual; abstract;
  function CancelarDocumento(const aDocumento: TTipoComprobanteXML): Boolean; virtual; abstract;
  function TimbrarDocumento(const aDocumento: TTipoComprobanteXML): TFETimbre; virtual; abstract;
  function AgregaCliente(const aNuevoEmisor: TFEContribuyente): String; virtual; abstract;
  function EditaCliente(const Activar: Boolean;const aRFC:String):String; virtual; abstract;
  function BorraCliente(const aRFC: String):String; virtual; abstract;
  function SaldoCliente(const aRFC: String) : Integer; virtual; abstract;
 end;

implementation

end.
