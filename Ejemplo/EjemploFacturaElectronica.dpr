(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Proyecto de consola que genera una Factura Electronica de ejemplo

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 Cambios para CFDI v3.2 Por Ing. Pablo Torres TecSisNet.net Cd. Juarez Chihuahua
 el 11-24-2013

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
program EjemploFacturaElectronica;

{$APPTYPE CONSOLE}
{.$DEFINE CODESITE}

uses
  SysUtils,
  ActiveX,
  ShlObj,
  Forms,
  ExtCtrls,
  Classes,
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
  CadenaOriginal in '..\CadenaOriginal.pas',
  FeCFDv22 in '..\CFD\FeCFDv22.pas',
  FeCFDv2 in '..\CFD\FeCFDv2.pas' {/,},
  FeCFDv32 in '..\CFD\FeCFDv32.pas',
  FETimbreFiscalDigital in '..\CFD\FETimbreFiscalDigital.pas',
  ProveedorAutorizadoCertificacion in '..\PACs\ProveedorAutorizadoCertificacion.pas',
  FeCFD in '..\CFD\FeCFD.pas',
  EcodexWsTimbrado in '..\PACs\Ecodex\EcodexWsTimbrado.pas',
  EcodexWsSeguridad in '..\PACs\Ecodex\EcodexWsSeguridad.pas',
  PAC.Ecodex.ManejadorDeSesion in '..\PACs\Ecodex\PAC.Ecodex.ManejadorDeSesion.pas',
  FacturacionHashes in '..\FacturacionHashes.pas',
  PACEcodex in '..\PACs\Ecodex\PACEcodex.pas',
  {$IFDEF CODESITE}
  CodeSiteLogging,
  {$ENDIF}
  PACComercioDigital in '..\PACs\ComercioDigital\PACComercioDigital.pas',
  PACEjemplo in '..\PACs\Ejemplo\PACEjemplo.pas',
  GeneradorCBB in '..\GeneradorCBB\GeneradorCBB.pas',
  QuricolAPI in '..\GeneradorCBB\QuricolAPI.pas',
  QuricolCode in '..\GeneradorCBB\QuricolCode.pas',
  FinkOkWsTimbrado in '..\PACs\FinkOk\FinkOkWsTimbrado.pas',
  PACFinkOk in '..\PACs\FinkOk\PACFinkOk.pas',
  FECancelaComercioDigital in '..\PACs\ComercioDigital\FECancelaComercioDigital.pas';

var
   ProveedorTimbrado : TProveedorAutorizadoCertificacion;
   TimbreDeFactura : TFETimbre;
   archivoFacturaXML, rutaImagenCBB: String;
   Factura: TFacturaElectronica;
   Emisor, Receptor: TFEContribuyente;
   Certificado: TFECertificado;
   Impuesto1, Impuesto2: TFEImpuestoTrasladado;
   Concepto1, Concepto2 : TFEConcepto;
   generadorCBB: TGeneradorCBB;
   CredencialesPAC: TFEPACCredenciales;
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


  // Checamos la presencia de archivos necesarios para el ejemplo
  if Not FileExists('./libeay32.dll') then
  begin
    WriteLn('Favor de copiar el archivo libeay32.dll del paquete OpenSSL descargable de: http://www.openssl.org/related/binaries.html');
    Readln;
    exit;
  end;

  if Not FileExists('./libssl32.dll') then
  begin
    WriteLn('Favor de copiar el archivo libssl32.dll del paquete OpenSSL descargable de: http://www.openssl.org/related/binaries.html');
    Readln;
    exit;
  end;

  // Checamos la presencia del DLL de la libreria para generacion de CBB
  if Not FileExists('./quricol32.dll') then
  begin
    WriteLn('Favor de copiar el archivo quricol32.dll de la subcarpeta \GeneradorCBB a la carpeta donde esta el ejecutable');
    Readln;
    exit;
  end;

  {$IF CompilerVersion < 20}  // se movio porque no alcanza a mostrar el mensaje de error de librerias
      // Bajo Delphi < 2009 tenemos que mandar llamar la siguiente rutina
      // para poder usar rutinas de la clase ActiveX, en este caso la rutina
      // para obtener la ruta al Escritorio de Windows.
      CoInitialize(nil);
  {$IFEND}

  try
      // 1. Definimos los datos del emisor y receptor

      // Si se desea probar al PAC FinkOk usar el siguiente Emisor:
      Emisor.RFC:='AAD990814BP7';
      // Si se desea usar al PAC Ecodex usar al siguiente Emisor
      //Emisor.RFC:='AAA010101AAA';

      Emisor.Nombre:='Mi Empresa SA de CV';
      Emisor.Direccion.Calle:='Calle de la Amargura';
      Emisor.Direccion.NoExterior:='123';
      Emisor.Direccion.NoInterior:='456';
      Emisor.Direccion.CodigoPostal:='87345';
      Emisor.Direccion.Colonia:='Col. Bondojito';
      Emisor.Direccion.Municipio:='Oaxaca';
      Emisor.Direccion.Estado:='Oaxaca';
      Emisor.Direccion.Pais:='México';
      Emisor.Direccion.Localidad:='Oaxaca';
      
       // 2. Agregamos los régimenes fiscales (requerido en CFD >= 2.2)
      SetLength(Emisor.Regimenes, 1);
      Emisor.Regimenes[0] := 'Regimen General de Ley';

      // Asignamos los valores iguales a la direcion del emisor suponiendo que se genera en el mismo lugar que se emitio
      Emisor.ExpedidoEn.Calle:=Emisor.Direccion.Calle;
      Emisor.ExpedidoEn.NoExterior:=Emisor.Direccion.NoExterior;
      Emisor.ExpedidoEn.NoInterior:=Emisor.Direccion.NoInterior;
      Emisor.ExpedidoEn.CodigoPostal:=Emisor.Direccion.CodigoPostal;
      Emisor.ExpedidoEn.Colonia:=Emisor.Direccion.Colonia;
      Emisor.ExpedidoEn.Municipio:=Emisor.Direccion.Municipio;
      Emisor.ExpedidoEn.Estado:=Emisor.Direccion.Estado;
      Emisor.ExpedidoEn.Pais:=Emisor.Direccion.Pais;
      Emisor.ExpedidoEn.Localidad:=Emisor.Direccion.Localidad;
      Emisor.ExpedidoEn.Referencia:=Emisor.Direccion.Referencia;

      Receptor.RFC:='PWD090210DR5';
      Receptor.Nombre:='Mi Cliente SA de CV';
      Receptor.Direccion.Calle:='Patriotismo';
      Receptor.Direccion.NoExterior:='4579';
      Receptor.Direccion.NoInterior:='94';
      Receptor.Direccion.CodigoPostal:='75489';
      Receptor.Direccion.Colonia:='La Añoranza';
      Receptor.Direccion.Municipio:='Coyoacán';
      Receptor.Direccion.Estado:='Veracruz';
      Receptor.Direccion.Pais:='México';
      Receptor.Direccion.Localidad:='Boca del Rio';


      // 4. Definimos el certificado junto con su llave privada
      Certificado.Ruta:=ExtractFilePath(Application.ExeName) + '\' + Emisor.RFC + '.cer';
      Certificado.LlavePrivada.Ruta:=ExtractFilePath(Application.ExeName) + '\' + Emisor.RFC + '.key';
      Certificado.LlavePrivada.Clave:='12345678a';

      // 5. Creamos la clase Factura con los parametros minimos.
      WriteLn('Generando factura CFD ...');
      Factura:=TFacturaElectronica.Create(Emisor, Receptor, Certificado, tcIngreso);

      //Factura.AutoAsignarFechaGeneracion := False;
      //Factura.FechaGeneracion := EncodeDateTime(2012, 05, 12, 19, 47, 22, 0);
      //Factura.OnComprobanteGenerado:=onComprobanteGenerado;

      Factura.MetodoDePago:='Tarjeta de credito';
      //Factura.NumeroDeCuenta:='1234';

      // Asignamos el lugar de expedición (requerido en  CFD >= 2.2)
      Factura.LugarDeExpedicion:='Queretaro, Qro';

      // Definimos todos los conceptos que incluyo la factura
      Concepto1.Cantidad:=10.25;
      Concepto1.Unidad:='Kilo';
      Concepto1.Descripcion:='Arroz blanco precocido';
      Concepto1.ValorUnitario:=12.23;
      Factura.AgregarConcepto(Concepto1);

      // Agregamos el impuesto del concepto 1
      Impuesto1.Nombre:='IVA';
      Impuesto1.Tasa:=16;
      Impuesto1.Importe:=(Concepto1.ValorUnitario * Concepto1.Cantidad) * (Impuesto1.Tasa/100);
      Factura.AgregarImpuestoTrasladado(Impuesto1);

      Concepto2.Cantidad:=5;
      Concepto2.Unidad:='PZA';
      Concepto2.Descripcion:='Piña dulce del bajio';
      Concepto2.ValorUnitario:=18.90;
      Factura.AgregarConcepto(Concepto2);

      // Le damos un descuento
      //Factura.AsignarDescuento(5, 'Por pronto pago');

      // Mandamos generar la factura con el siguiente folio disponible
      if Not(DirectoryExists(GetDesktopFolder() + '\Prueba-CFDI')) then
        CreateDir(GetDesktopFolder() + '\Prueba-CFDI');

      archivoFacturaXML:=GetDesktopFolder() + '\Prueba-CFDI\MiFactura.xml';
      rutaImagenCBB := GetDesktopFolder() + '\Prueba-CFDI\MiFactura-CBB.jpg';

      // Mandamos generar el CFD en memoria antes de timbrarlo
      Factura.Generar(12345, fpUnaSolaExhibicion);
      
      // Ya que tenemos el comprobante, lo mandamos timbrar con el PAC de nuestra elección,
      // por cuestiones de ejemplo, usaremos al PAC "Ecodex"

      ProveedorTimbrado := TPACFinkOk.Create;
      //ProveedorTimbrado := TPACEcodex.Create;
      //ProveedorTimbrado := TPACComercioDigital.Create; // Si queremos usar a Comercio Digital solo des-comentamos aqui

      try
        CredencialesPAC.RFC   := Emisor.RFC;
        CredencialesPAC.Clave := 'PWD';

        // Este es el "ID de Integrador" de pruebas de Ecodex
        CredencialesPAC.DistribuidorID := '2b3a8764-d586-4543-9b7e-82834443f219';

        // Asignamos nuestras credenciales de acceso con el PAC
        ProveedorTimbrado.AsignarCredenciales(CredencialesPAC);

        // Mandamos timbrar el documento al PAC
        TimbreDeFactura := ProveedorTimbrado.TimbrarDocumento(Factura.XML);

        // Asignamos el timbre a la factura para que sea válida
        WriteLn('Asignando timbre a factura para generar CFDI');
        Factura.AsignarTimbreFiscal(TimbreDeFactura);

        // Ahora generamos el CBB del CFDI
        generadorCBB := TGeneradorCBB.Create;

        // Generamos el CBB que por default se genera de 1200x1200px para que tenga la resolucion necesaria
        generadorCBB.GenerarImagen(Emisor,
                                   Receptor,
                                   Factura.Total,
                                   TimbreDeFactura.UUID,
                                   rutaImagenCBB);

      finally
        ProveedorTimbrado.Free;
        generadorCBB.Free;
      end;

      // Finalmente ya que la factura fue timbrada mandamos guardar la factura
      Factura.Guardar(archivoFacturaXML);

      FreeAndNil(Factura);
      WriteLn('CFDI generado con éxito en ' + archivoFacturaXML + '. Presiona cualquier tecla para salir');
      Readln;
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



