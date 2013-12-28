TFACTURACIONELECTRONICA v1.0 (Beta) 
===================================
Con soporte para CFD 2.2 y CFDI 3.2     
--------------------------------------
Esta es una librería que sirve para generar una factura electrónica de acuerdo a los artículos y leyes establecidas en la ley de Mexico y definidos por el SAT.

El propósito es servir como una libreria gratuita, de código abierto, de fácil uso en la cual con el esfuerzo de la comunidad siempre esté actualizada y funcional.

Algunos aspectos que busca tener esta libreria:

- Estar vigente (actualizada)
- No depender de librerias comerciales.
- Ser de fácil uso.
- Que pueda ser integrada fácilmente a cualquier proyecto existente.
- Contar con pruebas de unidad automatizadas para corroborar el funcionamiento adecuado de cada función y clase.
- Estar implementada en clases (seguir reglas de programación orientada a objetos).
- Esconder los detalles de implementación/técnicos al usuario final (el programador que use la clase).

Más información sobre este proyecto en:
<http://bambucode.com/codigoabierto>

Requerimientos técnicos
------------
- Contar con alguna edición de Delphi.
- Contar con librerias libeay32.dll, ssleay32.dll y el ejecutable openssl.exe (solo para las pruebas automatizadas) las cuales se encuentran en la siguiente liga: <http://www.openssl.org/related/binaries.html>

¿Qué falta por implementar?
-------------
- Manejo de Adendas.
- Manejo y pruebas de conceptos con datos aduanales.
- Manejo y pruebas de articulos con cuenta predial.

Proveedores Autorizados de Certificación (PAC) Soportados
-------------
* Ecodex - <http://www.ecodex.com.mx>
* Comercio Digital - <http://www.comercio-digital.com.mx> - Solo timbrado
* FinkOk - <http://www.finkok.com> - Solo timbrado

Completado
-------------
- Implementar la version 3.2 de los CFD (o comprobantes digitales en linea) con colaboración de Ing. Pablo Torres - <Completado a finales de Noviembre 2013>
- Implementar soporte para la versión 2.2 de CFD - Completado Junio 2012.
- Implementar la lectura de un CFD y que al mismo tiempo verifique si es válido o no. <- Completado 12 Dic 2010>
- Una clase que genere el reporte mensual de facturas generadas en el formato requerido por el SAT. < Completado 26 Ene 2011 >
- Se agregaron validaciones para verificar que el certificado sea de sellos y que el certificado y llave privada sean pareja <Completado 28 Diciembre 2013>

¿Cómo puedo ayudar?
-------------
Actualmente la librería se encuentra en estado "beta" en la implementación de CFDI. La manera en que puedes ayudar es en realizar más pruebas de unidad para probar los diferentes casos y corroborar que la librería funcione como debe. También puedes implementar más PACs basándote en los actuales y el ejemplo incluído. Así como en agregar documentación técnica o colaborar en la implementación de Adendas, conceptos con datos aduanales, etc.

Si te interesa contribuir en mejorar, extender o corregir esta librería para el beneficio de la comunidad y crédito para tí ponte en contacto a mi correo: <luis@bambucode.com> ya sea para envío de código realizado o bien si lo deseas puedes mandarme un "pull request" de tu "fork" de la librería.

Soporte Técnico
------------
El soporte es limitado y por la misma razón la librería es de código abierto, para que puedas estudiarla, mejorarla y corregirla en donde encuentres alguna falla. Si encuentras alguna falla favor de reportarla en esta página en la sección de "Issues" para que otros usuarios puedan colaborar y encontrar una solución como comunidad, te agradecemos intentes corregir cualquier problema primero antes de reportarlo para al menos saber que has intentado solucionarlo por tu cuenta.

Notas adicionales
------------
El ejecutable que use esta libreria deberá contar con los archivos DLL de openssl en el mismo directorio de la
aplicación para que pueda funcionar. Considere esto cuando genere un instalador o vaya a distribuir su aplicación
final.

Icono proporcionado por: http://pc.de/icons/

Compatibilidad con versiones
------------
La libreria ha sido probada solamente con Delphi XE2 aunque se ha tratado de mantener la compatibilidad con versiones desde Delphi 2007 si se encuentra algún error favor de reportarlo a la brevedad. En especial las rutinas de generación de CFDI v3.2 no han sido probadas en versiones anteriores a Delphi XE2.

Colaboradores actuales.
-------------
* Ing. Luis Carrasco - Bambú Code SA de CV - <http://github.com/lcarrasco>
* Ing. Eduardo  Padilla - Bambú Code SA de CV - <https://github.com/epadillac>
*  Ing. Pablo Torres - <http://www.tecsisnet.net>
