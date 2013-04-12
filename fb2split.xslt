<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.gribuser.ru/xml/fictionbook/2.0">

  <xsl:template match="/FictionBook">
    <xsl:for-each select="body/section">
      <xsl:variable name="title" select="title/p/text()" />
      <xsl:variable name="booktitle" select="/FictionBook/description/title-info/book-title" />
      <xsl:message>
        <xsl:value-of select="$title" />
      </xsl:message>
      <xsl:result-document method="xml" indent="yes" encoding="UTF-8" href="{$booktitle}/{substring(concat('0', position()), string-length(string(position())) )} {$title}.fb2">
        <FictionBook>
          <xsl:copy-of select="/FictionBook/@*" />
          <description>
            <xsl:copy-of select="/FictionBook/description/title-info" />
            <document-info>
              <xsl:copy-of select="/FictionBook/description/document-info/author" />
              <date>
                <xsl:attribute name="value">
                  <xsl:value-of select="current-date()"/>
                </xsl:attribute>
                <xsl:value-of select="current-date()"/>
              </date>
              <id>
                <xsl:value-of select="current-dateTime()"/>
              </id>
              <xsl:copy-of select="/FictionBook/description/document-info/version" />
            </document-info>
          </description>
          <body>
            <xsl:copy-of select="./*" />
          </body>
        </FictionBook>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>