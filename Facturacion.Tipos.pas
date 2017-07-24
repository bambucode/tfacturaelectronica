unit Facturacion.Tipos;

interface

uses System.SysUtils;

type

{$REGION 'Excepciones de validacion de la matriz de validaciones de CFDI 3.3'}
  ESATErrorGenericoException = class(Exception)
  private
    fCodigoError: Integer;
    fReintentable: Boolean;
  public
    constructor Create(const aMensajeExcepcion: String;
      const aCodigoError: Integer; const aReintentable: Boolean);
    property CodigoError: Integer read fCodigoError;
    property Reintentable: Boolean read fReintentable default false;
  end;


  // Listado de excepciones lanzadas de acuerdo a la Matriz de Erroes publicada
  // en el Anexo 20:
  // http://www.sat.gob.mx/informacion_fiscal/factura_electronica/Paginas/Anexo_20_version3.3.aspx
  // NOTA: Solo se implementaron las excepciones más comunes
  // si se desea se puede agregar el resto de las excepciones faltantes.

  // Los errores técnicos, donde se omiten nodos, no coincide, etc. no se calculó bien, etc
  // serán heredados de la siguiente excepcion. Estos errores deberán ser corregidos
  // en la librería directamente
  ESATErrorTecnicoXMLException            = class(ESATErrorGenericoException);
  // Los errores de "configuracion" donde algun dato del emisor está mal segun el SAT
  ESATDatoEmisorIncorrectoException       = class(ESATErrorGenericoException);
  ESATDatoReceptorIncorrectoException     = class(ESATErrorGenericoException);
  // Cuando algun valor de un campo de catalogo no existió en el mismo
  ESATValorNoEnCatalogoException          = class(ESATErrorGenericoException);
  // Existió un error arimético en el XML
  ESATProblemaDeLlenadoException          = class(ESATErrorGenericoException);
  ESATCampoConfirmacionRequeridoException = class(ESATErrorGenericoException);
  ESATNoIdentificadoException             = class(ESATErrorGenericoException); // CFDI33196

{$ENDREGION}

const
  _RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
  _RFC_VENTA_EXTRANJEROS        = 'XEXX010101000';

implementation

constructor ESATErrorGenericoException.Create(const aMensajeExcepcion: String;
  const aCodigoError: Integer; const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion);
  fReintentable := aReintentable;
  fCodigoError := aCodigoError;
end;

end.
