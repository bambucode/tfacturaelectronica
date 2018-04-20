{ ******************************************************* }
{                                                         }
{ TFacturaElectronica                                     }
{                                                         }
{ Soporte del PAC Solución Factible                       }
{                                                         }
{ ******************************************************* }

unit Facturacion.PAC.SolucionFactible;

interface

uses Facturacion.ProveedorAutorizadoCertificacion,
     Facturacion.Comprobante,
     SolucionFactibleWsTimbrado,
{$IF CompilerVersion >= 23}
   System.Types,
   System.SysUtils
{$ELSE}
   Types,
   SysUtils
{$IFEND}
 ;

type

   TProveedorSolucionFactible = class(TInterfacedObject, IProveedorAutorizadoCertificacion)
   private
      fwsTimbradoSolucionFactible: TimbradoPortType;
      fDominioWebService: string;
      fCredencialesPAC: TFacturacionCredencialesPAC;
      function ExtraerNodoTimbre(const aComprobanteXML: RawByteString) : TCadenaUTF8;
      procedure ProcesarExcepcionDePAC(const aExcepcion: Exception);
      function UTF8Bytes(const s: UTF8String): TBytedynArray; // sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
   public
      procedure  Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
      function TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8; overload;
      function TimbrarDocumento(const aXML : TCadenaUTF8; const aTransaccion : Int64): TCadenaUTF8; overload;
      function ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
           function CancelarDocumento(const aUUID: TCadenaUTF8): Boolean;
    function CancelarDocumentos(const aUUID: TListadoUUID): TListadoCancelacionUUID;
    function ObtenerAcuseDeCancelacion(const aUUID: string): string;
    function AgregarCliente(const aRFC, aRazonSocial, aCorreo: String): string;
    function ObtenerTimbrePrevio(const aIdTransaccionOriginal: Int64): TCadenaUTF8;
   end;

implementation

uses
   Facturacion.Tipos,
{$IF Compilerversion >= 23}
     System.Classes,
     System.RegularExpressions,
     Xml.xmldom,
     Xml.XMLIntf,
     Xml.Win.Msxmldom,
     Xml.XMLDoc
{$ELSE}
     Classes,
     RegularExpressions,
     xmldom,
     XMLIntf,
     Msxmldom,
     XMLDoc
{$IFEND}
  ;

{ TProveedorSolucionFactible }

function TProveedorSolucionFactible.AgregarCliente(const aRFC, aRazonSocial,
  aCorreo: String): string;
begin

end;

function TProveedorSolucionFactible.CancelarDocumento(
  const aUUID: TCadenaUTF8): Boolean;
begin

end;

function TProveedorSolucionFactible.CancelarDocumentos(
  const aUUID: TListadoUUID): TListadoCancelacionUUID;
begin

end;

procedure TProveedorSolucionFactible.Configurar(const aWsTimbrado, aWsClientes, aWsCancelacion: string;
                         const aCredencialesPAC, aCredencialesIntegrador : TFacturacionCredencialesPAC;
                         const aTransaccionInicial: Int64);
begin
   fDominioWebService := aWsTimbrado;
   fCredencialesPAC := aCredencialesPAC;
   // Incializamos las instancias de los WebServices
   fwsTimbradoSolucionFactible := GetTimbradoPortType(False,
     fDominioWebService);
end;

// sacada de http://stackoverflow.com/questions/5233480/string-to-byte-array-in-utf-8
function TProveedorSolucionFactible.UTF8Bytes(const s: UTF8String): TBytedynArray;
begin
   {$IF Compilerversion >= 20}
   Assert(StringElementSize(s) = 1)
   {$IFEND};
   SetLength(Result, Length(s));
   if Length(Result) > 0 then
      Move(s[1], Result[0], Length(s));
end;

function TProveedorSolucionFactible.TimbrarDocumento(const aComprobante: IComprobanteFiscal; const aTransaccion: Int64): TCadenaUTF8;
var
   respuestaTimbrado: CFDICertificacion;
   sXML: TBytedynArray;
   sXMLStr: RawByteString;
begin
   sXML := UTF8Bytes(aComprobante.Xml);
   respuestaTimbrado := fwsTimbradoSolucionFactible.timbrar(fCredencialesPAC.RFC, fCredencialesPAC.Clave, sXML, False);

   if respuestaTimbrado.status = 200 then
      Begin
         if respuestaTimbrado.resultados[0].status = 200 then
            Begin
               sXMLStr := TEncoding.UTF8.GetString( TBytes(respuestaTimbrado.resultados[0].cfdiTimbrado) );
               Result := ExtraerNodoTimbre(sXMLStr)
            End
         else
            raise Exception.Create('Falla Validación CFDI Error No.' + IntToStr(respuestaTimbrado.resultados[0].status) + ' / Detalle: ' +respuestaTimbrado.resultados[0].mensaje);
      end
   Else
      Begin
         raise Exception.Create('Falla Timbrado Error No.' + IntToStr(respuestaTimbrado.status) + ' / Detalle: ' + respuestaTimbrado.mensaje);
      end;
end;

function TProveedorSolucionFactible.ObtenerAcuseDeCancelacion(
  const aUUID: string): string;
begin

end;

function TProveedorSolucionFactible.ObtenerSaldoTimbresDeCliente(const aRFC: String): Integer;
begin
   {No existe esta funcionalidad para Solucion Factible, dejada solo por compatibilidad.}
end;

function TProveedorSolucionFactible.ObtenerTimbrePrevio(
  const aIdTransaccionOriginal: Int64): TCadenaUTF8;
begin

end;

function TProveedorSolucionFactible.ExtraerNodoTimbre(const aComprobanteXML: RawByteString): TCadenaUTF8;
var
   contenidoComprobanteXML: TCadenaUTF8;
begin
   Assert(aComprobanteXML <> '', 'La respuesta del servicio de timbrado fue nula');
   {$IF Compilerversion >= 20}
   // Delphi 2010 y superiores
   contenidoComprobanteXML := aComprobanteXML;
   {$ELSE}
   contenidoComprobanteXML := UTF8Encode(aComprobanteXML);
   {$IFEND}
   Result := TRegEx.Match(contenidoComprobanteXML, '<tfd:TimbreFiscalDigital.*?/>').Value;
   Assert(Result <> '', 'El XML del timbre estuvo vacio');
end;

procedure TProveedorSolucionFactible.ProcesarExcepcionDePAC(const aExcepcion: Exception);
var
   mensajeExcepcion: string;
   numeroErrorSAT: Integer;
begin
   mensajeExcepcion := aExcepcion.Message;
   raise EPACErrorGenericoException.Create(mensajeExcepcion, 0, 0, True);
end;

function TProveedorSolucionFactible.TimbrarDocumento(const aXML: TCadenaUTF8;
  const aTransaccion: Int64): TCadenaUTF8;
begin

end;

end.
