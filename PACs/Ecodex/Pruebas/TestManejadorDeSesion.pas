(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestManejadorDeSesion;

interface

uses
  TestFramework,
  FacturaTipos,
  TestPrueba,
  PAC.Ecodex.ManejadorDeSesion;

type

  TestTEcodexManejadorDeSesion = class(TTestPrueba)
  strict private
    fCredencialesDePrueba : TFEPACCredenciales;
    cutManejador: TEcodexManejadorDeSesion;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ObtenerNuevoTokenDeUsuario_DePrueba_RegreseTokenValido;
    procedure ObtenerNuevoTokenDeUsuario_ConEmisorNoInscrito_CauseExcepcion;
  end;

implementation

uses
  Windows, SysUtils, Classes;

procedure TestTEcodexManejadorDeSesion.SetUp;
begin
  inherited;
  cutManejador := TEcodexManejadorDeSesion.Create('https://pruebas.ecodex.com.mx:2045', 1);

  // Asignamos las credenciales de prueba
  // tomadas del documento "Guia de integracion ECODEX_v2.0.1.pdf" Página 28
  fCredencialesDePrueba.RFC            := 'SUL010720JN8'; ;
  fCredencialesDePrueba.Clave          := 'prueba';
  fCredencialesDePrueba.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';
end;

procedure TestTEcodexManejadorDeSesion.TearDown;
begin
  FreeAndNil(cutManejador);
end;

procedure TestTEcodexManejadorDeSesion.ObtenerNuevoTokenDeUsuario_DePrueba_RegreseTokenValido;
var
  tokenDeUsuario, tokenCorrecto : String;
begin
  // Asignamos las credenciales de prueba
  cutManejador.AsignarCredenciales(fCredencialesDePrueba);

  tokenDeUsuario := cutManejador.ObtenerNuevoTokenDeUsuario;

  CheckNotEquals('',
                tokenDeUsuario,
                'El token de usuario no se regreso correctamente');
end;

procedure
    TestTEcodexManejadorDeSesion.ObtenerNuevoTokenDeUsuario_ConEmisorNoInscrito_CauseExcepcion;
var
  credencialesIncorrectas: TFEPACCredenciales;
  seLanzoExcepcion: Boolean;
begin
  credencialesIncorrectas.RFC            := 'SUL111111JN8'; ;
  credencialesIncorrectas.Clave          := 'prueba';
  credencialesIncorrectas.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';

  cutManejador.AsignarCredenciales(credencialesIncorrectas);

  try
     cutManejador.ObtenerNuevoTokenDeUsuario;
  except
    On E:EPACEmisorNoInscritoException do
      seLanzoExcepcion := True;
  end;

  CheckTrue(seLanzoExcepcion,
            'Se debio haber lanzado excepcion EPACEmisorNoInscritoException al mandar solicitar un token' +
            ' de un RFC no inscrito con Ecodex.' );
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTEcodexManejadorDeSesion.Suite);

end.
