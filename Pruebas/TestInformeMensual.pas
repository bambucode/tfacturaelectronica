(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestInformeMensual;

interface

uses
  TestFramework,
  TestPrueba,
  FacturaTipos,
  InformeMensual,
  FeCFDv22,
  FacturaReglamentacion;

type

  TestTInformeMensual = class(TTestPrueba)
  strict private
    fInformeMensual: TInformeMensual;
    fFechaGeneracion: TDateTime;
    lineaBase, linea: String;
    fRfc: TFERFC;
    iMes: Integer;
    iAno: Integer;
    fEmisor: TFEContribuyente;
    comprobante1, comprobanteCancelado: TComprobanteInformeMensual;
    //aComprobantes: TArrComprobanteInformeMensual;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Agregar_TComprobanteInformeMensual_ComprobanteSeparadoPorPipes;
    procedure AgregarLineaConComprobanteCancelado_TComprobanteInformeMensual_ComprobanteSeparadoPorPipes;
    procedure AgregarLineaConRFCInvalido_TComprobanteInfomeMensual_CausesException;
    procedure AgregarLineaConMontoInvalido_TComprobanteInfomeMensual_CausesException;
    procedure AgregarLineaConImpuestoInvalido_TComprobanteInfomeMensual_CausesException;
    procedure AgregarLineaConImpuestoMayorAMonto_TComprobanteInfomeMensual_CausesException;
  end;

implementation

uses
  Windows, SysUtils, Classes, ShellApi, Forms, OpenSSLUtils, DateUtils, ActiveX, ShlObj,
  ConstantesFixtures;


procedure TestTInformeMensual.SetUp;
begin
  inherited;
  fRfc := 'ISP900909Q88';
  iMes := 12;
  iAno := 2010;

  fEmisor.RFC:=fRFC;

  // Creamos el objeto TInformeMensual
  fInformeMensual := TInformeMensual.Create(fEmisor, iMes, iAno);
end;

procedure TestTInformeMensual.TearDown;
begin
  FreeAndNil(fInformeMensual);
end;

function GetDesktopFolder: string;
var
 buf: array[0..255] of char;
 pidList: PItemIDList;
begin
 Result := 'No Desktop Folder found.';
 SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, pidList);
 if (pidList <> nil) then
  if (SHGetPathFromIDList(pidList, buf)) then
    Result := buf;
end;

procedure TestTInformeMensual.AgregarLineaConRFCInvalido_TComprobanteInfomeMensual_CausesException;
var
  bExcepcionLanzada: Boolean;
  comprobante: TComprobanteInformeMensual;
  fFechaGeneracion: TDateTime;
begin
  // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
  bExcepcionLanzada := False;
  comprobante.Receptor.RFC := 'AAA010101A';
  comprobante.Serie := 'A';
  comprobante.Folio := 1;
  comprobante.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobante.FechaExpedicion := fFechaGeneracion;
  comprobante.Total := 1200.50;
  comprobante.Impuestos := 192.08;
  comprobante.Estado := ecVigente;
  comprobante.Efecto := efEgreso;
  
  try
      fInformeMensual.Agregar(comprobante);
      fInformeMensual.GenerarContenidoDeInforme;
  except
    On E: ERFCInvalido do
    begin
      bExcepcionLanzada := True;
    end;
  end;

  CheckTrue(bExcepcionLanzada,
            'No se lanzo excepcion cuando se especifico rfc incorrecto.');
end;

procedure TestTInformeMensual.AgregarLineaConMontoInvalido_TComprobanteInfomeMensual_CausesException;
var
  bExcepcionLanzada: Boolean;
  comprobante: TComprobanteInformeMensual;
  fFechaGeneracion: TDateTime;
begin
  // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
  bExcepcionLanzada := False;
  comprobante.Receptor.RFC := 'AAA010101AAA';
  comprobante.Serie := 'A';
  comprobante.Folio := 1;
  comprobante.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobante.FechaExpedicion := fFechaGeneracion;
  comprobante.Total := 10000000000;
  comprobante.Impuestos := 192.08;
  comprobante.Estado := ecVigente;
  comprobante.Efecto := efEgreso;
  
  try
      fInformeMensual.Agregar(comprobante);
      fInformeMensual.GenerarContenidoDeInforme;
  except
    On E: EMontoInvalido do
    begin
      bExcepcionLanzada := True;
    end;
  end;

  CheckTrue(bExcepcionLanzada,
    'No se lanzo excepcion cuando se especifico rfc incorrecto.');
end;

procedure TestTInformeMensual.AgregarLineaConImpuestoMayorAMonto_TComprobanteInfomeMensual_CausesException;
var
  bExcepcionLanzada: Boolean;
  comprobante: TComprobanteInformeMensual;
  fFechaGeneracion: TDateTime;
begin
  // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
  bExcepcionLanzada := False;
  comprobante.Receptor.RFC := 'AAA010101AAA';
  comprobante.Serie := 'A';
  comprobante.Folio := 1;
  comprobante.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobante.FechaExpedicion := fFechaGeneracion;
  comprobante.Total := 1200.50;
  comprobante.Impuestos := 1920.08;
  comprobante.Estado := ecVigente;
  comprobante.Efecto := efEgreso;
  
  try
      fInformeMensual.Agregar(comprobante);
      fInformeMensual.GenerarContenidoDeInforme;
  except
    On E: EImpuestoInvalido do
    begin
      bExcepcionLanzada := True;
    end;
  end;

  CheckTrue(bExcepcionLanzada,
    'No se lanzo excepcion cuando se especifico rfc incorrecto.');
end;

procedure TestTInformeMensual.AgregarLineaConImpuestoInvalido_TComprobanteInfomeMensual_CausesException;
var
  bExcepcionLanzada: Boolean;
  comprobante: TComprobanteInformeMensual;
  fFechaGeneracion: TDateTime;
begin
  // Creamos un nuevo objeto OpenSSL con una clave incorrecta a proposito
  bExcepcionLanzada := False;
  comprobante.Receptor.RFC := 'AAA010101AAA';
  comprobante.Serie := 'A';
  comprobante.Folio := 1;
  comprobante.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobante.FechaExpedicion := fFechaGeneracion;
  comprobante.Total := 1200.50;
  comprobante.Impuestos := 10000000000;
  comprobante.Estado := ecVigente;
  comprobante.Efecto := efEgreso;

  try
      fInformeMensual.Agregar(comprobante);
      fInformeMensual.GenerarContenidoDeInforme;
  except
    On E: EImpuestoInvalido do
    begin
      bExcepcionLanzada := True;
    end;
  end;

  CheckTrue(bExcepcionLanzada,
    'No se lanzo excepcion cuando se especifico rfc incorrecto.');
end;

procedure TestTInformeMensual.Agregar_TComprobanteInformeMensual_ComprobanteSeparadoPorPipes;
var
  InformeMensual : TInformeMensual;
  y,m,d: Word;
begin
  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := EncodeDateTime(2011, 1, 26, 17, 30, 20, 0);
  DecodeDate(fFechaGeneracion, y, m, d);
  InformeMensual := TInformeMensual.Create(fEmisor, m, y);
  
  comprobante1.Receptor.RFC := 'AAA010101AAA';
  comprobante1.Serie := 'A';
  comprobante1.Folio := 1;
  comprobante1.NumAprobacion := 1111;

  comprobante1.FechaExpedicion := fFechaGeneracion;
  comprobante1.Total := 1200.50;
  comprobante1.Impuestos := 192.08;
  comprobante1.Estado := ecVigente;
  comprobante1.Efecto := efEgreso;

  lineaBase := '|AAA010101AAA|A|1|20111111|26/01/2011 17:30:20|1200.50|192.08|1|E||||'+#13#10;
  InformeMensual.Agregar(comprobante1);
  InformeMensual.GenerarContenidoDeInforme;
  linea := InformeMensual.Contenido;

  CheckEquals(lineaBase, linea, 'La linea agregada al reporte no es invalida.');
  FreeAndNil(InformeMensual);
end;

procedure TestTInformeMensual.AgregarLineaConComprobanteCancelado_TComprobanteInformeMensual_ComprobanteSeparadoPorPipes;
var
  InformeMensual : TInformeMensual;
  y,m,d: Word;
begin
  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := EncodeDateTime(2011, 1, 26, 17, 30, 20, 0);
  DecodeDate(fFechaGeneracion, y, m, d);
  InformeMensual := TInformeMensual.Create(fEmisor, m, y);
  
  comprobanteCancelado.Receptor.RFC := 'AAA010101AAA';
  comprobanteCancelado.Serie := 'A';
  comprobanteCancelado.Folio := 1;
  comprobanteCancelado.NumAprobacion := 1111;

  comprobanteCancelado.FechaExpedicion := fFechaGeneracion;
  comprobanteCancelado.Total := 1200.50;
  comprobanteCancelado.Impuestos := 192.08;
  comprobanteCancelado.Estado := ecCancelado;
  comprobanteCancelado.Efecto := efEgreso;

  lineaBase := '|AAA010101AAA|A|1|20111111|26/01/2011 17:30:20|1200.50|192.08|0|E||||' + #13#10;
  InformeMensual.Agregar(comprobanteCancelado);
  InformeMensual.GenerarContenidoDeInforme;
  linea := InformeMensual.Contenido;

  CheckEquals(lineaBase, linea, 'El comprobante cancelado no fue agregado correctamente.');
  FreeAndNil(InformeMensual);
end;

{
procedure TestTInformeMensual.GenerarReporte_ArrayOFTComprobanteInformeMensual_ArchivoDeTextoConComprobantes;
var
  bExisteArchivo: boolean;
  text: String;
  rutaReporte, reporteFixture: String;
  archivoReporte : WideString;
begin            
  comprobante1.ReceptorRFC := 'AAA010101AAA';
  comprobante1.Serie := 'A';
  comprobante1.Folio := 1;
  comprobante1.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobante1.FechaExpedicion := fFechaGeneracion;
  comprobante1.Total := 1200.50;
  comprobante1.Impuestos := 192.08;
  comprobante1.Estado := ecVigente;
  comprobante1.Efecto := efEgreso;

  SetLength(aComprobantes, Length(aComprobantes) + 1);
  aComprobantes[0] := comprobante1;

  //fInformeMensual.SetComprobante(0, comprobante1);

  comprobanteCancelado.ReceptorRFC := 'AAA010101AAA';
  comprobanteCancelado.Serie := 'A';
  comprobanteCancelado.Folio := 1;
  comprobanteCancelado.NumAprobacion := 1111;

  // Agregamos el comprobante con la fecha de hoy
  fFechaGeneracion := Now;
  comprobanteCancelado.FechaExpedicion := fFechaGeneracion;
  comprobanteCancelado.Total := 1200.50;
  comprobanteCancelado.Impuestos := 192.08;
  comprobanteCancelado.Estado := ecCancelado;
  comprobanteCancelado.Efecto := efEgreso;

  SetLength(aComprobantes, Length(aComprobantes) + 1);
  aComprobantes[1] := comprobanteCancelado;

  //fInformeMensual.SetComprobante(1, comprobanteCancelado);
  fInformeMensual.SetComprobantes(aComprobantes);
  
  fInformeMensual.GuardarReporte(GetDesktopFolder);
  rutaReporte := GetDesktopFolder + '\' + fInformeMensual.obtenerNombreArchivo();
  if FileExists(rutaReporte)
  then  bExisteArchivo := true
  else bExisteArchivo := false;

  CheckTrue(bExisteArchivo, 'El archivo del reporte no fue creado correctamente.');

  reporteFixture := '|AAA010101AAA|A|1|20101111|201012|1200.5|192.08|1|E||||'#$D#$A'|AAA010101AAA|A|1|20101111|201012|1200.5|192.08|0|E||||';

  archivoReporte := leerContenidoDeArchivo(rutaReporte);

  CheckEquals(reporteFixture, archivoReporte, 'El reporte no fue generado correctamente');
end; }

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTInformeMensual.Suite);

end.
