unit Facturacion.Tipos;

interface

uses
{$IF CompilerVersion >= 23}
     System.SysUtils
{$ELSE}
     SysUtils
{$IFEND};

type

  {$IFDEF undef}{$REGION 'Documentation'}{$ENDIF}
  ///	<summary>
  ///	  <para>
  ///	    Excepcion heredable que tiene la propiedad Reintentable para saber si
  ///	    dicha falla es temporal y el programa cliente debe de re-intentar la
  ///	    �ltima petici�n.
  ///	  </para>
  ///	  <para>
  ///	    Si su valor es Falso es debido a que la falla est� del lado del cliente
  ///	    y el PAC no puede procesar dicha petici�n (XML incorrecto, Sello mal
  ///	    generado, etc.)
  ///	  </para>
  ///	</summary>
  {$IFDEF undef}{$ENDREGION}{$ENDIF}
  ECFDIException = class(Exception)
  protected
    fReintentable : Boolean;
  public
    constructor Create(const aMensaje: string; const aReintentable: Boolean);
    property Reintentable : Boolean read fReintentable default false;
  end;

  {$IFDEF undef}{$REGION 'Excepciones de validacion de la matriz de validaciones de CFDI 3.3'}{$ENDIF}
  ESATErrorGenericoException = class(ECFDIException)
  private
    fCodigoError: Integer;
  public
    constructor Create(const aMensajeExcepcion: String; const aCodigoError: Integer; const aReintentable: Boolean);
    property CodigoError: Integer read fCodigoError;
  end;


  // Listado de excepciones lanzadas de acuerdo a la Matriz de Erroes publicada
  // en el Anexo 20:
  // http://www.sat.gob.mx/informacion_fiscal/factura_electronica/Paginas/Anexo_20_version3.3.aspx
  // NOTA: Solo se implementaron las excepciones m�s comunes
  // si se desea se puede agregar el resto de las excepciones faltantes.

  // Los errores t�cnicos, donde se omiten nodos, no coincide, etc. no se calcul� bien, etc
  // ser�n heredados de la siguiente excepcion. Estos errores deber�n ser corregidos
  // en la librer�a directamente
  ESATErrorTecnicoXMLException                    = class(ESATErrorGenericoException);
  // Error en el certificado, probablemente certificado caduco
  ESATErrorEnCertificadoException                 = class(ESATErrorGenericoException);
  // Los errores de "configuracion" donde algun dato del emisor est� mal segun el SAT
  ESATDatoEmisorIncorrectoException               = class(ESATErrorGenericoException);
  ESATDatoReceptorIncorrectoException             = class(ESATErrorGenericoException);
  // El porcentaje del impuesto tiene un valor fuera del catalogo de tasas c_TasaOCuota.json
  ESAImpuestoTasaIncorrectaException              = class(ESATErrorGenericoException);
  // Cuando algun valor de un campo de catalogo no existi� en el mismo
  ESATValorNoEnCatalogoException                  = class(ESATErrorGenericoException);
  // El uso de cfdi no es valido para el receptor
  EUsoCFDIIncorrectoException                     = class(ESATErrorGenericoException);
  // Existi� un error arim�tico en el XML
  ESATProblemaDeLlenadoException                  = class(ESATErrorGenericoException);
  ESATCampoConfirmacionRequeridoException         = class(ESATErrorGenericoException);
  ESATNoIdentificadoException                     = class(ESATErrorGenericoException); // CFDI33196
  ESATRFCNoPerteneceFronteraException             = class(ESATErrorGenericoException); // CFDI33196
  ESATCodigoPostalNoPerteneceFronteraException    = class(ESATErrorGenericoException); // CFDI33196
  ESATEstimuloFronteraNoAplicaAlProductoException = class(ESATErrorGenericoException); // CFDI33196
  {$IFDEF undef}{$ENDREGION}{$ENDIF}

const
  _RFC_VENTA_PUBLICO_EN_GENERAL         = 'XAXX010101000';
  _RFC_VENTA_EXTRANJEROS                = 'XEXX010101000';
  _NOMBRE_CONTRIBUYENTE_PUBLICO_GENERAL = 'P�blico en General';
  _NOMBRE_CONTRIBUYENTE_EXTRANJERO      = 'Venta al extranjero';
  _UUID_LONGITUD                        = 36;

implementation

constructor ESATErrorGenericoException.Create(const aMensajeExcepcion: String;
  const aCodigoError: Integer; const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion, aReintentable);
  fCodigoError := aCodigoError;
end;

constructor ECFDIException.Create(const aMensaje: string; const aReintentable: Boolean);
begin
  inherited Create(aMensaje);
  fReintentable := aReintentable;
end;

end.
