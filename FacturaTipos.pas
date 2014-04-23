(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV

 Define las estructuras usadas como parametros para generar la factura
 electrónica. Pensado por si en el futuro el SAT cambia las estructuras
 sean fácilmente extendibles sin necesidad de cambiar el código que lo haya
 usado con anterioridad.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit FacturaTipos;

interface

uses SysUtils;

type

// El tipo de String en el que debe estar codificada la "Cadena Original"
// ya que al estar en UTF8 Delphi 2007 necesita que sea del tipo UTF8String
// y si es Delphi 2009 o superior necesita que sea RawByteString
// Si NO se usan estos tipos de datos se pierden caracteres en memoria
{$IF Compilerversion >= 20}
TStringCadenaOriginal = RawByteString;
{$ELSE}
TStringCadenaOriginal = UTF8String;
{$IFEND}

TFEFolio = Integer;
TFESerie = String[10];

TFEFormaDePago = (fpUnaSolaExhibicion, fpParcialidades);
TFETipoComprobante = (tcIngreso, tcEgreso, tcTraslado);

// Versiones de CFD soportadas, en caso de que se lea un XML y no este dentro de estas versiones
// se lanzara una excepcion
TFEVersionComprobante = (fev20, fev22,fev32);

TFEDireccion = record
  Calle: String;
	NoExterior: String;
	NoInterior: String;
	CodigoPostal: String;
	Colonia: String;
  Municipio: String;
	Estado: String;
	Pais: String;
	Localidad: String;
  Referencia: String;
end;

// Expedido en es un "alias" de direccion, la definimos por si en el
// futuro diferente en algo a al direccion
TFEExpedidoEn = TFEDireccion;

TFEDocumentoAduanero = record
  Numero: String;
  Fecha: TDateTime;
  Aduana: String;
end;

TFERFC = String[13];

// Un regimen es una cadena
TFERegimenes = Array of String;

TFEContribuyente = record
	Nombre: String;
	RFC: TFERFC;
  Direccion: TFeDireccion;
  ExpedidoEn: TFEExpedidoEn;
  // Un contribuyente puede tener muchos regímenes fiscales
  Regimenes : TFERegimenes;
  // Atributo opcional para almacenar el correo del contribuyente
  CorreoElectronico : String;
end;

// Pre-definimos los tipos de contribuyentes de Publico en General y Extranjero
TContribuyentePublicoGeneral = TFEContribuyente;
TContribuyenteExtranjero = TFEContribuyente;

TFEDatosAduana = record
  NumeroDocumento: String;
  FechaExpedicion: TDateTime;
  Aduana: String;
end;

TFEConcepto = record
  Cantidad: Double;
  Unidad: String;
  Descripcion: String;
  ValorUnitario: Currency;
  // Datos opcionales
  NoIdentificacion: String;
  DatosAduana: TFEDatosAduana;
  CuentaPredial: String;
  Extra: String;
end;

TFEConceptos = Array of TFEConcepto;

TFELlavePrivada = record
   Ruta: String;
   Clave: String;
end;

// Tipo del certificado leido (usado por Clase TCertificadoSellos)
TFETipoCertificado = (tcSellos, tcFIEL);

TFECertificado = record
    Ruta: String;
    LlavePrivada: TFELlavePrivada;
    VigenciaInicio: TDateTime;
    VigenciaFin: TDateTime;
    NumeroSerie: String;
    RFCAlQuePertenece: string;
end;

TFEBloqueFolios = record
    NumeroAprobacion: Integer;
    AnoAprobacion: Integer;
    Serie: TFESerie; // Opcional
    FolioInicial: Integer;
    FolioFinal: Integer;
end;

TFEImpuestoRetenido = record
  Nombre : String; // IVA, ISR
  Importe: Currency;
end;

TFEImpuestosRetenidos = Array of TFEImpuestoRetenido;

TTipoImpuestoLocal = (tiRetenido, tiTrasladado);

TFEImpuestoLocal = record
  Nombre: String;
  Tasa: Double;
  Importe : Currency;
  Tipo: TTipoImpuestoLocal;
end;

TFEImpuestosLocales = Array of TFEImpuestoLocal;

TFETimbre = record
  Version : WideString;
  UUID : WideString;
  FechaTimbrado : TDateTime;
  SelloCFD : WideString;
  NoCertificadoSAT : WideString;
  SelloSAT : WideString;
  XML: WideString;
end;

TFEImpuestoTrasladado = record
    Nombre: String; // IVA, IEPS
    Tasa: Double;
    Importe : Currency;
end;

TFEImpuestosTrasladados = Array of TFEImpuestoTrasladado;

// Usado por la clase ReporteMensual
TFEPedimentos = Array of TFEDatosAduana;

TOnTimbradoRecibidoEvent = procedure(Sender: TObject; const aTimbre: TFETimbre) of Object;

TFEPACCredenciales = record
  RFC: string;
  Clave: String;
  DistribuidorID: string; // Usado por algunos PAC para la comunicacion (Ej: Ecodex)
  Certificado: TFECertificado;
end;

EFECertificadoNoExisteException = class(Exception);
EFECertificadoNoEsDeSellosException = class(Exception);
EFELlavePrivadaNoCorrespondeACertificadoException = class(Exception);
EFECertificadoNoVigente =  class(Exception);
EFECertificadoNoCorrespondeAEmisor = class(Exception);
EFECertificadoNoFueLeidoException = class(Exception);

{$REGION 'Errores durante generacion de CFD/I'}
EFEAtributoRequeridoNoPresenteException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Esta excepción se lanza cuando se intenta leer un XML de un CFD/I de una
///	  versión aun no soportada. Pensado para evitar leer futuras versiones aun
///	  no implementadas.
///	</summary>
{$ENDREGION}
EFEVersionComprobanteNoSoportadaException = class(Exception);
{$ENDREGION}

{$REGION 'Otras excepciones que se presentan al usar el comprobante fiscal'}

{$REGION 'Documentation'}
///	<summary>
///	  Este error se presenta cuando se intenta acceder a una propiedad que la
///	  version especifica del CFD no soporta, por ejemplo cuando se quiere
///	  obtener el timbre de un CFD 2.2, etc.
///	</summary>
{$ENDREGION}
EComprobanteNoSoportaPropiedadException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Esta excepcion se lanza cuando el XML del CFD no tuvo una estrucutra
///	  correcta o estaba mal formado, etc.
///	</summary>
{$ENDREGION}
EComprobanteEstructuraIncorrectaException = class(Exception);
{$ENDREGION}


{$REGION 'Documentation'}
///	<summary>
///	  <para>
///	    Excepcion heredable que tiene la propiedad Reintentable para saber si
///	    dicha falla es temporal y el programa cliente debe de re-intentar la
///	    última petición.
///	  </para>
///	  <para>
///	    Si su valor es Falso es debido a que la falla está del lado del cliente
///	    y el PAC no puede procesar dicha petición (XML incorrecto, Sello mal
///	    generado, etc.)
///	  </para>
///	</summary>
{$ENDREGION}
EPACException = class(Exception)
private
  fCodigoErrorSAT: Integer;
  fCodigoErrorPAC: Integer;
  fReintentable : Boolean;
public
  constructor Create(const aMensajeExcepcion: String; const aCodigoErrorSAT:
      Integer; const aCodigoErrorPAC: Integer; const aReintentable: Boolean);
  property CodigoErrorSAT: Integer read fCodigoErrorSAT;
  property CodigoErrrorPAC: Integer read fCodigoErrorPAC;
  property Reintentable : Boolean read fReintentable;
end;

// Excepciones que se lanzan durante el proceso de timbrado de un CFDI
{$REGION 'Documentation'}
///	<summary>
///	  Error estándard del SAT (301) el cual se lanza cuando el XML enviado al
///	  PAC no fue válido.
///	</summary>
{$ENDREGION}
ETimbradoXMLInvalidoException = class(EPACException);
ETimbradoImpuestoInvalidoException = class(EPACException); // Error 301 cuando un impuesto tiene un nombre no admitido
{$REGION 'Documentation'}
///	<summary>
///	  Error estándard del SAT (302) cuando el sello del comprobante no se
///	  generó correctamente por algún error en el comprobante o el cálculo del
///	  sello.
///	</summary>
{$ENDREGION}
ETimbradoSelloEmisorInvalidoException = class(EPACException); // Error 302
ETimbradoCertificadoNoCorrespondeException = class(EPACException); // Error 303
ETimbradoCertificadoRevocadoException = class(EPACException); // Error 304
ETimbradoFechaEmisionSinVigenciaException = class(EPACException); // Error 305
ETimbradoLlaveInvalidaException = class(EPACException); // Error 306
ETimbradoPreviamenteException = class(EPACException); // Error 307
ETimbradoCertificadoApocrifoException = class(EPACException); // Error 308
ETimbradoFechaGeneracionMasDe72HorasException = class(EPACException); // Error 401
ETimbradoRegimenEmisorNoValidoException = class(EPACException); // Error 402
ETimbradoFechaEnElPasadoException = class(EPACException); // Error 403


// Excepciones comunes para todos los PAC
{$REGION 'Documentation'}
///	<summary>
///	  Representa una "caida" general del servicio del PAC. Es decir
///	  temporalmente fuera de servicio
///	</summary>
{$ENDREGION}
EPACServicioNoDisponibleException = class(EPACException);
EPACCredencialesIncorrectasException = class(EPACException);
EPACEmisorNoInscritoException = class(EPACException);
EPACErrorGenericoDeAccesoException = class(EPACException);
EPACTimbradoRFCNoCorrespondeException = class(EPACException);
EPACTimbradoVersionNoSoportadaPorPACException = class(EPACException);
EPACTimbradoSinFoliosDisponiblesException = class(EPACException);
EPACCAnceladoSinCertificadosException = class(EPACException);

{$REGION 'Documentation'}
///	<summary>
///	  Este tipo de excepcion se lanza cuando se detecta una falla con el
///	  internet del usuario el cual es un problema de comunicación con el PAC.
///	</summary>
{$ENDREGION}
EPACProblemaConInternetException = class(EPACException);

EPACProblemaTimeoutException = class(EPACException);

{$REGION 'Documentation'}
///	<summary>
///	  Excepcion general para errores no programados/manejados.
///	</summary>
///	<remarks>
///	  <note type="important">
///	    Por defecto se establece que esta excepción es "re-intentable" para
///	    indicarle al cliente que debe de re-intentar realizar el ultimo proceso
///	  </note>
///	</remarks>
{$ENDREGION}
EPACErrorGenericoException = class(EPACException);

const
_RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
_RFC_VENTA_EXTRANJEROS        = 'XEXX010101000';
_URL_PRUEBAS_ECODEX           = 'https://pruebas.ecodex.com.mx:2045';

// Errores ecodex
_ERROR_ECODEX_CERTIFICADO_NUEVO = 'Error en Certificado:402';
_ERROR_ECODEX_CERTIFICADO_306   = '306 Certificado utilizado no es de sello';

// Códigos de error regresados por los PAC
_ERROR_SAT_XML_INVALIDO                             = '301';
_ERROR_SAT_SELLO_EMISOR_INVALIDO                    = '302';
_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE               = '303';
_ERROR_SAT_CERTIFICADO_REVOCADO                     = '304';
_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA               = '305';
_ERROR_SAT_LLAVE_NO_CORRESPONDE                     = '306';
_ERROR_SAT_PREVIAMENTE_TIMBRADO                     = '307';
_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT           = '308';
_ERROR_SAT_FECHA_FUERA_DE_RANGO                     = '401';
_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO                 = '402';
_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO               = '403';

implementation

constructor EPACException.Create(const aMensajeExcepcion: String; const
    aCodigoErrorSAT: Integer; const aCodigoErrorPAC : Integer; const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion);
  fReintentable := aReintentable;
  fCodigoErrorSAT := aCodigoErrorSAT;
  fCodigoErrorPAC := aCodigoErrorPAC;
end;

end.
