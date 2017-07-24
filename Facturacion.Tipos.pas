unit Facturacion.Tipos;

interface

uses SysUtils;

type

  {$REGION 'Excepciones de validacion de la matriz de validaciones de CFDI 3.3'}
  ESATErrorGenericoException = class(Exception)
  private
    fCodigoError: Integer;
    fReintentable : Boolean;
  public
    constructor Create(const aMensajeExcepcion: String;
                       const aCodigoError: Integer;
                       const aReintentable: Boolean);
    property CodigoError: Integer read fCodigoError;
    property Reintentable : Boolean read fReintentable default false;
  end;


  // Listado de excepciones lanzadas de acuerdo a la Matriz de Erroes publicada
  // en el Anexo 20:
  // http://www.sat.gob.mx/informacion_fiscal/factura_electronica/Paginas/Anexo_20_version3.3.aspx
  // NOTA: Solo se implementaron las excepciones más comunes
  // si se desea se puede agregar el resto de las excepciones faltantes.

  ESATFechaIncorrectaException                = class(ESATErrorGenericoException); // CFDI33101
  ESATSelloIncorrectoException                = class(ESATErrorGenericoException); // CFDI33102
  ESATFormaPagoSinValorDeCatalogoException    = class(ESATErrorGenericoException); // CFDI33104
  ESATCertificadoIncorrectoException          = class(ESATErrorGenericoException); // CFDI33105
  ESATLugarDeExpedicionNoValidoException      = class(ESATErrorGenericoException); // CFDI33125
  ESATRFCReceptorNoEnListaValidosException     = class(ESATErrorGenericoException); // CFDI33132
  ESATClaveProdServNoValidaException          = class(ESATErrorGenericoException); // CFDI33142

  ESATNoIdentificadoException                 = class(ESATErrorGenericoException); // CFDI33196

const
  _RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
  _RFC_VENTA_EXTRANJEROS        = 'XEXX010101000';

implementation

constructor ESATErrorGenericoException.Create(const aMensajeExcepcion: String;
                       const aCodigoError: Integer;
                       const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion);
  fReintentable := aReintentable;
  fCodigoError  := aCodigoError;
end;

end.
