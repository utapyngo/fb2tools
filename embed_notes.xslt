<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:l="http://www.w3.org/1999/xlink"
  xmlns="http://www.gribuser.ru/xml/fictionbook/2.0"
  xpath-default-namespace="http://www.gribuser.ru/xml/fictionbook/2.0">

  <xsl:key name="note" match="//p[@id]" use="encode-for-uri( @id )" />

  <xsl:template match="*|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="smalltext">
    <sup><sub><xsl:value-of select="text()"/></sub></sup>
  </xsl:template>

  <xsl:template match="//a[@type='note']">
    <xsl:variable name="ref" select="substring( @l:href, 2 )"/>
    <xsl:choose>
      <xsl:when test="key('note', $ref )">
        <xsl:for-each select="key('note', $ref )">
          <xsl:call-template name="smalltext"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="key( 'note', encode-for-uri( $ref ) )">
        <xsl:for-each select="key( 'note', encode-for-uri( $ref ) )">
          <xsl:call-template name="smalltext"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:value-of select="@l:href"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
