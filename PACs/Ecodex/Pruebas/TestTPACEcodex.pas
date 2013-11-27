(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestTPACEcodex;

interface

uses
  TestFramework,
  FacturaTipos,
  PAC.Ecodex.Timbrado;

type

  TestTPACEcodex = class(TTestCase)
  strict private
    fCredencialesDePrueba : TFEPACCredenciales;
    cutManejador: TEcodexManejadorDeSesion;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ObtenerNuevoTokenDeUsuario_DePrueba_RegreseTokenValido;
  end;

implementation

uses
  Windows, SysUtils, Classes;

procedure TestTPACEcodex.SetUp;
begin
  inherited;
  cutManejador := TEcodexManejadorDeSesion.Create;

  // Asignamos las credenciales de prueba
  // tomadas del documento "Guia de integracion ECODEX_v2.0.1.pdf" Página 28
  fCredencialesDePrueba.RFC            := 'SUL010720JN8';
  fCredencialesDePrueba.Clave          := 'prueba';
  fCredencialesDePrueba.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';
end;

procedure TestTPACEcodex.TearDown;
begin
  FreeAndNil(cutManejador);
end;

procedure TestTPACEcodex.ObtenerNuevoTokenDeUsuario_DePrueba_RegreseTokenValido;
var
  tokenDeUsuario : String;
const
  _TOKEN_CORRECTO = 'ab5935f20420a75fa03d981663ee2d94f1663211';
begin
  // Asignamos las credenciales de prueba
  cutManejador.AsignarCredenciales(fCredencialesDePrueba);

  tokenDeUsuario := cutManejador.ObtenerNuevoTokenDeUsuario;

  CheckEquals(_TOKEN_CORRECTO,
              tokenDeUsuario,
              'El token de usuario obtenido no fue el esperado');
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTPACEcodex.Suite);

end.
