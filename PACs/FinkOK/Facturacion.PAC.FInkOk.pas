{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{        Soporte del pac FinkOK TecsisNet.net           }
{                                                       }
{*******************************************************}

unit Facturacion.PAC.FInkOk;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     Facturacion.Tipos,
     Types,
     FinkOkWsTimbrado,
     SysUtils;

type

  TProveedorFinkOk = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
  private
    fwsTimbradoFinkOk: IFinkOkServicioTimbrado;
    fDominioWebService : string;
    fCredencialesPAC :  TFacturacionCredencialesPAC;
    function ExtraerNodoTimbre(const aComprobanteXML : TCadenaUTF8): TCadenaUTF8;
    procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
    function UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
  public
    procedure Configurar(const aDominioWebService: string; const aCredencialesPAC:
        TFacturacionCredencialesPAC; const aTransaccionInicial: Int64);
    function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const
        aTransaccion: Int64): TCadenaUTF8;
    function ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
  end;

implementation

uses Classes,
     xmldom,
     XMLIntf,
     {$IFDEF CODESITE}
     CodeSiteLogging,
     {$ENDIF}
     {$IF Compilerversion >= 20}
      System.RegularExpressions,
      Xml.Win.Msxmldom,
     {$ELSE}
       PerlRegEx,
       msxmldom,
     {$IFEND}
     XMLDoc;

{ TProveedorFinkOk }

procedure TProveedorFinkOk.Configurar(const aDominioWebService: string; const
    aCredencialesPAC: TFacturacionCredencialesPAC; const aTransaccionInicial:
    Int64);
begin
  fDominioWebService := aDominioWebService;
  fCredencialesPAC := aCredencialesPAC;
  // Incializamos las instancias de los WebServices
  fwsTimbradoFinkOk := GetWsFinkOkTimbrado(False, fDominioWebService + '/stamp');
end;

function TProveedorFinkOk.UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
begin
{$IF Compilerversion >= 20}Assert(StringElementSize(s)=1){$IFEND};
  SetLength(Result, Length(s));
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
end;

function TProveedorFinkOk.TimbrarDocumento(const aComprobante:
    IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
  respuestaTimbrado: TFinkOkRespuestaTimbrado;
  sXML:TByteDynArray;
begin
  sXML := UTF8Bytes(UTF8Encode(aComprobante.XML));
  respuestaTimbrado := fwsTimbradoFinkOk.stamp(sXML,fCredencialesPAC.RFC,fCredencialesPAC.Clave);
  if Trim(respuestaTimbrado.CodEstatus) <> '' then
    Result := ExtraerNodoTimbre(respuestaTimbrado.xml);
  if Trim(respuestaTimbrado.CodEstatus) = '' then
   begin
   {$IFDEF CODESITE}
    CodeSite.Send('Falla Validacion Error No.', respuestaTimbrado.Incidencias[0].CodigoError+'/Detalle :'+respuestaTimbrado.Incidencias[0].MensajeIncidencia);
   {$ELSE}
    raise exception.Create('Falla Validacion Error No.'+ respuestaTimbrado.Incidencias[0].CodigoError+'/Detalle :'+respuestaTimbrado.Incidencias[0].MensajeIncidencia);
   {$ENDIF}
   end;
end;

function TProveedorFinkOk.ObtenerSaldoTimbresDeCliente(const aRFC: String) : Integer;
begin
end;

function TProveedorFinkOk.ExtraerNodoTimbre(const aComprobanteXML : TCadenaUTF8): TCadenaUTF8;
var
  contenidoComprobanteXML: TCadenaUTF8;
 {$IF Compilerversion < 20}
  TRegex : TPerlRegex;
 {$ifend} 
const
  _REGEX_TIMBRE = '<tfd:TimbreFiscalDigital.*?/>';
begin
  Assert(aComprobanteXML <> '', 'La respuesta del servicio de timbrado fue nula');
  {$IF Compilerversion >= 20}
  // Delphi 2010 y superiores
   contenidoComprobanteXML := aComprobanteXML;
   Result := TRegEx.Match(contenidoComprobanteXML,_REGEX_TIMBRE).Value;
  {$ELSE}
   TRegex := TPerlRegex.Create(nil);
   Try
     TRegex.Subject:=UTF8String(aComprobanteXML);
     TRegex.RegEx:=_REGEX_TIMBRE;
     if TRegex.Match then
      Result:=TRegex.MatchedExpression; 
    Except
       on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    End;
  {$IFEND}
  Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

procedure TProveedorFinkOk.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
  mensajeExcepcion : string;
  numeroErrorSAT: Integer;
begin
  mensajeExcepcion := aExcepcion.Message;
     // Si llegamos aqui y no se ha lanzado ningun otro error lanzamos el error genérico de PAC
     // con la propiedad reintentable en verdadero para que el cliente pueda re-intentar el proceso anterior
     raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
//  end;
end;

end.
