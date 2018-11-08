<?xml version="1.0" ?>
<!-- 
	NITF 2.5 schema for Schematron 
	2000-06-16 reworked by Rick Jelliffe ricko@allette.com.au

	Includes parts of
	NITF Schema posted by Dave Pawson to maillist w3c-wai-pf@w3.org
	1999-10-29 as example for discussion purposes.
	NITF information can be found at http://www.nitf.org/
   
-->
<schema xmlns="http://www.ascc.net/xml/schematron">
    <title>News Industry Text Format 2.5</title>
	<phase id="Validate">
		<active pattern="BasicRules" />
		<active pattern="Required" />
	</phase>
	<phase id="Suggestions">
		<active pattern="suggested" />
	</phase>
	<phase id="SingleStory-WhoWhatWhereWhen" >
	     <active pattern="WhoWhatWhereWhenContent" />
	</phase>
	<phase id="MutipleStory-WhoWhatWhereWhen" >
	     <active pattern="WhoWhatWhereWhenBlock" />
	</phase>
    <pattern name="BasicRules">
		<rule context="meta | tobject.property | tobject.subject |
		ds | correction | erloc | doc-id | from-src | urgency |
		fixture | date.issue | date.release | date.expire |
		doc-scope | series | ed-msg | du-key | doc.copyright |
		doc.rights  | keyword | pubdata | revision-history |
		media-metadata |col | alt-code | br ">
		    <!-- empty elements -->
			<assert test="count(*) = 0"
			>The <name/> element should not contain children.</assert>
			<assert test="string-length(normalize-space(./text()))=0"
			>The <name/> element should not contain text.</assert>
	    </rule>

	    <rule context=" title | rights.owner | rights.startdate |
		rights.enddate | rights.agent | rights.geography |
		rights.type | rights.limitations | story.date |
		copyright.year | copyright.holder | media-reference |
		media-object | pre | datasource | chron | money |
		numer | frac-sep | denom | sub | sup | name.given |
		name.family | care.of | postcode | bibliography  ">
		    <!-- #PCDATA elements -->
			<assert test="count(*) = 0"
			>The <name/> element should not contain any elements or text.</assert>
	    </rule>

		<rule context="head | toobject | iim | docdata | del-list |
		key-list | body | body.head | body.content | block | 
		dd ">
		    <!-- element content elements with at lease no required element -->
			<assert test="string-length(normalize-space(./text()))=0"
			>The <name/> element should not contain text.</assert>
	    </rule>

		<rule context="nitf | hedline | note | abstract | table |
		media | ol | ul | dl | bq | fn | colgroup | thead |
		tbody | tfoot | tr | frac | postaddr | addressee">
		    <!-- element content elements with at lease one required element -->
		     <assert test="count(*) > 0"
			>The <name/> element should not be empty: it requires some element.</assert>
			<assert test="string-length(normalize-space(./text()))=0"
			>The <name/> element should not contain text.</assert>
	    </rule>

        <rule context="hl1 | hl2 | rights | byline | byttl |
		distributor | dateline | copyrite | p | media-caption |
		media-producer | li | dt | dd | credit | caption |
		th | td | event | function | location | sublocation |
		city | state | region | country | num | object.title |
		org | person | virtloc | a | em | lang | pronounce |
		q | delivery.point | delivery.office | tagline 
		">
		    <!-- swallow mixed content elements -->
			<assert test="1=1" />
		</rule>

		<rule context="*">
			<!-- catch any unexpected elements -->
			<report test="1=1"
			>The <name/> element is not a NITF 2.5 element.</report>
		</rule>

	</pattern>

<pattern name="Required">
  <rule context="a">
   <assert test="@href">Element a has no href attribute</assert>
   <assert test="@href = id(@href)/@id">Cross reference from a element not
available</assert>
  </rule>

   <rule context="alt-code  | event | function | obj.title | org |
   person | virtloc ">
   <assert test="string-length(@value) > 0"
   ><name/> has no value attribute (an alternate code or symbol for the element.)</assert>
   <assert test="string-length(@idsrc)
   >0"><name/> has no idsrc attribute(source {taxonomy} for the element's value)</assert>
   </rule>

   <rule context="ds">
   <assert test="string-length(@num) > 0
   "><name/> has no num attribute (IIM Record 2 field number)</assert>
   </rule>


  <rule context="fig">
   <assert test="string-length(@name) > 0">Figure has no name attribute</assert>
   <assert test="string-length(@source)>0">Figure has no source attribute </assert>
   <assert test="string-length(@alt)>0">Figure has no alternative text  (alt attribute)
description</assert>
  </rule>

 <rule context="img">
   <assert test="string-length(@name) > 0">Image has no name</assert>
   <assert test="string-length(@alt)>0">Image has no alternative text
description</assert>
  </rule>

  <rule context="fig.caption">
   <assert test="string-length(caption) > 0">No caption provided for
figure</assert>
  </rule>

   <rule context="media">
	<assert test="@media-type='text'
	or @media-type='audio' or @media-type='image' 
	or @media-type='video' or @media-type='data'
    or @media-type='application' or @media-type='other'"
    >The media element should have a media-type element with
	one of the following values:
	text, audio, image, video, data, application, other.
	</assert>
   </rule>
  <rule context="media-object">
   <assert test="string-length(@encoding) > 0"
   >A media-object should have its encoding attribute completed.</assert>
  </rule>


  <rule context="media-reference">
   <assert test="string-length(@data-location) > 0"
   >A media-reference should have its data-location attribute completed.</assert>
  </rule>


  <rule context="meta">
   <assert test="string-length(@content) > 0"
   >A meta element should have its content attribute completed.</assert>
  </rule>

         <rule context="docdata[urgency]">
            <assert test="string-length(normalize-space(urgency/@ed-urg)) &lt; 2">Urgency
should be a single digit</assert>
           
        </rule>

	</pattern>

	<pattern name="Suggested" >
         <!-- add best practise rules here -->

        <rule context="body">
            <assert test="string-length(@lang) &gt; 0">The language
attribute to the body element should not be empty.</assert>
        </rule>
        <rule context="body.head">
           
            <assert test="abstract">An abstract is needed for
archive purposes</assert>
        </rule>
        <rule context="hr">
            <assert test="parent::block">hr element should only be used in a block
element. Other uses are deprecated</assert>
            
        </rule>

    </pattern>

	<pattern name="WhoWhatWhereWhenBlock">

		<!-- Use this section to confirm whether a story 
		has all components. There are no How elements in NITF. -->

        <!-- This one tests all blocks -->
		<rule context="block">

		    <!-- Who -->
			<assert test=".//function  or .//name.give or .//name.family
			or .//org or .//person"
			>The should be at least one element
			marking up who a story is about.</assert>

		    <!-- What -->
			<assert test=".//event "
			>The should be at least one element
			marking up what a story is about.</assert>

			
		    <!-- Where -->
			<assert test=".//city or .//country or .//evloc  or .//location or
			.//region or .//state or .//sublocation or .//virtloc"
			>The should be at least one element
			marking up where a story occurred.</assert>

			
		    <!-- When -->
			<assert test=".//chron"
			>The should be at least one element
			marking up when a story occurred.</assert>

		</rule>

	 </pattern>


	<pattern name="WhoWhatWhereWhenContent">

		<!-- Use this section to confirm whether a story 
		has all components. There are no How elements in NITF. -->

        <!-- This one tests all the body.content.
		     This is suitable for if there is only one story. -->
		<rule context="body.content">

		    <!-- Who -->
			<assert test=".//function  or .//name.give or .//name.family
			or .//org or .//person"
			>The should be at least one element
			marking up who a story is about.</assert>

		    <!-- What -->
			<assert test=".//event "
			>The should be at least one element
			marking up what a story is about.</assert>

			
		    <!-- Where -->
			<assert test=".//city or .//country or .//evloc  or .//location or
			.//region or .//state or .//sublocation or .//virtloc"
			>The should be at least one element
			marking up where a story occurred.</assert>

			
		    <!-- When -->
			<assert test=".//chron"
			>The should be at least one element
			marking up when a story occurred.</assert>

		</rule>
     </pattern>


</schema>


