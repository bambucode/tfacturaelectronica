(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestPACEcodex;

interface

uses
  TestFramework,
  FacturaTipos,
  TestPrueba,
  PACEcodex;

type

  TestTPACEcodex = class(TTestPrueba)
  strict private
    fDocumentoDePrueba: WideString;
    fCredencialesDePrueba : TFEPACCredenciales;
    cutPACEcodex: TPACEcodex;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TimbrarDocumento_DePrueba_AsigneXMLDeTimbre;
    procedure TimbrarDocumento_DePrueba_RegreseDatosDeTimbre;
  end;

implementation

uses
  Windows, SysUtils, Classes, Forms;

procedure TestTPACEcodex.SetUp;
begin
  inherited;
  cutPACEcodex := TPACEcodex.Create;

  // Asignamos las credenciales de prueba
  // tomadas del documento "Guia de integracion ECODEX_v2.0.1.pdf" Página 28
  fCredencialesDePrueba.RFC            := 'SUL010720JN8';
  fCredencialesDePrueba.Clave          := 'prueba';
  fCredencialesDePrueba.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';
end;

procedure TestTPACEcodex.TearDown;
begin
  FreeAndNil(cutPACEcodex);
end;

procedure TestTPACEcodex.TimbrarDocumento_DePrueba_AsigneXMLDeTimbre;
begin
  Check(False);
end;

procedure TestTPACEcodex.TimbrarDocumento_DePrueba_RegreseDatosDeTimbre;
var
  timbreResultado : TFETimbre;
begin
  cutPACEcodex.AsignarCredenciales(fCredencialesDePrueba);

  // Leemos el XML de prueba para timbrarlo
  fDocumentoDePrueba := Self.leerContenidoDeArchivo(ExtractFilePath(Application.ExeName) +
                                                   '..\..\Fixtures\comprobante_a_timbrar.xml');

  timbreResultado := cutPACEcodex.TimbrarDocumento(fDocumentoDePrueba);

  CheckTrue(timbreResultado.UUID <> '',
            'El UUID del timbre no fue correcto');
end;

initialization

// Registra la prueba de esta unidad en la suite de pruebas
RegisterTest(TestTPACEcodex.Suite);

end.
