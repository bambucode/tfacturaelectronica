unit FinkOkWsComun;

interface
uses SysUtils,
     Facturacion.ProveedorAutorizadoCertificacion;
   function CodEstatus(Codigo:string):Boolean;

implementation

function CodEstatus(Codigo:string):Boolean;
var iCodigo : Integer;
 Begin
  Result:=False;
  try
   iCodigo:=StrToInt(Codigo);
   if Codigo='203' then raise EPACNoEncontradoParaCancelarException.Create('No corresponde el RFC del Emisor y de quien solicita la cancelaci�n',-1,iCodigo,False)
   else if Codigo='204' then raise EPACNoEncontradoParaCancelarException.Create('UUID No encontrado',-1,iCodigo,False)
   else if Codigo='300' then raise EPACNoEncontradoParaCancelarException.Create('Usuario No V�lido	300',-1,iCodigo,False)

   else if Codigo='301' then raise EPACNoEncontradoParaCancelarException.Create('XML Mal Formado',-1,iCodigo,False)
   else if Codigo='302' then raise EPACNoEncontradoParaCancelarException.Create('Sello Mal Formado o inv�lido',-1,iCodigo,False)
   else if Codigo='303' then raise EPACNoEncontradoParaCancelarException.Create('Sello no corresponde a emisor',-1,iCodigo,False)
   else if Codigo='304' then raise EPACNoEncontradoParaCancelarException.Create('Certificado Revocado o Caduco',-1,iCodigo,False)
   else if Codigo='305' then raise EPACNoEncontradoParaCancelarException.Create('Certificado Inv�lido ,La fecha de emisi�n no esta dentro de la vigencia del CSD del Emisor',-1,iCodigo,False)
   else if Codigo='306' then raise EPACNoEncontradoParaCancelarException.Create('El certificado no es de tipo CSD',-1,iCodigo,False)

   else if Codigo='307' then raise EPACNoEncontradoParaCancelarException.Create('Comprobante timbrado previamente',-1,iCodigo,False)
   else if Codigo='308' then raise EPACNoEncontradoParaCancelarException.Create('Certificado no expedido por el SAT',-1,iCodigo,False)

   else if Codigo='309' then raise EPACNoEncontradoParaCancelarException.Create('Patr�n de Folio inv�lido',-1,iCodigo,False)

   else if Codigo='401' then raise EPACNoEncontradoParaCancelarException.Create('Fecha y hora de generaci�n fuera de rango',-1,iCodigo,False)

   else if Codigo='402' then raise EPACNoEncontradoParaCancelarException.Create('RFC del emisor no se encuentra en el r�gimen de contribuyentes',-1,iCodigo,False)
   else if Codigo='403' then raise EPACNoEncontradoParaCancelarException.Create('La fecha de emisi�n no es posterior al 01 de enero de 2012',-1,iCodigo,False)

   else if Codigo='501' then raise EPACNoEncontradoParaCancelarException.Create('Autenticaci�n no v�lida',-1,iCodigo,False)

   else if Codigo='603' then raise EPACNoEncontradoParaCancelarException.Create('El CFDI no contiene un timbre previo (m�todo stamped)',-1,iCodigo,False)
   else if Codigo='702' then raise EPACNoEncontradoParaCancelarException.Create('No ha registrado el RFC emisor bajo la cuenta de el PAC',-1,iCodigo,False)
   else if Codigo='703' then raise EPACNoEncontradoParaCancelarException.Create('Cuenta suspendida',-1,iCodigo,False)
   else if Codigo='704' then raise EPACNoEncontradoParaCancelarException.Create('Error con la contrase�a de la llave Privada',-1,iCodigo,False)
   else if Codigo='705' then raise EPACNoEncontradoParaCancelarException.Create('XML estructura inv�lida',-1,iCodigo,False)
   else if Codigo='706' then raise EPACNoEncontradoParaCancelarException.Create('Socio Inv�lido',-1,iCodigo,False)
   else if Codigo='707' then raise EPACNoEncontradoParaCancelarException.Create('XML ya contiene un nodo TimbreFiscalDigital',-1,iCodigo,False)
   else if Codigo='708' then raise EPACNoEncontradoParaCancelarException.Create('No se pudo conectar al SAT',-1,iCodigo,False)
   else if Codigo='711' then raise EPACNoEncontradoParaCancelarException.Create('Error con el certificado al cancelar',-1,iCodigo,False)
   else if Codigo='712' then raise EPACNoEncontradoParaCancelarException.Create('El numero de ''noCertificado'' es diferente al del numero de certificado del atributo ''certificado''',-1,iCodigo,False)

   else if Codigo='715' then raise EPACNoEncontradoParaCancelarException.Create('Error al crear XML de consulta Sector Primario',-1,iCodigo,False)

   else if Codigo='716' then raise EPACNoEncontradoParaCancelarException.Create('Firma Inv�lida - Consulta Sector Primario',-1,iCodigo,False)
   else if Codigo='717' then raise EPACNoEncontradoParaCancelarException.Create('Error al generar la firma del XML',-1,iCodigo,False)

   else if Codigo='1000' then raise EPACNoEncontradoParaCancelarException.Create('Se recibi� la respuesta de la petici�n de forma exitosa',-1,iCodigo,False)

   else if Codigo='1001' then raise EPACNoEncontradoParaCancelarException.Create('No existen peticiones de cancelaci�n en espera de respuesta para el uuid',-1,iCodigo,False)
   else if Codigo='1002' then raise EPACNoEncontradoParaCancelarException.Create('Ya se recibi� una respuesta para la petici�n de cancelaci�n del uuid',-1,iCodigo,False)
   else if Codigo='1003' then raise EPACNoEncontradoParaCancelarException.Create('Sello No Corresponde al RFC Receptor',-1,iCodigo,False)
   else if Codigo='1004' then raise EPACNoEncontradoParaCancelarException.Create('Existen m�s de una petici�n de cancelaci�n para el mismo uuid',-1,iCodigo,False)
   else if Codigo='1005' then raise EPACNoEncontradoParaCancelarException.Create('El uuid es nulo no posee el formato correcto',-1,iCodigo,False)
   else if Codigo='1006' then raise EPACNoEncontradoParaCancelarException.Create('Se rebaso el n�mero m�ximo de solicitudes permitidas',-1,iCodigo,False)

   else if Codigo='1201' then raise EPACNoEncontradoParaCancelarException.Create('UUID Cancelado',-1,iCodigo,False)

   else if Codigo='1202' then raise EPACNoEncontradoParaCancelarException.Create('UUID Previamente cancelado',-1,iCodigo,False)
   else if Codigo='1203' then raise EPACNoEncontradoParaCancelarException.Create('UUID a cancelar no corresponde con el emisor',-1,iCodigo,False)
   else if Codigo='1205' then raise EPACNoEncontradoParaCancelarException.Create('UUID No existe',-1,iCodigo,False)
   else if Codigo='1302' then raise EPACNoEncontradoParaCancelarException.Create('Estructura de folios no v�lida',-1,iCodigo,False)
   else if Codigo='1305' then raise EPACNoEncontradoParaCancelarException.Create('Certificado no corresponde al emisor',-1,iCodigo,False)
   else if Codigo='1306' then raise EPACNoEncontradoParaCancelarException.Create('Certificado no vigente',-1,iCodigo,False)
   else if Codigo='1307' then raise EPACNoEncontradoParaCancelarException.Create('El certificado no es de tipo CSD',-1,iCodigo,False)
   else if Codigo='1308' then raise EPACNoEncontradoParaCancelarException.Create('Certificado revocado o caduco',-1,iCodigo,False)
   else if Codigo='no_cancelable' then
    Begin
     Result:=False;
     raise EPACNoEncontradoParaCancelarException.Create('El UUID contiene CFDI relacionados',-1,-1,False);
    End;
   if  Codigo='202' then raise EPACNoEncontradoParaCancelarException.Create('Petici�n de cancelaci�n realizada Previamente',-1,iCodigo,False);
  Except
   raise EPACNoEncontradoParaCancelarException.Create(Codigo,-1,-1,False);
  end;
end;


end.
