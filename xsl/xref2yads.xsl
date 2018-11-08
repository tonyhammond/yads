<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               version="1.0">

<!--
  //xref2yads.xsl

  Simple stylesheet to transform an XML document conforming to the
  CrossRef XML Schema (2.0.4) to a YADS - a Description Service -
  XML representation. All <doi_data> elements are selected and
  processed for the DOI (<doi> element) and associated resource
  collection (either toplevel <resource> for single resolution or
  toplevel <collection> for multiple resolution).

  This transform can be run with one parameter:

    profile     - add application profile (if non-zero)

  Author: Tony Hammond <mailto:tony_hammond@harcourt.com>
  Date:   2002.03.27

  Copyright (c) 2002 Elsevier Science Ltd. All rights reserved.
-->

<xsl:output method="xml" version="1.0" indent="no"/>
<!--<xsl:strip-space elements="*"/>-->

<!-- Add in application profile resource if non-zero -->
<xsl:param name="profile" select="0"/>

<!-- Set up a global to emit a newline -->
<xsl:variable name="nl" select="'&#x0a;'"/>

<xsl:template match="/">
  <yads><xsl:value-of select="$nl"/>
    <xsl:apply-templates/>
  </yads><xsl:value-of select="$nl"/>
</xsl:template>

<xsl:template match="doi_data//*|@*|text()|comment()">
  <xsl:if test="descendant-or-self::doi_data">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|comment()"/>
    </xsl:copy>
  </xsl:if>
</xsl:template>

<xsl:template match="doi_data">
  <nest><xsl:value-of select="$nl"/>
    <resource>
      <xsl:text>doi:</xsl:text><xsl:value-of select="doi"/>
    </resource>
    <xsl:choose>
      <xsl:when test="$profile!=0">
        <collection><xsl:value-of select="$nl"/>
            <item><xsl:value-of select="$nl"/>
              <resource>doi:10.0/profile.crossref</resource>
              <xsl:value-of select="$nl"/>
              <property type="type">doi:Profile</property>
              <xsl:value-of select="$nl"/>
            </item><xsl:value-of select="$nl"/>
            <item><xsl:value-of select="$nl"/>
              <xsl:apply-templates/>
            </item><xsl:value-of select="$nl"/>
        </collection><xsl:value-of select="$nl"/>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </nest><xsl:value-of select="$nl"/>
</xsl:template>

<xsl:template match="doi"/>

</xsl:transform> 
