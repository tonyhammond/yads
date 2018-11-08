<?xml version="1.0" encoding="ASCII" ?>
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
	schemaVersion="2001/09/17" 
	>
   <title>Resource Description Framework (RDF and RDFS) in XML</title>
   <ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
   <ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#" />
   <p>The Resource Description Framework is the cornerstone
   of the W3C's Semantic Web Activity. 
   </p>
   <p>The first pattern specifies all the names for elements 
   in the RDF and RDFS namespaces. The second pattern validates
   some attribute names. The third pattern specifies
   elements which are obsolescent, according to the proposed 
   syntax. The fourth pattern finds some common spelling errors.</p>
   <p>The fifth pattern specifies the information items of RDF
   which can be elements, including descriptions and properties.
   The remaining patterns allow better validation of some 
   attributes.
   </p>
   
<p>This schema will validate RDF elements and attributes
according to the "re-factored" syntax of
http://www.w3.org/TR/2001/WD-rdf-syntax-grammar-20010906/
It passes all RDF files in the RDF test suite and
reports all errors in that test suite (except for
certain ones regarding banning local attributes in
foreign namespaces, which needs further clarification.)</p>
 <p>The schema can also be used to label the function of
 elements with respect to the RDF framework.</p>
   <p>Invoking a validator using the "simple" phase
   basic tests only. Invoking all the patterns
   will also report common spelling errors and obselescent
   elements.</p>

   <phase id="simple">
    <active pattern="namespaceForElements" />
    <active pattern="namespaceForAttributes" />
    <active pattern="elements"/>
    <active pattern="aboutAttributes"/>
    <active pattern="parseType"/>
   </phase>

    <pattern name="namespaceForElements"
    	see="http://www.w3.org/TR/REC-rdf-syntax/">
    <rule context="rdf:*">
      <assert test="self::rdf:RDF or self::rdf:Description  or self::rdf:subject  or self::rdf:predicate 
       or self::rdf:object  or self::rdf:type  or self::rdf:value  or self::rdf:property 
        or self::rdf:li  or self::rdf:Bag  or self::rdf:Seq  or self::rdf:Alt
        or (starts-with(local-name(), '_') and number(substring-after(local-name(), '_')) ) "
         >The RDF namespace has the following names for elements:
         RDF, Description, subject, predicate, object, type, value, property,
         Bag, Seq, Alt, li or a name made from a prefix '_' followed by a number.</assert>
         <assert test="count(@*[namespace-uri()=''])=0"
         >All attributes on elements in the RDF namespace should be prefixed.</assert>

	</rule>
  <rule context="rdfs:*">
    <assert test="self::rdfs:Class  or self::rdfs:label  or self::rdfs:comment  or 
    self::rdfs:range  or self::rdfs:domain  or self::rdfs:subPropertyOf  or self::rdfs:subClassOf  or 
    self::rdfs:seeAlso  or self::rdfs:isDefinedBy  or self::rdfs:constraintResource  or  
    self::rdfs:constraintProperty  or self::rdfs:Resource"
    >The RDFS namespace has the following names for elements:
    Class, label, comment, range, domain, subPropertyOf, subClassOf,
    seeAlso, isDefinedBy, constraintResource, constraintProperty, resource.
    </assert>
  </rule>
  </pattern>
 
  <pattern name="namespaceForAttributes">
    <rule context="*[@rdf:*]">
      <report test="@rdf:li">rdf:li is not allowed as an attribute.</report>
    </rule>
  </pattern>
  
  <pattern name="obsolescent">
    <rule context="rdf:*">
           <report test="self::rdf:BAG | self::rdf:Bag | self::rdf:bag 
		    |	self::rdf:SEQ | self::rdf:Seq | self::rdf:seq
		    | self::rdf:ALT | self::rdf:Alt | self::rdf:alt
		    | self::rdf:LI | self::rdf:Li | self::rdf:li">
		 The <name /> element is not part of the refactored RDF syntax.</report>
     
     <report test="rdf:*[starts-with('_', local-name())]"
     >This schema may not handle all parts of the abbreviated syntax, such
     as <name /> elements.</report>
     </rule>
  </pattern>
 
 
  <pattern name="SpellingErrors"
      see="http://www.w3.org/TR/2001/WD-rdf-syntax-grammar-20010906/" >
	<!-- these rules test basic namespace and capitalization-->
  
	<rule	context="rdf | RDF" >
		<report	test="true()" diagnostics="fixRdfNs"
			>A <name/> element should be in the RDF Namespace.</report>
	</rule>
  
	<rule	context="rdf:rdf  |
		rdf:description | rdf:DESCRIPTION | 
		rdf:Subject | rdf:SUBJECT | rdf:Predicate | rdf:PREDICATE  |
		rdf:Object | rdf:OBJECT | rdf:Type | rdf:TYPE |
		rdf:Value | rdf:VALUE  |
		rdf:property | rdf:PROPERTY ">
		<report	test="true()" diagnostics="checkSpelling"
			>The element <name/> is not the correct capitalization.
			XML is case-sensitive.</report>
	</rule>

	<rule   context="rdfs:class | rdfs:CLASS | rdfs:Label |
		rdfs:LABEL | rdfs:Comment | rdfs:COMMENT |
		rdfs:Range | rdfs:RANGE | rdfs:Domain | rdfs:DOMAIN |
		rdfs:subpropertyof | rdfs:SUBPROPERTYOF |
		rdfs:subclassof | rdfs:SUBCLASSOF  |
		rdfs:seealso | rdfs:SEEALSO | 
		rdfs:isdefinedby | rdfs:ISDEFINEDBY |
		rdfs:contraintresource | rdfs:CONSTRAINTRESOURCE |
		rdfs:constraintproperty | rdfs:CONSTRAINPROPERTY |
		rdfs:resource | rdfs:RESOURCE ">
		<report	test="true()" diagnostics="checkSpelling"
			>The element <name/> is not the correct capitalization.
			XML is case-sensitive.</report>
	</rule>
  </pattern>
   
   <pattern name="elements" >
   
      <rule id="RDF" context="rdf:RDF">
          <assert test="count(ancestor::*) =0">The rdf:RDF element can only appear at the top-level
           </assert>
          <report test="@rdf:*">An rdf:* attribute cannot go on rdf:RDF.</report>
      </rule>
     
      <rule id="otherElements" context="*[ancestor::*[@rdf:parseType='parseOther']]">
           <assert test="rdf:* or *[@rdf:*]">Any rdf elements or attributes inside a parseOther section
            are not significant to the RDF document as rdf markup.</assert> 
      </rule>
       <rule id="description" context=" rdf:Description ">
              <assert test="true()">A Description element can appear at the top-level,
              as the child of rdf:RDF, or be the child of a property element with no parseType.
              If an element has rdf:parseType or rdf:resource, it is not a description element
              or typed node.
              </assert>
      </rule>
      
             <rule id="TypedNode" context="/* |  /rdf:RDF/*  | 
        *[not(@rdf:parseType)][not(@rdf:resource)][not(../rdf:Description)][not(../rdf:RDF)]/*[
          not(@rdf:resource)][not(@rdf:parseType)]">
              <assert test="true()">A  typed node element can appear at the top-level,
              as the child of rdf:RDF, or be the child of a property element with no parseType.
              If an element has rdf:parseType or rdf:resource, it is not a description element
              or typed node.
              </assert>
      </rule>

      <rule id="propertyElement" context="/*/* | /rdf:RDF/*/* | rdf:Description/* | 
      *[not(@rdf:parseType)]/*/*
          | *[normalize-space(@rdf:parseType)='Resource']/* 
          | */@rdf:parseType | */@rdf:resource ">
            <assert test="true()">Property elements such as <name /> should appear
                as the child of a description element
                or the child of an element with parseType of "Resource"</assert>
          <report test="rdf:bagID">Property elements such as <name /> should not have any bagIDs.</report>
         <!--assert test="* or @rdf:resource"
		    	>A property element such as <name/> must either
		    	contain its resource or give them in a resource
		    	(rdf:resource) attribute.</assert-->
          
		<report test="@rdf:about or @rdf:aboutEach"
			>Property elements such as <name/> should not have
			an rdf:about or an rdf:aboutEach attribute.</report>

      </rule>

      <rule id="rdf-error" context="rdf:*">
             <report test="rdf:*">An element in the RDF namespace such as <name />
             should be RDF, Description, or be used as a property element or description
             element or typed node.
            </report> 
      </rule>

      <rule id="error" context="*">
             <report test="*">The element <name /> was not expected by the schema.</report> 
      </rule>
    </pattern>

   <pattern name="idAttributes" >
   <rule abstract="true" id="idCheck">
      <assert test="count(//*[@rdf:ID=current()/@rdf:ID])=1"
      >The rdf:ID attribute should have unique token values in a document.</assert>
   </rule>
   <rule abstract="true" id="bagIdCheck">   
    <assert test="count(//*[@rdf:bagID=current()/@rdf:bagID])=1"
    >The rdf:bagID attribute should have unique token values in a document.</assert>
   </rule>
   
   <rule context="*[@rdf:ID][@rdf:bagID]">
    <extends rule="idCheck"/>
    <extends rule="bagIdCheck" />
   </rule>
   
   <rule context="*[@rdf:ID]">
    <extends rule="idCheck"/>
   </rule>
   
   <rule context="*[@rdf:bagID]">
    <extends rule="bagIdCheck" />
   </rule>
  </pattern>
  
  <pattern name="parseType">
    <rule context="*[@rdf:parseType]">
		<report	test="self::*[ @rdf:parseType='resource' or @rdf:parseType='literal' 
			or @rdf:parseType='RESOURCE' or @rdf:parseType='LITERAL' ]"
			diagnostics="checkSpelling"
			>The parseType attribute in a <name/> should be spelled either 'Literal' or 'Resource'.</report>
		<report test="self::*[@rdf:parseType='Literal']/*"
			>If the parseType attribute is 'Literal', the <name/> element
			should not contain child elements.</report>
      <report test="self::*[@rdf:parseType='Literal'][@rdf:resource]"
      >Specifying an rdf:parseType of "Literal" and an
 rdf:resource attribute at the same time is an error
      </report>
      <report test="self::*[@rdf:parseType='Literal'][count(@*[namespace-uri()!='http://www.w3.org/1999/02/22-rdf-syntax-ns#'])]"
      >If the parseType is 'Literal', there should be no other attributes outside
       the rdf namespace on the element.
      </report>
      </rule>
 </pattern>

  <pattern name="aboutAttributes"
	see="http://www.w3.org/TR/REC-rdf-syntax/" >

	<rule id="idAboutAttr" abstract="true">
		<report test="self::*[@rdf:ID][@rdf:about] or self::*[@rdf:ID][@rdf:aboutEach] 
		or self::*[@rdf:about][@rdf:aboutEach] "
			>The <name /> element can only have one rdf:ID or
			an rdf:about or an rdf:aboutEach attribute.</report>
	</rule>
        
	 <rule	context="/rdf:RDF" >
		<report test="@rdf:*" >The rdf:RDF element should not have an attributes.</report>
	</rule>

	 <rule	context="rdf:Description" >
		<extends rule="idAboutAttr" />
    <!--assert test="count(@*) = count(@rdf:*)"
    >The rdf:Description element should only have qualified attributes.</assert-->
	</rule>

	 <rule	context=" rdf:RDF/* | /*  |  *[@rdf:type]" >
		<extends rule="idAboutAttr" />
	</rule>
	<rule context="*">
		<report	test="self::*[@rdf:_1][rdf:_1] | self::*[@rdf:_2][rdf:_2]"
			>The <name/> element should use only the
			abbreviated syntax or the full syntax but not both.</report>
         </rule>

</pattern>     
  
  
 <diagnostics>
	<diagnostic id="fixRdfNs"
	>Add xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	to the element.</diagnostic>
	<diagnostic id="checkSpelling"
	>Check the spelling and capitalization</diagnostic>
 </diagnostics>
</schema>
