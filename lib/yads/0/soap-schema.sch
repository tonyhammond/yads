<?xml version='1.0'?>
<sch:schema
       xml:lang="en"
       xmlns:sch="http://www.ascc.net/xml/schematron" >
<sch:title>Schema for SOAP 1.1</sch:title>
<sch:ns prefix='soap-env' uri='http://schemas.xmlsoap.org/soap/envelope/'/>
<sch:p>This schema has (most of) the MUST conditions required of a SOAP
document.  v.0.3 2000-10-21 Rick Jelliffe, Francis Norton</sch:p>


<sch:pattern see='http://www.w3.org/TR/SOAP/' 

   name="Elements">
 
<sch:rule context='/*' role='elementDefinition'>
<sch:assert test='/soap-env:Envelope' role='topElement'>
The Envelope is the top element of the XML document representing the message. </sch:assert>
<sch:assert test='//soap-env:Envelope' role='occurrence'>
The element MUST be present in a SOAP message </sch:assert>
<sch:report test='string-length(namespace::*) = 0' role='contents'>
The <sch:name/> element MAY contain additional sub elements. If
present these elements MUST be namespace-qualified.</sch:report>
</sch:rule>

<sch:rule context='soap-env:Header' role='elementDefinition'>
<sch:assert test='parent::soap-env:Envelope
and (count(preceding-sibling::*) = 0)' role='occurrence'>
The <sch:name/> element MAY be present in a SOAP message. If present, the element MUST be the first immediate child
element of a SOAP Envelope element. </sch:assert>
<sch:report test='string-length(namespace::*) = 0' role='contents'>
All immediate child elements of the SOAP Header element MUST be
namespace-qualified.</sch:report>
</sch:rule>
 
<sch:rule context='soap-env:Body' role='elementDefinition'>
<sch:assert test='parent::soap-env:Envelope and 
(count(preceding-sibling::*) = 0 or 
 (count(preceding-sibling::*) =1 and preceding-sibling::soap-env:Header))' role='occurrence'>

The <sch:name/> element MUST be present in a SOAP message and MUST be an immediate child
element of a SOAP Envelope element. It MUST directly follow the SOAP Header
element if present. Otherwise it MUST be the first immediate child element of the SOAP Envelope element. </sch:assert>
<sch:assert test='count(soap-env:Body) &lt; 2' role='contents'>
The SOAP Fault
element MUST NOT appear more than once within a Body element. </sch:assert>
</sch:rule>

<sch:rule context='soap-env:Fault' role='elementDefinition'>
<sch:assert test='parent::soap-env:Body' role='occurrence'>
The SOAP Fault
element MUST appear as a body entry.</sch:assert>
<sch:assert test='parent::soap-env:faultcode' role='contents'>
The faultcode MUST be present in a SOAP Fault element
</sch:assert>
<sch:assert test='parent::soap-env:faultstring' role='contents'>
The faultstring MUST be present in a SOAP Fault element
</sch:assert>
<sch:report test='string-length(namespace::*) = 0' role='contents'>
The <sch:name/> element MAY contain additional sub elements. If
present these elements MUST be namespace-qualified.</sch:report>
<!--Tricky one ahead! Try this with DTDs or XML Schemas :-) -->
<sch:assert test='(../../soap-env:Header/*[@actor]) and 
 faultfactor' role='contents'>
Applications that do not act as the ultimate destination of the SOAP message MUST include the faultactor
element in a SOAP Fault element.
(Omitting the SOAP actor attribute indicates that the recipient is the ultimate destination of the SOAP message.) </sch:assert>
</sch:rule>

<sch:rule context=' faultcode' role='elementDefinition'>
<sch:assert test='parent::soap-env:Fault' role='occurrence'>
The faultcode element is intended for use by software to provide an algorithmic mechanism for identifying the fault.
The faultcode MUST be present in a SOAP
Fault element</sch:assert>
<sch:assert test='string-length(.) &gt; 0' role='contents'>
The faultcode value MUST be a qualified name.</sch:assert>
</sch:rule>

<sch:rule context=' faultstring' role='elementDefinition'>
<sch:assert test='parent::soap-env:Fault' role='occurrence'>
The faultstring element is intended to provide a human readable explanation of
the fault and is not intended for  algorithmic processing. 
The faultstring MUST be present in a SOAP
Fault element</sch:assert>
<sch:assert test='string-length(.) &gt; 0' role='contents'>
The faultstring SHOULD provide some information 
explaining the nature of the fault.</sch:assert>
</sch:rule>

<sch:rule context='faultfactor' role='elementDefinition'>
<sch:assert test='parent::soap-env:Fault' role='occurrence'>
The faultactor element is intended to provide information about who caused the
fault to happen within the message path.
The faultfactor MAY be present in a SOAP
Fault element</sch:assert>
<sch:assert test='string-length(.) &gt; 0' role='contents'>
The value of the faultfactor attribute
is a URI identifying the source.</sch:assert>
</sch:rule>

<sch:rule context='detail' role='elementDefinition'>
<sch:assert test='parent::soap-env:Fault' role='occurrence'>
The detail element is intended for carrying application specific error information related to the Body element. 
The detail MAY be present in a SOAP
Fault element</sch:assert>
<sch:report test='string-length(namespace::*) = 0' role='contents'>
The <sch:name/> element MAY contain additional sub elements. If
present these elements MUST be namespace-qualified.</sch:report>
</sch:rule>
</sch:pattern>

<sch:pattern  name="The mustUnderstand Attribute" >
<sch:rule context='*[@soap-env:mustUnderstand]' role='attributeDefinition'>
<sch:assert test='parent::soap-env:Header' role='occurrence'>
The recipient of a SOAP message MUST ignore all mustUnderstand
attributes that are not applied to an immediate child element of the SOAP Header element.</sch:assert>
<sch:assert test='( @soap-env:mustUnderstand = 1) or 
(@soap-env:mustUnderstand = 0)' role='contents'>
The value of the mustUnderstand attribute is either "1" or "0"</sch:assert>
</sch:rule></sch:pattern>

<sch:pattern name="The  actor Attribute">
<sch:rule context='*[@soap-env:actor]' role='attributeDefinition'>
<sch:assert test='parent::soap-env:Header' role='occurrence'>
The recipient of a SOAP message MUST ignore all 
actor attributes that are not applied to an immediate child element of the SOAP
Header element.</sch:assert> 
</sch:rule></sch:pattern>

</sch:schema>

