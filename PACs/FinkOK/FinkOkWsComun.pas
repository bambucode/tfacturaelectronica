unit FinkOkWsComun;

interface
uses SysUtils,
     Facturacion.ProveedorAutorizadoCertificacion;
   function CodEstatus(Codigo:string):Boolean;

implementation

  function RaisePACCodEstatusNumerico( Codigo: string ): Boolean;
 var iCodigo: Integer;
 begin
    iCodigo:=StrToIntDef(Codigo,0);
    result := true;
    if ICodigo = 0 then
     begin
      result := false;
      exit;
     end
     else if Codigo='203' then raise EPACNoEncontradoParaCancelarException.Create('No corresponde el RFC del Emisor y de quien solicita la cancelaci�n',-1,iCodigo,False)
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
     else if Codigo='701' then raise EPACNoEncontradoParaCancelarException.Create('Cliente o RFC emisor suspendido',-1,iCodigo,False)
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
    End
   else raise EPACNoEncontradoParaCancelarException.Create(Codigo,-1,-1,False);
   if  Codigo='202' then raise EPACNoEncontradoParaCancelarException.Create('Petici�n de cancelaci�n realizada Previamente',-1,iCodigo,False);
  end;

  function RaisePACCodEstatusAlfaCFDI( Codigo: string ): boolean;
  begin
   result := true;
   if Codigo='CFDI33101' then raise EPACNoEncontradoParaCancelarException.Create('"El campo Fecha no cumple con el patr�n requerido."',-1,-1,False)
   else if Codigo='CFDI33102' then raise EPACNoEncontradoParaCancelarException.Create('El resultado de la digesti�n debe ser igual al resultado de la desencripci�n del sello.',-1,-1,False)
   else if Codigo='CFDI33103' then raise EPACNoEncontradoParaCancelarException.Create('Si existe el complemento para recepci�n de pagos el campo FormaPago no debe existir.',-1,-1,False)
   else if Codigo='CFDI33104' then raise EPACNoEncontradoParaCancelarException.Create('El campo FormaPago no contiene un valor del cat�logo c_FormaPago.',-1,-1,False)
   else if Codigo='CFDI33105' then raise EPACNoEncontradoParaCancelarException.Create('EL certificado no cumple con alguno de los valores permitidos.',-1,-1,False)
   else if Codigo='CFDI33106' then raise EPACNoEncontradoParaCancelarException.Create('El valor de este campo SubTotal excede la cantidad de decimales que soporta la moneda.',-1,-1,False)
   else if Codigo='CFDI33107' then raise EPACNoEncontradoParaCancelarException.Create('El TipoDeComprobante es I,E o N, el importe registrado en el campo no es igual a la suma de los importes de los conceptos registrados.',-1,-1,False)
   else if Codigo='CFDI33108' then raise EPACNoEncontradoParaCancelarException.Create('El TipoDeComprobante es T o P y el importe no es igual a 0, o cero con decimales.',-1,-1,False)
   else if Codigo='CFDI33109' then raise EPACNoEncontradoParaCancelarException.Create('El valor registrado en el campo Descuento no es menor o igual que el campo Subtotal.',-1,-1,False)
   else if Codigo='CFDI33110' then raise EPACNoEncontradoParaCancelarException.Create('El TipoDeComprobante no es I,E o N, y un concepto incluye el campo descuento.',-1,-1,False)
   else if Codigo='CFDI33111' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Descuento excede la cantidad de decimales que soporta la moneda.',-1,-1,False)
   else if Codigo='CFDI33112' then raise EPACNoEncontradoParaCancelarException.Create('El campo Moneda no contiene un valor del cat�logo c_Moneda.',-1,-1,False)
   else if Codigo='CFDI33113' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoCambio no tiene el valor "1" y la moneda indicada es MXN.',-1,-1,False)
   else if Codigo='CFDI33114' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoCambio se debe registrar cuando el campo Moneda tiene un valor distinto de MXN y XXX.',-1,-1,False)
   else if Codigo='CFDI33115' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoCambio no se debe registrar cuando el campo Moneda tiene el valor XXX.',-1,-1,False)
   else if Codigo='CFDI33116' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoCambio no cumple con el patr�n requerido.',-1,-1,False)
   else if Codigo='CFDI33117' then raise EPACNoEncontradoParaCancelarException.Create('Cuando el valor del campo TipoCambio se encuentre fuera de los l�mites establecidos, debe existir el campo Confirmacion.',-1,-1,False)
   else if Codigo='CFDI33118' then raise EPACNoEncontradoParaCancelarException.Create('El campo Total no corresponde con la suma del subtotal, menos los descuentos aplicables, m�s las contribuciones recibidas'+' (impuestos trasladados - federales o locales, derechos, productos, aprovechamientos, aportaciones de seguridad social, contribuciones de mejoras) menos los impuestos retenidos.',-1,-1,False)
   else if Codigo='CFDI33119' then raise EPACNoEncontradoParaCancelarException.Create('Cuando el valor del campo Total se encuentre fuera de los l�mites establecidos, debe existir el campo Confirmacion.',-1,-1,False)
   else if Codigo='CFDI33120' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoDeComprobante, no contiene un valor del cat�logo c_TipoDeComprobante.',-1,-1,False)
   else if Codigo='CFDI33121' then raise EPACNoEncontradoParaCancelarException.Create('El campo MetodoPago, no contiene un valor del cat�logo c_MetodoPago.',-1,-1,False)
   else if Codigo='CFDI33122' then raise EPACNoEncontradoParaCancelarException.Create('Cuando se tiene el valor PIP en el campo MetodoPago y el valor en el campo TipoDeComprobante es I � E, el CFDI debe contener un complemento de recibo de pago.',-1,-1,False)
   else if Codigo='CFDI33123' then raise EPACNoEncontradoParaCancelarException.Create('Se debe omitir el campo MetodoPago cuando el TipoDeComprobante es T o P.',-1,-1,False)
   else if Codigo='CFDI33124' then raise EPACNoEncontradoParaCancelarException.Create('Si existe el complemento para recepci�n de pagos en este CFDI el campo MetodoPago no debe existir.',-1,-1,False)
   else if Codigo='CFDI33125' then raise EPACNoEncontradoParaCancelarException.Create('El campo LugarExpedicion, no contiene un valor del cat�logo c_CodigoPostal.',-1,-1,False)
   else if Codigo='CFDI33126' then raise EPACNoEncontradoParaCancelarException.Create('El campo Confirmacion no debe existir cuando los atributos TipoCambio y/o Total est�n dentro del rango permitido.',-1,-1,False)
   else if Codigo='CFDI33127' then raise EPACNoEncontradoParaCancelarException.Create('N�mero de confirmaci�n inv�lido.',-1,-1,False)
   else if Codigo='CFDI33128' then raise EPACNoEncontradoParaCancelarException.Create('N�mero de confirmaci�n utilizado previamente.',-1,-1,False)
   else if Codigo='CFDI33129' then raise EPACNoEncontradoParaCancelarException.Create('El campo TipoRelacion, no contiene un valor del cat�logo c_TipoRelacion.',-1,-1,False)
   else if Codigo='CFDI33130' then raise EPACNoEncontradoParaCancelarException.Create('El campo RegimenFiscal, no contiene un valor del cat�logo c_RegimenFiscal.',-1,-1,False)
   else if Codigo='CFDI33131' then raise EPACNoEncontradoParaCancelarException.Create('La clave del campo RegimenFiscal debe corresponder con el tipo de persona (fisica o moral).',-1,-1,False)
   else if Codigo='CFDI33132' then raise EPACNoEncontradoParaCancelarException.Create('Este RFC del receptor no existe en la lista de RFC inscritos no cancelados del SAT.',-1,-1,False)
   else if Codigo='CFDI33133' then raise EPACNoEncontradoParaCancelarException.Create('El campo ResidenciaFiscal, no contiene un valor del cat�logo c_Pais.',-1,-1,False)
   else if Codigo='CFDI33134' then raise EPACNoEncontradoParaCancelarException.Create('El RFC del receptor es de un RFC registrado en el SAT o un RFC gen�rico nacional y existe el campo ResidenciaFiscal.',-1,-1,False)
   else if Codigo='CFDI33135' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo ResidenciaFiscal no puede ser MEX.',-1,-1,False)
   else if Codigo='CFDI33136' then raise EPACNoEncontradoParaCancelarException.Create('Se debe registrar un valor de acuerdo al cat�logo c_Pais en en el campo ResidenciaFiscal, cuando en el en el campo NumRegIdTrib se registre informaci�n.',-1,-1,False)
   else if Codigo='CFDI33137' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo es un RFC inscrito no cancelado en el SAT o un RFC gen�rico nacional, y se registr� el campo NumRegIdTrib.',-1,-1,False)
   else if Codigo='CFDI33138' then raise EPACNoEncontradoParaCancelarException.Create('Para registrar el campo NumRegIdTrib, el CFDI debe contener el complemento de comercio exterior y el RFC del receptor debe ser un RFC gen�rico extranjero.',-1,-1,False)
   else if Codigo='CFDI33139' then raise EPACNoEncontradoParaCancelarException.Create('El campo NumRegIdTrib no cumple con el patr�n correspondiente.',-1,-1,False)
   else if Codigo='CFDI33140' then raise EPACNoEncontradoParaCancelarException.Create('El campo UsoCFDI, no contiene un valor del cat�logo c_UsoCFDI.',-1,-1,False)
   else if Codigo='CFDI33141' then raise EPACNoEncontradoParaCancelarException.Create('La clave del campo UsoCFDI debe corresponder con el tipo de persona (fisica o moral).',-1,-1,False)
   else if Codigo='CFDI33142' then raise EPACNoEncontradoParaCancelarException.Create('El campo ClaveProdServ, no contiene un valor del cat�logo c_ClaveProdServ.',-1,-1,False)
   else if Codigo='CFDI33143' then raise EPACNoEncontradoParaCancelarException.Create('No existe el complemento requerido para el valor de ClaveProdServ.',-1,-1,False)
   else if Codigo='CFDI33144' then raise EPACNoEncontradoParaCancelarException.Create('No est� declarado el impuesto relacionado con el valor de ClaveProdServ.',-1,-1,False)
   else if Codigo='CFDI33145' then raise EPACNoEncontradoParaCancelarException.Create('El campo ClaveUnidad no contiene un valor del cat�logo c_ClaveUnidad.',-1,-1,False)
   else if Codigo='CFDI33147' then raise EPACNoEncontradoParaCancelarException.Create('El valor valor del campo ValorUnitario debe ser mayor que cero (0) cuando el tipo de comprobante es Ingreso, Egreso o Nomina.',-1,-1,False)
   else if Codigo='CFDI33149' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Importe no se encuentra entre el limite inferior y superior permitido.',-1,-1,False)
   else if Codigo='CFDI33150' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Descuento debe tener hasta la cantidad de decimales que tenga registrado el atributo importe del concepto.',-1,-1,False)
   else if Codigo='CFDI33151' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Descuento es mayor que el campo Importe.',-1,-1,False)
   else if Codigo='CFDI33152' then raise EPACNoEncontradoParaCancelarException.Create('En caso de utilizar el nodo Impuestos en un concepto, se deben incluir impuestos  de traslado y/o retenciones.',-1,-1,False)
   else if Codigo='CFDI33154' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Base que corresponde a Traslado debe ser mayor que cero.',-1,-1,False)
   else if Codigo='CFDI33155' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Impuesto que corresponde a Traslado no contiene un valor del cat�logo c_Impuesto.',-1,-1,False)
   else if Codigo='CFDI33156' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TipoFactor que corresponde a Traslado no contiene un valor del cat�logo c_TipoFactor.',-1,-1,False)
   else if Codigo='CFDI33157' then raise EPACNoEncontradoParaCancelarException.Create('Si el valor registrado en el campo TipoFactor que corresponde a Traslado es Exento no se deben registrar los campos TasaOCuota ni Importe.',-1,-1,False)
   else if Codigo='CFDI33158' then raise EPACNoEncontradoParaCancelarException.Create('Si el valor registrado en el campo TipoFactor que corresponde a Traslado es Tasa o Cuota, se deben registrar los campos TasaOCuota e Importe.',-1,-1,False)
   else if Codigo='CFDI33159' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TasaOCuota que corresponde a Traslado no contiene un valor del cat�logo c_TasaOcuota o se encuentra fuera de rango.',-1,-1,False)
   else if Codigo='CFDI33161' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Importe o que corresponde a Traslado no se encuentra entre el limite inferior y superior permitido.',-1,-1,False)
   else if Codigo='CFDI33163' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Base que corresponde a Retenci�n debe ser mayor que cero.',-1,-1,False)
   else if Codigo='CFDI33164' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Impuesto que corresponde a Retenci�n no contiene un valor del cat�logo c_Impuesto.',-1,-1,False)
   else if Codigo='CFDI33165' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TipoFactor que corresponde a Retenci�n no contiene un valor del cat�logo c_TipoFactor.',-1,-1,False)
   else if Codigo='CFDI33166' then raise EPACNoEncontradoParaCancelarException.Create('Si el valor registrado en el campo TipoFactor que corresponde a Retenci�n debe ser distinto de Exento.',-1,-1,False)
   else if Codigo='CFDI33167' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TasaOCuota que corresponde a Retenci�n, no contiene un valor del cat�logo c_TasaOcuota o se encuentra fuera de rango.',-1,-1,False)
   else if Codigo='CFDI33169' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Importe que corresponde a Retenci�n no se encuentra entre el limite inferior y superior permitido.',-1,-1,False)
   else if Codigo='CFDI33170' then raise EPACNoEncontradoParaCancelarException.Create('El n�mero de pedimento es inv�lido.',-1,-1,False)
   else if Codigo='CFDI33171' then raise EPACNoEncontradoParaCancelarException.Create('El NumeroPedimento no debe existir si se incluye el complemento de comercio exterior.',-1,-1,False)
   else if Codigo='CFDI33172' then raise EPACNoEncontradoParaCancelarException.Create('El campo ClaveProdServ, no contiene un valor del cat�logo c_ClaveProdServ.',-1,-1,False)
   else if Codigo='CFDI33176' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo Importe no se encuentra entre el limite inferior y superior permitido.',-1,-1,False)
   else if Codigo='CFDI33177' then raise EPACNoEncontradoParaCancelarException.Create('El n�mero de pedimento es inv�lido.',-1,-1,False)
   else if Codigo='CFDI33178' then raise EPACNoEncontradoParaCancelarException.Create('El NumeroPedimento no debe existir si se incluye el complemento de comercio exterior.',-1,-1,False)
   else if Codigo='CFDI33179' then raise EPACNoEncontradoParaCancelarException.Create('Cuando el TipoDeComprobante sea T o P, el elemento Impuestos no debe existir.',-1,-1,False)
   else if Codigo='CFDI33180' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TotalImpuestosRetenidos debe tener hasta la cantidad de decimales que soporte la moneda.',-1,-1,False)
   else if Codigo='CFDI33181' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TotalImpuestosRetenidos debe ser igual a la suma de los importes registrados en el elemento hijo Retencion.',-1,-1,False)
   else if Codigo='CFDI33182' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TotalImpuestosTrasladados debe tener hasta la cantidad de decimales que soporte la moneda.',-1,-1,False)
   else if Codigo='CFDI33183' then raise EPACNoEncontradoParaCancelarException.Create('El valor del campo TotalImpuestosTrasladados no es igual a la suma de los importes registrados en el elemento hijo Traslado.',-1,-1,False)
   else if Codigo='CFDI33184' then raise EPACNoEncontradoParaCancelarException.Create('Debe existir el campo TotalImpuestosRetenidos.',-1,-1,False)
   else if Codigo='CFDI33185' then raise EPACNoEncontradoParaCancelarException.Create('El campo Impuesto no contiene un valor del cat�logo c_Impuesto.',-1,-1,False)
   else if Codigo='CFDI33186' then raise EPACNoEncontradoParaCancelarException.Create('Debe haber s�lo un registro por cada tipo de impuesto retenido.',-1,-1,False)
   else if Codigo='CFDI33187' then raise EPACNoEncontradoParaCancelarException.Create('Debe existir el campo TotalImpuestosRetenidos.',-1,-1,False)
   else if Codigo='CFDI33189' then raise EPACNoEncontradoParaCancelarException.Create('El campo Importe correspondiente a Retenci�n no es igual a la suma de los importes de los impuestos retenidos registrados en los conceptos donde el impuesto sea igual al campo impuesto de este elemento.',-1,-1,False)
   else if Codigo='CFDI33190' then raise EPACNoEncontradoParaCancelarException.Create('Debe existir el campo TotalImpuestosTrasladados.',-1,-1,False)
   else if Codigo='CFDI33191' then raise EPACNoEncontradoParaCancelarException.Create('El campo Impuesto no contiene un valor del cat�logo c_Impuesto.',-1,-1,False)
   else if Codigo='CFDI33192' then raise EPACNoEncontradoParaCancelarException.Create('Debe haber s�lo un registro con la misma combinaci�n de impuesto, factor y tasa por cada traslado.',-1,-1,False)
   else if Codigo='CFDI33193' then raise EPACNoEncontradoParaCancelarException.Create('El valor seleccionado debe corresponder a un valor del catalogo donde la columna impuesto corresponda con el campo impuesto y la columna factor corresponda con el campo TipoFactor.',-1,-1,False)
   else if Codigo='CFDI33195' then raise EPACNoEncontradoParaCancelarException.Create('El campo Importe correspondiente a Traslado no es igual a la suma de los importes de los impuestos trasladados registrados en los conceptos donde el impuesto del concepto sea igual '+'al campo impuesto de este elemento y la TasaOCuota del concepto sea igual al campo TasaOCuota de este elemento.',-1,-1,False)
   else if Codigo='CFDI40102' then raise EPACNoEncontradoParaCancelarException.Create('El resultado de la digesti�n debe ser igual al resultado de la desencripci�n del sello.',-1,-1,False)
   else result := false;
  end;

  function RaisePACCodEstatusAlfaCCE( Codigo: string ): boolean;
  begin
   result := true;
   if Codigo='CCE101' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante no tiene un valor valido',-1,-1,False)
   else if Codigo='CCE102' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:fecha no cumple con el patr�n requerido.',-1,-1,False)
   else if Codigo='CCE103' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:subtotal no coincide con la suma de los atributos importe de los nodos Concepto.',-1,-1,False)
   else if Codigo='CCE104' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Moneda se debe registrar',-1,-1,False)
   else if Codigo='CCE105' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Moneda no contiene un valor del cat�logo catCFDI:c_Moneda.',-1,-1,False)
   else if Codigo='CCE106' then raise EPACNoEncontradoParaCancelarException.Create('El atributo TipoCambio no tiene el valor "1" y la moneda indicada es MXN.',-1,-1,False)
   else if Codigo='CCE107' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:TipoCambio se debe registrar cuando el atributo cfdi:Comprobante:Moneda tiene un valor distinto de MXN y XXX.',-1,-1,False)
   else if Codigo='CCE108' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:TipoCambio no se debe registrar cuando el atributo cfdi:Comprobante:Moneda tiene el valor XXX.',-1,-1,False)
   else if Codigo='CCE109' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:TipoCambio no cumple con el patr�n requerido.',-1,-1,False)
   else if Codigo='CCE110' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:tipoDeComprobante no cumple con alguno de los valores permitidos.',-1,-1,False)
   else if Codigo='CCE111' then raise EPACNoEncontradoParaCancelarException.Create('El atributo MotivoTraslado debe registrarse cuando cfdi:Comprobante:tipoDeComprobante tiene el valor "traslado".',-1,-1,False)
   else if Codigo='CCE112' then raise EPACNoEncontradoParaCancelarException.Create('El nodo Propietario se debe registrar cuando cfdi:Comprobante:tipoDeComprobante tiene el valor "traslado" y MotivoTraslado tiene la clave "05".',-1,-1,False)
   else if Codigo='CCE113' then raise EPACNoEncontradoParaCancelarException.Create('El atributo MotivoTraslado no debe existir cuando cfdi:Comprobante:tipoDeComprobante es distinto de "traslado".',-1,-1,False)
   else if Codigo='CCE114' then raise EPACNoEncontradoParaCancelarException.Create('El nodo Propietario no debe existir cuando cfdi:Comprobante:tipoDeComprobante es distinto de "traslado" y MotivoTraslado tiene una clave distinta de "05".',-1,-1,False)
   else if Codigo='CCE115' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:total no coincide con la suma del cfdi:Comprobante:subTotal, menos el cfdi:Comprobante:descuento, m�s cfdi:Comprobante:Impuestos:totalImpuestosTrasladados menos cfdi:Comprobante:Impuestos:totalImpuestosRetenidos.',-1,-1,False)
   else if Codigo='CCE116' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:LugarExpedicion no cumple con alguno de los valores permitidos.',-1,-1,False)
   else if Codigo='CCE117' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:Nombre se debe registrar.',-1,-1,False)
   else if Codigo='CCE118' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:pais debe tener el valor "MEX".',-1,-1,False)
   else if Codigo='CCE119' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:pais debe tener el valor "MEX".',-1,-1,False)
   else if Codigo='CCE120' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:estado debe contener una clave del cat�logo catCFDI:c_Estado donde la columna c_Pais tenga el valor "MEX".',-1,-1,False)
   else if Codigo='CCE121' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:estado debe contener una clave del cat�logo catCFDI:c_Estado donde la columna c_Pais tenga el valor "MEX".',-1,-1,False)
   else if Codigo='CCE122' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:municipio debe contener una clave del cat�logo de catCFDI:c_Municipio donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE123' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:municipio debe contener una clave del cat�logo de catCFDI:c_Municipio donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE124' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:localidad debe contener una clave del cat�logo de catCFDI:c_Localidad, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE125' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:localidad debe contener una clave del cat�logo de catCFDI:c_Localidad, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE126' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:colonia debe contener una clave del cat�logo de catCFDI:c_Colonia, donde la columna c_CodigoPostal debe ser igual a la clave registrada en el atributo codigoPostal si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE127' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:colonia debe contener una clave del cat�logo de catCFDI:c_Colonia, donde la columna c_CodigoPostal debe ser igual a la clave registrada en el atributo codigoPostal si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE128' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:DomicilioFiscal:codigoPostal debe contener una clave del cat�logo de catCFDI:c_CodigoPostal, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado, la columna'+' clave de c_Municipio debe ser igual a la clave registrada en el atributo municipio, y si existe el atributo de localidad, la columna clave de c_Localidad debe ser igual a la clave registrada en el atributo localidad si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE129' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:ExpedidoEn:codigoPostal debe contener una clave del cat�logo de catCFDI:c_CodigoPostal, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado, la columna clave'+' de c_Municipio debe ser igual a la clave registrada en el atributo municipio, y si existe el atributo de localidad, la columna clave de c_Localidad debe ser igual a la clave registrada en el atributo localidad si el nodo es generado.',-1,-1,False)
   else if Codigo='CCE130' then raise EPACNoEncontradoParaCancelarException.Create('El nodo Comprobante.Emisor.RegimenFiscal debe tener solo un elemento hijo Regimen.',-1,-1,False)
   else if Codigo='CCE131' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:RegistroFiscal:Regimen no cumple con alguno de los valores permitidos para el tipo de persona del emisor.',-1,-1,False)
   else if Codigo='CCE132' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:rfc no tiene el valor "XEXX010101000" y el tipoDeComprobante tiene un valor distinto de "traslado" y MotivoTraslado un valor distinto de "02".',-1,-1,False)
   else if Codigo='CCE133' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:rfc debe tener un RFC v�lido dentro de la lista de RFC''s o el valor "XEXX010101000" cuando el tipoDeComprobante es "traslado" y MotivoTraslado es "02".',-1,-1,False)
   else if Codigo='CCE134' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:nombre se debe registrar.',-1,-1,False)
   else if Codigo='CCE135' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cfdi:Comprobante:Receptor:Domicilio se debe registrar.',-1,-1,False)
   else if Codigo='CCE136' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:estado debe '+'contener una clave del cat�logo catCFDI:c_Estado donde la columna c_Pais tenga el valor "MEX" si el atributo pais tiene el valor "MEX", el tipoDeComprobante es "traslado" y MotivoTraslado tiene el valor "02".',-1,-1,False)
   else if Codigo='CCE137' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:municipio '+'debe contener una clave del cat�logo de catCFDI:c_Municipio donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el atributo pais tiene el valor "MEX", el '+'tipoDeComprobante es "traslado" y MotivoTraslado tiene el valor "02".',-1,-1,False)
   else if Codigo='CCE138' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:localidad debe '+'contener una clave del cat�logo de catCFDI:c_Localidad, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado si el atributo pais tiene el valor "MEX", el '+'tipoDeComprobante es "traslado" y MotivoTraslado tiene el valor "02".',-1,-1,False)
   else if Codigo='CCE139' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:colonia debe '+'contener una clave del cat�logo de catCFDI:c_Colonia, donde la columna c_CodigoPostal debe ser igual a la clave registrada en el atributo codigoPostal si el atributo pais tiene el valor "MEX", el '+'tipoDeComprobante es "traslado" y MotivoTraslado tiene el valor "02".',-1,-1,False)
   else if Codigo='CCE140' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:codigoPostal '+'debe contener una clave del cat�logo de catCFDI:c_CodigoPostal, donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo estado, la columna clave de c_Municipio debe '+'ser igual a la clave registrada en el atributo municipio, y si existe el atributo de localidad, la columna clave de c_Localidad debe ser igual a la '+'clave registrada en el atributo localidad si el atributo pais tiene el valor "MEX", el tipoDeComprobante es "traslado" y MotivoTraslado tiene el valor "02".',-1,-1,False)
   else if Codigo='CCE141' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:pais debe ser '+'distinto de "MEX" y existir en el cat�logo catCFDI:c_Pais si tipoDeComprobante es distinto de "traslado" o MotivoTraslado es distinto de "02".',-1,-1,False)
   else if Codigo='CCE142' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:pais debe '+'contener una clave del cat�logo catCFDI:c_Estado donde la columna c_Pais sea igual a la clave del pais registrada en el atributo pais del mismo nodo.',-1,-1,False)
   else if Codigo='CCE143' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:codigoPostal '+'se debe registrar cuando tipoDeComprobante es distinto de "traslado" o MotivoTraslado es distinto de "02" y el pais es distinto de "MEX".',-1,-1,False)
   else if Codigo='CCE144' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Domicilio:codigoPostal '+'debe cumplir con el patr�n especificado en el cat�logo catCFDI:c_Pais cuando tipoDeComprobante es distinto de "traslado" o MotivoTraslado es distinto de "02" y el pais es distinto de "MEX".',-1,-1,False)
   else if Codigo='CCE145' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:TipoDeComprobante no cumple con '+'alguno de los valores permitidos para este complemento.',-1,-1,False)
   else if Codigo='CCE146' then raise EPACNoEncontradoParaCancelarException.Create('El atributo MotivoTraslado se debe registrar cuando el atributo '+'cfdi:Comprobante:TipoDeComprobante tiene el valor "T".',-1,-1,False)
   else if Codigo='CCE147' then raise EPACNoEncontradoParaCancelarException.Create('El nodo Propietario se debe registrar cuando el atributo '+'cfdi:Comprobante:TipoDeComprobante tiene el valor "T" y MotivoTraslado tiene la clave "05".',-1,-1,False)
   else if Codigo='CCE148' then raise EPACNoEncontradoParaCancelarException.Create('El nodo Propietario no se debe registrar cuando el atributo  '+'cfdi:Comprobante:TipoDeComprobante tiene un valor distinto de "T" y MotivoTraslado tiene una clave distinta de "05".',-1,-1,False)
   else if Codigo='CCE149' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Emisor:Nombre se debe registrar.',-1,-1,False)
   else if Codigo='CCE150' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfd:Comprobante:Receptor:Rfc no tiene el valor '+'"XEXX010101000" y el TipoDeComprobante tiene un valor distinto de "T" y MotivoTraslado un valor distinto de "02".',-1,-1,False)
   else if Codigo='CCE151' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Rfc debe tener un RFC '+'v�lido dentro de la lista de RFC''s o el valor "XEXX010101000" cuando el TipoDeComprobante es "T" y MotivoTraslado es "02".',-1,-1,False)
   else if Codigo='CCE152' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Receptor:Nombre se debe registrar.',-1,-1,False)
   else if Codigo='CCE153' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior no puede registrarse mas de una vez.',-1,-1,False)
   else if Codigo='CCE154' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior debe registrarse como un nodo hijo del nodo Complemento en el CFDI.',-1,-1,False)
   else if Codigo='CCE155' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior solo puede coexistir con los complementos Timbre Fiscal Digital, otros derechos e impuestos, leyendas fiscales, recepci�n de pago, CFDI registro fiscal.',-1,-1,False)
   else if Codigo='CCE156' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:FolioFiscalOrig se debe registrar si el valor de cce11:ComercioExterior:MotivoTraslado es "01".',-1,-1,False)
   else if Codigo='CCE157' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:CfdiRelacionados:CfdiRelacionado:UUID se debe registrar si el valor de cce11:ComercioExterior:MotivoTraslado es "01" con el tipo de relaci�n "05".',-1,-1,False)
   else if Codigo='CCE158' then raise EPACNoEncontradoParaCancelarException.Create('El atributo XXXXX no debe existir si el valor de cce11:ComercioExterior:TipoOperacion es "A".',-1,-1,False)
   else if Codigo='CCE159' then raise EPACNoEncontradoParaCancelarException.Create('El atributo XXXX debe registrarse si la clave de cce11:ComercioExterior:TipoOperacion registrada es "1" � "2".',-1,-1,False)
   else if Codigo='CCE160' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:NumCertificadoOrigen no se debe registrar si el valor de cce11:ComercioExterior:CertificadoOrigen es "0".',-1,-1,False)
   else if Codigo='CCE161' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:NumExportadorConfiable no se debe registrar si la clave de pa�s del receptor o del destinatario no corresponde a un pa�s del cat�logo catCFDI:c_Pais donde la columna Agrupaci�n tenga el valor Uni�n Europea.',-1,-1,False)
   else if Codigo='CCE162' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:TotalUSD no coincide con la suma de ValorDolares de las mercanc�as.',-1,-1,False)
   else if Codigo='CCE163' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:TotalUSD debe registrarse con dos decimales.',-1,-1,False)
   else if Codigo='CCE164' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Curp no se debe registrar si el atributo Rfc del nodo cfdi:Comprobante:Emisor es de longitud 12.',-1,-1,False)
   else if Codigo='CCE165' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Curp se debe registrar si el atributo Rfc del nodo cfdi:Comprobante:Emisor es de longitud 13.',-1,-1,False)
   else if Codigo='CCE166' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior:Emisor:Domicilio no debe registrarse si la versi�n de CFDI es  3.2.',-1,-1,False)
   else if Codigo='CCE167' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior:Emisor:Domicilio debe registrarse si la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE168' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:Pais debe tener la clave "MEX".',-1,-1,False)
   else if Codigo='CCE169' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:Estado debe contener una clave del cat�logo de catCFDI:c_Estado donde la columna c_Pais tiene el valor "MEX".',-1,-1,False)
   else if Codigo='CCE170' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:Municipio debe contener una clave del cat�logo de catCFDI:c_Municipio donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado.',-1,-1,False)
   else if Codigo='CCE171' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:Localidad debe contener una clave del cat�logo de catCFDI:c_Localidad donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado.',-1,-1,False)
   else if Codigo='CCE172' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:Colonia debe contener una clave del cat�logo de catCFDI:c_Colonia donde la columna c_CodigoPostal debe ser igual a la clave registrada en el atributo CodigoPostal.',-1,-1,False)
   else if Codigo='CCE173' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Emisor:Domicilio:CodigoPostal debe contener una clave del cat�logo catCFDI:c_CodigoPostal donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado'+', la columna clave de c_Municipio debe ser igual a la clave registrada en el atributo Municipio y si existe el atributo de Localidad, la columna clave de c_Localidad debe ser igual a la clave registrada en el atributo Localidad.',-1,-1,False)
   else if Codigo='CCE174' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Propietario:NumRegIdTrib no tiene un valor que exista en el registro del pa�s indicado en el atributo cce1:Propietario:ResidenciaFiscal.',-1,-1,False)
   else if Codigo='CCE175' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Propietario:NumRegIdTrib no cumple con el patr�n publicado en la columna "Formato de registro de identidad tributaria" del pa�s indicado en el atributo cce1:Propietario:ResidenciaFiscal.',-1,-1,False)
   else if Codigo='CCE176' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib no debe registrarse si la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE177' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib debe registrarse si la versi�n de CFDI es 3.2.',-1,-1,False)
   else if Codigo='CCE178' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib no tiene un valor que exista en el registro del pa�s indicado en el atributo cfdi:Comprobante:Receptor:Domicilio:pais.',-1,-1,False)
   else if Codigo='CCE179' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib no cumple con el patr�n publicado en la columna "Formato de registro de identidad tributaria" del pa�s indicado en el atributo cfdi:Comprobante:Receptor:Domicilio:pais.',-1,-1,False)
   else if Codigo='CCE180' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior:Receptor:Domicilio no debe registrarse si la versi�n de CFDI es  3.2.',-1,-1,False)
   else if Codigo='CCE181' then raise EPACNoEncontradoParaCancelarException.Create('El nodo cce11:ComercioExterior:Receptor:Domicilio debe registrarse si la versi�n de CFDI es  3.3.',-1,-1,False)
   else if Codigo='CCE182' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:Colonia debe tener un valor del cat�logo de colonia donde '+'la columna c�digo postal sea igual a la clave registrada en el atributo CodigoPostal cuando la clave de pa�s es "MEX", contiene una cadena num�rica de cuatro posiciones y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE183' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:Localidad debe tener un valor del cat�logo de localidades'+' (catCFDI:c_Localidad) donde la columna c_Estado sea igual a la clave registrada en el atributo Estado cuando la clave de pa�s es "MEX" y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE184' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:Municipio debe tener un valor del cat�logo de municipios'+' (catCFDI:c_Municipio) donde la columna c_Estado sea igual a la clave registrada en el atributo Estado cuando la clave de pa�s es "MEX" y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE185' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:Estado debe tener un valor del cat�logo de estados catCFDI:c_Estado '+'donde la columna c_Pais sea igual a la clave de pa�s registrada en el atributo Pais y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE186' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:CodigoPostal debe cumplir con el patr�n especificado para el pa�s '+'cuando es distinta de "MEX" y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE187' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Receptor:Domicilio:CodigoPostal debe tener un valor del cat�logo de c�digos postales '+'catCFDI:c_CodigoPostal donde la columna c_Estado sea igual a la clave '+'registrada en el atributo Estado, la columna c_Municipio sea igual a la clave registrada en el atributo Municipio y la columna c_Localidad sea igual a la clave registrada en el atributo Localidad en caso de que se haya registrado cuando la clave de '+'pa�s es "MEX" y la versi�n de CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE188' then raise EPACNoEncontradoParaCancelarException.Create('El campo tipoDeComprobante tiene el valor "traslado" por lo tanto s�lo podr�s registrar un Destinatario.',-1,-1,False)
   else if Codigo='CCE189' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:NumRegIdTrib no tiene un valor que exista en el registro del pa�s indicado '+'en el atributo cce11:ComercioExterior:Destinatario:Domicilio:Pais.',-1,-1,False)
   else if Codigo='CCE190' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:NumRegIdTrib no cumple con el patr�n publicado en la columna "Formato de '+'registro de identidad tributaria" del pa�s indicado en el atributo cce11:ComercioExterior:Destinatario:Domicilio:Pais.',-1,-1,False)
   else if Codigo='CCE191' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:Colonia debe tener un valor del cat�logo de colonias donde la '+'columna c�digo postal sea igual a la clave registrada en el atributo CodigoPostal cuando la clave de pa�s es "MEX" y contiene una cadena num�rica de cuatro posiciones.',-1,-1,False)
   else if Codigo='CCE192' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:Localidad debe tener un valor del cat�logo de localidades '+'(catCFDI:c_Localidad) donde la columna c_Estado sea igual a la clave registrada en el atributo Estado cuando la clave de pa�s es "MEX".',-1,-1,False)
   else if Codigo='CCE193' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:Municipio debe tener un valor del cat�logo de municipios '+'(catCFDI:c_Municipio) donde la columna c_Estado sea igual a la clave registrada en el atributo Estado cuando la clave de pa�s es "MEX".',-1,-1,False)
   else if Codigo='CCE194' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:Estado debe tener un valor del cat�logo de estados catCFDI:c_Estado '+'donde la columna c_Pais sea igual a la clave de pa�s registrada en el atributo Pais cuando la clave de pa�s existe en la columna c_Pais del cat�logo catCFDI:c_Estado y es diferente de "ZZZ".',-1,-1,False)
   else if Codigo='CCE195' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:CodigoPostal debe cumplir con el patr�n especificado para el pa�s '+'cuando es distinta de "MEX".',-1,-1,False)
   else if Codigo='CCE196' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Destinatario:Domicilio:CodigoPostal debe tener un valor del cat�logo de c�digos postales '+'catCFDI:c_CodigoPostal donde la columna c_Estado sea igual a la '+'clave registrada en el atributo Estado, la columna c_Municipio sea igual a la clave registrada en el atributo Municipio y la columna c_Localidad sea igual a la clave registrada en el atributo Localidad en caso de que se haya registrado cuando la clave de '+'pa�s es "MEX".',-1,-1,False)
   else if Codigo='CCE197' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:NoIdentificacion se debe registrar en cada concepto.',-1,-1,False)
   else if Codigo='CCE198' then raise EPACNoEncontradoParaCancelarException.Create('Debe existir al menos un cfdi:Comprobante:Conceptos:Concepto:NoIdentificacion relacionado con cce11:ComercioExterior:Mercancias:Mercancia:NoIdentificacion.',-1,-1,False)
   else if Codigo='CCE199' then raise EPACNoEncontradoParaCancelarException.Create('Debe existir al menos un concepto en el nodo cfdi:Comprobante:Conceptos por cada mercanc�a registrada en el elemento cce1:ComercioExterior:Mercancias donde el atributo '+'cce11:ComercioExterior:Mercancias:Mercancia:NoIdentificacion sea igual al atributo cfdi:Comprobante:Conceptos:Concepto:NoIdentificacion.',-1,-1,False)
   else if Codigo='CCE200' then raise EPACNoEncontradoParaCancelarException.Create('No se deben repetir elementos Mercancia donde el NoIdentificacion y la FraccionArancelaria sean iguales en el elemento cce11:ComercioExterior:Mercancias.',-1,-1,False)
   else if Codigo='CCE201' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:Cantidad no cumple con alguno de los valores permitidos cuando no se registra el atributo cce11:ComercioExterior:Mercancias:Mercancia:CantidadAduana.',-1,-1,False)
   else if Codigo='CCE202' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:Unidad no cumple con alguno de los valores permitidos cuando no se registra el atributo cce11:ComercioExterior:Mercancias:Mercancia:CantidadAduana.',-1,-1,False)
   else if Codigo='CCE203' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:ValorUnitario no cumple con alguno de los valores permitidos cuando no se registra el atributo cce11:ComercioExterior:Mercancias:Mercancia:CantidadAduana.',-1,-1,False)
   else if Codigo='CCE204' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:importe debe ser mayor o igual que el l�mite inferior y menor o igual que el l�mite superior calculado.',-1,-1,False)
   else if Codigo='CCE205' then raise EPACNoEncontradoParaCancelarException.Create('La suma de los campos cce11:ComercioExterior:Mercancias:Mercancia:ValorDolares distintos  de "0" y "1" de todas las mercanc�as que tengan el mismo NoIdentificacion y '+'�ste sea igual al NoIdentificacion del concepto debe ser mayor o igual al valor m�nimo y menor o igual al valor m�ximo calculado.',-1,-1,False)
   else if Codigo='CCE206' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:Mercancia:FraccionArancelaria debe registrarse cuando el atributo cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana '+'o el atributo cfdi:Comprobante:Conceptos:Concepto:Unidad tienen un valor distinto de "99".',-1,-1,False)
   else if Codigo='CCE207' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:Mercancia:FraccionArancelaria no debe registrarse cuando el atributo cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana '+'o el atributo cfdi:Comprobante:Conceptos:Concepto:Unidad tienen el valor "99".',-1,-1,False)
   else if Codigo='CCE208' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:Mercancia:FraccionArancelaria debe tener un valor vigente del cat�logo catCFDI:c_FraccionArancelaria.',-1,-1,False)
   else if Codigo='CCE209' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana debe tener el valor especificado en el cat�logo catCFDI:c_FraccionArancelaria columna "UMT" cuando el '+'atributo cce11:ComercioExterior:Mercancias:Mercancia:FraccionArancelaria est� registrado.',-1,-1,False)
   else if Codigo='CCE210' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:Conceptos:Concepto:Unidad del concepto relacionado a la mercnc�a debe tener el valor especificado en el cat�logo catCFDI:c_FraccionArancelaria '+'columna "UMT" cuando el atributo cce11:ComercioExterior:Mercancias:Mercancia:FraccionArancelaria est� registrado.',-1,-1,False)
   else if Codigo='CCE211' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cfdi:Comprobante:descuento debe ser mayor o igual que la suma de los atributos cce11:ComercioExterior:Mercancias:Mercancia:ValorDolares de todas las mercanc�as '+'que tengan la fracci�n arancelaria "98010001" convertida a la moneda del comprobante si la versi�n del CFDI es 3.2.',-1,-1,False)
   else if Codigo='CCE212' then raise EPACNoEncontradoParaCancelarException.Create('La suma de los valores de cfdi:Comprobante:Conceptos:Concepto:Descuento donde el NoIdentificacion es el mismo que el de la mercanc�a convertida a la moneda del comprobante '+'debe ser mayor o igual que la suma de los valores de  cce11:ComercioExterior:Mercancias:Mercancia:ValorDolares de todas las mercanc�as '+'que tengan la fracci�n arancelaria "98010001" y el NoIdentificacion sea igual al NoIdentificacion del concepto si la versi�n del CFDI es 3.3.',-1,-1,False)
   else if Codigo='CCE213' then raise EPACNoEncontradoParaCancelarException.Create('Los atributos CantidadAduana, UnidadAduana y ValorUnitarioAduana deben existir en los registros involucrados si se ha registrado alguno de ellos, si existe m�s de un concepto '+'con el mismo NoIdentificacion o si existe m�s de una mercanc�a con el mismo NoIdentificacion.',-1,-1,False)
   else if Codigo='CCE214' then raise EPACNoEncontradoParaCancelarException.Create('Los atributos CantidadAduana, UnidadAduana y ValorUnitarioAduana deben registrarse en todos los elementos mercanc�a del comprobante, siempre que uno de ellos los tenga registrados.',-1,-1,False)
   else if Codigo='CCE215' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:Mercancia:ValorUnitarioAduana debe ser mayor que "0" cuando  cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana es distinto de "99".',-1,-1,False)
   else if Codigo='CCE216' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:ValorDolares de cada mercanc�a registrada debe ser mayor o igual que el l�mite inferior y menor o igual que el l�mtie superior o uno, cuando la '+'normatividad lo permita y exista el atributo cce11:ComercioExterior:Mercancias:Mercancia:CantidadAduana.',-1,-1,False)
   else if Codigo='CCE217' then raise EPACNoEncontradoParaCancelarException.Create('El atributo cce11:ComercioExterior:Mercancias:ValorDolares de cada mercanc�a registrada debe ser igual al producto del valor del atributo cfdi:Comprobante:Conceptos:Concepto:Importe por el valor '+'del atributo cfdi:Comprobante:TipoCambio y dividido entre el valor del atributo  cce11:ComercioExterior:TipoDeCambioUSD '+'donde el atributo cfdi:Comprobante:Conceptos:NoIdentificacion es igual al atributo  cce11:ComercioExterior:Mercancias:Mercancia:NoIdentificacion, "0" cuando el atributo cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana '+'o el atributo  cfdi:Comprobante:Conceptos:Concepto:Unidad tienen el valor "99", o "1", cuando la normatividad lo permita y no debe existir el atributo cce11:ComercioExterior:Mercancias:Mercancia:CantidadAduana',-1,-1,False)
   else result := false;
  end;

function CodEstatus(Codigo:string):Boolean;
var iCodigo : Integer;
  Code: Integer;
  Value: Double;
Begin
 Result:=False;
 val(Codigo, Value, Code);

 {NOTA: Se tuvo que dividir el lanzamiento de excepciones debido a que en delphi XE1
  y anteriores manda un error de 'Too many local constants'
 }
 if Code=0 then // verifico si es numerico
  Begin
   RaisePACCodEstatusNumerico(Codigo);
  End
 else
 Begin
  if not RaisePACCodEstatusAlfaCFDI(Codigo) then
      if not RaisePACCodEstatusAlfaCCE(Codigo) then
         raise EPACErrorGenericoException.Create(Codigo,-1,-1,False);
  end;
 End;

end.

