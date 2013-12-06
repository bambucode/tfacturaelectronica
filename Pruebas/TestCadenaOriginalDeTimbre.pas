(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA

 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Este archivo pertenece al proyecto de codigo abierto de BambuCode:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
 unit TestCadenaOriginalDeTimbre;

interface

uses
  TestFramework, TestPrueba, FacturaTipos, CadenaOriginalTimbre;

type

  TestTCadenaOriginalDeTimbre = class(TTestPrueba)
  strict private
  private
    fFixtureTimbreXML: TStringCadenaOriginal;
    fFixtureCadena: TStringCadenaOriginal;
  public
    function LeerContenidoDeArchivo(sNombreArchivo: String): WideString;
    procedure SetUp; override;
  published
      procedure CadenaOriginalGenerada_TimbreDeFactura_SeaCorrecto;
  end;

implementation

uses
  Windows, SysUtils, Classes, ClaseOpenSSL, CodeSiteLogging;

procedure TestTCadenaOriginalDeTimbre.SetUp;
begin
  inherited;
  fFixtureTimbreXML := LeerContenidoDeArchivo(fRutaFixtures + 'comprobante_fiscal/v32/comprobante_timbre.xml');
  fFixtureCadena := LeerContenidoDeArchivo(fRutaFixtures + 'comprobante_fiscal/v32/cadena_original_timbre.txt');

  Assert(fFixtureTimbreXML <> '', 'El fixture del xml del timbre no puede ser vacio');
  Assert(fFixtureCadena <> '', 'El fixture de la cadena original del timbre no puede ser vacio');
end;

procedure
    TestTCadenaOriginalDeTimbre.CadenaOriginalGenerada_TimbreDeFactura_SeaCorrecto;
var
  generadorCadenaOriginalTimbre: TCadenaOriginalDeTimbre;
  lCadenaOriginalTimbre: TStringCadenaOriginal;
const
  _RUTA_XSLT = '../../XSLT/cadenaoriginal_TFD_1_0.xslt';
begin
  generadorCadenaOriginalTimbre := TCadenaOriginalDeTimbre.Create(fFixtureTimbreXML, _RUTA_XSLT);
  lCadenaOriginalTimbre := generadorCadenaOriginalTimbre.Generar;

  CheckEquals(fFixtureCadena,
              lCadenaOriginalTimbre,
              'La cadena original no fue generada correctamente');
end;

function TestTCadenaOriginalDeTimbre.LeerContenidoDeArchivo(sNombreArchivo: String): WideString;
var
  slArchivo: TStrings;
begin
  slArchivo := TStringList.Create;
  slArchivo.LoadFromFile(sNombreArchivo);
  {$IF Compilerversion >= 20}
  Result:=Trim(slArchivo.Text);
  {$ELSE}
  Result:=Trim(UTF8Encode(slArchivo.Text));
  {$IFEND}
  FreeAndNil(slArchivo);
end;

initialization
  // Registra la prueba de esta unidad en la suite de pruebas
  RegisterTest(TestTCadenaOriginalDeTimbre.Suite);
end.
