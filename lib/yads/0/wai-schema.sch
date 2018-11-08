<?xml version="1.0" ?>
<!--
	Schematron schema for WAI
	http://www.ascc.net/xml/resource/schematron/wai.xml

	  2000/07/21 modified for XHTML 
             Dan Connolly, W3C http://www.w3.org/People/Connolly/
         
         2001/06/12 test namespaces 
  	     Rick Jelliffe, ricko@gate.sinica.edu.tw
	     Academia Sinica Computing Centre, Taipei, Taiwan

	Taken from http://www.w3.org/TR/1999/WAI-WEBCONTENT-19990505 

	For the Schematron validator, go to 
	http://www.ascc.net/xml/resource/schematron/schematron.html

       Note: in a context, the XSLT "|" is used to indicate or. In a 
       test, the XPath "or" is used. 

-->
<!--
Original Copyright (c) 2001 Rick Jelliffe, Topologi Pty/ Ltd 

 This software is provided 'as-is', without any express or implied warranty. 
 In no event will the authors be held liable for any damages arising from 
 the use of this software.

 Permission is granted to anyone to use this software for any purpose, 
 including commercial applications, and to alter it and redistribute it freely,
 subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not claim
 that you wrote the original software. If you use this software in a product, 
 an acknowledgment in the product documentation would be appreciated but is 
 not required.

 2. Altered source versions must be plainly marked as such, and must not be 
 misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.
-->
	
<schema
        xmlns="http://www.ascc.net/xml/schematron"
        ns="http://www.ascc.net/xml/resource/schematron/wai.xml"
        xmlns:h="http://www.w3.org/1999/xhtml"
>
  
          <title>Schema for Web Content Accessibility</title>
           <ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>

            <phase id="Namespaces">
                     <active  pattern="general" />
           </phase>
           <phase id="WAI"  >
                     <active  pattern="g1" />
                     <active  pattern="g2" />
                     <active   pattern="g3" />
                     <active   pattern="g4" />
                     <active   pattern="g5" />
                     <active   pattern="g6" />
                     <active   pattern="gx" />
                     <active   pattern="g12" />
                 </phase>
                   <pattern name="Namespace"  id="general">
                              <rule context="h:html"><assert test="1=1" /></rule>
                              <rule context="h:HTML">
                                   <report test="1=1" icon="saturn2.gif">Element names should be in lower case.
                                   This document uses uppercase for its HTML element.</report>
                              </rule>
                              <rule context="html" >
                                   <report test="1=1" icon="saturn2.gif">The html element of this document does
                                    not have a namespace declaration in effect.
                                    Try adding <emph>        xmlns="http://www.w3.org/1999/xhtml"</emph>.</report>
                              </rule>
                              <rule context="h:*"><assert test="1=1" /></rule>
                               <rule context="*">
                                   <report test="1=1" icon="saturn2.gif">This schema only deals with  XHTML elements.</report>
                               </rule>
                    </pattern>
         
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 1"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-provide-equivalents"
		fpi="+//IDN sinica.edu.tw/SGML Schema for WAI::Guideline 1//EN"
		id="g1">
		<rule context="h:img" >
			<assert  test="@alt  or  @longdesc" icon="ry1.gif">(1.1) An image element should have some descriptive text: an alt or longdesc attribute.</assert>
			<key name="imgkey" path="@alt" />
		</rule>
		<rule context="h:input">
			<assert test="@alt"  icon="ry1.gif">(1.1) An input element should have some descriptive text: an alt or longdesc attribute.</assert>
		</rule>
		<rule context="h:applet ">
			<assert test="@alt"  icon="ry1.gif">(1.1) An applet element should have some descriptive text: an alt or longdesc attribute.</assert>
		</rule>
		<rule context="h:map"  >
			<assert test="h:area/@alt  or  a "   icon="ry1.gif">(1.1) A map element should have some descriptive text: an alt attribute or a link.</assert>
		</rule>
		<rule context="h:object"   >
			<assert test="string-length(text()) &gt; 0"   icon="ry1.gif">(1.1) An object element should contain some descriptive text.</assert>
		</rule>
		<rule context="h:frame ">
			<assert test="@longdesc"   icon="ry1.gif">(1.1) A frame element should have some descriptive text: a longdesc attribute.</assert>
		</rule>
		
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 2"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-color"
                                        id="g2">
		<rule context="h:body[@color][@bgcolor]">
			<report role="samecolor" test="string(@bgcolor) = string(@color)"   icon="by1.gif">(2.2) The background color and the foreground color are the same</report>
			<!-- put specific color comparisons here -->
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 3"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-structure-presentation"
                                        id="g3">
		<rule context="h:b    | h:i ">
			<report test="self::*"  icon="by1.gif">(3.3) Concerning element <name />: B and I are not recommended. Use strong and em, or stylesheets.</report>
		</rule>
		<rule context="h:ul  | h:ol ">
			<assert test="//h:li"  icon="by1.gif">(3.3) A list should not be used for formatting effects</assert>
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 4"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-abbreviated-and-foreign"
                                       id="g4">
		<rule role="topdoc" context="h:html  ">
			<assert test="@lang  or  @xml:lang "  icon="Alien06.gif">(4.3) The primary language of a 
				document should be identified. </assert>
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 5"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/i#gl-table-markup"
                                         id="g5" >
		<rule context="h:table">
			<assert test="h:caption"  icon="swpk1.gif">(5.1) A table should have a caption</assert>
			<assert test="@summary "  icon="swpk1.gif">(5.5) A table should have a summary attribute </assert>
		</rule>
		<rule context="h:td">
			<assert test="@scope  or  @headers  or  @axis  "  icon="ry1.gif">(5.2) Table data should identify 
			its scope, headers, axis in attributes.</assert>
		</rule>
		<rule context="h:th">
			<assert test="@abbr"  icon="swpk1.gif">(5.6) A table header should have an abbr attribute to give abbreviation</assert>
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 6"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-new-technologies"  
                                        id="g6">
		<rule context="*[@onmouseup]">
			<assert test="@onkeyup"  icon="ry1.gif">(6.4) If you specify an "onmouseup" attribute
			on a <name /> element,
			you should also specify an "onkeyup" attribute</assert> 
		</rule>
		<rule context="*[@onmousedown]">
			<assert test="@onkeydown"  icon="ry1.gif">(6.4) If you specify an "onmousedown" 
			attribute on a <name /> element,
			you should also specify an "onkeydown" attribute</assert> 
		</rule>
		<rule context="*[@onclick]">
			<assert test="@onkeypress"  icon="ry1.gif">(6.4) If you specify an "onclick" 
			event on a <name /> element,
			you should also specify an "onkeypress"</assert> 
		</rule>
		<rule context="*[local-name='marquee'] ">
			<assert test="*"  icon="Alien06.gif">(6.5) The marquee element is not good HTML</assert>
		</rule>
		<rule context="*[local-name='blink'] ">
			<assert test="*"  icon="Alian06.gif">(6.5) The blink element is not good HTML</assert>
		</rule>
		<rule context="h:frame ">
			<report test="contains(@src, '.gif')
				 or 	contains(string(@src), '.GIF')  
				 or  contains(string(@src), '.jpg')  or contains(string(@src), '.JPG') 
				 or  contains(string(@src), '.jpeg')  or contains(string(@src), '.JPEG') 
				 or  contains(string(@src), '.png')  or contains(string(@src), '.PNG') "  icon="ry1.gif">
				(6.2) A frame should not be a direct image</report>
			<assert test="../h:noframes">(6.5) If you specify a frame, also specify a
			noframes element.</assert>
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 7"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-movement"
                                        id="g7">
		<rule context="h:meta  ">
			<report test="@http-equiv = 'refresh'"  icon="by1.gif">(7.1) The 
			user should control the refreshing of the page</report>
		</rule>
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline ?"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/"
                                        id="gx">
		<rule context="h:fieldset ">
			<assert test="h:legend"  icon="by1.gif">(?) A fieldset should have a legend</assert>
	     	</rule>	
	</pattern>
	<pattern name="Web Content Accessibility Guidelines 1.0, Guideline 12"
		see="http://www.w3.org/TR/WAI-WEBCONTENT/#gl-complex-elements" 
                                       id="g12" >
		<rule context="h:frameset ">
			<assert test="@title"  icon="by1.gif">(12.1) A frameset should have a title</assert>
	     	</rule>	
	</pattern>
</schema>
