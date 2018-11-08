<?xml version="1.0"?>
 <!-- Schematron schema for CALS tabls (Exchange subset of OASIS) 
             Created: Rick Jelliffe, Topologi 
             Version: 2001-06-22 
       
	Thanks to Paul Hermans for supplying test data -->
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
<schema xmlns="http://www.ascc.net/xml/schematron"   >
	<title>SGML Open CALS Tables</title>
	<p>This Schematron schema describes the OASIS SGML table model
 <emph>-//SGML Open//DTD Exchange Table Model 19960430//EN</emph>
 (and its equivalent XML version
  <emph>-//OASIS//DTD XML Exchange Table Model 19990315//EN</emph>)
 which is a subset of the full SGML CALS table model
 <emph>-//USA-DOD//DTD Table Model 951010//EN</emph> of
 <emph>US MIL-HDBK-28001</emph>.
 (The subset excludes formatting features that are not commonly
 implemented. It is the subset that will be used in DOCBOOK 5.0)
 </p>
	<p>This has been implemented as an open schema: it allows additional
 elements and attributes. This means that it will not catch spelling
 errors of element GIs and attibute names, which are often a common problem.
 However, it will catch attempts to use the elements of table in unexpected
 places, for example an entry anywhere other than in a row.</p>
	<p>To do: validate numbers, units and tokens</p>

<phase id="DefiniteProblems">
	<active pattern="coextbl" />
</phase>
<phase id="GoFishing">
	<active pattern="strict" />
</phase>

        <pattern name="Rules for Tables" see="http://www.oasis-open.org/html/tr9503.html" id="coextbl">
		<rule context="table">
			<!-- elements -->
			<report test="tgroup/following-sibling::title">The title of a <name/>, if it is given, should go before any tgroups.</report>
			<assert test="tgroup">A <name/> should have one or more tgroups as its child</assert>
			<!-- attributes -->
			<assert test="not(@frame) or ((@frame='top') or (@frame='bottom') or (@frame='topbot')
       or (@frame='all') or (@frame='sides') or (@frame='none'))">The align attribute on <name/> should be "top", "bottom", "topbot", "all", "sides" or "none".</assert>
		</rule>
		<rule context="title">
			<!-- elements -->
			<report test="parent::tgroup | parent::thead | parent::tbody | parent::colspec
      | parent::row | parent::entry ">A <name/> should not be the child of a tgroup, thead, tbody, colspec, row or entry</report>
		</rule>
		<rule context="tgroup">
			<!-- elements -->
			<assert test="count(thead)&lt; 2">A <name/> should not have more than one thead elements.</assert>
			<assert test="count(tbody)=1">A <name/> should have a tbody element.</assert>
			<assert test="parent::table">A <name/> should be the child of a table.</assert>
			<assert test="not(@cols) or (count(colspec) &lt;= @cols)">The number of colspecs should not be more than the number in the cols attribute.</assert>
			<!-- attributes -->
			<assert test="@cols">A <name/> should have a cols attribute.</assert>
			<assert test="string-length(@cols) &gt; 0">The cols attribute on <name/> should have a value (a number).</assert>
			<assert test="not(@align) or ((@align='left') or (@align='right') or (@align='center')
       or (@align='justify') or (@align='char'))">The align attribute on <name/> should be "left", "right", "center", "justify" or "char".</assert>
		</rule>
		<rule context="colspec">
			<!-- elements -->
			<report test="*">A <name/> should not have children. It should be an "empty" element.</report>
			<assert test="parent::tgroup">A <name/> should be the child of a tgroup.</assert>
			<report test="preceding-sibling::thead or  preceding-sibling::tbody">A <name/> should come before any theads or tbody.</report>
			<!-- attributes -->
			<assert test="not(@align) or ((@align='left') or (@align='right') or (@align='center')
       or (@align='justify') or (@align='char'))">The align attribute on <name/> should be "left", "right", "center", "justify" or "char".</assert>
			<assert test="not(@colnum) or string-length(@colnum) &gt; 0">The colnum attribute on <name/> should have a value (a number).</assert>
			<assert test="not(@colname) or string-length(@colname) &gt; 0">The colname attribute on <name/> should have a value (a word).</assert>
			<assert test="not(@charoff) or string-length(@charoff) &gt; 0">The charoff attribute on <name/> should have a value (a word).</assert>
			<report test="@colnum and preceding-sibling::colspec[@colnum &gt;= current()/@colnum]">The colnum attributes in each <name/> in a tgroup should be increasing numbers.</report>
			<assert test="not(@colname) or (count(parent::*/colspec[@colname=current()/@colname])=1)">The colname attribute in each <name/> in a tgroup should be unique.</assert>
			<assert test="not(@colname) or (count(parent::*/colspec[@colname=current()/@colname])=1)"   >A colname attribute on <name/> should be unique within the current tgroup.</assert>
			<report test="not(@align='char') and (string-length(normalize-space(@char)) &gt; 0)">The char attribute on <name/> should not be specified when align attribute is not "char".</report>
		</rule>
		<rule context="thead">
			<!-- elements -->
			<report test="preceding-sibling::tbody">A <name/> should come before the tbody.</report>
			<assert test="row">A <name/> should have at least one row.</assert>
			<assert test="parent::tgroup">A <name/> should be the child of a tgroup.</assert>
			<!-- attributes -->
			<assert test="not(@valign) or ((@valign='top') or (@valign='middle') or (@valign='bottom'))">The valign attribute on <name/> should be "top", "middle" or "bottom".</assert>
		</rule>
		<rule context="tbody">
			<!-- elements -->
			<assert test="row">A <name/> should have at least one row.</assert>
			<assert test="parent::tgroup">A <name/> should be the child of a tgroup.</assert>
			<!-- attributes -->
			<assert test="not(@valign) or ((@valign='top') or (@valign='middle') or (@valign='bottom'))">The valign attribute on <name/> should be "top", "middle" or "bottom".</assert>
		</rule>
		<rule context="row">
			<!-- elements -->
			<assert test="entry">A <name/> should have at least one entry.</assert>
			<assert test="parent::thead | parent::tbody">A <name/> should be the child of a thead or tbody.</assert>
			<assert test="not(parent::*/parent::tgroup/@cols) or 
           (parent::*/parent::tgroup/@cols &gt;= count(entry))">A <name/> should have entries not exceeding the number given in the cols attribute on the ancestor tgroup.</assert>
			<!-- that does not check effects of spanning and morerows -->
			<!-- attributes -->
			<assert test="not(@valign) or ((@valign='top') or (@valign='middle') or (@valign='bottom'))">The name attribute on <name/> should be "top", "middle" or "bottom".</assert>
		</rule>
		<rule context="entry">
			<!-- elements -->
			<assert test="parent::row">A <name/> should be the child of a row.</assert>
			<!-- attributes -->
			<assert test="not(@align) or ((@align='left') or (@align='right') or (@align='center')
       or (@align='justify') or (@align='char'))">The align attribute on <name/> should be "left", "right", "center", "justify" or "char".</assert>
			<assert test="not(@valign) or ((@valign='top') or (@valign='middle') or (@valign='bottom'))">The valign attribute on <name/> should be "top", "middle" or "bottom".</assert>
			<assert test="not(@colname) or string-length(@colname) &gt; 0">The colname attribute on <name/> should have a value (a word).</assert>
			<assert test="not(@namest) or string-length(@namest) &gt; 0">The namest attribute on <name/> should have a value (a word).</assert>
			<assert test="not(@nameend) or string-length(@nameend) &gt; 0">The nameend attribute on <name/> should have a value (a word).</assert>
			<assert test="not(@morerows) or string-length(@morerows) &gt; 0">The morerows attribute on <name/> should have a value (a number).</assert>
			<assert test="not(@charoff) or string-length(@charoff) &gt; 0">The charoff attribute on <name/> should have a value (a word).</assert>
			<report test="@morerows &gt; count(
parent::row/following-sibling::row)">The morerows attribute on <name/> should not specify a greater number than there are rows available.</report>
			<assert test="not(@colname) or ancestor::tgroup[1]/colspec[@colname = current()/@colname]">A colname attribute on <name/> should give the name of a colname attribute of a colspec.</assert>
			<assert test="not(@namest) or ancestor::tgroup[position()=1]/colspec[@colname = current()/@namest]">A namest attribute on <name/> should give the name of a colname attribute of a colspec.</assert>
			<assert test="not(@nameend) or ancestor::tgroup[position()=1]/colspec[@colname = current()/@nameend]">A nameend attribute on <name/> should give the name of a colname attribute of a colspec.</assert>
			<!-- this doesn't capture when some colspecs are numbered and others are not -->
			<assert test="not(@namest) or not(@nameend) or 
      not(ancestor::tgroup[position='1']/colspec[@colname=current()/@namest]/@colnum) or
      not(ancestor::tgroup[position='1']/colspec[@colname=current()/@nameend]/@colnum) or
      (ancestor::tgroup[position='1']/colspec[@colname=current()/@namest]/@colnum &lt;
      ancestor::tgroup[position='1']/colspec[@colname=current()/@nameend]/@colnum )">The nameend attribute should specify a column to the right of the namest attribute.</assert>

<!--
			<assert test="not(@namest) or not(@nameend) or 
      ancestor::tgroup[position='1']/colspec[@colname=current()/@namest]/@colnum or
      ancestor::tgroup[position='1']/colspec[@colname=current()/@nameend]/@colnum or
      (ancestor::tgroup[position='1']/colspec[@colname=current()/@namest]/position() &lt;
      ancestor::tgroup[position='1']/colspec[@colname=current()/@nameend]/position() )">The nameend attribute should specify a column to the right of the namest attribute.</assert>
-->
			<!-- this doesn't capture checking against the colspec or when columns are implied -->
			<!-- instead, a loose check is made that any colspec has that value. Better than 0.-->
			<assert test="not(@char) or @namest or
         (count(../entry[@namest=current()/@namest][@char!=current()/@char])=0)">Each char attribute on <name/> in a column should agree.</assert>
			<report test="@char and 
          ancestor::tgroup[position()=1]/colspec[@char=current()/@char]">If a <name/> has a value for char, there should be a colspec with that value.</report>
			<assert test="not(@charoff) or @namest or
         (count(../entry[@namest=current()/@namest][@charoff!=current()/@charoff])=0)">Each charoff attribute on <name/> in a column should agree.</assert>
			<report test="@charoff and 
          ancestor::tgroup[position()=1]/colspec[@charoff=current()/@charoff]">If a <name/> has a value for charoff, there should be a colspec with that value.</report>
		</rule>
	</pattern>

    <pattern name="Report Potential Errors" id="strict">
	<rule context="table">
			<!-- elements -->
			<report test="ancestor::table">A <name/> should not contain another table.</report>
			<!-- attributes -->
			<assert test="not(@colsep) or ((@colsep='1') or (@colsep='0'))">The colsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
			<assert test="not(@rowsep) or ((@rowsep='1') or (@rowsep='0'))">The rowsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
			<assert test="not(@pgwide) or ((@pgwide='1') or (@pgwide='0'))">The pgwide attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
		</rule>
		<rule context="tgroup">
			<!-- elements -->
			<!-- attributes -->
			<assert test="not(@colsep) or ((@colsep='1') or (@colsep='0'))">The colsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
			<assert test="not(@rowsep) or ((@rowsep='1') or (@rowsep='0'))">The rowsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
		</rule>
		<rule context="colspec">
			<!-- elements -->
			<!-- attributes -->
			<assert test="not(@colsep) or ((@colsep='1') or (@colsep='0'))">The colsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
			<assert test="not(@rowsep) or ((@rowsep='1') or (@rowsep='0'))">The rowsep attribute on <name/> is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
     	</rule>

		<rule context="row">
			<!-- elements -->
			<!-- attributes -->
			<assert test="not(@rowsep) or ((@rowsep='1') or (@rowsep='0'))">The rowsep attribute on <name/>  is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
		</rule>
		<rule context="entry">
			<!-- elements -->
			<!-- attributes -->
			<assert test="not(@colsep) or ((@colsep='1') or (@colsep='0'))">The colsep attribute on <name/> is best as "0" (no) or "1" (yes): other values  will be treated as yes. Is this what you expect?</assert>
			<assert test="not(@rowsep) or ((@rowsep='1') or (@rowsep='0'))">The rowsep attribute on <name/>  is best as "0" (no) or "1" (yes): other values will be treated as yes. Is this what you expect?</assert>
		</rule>

	</pattern>

</schema>
