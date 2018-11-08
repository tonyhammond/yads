/*
  ########################################################################
  #
  # yads.doi.sample.Sample6 - A Java test class to build a DOI DObject
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
 * The Sample6 class provides a {@link #main} method which gives
 * a demo of building a simple DObject 
 * using anonymous groups, writing the instance out as an RDF
 * description in Notation3.
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample6</code>
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
    &nbsp;&nbsp;&nbsp;.addMember("access", "default")
    &nbsp;)
    &nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;.addMember("resource", "http://www.cnri.reston.va.us")
    &nbsp;&nbsp;&nbsp;.addMember("label", "CNRI")
    &nbsp;&nbsp;&nbsp;.addMember("detail", "Corporation for National Research Initiatives.")
    &nbsp;);

    // Set the resource hierarchy for this DObject profile

    d.setHierarchy(c);
    
    // Print an RDF/N3 description of the DObject

    System.out.print(d.toNotation3());

 }
</pre>
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class Sample6 {

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
       .addMember("access", "default")
     )
     .addGroup(new Group()
       .addMember("resource", "http://www.cnri.reston.va.us")
       .addMember("label", "CNRI")
       .addMember("detail", "Corporation for National Research Initiatives.")
     );

    // Set the resource hierarchy for this DObject profile

    d.setHierarchy(c);
    
    // Print an RDF/N3 description of the DObject

    System.out.print(d.toNotation3());

 }

}
