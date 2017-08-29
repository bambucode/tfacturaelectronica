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
- Contar con alguna edición de Delphi (de momento solo se garantiza funcionamiento en Delphi 2007,Seattle,Tokyo)
- Contar con librerias libeay32.dll, ssleay32.dll y el ejecutable openssl.exe (solo para las pruebas automatizadas) las cuales se encuentran en la siguiente liga: <http://www.openssl.org/related/binaries.html>


Limitaciones
--------------
A partir de la versión 2.0 de la librería, que implementa el soporte para CFDI v3.3 (Julio 2017), se estandariza el uso de las clases auto generadas por Delphi para el manejo del XML de los comprobantes permitiendo el uso de todos los nodos, atributos y propiedades de cada version según los haya definido el SAT, sin embargo de omiten las validaciones de los campos y ahora esta responsabilidad será a cargo del programador / usuario de la librería.

Por ejemplo la librería te permitirá llenar el atributo `Total` de la factura con una cadena, lo cual no es correcto pero a nivel XML es válido.

Proveedores Autorizados de Certificación (PAC) Soportados por v2.0
-------------
* Ecodex - <http://www.ecodex.com.mx>
* FinkOk - <http://www.finkok.com>
* Comercio-digital <http://www.comercio-digital.com>

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
- Otros complementos (comercio electronico, etc.)
- Pruebas de unidad
- Validaciones de campos basado en los múltiples catálogos publicados por el SAT.
- Soporte para ediciones anteriores de Delphi 2010, etc.

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
La libreria ha sido probada solamente con Delphi XE2 aunque se ha tratado de mantener la compatibilidad con versiones desde Delphi 2007 si se encuentra algún error favor de reportarlo a la brevedad. En especial las rutinas de generación de CFDI v3.2 no han sido probadas en versiones anteriores a Delphi XE2.

Colaboradores actuales.
-------------
* Ing. Luis Carrasco - Bambú Code SA de CV - <http://github.com/lcarrasco>
* Ing. Eduardo  Padilla - Bambú Code SA de CV - <https://github.com/epadillac>
* Ing. Pablo Torres - <http://www.tecsisnet.net>
* Felipe Faccinetto <https://github.com/ffaccinetto>
