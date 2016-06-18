{* *****************************************************************************
  PROYECTO FACTURACION ELECTRONICA
  Copyright (C) 2010-2014 - Bambu Code SA de CV

  Esta clase representa un Comprobante Fiscal Digital en su Version 2.0 asi como
  los metodos para generarla.

  Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
  http://bambucode.com/codigoabierto

  La licencia de este codigo fuente se encuentra en:
  http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA

  Cambios para CFDI v3.2 Por Ing. Pablo Torres TecSisNet.net Cd. Juarez Chihuahua
  el 11-24-2013
***************************************************************************** *}

unit EnviaComprobante;

interface
uses classes,
     sysUtils,
     Dialogs,
     IdMessage,
     IdIOHandler,
     IdIOHandlerSocket,
     IdIOHandlerStack,
     IdSSL,
     FacturaTipos,
     IdMessageClient,
     IdSMTPBase,
     IdBaseComponent,
     IdAttachmentFile,
     IdComponent,
     IdTCPConnection,
     IdTCPClient,
     idSMTP,
     IdExplicitTLSClientServerBase,
     IdSSLOpenSSL,
     idException;
type
 TEnviaComprobante =class
 private
  fNombre,fUsuario,fClave,fServidor,fPDFFile,fXMLFile,fCorreo,fAsunto,fMensaje:String;
  fPuerto : Integer;
  fSeguro : Boolean;
  fMetodo : TMetodo;
  fUsarTSL :TUsarTSL;
  fFormato :TFormato;
 protected
  fSMTP: TIdSMTP;
  fIOHandler: TManejador;
  fMailMessage: TIdMessage;
 published
  property Nombre :String read fNombre write fNombre;
  property Usuario :String read fUsuario write fUsuario;
  property Mensaje :String read fMensaje write fMensaje;
  property Servidor :String read fServidor write fServidor;
  property Clave :String read fClave write fClave;
  property Correo :String read fCorreo write fCorreo;
  property PDFFile :String read fPDFFile write fPDFFile;
  property XMLFile :String read fXMLFile write fXMLFile;
  property Formato :TFormato read fFormato write fFormato;
  property Asunto :String read fAsunto write fAsunto;
  property Puerto :Integer read fPuerto write fPuerto;
  property Seguro :Boolean read fSeguro write fSeguro;
  property Metodo : TMetodo read fMetodo write fMetodo;
  property UsarTSL :TUsarTSL read fUsarTSL write fUsarTSL;
 public
  Function EnviaComprobante:Boolean;
  constructor Create;
  destructor destroy;
 end;
implementation

constructor TEnviaComprobante.Create;
Begin
// Creo los componentes
  fSMTP:=TIdSMTP.Create;
  fIOHandler:= TManejador.Create;
  fMailMessage:=TIdMessage.Create;
// defino los estandares para hotmail gmail etc
  fSeguro:=True;
  fUsarTSL:=utUseExplicitTLS;
  fMetodo:=sslvSSLv3;
  fFormato:=tfPdf;
End;

destructor TEnviaComprobante.destroy;
Begin
 fSMTP.Free;
 fIOHandler.Free;
 fMailMessage.Free;
End;

Function TEnviaComprobante.EnviaComprobante:Boolean;
var
  FOutputStream: TMemoryStream;
begin
 Result:=True;
 Assert(fNombre <> '', 'El nombre del Emisor es invalido');
 Assert(fUsuario <> '', 'El usuario fue invalido');
 Assert(fClave <> '', 'La clave de correo fue invalida');
 Assert(fServidor <> '', 'El servidor de correo fue invalido');
 Assert(fAsunto <> '', 'El asunto es invalido');
 Assert(fMensaje <> '', 'El mensaje es invalido');
 Assert(fPuerto <> 0, 'El puerto es invalido');
 if Trim(fCorreo)='' then
   fCorreo:=InputBox('Introduzca el correo electronico del destinatario','Correo Electronico','');
 if Trim(fCorreo)='' then
  Begin
   raise exception.create('El correo electronico del destinatario es invalido, el proceso se detendra');
   Result:=False;
   Exit;
  End;
  //Configurar el servidor de salida
  fSMTP.Host:=fServidor;
  fSMTP.Port :=fPuerto;
  fSMTP.Username:=fUsuario;
  fSMTP.Password:=fClave;

  //Configurar el ssl si se necesita
  if fSeguro then
  begin
    fIOHandler.Port:=fPuerto;
    fIOHandler.SSLOptions.Method:=fMetodo;
    fSMTP.IOHandler:=fIOHandler;
    fSMTP.UseTLS:=fUsarTSL;
  end;
  //configurar el mensaje de correo
  fMailMessage.Clear;
  fMailMessage.Priority := mpNormal;
//  fMailMessage.From.Name := FNombreEnvia; // 'Usuario Envia';//quien envia
//  fMailMessage.From.Address := FCorreoEnvia; // 'correo@loquesea.net';
//  if fConfirmacion then
//   fMailMessage.ReceiptRecipient.Text := FCorreoEnvia; // se usa para solicitar confirmación de correo
  fMailMessage.ContentType:='multipart/mixed';
  fMailMessage.From.Address := fSMTP.Username;
  fMailMessage.From.Name:=fNombre;
  fMailMessage.Recipients.EMailAddresses := fCorreo;
  fMailMessage.Subject:=fAsunto;
  fMailMessage.Body.Text:=fMensaje;

  //agregar el pdf al correo
  if FileExists(fPDFFile) then
   Begin
    with TIdAttachmentFile.Create(fMailMessage.MessageParts, fPDFFile) do
    begin
      ContentID:='1';
      if fFormato=tfPdf then
       ContentType:='application/pdf'
      Else if fFormato=tfBMP then
       ContentType:='image/bmp'
      Else if fFormato=tfXLS then
       ContentType:='application/vnd.ms-excel'
      Else if fFormato=tfHTML then
       ContentType:='text/html'
      Else if fFormato=tfTIF then
       ContentType:='image/tiff'
      Else if fFormato=tfJPG then
       ContentType:='image/jpeg';
      FileName:=fPDFFile;
    end;
   end; 
   if FileExists(fXMLFile) then
    Begin
     with TIdAttachmentFile.Create(fMailMessage.MessageParts, fXMLFile) do
      begin
       ContentID:='2';
       ContentType:='text/xml';
       FileName:=fXMLFile;
      end;
    End;
  //enviar el correo
  try
    with fSMTP do
     Try
      ConnectTimeout:=3000;
      ReadTimeout:=3000;
      Connect;
      Send(fMailMessage);
    except
     on E:Exception do
      Begin
       Result:=False;
       raise exception.create('ERROR al enviar correo: ' + E.Message);
      End;
    end;
  finally
    if fSMTP.Connected then fSMTP.Disconnect;
  end;
end;


end.
