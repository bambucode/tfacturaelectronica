TFACTURACIONELECTRONICA v2.0 - Alpha
--------------------------------------
Esta es una librería que sirve para generar una factura electrónica (CFDI) de acuerdo a los artículos y leyes establecidas en la ley de Mexico y definidos por el SAT.

El propósito es servir como una libreria gratuita, de código abierto, de fácil uso en la cual con el esfuerzo de la comunidad siempre esté actualizada y funcional.

Algunos aspectos que busca tener esta libreria:

- Estar vigente (actualizada)
- No depender de librerias comerciales.
- Ser de fácil uso.
- Que pueda ser integrada fácilmente a cualquier proyecto existente.
- Contar con pruebas de unidad automatizadas para corroborar el funcionamiento adecuado de cada función y clase.
- Estar implementada en clases (seguir reglas de programación orientada a objetos).
- Esconder los detalles de implementación/técnicos al usuario final (el programador que use la clase).

Requerimientos técnicos
------------
- Contar con alguna edición de Delphi (de momento solo se garantiza funcionamiento en Delphi Seattle)
- Contar con librerias libeay32.dll, ssleay32.dll y el ejecutable openssl.exe (solo para las pruebas automatizadas) las cuales se encuentran en la siguiente liga: <http://www.openssl.org/related/binaries.html>


Limitaciones
--------------
A partir de la versión 2.0 de la librería, que implementa el soporte para CFDI v3.3 (Julio 2017), se estandariza el uso de las clases auto generadas por Delphi para el manejo del XML de los comprobantes permitiendo el uso de todos los nodos, atributos y propiedades de cada version según los haya definido el SAT, sin embargo de omiten las validaciones de los campos y ahora esta responsabilidad será a cargo del programador / usuario de la librería.

Por ejemplo la librería te permitirá llenar el atributo `Total` de la factura con una cadena, lo cual no es correcto pero a nivel XML es válido.

Proveedores Autorizados de Certificación (PAC) Soportados por v2.0
-------------
* Ecodex - <http://www.ecodex.com.mx>
* FinkOk - colaboración de @ptorres
* ComercioDigital - colaboración de @ptorres
* Solución Factible - colaboración de @ffaccinetto 
* Multifacturas - <http://www.multifacturas.com> - colaboración de @fduenas

Complementos de Factura Soportados por v2.0
-------------
* Para CFDI 3.2
	- Vía OOP, usando clases autogeneradas por medio de XML Databinding de Delphi (IXMLDocument, IXMLNode, etc.)
		- Timbre Fiscal Digital 1.0
		- Impuestos Locales 1.0
	
* Para CFDI 3.3
	- Vía OOP, usando clases autogeneradas por medio de XML Databinding de Delphi (IXMLDocument, IXMLNode, etc.)
		- Timbre Fiscal Digital 1.1
		- Impuestos Locales 1.0
		- Recepción de Pagos 1.0	
		- Comercio Exterior 1.1		- colaboración de @fduenas
		- Nómina 1.2 				- colaboración de @fduenas
		- Notarios Publicos 1.0 	- colaboración de @fduenas
	- Se ha modificado el archivo cadenaoriginal_3_3.xslt para que cualquiera de los complementos implementados por el SAT a la fecha (2018-09-28) sea tomado en cuenta al generarse la cadena original, con esto, aunque NO EXISTA una clase específica para un complemento (ej: TComercioExteriorV11), este puedan agregarse al nodo \<cfdi:Complemento\> de manera manual usando los métodos: 
		- IComprobanteFiscalV33.Complemento.AddNode(\<nombre_complemento\>) --> Nueva Instancia IXMLNode
		- IXMLNode.AddNode(\<nombre_nodohijo\>)
		- IXMLNode.FindNode(\<nombre_nodohijo\>)
		- IXMLNode.AttributeNodes\[\<nombre_atributo\>\].Text
		- Para mayor información acerca de cómo trabajar con nodos XML en Delphi, consultar: http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Working_with_XML_Nodes
	- El complemento que sea agregado de manera manual debe cumplir con las especificaciones establecidas por el SAT para dicho complemento. Para mayor información consultar la documentación técnica del complemento a agregar.

Documentación Técnica
-------------
A partir de la v2.0 de la librería, se ha documentado de forma extensiva el proyecto, la estructura, su funcionamiento, etc. para ello te invitamos a consultar <https://github.com/bambucode/tfacturaelectronica/wiki>

¿Qué falta?
-------------------
A Mayo de 2017 falta de implementar lo siguiente (en orden de importancia):

- ~~Lectura de CFDI 3.3~~
- ~~Generación de CBB con cambios para CFDI 3.3~~.
- ~~Soporte para generación/lectura de CFDI 3.2 (para fines de compatibilidad y migración)~~
- ~~Lanzar excepciones basado en el catálogo de errores de CFDI 3.3~~ (Parcial)
- ~~Poder incluir impuestos locales (3.2 y 3.3)~~.
- ~~Complemento de pagos~~ con ayuda de @ffaccinetto
- Otros complementos (donatarias, hidrocarburos, etc.)
- Pruebas de unidad
- Validaciones de campos basado en los múltiples catálogos publicados por el SAT.
- ~~Soporte para ediciones anteriores de Delphi 7, Delphi 2007, 2010, XE1 etc.~~ con ayuda de @fduenas
- Realizar pruebas en Delphi 2007, Delphi 2009 y Delphi 2010

Notas de compatibilidad con otras versiones de Delphi
-------------------
-  Se agregó y probó exitósamente el soporte con Delphi 7, Delphi XE1 y Delphi XE 10.2.3 (Tokyo), por lo que no debe haber problemas con Delphi 2009 y 2010 y demás versiones intermedias.

-  Para el soporte con Delphi 7, Delphi 2007, Delphi 2009 y Delphi 2010 se requiere usar la librería TPerlRegExp para el uso de Expresiones Regulares, debido a que el soporte nativo para estas últimas se agregó a partir de Delphi XE1.
	- Esta se encuentra en la carpeta: lib/external/legacy/TPerlRegEx (agregada el 2018-09-25)
	- También puede descargarse desde la página: <https://www.regular-expressions.info/delphi.html> 
     		o directamente desde: <https://www.regular-expressions.info/download/TPerlRegEx.zip>
	- Además se conserva una copia de dicha librería desde el repositorio: <https://github.com/fduenas/TPerlRegEx>
	- Una vez descargado el archivo, extraerlo en la carpeta de su conveniencia 
	- Agregar el folder que contiene los archivos a la configuracion Library Path del Proyecto (Project/Options/Delphi Compiler/Search path) o del IDE de Delphi (Tools/Environment Options/Library/Library path)
	
	- Para Mayor información acerca del uso de esta librería consultar: https://www.regular-expressions.info/delphi.html
	- Para que el Pac Comercio Digital pueda funcionar es necesaria la libreria SynaCode, se encuentra en el directorio de Lib\synapse

¿Cómo puedo ayudar?
-------------------
La librería lleva más de 4 años de haber sido liberada al público, sin embargo aun falta mucho trabajo por hacer. Puedes comenzar checando el apartado de "Issues" del proyecto para ver en que puedes colaborar, una vez que lo hagas puedes mandar un pull-request para que implementemos tus cambios.

Si te interesa contribuir en mejorar, extender o corregir esta librería para el beneficio de la comunidad y crédito para tí ponte en contacto a través del foro oficial de la librería en <https://groups.google.com/forum/#!forum/tfacturaelectronica>

Soporte Técnico
------------
El soporte técnico se hace a través de la comunidad en el foro oficial de la librería al cual se puede acceder en: <https://groups.google.com/forum/#!forum/tfacturaelectronica> . De manera adicional, si encuentras alguna falla o te gustaría alguna funcionalidad favor de reportarla en esta página en la sección de "Issues" para que otros usuarios puedan colaborar y encontrar una solución como comunidad, te agradecemos intentes corregir cualquier problema primero antes de reportarlo para al menos saber que has intentado solucionarlo por tu cuenta.

Notas adicionales
------------
El ejecutable que use esta libreria deberá contar con los archivos DLL de openssl en el mismo directorio de la
aplicación para que pueda funcionar. Considere esto cuando genere un instalador o vaya a distribuir su aplicación
final.

Icono proporcionado por: http://pc.de/icons/

Compatibilidad con versiones
------------
La libreria ha sido probada solamente con Delphi 7, Delphi XE1, Delphi XE2, delphi XE10.2.3 (Tokyo), por lo que no debería haber problema con versiones intermedias y aunque se ha tratado de mantener la compatibilidad con versiones desde Delphi 7, si se encuentra algún error, favor de reportarlo a la brevedad. En especial las rutinas de generación de CFDI v3.2 no han sido probadas en versiones anteriores a Delphi XE2. Antes de realizar pruebas con versiones anteriores a Rad Studio XE1, es importante leer la sección "Notas de compatibilidad con otras versiones de Delphi".

Colaboradores actuales.
-------------
* Ing. Luis Carrasco - Bambú Code SA de CV - <http://github.com/lcarrasco>
* Ing. Eduardo  Padilla - Bambú Code SA de CV - <https://github.com/epadillac>
* Ing. Pablo Torres - <http://www.tecsisnet.net>
* Felipe Faccinetto - <https://github.com/ffaccinetto>
* Lic. Francisco Armando Dueñas Rodriguez - <https://github.com/fduenas>
