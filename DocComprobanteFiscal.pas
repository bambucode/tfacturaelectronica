unit DocComprobanteFiscal;

interface

uses FacturaTipos;

type

{

Representa a un comprobante fiscal (fisico, digital, etc) sus datos y metodos
para asignar sus propiedades
RESPONSABILIDAD:
- Almacenar los datos de un comprobante en las estructuras internas.
RAZON PARA CAMBIAR:
-
}
    TDocumentoComprobanteFiscal = class
    {$IFDEF VERSION_DE_PRUEBA}
     public
    {$ELSE}
     private
    {$ENDIF}
        bFacturaGenerada : Boolean;
        fEmisor: TFEContribuyente;
        fReceptor: TFEContribuyente;
        fFolio: TFEFolio;
        fFormaDePago: TFEFormaDePago;
        fTipoComprobante: TFeTipoComprobante;
        fExpedidoEn: TFeExpedidoEn;
        fFechaGeneracion: TDateTime;
        fCondicionesDePago: String;
        fMetodoDePago: String;
        sForma: String;
        fDescuento: Currency;
        fMotivoDescuento: String;
        fSerie: TFESerie;
        
        fTotal: Currency;
        fSubTotal: Currency;
        fTotalImpuestosRetenidos: Currency;
        fTotalImpuestosTrasladados: Currency;

        // Variables "cache"
        bHuboRetenciones: Boolean;
        bHuboTraslados: Boolean;

        fArrConceptos: TFEConceptos;
        fArrImpuestosTrasladados: TFEImpuestosTrasladados;
        fArrImpuestosRetenidos: TFEImpuestosRetenidos;

        // Funcion usada para obtener el importe de un concepto 
        function ObtenerImporte(Concepto: TFEConcepto) : Currency;
        function getTotal() : Currency;
    public
        constructor Create;
        // Propiedades del comprobante normal
        property FacturaGenerada: Boolean read bFacturaGenerada write bFacturaGenerada;
        property Serie: TFESerie read fSerie write fSerie;
        property Folio: TFEFolio read fFolio write fFolio;
        property Emisor: TFEContribuyente read fEmisor write fEmisor;
        property Receptor: TFEContribuyente read fReceptor write fReceptor;
        property ExpedidoEn: TFeDireccion read fExpedidoEn write fExpedidoEn;
        property FormaDePago: TFEFormaDePago read fFormaDePago write fFormaDePago;
        property Tipo: TFeTipoComprobante read fTipoComprobante write fTipoComprobante;
        property Total: Currency read getTotal;
        property SubTotal: Currency read fSubTotal write fSubTotal;
        property CondicionesDePago: String read fCondicionesDePago write fCondicionesDePago;
        property MetodoDePago: String read fMetodoDePago write fMetodoDePago;
        property FechaGeneracion : TDateTime read fFechaGeneracion write fFechaGeneracion;
        property Conceptos: TFEConceptos read fArrConceptos;
        property ImpuestosRetenidos: TFEImpuestosRetenidos read fArrImpuestosRetenidos;
        property ImpuestosTrasladados: TFEImpuestosTrasladados read fArrImpuestosTrasladados;
        property TotalImpuestosRetenidos: Currency read fTotalImpuestosRetenidos;
        property TotalImpuestosTrasladados: Currency read fTotalImpuestosTrasladados;
        property DescuentoMonto: Currency read fDescuento;
        property DescuentoMotivo: String read fMotivoDescuento;
        /// <summary>Agrega un nuevo concepto a la factura, regresa la posicion de dicho concepto en
        /// el arreglo de 'Conceptos'</summary>
        /// <param name="NuevoConcepto">Este es el nuevo concepto a agregar a la factura
        ///   el parametro es un "record" del tipo TFEConcepto.</param>
        function AgregarConcepto(NuevoConcepto: TFeConcepto) : Integer;
        /// <summary>Agrega un nuevo impuesto de retención (ISR, IVA) al comprobante</summary>
        /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre e importe del mismo</param>
        function AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido) : Integer;
        /// <summary>Agrega un nuevo impuesto de traslado (IVA, IEPS)</summary>
        /// <param name="NuevoImpuesto">El nuevo Impuesto con los datos de nombre, tasa e importe del mismo</param>
        function AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado) : Integer;
        /// <summary>Asigna el importe total de descuentos aplicados al comprobante asi como su motivo </summary>
        /// <param name="ImporteDescuento">El monto total de descuentos realizados al comprobante</param>
        /// <param name="Motivo">Atributo opcional para indicar el motivo del descuento</param>
        procedure AsignarDescuento(ImporteDescuento: Currency; Motivo: String);
    end;

implementation

constructor TDocumentoComprobanteFiscal.Create;
begin
    // TODO LO SIGUIENTE LO HACE DELPHI POR NOSOTROS:
    // Rewrite:
    {fTotal:=0;
    fSubTotal:=0;
    fTotalImpuestosRetenidos:=0;
    fTotalImpuestosTrasladados:=0;
    bFacturaGenerada := False;
    bHuboRetenciones:=False;
    bHuboTraslados:=False; }
end;

function TDocumentoComprobanteFiscal.AgregarConcepto(NuevoConcepto: TFEConcepto) : Integer;
begin
    SetLength(fArrConceptos, Length(fArrConceptos) + 1);
    fArrConceptos[Length(fArrConceptos) - 1] := NuevoConcepto;

    // Se Suma el total
    fSubtotal := fSubtotal + ObtenerImporte(NuevoConcepto);
    fTotal:=fTotal + ObtenerImporte(NuevoConcepto);

    Result:=Length(fArrConceptos) - 1;
end;

function TDocumentoComprobanteFiscal.AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido) : Integer;
begin
    SetLength(fArrImpuestosRetenidos, Length(fArrImpuestosRetenidos) + 1);
    fArrImpuestosRetenidos[Length(fArrImpuestosRetenidos) - 1] := NuevoImpuesto;
    fTotalImpuestosRetenidos:=fTotalImpuestosRetenidos + NuevoImpuesto.Importe;
    Result:=Length(fArrImpuestosRetenidos) - 1;
end;

function TDocumentoComprobanteFiscal.AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado) : Integer;
begin
    SetLength(fArrImpuestosTrasladados, Length(fArrImpuestosTrasladados) + 1);
    fArrImpuestosTrasladados[Length(fArrImpuestosTrasladados) - 1] := NuevoImpuesto;
    fTotalImpuestosTrasladados:=fTotalImpuestosTrasladados + NuevoImpuesto.Importe;
    Result:=Length(fArrImpuestosTrasladados) - 1;
end;

procedure TDocumentoComprobanteFiscal.AsignarDescuento(ImporteDescuento: Currency; Motivo: String);
begin
  fDescuento := ImporteDescuento;
  fMotivoDescuento := Motivo;
end;

function TDocumentoComprobanteFiscal.getTotal() : Currency;
begin
    Result:=fSubTotal + fTotalImpuestosRetenidos + fTotalImpuestosTrasladados - fDescuento;
end;

function TDocumentoComprobanteFiscal.ObtenerImporte(Concepto: TFEConcepto) : Currency;
begin
    Result:=Concepto.ValorUnitario * Concepto.Cantidad;
end;

end.
