/*
  ########################################################################
  #
  # yads.doi.sample.Sample1 - A Java test class to build a DOI DObject
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
 * The Sample1 class provides a {@link #main} method which gives
 * a demo of building a simple DObject 
 * using named groups, writing the instance out as an RDF
 * description and instantiating a new DObject from this RDF description.
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample1</code>
 * <p>
 * Here's the sample code:
<pre>
  public static void main(String[] argv) {
  
    // Create new DObject

    DObject d = new DObject("10.1234/567");
    
    // Select a DOI Application Profile

    d.forProfile(Common.DOI_PROFILE_DEFAULT);
    
    // Construction using named groups

    Container c = new Container();

    Group g1, g2;

    g1 = new Group();
    g1.addMember("resource", "http://www.doi.org");
    g1.addMember("label", "IDF");
    g1.addMember("detail", "International DOI Foundation.");
    g1.addMember("access", "default");

    g2 = new Group();
    g2.addMember("resource", "http://www.cnri.reston.va.us");
    g2.addMember("label", "CNRI");
    g2.addMember("detail", "Corporation for National Research Initiatives.");

    c.addGroup(g1);
    c.addGroup(g2);
         
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
 * @version	0.1.5
 */
public class Sample1 {

  public static void main(String[] argv) {
  
    // Create new DObject

    DObject d = new DObject("10.1234/567");
    
    // Select a DOI Application Profile

    d.forProfile(Common.DOI_PROFILE_DEFAULT);
    
    // Construction using named groups

    Container c = new Container();

    Group g1, g2;

    g1 = new Group();
    g1.addMember("resource", "http://www.doi.org");
    g1.addMember("label", "IDF");
    g1.addMember("detail", "International DOI Foundation.");
    g1.addMember("access", "default");

    g2 = new Group();
    g2.addMember("resource", "http://www.cnri.reston.va.us");
    g2.addMember("label", "CNRI");
    g2.addMember("detail", "Corporation for National Research Initiatives.");

    c.addGroup(g1);
    c.addGroup(g2);
         
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
