{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}
unit Facturacion.ProveedorAutorizadoCertificacion;

interface

uses
{$IF CompilerVersion >= 23}
     System.Classes,
     System.SysUtils,
     System.Generics.Collections,
{$ELSE}
     Classes,
     SysUtils,
   {$IF CompilerVersion >= 20}
     Generics.Collections,
   {$IFEND}
{$IFEND}
     Facturacion.Comprobante,
     Facturacion.Tipos;
<<<<<<< HEAD
  Const

   PAC_PARAM_SVC_URL_API = 'PAC_PARAM_SVC_URL_API';
   PAC_PARAM_SVC_URL_API_TIMBRADO = 'PAC_PARAM_SVC_URL_API_TIMBRADO';
   PAC_PARAM_SVC_URL_API_CANCELACION = 'PAC_PARAM_SVC_URL_API_CANCELACION';
   PAC_PARAM_SVC_URL_API_CLIENTES    = 'PAC_PARAM_SVC_URL_API_CLIENTES';
   PAC_PARAM_SVC_MODO_PRODUCCION = 'PAC_PARAM_SVC_MODO_PRODUCCION';

   PAC_PARAM_SESION_TRANSACCION_INICIAL = 'PAC_PARAM_TRANSACCION_INICIAL';

   //Credenciales
   PAC_PARAM_SESION_ID                              = 'PAC_PARAM_SESION_ID';
   PAC_PARAM_SESION_PAC_USUARIO_ID     = 'PAC_PARAM_SESION_PAC_USUARIO_ID';
   PAC_PARAM_SESION_PAC_USUARIO_CLAVE  = 'PAC_PARAM_SESION_PAC_USUARIO_CLAVE';
   PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID = 'PAC_PARAM_SESION_PAC_DISTRIBUIDOR_ID';

   PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID     = 'PAC_PARAM_SESION_INTEGRADOR_USUARIO_ID';
   PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE  = 'PAC_PARAM_SESION_INTEGRADOR_USUARIO_CLAVE';
   PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID = 'PAC_PARAM_SESION_INTEGRADOR_DISTRIBUIDOR_ID';

   PAC_PARAM_SEGURIDAD_CERTIFICADO        = 'PAC_PARAM_SEGURIDAD_CERTIFICADO';
   PAC_PARAM_SEGURIDAD_LLAVEPRIVADA       = 'PAC_PARAM_SEGURIDAD_LLAVEPRIVADA';
   PAC_PARAM_SEGURIDAD_LLAVEPRIVADA_CLAVE = 'PAC_PARAM_SEGURIDAD_LLAVEPRIVADA_CLAVE';

=======
>>>>>>> b6e7ec2ea5703f4e07d9023331866b9af1740dad
type

  TListadoUUID = Array of string;
  // NOTA: Aqui se debera cambiar el TDictionary por otro codigo para versiones de
  // Delphi anteriores

 {$IF CompilerVersion >= 20}
  TListadoCancelacionUUID = TDictionary<String, Boolean>;
 {$ELSE}
  // No es la clase mas optimizada que pueda existir para Delphi 7, pero cumple con las
  // funciones basicas

  TUUIDInfoList=class;
  TUUIDInfoListItem = class(TObject)
  private
  protected
    fCancelado: boolean;
    fEncontrado: boolean;
    fExtraInfo: string;
    fTag: NativeInt;
    fTagStr: String;
    fUUID: string;
    fUUIDList: TUUIDInfoList;
  public
   constructor Create( aUUID:String; aEncontrado: Boolean; aCancelado: Boolean;
    aExtraInfo: string=''; aUUIDList: TUUIDInfoList=nil); reintroduce; overload;
   property UUID: string read fUUID write fUUID;
   property Cancelado: boolean read fCancelado write fCancelado;
   property Encontrado: boolean read fEncontrado write fEncontrado;
   property ExtraInfo: string read fExtraInfo write fExtraInfo;
   property Tag: NativeInt read fTag write fTag;
   property TagStr: String read fTagStr write fTagStr;
  end;

  TUUIDInfoList = class(TStringList)
  private
    function GetCancelado(const UUID: string): Boolean;
    function GetItems(const UUID: string): TUUIDInfoListItem;
    procedure SetCancelado(const UUID: string; const Value: Boolean);
    procedure SetItems(const UUID: string; const Value: TUUIDInfoListItem);
  protected
   procedure FreeItems;
  public
   destructor Destroy; override;
   procedure Clear; override;
   procedure Delete(Index: Integer); override;
   function Add(aUUID:String; aEncontrado: Boolean; aCancelado: Boolean;
    aExtraInfo: string=''): TUUIDInfoListItem; reintroduce; overload;
   function Add(aUUID:String; aCancelado: Boolean; aExtraInfo: string=''): TUUIDInfoListItem; overload;
   function AddCancelado(aUUID:String; aExtraInfo: string=''): TUUIDInfoListItem; overload;
   property Items[const UUID: string]: TUUIDInfoListItem read GetItems write SetItems;
   property Cancelado[const UUID: string]: Boolean read GetCancelado write SetCancelado;
  end;

  TListadoCancelacionUUID = class(TUUIDInfoList);
 {$IFEND}

  EPACNoConfiguradoException = class(Exception);

  EPACException = class(ECFDIException)
  private
    fCodigoErrorSAT: Integer;
    fCodigoErrorPAC: Integer;
  public
    constructor Create(const aMensajeExcepcion: String;
                       const aCodigoErrorSAT: Integer;
                       const aCodigoErrorPAC: Integer;
                       const aReintentable: Boolean);

    property CodigoErrorSAT: Integer read fCodigoErrorSAT;
    property CodigoErrrorPAC: Integer read fCodigoErrorPAC;
  end;

  EPACXMLMalFormadoException                    = class(EPACException);
  EPACServicioNoDisponibleException             = class(EPACException);
  EPACCredencialesIncorrectasException          = class(EPACException);
  EPACEmisorNoInscritoException                 = class(EPACException);
  EPACErrorGenericoDeAccesoException            = class(EPACException);
  EPACLCOFueraDeLinea                           = class(EPACException);
  EPACTimbradoRFCNoCorrespondeException         = class(EPACException);
  EPACTimbradoVersionNoSoportadaPorPACException = class(EPACException);
  EPACTimbradoSinFoliosDisponiblesException     = class(EPACException);
  EPACNoEncontradoParaCancelarException         = class(EPACException);
  EPACAcuseNoEncontradoException                = class(EPACException);
  EPACNoExisteSolicitudCancelacionException     = class(EPACException);
  EPACNoSePudoObtenerAcuseException             = class(EPACException);
  {$IFDEF undef}{$REGION 'Documentation'}{$ENDIF}
  ///	<summary>
  ///	  Este error es lanzado cuando la fecha de sellado es mayor a la fecha de la ciudad de mexico, ej. clientes en Cancun
  ///	</summary>
  {$IFDEF undef}{$ENDREGION}{$ENDIF}
  EPACFechaInvalida = class(EPACException);
  {$IFDEF undef}{$REGION 'Documentation'}{$ENDIF}
  ///	<summary>
  ///	  Este tipo de excepcion se lanza cuando se detecta una falla con el
  ///	  internet del usuario el cual es un problema de comunicación con el PAC.
  ///	</summary>
  {$IFDEF undef}{$ENDREGION}{$ENDIF}
  EPACProblemaConInternetException = class(EPACException);

  EPACProblemaTimeoutException = class(EPACException);

  {$IFDEF undef}{$REGION 'Documentation'}{$ENDIF}
  ///	<summary>
  ///	  Excepcion general para errores no programados/manejados.
  ///	</summary>
  ///	<remarks>
  ///	  <note type="important">
  ///	    Por defecto se establece que esta excepcion es "re-intentable" para
  ///	    indicarle al cliente que debe de re-intentar realizar el ultimo proceso
  ///	  </note>
  ///	</remarks>
  {$IFDEF undef}{$ENDREGION}{$ENDIF}
  EPACErrorGenericoException = class(EPACException);

  EPACDocumentoNoEncontradoException = class(EPACException);
  EPACCancelacionFallidaCertificadoNoCargadoException = class(EPACErrorGenericoException);
  EPACCancelacionFallidaDocumentoNoEncontradoException = class(EPACErrorGenericoException);

  EPACCorreoUsadoPreviamenteException = class(EPACErrorGenericoException);
  EPACEmisorYaExistenteException  = class(EPACErrorGenericoException);
  EPACTimbradoPreviamenteException = class(EPACErrorGenericoException);

  IProveedorAutorizadoCertificacion = interface
    ['{BB3456F4-277A-46B7-B2BC-A430E35130E8}']
    procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
    function Parametros: TStrings;
    function CancelarDocumento(const aUUID: TCadenaUTF8): Boolean;
    function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID;
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal;
                              const aTransaccion: Int64) : TCadenaUTF8; overload;
    function TimbrarDocumento(const aXML : TCadenaUTF8; const aTransaccion : Int64): TCadenaUTF8; overload;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
    function ObtenerAcuseDeCancelacion(const aUUID: string): string;
    function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string;
    function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8;
  end;

implementation

constructor EPACException.Create(const aMensajeExcepcion: String; const
    aCodigoErrorSAT: Integer; const aCodigoErrorPAC : Integer; const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion, aReintentable);
  fCodigoErrorSAT := aCodigoErrorSAT;
  fCodigoErrorPAC := aCodigoErrorPAC;
end;

{$IF CompilerVersion < 20}
{ TUUIDInfoListItem }

constructor TUUIDInfoListItem.Create(aUUID: String; aEncontrado,
  aCancelado: Boolean; aExtraInfo: string; aUUIDList: TUUIDInfoList);
begin
 Inherited Create;
 fUUID := aUUID;
 fEncontrado := aEncontrado;
 fCancelado := aCancelado;
 fExtraInfo := aExtraInfo;
 fUUIDList := aUUIDList;
end;

{ TUUIDInfoList }

function TUUIDInfoList.Add(aUUID: String; aEncontrado,
  aCancelado: Boolean; aExtraInfo: string=''): TUUIDInfoListItem;
begin
 result := TUUIDInfoListItem.Create(aUUID, aEncontrado, aCancelado, aExtraInfo, self);
 AddObject(aUUID, result);
end;

function TUUIDInfoList.Add(aUUID: String; aCancelado: Boolean;
  aExtraInfo: string): TUUIDInfoListItem;
begin
 result := Add(aUUID, True, aCancelado, aExtraInfo);
end;

function TUUIDInfoList.AddCancelado(aUUID: String; aExtraInfo: string): TUUIDInfoListItem;
begin
 result := Add(aUUID, True, True, aExtraInfo);
end;


procedure TUUIDInfoList.Clear;
begin
  FreeItems;
  inherited;
end;

procedure TUUIDInfoList.Delete(Index: Integer);
var LObj: TObject;
begin
  LObj := GetObject(Index);
  if Assigned(LObj) then
      FreeAndNil(LObj);
  inherited Delete(index);
end;

destructor TUUIDInfoList.Destroy;
begin
  FreeItems;
  inherited;
end;

procedure TUUIDInfoList.FreeItems;
var LObj: TObject;
     LIdx: Integer;
begin
  for LIdx := 0 to count-1 do
  begin
   LObj := Objects[LIdx];
   if Assigned(LObj) then
      FreeAndNil(LObj);
  end;
end;

function TUUIDInfoList.GetCancelado(const UUID: string): Boolean;
begin
 result := GetItems( UUID ).Cancelado;
end;

function TUUIDInfoList.GetItems(const UUID: string): TUUIDInfoListItem;
var LIndex: Integer;
begin
 result := nil;
 result := TUUIDInfoListItem( Objects[ IndexOf( UUID ) ] );
end;

procedure TUUIDInfoList.SetCancelado(const UUID: string;
  const Value: Boolean);
begin
 GetItems(UUID).Cancelado := Value;
end;

procedure TUUIDInfoList.SetItems(const UUID: string;
  const Value: TUUIDInfoListItem);
begin
 Objects[ IndexOf(UUID) ] := Value;
end;
{$IFEND}

end.
