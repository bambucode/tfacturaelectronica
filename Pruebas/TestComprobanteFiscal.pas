(* *****************************************************************************
  Copyright (C) 2010 - Bambu Code SA de CV - Ing. Luis Carrasco

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/bc_facturaelectronica/blob/master/LICENCIA
  ***************************************************************************** *)
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
      procedure Create_NuevoComprobante_GenereEstructuraXMLBasica;
      procedure setReceptor_Receptor_LoGuardeEnXML;
      procedure setEmisor_Emisor_LoGuardeEnXML;
      procedure AgregarConcepto_Concepto_LoGuardeEnXML;
      procedure setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
  end;

implementation

uses
  Windows, SysUtils, Classes, ConstantesFixtures;

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
var
   Concepto: TFEConcepto;
   sXMLConcepto : WideString;
begin
   sXMLConcepto:=leerContenidoDeFixture('comprobante_fiscal/concepto.xml');

   Concepto.Cantidad:=12.55;
   Concepto.Unidad:='pz';
   // Incluimos algunos caracteres invalidos para el XML para verificar
   // que se estén "escapando" correctamente
   Concepto.Descripcion:='Jabón & Jabón Modelo <ABC>';
   Concepto.ValorUnitario:=30.50;

   fComprobanteFiscal.AgregarConcepto(Concepto);
   
   CheckEquals(sXMLConcepto, fComprobanteFiscal.fXmlComprobante.XML,
              'El concepto no fue almacenado correctamente en la estrucutr XML');
end;

procedure TestTFEComprobanteFiscal.Create_NuevoComprobante_GenereEstructuraXMLBasica;
var
   sXMLEncabezadoBasico: WideString;
   NuevoComprobante: TFEComprobanteFiscal;
begin
    // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
   sXMLEncabezadoBasico:=leerContenidoDeFixture('comprobante_fiscal/comprobante_nuevo.xml');
   NuevoComprobante := TFEComprobanteFiscal.Create;

   // Checamos que sea igual que nuestro Fixture...
   CheckEquals(sXMLEncabezadoBasico, fComprobanteFiscal.fXmlComprobante.XML, 'El encabezado del XML basico para un comprobante no fue el correcto');
   FreeAndNil(NuevoComprobante);
end;

procedure TestTFEComprobanteFiscal.setCertificado_Certificado_GuardeNumeroDeSerieEnEstructuraXML;
var
   Certificado: TFECertificado;
   sXMLConNumSerieCertificado: WideString;
begin
   Certificado.Ruta:=fRutaFixtures + _RUTA_CERTIFICADO;

   // Leemos el contenido de nuestro 'Fixture' para comparar que sean iguales...
   sXMLConNumSerieCertificado:=leerContenidoDeFixture('comprobante_fiscal/comprobante_numeroserie.xml');

   // Especificamos el certificado que usaremos a la clase comprobante
   fComprobanteFiscal.Certificado:=Certificado;

   // Checamos que sea igual que nuestro Fixture...
   CheckEquals(sXMLConNumSerieCertificado, fComprobanteFiscal.fXmlComprobante.XML, 'El Contenido XML no contiene el numero de serie del certificado o este es incorrecto.');
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

