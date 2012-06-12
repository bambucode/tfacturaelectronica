(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2012 - Bambu Code SA de CV - Ing. Luis Carrasco

 Proyecto de consola que genera una Factura Electronica de ejemplo

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
program EjemploFacturaElectronica;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ActiveX,
  ShlObj,
  Forms,
  ClaseOpenSSL in '..\ClaseOpenSSL.pas',
  ComprobanteFiscal in '..\ComprobanteFiscal.pas',
  FacturaElectronica in '..\FacturaElectronica.pas',
  FacturaReglamentacion in '..\FacturaReglamentacion.pas',
  FacturaTipos in '..\FacturaTipos.pas',
  libeay32 in '..\libeay32.pas',
  LibEay32Plus in '..\LibEay32Plus.pas',
  OpenSSLUtils in '..\OpenSSLUtils.pas',
  SelloDigital in '..\SelloDigital.pas',
  DateUtils,
  DocComprobanteFiscal in '..\DocComprobanteFiscal.pas',
  CadenaOriginal in '..\CadenaOriginal.pas';

var
   sArchivo: String;
   Factura: TFacturaElectronica;
   Emisor, Receptor: TFEContribuyente;
   Certificado: TFECertificado;
   BloqueFolios: TFEBloqueFolios;
   Impuesto1, Impuesto2: TFEImpuestoTrasladado;
   Concepto1, Concepto2 : TFEConcepto;

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

begin
  {$IF CompilerVersion < 20}
      // Bajo Delphi < 2009 tenemos que mandar llamar la siguiente rutina
      // para poder usar rutinas de la clase ActiveX, en este caso la rutina
      // para obtener la ruta al Escritorio de Windows.
      CoInitialize(nil);
  {$IFEND}


  try
      // 1. Definimos los datos del emisor y receptor
      Emisor.RFC:='AAA010101AAA';
      Emisor.Nombre:='A.C. de Pruebas';
      Emisor.Direccion.Calle:='Av. Hidalgo';
      Emisor.Direccion.NoExterior:='77';
      Emisor.Direccion.CodigoPostal:='06300';
      Emisor.Direccion.Colonia:='Guerrero';
      Emisor.Direccion.Municipio:='Coyoacán';
      Emisor.Direccion.Estado:='Distrito Federal';
      Emisor.Direccion.Pais:='México';

      // 2. Agregamos los régimenes fiscales (requerido en el CFD 2.2)
      SetLength(Emisor.Regimenes, 1);
      Emisor.Regimenes[0] := 'Profesionista con Actividad Empresarial';

      Receptor.RFC:='FIFC000101AM1';
      Receptor.Nombre:='Contribuyente de Pruebas Ficticio';
      Receptor.Direccion.Calle:='Av. Hidalgo';
      Receptor.Direccion.NoExterior:='88';
      Receptor.Direccion.CodigoPostal:='06301';
      Receptor.Direccion.Colonia:='Guerrero';
      Receptor.Direccion.Municipio:='Coyoacán';
      Receptor.Direccion.Estado:='Distrito Federal';
      Receptor.Direccion.Pais:='México';

      // 3. Definimos los datos de los folios que nos autorizo el SAT
      BloqueFolios.NumeroAprobacion:=1;
      BloqueFolios.AnoAprobacion:=2010;
      BloqueFolios.Serie:='A';
      BloqueFolios.FolioInicial:=1;
      BloqueFolios.FolioFinal:=1000;

      // 4. Definimos el certificado junto con su llave privada
      Certificado.Ruta:=ExtractFilePath(Application.ExeName) + '/aaa010101aaa_CSD_01.cer';
      Certificado.LlavePrivada.Ruta:=ExtractFilePath(Application.ExeName) + '\aaa010101aaa_CSD_01.key';
      Certificado.LlavePrivada.Clave:='a0123456789';

      // 5. Creamos la clase Factura con los parametros minimos.
      Factura:=TFacturaElectronica.Create(Emisor, Receptor, BloqueFolios, Certificado, tcIngreso);
      //Factura.AutoAsignarFechaGeneracion := False;
      //Factura.FechaGeneracion := EncodeDateTime(2012, 06, 12, 11, 32, 50, 0);
      //Factura.OnComprobanteGenerado:=onComprobanteGenerado;

      Factura.MetodoDePago:='efectivo';
      // Asignamos el lugar de expedición (requerido en la CFD 2.2)
      Factura.LugarDeExpedicion:='Chihuahua, Chihuahua';

      // Definimos todos los conceptos que incluyo la factura
      Concepto1.Cantidad:=1;
      Concepto1.Unidad:='PZA';
      Concepto1.Descripcion:='Lapiz Numero 2';
      Concepto1.ValorUnitario:=10;
      Factura.AgregarConcepto(Concepto1);

      // Agregamos el impuesto del concepto 1
      Impuesto1.Nombre:='IVA';
      Impuesto1.Tasa:=16;
      Impuesto1.Importe:=(Concepto1.ValorUnitario * Concepto1.Cantidad) * (Impuesto1.Tasa/100);
      Factura.AgregarImpuestoTrasladado(Impuesto1);

      Concepto2.Cantidad:=3;
      Concepto2.Unidad:='M';
      Concepto2.Descripcion:='Alimento o Medicina';
      Concepto2.ValorUnitario:=10.50;
      Factura.AgregarConcepto(Concepto2);

      // Agregamos el impuesto del concepto 2 con Tasa Cero
      Impuesto2.Nombre:='IVA';
      Impuesto2.Tasa:=0;
      Impuesto2.Importe:=(Concepto2.ValorUnitario * Concepto2.Cantidad) * (Impuesto2.Tasa/100);
      Factura.AgregarImpuestoTrasladado(Impuesto2);

      // Le damos un descuento
      //Factura.AsignarDescuento(5, 'Por pronto pago');

      // Mandamos generar la factura con el siguiente folio disponible
      sArchivo:=GetDesktopFolder() + '\MiFactura.xml';
      Factura.GenerarYGuardar(1, fpUnaSolaExhibicion, sArchivo);

      WriteLn('La factura ha sido generada y guardada en el escritorio. El archivo es: ' + sArchivo);
      Readln;
      FreeAndNil(Factura);
  except
    on E: Exception do
    begin
      WriteLn('Ocurrio un error:');
      Writeln(E.ClassName, ': ', E.Message);
      ReadLn;
    end;
  end;

  {$IF CompilerVersion < 20}
      CoUnInitialize; // Liberamos la memoria usada por la unidad ActiveX
  {$IFEND}

end.



