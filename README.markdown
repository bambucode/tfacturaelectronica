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
<http://bambucode.com/codigoabierto>

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


Completado
-------------
- Implementar la version 3.2 de los CFD (o comprobantes digitales en linea). <Completado en Diciembre 2013> con colaboración de Ing. Pablo 
- Implementar soporte para la versión 2.2 de CFD - Completado Junio 2012.
- Implementar la lectura de un CFD y que al mismo tiempo verifique si es válido o no. <- Completado 12 Dic 2010>
- Una clase que genere el reporte mensual de facturas generadas en el formato requerido por el SAT. < Completado 26 Ene 2011 >

¿Cómo puedo colaborar?
-------------
Si te interesa contribuir en mejorar, extender o corregir esta librería para el beneficio de la comunidad y crédito para tí ponte en contacto a mi correo: <luis@bambucode.com>

Notas adicionales
------------
El ejecutable que use esta libreria deberá contar con los archivos DLL de openssl en el mismo directorio de la
aplicación para que pueda funcionar. Considere esto cuando genere un instalador o vaya a distribuir su aplicación
final.

Compatibilidad con versiones
------------
La libreria ha sido probada solamente con Delphi XE2 aunque se ha tratado de mantener la compatibilidad con versiones desde Delphi 2007 si se encuentra algún error favor de reportarlo a la brevedad.

Colaboradores actuales.
-------------
* Ing. Luis Carrasco - Bambu Code SA de CV - <http://github.com/lcarrasco>
*  Ing. Pablo Torres - <http://www.tecsisnet.net>