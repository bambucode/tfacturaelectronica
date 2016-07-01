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
        fFacturaGenerada : Boolean;
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

        fRecalcularImporte : Boolean;
        fTotal: Currency;
        fSubTotal: Currency;
        fTotalImpuestosRetenidos: Currency;
        fTotalImpuestosTrasladados: Currency;
        fTotalImpuestosLocalesTrasladados : Currency;
        fTotalImpuestosLocalesRetenidos : Currency;

        // Variables "cache"
        bHuboRetenciones: Boolean;
        bHuboTraslados: Boolean;

        fArrConceptos: TFEConceptos;
        fArrImpuestosTrasladados: TFEImpuestosTrasladados;
        fArrImpuestosRetenidos: TFEImpuestosRetenidos;
        FImpuestosLocales: TFEImpuestosLocales;
        FLugarDeExpedicion: String;
        FNumeroDeCuenta: String;

        // Funcion usada para obtener el importe de un concepto 
        function ObtenerImporte(Concepto: TFEConcepto) : Currency;
        function obtenerNumArticulos() : Integer;
        function getTotal() : Currency;
    public
        constructor Create(aRecalcularImporte : Boolean = True); overload;
        // Propiedades del comprobante normal
        property FacturaGenerada: Boolean read fFacturaGenerada write fFacturaGenerada;
        property Serie: TFESerie read fSerie write fSerie;
        property Folio: TFEFolio read fFolio write fFolio;
        property Emisor: TFEContribuyente read fEmisor write fEmisor;
        property Receptor: TFEContribuyente read fReceptor write fReceptor;
        property ExpedidoEn: TFeDireccion read fExpedidoEn write fExpedidoEn;
        property FormaDePago: TFEFormaDePago read fFormaDePago write fFormaDePago;
        property Tipo: TFeTipoComprobante read fTipoComprobante write fTipoComprobante;
        property Total: Currency read getTotal write fTotal;
        property SubTotal: Currency read fSubTotal write fSubTotal;
        property CondicionesDePago: String read fCondicionesDePago write fCondicionesDePago;
        property MetodoDePago: String read fMetodoDePago write fMetodoDePago;
        property FechaGeneracion : TDateTime read fFechaGeneracion write fFechaGeneracion;
        property Conceptos: TFEConceptos read fArrConceptos;
        property NumeroArticulos: Integer read obtenerNumArticulos;
        property ImpuestosRetenidos: TFEImpuestosRetenidos read fArrImpuestosRetenidos;
        property ImpuestosTrasladados: TFEImpuestosTrasladados read fArrImpuestosTrasladados;
        property TotalImpuestosRetenidos: Currency read fTotalImpuestosRetenidos;
        property TotalImpuestosTrasladados: Currency read fTotalImpuestosTrasladados;
        property DescuentoMonto: Currency read fDescuento;
        property DescuentoMotivo: String read fMotivoDescuento;
        property ImpuestosLocales: TFEImpuestosLocales read FImpuestosLocales;
        property LugarDeExpedicion: String read FLugarDeExpedicion write
            FLugarDeExpedicion;
        property NumeroDeCuenta: String read FNumeroDeCuenta write FNumeroDeCuenta;
        property TotalImpuestosLocalesRetenidos: Currency read
            FTotalImpuestosLocalesRetenidos;
        property TotalImpuestosLocalesTrasladados: Currency read
            FTotalImpuestosLocalesTrasladados;
        /// <summary>Agrega un nuevo concepto a la factura, regresa la posicion de dicho concepto en
        /// el arreglo de 'Conceptos'</summary>
        /// <param name="NuevoConcepto">Este es el nuevo concepto a agregar a la factura
        ///   el parametro es un "record" del tipo TFEConcepto.</param>
        function AgregarConcepto(NuevoConcepto: TFeConcepto) : Integer;

        {$REGION 'Documentation'}
        ///	<summary>
        ///	  Agrega un nuevo impuesto local (ISH, etc)
        ///	</summary>
        {$ENDREGION}
        function AgregarImpuestoLocal(aNuevoImpuestoLocal: TFEImpuestoLocal): Integer;
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
        procedure BorrarConceptos; virtual;
    end;

implementation

uses SysUtils;

constructor TDocumentoComprobanteFiscal.Create(aRecalcularImporte : Boolean = True);
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
  inherited Create;
  fRecalcularImporte := aRecalcularImporte;
end;

function TDocumentoComprobanteFiscal.obtenerNumArticulos() : Integer;
begin
  Result:=Length(fArrConceptos);
end;

function TDocumentoComprobanteFiscal.AgregarConcepto(NuevoConcepto: TFEConcepto) : Integer;
var
  importe : Currency;
begin
  SetLength(fArrConceptos, Length(fArrConceptos) + 1);
  fArrConceptos[Length(fArrConceptos) - 1] := NuevoConcepto;

  importe := NuevoConcepto.Importe;

  if fRecalcularImporte then
    importe := ObtenerImporte(NuevoConcepto);

  // Se Suma el total
  fSubtotal := fSubtotal + importe;

  Result:=Length(fArrConceptos) - 1;
end;

function TDocumentoComprobanteFiscal.AgregarImpuestoLocal(aNuevoImpuestoLocal:
    TFEImpuestoLocal): Integer;
begin
  SetLength(fImpuestosLocales, Length(fImpuestosLocales) + 1);
  fImpuestosLocales[Length(fImpuestosLocales) - 1] := aNuevoImpuestoLocal;

  case aNuevoImpuestoLocal.Tipo of
    tiRetenido    : fTotalImpuestosLocalesRetenidos := fTotalImpuestosLocalesRetenidos + aNuevoImpuestoLocal.Importe;
    tiTrasladado  : fTotalImpuestosLocalesTrasladados := fTotalImpuestosLocalesTrasladados + aNuevoImpuestoLocal.Importe;
  end;
  Result:=Length(fImpuestosLocales) - 1;
end;

function TDocumentoComprobanteFiscal.AgregarImpuestoRetenido(NuevoImpuesto: TFEImpuestoRetenido) : Integer;
begin
  // Convertimos el nombre del impuesto a mayusculas ya que el SAT usa todos sus impuestos en mayusculas
  NuevoImpuesto.Nombre := Uppercase(NuevoImpuesto.Nombre);

  SetLength(fArrImpuestosRetenidos, Length(fArrImpuestosRetenidos) + 1);
  fArrImpuestosRetenidos[Length(fArrImpuestosRetenidos) - 1] := NuevoImpuesto;
  fTotalImpuestosRetenidos:=fTotalImpuestosRetenidos + NuevoImpuesto.Importe;
  Result:=Length(fArrImpuestosRetenidos) - 1;
end;

function TDocumentoComprobanteFiscal.AgregarImpuestoTrasladado(NuevoImpuesto: TFEImpuestoTrasladado) : Integer;
begin
  // Convertimos el nombre del impuesto a mayusculas ya que el SAT usa todos sus impuestos en mayusculas
  NuevoImpuesto.Nombre := Uppercase(NuevoImpuesto.Nombre);

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

procedure TDocumentoComprobanteFiscal.BorrarConceptos;
begin
   SetLength(fArrConceptos, 0);
   fFacturaGenerada := False;
end;

function TDocumentoComprobanteFiscal.getTotal() : Currency;
begin
  // Esto ocurre en caso de que se establezca un total definido por otra instancia
  if fTotal > 0 then
    Result := fTotal
  else
    // Anexo 20:
    // Atributo requerido para representar la suma del subtotal, menos los descuentos aplicables,
    // más los impuestos trasladados, menos los impuestos retenidos.
    Result:=fSubTotal - fDescuento + (fTotalImpuestosTrasladados - fTotalImpuestosRetenidos) +
                                     (fTotalImpuestosLocalesTrasladados - fTotalImpuestosLocalesRetenidos);
end;

function TDocumentoComprobanteFiscal.ObtenerImporte(Concepto: TFEConcepto) : Currency;
begin
  Result := Concepto.ValorUnitario * Concepto.Cantidad;
end;

end.
