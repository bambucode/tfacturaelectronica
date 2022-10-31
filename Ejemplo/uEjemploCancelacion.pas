unit uEjemploCancelacion;

interface

uses Facturacion.ProveedorAutorizadoCertificacion;

procedure CancelarCFDI(const aPAC: IProveedorAutorizadoCertificacion);
procedure ObtenerAcuseCFDI(const aPAC: IProveedorAutorizadoCertificacion);

implementation

uses Facturacion.CancelaCFD, VCL.Forms, SysUtils;

procedure CancelarCFDI(const aPAC: IProveedorAutorizadoCertificacion);
var
  solicitudCancelacion : TSolicitudCancelacionCFD;
  archivoCertificados, archivoLlavePrivada, contrasenaLlavePrivada: String;
begin
  Assert(aPAC <> nil, 'La instancia aPAC no debio ser nula');

//  solicitudCancelacion.RFCEmisor := 'EKU9003173C9';
//  solicitudCancelacion.UUID := '76efb3fe-2bea-4f32-af30-cfb4af4aeceb';
//  solicitudCancelacion.Motivo := '02';

  solicitudCancelacion.RFCEmisor := 'EKU9003173C9';
  solicitudCancelacion.UUID := '76efb3fe-2bea-4f32-af30-cfb4af4aeceb';
  solicitudCancelacion.Motivo := '01';
  solicitudCancelacion.UUIDSustituto := '76efb3fe-2bea-4f32-af30-cfb4af4a1234';

//  solicitudCancelacion.RFCEmisor := 'EKU9003173C9';
//  solicitudCancelacion.UUID := '76efb3fe-2bea-4f32-af30-cfb4af4aeceb';
//  solicitudCancelacion.Motivo := '04';

  archivoCertificados := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.cer';
  archivoLlavePrivada := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Escuela_Kemper_Urgate_EKU9003173C9_20190617_131753.key';
  contrasenaLlavePrivada := '12345678a';

  {$ifdef PAC_DEMO_FINOK}
      rutaCertificado   := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.cer';
      rutaLlavePrivada  := ExtractFilePath(Application.ExeName) + '..\CSD Pruebas\CSD_Pruebas_CFDI_MISC491214B86_20190528_175522.key';
      claveLlavePrivada := '12345678a';
//      solicitudCancelacion.RFCEmisor := 'EKU9003173C9';

      olicitudCancelacion.UUID := '5EB5DCB4-A500-5C0E-A3F2-6912C1BF4B05';
      solicitudCancelacion.UUIDSustitutoFolioSustitucion:='';//'697EF015-0028-505C-8E09-5D340ABD5356';
      solicitudCancelacion.Motivo:='02';
  {$endif}

  if aPAC.CancelarDocumento(solicitudCancelacion,
                            archivoCertificados,
                            archivoLlavePrivada,
                            contrasenaLlavePrivada) then
    WriteLn('Se solicitó cancelación de forma exitosa')
  else
    WriteLn('Ocurrio un problema con la cancelacion');
end;

procedure ObtenerAcuseCFDI(const aPAC: IProveedorAutorizadoCertificacion);
var
  solicitudAcuse: TSolicitudAcuseCancelacionCFD;
begin
  solicitudAcuse.RFCEmisor := 'EKU9003173C9';
  solicitudAcuse.UUID := '76efb3fe-2bea-4f32-af30-cfb4af4aeceb';
  WriteLn('Se obtuvo el acuse de cancelacion:');
  WriteLn(aPAC.ObtenerAcuseDeCancelacion(solicitudAcuse));
end;

end.