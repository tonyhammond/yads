/*
  ########################################################################
  #
  # yads.doi.sample.Sample2 - A Java test class to build a DOI DObject
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package yads.doi.sample;

import yads.doi.lib.*;
import java.io.*;
import java.lang.*;

/**
 * The Sample2 class provides a {@link #main} method which gives
 * a demo of building a simple DObject 
 * using anonymous groups, writing the instance out as an RDF
 * description and instantiating a new DObject from this RDF description.
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample2</code>
 * <p>
 * Here's the sample code:
<pre>
  public static void main(String[] argv) {
  
    // Create new DObject

    DObject d = new DObject("10.1234/567");
    
    // Select a DOI Application Profile

    d.forProfile(Common.DOI_PROFILE_DEFAULT);
    
    // Construction using anonymous groups

    Container c = new Container();

    c.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;.addMember("resource", "http://www.doi.org")
    &nbsp;&nbsp;&nbsp;.addMember("label", "IDF")
    &nbsp;&nbsp;&nbsp;.addMember("detail", "International DOI Foundation.")
    &nbsp;)
    &nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;.addMember("resource", "http://www.handle.net")
    &nbsp;&nbsp;&nbsp;.addMember("label", "CNRI")
    &nbsp;&nbsp;&nbsp;.addMember("detail", "Corporation for National Research Initiatives.")
    &nbsp;);

    // Set the resource hierarchy for this DObject profile

    d.setHierarchy(c);
    
    // Dump a simple text description of the DObject

    d.dump();

    // Print an RDF/XML description of the DObject

    System.out.print(d.toXML());

    // Now create a new anonymous DObject and intantiate from an RDF/XML
    // description of the existing DObject

    DObject e = new DObject();
    e.copy(d);

    System.out.println();
    e.dump();

 }
</pre>
 * @author	Tony Hammond
 * @version	0.1.4
 */
public class Sample2 {

  public static void main(String[] argv) {
  
    // Create new DObject

    DObject d = new DObject("10.1234/567");
    
    // Select a DOI Application Profile

    d.forProfile(Common.DOI_PROFILE_DEFAULT);
    
    // Construction using anonymous groups

    Container c = new Container();

    c.addGroup(new Group()
       .addMember("resource", "http://www.doi.org")
       .addMember("label", "IDF")
       .addMember("detail", "International DOI Foundation.")
     )
     .addGroup(new Group()
       .addMember("resource", "http://www.handle.net")
       .addMember("label", "CNRI")
       .addMember("detail", "Corporation for National Research Initiatives.")
     );

    // Set the resource hierarchy for this DObject profile

    d.setHierarchy(c);
    
    // Dump a simple text description of the DObject

    d.dump();

    // Print an RDF/XML description of the DObject

    System.out.print(d.toXML());

    // Now create a new anonymous DObject and intantiate from an RDF/XML
    // description of the existing DObject

    DObject e = new DObject();
    e.copy(d);

    System.out.println();
    e.dump();

 }

}
