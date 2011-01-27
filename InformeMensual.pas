unit InformeMensual;

interface

uses FacturaTipos, SysUtils;

type

  TEstadoComprobante = (ecVigente, ecCancelado);
  TEfectoComprobante = (efIngreso, efEgreso, efTraslado);

  TComprobanteInformeMensual = record
       ReceptorRFC: TFERFC;
       Serie: TFESerie;
       Folio: TFEFolio;
       NumAprobacion: Integer;
       FechaExpedicion: TDateTime;
       Total: Currency;
       Impuestos: Currency;
       Estado: TEstadoComprobante;
       Efecto: TEfectoComprobante;
       Pedimentos: TFEPedimentos;
  end;

  TAComprobanteInformeMensual = Array of  TComprobanteInformeMensual;

  ERFCInvalido = class(Exception);
  EFolioInvalido = class(Exception);
  ESerieInvalida = class(Exception);
  EMontoInvalido = class(Exception);
  EImpuestoInvalido = class(Exception);
  EMesInvalido = class(Exception);
  EAnoInvalido = class(Exception);

  ///<summary>Representa la clase que permite generar el Informe Mensual de Comprobantes
  /// Emitidos definido en el Anexo 20</summary>
  TInformeMensual = class
  {$IFDEF VERSION_DE_PRUEBA}
  public
  {$ELSE}
  private
  {$ENDIF}
      // Variable para guardar el contenido del reporte para despues guardarlo en un archivo fisico
      sContenido: WideString;
      fRFC: TFERFC;
      fComprobantes: TAComprobanteInformeMensual;

      // El nombre del archivo debe empezar con 1 si se usan CFDs, 2 si fueron solicitados a un
      // establecimiento autorizado..
      const NUMERO_ESQUEMA = 1;

      function ConvertirComprobanteEstadoACadena(Estado: TEstadoComprobante): String;
      function ConvertirComprobanteEfectoACadena(Efecto: TEfectoComprobante): String;

      function GetComprobantes(): TAComprobanteInformeMensual;
      function QuitarPipes(Cadena: String) : String;
      function obtenerNombreArchivo(): String;
      /// <summary>Agrega una linea a la variable temporal del reporte mensual para poder generar el archivo del informe</param>
      /// <param name="Comprobante">Comprobante que se va a agregar</param>
      function AgregarLinea(Comprobante: TComprobanteInformeMensual): String;
      procedure GenerarContenidoDeInforme;
  protected
      fMes: Integer;
      fAno: Integer;
  public
      property RFC: TFERFC read fRFC;
      property Mes: Integer read fMes;
      property Ano: Integer read fAno;
      //property Comprobante[Index: Integer]: TComprobanteInformeMensual read GetComprobante write SetComprobante;
      /// <summary>Crea la clase InformeMensual para el Emisor, Mes y Año correspondientes</summary>
      /// <param name="EmisorRFC">El RFC del contribuyente que envia el informe</param>
      /// <param name="Mes">Numero del mes del informe</param>
      /// <param name="Ano">Año del informe (4 digitos), Ej: 2010</param>
      constructor Create(EmisorRFC: TFERFC; Mes, Ano: Integer); overload;
      /// <summary>Agrega el Comprobante para el informe mensual a incluir en el archivo de texto</param>
      /// <param name="Comprobante">Datos del CFD en el formato de ComprobanteInformeMensual</param>
      /// <summary>Genera el informe en formato de Texto con el nombre que debe llegar definido por el SAT
      /// en el Anexo 20</param>
      /// <param name="DirectorioDestino">Directorio donde se guardara el archivo del informe</param>
      procedure GuardarReporte(DirectorioDestino: String);
      /// <summary>Agrega una linea a la variable temporal del reporte mensual para poder generar el archivo del informe</param>
      /// <param name="Comprobante">Comprobante que se va a agregar</param>
      procedure Agregar(Comprobante: TComprobanteInformeMensual);
      /// Regresa el contenido del informe
      property Contenido : WideString read sContenido;
  end;

implementation

uses Classes, FacturaReglamentacion;

function TInformeMensual.obtenerNombreArchivo(): String;
begin
       // Regresamos el nombre que debe tener el archivo de reporte de acuerdo
       // al Anexo 20
       Result:=IntToStr(NUMERO_ESQUEMA) +
               fRFC +
               Format('%.2d', [fMes]) +
               IntToStr(fAno) +
               '.txt';
end;

constructor TInformeMensual.Create(EmisorRFC: TFERFC; Mes, Ano: Integer);
begin
     inherited Create;
     fRFC := EmisorRFC;
     fMes := Mes;
     fAno := Ano;

     sContenido := '';
end;

// Funcion que quita los pipes para cumplir con la regla:
// 2.	Ninguno de los atributos que conforman el informe mensual deberá contener el carácter | (“pipe”)
//    debido a que este será utilizado como carácter de control en la formación del informe mensual.
function TInformeMensual.QuitarPipes(Cadena: String) : String;
begin
   Result:=StringReplace(Cadena, '|', '', [rfReplaceAll]);
end;

function TInformeMensual.AgregarLinea(Comprobante: TComprobanteInformeMensual): String;
var
   d, m, y: word;
   nueva_linea: String;
begin
  if (Length(Comprobante.ReceptorRFC) < 12) then
    raise ERFCInvalido.create('El rfc de la factura añadida no es valido, el rfc debe ser de 12 o 13 caracteres');

  // No es necesario validarlo, esta limitado por el tipo de dato LongInt
  //if (Comprobante.Folio > 0) and (Comprobante.Folio > 2147483647)  then
  //  raise EFolioInvalido.create('El folio de la factura debe ser mayor a 0 y no puede ser mayor a 2147483647');

  // No es necesario validarlo, esta truncado por el tipo String[10]
  //if Length(Comprobante.Serie) > 10 then
    //raise ESerieInvalida.create('La serie de la factura tiene mas caracteres de los permitidos, el folio debe tener de 0 a 10 caracteres');

  if (Comprobante.Total > 0) and (Comprobante.Total >= 10000000000)  then
    raise EMontoInvalido.create('El monto de la operacion de la factura debe ser mayor a 0 menor a 10000000000');

  //Monto del Impuesto al Valor Agregado trasladado.(Comprobante.Impuesto)
  //Puede ser NULO, CERO o un número menor o igual a 9999999999.99
  //Debe ser menor que el Monto de la operación (campo Comprobante.Monto)
  if Comprobante.Impuestos > Comprobante.Total  then
    raise EImpuestoInvalido.create('El monto del impuesto de la factura debe ser menor monto de la operacion ');

  if Comprobante.Impuestos >= 10000000000  then
    raise EImpuestoInvalido.create('El monto del impuesto de la factura debe ser menor a 10000000000');

  // Agregar exception si el comprobante no es del mes actual
  DecodeDate(Comprobante.FechaExpedicion, y, m, d);

  if m <> fMes then
    raise EMesInvalido.create('El comprobante añadido no corresponde al mes del reporte');

  if y <> fAno then
    raise EAnoInvalido.create('El comprobante añadido no corresponde al año del reporte');

    // Excepcion temporal debido a que falta poner soporte para datos de aduana
    if Length(Comprobante.Pedimentos) > 0 then
        raise Exception.Create('La informacion aduanera/pedimentos aun no esta implementado en esta clase!');

    // |PLW750114XP1|PPP|47|200401|24/02/2004 16:16:52|26314.00|0.00|1|
    nueva_linea := '|' + QuitarPipes(Comprobante.ReceptorRFC) + '|' +
              QuitarPipes(Comprobante.Serie)  + '|' +
              IntToStr(Comprobante.Folio)  + '|' +
              IntToStr(fAno) + IntToStr(Comprobante.NumAprobacion) + '|' + //  4. Año y Num de Aprobacion
              TFEReglamentacion.ComoFechaHoraInforme(Comprobante.FechaExpedicion) + '|' +  // Fecha y hora de expedicion
              TFEReglamentacion.ComoMoneda(Comprobante.Total)  + '|' +
              TFEReglamentacion.ComoMoneda(Comprobante.Impuestos)  + '|' +
              ConvertirComprobanteEstadoACadena(Comprobante.Estado)  + '|' +
              ConvertirComprobanteEfectoACadena(Comprobante.Efecto)  + '|' +
              '||' + // <--- TODO: Leer aqui el arreglo de los datos aduaneros e incluirlos en lugar de poner NULL
              '|' + #13#10; // Fin del registro Pipe + Enter
              
    sContenido:=sContenido + nueva_linea;

    // Regresamos la linea q vamos a agregar
    Result := nueva_linea;
end;

function TInformeMensual.ConvertirComprobanteEstadoACadena(Estado: TEstadoComprobante): String;
begin
  case Estado of
    ecVigente: result:= '1';
    ecCancelado: result := '0';
  end;
end;

function TInformeMensual.ConvertirComprobanteEfectoACadena(Efecto: TEfectoComprobante): String;
begin
  case Efecto of
    efIngreso: result := 'I';
    efEgreso:  result := 'E';
    efTraslado: result := 'T';
  end;
end;

procedure TInformeMensual.GenerarContenidoDeInforme;
var
      I: Integer;
begin
      sContenido:='';

     // Agregamos cada comprobante al archivo...
     for I := 0 to Length(fComprobantes) - 1 do
        AgregarLinea(fComprobantes[I]);

     {$IFDEF DEBUG}
        if Length(fComprobantes) > 0 then
          Assert(sContenido <> '', 'No hubo lineas de informe cuando si se agregaron comprobante al informe.');
     {$ENDIF}
end;

procedure TInformeMensual.GuardarReporte(DirectorioDestino: String);
var
    slArchivo: TStrings;
    sNombreArchivo: String;
begin
    slArchivo:= TStringList.Create;
    sNombreArchivo:=obtenerNombreArchivo();

    try
       GenerarContenidoDeInforme;
       slArchivo.Text:=sContenido;

       // Guardamos el archivo en el directorio destino
       slArchivo.SaveToFile(DirectorioDestino + '\' + sNombreArchivo);
    finally
       FreeAndNil(slArchivo);
    end;
end;

procedure TInformeMensual.Agregar(Comprobante: TComprobanteInformeMensual);
begin
    SetLength(fComprobantes, Length(fComprobantes) + 1);
    fComprobantes[Length(fComprobantes) - 1] := Comprobante;
end;

function TInformeMensual.GetComprobantes(): TAComprobanteInformeMensual;
begin
  Result := fComprobantes;
end;

end.
