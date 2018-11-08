<?xml version="1.0"?> 
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xrf="http://www.crossref.org/schema_2.0.4#"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:has="doi:1014/yads-schema-2002-04-03#"
               xmlns:isa="doi:1014/yads-schema-2002-04-03#"
               xmlns:saxon="http://icl.com/saxon"
               xmlns:xalan="org.apache.xalan.xslt.extensions.Redirect"
               extension-element-prefixes="saxon xalan"
               exclude-result-prefixes="xrf"
               version="1.0">

<!--
  //yads2rdf.xsl

  Stylesheet to transform an XML document conforming to the YADS
  generic XML Schema to an RDF/XML representation.

  Each description is mapped to an RDF/XML representation and is
  written to a common output or if the parameter "split" is set
  is written to its own output file. XSLT 1.0 does not support
  multiple outputs so we need to take advantage of vendor-specific
  extensions. Two processors are supported: Saxon and Xalan.

  This transform can be run with two parameters:

    split       - write descriptions to separate files (set value
                  for specific processor: "saxon" or "xalan")

    comments    - copy comments (if non-zero)

  Author: Tony Hammond <mailto:tony_hammond@harcourt.com>
  Date:   2002.03.27

  Copyright (c) 2002 Elsevier Science Ltd. All rights reserved.
-->

<xsl:output method="xml" version="1.0" indent="no"/>
<xsl:strip-space elements="*"/>

<!-- Split output across multiple files if parameter set -->
<xsl:param name="split"/>

<!-- Copy comments if non-zero -->
<xsl:param name="comments" select="1"/>

<!-- Set up a global to emit a newline -->
<xsl:variable name="nl" select="'&#x0a;'"/>

<!--
  Match root element - only process <nest> descendants
-->
  <xsl:template match="/">
    <xsl:apply-templates select="/comment()"/>
    <xsl:choose>
      <xsl:when test="$split">
        <xsl:apply-templates select="//yads"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nl"/>
        <rdf:RDF
          xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
          xmlns:has="doi:1014/yads-schema-2002-04-03#"
          xmlns:isa="doi:1014/yads-schema-2002-04-03#"
        ><xsl:value-of select="$nl"/> 
          <xsl:apply-templates select="//yads"/>
        </rdf:RDF><xsl:value-of select="$nl"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template match="//comment()">
  <xsl:if test="$comments!=0">
    <xsl:copy>
      <xsl:apply-templates select="comment()"/>
    </xsl:copy>
    <xsl:value-of select="$nl"/> 
  </xsl:if>
</xsl:template>

<!--
  Match <yads> elements - set up output file based on sequence number
  if "split" parameter set
-->
  <xsl:template match="yads">
    <xsl:variable name="doi" select="./resource"/>
    <xsl:variable name="file" select="concat('yads_', position(), '.rdf')"/>
    <xsl:choose>
      <xsl:when test="$split = 'saxon'">
        <saxon:output href="{$file}">
          <xsl:value-of select="$nl"/>
          <rdf:RDF
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:has="doi:1014/yads-schema-2002-04-03#"
            xmlns:isa="doi:1014/yads-schema-2002-04-03#"
          ><xsl:value-of select="$nl"/> 
            <xsl:call-template name="description"/>
          </rdf:RDF><xsl:value-of select="$nl"/>
        </saxon:output>
      </xsl:when>
      <xsl:when test="$split = 'xalan'">
        <xalan:write select="$file">
          <xsl:value-of select="$nl"/>
          <rdf:RDF
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:has="doi:1014/yads-schema-2002-04-03#"
            xmlns:isa="doi:1014/yads-schema-2002-04-03#"
          ><xsl:value-of select="$nl"/> 
            <xsl:call-template name="description"/>
          </rdf:RDF><xsl:value-of select="$nl"/>
        </xalan:write>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- -->
  <xsl:template name="description">
    <rdf:Description rdf:about=""><xsl:value-of select="$nl"/>
      <xsl:apply-templates/>
    </rdf:Description><xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match <collection> elements - test the "order" attribute to select
  the appropriate RDF container element
-->
  <xsl:template match="collection">
    <xsl:variable name="order" select="@order"/>
    <xsl:variable name="container">
      <xsl:choose>
        <xsl:when test="$order='choice'">rdf:Alt</xsl:when>
        <xsl:when test="$order='unordered'">rdf:Bag</xsl:when>
        <xsl:when test="$order='sequenced'">rdf:Seq</xsl:when>
        <xsl:otherwise>rdf:Bag</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <has:collection><xsl:value-of select="$nl"/>
      <xsl:element name="{$container}"><xsl:value-of select="$nl"/>
        <xsl:apply-templates/>
      </xsl:element><xsl:value-of select="$nl"/>
    </has:collection><xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match <nest> elements
-->
  <xsl:template match="nest">
    <xsl:choose>
      <xsl:when test="name(..)='collection'">
        <rdf:li rdf:parseType="Resource"><xsl:value-of select="$nl"/>
          <rdf:type>isa:Nest</rdf:type><xsl:value-of select="$nl"/>
            <xsl:apply-templates/>
        </rdf:li><xsl:value-of select="$nl"/>
      </xsl:when>
      <xsl:otherwise>
          <rdf:type>isa:Nest</rdf:type><xsl:value-of select="$nl"/>
            <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  Match <item> elements
-->
  <xsl:template match="item">
    <xsl:choose>
      <xsl:when test="name(..)='collection'">
        <rdf:li rdf:parseType="Resource"><xsl:value-of select="$nl"/>
          <rdf:type>isa:Item</rdf:type><xsl:value-of select="$nl"/>
            <xsl:apply-templates/>
        </rdf:li><xsl:value-of select="$nl"/>
      </xsl:when>
      <xsl:otherwise>
          <rdf:type>isa:Item</rdf:type><xsl:value-of select="$nl"/>
            <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  Match <data> elements - convert to YADS resource element
-->
  <xsl:template match="data">
    <xsl:variable name="data">
      <xsl:call-template name="data-uri">
        <xsl:with-param name="data" select="."/>
      </xsl:call-template>
    </xsl:variable>
      <xsl:call-template name="_resource">
        <xsl:with-param name="resource" select="$data"/>
      </xsl:call-template>
  </xsl:template>

<!--
  Template with minimal treatment for converting a <data> element
  to a URI of scheme "data:". Basically this just prepends a
  string "data:," and hex escapes any spaces. Obviously a more 
  complete hex excaping is required.
-->
  <xsl:template name="data-uri">
    <xsl:param name="data"/>
    <xsl:text>data:,</xsl:text>
    <xsl:choose>
      <xsl:when test="contains($data, ' ')">
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="original" select="$data"/>
          <xsl:with-param name="substring" select="' '"/>
          <xsl:with-param name="replacement" select="'%20'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  Match <resource> elements - convert to YADS resource element
-->
  <xsl:template match="resource">
    <xsl:variable name="resource" select="."/>
    <xsl:call-template name="_resource">
      <xsl:with-param name="resource" select="$resource"/>
    </xsl:call-template>
  </xsl:template>

<!--
  Common template for handling <data> and <resource> elements
-->
  <xsl:template name="_resource">
    <xsl:param name="resource"/>
    <has:resource rdf:resource="{$resource}"/>
    <xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match <property> elements - promote "type" attribute to appropriate
  YADS property element
-->
  <xsl:template match="property">
    <xsl:element name="{concat('has:', @type)}">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
    <xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Utility template for replacing substrings
-->
  <xsl:template name="replace-substring">
    <xsl:param name="original"/>
    <xsl:param name="substring"/>
    <xsl:param name="replacement" select="''"/>
    <xsl:variable name="first">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="substring-before($original, $substring)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$original"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="middle">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="$replacement"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="last">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:choose>
            <xsl:when test="contains(substring-after($original, $substring), $substring)">
              <xsl:call-template name="replace-substring">
                <xsl:with-param name="original"><xsl:value-of select="substring-after($original, $substring)"/></xsl:with-param>
                <xsl:with-param name="substring"><xsl:value-of select="$substring"/></xsl:with-param>
                <xsl:with-param name="replacement"><xsl:value-of select="$replacement"/></xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring-after($original, $substring)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat($first, $middle, $last)"/>
  </xsl:template>

</xsl:transform>
