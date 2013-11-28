{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2013 - Bambú Code SA de CV - Ing. Luis Carrasco

  Esta clase representa la estructura de un PAC Ejemplo para basarse en ella
  y poder implementar a un nuevo PAC. Se deben de implementar los 3 métodos
  definidos en la interfase IProveedorAutorizadoDeCertificacion

  Este archivo pertenece al proyecto de codigo abierto de Bambú Code:
  http://bambucode.com/codigoabierto

  La licencia de este código fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  ***************************************************************************** *}

unit PACEjemplo;

interface

uses Classes,
     xmldom,
     XMLIntf,
     msxmldom,
     XMLDoc,
     SysUtils,
     FacturaTipos,
     FeCFD;

type

 {$REGION 'Documentation'}
 ///	<summary>
 ///	  Implementa el servicio de timbrado para CFDI del proveedor "Comercio
 ///	  Digital" (<see href="http://www.comercio-digital.com.mx" />)
 ///	</summary>
 {$ENDREGION}
 TPACEjemplo = class(TInterfacedObject, IProveedorAutorizadoDeCertificacion)
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  private
{$ENDIF}
  fCredenciales : TFEPACCredenciales;
  fDocumentoXML : TXMLDocument;
public
  procedure AfterConstruction; override;
  procedure AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
  function CancelarDocumento(const aDocumento: string): Boolean;
  function TimbrarDocumento(const aDocumento: string): TFETimbre;
 end;

implementation


procedure TPACEjemplo.AfterConstruction;
begin
  inherited;
  fDocumentoXML := TXMLDocument.Create(nil);
  fDocumentoXML.Active := True;
end;

procedure TPACEjemplo.AsignarCredenciales(const aCredenciales: TFEPACCredenciales);
begin
  //
end;

function TPACEjemplo.CancelarDocumento(const aDocumento: string): Boolean;
begin
  // TODO: Implementar la cancelacion del documento por medio del API del PAC
end;

function TPACEjemplo.TimbrarDocumento(const aDocumento: string): TFETimbre;
begin
   // TODO: Aqui se debe de implementar el metodo que recibe el comprobante XML y lo manda
   // al PAC segun el API del mismo (SOAP, REST, etc)

   // NOTA: Debemos validar los posibles tipos de error que se pueden presentar:
   // EDocumentoTimbradoPreviamenteException

   // Posteriormente asignamos el resultado de esta funcion (tipo TFETimbre) y las propiedades
   // del mismo
end;

end.
