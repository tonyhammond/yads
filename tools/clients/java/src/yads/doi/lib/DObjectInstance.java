/*
  ########################################################################
  #
  # yads.doi.lib.DObjectInstance - A Java class for a DObject RDF instance
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package yads.doi.lib;

/**
 * An instance of a library DObject for test purposes
 * (see {@link DObject#main}).
 * <p>
 * Here's the RDF/XML description: 
<pre>
&lt;rdf:RDF
&nbsp;&nbsp;xmlns:doi="doi:1014/10.system/schema.2001-07-26#"
&nbsp;&nbsp;xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
&gt;
&nbsp;&nbsp;&lt;doi:DObject rdf:about="doi:10.1234/567"&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:contains&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;rdf:Bag&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;rdf:li rdf:parseType="Resource"&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:profile rdf:resource="1014/10.system/profile.zero"/&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:contains&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;rdf:Bag&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;rdf:li rdf:parseType="Resource"&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:resource rdf:resource="http://www.doi.org"/&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:label&gt;IDF&lt;/doi:label&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:detail&gt;International DOI Foundation.&lt;/doi:detail&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:access&gt;default&lt;/doi:access&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/rdf:li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;rdf:li rdf:parseType="Resource"&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:resource rdf:resource="http://www.cnri.reston.va.us"/&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:label&gt;CNRI&lt;/doi:label&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;doi:detail&gt;Corporation for National Research Initiatives.&lt;/doi:detail&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/rdf:li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/rdf:Bag&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/doi:contains&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/rdf:li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/rdf:Bag&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&lt;/doi:contains&gt;
&nbsp;&nbsp;&lt;/doi:DObject&gt;
&lt;/rdf:RDF&gt;
</pre>
 * @author	Tony Hammond
 * @version	0.1.5
 */
public abstract class DObjectInstance {

  public static String RDF = new String();
  private static StringBuffer RDF_ = new StringBuffer();

  static {

    RDF_.append("<rdf:RDF\n");
    RDF_.append("  xmlns:doi=\"doi:1014/10.system/schema.2001-07-26#\"\n");
    RDF_.append("  xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n");
    RDF_.append(">\n");
    RDF_.append("<doi:DObject rdf:about=\"doi:10.1234/567\">\n");
    RDF_.append("<doi:contains>\n");
    RDF_.append("<rdf:Bag>\n");
    RDF_.append("<rdf:li rdf:parseType=\"Resource\">\n");
    RDF_.append("<doi:profile rdf:resource=\"1014/10.system/profile.zero\"/>\n");
    RDF_.append("<doi:contains>\n");
    RDF_.append("<rdf:Bag>\n");
    RDF_.append("<rdf:li rdf:parseType=\"Resource\">\n");
    RDF_.append("<doi:resource rdf:resource=\"http://www.doi.org\"/>\n");
    RDF_.append("<doi:label>IDF</doi:label>\n");
    RDF_.append("<doi:detail>International DOI Foundation.</doi:detail>\n");
    RDF_.append("<doi:access>deault</doi:access>\n");
    RDF_.append("</rdf:li>\n");
    RDF_.append("<rdf:li rdf:parseType=\"Resource\">\n");
    RDF_.append("<doi:resource rdf:resource=\"http://www.cnri.reston.va.us\"/>\n");
    RDF_.append("<doi:label>CNRI</doi:label>\n");
    RDF_.append("<doi:detail>Corporation for National Research Initiatives.</doi:detail>\n");
    RDF_.append("</rdf:li>\n");
    RDF_.append("</rdf:Bag>\n");
    RDF_.append("</doi:contains>\n");
    RDF_.append("</rdf:li>\n");
    RDF_.append("</rdf:Bag>\n");
    RDF_.append("</doi:contains>\n");
    RDF_.append("</doi:DObject>\n");
    RDF_.append("</rdf:RDF>\n");

    RDF = RDF_.toString();
  
  }

}
