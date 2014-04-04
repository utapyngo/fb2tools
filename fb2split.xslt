<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:l="http://www.w3.org/1999/xlink"
  xmlns="http://www.gribuser.ru/xml/fictionbook/2.0"
  xpath-default-namespace="http://www.gribuser.ru/xml/fictionbook/2.0">

  <xsl:variable name="num-sections" select="count(/FictionBook/body/section)" />

  <xsl:template match="*|@*">
    <xsl:param name="title" />
    <xsl:copy>
      <xsl:apply-templates select="node()|@*">
        <xsl:with-param name="title" select="$title" />
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/FictionBook/description/document-info/date">
    <date>
      <xsl:attribute name="value">
        <xsl:value-of select="current-date()"/>
      </xsl:attribute>
      <xsl:value-of select="current-date()"/>
    </date>
  </xsl:template>

  <xsl:template match="/FictionBook/description/document-info/id">
    <id>
      <xsl:value-of select="current-dateTime()"/>
    </id>
  </xsl:template>

  <xsl:template match="/FictionBook/description/title-info/annotation">
  </xsl:template>

  <xsl:template match="/FictionBook/description/title-info/book-title">
    <xsl:param name="title" />
    <book-title>
      <xsl:value-of select="$title" />
    </book-title>
  </xsl:template>

  <xsl:template name="description">
    <xsl:param name="title" />
    <xsl:apply-templates select="/FictionBook/description">
      <xsl:with-param name="title" select="$title" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="/FictionBook/body/section">
    <xsl:choose>
      <xsl:when test="$num-sections > 1">
        <xsl:variable name="title" select="if (title/*/*/text()) then title/*/*/text() else title/*/text()" />
        <xsl:variable name="title-escaped" select="translate($title, '&quot;:?\/*|&lt;&gt;', '')" />
        <xsl:variable name="booktitle" select="/FictionBook/description/title-info/book-title" />
        <xsl:variable name="index"><xsl:number/></xsl:variable>
        <xsl:variable name="padded-index" select="format-number($index, substring('0000000', 1, string-length(string($num-sections))))"/>
        <xsl:message>
          <xsl:value-of select="$title" />
        </xsl:message>
        <xsl:result-document method="xml" indent="yes" encoding="UTF-8" href="{$booktitle}/{$padded-index} {$title-escaped}.fb2">
          <FictionBook>
            <xsl:call-template name="description">
              <xsl:with-param name="title" select="$title" />
            </xsl:call-template>
            <body>
              <xsl:choose>
                <xsl:when test="section">
                  <xsl:copy-of select="./*" copy-namespaces="no" />
                </xsl:when>
                <xsl:otherwise>
                  <section>
                    <xsl:copy-of select="./*" copy-namespaces="no" />
                  </section>
                </xsl:otherwise>
              </xsl:choose>
            </body>
          </FictionBook>
        </xsl:result-document>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Nothing to split. There is only one section in this file.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>