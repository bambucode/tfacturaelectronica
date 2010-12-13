unit FacturaElectronica;

interface

uses FacturaTipos, ComprobanteFiscal;

type

TOnComprobanteGenerado = procedure(Sender: TObject) of Object;

///<summary>Representa una factura electronica sus metodos para generarla, leerla y validarla
/// cumpliendo la ley del Codigo Fiscal de la Federacion (CFF) Articulos 29 y 29-A.
/// (Soporta la version 2.0 de CFD)</summary>
TFacturaElectronica = class(TFEComprobanteFiscal)
{$IFDEF VERSION_DE_PRUEBA}
  public
{$ELSE}
  private
{$ENDIF}
  fOnComprobanteGenerado: TOnComprobanteGenerado;
  function obtenerCertificado() : TFECertificado;
published
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

  /// <summary>Evento que es llamado inemdiatamente después de que el CFD fue generado,
  /// el cual puede ser usado para registrar en su sistema contable el registro de la factura
  // el cual es un requisito del SAT (Art 29, Fraccion VI)</summary>
  property OnComprobanteGenerado : TOnComprobanteGenerado read fOnComprobanteGenerado write fOnComprobanteGenerado;
  constructor Create(cEmisor, cCliente: TFEContribuyente; bfBloqueFolios: TFEBloqueFolios;
                     cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);
  destructor Destroy; override;


  //procedure Leer(sRuta: String);
  /// <summary>Genera el archivo XML de la factura electrónica con el sello, certificado, etc</summary>
  /// <param name="Folio">Este es el numero de folio que tendrá esta factura. Si
  /// es la primer factura, deberá iniciar con el número 1 (Art. 29 Fraccion III)</param>
  /// <param name="fpFormaDePago">Forma de pago de la factura (Una sola exhibición o parcialidades)</param>
  /// <param name="sArchivo">Nombre del archivo junto con la ruta en la que se guardará el archivo XML</param>
  procedure GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
  //function esValida() : Boolean;
  /// <summary>Genera la factura en formato cancelado</summary>
  // function Cancelar;
end;

const
	_RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
	_RFC_VENTA_EXTRANJEROS        = 'XEXX010101000';

implementation

uses sysutils, Classes;

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

    // TODO: Implementar CFD 3.0 y usar la version segun sea necesario...
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
procedure TFacturaElectronica.GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
begin
     //if ValidarCamposNecesarios() = False then
     //    raise Exception.Create('No todos los campos estan llenos.');

     if (inherited Receptor.RFC = '') then
        Raise Exception.Create('No hay un receptor configurado');

     // Especificamos los campos del CFD en el orden especifico
     // ya que de lo contrario no cumplirá con los requisitios del SAT
     inherited Folio:=iFolio;
     inherited FormaDePago:=fpFormaDePago;

     
     // Generamos el archivo
     inherited GuardarEnArchivo(sArchivo);
     
     // Mandamos llamar el evento de que se genero la factura
     if Assigned(fOnComprobanteGenerado) then
        fOnComprobanteGenerado(Self);
end;


end.
