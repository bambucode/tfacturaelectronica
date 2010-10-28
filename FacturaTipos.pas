(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Define las estructuras usadas como parametros para generar la factura
 electrónica. Pensado por si en el futuro el SAT cambia las estructuras
 sean fácilmente extendibles sin necesidad de cambiar el código que lo haya
 usado con anterioridad.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit FacturaTipos;

interface

type

TFEFormasDePago = (fpUnaSolaExhibicion, fpParcialidades);

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

TFEDocumentoAduanero = record
  Numero: String;
  Fecha: TDateTime;
  Aduana: String;
end;

TFEContribuyente = record
	Nombre: String;
	RFC: String[13];
  Direccion: TFeDireccion;
end;

TFEConcepto = record
  Cantidad: Double;
  Unidad: String;
  Descripcion: String;
  ValorUnitario: Currency;
  // Datos opcionales
  NoIdentificacion: String;
public
  function Importe() : Currency;
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
    Serie: String; // Opcional
    FolioInicial: Integer;
    FolioFinal: Integer;
end;

TFEFolio = Integer;
TFESerie = String;

implementation

function TFEConcepto.Importe : Currency;
begin
    Result:=Cantidad * ValorUnitario;
end;

end.
