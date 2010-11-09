unit FacturaElectronica;

interface

uses FacturaTipos, ComprobanteFiscal;

type

TOnComprobanteGenerado = procedure() of Object;

///<summary>Representa una factura electronica sus metodos para generarla, leerla y validarla
/// cumpliendo la ley del Codigo Fiscal de la Federacion (CFF) Articulos 29 y 29-A.
/// (Soporta la version 2.0 de CFD)</summary>
TFacturaElectronica = class(TFEComprobanteFiscal)
private
  fArrConceptos: TFEConceptos;
  // Conceptos
  dDescuentos: Currency;
  dSubtotal: Currency;
  dTotal: Currency;
  dImpuestos : Currency;
  // Eventos:
  fOnComprobanteGenerado: TOnComprobanteGenerado;
  //procedure leerContenidoCertificado(sRuta: String);
public
  property Conceptos: TFEConceptos read fArrConceptos;
  /// <summary>Evento que es llamado inemdiatamente después de que el CFD fue generado,
  /// el cual puede ser usado para registrar en su sistema contable el registro de la factura
  // el cual es un requisito del SAT (Art 29, Fraccion VI)</summary>
  property OnComprobanteGenerado : TOnComprobanteGenerado read fOnComprobanteGenerado write fOnComprobanteGenerado;
  constructor Create(cEmisor, cCliente: TFEContribuyente; bfBloqueFolios: TFEBloqueFolios;
                     cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);
  destructor Destroy; override;
  /// <summary>Agrega un nuevo concepto a la factura, regresa la posicion de dicho concepto en
  /// el arreglo de 'Conceptos'</summary>
  /// <param name="NuevoConcepto">Este es el nuevo concepto a agregar a la factura
  ///   el parametro es un "record" del tipo TFEConcepto.</param>
  function AgregarConcepto(NuevoConcepto: TFeConcepto) : Integer;
  //procedure Leer(sRuta: String);

  /// <summary>Genera la factura (en XML) de acuerdo a todos los parametros especificados.
  ///    Una vez como XML se puede guardar en la BD, en archivo, etc.</summary>
  /// <param name="Folio">Este es el numero de folio que tendrá esta factura. Si
  ///    es la primer factura, deberá iniciar con el número 1 (Art. 29 Fraccion III)</param>
  procedure GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
  //function esValida() : Boolean;
  /// <summary>Genera la factura en formato cancelado</summary>
  // function Cancelar;
end;

const
	_RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
	_RFC_VENTA_EXTRANJEROS = '';

implementation

uses sysutils, Classes;

constructor TFacturaElectronica.Create(cEmisor, cCliente: TFEContribuyente;
            bfBloqueFolios: TFEBloqueFolios; cerCertificado: TFECertificado; tcTipo: TFETipoComprobante);
begin
    inherited Create;
    dSubtotal := 0;

    // TODO: Checar si la venta fue a un cliente publico en general
    // para dejar sus demas campos vacios.

    // Llenamos las propiedades de la clase padre "Comprobante".
    Emisor:=cEmisor;
    Receptor:=cCliente;
    BloqueFolios:=bfBloqueFolios;
    Tipo:=tcTipo;
    Certificado:=cerCertificado;

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

function TFacturaElectronica.AgregarConcepto(NuevoConcepto: TFEConcepto) : Integer;
begin
    SetLength(fArrConceptos, Length(fArrConceptos) + 1);
    fArrConceptos[Length(fArrConceptos) - 1] := NuevoConcepto;

    // Se Suma el total
    dSubtotal := dSubtotal + NuevoConcepto.Importe;
    dTotal:=dTotal + NuevoConcepto.Importe;

    Result:=Length(fArrConceptos) - 1;
end;

procedure TFacturaElectronica.GenerarYGuardar(iFolio: Integer; fpFormaDePago: TFEFormaDePago; sArchivo: String);
var
  I: Integer;
begin
     //if ValidarCamposNecesarios() = False then
     //    raise Exception.Create('No todos los campos estan llenos.');

     inherited Folio:=iFolio;
     inherited FormaDePago:=fpFormaDePago;

     // Agregamos todos los conceptos que fueron agregados previamente al arreglo
     for i := 0 to Length(fArrConceptos) - 1 do
         inherited AgregarConcepto(fArrConceptos[I]);
    
     // Asignamos el total y subtotal
     inherited Subtotal:=dSubtotal;

     // Generamos el archivo
     inherited GuardarEnArchivo(sArchivo);

     // Mandamos llamar el evento de que se genero la factura
     if Assigned(fOnComprobanteGenerado) then
        fOnComprobanteGenerado();
end;


end.
