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

{$REGION 'Documentation'}
///	<summary>
///	  Clase padre abstracta que representa a un proveedor autorizado de certificacion
///	  (PAC) y los métodos de timbrado y cancelación que todos deben de
///	  soportar. Todas las implementaciones de PAC deben heredar esta clase
///	</summary>
{$ENDREGION}
 TProveedorAutorizadoCertificacion = class
 public
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales); virtual; abstract;
  function CancelarDocumento(const aDocumento: string): Boolean; virtual; abstract;
  function TimbrarDocumento(const aDocumento: string): TFETimbre; virtual; abstract;
 end;

implementation

end.
