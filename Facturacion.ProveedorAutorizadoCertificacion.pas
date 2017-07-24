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
     SysUtils;

type

  EPACNoConfiguradoException = class(Exception);

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  <para>
  ///	    Excepcion heredable que tiene la propiedad Reintentable para saber si
  ///	    dicha falla es temporal y el programa cliente debe de re-intentar la
  ///	    última petición.
  ///	  </para>
  ///	  <para>
  ///	    Si su valor es Falso es debido a que la falla está del lado del cliente
  ///	    y el PAC no puede procesar dicha petición (XML incorrecto, Sello mal
  ///	    generado, etc.)
  ///	  </para>
  ///	</summary>
  {$ENDREGION}
  EPACException = class(Exception)
  private
    fCodigoErrorSAT: Integer;
    fCodigoErrorPAC: Integer;
    fReintentable : Boolean;
  public
    constructor Create(const aMensajeExcepcion: String; const aCodigoErrorSAT:
        Integer; const aCodigoErrorPAC: Integer; const aReintentable: Boolean);
    property CodigoErrorSAT: Integer read fCodigoErrorSAT;
    property CodigoErrrorPAC: Integer read fCodigoErrorPAC;
    property Reintentable : Boolean read fReintentable;
  end;

  EPACServicioNoDisponibleException = class(EPACException);
  EPACCredencialesIncorrectasException = class(EPACException);
  EPACEmisorNoInscritoException = class(EPACException);
  EPACErrorGenericoDeAccesoException = class(EPACException);
  EPACTimbradoRFCNoCorrespondeException = class(EPACException);
  EPACTimbradoVersionNoSoportadaPorPACException = class(EPACException);
  EPACTimbradoSinFoliosDisponiblesException = class(EPACException);
  EPACCAnceladoSinCertificadosException = class(EPACException);
  EPACNoSePudoObtenerAcuseException = class(EPACException);
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Este tipo de excepcion se lanza cuando se detecta una falla con el
  ///	  internet del usuario el cual es un problema de comunicación con el PAC.
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
  ///	    Por defecto se establece que esta excepción es "re-intentable" para
  ///	    indicarle al cliente que debe de re-intentar realizar el ultimo proceso
  ///	  </note>
  ///	</remarks>
  {$ENDREGION}
  EPACErrorGenericoException = class(EPACException);

  IProveedorAutorizadoCertificacion = interface
    ['{BB3456F4-277A-46B7-B2BC-A430E35130E8}']
    procedure Configurar(const aDominioWebService: string;
                         const aCredencialesPAC: TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal;
                              const aTransaccion: Int64) : TCadenaUTF8;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
  end;

implementation

constructor EPACException.Create(const aMensajeExcepcion: String; const
    aCodigoErrorSAT: Integer; const aCodigoErrorPAC : Integer; const aReintentable: Boolean);
begin
  inherited Create(aMensajeExcepcion);
  fReintentable := aReintentable;
  fCodigoErrorSAT := aCodigoErrorSAT;
  fCodigoErrorPAC := aCodigoErrorPAC;
end;

end.
