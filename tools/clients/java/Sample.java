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
 * The Sample class provides a {@link #main} method which gives
 * a demo of building a simple DObject. 
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample</code>
 * <p>
 * Here's the sample code:
<pre>
  public static void main(String[] argv) {
  
    // Set the DOI and the Application Profile

    String doi = "10.1234/567";
    String profile = Common.DOI_PROFILE_DEFAULT;
    
    // Build a simple container

    Container c = new Container()
    &nbsp;&nbsp;.addResource(new Resource("http://www.doi.org")
    &nbsp;&nbsp;&nbsp;&nbsp;.addLabel("IDF")
    &nbsp;&nbsp;&nbsp;&nbsp;.addDetail("International DOI Foundation.")
    &nbsp;&nbsp;&nbsp;&nbsp;.addAccess("default")
    &nbsp;&nbsp;)
    &nbsp;&nbsp;.addResource(new Resource("http://www.cnri.reston.va.us")
    &nbsp;&nbsp;&nbsp;&nbsp;.addLabel("CNRI")
    &nbsp;&nbsp;&nbsp;&nbsp;.addDetail("Corporation for National Research Initiatives.")
    &nbsp;&nbsp;);
    
    // Create new DObject

    DObject d = new DObject(doi, profile, c);
    
    // Print a simple text description of the DObject

    System.out.print(d);

 }
</pre>
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class Sample {

  public static void main(String[] argv) {
  
    // Set the DOI and the Application Profile

    String doi = "10.1234/567";
    String profile = Common.DOI_PROFILE_DEFAULT;
    
    // Build a simple container

    Container c = new Container()
      .addResource(new Resource("http://www.doi.org")
        .addLabel("IDF")
        .addDetail("International DOI Foundation.")
        .addAccess("default")
      )
      .addResource(new Resource("http://www.cnri.reston.va.us")
        .addLabel("CNRI")
        .addDetail("Corporation for National Research Initiatives.")
      );
    
    // Create new DObject

    DObject d = new DObject(doi, profile, c);
    
    // Print a simple text description of the DObject

    System.out.print(d);

 }

}
