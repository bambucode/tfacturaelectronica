unit TestComprobanteFiscal;

interface

uses
  TestFramework, ComprobanteFiscal, FacturaTipos, TestPrueba;

type

  TestTFEComprobanteFiscal = class(TTestPrueba)
  strict private
    fComprobanteFiscal: TFEComprobanteFiscal;
  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
      procedure setReceptor_Receptor_LoGuardeEnXML;
      procedure setEmisor_Emisor_LoGuardeEnXML;
      procedure AgregarConcepto_Concepto_LoGuardeEnXML;
      procedure Create_NuevoComprobante_GenereEstructuraXMLBasica;
  end;

implementation

uses
  Windows, SysUtils, Classes;

procedure TestTFEComprobanteFiscal.SetUp;
begin
   inherited;
   fComprobanteFiscal:=TFEComprobanteFiscal.Create;
end;

procedure TestTFEComprobanteFiscal.TearDown;
begin
   FreeAndNil(fComprobanteFiscal);
end;

procedure TestTFEComprobanteFiscal.AgregarConcepto_Concepto_LoGuardeEnXML;
begin
    //
end;

procedure TestTFEComprobanteFiscal.Create_NuevoComprobante_GenereEstructuraXMLBasica;
begin
  //
end;

procedure TestTFEComprobanteFiscal.setEmisor_Emisor_LoGuardeEnXML;
var
  Emisor: TFEContribuyente;
  sXMLConReceptor: WideString;
begin
  Emisor.Nombre:='Industrias del Sur Poniente, S.A. de C.V.';
  Emisor.RFC:='ISP900909Q88';
  with Emisor.Direccion do
  begin
    Calle:='Alvaro Obregón';
    NoExterior:='37';
    NoInterior:='';
    CodigoPostal:='31000';
    Colonia:='Col. Roma Norte';
    Municipio:='Cuauhtémoc';
    Estado:='Distrito Federal';
    Pais:='México';
    Localidad:='';
    Referencia:='';
  end;

  // Establecemos el receptor
  fComprobanteFiscal.Emisor:=Emisor;

  //guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'emisor.xml');
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConReceptor:=leerContenidoDeFixture('comprobante_fiscal/emisor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML, 'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

procedure TestTFEComprobanteFiscal.setReceptor_Receptor_LoGuardeEnXML;
var
  Receptor: TFEContribuyente;
  sXMLConReceptor: WideString;
begin
  Receptor.Nombre:='Rosa María Calderón Uriegas';
  Receptor.RFC:='CAUR390312S87';
  with Receptor.Direccion do
  begin
    Calle:='Jardines del Valle';
    NoExterior:='06700';
    NoInterior:='';
    CodigoPostal:='95465';
    Colonia:='Prau Prau';
    Municipio:='Monterrey';
    Estado:='Nuevo León';
    Pais:='México';
    Localidad:='Monterrey';
    Referencia:='';
  end;

  // Establecemos el receptor
  fComprobanteFiscal.Receptor:=Receptor;
  //guardarContenido(fComprobanteFiscal.fXmlComprobante.XML, 'comprobante_fiscal/receptor.xml');
  // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
  sXMLConReceptor:=leerContenidoDeFixture('comprobante_fiscal/receptor.xml');
  CheckEquals(sXMLConReceptor, fComprobanteFiscal.fXmlComprobante.XML, 'El Contenido XML del Comprobante no almaceno correctamente los datos del receptor (es diferente al fixture receptor.xml)');
end;

initialization
  // Registra la prueba de esta unidad en la suite de pruebas
  RegisterTest(TestTFEComprobanteFiscal.Suite);
end.

