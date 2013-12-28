(* *****************************************************************************
  Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)

unit TestCertificadoSellos;

interface

uses
  TestFramework,
  TestPrueba,
  ClaseCertificadoSellos;

type

  TestTCertificadoSellos = class(TTestPrueba)
  strict private
    fCertificadoSellos: TCertificadoSellos;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Tipo_ConArchivoDeFiel_RegreseTipoFiel;
    procedure Tipo_ConArchivoDeSellosl_RegreseTipoSellos;
  end;

implementation

uses
  Windows, SysUtils, Classes, FacturaTipos,
  ConstantesFixtures,
  CodeSiteLogging;


procedure TestTCertificadoSellos.SetUp;
begin
  inherited;

end;

procedure TestTCertificadoSellos.TearDown;
begin

end;

procedure TestTCertificadoSellos.Tipo_ConArchivoDeFiel_RegreseTipoFiel;
var
  certificadoSellos: TCertificadoSellos;
begin
  // NOTA: Debido a que la FIEL es privada, esta prueba se omite al no tener una
  // FIEL "de pruebas", sin embargo si se desea realizar se puede descomentar el
  // codigo siguiente para realizarla especificando la ruta del certificado FIEL a probar
  {certificadoSellos := TCertificadoSellos.Create('C:\FIEL.cer');
  try
    CheckTrue(tcFIEL = certificadoSellos.Tipo,
            'El certificado leido debio haberse establecido como tcFIEL');
  finally
    certificadoSellos.Free;
  end;     }
  Check(True);
end;

procedure TestTCertificadoSellos.Tipo_ConArchivoDeSellosl_RegreseTipoSellos;
var
  certificadoSellos: TCertificadoSellos;
const
  _ARCHIVO_CERTIFICADO_SELLOS = 'openssl\aaa010101aaa_CSD_01.cer';
begin
  certificadoSellos := TCertificadoSellos.Create(fRutaFixtures + _ARCHIVO_CERTIFICADO_SELLOS);
  try
    CheckTrue(tcSellos = certificadoSellos.Tipo,
              'El certificado leido debio haberse establecido como tcSellos');
  finally
    certificadoSellos.Free;
  end;
end;

initialization
  RegisterTest(TestTCertificadoSellos.Suite);
end.
