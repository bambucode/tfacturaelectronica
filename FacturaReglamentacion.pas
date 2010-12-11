(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Metodos para validar los diferentes tipos de datos y como deben de estar
 especificados en el archivo XML.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit FacturaReglamentacion;

interface

type

  TFEReglamentacion = class
      /// <summary>Convierte el valor de moneda al formato de dinero requerido por el SAT
      /// </summary>
      /// <param name="Monto">Monto a convertir al formato aceptado por el SAT</param>
      class function ComoMoneda(dMonto: Currency) : String;
      class function ComoCadena(sCadena: String) : String;
      class function ComoCantidad(dCantidad: Double) : String;
      class function ComoFechaHora(dtFecha: TDateTime) : String;
      class function ComoFechaAduanera(dtFecha: TDateTime) : String;
      class function ComoTasaImpuesto(dTasa: Double) : String;
      class function ComoDateTime(sFechaISO8601: String): TDateTime;
  end;

implementation

uses SysUtils, DateUtils;

// Segun las reglas del SAT:
// "Se expresa en la forma aaaa-mm-ddThh:mm:ss, de acuerdo con la especificación ISO 8601"
class function TFEReglamentacion.ComoFechaHora(dtFecha: TDateTime) : String;
begin
  Result := FormatDateTime('yyyy-mm-dd', dtFecha) + 'T' + FormatDateTime('hh:nn:ss', dtFecha);
end;

// Convierte una fecha de ISO 8601 (formato del XML) a TDateTime usado en Delphi.
class function TFEReglamentacion.ComoDateTime(sFechaISO8601: String): TDateTime;
var
    sAno, sMes, sDia, sHora, sMin, sMs: String;
begin
    // Ejemplo: 2009-08-16T16:30:00
    sAno := Copy(sFechaISO8601, 1, 4);
    sMes := Copy(sFechaISO8601, 6, 2);
    sDia := Copy(sFechaISO8601, 9, 2);
    sHora := Copy(sFechaISO8601, 12, 2);
    sMin := Copy(sFechaISO8601, 15, 2);
    sMs := Copy(sFechaISO8601, 18, 2);
    Result := EncodeDateTime(StrToInt(sAno), StrToInt(sMes), StrToInt(sDia), StrToInt(sHora),
                              StrToInt(sMin), StrToInt(sMs), 0);
end;

class function TFEReglamentacion.ComoFechaAduanera(dtFecha: TDateTime) : String;
begin
   // Formato sacado del CFDv2.XSD: "Atributo requerido para expresar la fecha de expedición
   // del documento aduanero que ampara la importación del bien. Se expresa en el formato aaaa-mm-dd"
   Result := FormatDateTime('yyyy-mm-dd', dtFecha);
end;

class function TFEReglamentacion.ComoMoneda(dMonto: Currency) : String;
begin
   Result:=FloatToStrF(dMonto,ffFixed,10,2);
end;

class function TFEReglamentacion.ComoTasaImpuesto(dTasa: Double) : String;
begin
   Result:=FloatToStrF(dTasa,ffFixed,10,2);
end;

// Las cadenas usadas en el XML deben de escapar caracteres incorrectos
// Ref: http://dof.gob.mx/nota_detalle.php?codigo=5146699&fecha=15/06/2010
class function TFEReglamentacion.ComoCadena(sCadena: String) : String;
var
   sCadenaEscapada: String;
begin
    sCadenaEscapada:=sCadena;
    // Las siguientes validaciones las omitimos ya que las mismas clases
    // de Delphi lo hacen por nosotros:
    // En el caso del & se deberá usar la secuencia &amp;
    // En el caso del “ se deberá usar la secuencia &quot;
    // En el caso del < se deberá usar la secuencia &lt;
    // En el caso del > se deberá usar la secuencia &gt;
    // En el caso del ‘ se deberá usar la secuencia &apos;

    // Si se presentan nuevas reglas para los Strings en el XML, incluirlas aqui

    Result:=sCadenaEscapada;
end;

class function TFEReglamentacion.ComoCantidad(dCantidad: Double) : String;
begin
   // Las cantidades cerradas las regresamos sin decimales
   // las que tienen fracciones con 2 digitos decimales...
   if Frac(dCantidad) > 0 then
      Result:=FloatToStrF(dCantidad,ffFixed,10,2)
   else
      Result:=IntToStr(Round(dCantidad));
end;

end.