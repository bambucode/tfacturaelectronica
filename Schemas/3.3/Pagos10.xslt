﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:pago10="http://www.sat.gob.mx/Pagos">

  <xsl:template match="pago10:Pagos">
    <!--Manejador de Atributos Pagos-->
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Version" />
    </xsl:call-template>

    <!--  Iniciamos el manejo de los elementos hijo en la secuencia -->
    <xsl:for-each select="./pago10:Pago">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="pago10:Pago">
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@FechaPago" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@FormaDePagoP" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@MonedaP" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TipoCambioP" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Monto" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NumOperacion" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@RfcEmisorCtaOrd" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NomBancoOrdExt" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@CtaOrdenante" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@RfcEmisorCtaBen" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@CtaBeneficiario" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TipoCadPago" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@CertPago" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@CadPago" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@SelloPago" />
    </xsl:call-template>

    <!--  Iniciamos el tratamiento de los atributos de pago10:DocumentoRelacionado-->
    <xsl:for-each select="./pago10:DoctoRelacionado">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
    <xsl:for-each select="./pago10:Impuestos">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="pago10:DoctoRelacionado">

    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@IdDocumento" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Serie" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@Folio" />
    </xsl:call-template>

    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@MonedaDR" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TipoCambioDR" />
    </xsl:call-template>

    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@MetodoDePagoDR" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@NumParcialidad" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@ImpSaldoAnt" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@ImpPagado" />
    </xsl:call-template>

    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@ImpSaldoInsoluto" />
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="pago10:Impuestos">
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TotalImpuestosRetenidos" />
    </xsl:call-template>
    <xsl:call-template name="Opcional">
      <xsl:with-param name="valor" select="./@TotalImpuestosTrasladados" />
    </xsl:call-template>

    <xsl:apply-templates select="./pago10:Retenciones"/>
    <xsl:apply-templates select="./pago10:Traslados"/>

  </xsl:template>

  <xsl:template match="pago10:Retenciones">
    <xsl:for-each select="./pago10:Retencion">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="pago10:Traslados">
    <xsl:for-each select="./pago10:Traslado">
      <xsl:apply-templates select="."/>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="pago10:Retencion">
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Impuesto" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Importe" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="pago10:Traslado">
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Impuesto" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@TipoFactor" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@TasaOCuota" />
    </xsl:call-template>
    <xsl:call-template name="Requerido">
      <xsl:with-param name="valor" select="./@Importe" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>