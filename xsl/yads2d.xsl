<?xml version="1.0"?> 
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:saxon="http://icl.com/saxon"
               xmlns:xalan="org.apache.xalan.xslt.extensions.Redirect"
               extension-element-prefixes="saxon xalan"
               version="1.0">

<!--
  //yads2d.xsl

  Stylesheet to transform an XML document conforming to the YADS
  generic XML Schema to a text dump representation.

  Each description is mapped to a  text dump representation and is
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

-->

<xsl:output method="text"/>
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
        <xsl:apply-templates select="//yads"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="//comment()">
    <xsl:if test="$comments!=0">
      <xsl:variable name="comment">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:variable name="indent">
      <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)"/>
      </xsl:variable>
      <xsl:call-template name="indent">
        <xsl:with-param name="indent" select="$indent"/>
      </xsl:call-template>
    <xsl:text># </xsl:text> 
    <xsl:call-template name="replace-substring">
      <xsl:with-param name="original" select="$comment"/>
      <xsl:with-param name="substring" select="$nl"/>
      <xsl:with-param name="replacement" select="concat($nl,'# ')"/>
    </xsl:call-template>
    <xsl:value-of select="$nl"/> 
  </xsl:if>
</xsl:template>

<!--
  Match <yads> elements - set up output file based on sequence number
  if "split" parameter set
-->
  <xsl:template match="yads">
    <xsl:variable name="doi" select="./resource"/>
    <xsl:variable name="file" select="concat('yads_', position(), '.d')"/>
    <xsl:choose>
      <xsl:when test="$split='saxon'">
        <saxon:output href="{$file}">
          <xsl:value-of select="$nl"/>
          <xsl:call-template name="description"/>
        </saxon:output>
      </xsl:when>
      <xsl:when test="$split='xalan'">
        <xalan:write select="$file">
          <xsl:value-of select="$nl"/>
          <xsl:call-template name="description"/>
        </xalan:write>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- -->
  <xsl:template name="description">
    <xsl:variable name="resource" select="nest/resource"/>
      <xsl:apply-templates/>
  </xsl:template>

<!--
  Match <collection> elements - test the "order" attribute to select
  the appropriate RDF container element
-->
  <xsl:template match="collection">
    <xsl:variable name="order" select="@order"/>
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)-1"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="$order='choice'"><xsl:text/>&#x3c;</xsl:when>
      <xsl:when test="$order='sequenced'"><xsl:text>[</xsl:text></xsl:when>
      <xsl:when test="$order='unordered'"><xsl:text>{</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>{</xsl:text></xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$nl"/>
    <xsl:apply-templates/>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="$order='choice'"><xsl:text/>&#x3e;</xsl:when>
      <xsl:when test="$order='sequenced'"><xsl:text>]</xsl:text></xsl:when>
      <xsl:when test="$order='unordered'"><xsl:text>}</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>}</xsl:text></xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$nl"/>
  </xsl:template>

  <xsl:template name="indent">
    <xsl:param name="indent"/>
    <xsl:variable name="random-nodes" select="document('')//node()"/>
    <xsl:for-each select="$random-nodes[position() &lt;= $indent]">
       <xsl:text>  </xsl:text>
    </xsl:for-each>
  </xsl:template>

<!--
  Match <nest> elements
-->
  <xsl:template match="nest">
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)-1"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>(*</xsl:text><xsl:value-of select="$nl"/>
      <xsl:apply-templates/>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>*)</xsl:text><xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match <item> elements
-->
  <xsl:template match="item">
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)-1"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>(</xsl:text><xsl:value-of select="$nl"/>
      <xsl:apply-templates/>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>)</xsl:text><xsl:value-of select="$nl"/>
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
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>resource =&#x3e; &#x3c;</xsl:text>
    <xsl:value-of select="$resource"/>
    <xsl:text>&#x3e;</xsl:text>
    <xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match literal property elements
-->
  <xsl:template match="access|detail|directive|label|role|service|type">
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:value-of select="name(.)"/>
    <xsl:text> =&#x3e; "</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$nl"/>
  </xsl:template>

<!--
  Match <property> elements - promote "type" attribute to appropriate
  YADS property element
-->
  <xsl:template match="property">
    <xsl:variable name="indent">
    <xsl:value-of select="count(ancestor-or-self::collection|ancestor-or-self::nest|ancestor-or-self::item)"/>
    </xsl:variable>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>property =&#x3e; </xsl:text>
    <xsl:text>(</xsl:text><xsl:value-of select="$nl"/>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent+1"/>
    </xsl:call-template>

        <xsl:text>literal =&#x3e; "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$nl"/>
<!--
    <xsl:choose>
      <xsl:when test="starts-with(., 'http:')">
        <xsl:variable name="resource" select="."/>
        <xsl:call-template name="_resource">
          <xsl:with-param name="resource" select="$resource"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>literal =&#x3e; "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$nl"/>
      </xsl:otherwise>
    </xsl:choose>
-->
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent+1"/>
    </xsl:call-template>
    <xsl:text>type =&#x3e; "</xsl:text>
    <xsl:value-of select="@type"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$nl"/>
    <xsl:call-template name="indent">
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
    <xsl:text>)</xsl:text><xsl:value-of select="$nl"/>
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
