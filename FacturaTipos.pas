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

// Versiones de CFD soportadas
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

TFECertificado = record
    Ruta: String;
    LlavePrivada: TFELlavePrivada;
    VigenciaInicio: TDateTime;
    VigenciaFin: TDateTime;
    NumeroSerie: String;
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
end;

// Excepciones que se lanzan durante el proceso de timbrado de un CFDI

{$REGION 'Documentation'}
///	<summary>
///	  Error estándard del SAT (301) el cual se lanza cuando el XML enviado al
///	  PAC no fue válido.
///	</summary>
{$ENDREGION}
ETimbradoXMLInvalidoException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Error estándard del SAT (302) cuando el sello del comprobante no se
///	  generó correctamente por algún error en el comprobante o el cálculo del
///	  sello.
///	</summary>
{$ENDREGION}
ETimbradoSelloEmisorInvalidoException = class(Exception); // Error 302
ETimbradoCertificadoNoCorrespondeException = class(Exception); // Error 303
ETimbradoCertificadoRevocadoException = class(Exception); // Error 304
ETimbradoFechaEmisionSinVigenciaException = class(Exception); // Error 305
ETimbradoLlaveInvalidaException = class(Exception); // Error 306
ETimbradoPreviamenteException = class(Exception); // Error 307
ETimbradoCertificadoApocrifoException = class(Exception); // Error 308
ETimbradoFechaGeneracionMasDe72HorasException = class(Exception); // Error 401
ETimbradoRegimenEmisorNoValidoException = class(Exception); // Error 402
ETimbradoFechaEnElPasadoException = class(Exception); // Error 403

// Excepciones comunes para todos los PAC

{$REGION 'Documentation'}
///	<summary>
///	  Representa una "caida" general del servicio del PAC. Es decir
///	  temporalmente fuera de servicio
///	</summary>
{$ENDREGION}
EPACServicioNoDisponibleException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Excepcion general para errores no programados/manejados.
///	</summary>
{$ENDREGION}
ETimbradoErrorGenericoException = class(Exception);

const
_RFC_VENTA_PUBLICO_EN_GENERAL = 'XAXX010101000';
_RFC_VENTA_EXTRANJEROS        = 'XEXX010101000';

// Códigos de error regresados por los PAC
_ERROR_SAT_XML_INVALIDO                   = '301';
_ERROR_SAT_SELLO_EMISOR_INVALIDO          = '302';
_ERROR_SAT_CERTIFICADO_NO_CORRESPONDE     = '303';
_ERROR_SAT_CERTIFICADO_REVOCADO           = '304';
_ERROR_SAT_FECHA_EMISION_SIN_VIGENCIA     = '305';
_ERROR_SAT_LLAVE_NO_CORRESPONDE           = '306';
_ERROR_SAT_PREVIAMENTE_TIMBRADO           = '307';
_ERROR_SAT_CERTIFICADO_NO_FIRMADO_POR_SAT = '308';
_ERROR_SAT_FECHA_FUERA_DE_RANGO           = '401';
_ERROR_SAT_REGIMEN_EMISOR_NO_VALIDO       = '402';
_ERROR_SAT_FECHA_EMISION_EN_EL_PASADO     = '403';

implementation

end.