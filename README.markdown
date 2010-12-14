TFACTURACIONELECTRONICA (Beta)
=====================================
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
<http://www.bambucode.com/codigoabierto>

Requerimientos técnicos
------------
- Contar con alguna edición de Delphi.
- Contar con librerias libeay32.dll, ssleay32.dll y el ejecutable openssl.exe (solo para las pruebas automatizadas)
las cuales se encuentran en la siguiente liga: <http://www.openssl.org/related/binaries.html>

¿Qué falta por implementar?
-------------
- Manejo de Adendas.
- Manejo y pruebas de conceptos con datos aduanales.
- Manejo y pruebas de articulos con cuenta predial.
- Implementar la version 3 de los CFD (o comprobantes digitales en linea).
- Implementar la lectura de un CFD y que al mismo tiempo verifique si es válido o no. <- Completado 12 Dic 2010>
- Una clase que genere el reporte mensual de facturas generadas en el formato requerido por el SAT.

¿Cómo puedo colaborar?
-------------
Si te interesa contribuir en mejorar, extender o corregir esta librería para el beneficio de la comunidad y crédito para tí puedes obtener más información sobre como hacerlo en la siguiente página:
<http://www.bambucode.com/codigoabierto/facturacion_electronica_delphi.php>

Notas adicionales
------------
El ejecutable que use esta libreria deberá contar con los archivos DLL de openssl en el mismo directorio de la
aplicación para que pueda funcionar. Considere esto cuando genere un instalador o vaya a distribuir su aplicación
final.

Compatibilidad con versiones
------------
La libreria está siendo probada con las versiones de Delphi 2007 y Delphi XE.

Colaboradores actuales.
-------------
* Ing. Luis Carrasco - Bambu Code SA de CV - <http://github.com/lcarrasco>

