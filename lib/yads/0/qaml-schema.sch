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
	>
	<ns prefix="h" uri="http://www.w3.org/TR/REC-html40" />
	<title>QAML</title>
    <p>The Question and Answer Markup Language (QAML)
	provides a simple way to markup Frequently Asked Question
	(FAQ) documents, or any other document that requires
	a question-and-answer approach.</p>
	<p>See http://www.ascc.net/xml/en/utf-8/qaml-index.html 
	for more information.</p>

	<p>This schema is not exhaustive.</p>

	<pattern name="fulness">
		<rule context="/">
			<assert test="/faq"
			>The top-level element should be "faq".</assert>
		</rule>
		<rule context="/faq">
			<assert test="*[1][self::head]"
			>A faq has a head and a body. The head element comes first.</assert>
			<assert test="*[2][self::body]"
			>A faq has a head and a body. The body comes second.</assert>
			<report test="*[3]"
			>A faq has a head and a body. There should be no third element.</report>
		</rule>
		<rule  context="head" >
			<assert test="*[1][self::title]"
			>The first element in a head should be a title.</assert>
			<assert test="maintain"
			>The head element should have a maintain element, which gives who is
			maintaining the FAQ.</assert>
		</rule>
		<rule context=" version | hdr | althdr | archive | label | link">
			<assert test="parent::head"
			>The <name/> element can only appear in the head of the faq.</assert>
		</rule>
		<rule context=" maintain">
			<assert test="parent::head"
			>The <name/> element can only appear in the head of the faq.</assert>
			<assert test="name"
			>The <name/> element should have one or more names of the maintainers, in element name.</assert>
			<assert test="email"
			>The <name/> element should have one or more email addresses of the maintainers, in element email.</assert>
		</rule>
		<rule context="hdr | althdr">
			<assert test="*[1][self::type]"
			>The first child of <name/> should be a "type" element.</assert>
			<assert test="*[2][self::content]"
			>The first child of <name/> should be a "content" element.</assert>
		</rule>
		<rule  context="body" >
			<assert test="qna or section/qna or section/q or section/p or section/section 
			or section/div"
			>The body of a faq contains either qna elements or 
			section elements (which themselves should contain mixed qna elements
			or section, or div, or p or q elements).</assert>
		</rule>
		<rule  context="section" >
			<assert test="*[1][self::title] or *[1][self::logo][following-sibling::title]"
			>A section must have a title as the first element,
			after any logo.</assert>
		</rule>
		<rule  context="logo">
			<assert test="not(preceding-sibling::*) or preceding-sibling::logo
			or preceding-sibling::q[parent::section] 
			or preceding-sibling::a[parent::section]  "
			>The logo element must appear as the first elements in
			their parent, or at the start of each answer for
			a multi-answer qna.</assert>
			<assert test="parent::author or parent::contributor or
			parent::maintain or parent::qna or parent::section "
			>The logo element can only appear in the following elements
			(at the start): author, contributor, maintain, qna, section.
			</assert>
		</rule>
		
		<rule context="qna">
			<assert test="count(q) =1"
			>A qna must have a question element q (and an answer elements a)</assert>
			<assert test="a"
			>A qna must have (a question element q and) an answer elements a</assert>
		</rule>
		<rule context="a">
			<assert test="count(*) &gt; 0"
			>The answer a element should have not direct text content.
			Instead, it should contain p elements or div elements.
			You can use the class attribute on the p and div elements
			to give them particular styles.</assert>
			<assert test="count(*) = count(p) + count(div)  "
			>The answer a element can have p elements or div elements.
			You can use the class attribute on the p and div elements
			to give them particular styles.</assert>
		</rule>
		<rule context="div">
			<assert test="count(*) &gt; 0"
			>The division div element should have not direct text content.
			Instead, it should contain have p elements.</assert>

			<assert test="count(*) = count(p)"
			>The a element can have p elements elements.
			You can use the class attribute on the div elements
			to give particular styles. Use &lt;div class="ul">
			containing &lt;p class="li"> to create lists.</assert>
		</rule>
	</pattern>

	<pattern name="emptiness">
		<rule context="address | archive | content | email | label
		| link | logo | name | span | subject | title | topic | type
		| version " >
			<assert test="count(*)=0"
			>The <name/> element should have no element children.</assert>
		</rule>
	</pattern>

</schema>