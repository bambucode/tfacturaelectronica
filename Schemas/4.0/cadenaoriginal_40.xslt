<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:cfdi="http://www.sat.gob.mx/cfd/4" xmlns:cce11="http://www.sat.gob.mx/ComercioExterior11" xmlns:donat="http://www.sat.gob.mx/donat" xmlns:divisas="http://www.sat.gob.mx/divisas" xmlns:implocal="http://www.sat.gob.mx/implocal" xmlns:leyendasFisc="http://www.sat.gob.mx/leyendasFiscales" xmlns:pfic="http://www.sat.gob.mx/pfic" xmlns:tpe="http://www.sat.gob.mx/TuristaPasajeroExtranjero" xmlns:nomina12="http://www.sat.gob.mx/nomina12" xmlns:registrofiscal="http://www.sat.gob.mx/registrofiscal" xmlns:pagoenespecie="http://www.sat.gob.mx/pagoenespecie" xmlns:aerolineas="http://www.sat.gob.mx/aerolineas" xmlns:valesdedespensa="http://www.sat.gob.mx/valesdedespensa" xmlns:notariospublicos="http://www.sat.gob.mx/notariospublicos" xmlns:vehiculousado="http://www.sat.gob.mx/vehiculousado" xmlns:servicioparcial="http://www.sat.gob.mx/servicioparcialconstruccion" xmlns:decreto="http://www.sat.gob.mx/renovacionysustitucionvehiculos" xmlns:destruccion="http://www.sat.gob.mx/certificadodestruccion" xmlns:obrasarte="http://www.sat.gob.mx/arteantiguedades" xmlns:ine="http://www.sat.gob.mx/ine" xmlns:iedu="http://www.sat.gob.mx/iedu" xmlns:ventavehiculos="http://www.sat.gob.mx/ventavehiculos" xmlns:detallista="http://www.sat.gob.mx/detallista" xmlns:ecc12="http://www.sat.gob.mx/EstadoDeCuentaCombustible12" xmlns:consumodecombustibles11="http://www.sat.gob.mx/ConsumoDeCombustibles11" xmlns:gceh="http://www.sat.gob.mx/GastosHidrocarburos10" xmlns:ieeh="http://www.sat.gob.mx/IngresosHidrocarburos10" xmlns:cartaporte20="http://www.sat.gob.mx/CartaPorte20" xmlns:pago20="http://www.sat.gob.mx/Pagos20">

  <!-- Con el siguiente método se establece que la salida deberá ser en texto -->
  <xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
  <!--
		En esta sección se define la inclusión de las plantillas de utilerías para colapsar espacios
	-->
 <!-- Manejador de datos requeridos -->
	<xsl:template name="Requerido">
		<xsl:param name="valor"/>|<xsl:call-template name="ManejaEspacios">
			<xsl:with-param name="s" select="$valor"/>
		</xsl:call-template>
	</xsl:template>

	<!-- Manejador de datos opcionales -->
	<xsl:template name="Opcional">
		<xsl:param name="valor"/>
		<xsl:if test="$valor">|<xsl:call-template name="ManejaEspacios"><xsl:with-param name="s" select="$valor"/></xsl:call-template></xsl:if>
	</xsl:template>
	
	<!-- Normalizador de espacios en blanco -->
	<xsl:template name="ManejaEspacios">
		<xsl:param name="s"/>
		<xsl:value-of select="normalize-space(string($s))"/>
	</xsl:template>
  <!-- 
		En esta sección se define la inclusión de las demás plantillas de transformación para 
		la generación de las cadenas originales de los complementos fiscales 
	-->
<xsl:template match="donat:Donatarias">
<!--
 Iniciamos el tratamiento de los atributos de donat:Donatarias 
-->
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@version"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@noAutorizacion"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@fechaAutorizacion"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@leyenda"/>
</xsl:call-template>
</xsl:template>

	<xsl:template match="divisas:Divisas">
<!--
 Iniciamos el tratamiento de los atributos de divisas:Divisas 
-->
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@version"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@tipoOperacion"/>
</xsl:call-template>
</xsl:template>

	<xsl:template match="implocal:ImpuestosLocales">
<!--
Iniciamos el tratamiento de los atributos de ImpuestosLocales 
-->
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@version"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TotaldeRetenciones"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TotaldeTraslados"/>
</xsl:call-template>
<xsl:for-each select="implocal:RetencionesLocales">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpLocRetenido"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TasadeRetencion"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@Importe"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="implocal:TrasladosLocales">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpLocTrasladado"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TasadeTraslado"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@Importe"/>
</xsl:call-template>
</xsl:for-each>
</xsl:template>

<xsl:template match="leyendasFisc:LeyendasFiscales">
<!--
Iniciamos el tratamiento de los atributos del complemento LeyendasFiscales 
-->
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@version"/>
</xsl:call-template>
<!--  Manejo de los atributos de las leyendas Fiscales -->
<xsl:for-each select="./leyendasFisc:Leyenda">
<xsl:apply-templates select="."/>
</xsl:for-each>
</xsl:template>
<!--
 Manejador de nodos tipo Información de las leyendas 
-->
<xsl:template match="leyendasFisc:Leyenda">
<!--  Manejo de los atributos de la leyenda  -->
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@disposicionFiscal"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@norma"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@textoLeyenda"/>
</xsl:call-template>
</xsl:template>

	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/pfic/pfic.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/TuristaPasajeroExtranjero/TuristaPasajeroExtranjero.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina12.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/cfdiregistrofiscal/cfdiregistrofiscal.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/pagoenespecie/pagoenespecie.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/aerolineas/aerolineas.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/valesdedespensa/valesdedespensa.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/notariospublicos/notariospublicos.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/vehiculousado/vehiculousado.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/servicioparcialconstruccion/servicioparcialconstruccion.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/renovacionysustitucionvehiculos/renovacionysustitucionvehiculos.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/certificadodestruccion/certificadodedestruccion.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/arteantiguedades/obrasarteantiguedades.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior11/ComercioExterior11.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/ine/ine11.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/iedu/iedu.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/ventavehiculos/ventavehiculos11.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/detallista/detallista.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/EstadoDeCuentaCombustible/ecc12.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/consumodecombustibles/consumodeCombustibles11.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/GastosHidrocarburos10/GastosHidrocarburos10.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/IngresosHidrocarburos10/IngresosHidrocarburos.xslt"/>
	<xsl:include href="http://www.sat.gob.mx/sitio_internet/cfd/CartaPorte/CartaPorte20.xslt"/>
	
  <xsl:template match="pago20:Pagos">
<!-- Manejador de Atributos Pagos -->
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@Version"/>
</xsl:call-template>
<!--
 Iniciamos el manejo de los elementos de tipo Totales. 
-->
<xsl:for-each select="./pago20:Totales">
<xsl:apply-templates select="."/>
</xsl:for-each>
<!--  Iniciamos el manejo de los elementos de tipo Pago.  -->
<xsl:for-each select="./pago20:Pago">
<xsl:apply-templates select="."/>
</xsl:for-each>
</xsl:template>
<!--
 Iniciamos el tratamiento de los atributos de pago20:Totales. 
-->
<xsl:template match="pago20:Totales">
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalRetencionesIVA"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalRetencionesISR"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalRetencionesIEPS"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosBaseIVA16"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosImpuestoIVA16"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosBaseIVA8"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosImpuestoIVA8"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosBaseIVA0"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosImpuestoIVA0"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TotalTrasladosBaseIVAExento"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@MontoTotalPagos"/>
</xsl:call-template>
</xsl:template>
<!--
 Iniciamos el tratamiento de los atributos de pago20:Pago 
-->
<xsl:template match="pago20:Pago">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@FechaPago"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@FormaDePagoP"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@MonedaP"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TipoCambioP"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@Monto"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@NumOperacion"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@RfcEmisorCtaOrd"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@NomBancoOrdExt"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@CtaOrdenante"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@RfcEmisorCtaBen"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@CtaBeneficiario"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TipoCadPago"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@CertPago"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@CadPago"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@SelloPago"/>
</xsl:call-template>
<!--
  Iniciamos el tratamiento de los atributos de pago20:DocumentoRelacionado. 
-->
<xsl:for-each select="./pago20:DoctoRelacionado">
<xsl:apply-templates select="."/>
</xsl:for-each>
<!--
  Iniciamos el tratamiento de los atributos de pago20:ImpuestosP. 
-->
<xsl:for-each select="./pago20:ImpuestosP">
<xsl:apply-templates select="."/>
</xsl:for-each>
</xsl:template>
<!--
 Iniciamos el tratamiento de los atributos de pago20:DoctoRelacionado. 
-->
<xsl:template match="pago20:DoctoRelacionado">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@IdDocumento"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@Serie"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@Folio"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@MonedaDR"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@EquivalenciaDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@NumParcialidad"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpSaldoAnt"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpPagado"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpSaldoInsoluto"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ObjetoImpDR"/>
</xsl:call-template>
<!--
  Iniciamos el tratamiento de los atributos del subnodo ImpuestosDR-RetencionesDR-RetencionDR. 
-->
<xsl:for-each select="./pago20:ImpuestosDR/pago20:RetencionesDR/pago20:RetencionDR">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@BaseDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpuestoDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TipoFactorDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TasaOCuotaDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImporteDR"/>
</xsl:call-template>
</xsl:for-each>
<!--
  Iniciamos el tratamiento de los atributos del subnodo ImpuestosDR-TrasladosDR-TrasladoDR. 
-->
<xsl:for-each select="./pago20:ImpuestosDR/pago20:TrasladosDR/pago20:TrasladoDR">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@BaseDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpuestoDR"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TipoFactorDR"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TasaOCuotaDR"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@ImporteDR"/>
</xsl:call-template>
</xsl:for-each>
</xsl:template>
<!--
 Iniciamos el tratamiento de los atributos de pago20:ImpuestosP. 
-->
<xsl:template match="pago20:ImpuestosP">
<xsl:apply-templates select="./pago20:RetencionesP"/>
<xsl:apply-templates select="./pago20:TrasladosP"/>
</xsl:template>
<xsl:template match="pago20:RetencionesP">
<xsl:for-each select="./pago20:RetencionP">
<xsl:apply-templates select="."/>
</xsl:for-each>
</xsl:template>
<xsl:template match="pago20:TrasladosP">
<xsl:for-each select="./pago20:TrasladoP">
<xsl:apply-templates select="."/>
</xsl:for-each>
</xsl:template>
<xsl:template match="pago20:RetencionP">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpuestoP"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImporteP"/>
</xsl:call-template>
</xsl:template>
<xsl:template match="pago20:TrasladoP">
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@BaseP"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@ImpuestoP"/>
</xsl:call-template>
<xsl:call-template name="Requerido">
<xsl:with-param name="valor" select="./@TipoFactorP"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@TasaOCuotaP"/>
</xsl:call-template>
<xsl:call-template name="Opcional">
<xsl:with-param name="valor" select="./@ImporteP"/>
</xsl:call-template>
</xsl:template>

  <!-- Aquí iniciamos el procesamiento de la cadena original con su | inicial y el terminador || -->
  <xsl:template match="/">|<xsl:apply-templates select="/cfdi:Comprobante"/>||</xsl:template>
  <!--  Aquí iniciamos el procesamiento de los datos incluidos en el comprobante -->
  <xsl:template match="cfdi:Comprobante">
    <!-- Iniciamos el tratamiento de los atributos de comprobante -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Version"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Serie"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Folio"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Fecha"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@FormaPago"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@NoCertificado"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@CondicionesDePago"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@SubTotal"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Descuento"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Moneda"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TipoCambio"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Total"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@TipoDeComprobante"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Exportacion"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@MetodoPago"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@LugarExpedicion"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Confirmacion"/>
    </xsl:call-template>
    <!--
		Llamadas para procesar al los sub nodos del comprobante
	-->
	<xsl:apply-templates select="./cfdi:InformacionGlobal"/>
    <xsl:apply-templates select="./cfdi:CfdiRelacionados"/>
    <xsl:apply-templates select="./cfdi:Emisor"/>
    <xsl:apply-templates select="./cfdi:Receptor"/>
    <xsl:apply-templates select="./cfdi:Conceptos"/>
    <xsl:apply-templates select="./cfdi:Impuestos"/>
    <xsl:for-each select="./cfdi:Complemento">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>
  
  <!-- Manejador de nodos tipo InformacionGlobal -->
  <xsl:template match="cfdi:InformacionGlobal">
    <!-- Iniciamos el tratamiento de los atributos del nodo tipo InformacionGlobal -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Periodicidad"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Meses"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Año"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Manejador de nodos tipo CFDIRelacionados -->
  <xsl:template match="cfdi:CfdiRelacionados">
    <!-- Iniciamos el tratamiento de los atributos del nodo tipo CFDIRelacionados -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@TipoRelacion"/>
    </xsl:call-template>
    <xsl:for-each select="./cfdi:CfdiRelacionado">
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@UUID"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <!-- Manejador de nodos tipo Emisor -->
  <xsl:template match="cfdi:Emisor">
    <!-- Iniciamos el tratamiento de los atributos del nodo tipo Emisor -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Rfc"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Nombre"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@RegimenFiscal"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@FacAtrAdquirente"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Manejador de nodos tipo Receptor -->
  <xsl:template match="cfdi:Receptor">
    <!-- Iniciamos el tratamiento de los atributos del nodo tipo Receptor -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Rfc"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Nombre"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@DomicilioFiscalReceptor"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@ResidenciaFiscal"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NumRegIdTrib"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@RegimenFiscalReceptor"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@UsoCFDI"/>
    </xsl:call-template>

  </xsl:template>

  <!-- Manejador de nodos tipo Conceptos -->
  <xsl:template match="cfdi:Conceptos">
    <!-- Llamada para procesar los distintos nodos tipo Concepto -->
    <xsl:for-each select="./cfdi:Concepto">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <!--Manejador de nodos tipo Concepto-->
  <xsl:template match="cfdi:Concepto">
    <!-- Iniciamos el tratamiento de los atributos del Concepto -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@ClaveProdServ"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NoIdentificacion"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Cantidad"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@ClaveUnidad"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Unidad"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Descripcion"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@ValorUnitario"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Importe"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Descuento"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@ObjetoImp"/>
    </xsl:call-template>

    <!-- Manejo de sub nodos de información Traslado de Conceptos:Concepto:Impuestos:Traslados-->
    <xsl:for-each select="./cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado">
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Base"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Impuesto"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@TipoFactor"/>
      </xsl:call-template>
      <xsl:call-template name="Opcional">
        <xsl:with-param name="valor" select="./@TasaOCuota"/>
      </xsl:call-template>
      <xsl:call-template name="Opcional">
        <xsl:with-param name="valor" select="./@Importe"/>
      </xsl:call-template>
    </xsl:for-each>

    <!-- Manejo de sub nodos de Retencion por cada una de los Conceptos:Concepto:Impuestos:Retenciones-->
    <xsl:for-each select="./cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion">
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Base"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Impuesto"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@TipoFactor"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@TasaOCuota"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Importe"/>
      </xsl:call-template>
    </xsl:for-each>

	<!-- Manejo de los distintos sub nodos a cuenta de terceros de forma indistinta a su grado de dependencia -->
    <xsl:for-each select="./cfdi:ACuentaTerceros">
      <xsl:apply-templates select="."/>
    </xsl:for-each>

    <!-- Manejo de los distintos sub nodos de información aduanera de forma indistinta a su grado de dependencia -->
    <xsl:for-each select="./cfdi:InformacionAduanera">
      <xsl:apply-templates select="."/>
    </xsl:for-each>

    <!-- Llamada al manejador de nodos de CuentaPredial en caso de existir -->
    <xsl:if test="./cfdi:CuentaPredial">
      <xsl:apply-templates select="./cfdi:CuentaPredial"/>
    </xsl:if>

    <!-- Llamada al manejador de nodos de ComplementoConcepto en caso de existir -->
    <xsl:if test="./cfdi:ComplementoConcepto">
      <xsl:apply-templates select="./cfdi:ComplementoConcepto"/>
    </xsl:if>

    <!-- Llamada al manejador de nodos de Parte en caso de existir -->
    <xsl:for-each select=".//cfdi:Parte">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>
  
  <!-- Manejador de nodos tipo ACuentaTerceros -->
  <xsl:template match="cfdi:ACuentaTerceros">
    <!-- Manejo de los atributos del nodo tipo ACuentaTerceros -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@RfcACuentaTerceros"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@NombreACuentaTerceros"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@RegimenFiscalACuentaTerceros"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@DomicilioFiscalACuentaTerceros"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Manejador de nodos tipo Información Aduanera -->
  <xsl:template match="cfdi:InformacionAduanera">
    <!-- Manejo de los atributos de la información aduanera -->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@NumeroPedimento"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Manejador de nodos tipo Información CuentaPredial -->
  <xsl:template match="cfdi:CuentaPredial">
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Numero"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Manejador de nodos tipo ComplementoConcepto -->
  <xsl:template match="cfdi:ComplementoConcepto">
    <xsl:for-each select="./*">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <!-- Manejador de nodos tipo Parte -->
  <xsl:template match="cfdi:Parte">
    <!-- Iniciamos el tratamiento de los atributos de Parte-->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@ClaveProdServ"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NoIdentificacion"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Cantidad"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Unidad"/>
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Descripcion"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@ValorUnitario"/>
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Importe"/>
    </xsl:call-template>

    <!-- Manejador de nodos tipo InformacionAduanera-->
    <xsl:for-each select=".//cfdi:InformacionAduanera">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <!-- Manejador de nodos tipo Complemento -->
  <xsl:template match="cfdi:Complemento">
    <xsl:for-each select="./*">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <!-- Manejador de nodos tipo Domicilio fiscal -->
  <xsl:template match="cfdi:Impuestos">
    <!-- Manejo de sub nodos de Retencion por cada una de los Impuestos:Retenciones-->
    <xsl:for-each select="./cfdi:Retenciones/cfdi:Retencion">
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Impuesto"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Importe"/>
      </xsl:call-template>
    </xsl:for-each>
    <!-- Iniciamos el tratamiento de los atributos de TotalImpuestosRetenidos-->
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TotalImpuestosRetenidos"/>
    </xsl:call-template>
    <!-- Manejo de sub nodos de información Traslado de Impuestos:Traslados-->
    <xsl:for-each select="./cfdi:Traslados/cfdi:Traslado">
	  <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Base"/>
      </xsl:call-template>      
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@Impuesto"/>
      </xsl:call-template>
      <xsl:call-template name="Requerido">
        <xsl:with-param name="valor" select="./@TipoFactor"/>
      </xsl:call-template>
      <xsl:call-template name="Opcional">
        <xsl:with-param name="valor" select="./@TasaOCuota"/>
      </xsl:call-template>
      <xsl:call-template name="Opcional">
        <xsl:with-param name="valor" select="./@Importe"/>
      </xsl:call-template>
    </xsl:for-each>
    <!-- Iniciamos el tratamiento de los atributos de TotalImpuestosTrasladados-->
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TotalImpuestosTrasladados"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>