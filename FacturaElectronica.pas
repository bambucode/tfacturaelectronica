{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambu Code SA de CV

  Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
  los metodos para generarla.

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  Cambios para CFDI v3.2 Por Ing. Pablo Torres TecSisNet.net Cd. Juarez Chihuahua
  el 11-24-2013
***************************************************************************** *}

unit FacturaElectronica;

interface

uses FacturaTipos,
     ComprobanteFiscal;

type

TOnComprobanteGenerado = procedure(Sender: TObject) of Object;
TOnComprobanteTimbrado = procedure(Sender: TObject) of Object;

///<summary>Representa una factura electronica sus metodos para generarla, leerla y validarla
/// cumpliendo la ley del Codigo Fiscal de la Federacion (CFF) Articulos 29 y 29-A.
/// (Soporta la version 2.0/2.2/3.2 de CFD)</summary>
TFacturaElectronica = class(TFEComprobanteFiscal)
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  strict private
{$ENDIF}
  fCertificadoUsado: TFECertificado;
  fComprobanteGenerado : Boolean;
  fOnComprobanteTimbrado : TOnComprobanteTimbrado;
  fOnComprobanteGenerado: TOnComprobanteGenerado;
   fRecalcularImporte: Boolean;
  function GetonComprobanteTimbrado: TOnComprobanteTimbrado;
  function obtenerCertificado() : TFECertificado;
  procedure SetonComprobanteTimbrado(const Value: TOnComprobanteTimbrado);
protected
  function getXML: WideString; override;
  procedure setXML(const Valor: WideString); override;
public
  property FechaGeneracion;
  property FacturaGenerada;
  property Folio;
  property SubTotal;
  property Total;
  property Conceptos;
  property ImpuestosRetenidos;
  property ImpuestosTrasladados;
  property onComprobanteTimbrado: TOnComprobanteTimbrado read
      GetonComprobanteTimbrado write SetonComprobanteTimbrado;
public
  /// <summary>Evento que es llamado inemdiatamente después de que el CFD fue generado,
  /// el cual puede ser usado para registrar en su sistema contable el registro de la factura
  // el cual es un requisito del SAT (Art 29, Fraccion VI)</summary>
  property OnComprobanteGenerado : TOnComprobanteGenerado read fOnComprobanteGenerado write fOnComprobanteGenerado;

  constructor Create(cEmisor, cCliente: TFEContribuyente; bfBloqueFolios: TFEBloqueFolios;
                     cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);  overload; deprecated;
  constructor Create(cEmisor, cCliente: TFEContribuyente; cerCertificado: TFECertificado;
                      tcTipo: TFETipoComprobante; aRecalcularImporte :Boolean = True);  overload;

  destructor Destroy; override;
  procedure AfterConstruction; override;
  /// <summary>Genera el archivo XML de la factura electrónica con el sello, certificado, etc</summary>
  /// <param name="Folio">Este es el numero de folio que tendrá esta factura. Si
  /// es la primer factura, deberá iniciar con el número 1 (Art. 29 Fraccion III)</param>
  /// <param name="fpFormaDePago">Forma de pago de la factura (Una sola exhibición o parcialidades)</param>
  /// <param name="sArchivo">Nombre del archivo junto con la ruta en la que se guardará el archivo XML</param>
  procedure GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String); deprecated;
  procedure Generar(const aFolio: Integer; aFormaDePago: TFEFormaDePago);
  procedure Guardar(const aArchivoDestino: String);
  procedure AsignarTimbreFiscal(const aTimbre: TFETimbre); override;
published
  constructor Create(aRecalcularImporte :Boolean = True); overload;
end;

implementation

uses sysutils, Classes;

constructor TFacturaElectronica.Create(aRecalcularImporte :Boolean = True);
begin
  inherited Create(fev32, aRecalcularImporte);
end;

constructor TFacturaElectronica.Create(cEmisor, cCliente: TFEContribuyente; cerCertificado: TFECertificado;
                      tcTipo: TFETipoComprobante; aRecalcularImporte :Boolean = True);
begin
  // Si usamos este constructor que no usa bloque de folios creamos un CFDI 3.2 por default
  inherited Create(fev32, aRecalcularImporte);
  // Llenamos las variables internas con las de los parametros
  inherited Emisor:=cEmisor;
  inherited Receptor:=cCliente;
  inherited Tipo:=tcTipo;

  fCertificadoUsado := cerCertificado;
end;

procedure TFacturaElectronica.AfterConstruction;
begin
  inherited;

  // REWRITE: Validamos aqui que el certificado sea valido
  if fCertificadoUsado.Ruta <> '' then
  begin
    inherited Certificado:=fCertificadoUsado;
  end;
end;

constructor TFacturaElectronica.Create(cEmisor, cCliente: TFEContribuyente;
            bfBloqueFolios: TFEBloqueFolios; cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);
begin
    // Si usamos este metodo que usa bloque de folios creamos por default un CFD 2.2
    inherited Create(fev22);
    // Llenamos las variables internas con las de los parametros
    inherited Emisor:=cEmisor;
    inherited Receptor:=cCliente;

    // REWRITE: Validamos aqui el bloque de folios que sea valido
    inherited BloqueFolios:=bfBloqueFolios;
    // REWRITE: Validamos aqui que el certificado sea valido
    inherited Certificado:=cerCertificado;
    inherited Tipo:=tcTipo;
end;

destructor TFacturaElectronica.Destroy();
begin
   inherited Destroy;
end;



// Obtenemos el certificado de la clase padre para obtener el record
// con los datos de serie, no aprobacion, etc.
function TFacturaElectronica.obtenerCertificado() : TFECertificado;
begin
    Result:=inherited Certificado;
end;

procedure TFacturaElectronica.Generar(const aFolio: Integer; aFormaDePago: TFEFormaDePago);
begin
  if (inherited Receptor.RFC = '') then
      Raise Exception.Create('No hay un receptor configurado');

   // Especificamos los campos del CFD en el orden especifico
   // ya que de lo contrario no cumplirá con los requisitios del SAT
   inherited Folio:=aFolio;
   inherited FormaDePago:=aFormaDePago;

   // Generamos la factura solo en memoria
   inherited GenerarComprobante;

   fComprobanteGenerado := True;

   // Mandamos llamar el evento de que se genero la factura
   if Assigned(fOnComprobanteGenerado) then
      fOnComprobanteGenerado(Self);
end;

procedure TFacturaElectronica.Guardar(const aArchivoDestino: String);
begin
   if Not fComprobanteGenerado then
     raise Exception.Create('Es necesario se mande generar la factura antes de ser guardada');

   inherited GuardarEnArchivo(aArchivoDestino);
end;

procedure TFacturaElectronica.GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
begin
     Generar(iFolio, fpFormaDePago);
     Guardar(sArchivo);
end;

procedure TFacturaElectronica.AsignarTimbreFiscal(const aTimbre: TFETimbre);
begin
  inherited AsignarTimbreFiscal(aTimbre);

  // Mandamos llamar el evento de que se asigno el timbrado
  if Assigned(fOnComprobanteTimbrado) then
    fOnComprobanteTimbrado(Self);
end;

function TFacturaElectronica.getXML: WideString;
begin
  Result := inherited getXML;
end;

procedure TFacturaElectronica.setXML(const Valor: WideString);
begin
  inherited setXML(Valor);
  // Si se establece un XML indicamos que ya se genero(sello) la factura
  fComprobanteGenerado := True;
end;

function TFacturaElectronica.GetonComprobanteTimbrado: TOnComprobanteTimbrado;
begin
  Result := fOnComprobanteTimbrado;
end;

procedure TFacturaElectronica.SetonComprobanteTimbrado(const Value:
    TOnComprobanteTimbrado);
begin
  fOnComprobanteTimbrado := Value;
end;


end.
