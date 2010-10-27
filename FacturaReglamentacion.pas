(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

 Metodos para validar los diferentes tipos de datos y como deben de estar
 especificados en el archivo XML.

 Este archivo pertenece al proyecto de codigo fuente de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
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
  end;

implementation

uses SysUtils;

class function TFEReglamentacion.ComoMoneda(dMonto: Currency) : String;
begin
   Result:=FloatToStrF(dMonto,ffFixed,10,2);
end;

class function TFEReglamentacion.ComoCadena(sCadena: String) : String;
begin
    // TODO: Escapar lo siguiente:
    // En el caso del & se deberá usar la secuencia &amp;
    // En el caso del “ se deberá usar la secuencia &quot;
    // En el caso del < se deberá usar la secuencia &lt;
    // En el caso del > se deberá usar la secuencia &gt;
    // En el caso del ‘ se deberá usar la secuencia &apos;
end;

class function TFEReglamentacion.ComoCantidad(dCantidad: Double) : String;
begin
   Result:=FloatToStrF(dCantidad,ffFixed,10,0);
end;

end.
