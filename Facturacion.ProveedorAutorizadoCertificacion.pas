{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}
unit Facturacion.ProveedorAutorizadoCertificacion;

interface

uses Facturacion.Comprobante,
     System.Generics.Collections,
     Facturacion.Tipos,
     System.SysUtils;

type

  TListadoUUID = Array of string;
  // NOTA: Aqui se deberá cambiar el TDictionary por otro codigo para versiones de
  // Delphi anteriores
  TListadoCancelacionUUID = TDictionary<String, Boolean>;

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
  EPACCAnceladoSinCertificadosException         = class(EPACException);
  EPACNoEncontradoParaCancelarException         = class(EPACException);
  EPACAcuseNoEncontradoException                = class(EPACException);
  EPACNoSePudoObtenerAcuseException             = class(EPACException);
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Este error es lanzado cuando la fecha de sellado es mayor a la fecha de la ciudad de mexico, ej. clientes en Cancun
  ///	</summary>
  {$ENDREGION}
  EPACFechaInvalida = class(EPACException);
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Este tipo de excepcion se lanza cuando se detecta una falla con el
  ///	  internet del usuario el cual es un problema de comunicaci�n con el PAC.
  ///	</summary>
  {$ENDREGION}
  EPACProblemaConInternetException = class(EPACException);

  EPACProblemaTimeoutException = class(EPACException);

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Excepcion general para errores no programados/manejados.
  ///	</summary>
  ///	<remarks>
  ///	  <note type="important">
  ///	    Por defecto se establece que esta excepcion es "re-intentable" para
  ///	    indicarle al cliente que debe de re-intentar realizar el ultimo proceso
  ///	  </note>
  ///	</remarks>
  {$ENDREGION}
  EPACErrorGenericoException = class(EPACException);

  EPACDocumentoNoEncontradoException = class(EPACException);
  EPACCancelacionFallidaCertificadoNoCargadoException = class(EPACErrorGenericoException);
  PACCancelacionFallidaDocumentoNoEncontradoException = class(EPACErrorGenericoException);

  EPACCorreoUsadoPreviamenteException = class(EPACErrorGenericoException);
  EPACEmisorYaExistenteException  = class(EPACErrorGenericoException);
  EPACTimbradoPreviamenteException = class(EPACErrorGenericoException);

  IProveedorAutorizadoCertificacion = interface
    ['{BB3456F4-277A-46B7-B2BC-A430E35130E8}']
    procedure Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
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

end.
