<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fb2="http://www.gribuser.ru/xml/fictionbook/2.0">

  <xsl:template match="/fb2:FictionBook">
    <xsl:for-each select="fb2:body/fb2:section">
      <xsl:variable name="title" select="fb2:title/fb2:p/text()" />
      <xsl:variable name="booktitle" select="/fb2:FictionBook/fb2:description/fb2:title-info/fb2:book-title" />
      <xsl:message>
        <xsl:value-of select="$title" />
      </xsl:message>
      <xsl:result-document method="xml" indent="yes" encoding="UTF-8" href="{$booktitle}/{substring(concat('0', position()), string-length(string(position())) )} {$title}.fb2">
        <fb2:FictionBook>
          <xsl:copy-of select="/fb2:FictionBook/@*" />
          <fb2:description>
            <xsl:copy-of select="/fb2:FictionBook/fb2:description/fb2:title-info" />
            <fb2:document-info>
              <xsl:copy-of select="/fb2:FictionBook/fb2:description/fb2:document-info/fb2:author" />
              <fb2:date>
                <xsl:attribute name="value">
                  <xsl:value-of select="current-date()"/>
                </xsl:attribute>
                <xsl:value-of select="current-date()"/>
              </fb2:date>
              <fb2:id>
                <xsl:value-of select="current-dateTime()"/>
              </fb2:id>
              <xsl:copy-of select="/fb2:FictionBook/fb2:description/fb2:document-info/fb2:version" />
            </fb2:document-info>
          </fb2:description>
          <fb2:body>
            <xsl:copy-of select="./*" />
          </fb2:body>
        </fb2:FictionBook>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>