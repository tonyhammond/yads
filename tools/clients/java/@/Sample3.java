/*
  ########################################################################
  #
  # yads.doi.sample.Sample3 - A Java test class to build a DOI DObject
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
 * The Sample3 class provides a {@link #main} method which gives
 * a demo of building an extended DObject 
 * using cascaded method calls which build up a complex resource hierarchy
 * that exhibits all three allowed orderings: GROUP_ALTERNATE,
 * GROUP_SEQUENCED, GROUP_UNORDERED (see {@link DObjectMap}).
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample3</code>
 * <p>
 * Here's the sample code:
<pre>
  public static void main(String[] argv) {
  
    // Create a new DObject

    DObject d = new DObject("10.1045/july2001-contents");

    // Create table of contents groups

    Group contents1 = new Group()
    &nbsp;&nbsp;.addContainer
    &nbsp;&nbsp;&nbsp;&nbsp;(new Container()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:title_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Generalizing the OpenURL Framework beyond References to Scholarly Works: The Bison-Fute Model")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:author_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Herbert Van de Sompel, Cornell University and Oren Beit-Arie, Ex Libris (USA) Inc.")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;);

    Group contents2 = new Group()
    &nbsp;&nbsp;.addContainer
    &nbsp;&nbsp;&nbsp;&nbsp;(new Container()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:title_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Digital Libraries and Education:Trends and Opportunities")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:author_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Hans Roes, Tilburg University Library")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;);

    Group contents3 = new Group()
    &nbsp;&nbsp;.addContainer
    &nbsp;&nbsp;&nbsp;&nbsp;(new Container()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:title_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "E-Books and Their Future in Academic Libraries: An Overview")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:author_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Lucia Snowhill, University of California, Santa Barbara")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;);

    Group contents4 = new Group()
    &nbsp;&nbsp;.addContainer
    &nbsp;&nbsp;&nbsp;&nbsp;(new Container()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:title_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Penn State Visual Image User Study")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("type", "dlib:author_string")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.addMember("label", "Henry Pisciotta, Roger Brisson, Eric Ferrin, Michael Dooris, and Amanda Spink, Pennsylvania State University")
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
    &nbsp;&nbsp;&nbsp;&nbsp;);

    // Add the table of contents groups to a sequenced container

    Container contents = new Container(DObjectMap.GROUP_SEQUENCED)
    &nbsp;&nbsp;.addGroup(contents1)
    &nbsp;&nbsp;.addGroup(contents2)
    &nbsp;&nbsp;.addGroup(contents3)
    &nbsp;&nbsp;.addGroup(contents4);

    // Create the originating site

    Group origin_ = new Group()
    &nbsp;&nbsp;.addMember("resource", "http://www.dlib.org/dlib/may01/05contents.html")
    &nbsp;&nbsp;.addMember("label", "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A.")
    &nbsp;&nbsp;.addMember("detail", "Originating site - USA.");

    // Create the mirror sites

    Group mirror1 = new Group()
    &nbsp;&nbsp;.addMember("resource", "http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/may01/05contents.html")
    &nbsp;&nbsp;.addMember("label", "UKOLN: The UK Office for Library and Information Networking, Bath, England")
    &nbsp;&nbsp;.addMember("detail", "Mirror site - UK.");

    Group mirror2 = new Group()
    &nbsp;&nbsp;.addMember("resource", "http://sunsite.anu.edu.au/mirrors/dlib/dlib/may01/05contents.html")
    &nbsp;&nbsp;.addMember("label", "The Australian National University Sunsite, Canberra, Australia")
    &nbsp;&nbsp;.addMember("detail", "Mirror site - Australia.");

    Group mirror3 = new Group()
    &nbsp;&nbsp;.addMember("resource", "http://webdoc.sub.gwg.de/edoc/aw/d-lib/dlib/may01/05contents.html")
    &nbsp;&nbsp;.addMember("label", "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany")
    &nbsp;&nbsp;.addMember("detail", "Mirror site - Germany.");

    Group mirror4 = new Group()
    &nbsp;&nbsp;.addMember("resource", "http://www.dlib.org.ar/dlib/may01/05contents.html")
    &nbsp;&nbsp;.addMember("label", "Universidad de Belgrano, Buenos Aires, Argentina")
    &nbsp;&nbsp;.addMember("detail", "Mirror site - Argentina.");

    // Add the mirror site groups to an alternates container

    Container mirrors = new Container(DObjectMap.GROUP_ALTERNATE)
    &nbsp;&nbsp;.addGroup(origin_)
    &nbsp;&nbsp;.addGroup(mirror1)
    &nbsp;&nbsp;.addGroup(mirror2)
    &nbsp;&nbsp;.addGroup(mirror3)
    &nbsp;&nbsp;.addGroup(mirror4);

    // Build toplevel container and attach table of contents and
    // mirror sites containers

    Container c = new Container()
    &nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;.addMember("detail", "Table of Contents for July 2001 issue of D-Lib magazine.")
    &nbsp;&nbsp;&nbsp;&nbsp;.addContainer(contents)
    &nbsp;&nbsp;)
    &nbsp;&nbsp;.addGroup(new Group()
    &nbsp;&nbsp;&nbsp;&nbsp;.addMember("detail", "Original and mirror websites.")
    &nbsp;&nbsp;&nbsp;&nbsp;.addContainer(mirrors)
    &nbsp;&nbsp;);

    // Now add the resource hierarchy to the DObject

    d.forProfile("doi:10.system/profile.dlib_magazine");
    d.setHierarchy(c);

    // Print an RDF/XML description of the DObject

    System.out.print(d.toXML());

  }
</pre>
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
public class Sample3 {

  public static void main(String[] argv) {
  
    // Create a new DObject

    DObject d = new DObject("10.1045/july2001-contents");

    // Create table of contents groups

    Group contents1 = new Group()
      .addContainer
        (new Container()
          .addGroup(new Group()
            .addMember("type", "dlib:title_string")
            .addMember("label", "Generalizing the OpenURL Framework beyond References to Scholarly Works: The Bison-Fute Model")
          )
          .addGroup(new Group()
            .addMember("type", "dlib:author_string")
            .addMember("label", "Herbert Van de Sompel, Cornell University and Oren Beit-Arie, Ex Libris (USA) Inc.")
          )
        );

    Group contents2 = new Group()
      .addContainer
        (new Container()
          .addGroup(new Group()
            .addMember("type", "dlib:title_string")
            .addMember("label", "Digital Libraries and Education:Trends and Opportunities")
          )
          .addGroup(new Group()
            .addMember("type", "dlib:author_string")
            .addMember("label", "Hans Roes, Tilburg University Library")
          )
        );

    Group contents3 = new Group()
      .addContainer
        (new Container()
          .addGroup(new Group()
            .addMember("type", "dlib:title_string")
            .addMember("label", "E-Books and Their Future in Academic Libraries: An Overview")
          )
          .addGroup(new Group()
            .addMember("type", "dlib:author_string")
            .addMember("label", "Lucia Snowhill, University of California, Santa Barbara")
          )
        );

    Group contents4 = new Group()
      .addContainer
        (new Container()
          .addGroup(new Group()
            .addMember("type", "dlib:title_string")
            .addMember("label", "Penn State Visual Image User Study")
          )
          .addGroup(new Group()
            .addMember("type", "dlib:author_string")
            .addMember("label", "Henry Pisciotta, Roger Brisson, Eric Ferrin, Michael Dooris, and Amanda Spink, Pennsylvania State University")
          )
        );

    // Add the table of contents groups to a sequenced container

    Container contents = new Container(DObjectMap.GROUP_SEQUENCED)
      .addGroup(contents1)
      .addGroup(contents2)
      .addGroup(contents3)
      .addGroup(contents4);

    // Create the originating site

    Group origin_ = new Group()
      .addMember("resource", "http://www.dlib.org/dlib/may01/05contents.html")
      .addMember("label", "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A.")
      .addMember("detail", "Originating site - USA.");

    // Create the mirror sites

    Group mirror1 = new Group()
      .addMember("resource", "http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/may01/05contents.html")
      .addMember("label", "UKOLN: The UK Office for Library and Information Networking, Bath, England")
      .addMember("detail", "Mirror site - UK.");

    Group mirror2 = new Group()
      .addMember("resource", "http://sunsite.anu.edu.au/mirrors/dlib/dlib/may01/05contents.html")
      .addMember("label", "The Australian National University Sunsite, Canberra, Australia")
      .addMember("detail", "Mirror site - Australia.");

    Group mirror3 = new Group()
      .addMember("resource", "http://webdoc.sub.gwg.de/edoc/aw/d-lib/dlib/may01/05contents.html")
      .addMember("label", "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany")
      .addMember("detail", "Mirror site - Germany.");

    Group mirror4 = new Group()
      .addMember("resource", "http://www.dlib.org.ar/dlib/may01/05contents.html")
      .addMember("label", "Universidad de Belgrano, Buenos Aires, Argentina")
      .addMember("detail", "Mirror site - Argentina.");

    // Add the mirror site groups to an alternates container

    Container mirrors = new Container(DObjectMap.GROUP_ALTERNATE)
      .addGroup(origin_)
      .addGroup(mirror1)
      .addGroup(mirror2)
      .addGroup(mirror3)
      .addGroup(mirror4);

    // Build toplevel container and attach table of contents and
    // mirror sites containers

    Container c = new Container()
      .addGroup(new Group()
        .addMember("detail", "Table of Contents for July 2001 issue of D-Lib magazine.")
        .addContainer(contents)
      )
      .addGroup(new Group()
        .addMember("detail", "Original and mirror websites.")
        .addContainer(mirrors)
      );

    // Now add the resource hierarchy to the DObject

    d.forProfile("doi:10.system/profile.dlib_magazine");
    d.setHierarchy(c);

    // Print an RDF/XML description of the DObject

    System.out.print(d.toXML());

  }

}
