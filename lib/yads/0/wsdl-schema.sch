<schema xmlns="http://www.ascc.net/xml/schematron" xmlns:zvon="http://zvon.org/schematron">
	<!--
		(c) 2001, Simon Fell, all rights reserved.
		This is a basic schematron schema for validating SOAP orientated WSDL documents
		The latest info on this can be found at http://www.pocketsoap.com/wsdl

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


 		Version : March 2, 2001 Simon Fell
 			* base version, no schema related checking yet, the cross reference
 			  checks are not namespace aware.	
	-->
	<title>A Schematron Schema for SOAP based WSDL</title>
  	<ns prefix="wsdl" uri="http://schemas.xmlsoap.org/wsdl/" />
  	<ns prefix="soap" uri="http://schemas.xmlsoap.org/wsdl/soap/" />

	<pattern name="Definitions Checks">
		<rule context="/">
			<assert test=".=wsdl:definitions">Root element should be http://schemas.xmlsoap.org/wsdl/:definitions</assert>
		</rule>
		<rule context="wsdl:definitions">
			<assert test="@name"><name zvon:fullPath='yes'/> should have a name attribute</assert>
		</rule>
	</pattern>
	

 	<pattern name="Service Checks">
 		<rule context="wsdl:service">
 	                    			<assert test="@name"><name zvon:fullPath='yes'/> A service should have a name attribute</assert>
 			<assert test="wsdl:port"><name zvon:fullPath='yes'/> A service should have at least one port element</assert>
 		</rule>
 		<rule context="wsdl:service/wsdl:port">
 			<assert test="@name"><name zvon:fullPath='yes'/> A port should have a name attribute</assert>
 			<assert test="@binding"><name zvon:fullPath='yes'/> A port should have a binding attriubte</assert>
 			<assert test="soap:address"><name zvon:fullPath='yes'/> A port should define a soap:address element</assert>
 		</rule>
 		<rule context="wsdl:service/wsdl:port/@binding">
                                                      <key name="binding"  path="wsdl:binding" use="@name"/>

 			<assert test="key('binding',substring-after(.,':')) or key('binding',.)">
 				<name zvon:fullPath='yes'/> should reference a binding that exists</assert>
 		</rule>
 		<rule context="wsdl:service/wsdl:port/soap:address">
 			<assert test="@location"><name zvon:fullPath='yes'/> a soap:address should have a location attribute</assert>
 		</rule>
  	</pattern>
  
  

 	<pattern name="Binding Checks">
		<rule context="wsdl:binding">
	                   			<assert test="@name"><name zvon:fullPath='yes'/> A binding should have a name attribute</assert>
			<assert test="@type"><name zvon:fullPath='yes'/> A binding should have a type attribute</assert>
			<assert test="soap:binding"><name zvon:fullPath='yes'/> A binding should have a soap binding element</assert>
			<assert test="wsdl:operation"><name zvon:fullPath='yes'/> A binding should have 1 or more operations</assert>
		</rule>
		<rule context="wsdl:binding/@type">
                                       <key name="portType"  path="wsdl:portType" use="@name"/>

			<assert test="key('portType',substring-after(.,':')) or key('portType',.)"><name zvon:fullPath='yes'/> should point to a portType that exists.</assert>
		</rule>
		<rule context="soap:binding">
			<assert test="normalize-space(@style)='rpc' or normalize-space(@style)='document'"><name zvon:fullPath='yes'/> a soap:binding style should be rpc or document</assert>
			<assert test="@transport"><name zvon:fullPath='yes'/> a soap:binding should have a transport attribute</assert>
		</rule>
		<rule context="wsdl:binding/wsdl:operation">
			<assert test="@name"><name zvon:fullPath='yes'/> An operation should have a name attriubte</assert>
			<assert test="wsdl:input"><name zvon:fullPath='yes'/> An operation should have an input element</assert>
			<assert test="soap:operation"><name zvon:fullPath='yes'/> An operation should have a soap:operation element</assert>
		</rule>
		<rule context="wsdl:binding/wsdl:operation/@name">
                                       <key name="portType2"  path="wsdl:portType" use="@name"/>

			<assert test="key('portType2',substring-after(../../@type,':'))/wsdl:operation/@name=. or key('portType2',../../@type)/wsdl:operation/@name=."  diagnostics="port" >
				<name zvon:fullPath='yes'/> should point to an operation that exists in the appropriate portType.
			</assert>
		</rule>
		<rule context="soap:operation">
			<assert test="@soapAction"><name zvon:fullPath='yes'/> A soap:operation should have a soapAction attriubte</assert>
		</rule>
		<rule context="wsdl:binding/wsdl:operation/wsdl:input">
			<assert test="soap:body"><name zvon:fullPath='yes'/> An input should have a soap:body child</assert>
		</rule>
		<rule context="wsdl:binding/wsdl:operation/wsdl:output">
			<assert test="soap:body"><name zvon:fullPath='yes'/> An output should have a soap:body child</assert>
		</rule>
		<rule context="soap:body">
			<assert test="normalize-space(@use)='literal' or normalize-space(@use)='encoded'"><name zvon:fullPath='yes'/> the use attribute for soap:body should be 'literal' or 'encoded'</assert>
			<assert test="normalize-space(@use)='literal' or (normalize-space(@use)='encoded' and @encodingStyle)"><name zvon:fullPath='yes'/> soap:body elements with an use='encoded' should have an encodingStyle attriubte</assert>
			<assert test="@namespace"><name zvon:fullPath='yes'/> the soap:body element should have a namespace attribute</assert>
		</rule>
	</pattern>


	<pattern name="portType checks">
		<rule context="wsdl:portType">
			<assert test="@name"><name zvon:fullPath='yes'/> should have a name attribute</assert>
			<assert test="wsdl:operation"><name zvon:fullPath='yes'/> should have at least 1 operation</assert>
		</rule>
		<rule context="wsdl:portType/wsdl:operation">
			<assert test="@name"><name zvon:fullPath='yes'/> should have a name attribute</assert>
			<assert test="wsdl:input or wsdl:output"> should have an input and/or an output element</assert>
		</rule>
		<rule context="wsdl:portType/wsdl:operation/wsdl:input | wsdl:portType/wsdl:operation/wsdl:output">
                    	<key name="message" path="wsdl:message" use="@name"/>
			<assert test="@message"><name zvon:fullPath='yes'/> should have a message attriubte</assert>
			<assert test="key('message',substring-after(@message,':')) or key('message',@message)"><name zvon:fullPath='yes'/> should point to a message that exists.</assert>
		</rule>
	</pattern>

	<pattern name="message checks">
		<rule context="wsdl:message">
			<assert test="@name"><name zvon:fullPath='yes'/> should have a name attribute</assert>
		</rule>
		<rule context="wsdl:message/wsdl:part">
			<assert test="@name"><name zvon:fullPath='yes'/> should have a name attribute</assert>
			<assert test="@type or @element"><name zvon:fullPath='yes'/> should have a 'type' or 'element' attriubte</assert>
		</rule>
	</pattern>

    <diagnostics>
                <diagnostic id="port"
               >Check  portType '<value-of select="../../@type" />'</diagnostic>
   </diagnostics>
</schema>


