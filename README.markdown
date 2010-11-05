FACTURACION ELECTRONICA
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

<b>NOTA: Las librerías aún están en desarrollo y están siendo constantemente actualizadas. Tan pronto se tenga lista una versión beta del código se removerá este aviso. - 28 Octubre 2010</b> 

Más información sobre este proyecto en:
<http://www.bambucode.com/codigoabierto>

Requerimientos técnicos
------------
- Contar con alguna edición de Delphi.
- Contar con librerias libeay32.dll, ssleay32.dll y el ejecutable openssl.exe (solo para las pruebas automatizadas)
las cuales se encuentran en la siguiente liga: <http://www.openssl.org/related/binaries.html>

¿Qué falta por implementar?
-------------
- Una clase que genere el reporte mensual de facturas generadas en el formato requerido por el SAT.
- Implementar la version 3 de los CFD (o comprobantes digitales en linea).
- Manejo y pruebas de conceptos con datos aduanales.
- Manejo y pruebas de articulos con cuenta predial.

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

¿Nuevo en github/uso de git?
-------------
Algunas personas no están familiarizadas con el uso de Git (sistema de manejo de código fuente) por lo que pueden
obtener más información sobre las amplias ventajas de usarlo en la siguiente liga:

* Video de introducción a Git/Github (en inglés) - <http://www.pragprog.com/screencasts/v-scgithub/insider-guide-to-github>
* Libro ProGit (en inglés)- <http://progit.org/book> 
* Traducción Libro ProGit parcial (en español) - <http://progit.org/book/es/>

Si desean pueden usar el siguiente software (de uso libre para proyectos no comerciales) para interactuar con Git
bajo Windows:
<http://www.syntevo.com/smartgit>