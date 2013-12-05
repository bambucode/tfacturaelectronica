unit FacturaElectronica;

interface

uses FacturaTipos, ComprobanteFiscal;

type

TOnComprobanteGenerado = procedure(Sender: TObject) of Object;

///<summary>Representa una factura electronica sus metodos para generarla, leerla y validarla
/// cumpliendo la ley del Codigo Fiscal de la Federacion (CFF) Articulos 29 y 29-A.
/// (Soporta la version 2.0/2.2/3.2 de CFD)</summary>
TFacturaElectronica = class(TFEComprobanteFiscal)
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  private
{$ENDIF}
  fComprobanteGenerado : Boolean;
  fOnComprobanteGenerado: TOnComprobanteGenerado;
  function obtenerCertificado() : TFECertificado;
public
  property FechaGeneracion;
  property FacturaGenerada;
  property Folio;
  property SubTotal;
  property Conceptos;
  property ImpuestosRetenidos;
  property ImpuestosTrasladados;
{protected
  procedure setXML(Valor: WideString); override;
  function getXML() : WideString;  }
public
  //property XML : WideString read getXML write setXML;
  /// <summary>Evento que es llamado inemdiatamente despu�s de que el CFD fue generado,
  /// el cual puede ser usado para registrar en su sistema contable el registro de la factura
  // el cual es un requisito del SAT (Art 29, Fraccion VI)</summary>
  property OnComprobanteGenerado : TOnComprobanteGenerado read fOnComprobanteGenerado write fOnComprobanteGenerado;
  constructor Create(cEmisor, cCliente: TFEContribuyente; bfBloqueFolios: TFEBloqueFolios;
                     cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);  overload;
  destructor Destroy; override;
  //procedure Leer(sRuta: String);
  /// <summary>Genera el archivo XML de la factura electr�nica con el sello, certificado, etc</summary>
  /// <param name="Folio">Este es el numero de folio que tendr� esta factura. Si
  /// es la primer factura, deber� iniciar con el n�mero 1 (Art. 29 Fraccion III)</param>
  /// <param name="fpFormaDePago">Forma de pago de la factura (Una sola exhibici�n o parcialidades)</param>
  /// <param name="sArchivo">Nombre del archivo junto con la ruta en la que se guardar� el archivo XML</param>
  procedure GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
  //function esValida() : Boolean;
  /// <summary>Genera la factura en formato cancelado</summary>
  // function Cancelar;
  procedure Generar(const aFolio: Integer; aFormaDePago: TFEFormaDePago);
  procedure Guardar(const aArchivoDestino: String);
published
  constructor Create; overload;
end;

implementation

uses sysutils, Classes;

constructor TFacturaElectronica.Create;
begin
  inherited Create;
end;

constructor TFacturaElectronica.Create(cEmisor, cCliente: TFEContribuyente;
            bfBloqueFolios: TFEBloqueFolios; cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);
begin
    inherited Create;
    // Llenamos las variables internas con las de los parametros
    inherited Emisor:=cEmisor;
    inherited Receptor:=cCliente;

    // REWRITE: Validamos aqui el bloque de folios que sea valido
    inherited BloqueFolios:=bfBloqueFolios;
    // REWRITE: Validamos aqui que el certificado sea valido
    inherited Certificado:=cerCertificado;
    inherited Tipo:=tcTipo;

    // TODO: Implementar CFD 3.02 y usar la version segun sea necesario...
    // Que version de CFD sera usada?
    {if (Now < EncodeDate(2011,1,1)) then
      fComprobante := TFEComprobanteFiscal.Create;
    else
      fVersion:=TFEComprobanteFiscalV3.Create; }
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

{
function TFacturaElectronica.getXML() : WideString;
begin
    Result:=inherited XML;
end;

procedure TFacturaElectronica.setXML(Valor: WideString);
var
  I: Integer;
begin
    // Leemos el XML en el Comprobante
    inherited XML:=Valor;
end;
 }

procedure TFacturaElectronica.Generar(const aFolio: Integer; aFormaDePago: TFEFormaDePago);
begin
  if (inherited Receptor.RFC = '') then
      Raise Exception.Create('No hay un receptor configurado');

   // Especificamos los campos del CFD en el orden especifico
   // ya que de lo contrario no cumplir� con los requisitios del SAT
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


end.
