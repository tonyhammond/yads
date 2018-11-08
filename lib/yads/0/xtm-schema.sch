<?xml version="1.0" encoding="UTF-8"?>
<!--

Copyright (c) 2001 Rick Jelliffe, Topologi Pty/ Ltd 



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


<schema xmlns="http://www.ascc.net/xml/schematron"
	xml:lang="en"  
	schemaVersion="2001/06/12"  
	icon="http://www.topicmaps.org/logos/xtm-logo-80.gif"
>

<title>XML Topic Maps</title>


	<ns prefix="xtm" uri="http://www.topicMaps.org/xtm/1.0/" />
	<ns prefix="xlink" uri="http://www.w3.org/1999/xlink" />

	
	<pattern name="Elements"
		see="http://www.topicmaps.org/xtm/1.0/">
		<rule context="xtm:topicMap">
			<assert test="count(*) = count(xtm:topic) + count(xtm:association) + count(xtm:mergeMap)"
			>A <name/> should contain only the following elements: topic, association and mergeMap.</assert>
		</rule>
		<rule context="xtm:topic">
			<assert test="count(*) = count(xtm:instanceOf) + count(xtm:subjectIdentity) + count(xtm:baseName) + count(xtm:occurrence)"
			>A <name/> should contain only the following elements: instanceOf, subjectIdentity, baseName and occurrence.</assert>
			<assert test="string-length(normalize-space(@id)) &gt; 0"
			>A <name/> element must have an id attribute.</assert>
			<assert test="count(xtm:subjectIdentity) &lt; 2"
			>The <name/> element should have at most one subjectIdentity.</assert>
			<report test="xtm:subjectIdentity[following-sibling::xtm:instanceOf]
			  or xtm:baseName[following-sibling::xtm:instanceOf]
			  or xtm:occurrence[following-sibling::xtm:instanceOf] "
			>The instanceOf element should come before any others.</report>
			<report test="xtm:baseName[following-sibling::xtm:subjectIdentity]
			  or xtm:occurrence[following-sibling::xtm:subjectIdentity]"
			>The subjectIdentity element should come before any baseName or occurrence elements.</report>
		</rule>
		<rule context="xtm:association">
			<assert test="count(*) = count(xtm:instanceOf) + count(xtm:scope) + count(xtm:member)"
			>A <name/> should contain only the following elements: instanceOf, scope and member.</assert>
			<assert test="count(xtm:instanceOf) &lt; 2"
			>The <name/> element should have at most one instanceOf.</assert>
			<assert test="count(xtm:scope) &lt; 2"
			>The <name/> element should have at most one scope.</assert>
			<report test="xtm:scope[following-sibling::xtm:instanceOf]
			  or xtm:member[following-sibling::xtm:instanceOf]"
			>The instanceOf element should come before any scope or member elements.</report>
			<report test="xtm:member[following-sibling::xtm:scope]"
			>The scope element should come before any member elements.</report>
		</rule>
		<rule context="xtm:member">
		<assert test="count(*) = count(xtm:roleSpec) + count(xtm:topicRef) + count(xtm:resourceRef) + subjectIndictorRef"
			>A <name/> should contain only the following elements: roleSpec, topicRef, resourceRef, subjectIndicatorRef.</assert>
			<assert test="count(xtm:roleSpec) &lt; 2"
			>The <name/> element should have at most one roleSpec.</assert>
			<report test="xtm:resourceRef[following-sibling::xtm:roleSpec]
			  or xtm:topicRef[following-sibling::xtm:roleSpec]
			  or xtm:subjectIndicatorRef[following-sibling::xtm:roleSpec]"
			>The rolespec element should come before any <name/> elements.</report>
		</rule>
		<rule context="xtm:mergeMap" >
			<assert test="@xlink:href"
			>A <name/> element is a simple XLink, and should have a xlink:href attribute.
			</assert>
			<assert test="count(*) = count(xtm:topicRef) + count(xtm:resourceRef) + count(xtm:subjectIndicatorRef)"
			>A <name/> should contain only the following elements: topicRef, resourceRef, subjectIndicatorRef.</assert>
			<assert test="count(*)&gt; 0"
			>A <name/> element should have at least one child.</assert>
		</rule>
		<rule context="xtm:instanceOf | xtm:roleSpec">
			<assert test="count(*) =1"
			>The <name/> element should only have a single child.</assert>
			<assert test="xtm:topicRef or xtm:subjectIndicatorRef"
			>The <name/> element should contain a topicRef or a subjectIndicatorRef.</assert>
		</rule>
		<rule context="xtm:subjectIdentity">
			<assert test="count(xtm:resourceRef) &lt; 2"
			>The <name/> element should have at most one resourceRef.</assert>
			<assert test="xtm:resourceRef or xtm:subjectIndicatorRef or xtm:topicRef"
			>The <name/> element should contain, after an optional resourceRef, some topicRef and subjectIndicatorRef.</assert>
			<assert test="not(xtm:resourceRef) or *[1][self::xtm:resourceRef]"
			>A resourceRef, if used, should be the first child of <name /></assert>
		</rule>
		<rule context="xtm:baseName">
			<assert test="count(*) = count(xtm:scope) + count(xtm:baseNameString) + count(xtm:variant)"
			>A <name/> should contain only the following elements: scope, baseNameString and variant.</assert>
			<assert test="count(xtm:baseNameString)=1"
			>A <name/> should have one baseNameString element.</assert>
			<report test="xtm:baseNameString[following-sibling::xtm:scope]
			  or xtm:variant[following-sibling::xtm:scope]"
			>In a baseName, the scope element should come before any baseNameString or variant elements.</report>
			<report test="xtm:variant[following-sibling::xtm:baseNameString]"
			>In a baseName, any variant elements should come after the baseNameString element.</report>
		</rule>
		
		<rule context="xtm:baseNameString">
			<assert test="count(*)=0"
			>A <name/> should have no element content, just a string .</assert>
		</rule>

		<rule context="xtm:scope">
			<assert test="count(*) = count(xtm:topicRef) + count(xtm:resourceRef) + count(xtm:subjectIndicatorRef)"
			>A <name/> should contain only the following elements: topicRef, resourceRef, subjectIndicatorRef.</assert>
			<assert test="count(*)&gt; 0"
			>A <name/> element should have at least one child.</assert>
		</rule>
		<rule context="xtm:variant ">
			<assert test="count(*) = count(xtm:parameters) + count(xtm:variantName) + count(xtm:variant)"
			>A <name/> should contain only the following elements: parameters, variantName, variant.</assert>
			<assert test="count(xtm:parameters) = 1"
			>A <name/> element should start with  one parameters element.</assert>
			<assert test="*[1][self::xtm:parameters]"
			>A <name/> element should start with a parameters element.</assert>
			<assert test="count(xtm:variantName) &lt; 2"
			>A <name/> element can only have one variantName.</assert>
			<assert test="not(xtm:variantName) or xtm:variantName[preceding-sibling::xtm:parameters]"
			>In a <name/>, the variantName must directly follow the parameters element.</assert>
		</rule>
		<rule context="xtm:parameters ">
			<assert test="count(*) = count(xtm:topicRef) + count(xtm:subjectIndicatorRef)"
			>A <name/> should contain only the following elements: topicRef, subjectIndicatorRef.</assert>
			<assert test="count(*) &gt; 0" 
			>A <name/> element must have at least one topicRef or subjectIndicatorRef</assert>
		</rule>
		<rule context="xtm:variantName ">
			<assert test="count(*) = count(xtm:resourceRef) + count(xtm:resourceData) "
			>A <name/> should contain only the following elements: resourceRef, resourceData.</assert>
			<assert test="count(*) =1" 
			>A variantName can only have a single child (either resourceRef or resourceData).</assert>
		</rule>
		<rule context="xtm:resourceData ">
			<assert test="count(*)=0"
			>A <name/> should be empty.</assert>
		</rule>
		<rule context="xtm:occurrence ">
			<assert test="count(*) = count(xtm:instanceOf) + count(xtm:scope) + count(xtm:resourceRef) + count(xtm:resourceData)"
			>A <name/> should contain only the following elements: instanceOf, scope, resourceRef and resourceData.</assert>
			<assert test="count(xtm:instanceOf) &lt; 2"
			>The <name/> element should have at most one instanceOf.</assert>
			<assert test="count(xtm:scope) &lt; 2"
			>The <name/> element should have at most one scope.</assert>
			<assert test="count(xtm:resourceRef) + count(xtm:resourceData) &lt; 2"
			>The <name/> element should have a resourceRef or a resourceData attribute.</assert>
			<report test="xtm:scope[following-sibling::xtm:instanceOf] "
			>The scope element should come after the instanceOf element.</report>
			<report test="xtm:resourceData[following-sibling::xtm:instanceOf]
			  or xtm:resourceRef[following-sibling::xtm:instanceOf]"
			>The instanceOf element should come before the resourceRef or resourceData element.</report>
		</rule>
		<rule context="xtm:association">
			<assert test="count(*) = count(xtm:instanceOf) + count(xtm:scope) + count(xtm:member)"
			>A <name/> should contain only the following elements: instanceOf, scope and member.</assert>
			<assert test="count(xtm:instanceOf) &lt; 2"
			>The <name/> element should have at most one instanceOf.</assert>
			<assert test="count(xtm:scope) &lt; 2"
			>The <name/> element should have at most one scope.</assert>
			<report test="xtm:scope[following-sibling::xtm:instanceOf]
			  or xtm:member[following-sibling::xtm:instanceOf]"
			>The instanceOf element should come before any scope or member elements.</report>
			<report test="xtm:member[following-sibling::xtm:scope]"
			>The scope element should come before any member elements.</report>
		</rule>
		

		<rule context="xtm:subjectIndicatorRef | xtm:resourceRef | xtm:topicRef">
			<assert test="count(*)=0"
			>A <name/> element should not have children.</assert>
			<assert test="@xlink:href"
			>A <name/> element is a simple XLink, and should have a xlink:href attribute.
			</assert>
		</rule>
		
	</pattern>

</schema>