<schema  xmlns="http://www.ascc.net/xml/schematron">
	<title>SMIL</title>
	<!--
		Schematron Schema for SMIL 
		http://www.w3.org/TR/REC-smil/

		Created: 1999-11-11 Rick Jelliffe. Untested
			Need to add patterns for some attributes & WAI guidelines.
 		Version: 2001-06-13 Namespace added to cope with SMIL 2 too

		The SMIL language has several requirements that 
		cannot be expressed in DTDs:
		  Implmented:
			* The top-level element must be <smil>
			* The element <switch> has a different content model
				if it is in a <body> or a <head>
			* The <region> and <root-layout> elements can only appear
				inside a <layout> element, yet that element
				can have content from external languages.
		  Not implemented:
			* Some of the attributes have values constrained
				other than as NMTOKENs: for example, endsync & repeat


	-->
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
     <ns prefix="s" uri="http://www.w3.org/2001/SMIL20/PR/" />
	<pattern name="Top-Level Structures">
                                   
		<rule context="/smil ">
			<assert test="self::*"
			>A <name/> element must appear at the top level.</assert>
			<assert test="count(head)  &lt; 2"
			>A <name/> element should not have more than one head element.</assert>
			<assert test="count(body) &lt; 2"
			>A <name/> element should not have more than one body element.</assert>
		</rule>
		<rule context="/s:smil ">
			<assert test="self::*"
			>A <name/> element must appear at the top level.</assert>
			<assert test="count(s:head)  &lt; 2"
			>A <name/> element should not have more than one head element.</assert>
			<assert test="count(s:body) &lt; 2"
			>A <name/> element should not have more than one body element.</assert>
		</rule>

		<rule context="smil or s:smil">
			<assert test="ancestor::*"
			>A <name/> element must only appear at the top level.</assert>
		</rule>
	</pattern>
	<pattern name="The Document Head">
		<rule context="head">
			<assert test="parent::smil"
			>A <name/> element should be a child of the smil element.</assert> 
			<assert test="(count(layout) + count(switch) + count(meta)) = count(*)"
			>A <name/> element should only contain the elements layout, switch or meta.
			</assert>
		</rule>
       	                    <rule context="s:head">
			<assert test="parent::s:smil"
			>A <name/> element should be a child of the smil element.</assert> 
			<assert test="(count(s:layout) + count(s:switch) + count(s:meta)) = count(*)"
			>A <name/> element should only contain the elements layout, switch or meta.
			</assert>
		</rule>

		<rule context="meta">
			<assert test="@name"
			>A <name/> element should have a name attribute.</assert>
			<assert test="@content"
			>A <name/> element should have a content attribute.</assert>
			<assert test="parent::head"
			>A <name/> element can only appear in a head element.</assert>
			<report test="*"
			>A <name/> element should not have any content.</report>
		</rule>
	                   <rule context="s:meta">
			<assert test="@name or @s:name"
			>A <name/> element should have a name attribute.</assert>
			<assert test="@content or @s:content"
			>A <name/> element should have a content attribute.</assert>
			<assert test="parent::s:head"
			>A <name/> element can only appear in a head element.</assert>
			<report test="*"
			>A <name/> element should not have any content.</report>
		</rule>

		<rule context="layout">
			<assert test="parent::head or parent::switch"
			>A <name/> element can only appear in a head or switch element.</assert>
			<!-- ANY -->
		</rule>

		<rule context="s:layout">
			<assert test="parent::s:head or parent::s:switch"
			>A <name/> element can only appear in a head or switch element.</assert>
			<!-- ANY -->
		</rule>
		<rule context="head/switch">
			<assert test="layout"
			>A <name/> element in the head can only contain layout elements.
			</assert>
		</rule>
		<rule context="s:head/s:switch">
			<assert test="s:layout"
			>A <name/> element in the head can only contain layout elements.
			</assert>
		</rule>
		<rule context="region | root-layout">
			<assert test="ancestor::layout"
			>A <name/> must be in a layout element.</assert>
			<report test="*"
			>A <name/> should be empty. It should not have any subelements.</report>
		</rule>
		<rule context="s:region | s:root-layout">
			<assert test="ancestor::s:layout"
			>A <name/> must be in a layout element.</assert>
			<report test="*"
			>A <name/> should be empty. It should not have any subelements.</report>
		</rule>
	</pattern>
	<pattern name="The Document Body">
		<rule context="body">
			<assert test="parent::smil"
			>A <name/> element should be a child of the smil element.</assert>
			<assert role="container content" 
			test="count(audio) + count(video) + count(text) + count(img) 
			+ count(animation) + count(textstream) + count(ref)
			+ count(par) + count(seq) + count(switch) + count(a) = count(*)  "
			>A <name/> element can only have container content.
			</assert>
		</rule>
                    	<rule context="s:body">
			<assert test="parent::s:smil"
			>A <name/> element should be a child of the smil element.</assert>
			<assert role="container content" 
			test="count(s:audio) + count(s:video) + count(s:text) + count(s:img) 
			+ count(s:animation) + count(s:textstream) + count(s:ref)
			+ count(s:par) + count(s:seq) + count(s:switch) + count(s:a) = count(*)  "
			>A <name/> element can only have container content.
			</assert>
		</rule>

		<rule context="par | seq | body/switch ">
			<assert role="container content" 
			test="count(audio) + count(video) + count(text) + count(img) 
			+ count(animation) + count(textstream) + count(ref)
			+ count(par) + count(seq) + count(switch) + count(a) = count(*)  "
			>A <name/> element can only have container content.
			</assert>
		</rule>

		<rule context="s:par | s:seq | s:body/s:switch ">
			<assert role="container content" 
			test="count(s:audio) + count(s:video) + count(s:text) + count(s:img) 
			+ count(s:animation) + count(s:textstream) + count(s:ref)
			+ count(s:par) + count(s:seq) + count(s:switch) + count(s:a) = count(*)  "
			>A <name/> element can only have container content.
			</assert>
		</rule>
		<rule context="audio |video |text |img |animation |textstream |ref" role="mo-elements">
			<report role="mo-content" test="count(anchor) &lt; count(*)"
			>Only anchor elements are allowed as subelements of media object elements.</report>
			<assert test="parent::par or parent::switch or parent::seq"
			>A <name/> element may only be inside the elements par, switch or seq.</assert>
		</rule>
		<rule context="s:audio |s:video |s:text |s:img |s:animation |s:textstream |s:ref" role="mo-elements">
			<report role="mo-content" test="count(s:anchor) &lt; count(*)"
			>Only anchor elements are allowed as subelements of media object elements.</report>
			<assert test="parent::s:par or parent::s:switch or parent::s:seq"
			>A <name/> element may only be inside the elements par, switch or seq.</assert>
		</rule>

		<rule context="anchor">
			<assert test="@href"
			>A <name/> element should have an href element.</assert>
		</rule>
	                   <rule context="s:anchor">
			<assert test="@href or @s:href"
			>A <name/> element should have an href element.</assert>
		</rule>
	
		<rule context="a">
			<assert test="@href"
			>A <name/> element should have an href element.</assert>
		</rule>
		<rule context="s:a">
			<assert test="@href or @s:href"
			>A <name/> element should have an href element.</assert>
		</rule>
	</pattern>

	<pattern name="Media Object Attributes">
		<rule context="*[@region] | *[@alt] | *[@longdesc] | *[@src] | *[@type] 
			| *[@dur] | *[@repeat] |
		             *[@s:region] | *[@s:alt] | *[@s:longdesc] | *[@s:src] | *[@s:type] 
			| *[@s:dur] | *[@s:repeat]" >
			<assert test="self::audio or self::video or self::text or self::img
			 or self::animation or self::textstream or self::ref or
			self::s:audio or self::s:video or self::s:text or self::s:img
			 or self::s:animation or self::s:textstream or self::s:ref"
			>A Media Object attribute should only be on a Media Object Element.</assert>
		</rule>
	</pattern>
	<pattern name="Id Attributes">
		<rule context="*[@id] | *[@s:id] ">
			<assert test="self::smil or self::head or self::layout 
			or self::region or self::root 
			or self::body or self::par or self::seq or self::switch 
			or self::audio or self::video or self::text or self::img or self::animation 
			or self::textstream or self::ref  or
			self::s:smil or self::s:head or self::s:layout 
			or self::s:region or self::s:root 
			or self::s:body or self::s:par or self::s:seq or self::s:switch 
			or self::s:audio or self::s:video or self::s:text or self::s:img or self::animation 
			or self::s:textstream or self::s:ref"
			>A <name/> element cannot have an ID attribute.</assert>
		</rule>
	</pattern>
	<pattern name="Link Attributes">
		<rule context="a[@show] | anchor[@show]">
			<assert test="(@show='replace') or (@show='new') or (@show='pause')"
			>The show attribute on a <name/> element should have one of the
			values replace, new or pause.</assert>
		</rule>

		<rule context="s:a[@show] | s:anchor[@show]">
			<assert test="(@show='replace') or (@show='new') or (@show='pause')"
			>The show attribute on a <name/> element should have one of the
			values replace, new or pause.</assert>
		</rule>

		<rule context="s:a[@s:show] | s:anchor[@s:show]">
			<assert test="(@s:show='replace') or (@s:show='new') or (@show='pause')"
			>The show attribute on a <name/> element should have one of the
			values replace, new or pause.</assert>
		</rule>

	</pattern>


	<pattern name="Skip Attributes">
		<rule context="meta[@skip-content] | anchor[@skip-content] | root-layout[@skip-content]
			| region[@skip-content]">
			<assert test="(@skip-content ='true' ) or ( @skip-content = 'false')"
			>A skip-content attribute on a <name/> element can only have a 
			value of true or false.</assert>
		</rule>
	    <rule context="s:meta[@skip-content] | s:anchor[@skip-content] | s:root-layout[@skip-content]
			| s:region[@skip-content]">
			<assert test="(@skip-content ='true' ) or ( @skip-content = 'false')"
			>A skip-content attribute on a <name/> element can only have a 
			value of true or false.</assert>
		</rule>
	    <rule context="s:meta[@s:skip-content] | s:anchor[@s:skip-content] | s:root-layout[@s:skip-content]
			| s:region[@s:skip-content]">
			<assert test="(@s:skip-content ='true' ) or ( @s:skip-content = 'false')"
			>A skip-content attribute on a <name/> element can only have a 
			value of true or false.</assert>
		</rule>
	</pattern>
	<pattern name="Region Attributes">
		<rule context="region[@fit]">
			<assert test="(@fit='hidden' ) or (@fit='fill') or
			(@fit='meet') or (@fit='scroll') or (@fit='slice')"
			>In the element <name/> the attribute fit can only have values
			hidden, fill, meet, scroll or slice.</assert>
		</rule>

		<rule context="s:region[@fit]">
			<assert test="(@fit='hidden' ) or (@fit='fill') or
			(@fit='meet') or (@fit='scroll') or (@fit='slice')"
			>In the element <name/> the attribute fit can only have values
			hidden, fill, meet, scroll or slice.</assert>
		</rule>

		<rule context="s:region[@s:fit]">
			<assert test="(@s:fit='hidden' ) or (@s:fit='fill') or
			(@s:fit='meet') or (@s:fit='scroll') or (@s:fit='slice')"
			>In the element <name/> the attribute fit can only have values
			hidden, fill, meet, scroll or slice.</assert>
		</rule>
	</pattern>

</schema>
