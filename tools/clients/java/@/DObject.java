/*
  ########################################################################
  #
  # yads.doi.lib.DObject - A Java class for manipulating DOI DObjects
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package yads.doi.lib;

import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;

import org.apache.oro.text.perl.*;
import org.apache.oro.text.regex.*;

/**
 * A DObject manages the resource hierarchy associated 
 * with a DOI public identifier. This class defines methods for
 * manipulating and persisting DObjects. DObjects are serialized across
 * client/service transactions as RDF/XML instances (see {@link 
 * DObjectInstance})..
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
public class DObject {

  static PrintStream out = System.out;

  static int nDObjects = 0;	// Class DObject number

  private int nDObject;		// Number of this DObject within class
  private String doi;		// DOI for this DObject
  private HashMap dataObject;	// Data element type/value pairs keyed on index
  private HashMap dataTypes;	// Hash keyed on data type with list of data values
  private int dataIndex;	// Next available index for dataObject hash
  private String dataMap;	// Map of indexes within Groups

  /**
   * Constructor for an anonymous DObject.
   */
  public DObject() {

    this ("");

  }

  /**
   * Constructor for a named DObject.
   *
   * @param doi  public identifier for this DObject - the DOI
   */
  public DObject(String doi) {
  
    nDObjects++;
    this.nDObject = nDObjects;

    this.doi = doi;
    this.dataObject = new HashMap();
    this.dataTypes = new HashMap();
 
    this.dataIndex = 0;
    this.dataMap = new String();

  } 

  /**
   * Constructor for a named DObject with profile.
   *
   * @param doi  String public identifier for this DObject - the DOI
   * @param profile  String DOI Application Profile
   */
  public DObject(String doi, String profile) {
  
    this(doi);
    this.forProfile(profile);

  } 

  /**
   * Constructor for a named DObject with profile and hierarchy.
   *
   * @param doi  String public identifier for this DObject - the DOI
   * @param profile  String DOI Application Profile
   * @param hierarchy  Container the reesource hierarchy
   */
  public DObject(String doi, String profile, Container hierarchy) {
  
    this(doi);
    this.forProfile(profile);
    this.setHierarchy(hierarchy);

  } 

  // Wrapper for fetch from DataStore

  /**
   * Retrieves Groups from the persisted DObject within the DataStore
   * identified by <code>doi</code> and use them to populate the current
   * DObject instance.
   */
  public DObject readDataStore() {

    _getDataFromStore();

    return this;

  }

  // Wrapper for put to DataStore

  /**
   * Generic method for modifying a DObject copy within the DataStore with 
   * the Groups present within the current DObject instance.
   *
   * @param auth     an authentication object
   * @param request  specifies the type of operation
   *
   * @see            DObject#createDataStore
   * @see            DObject#deleteDataStore
   * @see            DObject#writeDataStore
   */
  private void _writeDataStore(Authentication auth, String request) {

    _putDataToStore(auth, request);

  }

  // Convenience wrappers for specific writeDataStore methods

  /**
   * Creates a persisted copy of the current DObject instance within the DataStore.
   *
   * @param auth     an authentication object
   */
  public void createDataStore(Authentication auth) {

    _writeDataStore(auth, Common.DATA_STORE_CALL_CREATE);

  }

  /**
   * Deletes the persisted copy of the current DObject instance within the DataStore.
   *
   * @param auth     an authentication object
   */
  public void deleteDataStore(Authentication auth) {

    _writeDataStore(auth, Common.DATA_STORE_CALL_DELETE);

  }

  /**
   * Writes a persisted copy of the current DObject instance within the DataStore.
   *
   * @param auth     an authentication object
   */
  public void writeDataStore(Authentication auth) {

    _writeDataStore(auth, Common.DATA_STORE_CALL_WRITE);

  }

/*
  ########################################################################
  #
  ########################################################################
*/

  /**
   * Returns the DObject types within the current DObject instance.
   *
   * @return          list of string values of DObject data types
   */
  public ArrayList getDataTypes() {

    List l = new ArrayList();

    for (Iterator i_ = dataTypes.entrySet().iterator(); i_.hasNext(); ) {
      Map.Entry e = (Map.Entry)i_.next();
      l.add(e.getKey().toString());
    }
    return (ArrayList) l;

  }

  /**
   * Returns the DObject values within the current DObject instance.
   *
   * @return          list of string values of DObject data values
   */
  public ArrayList getDataValues() {

    List l = new ArrayList();
    List list;
    String s;

    for (Iterator i_ = dataTypes.entrySet().iterator(); i_.hasNext(); ) {
      Map.Entry e = (Map.Entry)i_.next();
      s = (String)e.getKey();
      list = (ArrayList)dataTypes.get(s);
      for (Iterator j_ = list.iterator(); j_.hasNext(); ) {
        l.add(j_.next().toString());
      }
    }
    return (ArrayList) l;

  }

  // Set accessor method for DObject name - the DOI

  /**
   * Returns the DObject name - the DOI.
   *
   * @return          the DOI string for this DObject
   */
  public String getDOI() {
    return this.doi;
  }

  // Set accessor methods for individual types

  /**
   * Returns data values of DObject type 'access' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'access'
   */
  public ArrayList getAccesses() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_ACCESS);
  }

  /**
   * Returns data values of DObject type 'agent' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'agent'
   */
  public ArrayList getAgents() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_AGENT);
  }

  /**
   * Returns data values of DObject type 'detail' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'detail'
   */
  public ArrayList getDetails() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_DETAIL);
  }

  /**
   * Returns data values of DObject type 'label' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'label'
   */
  public ArrayList getLabels() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_LABEL);
  }

  /**
   * Returns data values of DObject type 'null' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'null'
   */
  public ArrayList getNulls() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_NULL);
  }

  /**
   * Returns data values of DObject type 'profile' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'profile'
   */
  public ArrayList getProfiles() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_PROFILE);
  }

  /**
   * Returns data values of DObject type 'resolve' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'resolve'
   */
  public ArrayList getResolves() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_RESOLVE);
  }

  /**
   * Returns data values of DObject type 'resource' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'resource'
   */
  public ArrayList getResources() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_RESOURCE);
  }

  /**
   * Returns data values of DObject type 'role' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'role'
   */
  public ArrayList getRoles() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_ROLE);
  }

  /**
   * Returns data values of DObject type 'schema' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'schema'
   */
  public ArrayList getSchemas() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_SCHEMA);
  }

  /**
   * Returns data values of DObject type 'service' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'service'
   */
  public ArrayList getServices() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_SERVICE);
  }

  /**
   * Returns data values of DObject type 'type' for the current DObject
   * instance.
   *
   * @return          list of string values of DObject type 'type'
   */
  public ArrayList getTypes() {
    return (ArrayList)dataTypes.get(DObjectTypes.DOI_TYPE_TYPE);
  }

  // Define a set of type test methods

  private boolean _isOfType(String type, String s) {
  
    boolean test = false;
    Iterator i_;

    for (i_ = ((ArrayList)dataTypes.get(type)).iterator(); i_.hasNext(); ) {
      if (i_.next().equals(s)) {
        test = true; break;
      }
    }
    return test;
  }

  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'access'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'access', <code>false</code> otherwise.
   */
  public boolean hasAccess(String s) {
    return _isOfType(DObjectTypes.DOI_TYPE_ACCESS, s);
  }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'agent'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'agent', <code>false</code> otherwise.
   */
  public boolean hasAgent(String s) {
    return _isOfType(DObjectTypes.DOI_TYPE_AGENT, s);
  }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'detail'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'detail', <code>false</code> otherwise.
   */
   public boolean hasDetail(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_DETAIL, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'label'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'label', <code>false</code> otherwise.
   */
  public boolean hasLabel(String s) {
    return _isOfType(DObjectTypes.DOI_TYPE_LABEL, s);
  }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'null'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'null', <code>false</code> otherwise.
   */
   public boolean hasNull(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_NULL, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'profile'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'profile', <code>false</code> otherwise.
   */
   public boolean hasProfile(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_PROFILE, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'resolve'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'resolve', <code>false</code> otherwise.
   */
   public boolean hasResolve(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_RESOLVE, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'resource'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'resource', <code>false</code> otherwise.
   */
   public boolean hasResource(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_RESOURCE, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'role'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'role', <code>false</code> otherwise.
   */
   public boolean hasRole(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_ROLE, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'schema'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'schema', <code>false</code> otherwise.
   */
  public boolean hasSchema(String s) {
    return _isOfType(DObjectTypes.DOI_TYPE_SCHEMA, s);
  }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'service'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'service', <code>false</code> otherwise.
   */
   public boolean hasService(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_SERVICE, s);
   }
  
  /**
   * Tests a string to determine if the current DObject instance has this resource as type 'type'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DObject type
   *                  'type', <code>false</code> otherwise.
   */
   public boolean hasType(String s) {
     return _isOfType(DObjectTypes.DOI_TYPE_TYPE, s);
   }
  

/*
  ########################################################################
  #
  ########################################################################
*/


  // public ArrayList getGroups() {
  public void getGroups() {

    // return this.aGroups;

  }


  /** 
   * Prints dump of the current DObject instance Map.
   */
  public void dumpMap() {

    out.println("DObject Map = " + this.dataMap + "\n");

  }


  /** 
   * Prints dump of the current DObject instance.
   */
  public void dumpGroups() {

    out.println("Dump for <doi:" + this.doi + ">\n");
    out.println("DObject Map = " + this.dataMap + "\n");
    out.print(this.toString());

  }

  /** 
   * Prints dump of the current DObject instance.
   */
  public void dump() {

    this.dumpGroups();

  }

  /** 
   * Copies a DObject instance.
   */
  public DObject copy(DObject d) {

    this.fromXML(d.toXML());

    return this;

  }


  /** 
   * Returns a string description of the current DObject instance
   * as a simple text dump.
   *
   * @param          string - a simple text dump
   */
  public String toString() {

    String s;
    String type, data;

    StringBuffer dump = new StringBuffer();
    int nGroups = 0;
    int indent = -1;

    Perl5Util re = new Perl5Util();

    StringTokenizer st = new StringTokenizer(this.dataMap);

    dump.append("DObject <doi:" + this.doi + "> =>\n");

    // Now run though the DOI handle map

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();

      if (s.equals(DObjectMap.GROUP_OPEN)
          || s.equals(DObjectMap.GROUP_ALTERNATE_OPEN)
          || s.equals(DObjectMap.GROUP_SEQUENCED_OPEN)
          || s.equals(DObjectMap.GROUP_UNORDERED_OPEN)) {
        indent++;
        for (int i = 1; i <= indent; i++) { dump.append("  "); }
        dump.append(s + "\n");
      }
      else if (s.equals(DObjectMap.GROUP_CLOSE)
               || s.equals(DObjectMap.GROUP_ALTERNATE_CLOSE)
               || s.equals(DObjectMap.GROUP_SEQUENCED_CLOSE)
               || s.equals(DObjectMap.GROUP_UNORDERED_CLOSE)) {
        for (int i = 1; i <= indent; i++) { dump.append("  "); }
        dump.append(s + "\n");
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];

        data = re.substitute("s/&lt;/\\</g", data);
        data = re.substitute("s/&gt;/\\>/g", data);
        data = re.substitute("s/&amp;/\\&/g", data);

        for (int i = 1; i <= indent; i++) { dump.append("  "); }
        if (DObjectTypes.isRDFLiteral(type)) {
          dump.append("  " + type + " => \"" + data + "\"\n");
        }
        else if (DObjectTypes.isRDFResource(type)) {
          dump.append("  " + type + " => <" + data + ">\n");
        }
        else {
          // What? - Just ignore?
        }
      }
    }

    return dump.toString();

  }

/*
  ########################################################################
  #
  ########################################################################
*/

  /** 
   * Reads the current DObject instance from an RDF/XML description.
   *
   * @param          string - an RDF/XML description
   * @return         DObject
   */
  public DObject fromXML(String sRDF) {

    String s = new String();
    String type = new String();
    String data = new String();

    StringBuffer dataBuffer = new StringBuffer();

    String line;
    List lines = new ArrayList();

    StringBuffer dataMapBuffer = new StringBuffer();

    Perl5Util re = new Perl5Util();
    MatchResult match;

    // Reset instance variables - this method will clobber any
    // existing variables

    this.dataObject.clear();
    this.dataTypes.clear();
    this.dataMap = "";
    this.dataIndex = 0;
 
    try {
      re.split(lines, "/\\n/", sRDF);
    }
    catch (MalformedPerl5PatternException x) { out.println("Problem with re: " + x.getMessage()); }
    
    for (Iterator i_ = lines.iterator(); i_.hasNext(); ) {

      line = ((String)i_.next()).trim();

      // On an RDF doi:DObject typed node

      if (line.startsWith("<doi:DObject")) {
        StringTokenizer st = new StringTokenizer(line, "\"");

        s = (String)st.nextToken();
        doi = ((String)st.nextToken()).substring(4);
        continue;
      }

      // RE match problem with "/" character
      //
      // if (re.match("/<doi:DObject rdf:about=\"doi:(.*?)\"", line)) {
      //   doi = match.group(1);
      // }

      // On an RDF Bag container open tag

      else if (re.match("/<rdf:Bag>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_UNORDERED_OPEN);
      }

      // On an RDF Bag container close tag

      else if (re.match("/<\\/rdf:Bag>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_UNORDERED_CLOSE);
      }

      // On an RDF Seq container open tag

      else if (re.match("/<rdf:Seq>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_SEQUENCED_OPEN);
      }

      // On an RDF Seq container close tag

      else if (re.match("/<\\/rdf:Seq>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_SEQUENCED_CLOSE);
      }

      // On an RDF Alt container open tag

      else if (re.match("/<rdf:Alt>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_ALTERNATE_OPEN);
      }

      // On an RDF Alt close container tag

      else if (re.match("/<\\/rdf:Alt>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_ALTERNATE_CLOSE);
      }

      // On an RDF anonymous resource open tag

      else if (re.match("/<rdf:li rdf:parseType=\"Resource\">/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_OPEN);
      }

      // On an RDF anonymous resource close tag

      else if (re.match("/<\\/rdf:li>/", line)) {
        dataMapBuffer.append(" " + DObjectMap.GROUP_CLOSE);
      }

      // Skip the DOI container property open/close tags

      else if (re.match("/<\\/?doi:contains>/", line)) {
      }

      //  The only other lines for parsing are the data elements

      else if (re.match("/<doi:/", line)) {

        type = data = null;

        if (re.match("/<doi:(\\w+)>(.*?)<\\/doi:\\w+>/", line)) {
          
          match = re.getMatch();
          type = match.group(1); data = match.group(2);

        }
        else if (re.match("/<doi:(\\w+) rdf:resource=\"(.*?)\"\\/>/", line)) {
          
          match = re.getMatch();
          type = match.group(1); data = match.group(2);

        }

        // Test whether this type is a legitimate DObject type

        if (DObjectTypes.isDObjectType(type)) {

          // Add the element type/data pair to the dataObject hash

          s = Integer.toString(this.dataIndex);
          this.dataObject.put(s, new String[] { type, data });
          dataMapBuffer.append(" " + s);
          this.dataIndex++;

          // Push the data onto the dataTypes hash

          List l = (ArrayList)(this.dataTypes.get(type));
          if  (l == null) {
            l = new ArrayList();
          }
          l.add(data);
          this.dataTypes.put(type, l);
        
        }

      }

    }

    // Set the dataMap

    this.dataMap = dataMapBuffer.toString().trim();

    // Return the dataObject

    return this;

  }


  /** 
   * Returns a string description of the current DObject instance
   * in RDF/XML.
   *
   * @return          string - an RDF/XML description
   */
  public String toXML() {

    String s = new String();
    String type = new String();
    String data = new String();
    int indent = 0;

    StringBuffer XML_Buffer = new StringBuffer();

    Perl5Util re = new Perl5Util();

    XML_Buffer.append("<rdf:RDF\n");
    XML_Buffer.append("  xmlns:doi=\"" + Common.DOI_OBJECT_SCHEMA + "\"\n");
    XML_Buffer.append("  xmlns:rdf=\"" + Common.RDF_SYNTAX_SCHEMA + "\"\n");
    XML_Buffer.append(">\n");
    XML_Buffer.append("  <doi:DObject rdf:about=\"doi:" + this.doi + "\">\n");
  
    indent++;
  
    // Now run though the DOI handle map
  
    StringTokenizer st = new StringTokenizer(dataMap);
  
    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();
  
      if (s.equals(DObjectMap.GROUP_UNORDERED_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<rdf:Bag>\n");
      }
      else if (s.equals(DObjectMap.GROUP_UNORDERED_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</rdf:Bag>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_SEQUENCED_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<rdf:Seq>\n");
      }
      else if (s.equals(DObjectMap.GROUP_SEQUENCED_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</rdf:Seq>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_ALTERNATE_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<rdf:Alt>\n");
      }
      else if (s.equals(DObjectMap.GROUP_ALTERNATE_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</rdf:Alt>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("<rdf:li rdf:parseType=\"Resource\">\n");
      }
      else if (s.equals(DObjectMap.GROUP_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          XML_Buffer.append("  ");
        }
        XML_Buffer.append("</rdf:li>\n");
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];
  
        data = re.substitute("s/\\</&lt;/g", data);
        data = re.substitute("s/\\>/&gt;/g", data);
        data = re.substitute("s/\\&/&amp;/g", data);

        for (int i = 0; i <= indent; i++) {
          XML_Buffer.append("  ");
        }
        if (DObjectTypes.isRDFLiteral(type)) {
          XML_Buffer.append("<doi:" + type + ">");
        }
        else if (DObjectTypes.isRDFResource(type)) {
          XML_Buffer.append("<doi:" + type + " rdf:resource=\"");
        }
        else {
          // What? - Just ignore?
        }
  
        XML_Buffer.append(data);
  
        if (DObjectTypes.isRDFLiteral(type)) {
          XML_Buffer.append("</doi:" + type + ">\n");
        }
        else if (DObjectTypes.isRDFResource(type)) {
          XML_Buffer.append("\"/>\n");
        }
        else {
          // What? - Just ignore?
        }
   
      }

    }
    XML_Buffer.append("  </doi:DObject>\n");
    XML_Buffer.append("</rdf:RDF>\n");
  
    return XML_Buffer.toString();

  }

  /** 
   * Returns a string description of the current DObject instance
   * in RDF/N3.
   *
   * @return          string - an RDF/N3 description
   */
  public String toNotation3() {

    String s = new String();
    String type = new String();
    String data = new String();
    int indent = 0;

    StringBuffer N3_Buffer = new StringBuffer();

    Perl5Util re = new Perl5Util();

    N3_Buffer.append("@prefix :doi <" + Common.DOI_OBJECT_SCHEMA + "> .\n");
    N3_Buffer.append("@prefix :rdf <" + Common.RDF_SYNTAX_SCHEMA + "> .\n");
    N3_Buffer.append("\n");
    N3_Buffer.append("<doi:" + this.doi + "> a DObject ;\n");
  
    // Now run though the DOI handle map
  
    StringTokenizer st = new StringTokenizer(dataMap);
  
    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();
  
      if (s.equals(DObjectMap.GROUP_UNORDERED_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("doi:contains [\n");
      }
      else if (s.equals(DObjectMap.GROUP_UNORDERED_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("a rdf:Bag ] ;\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_SEQUENCED_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("doi:contains [\n");
      }
      else if (s.equals(DObjectMap.GROUP_SEQUENCED_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("a rdf:Seq ] ;\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_ALTERNATE_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("doi:contains [\n");
      }
      else if (s.equals(DObjectMap.GROUP_ALTERNATE_CLOSE)) {
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("a rdf:Alt ] ;\n");
        indent--;
      }
      else if (s.equals(DObjectMap.GROUP_OPEN)) {
        indent++;
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("rdf:li [\n");
      }
      else if (s.equals(DObjectMap.GROUP_CLOSE)) {
        // sData.chomp!; sData.chop!; sData << "\n"
        N3_Buffer.deleteCharAt(N3_Buffer.length() - 2);
        for (int i = 0; i < indent; i++) {
          N3_Buffer.append("  ");
        }
        N3_Buffer.append("] ;\n");
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];
  
        data = re.substitute("s/\\</&lt;/g", data);
        data = re.substitute("s/\\>/&gt;/g", data);
        data = re.substitute("s/\\&/&amp;/g", data);

        for (int i = 0; i <= indent; i++) {
          N3_Buffer.append("  ");
        }
        if (DObjectTypes.isRDFLiteral(type)) {
          N3_Buffer.append("doi:" + type + " \"" + data + "\" ;\n");
        }
        else if (DObjectTypes.isRDFResource(type)) {
          N3_Buffer.append("doi:" + type + " <" + data + "> ;\n");
        }
        else {
          // What? - Just ignore?
        }
  
      }

    }
    // sData.chomp!; sData.chop!; sData << ".\n"
    N3_Buffer.deleteCharAt(N3_Buffer.length() - 1);
    N3_Buffer.deleteCharAt(N3_Buffer.length() - 1);
    N3_Buffer.append(".\n");
  
    return N3_Buffer.toString();

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  /**
  */

  private DObject _getDataFromStore() {

    return this.fromXML(_getDataValues(this.doi));

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  /**
  */

  private void _putDataToStore(Authentication auth, String request) {

    String s = new String();
    String type = new String();
    String data = new String();

    StringBuffer dataBuffer = new StringBuffer();

    dataBuffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    dataBuffer.append("<SOAP-ENV:Envelope\n");
    dataBuffer.append("  xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\n");
    dataBuffer.append("  SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"\n");
    dataBuffer.append(">\n");
    dataBuffer.append("<SOAP-ENV:Body>\n");
    dataBuffer.append("<YADS:" + request + "\n");
    dataBuffer.append("  xmlns:YADS=\"http://dx.doi.org/1014/doi.service\"\n");
    dataBuffer.append(">\n");
    dataBuffer.append("<yads:authentication>");
    dataBuffer.append("<yads:username>" + auth.getUsername() + "</yads:username>\n");
    dataBuffer.append("<yads:password>" + auth.getPassword() + "</yads:password>\n");
    dataBuffer.append("</yads:authentication>");
    dataBuffer.append(this.toXML());
    dataBuffer.append("</YADS:" + request + ">\n");
    dataBuffer.append("</SOAP-ENV:Body>\n");
    dataBuffer.append("</SOAP-ENV:Envelope>\n");

    // out.println(dataBuffer.toString());

    out.print(_setDataValues(dataBuffer.toString()));

  }

/*
  ########################################################################
  #
  # The following private methods ...
  #
  ########################################################################
*/


  // 
  private String _getDataValues(String doi) {

    String host = Common.DOI_SERVICE_HOST;
    String path = Common.DOI_SERVICE_PATH + "?xml=true&doi=" + doi;
    
    return _getXMLFromService(host, path);

  }

  private String _setDataValues(String data) {

    String host = Common.DOI_SERVICE_HOST;
    String path = Common.DOI_SERVICE_PATH + "?data=" + URLEncoder.encode(data);
    
    return _getXMLFromService(host, path);

  }

  private String _getXMLFromService(String host, String path) {

    StringBuffer XML = new StringBuffer();

    try {
      URL url = new URL("http://" + host + path);

      // DataInputStream dis = new DataInputStream(url.openStream());
      BufferedReader dis
          = new BufferedReader(new InputStreamReader(url.openStream()));
 
      String inputLine;

      while ((inputLine = dis.readLine()) != null) {
        XML.append(inputLine + "\n");
      }
      dis.close();
    } catch (MalformedURLException me) {
       out.println("MalformedURLException: " + me);
    } catch (IOException ioe) {
       out.println("IOException: " + ioe);
    }

    return XML.toString();

  }


/*
  ########################################################################
  #
  ########################################################################
*/

  // 

  /**
   * Selects the default DOI Application Profile.
   */
  public DObject forProfile() {

    return this.forProfile(Common.DOI_PROFILE_DEFAULT);

  }

  // 

  /**
   * Selects the named DOI Application Profile.
   *
   * @param profile         the DOI Application Profile
   */
  public DObject forProfile(String profile) {

    List l;
    Iterator i_;

    String s = new String();
    String type = new String();
    String data = new String();
    
    int indexProfile = 0;

    // See whether we need to add in a value for the profile

    if (!(this.dataTypes.containsKey(DObjectTypes.DOI_TYPE_PROFILE)
          && ((ArrayList)this.dataTypes.get(DObjectTypes.DOI_TYPE_PROFILE)).contains(profile))) {

      // Husk: Make check that profile is legitimate

      s = Integer.toString(this.dataIndex);
      type = DObjectTypes.DOI_TYPE_PROFILE;
      data = profile;
      this.dataObject.put(s, new String[] { type, data });
      indexProfile = this.dataIndex;

      l = new ArrayList();
      l.add(data);
      dataTypes.put(type, l);

    }
    else {

      for (i_ = this.dataObject.entrySet().iterator(); i_.hasNext(); ) {
        Map.Entry e = (Map.Entry)i_.next();
        s = (String)e.getKey();
        type = ((String [])this.dataObject.get(s))[0];
        data = ((String [])this.dataObject.get(s))[1];
        if (type.equals(DObjectTypes.DOI_TYPE_PROFILE)
            && data.equals(profile)) {
          indexProfile = Integer.parseInt(s);
          break;
        }
      }

    }

    return this;

  }

  //

  /**
   * Sets the resource hierarchy for the current DOI Application Profile.
   *
   * @param container         the resource hierarchy
   */
  public DObject setHierarchy(Container container) {

    // Set the dataMap

    this.dataMap += DObjectMap.GROUP_UNORDERED_OPEN + " ";
    this.dataMap += DObjectMap.GROUP_OPEN + " " + Integer.toString(this.dataIndex);

    this.addContainer_((Group)container);

    this.dataMap += " " + DObjectMap.GROUP_CLOSE;
    this.dataMap += " " + DObjectMap.GROUP_UNORDERED_CLOSE;

    return this;

  }

  //

  private void addContainer_(Group group) {

    String s;
    String type, data;

    String groupO = "";
    String groupC = "";

    // Set the dataMap

    Iterator i_;
    List l = group.getMembers();
    Object[] member;
    for (i_ = l.iterator(); i_.hasNext(); ) {

      member = (Object[])i_.next();
      type = (String)member[0];

      if (type.equals("order")) {
        data = (String)member[1];
        if (data.equals(DObjectMap.GROUP_ALTERNATE)) {
          groupO = DObjectMap.GROUP_ALTERNATE_OPEN;
          groupC = DObjectMap.GROUP_ALTERNATE_CLOSE;
        }
        else if (data.equals(DObjectMap.GROUP_SEQUENCED)) {
          groupO = DObjectMap.GROUP_SEQUENCED_OPEN;
          groupC = DObjectMap.GROUP_SEQUENCED_CLOSE;
        }
        else if (data.equals(DObjectMap.GROUP_UNORDERED)) {
          groupO = DObjectMap.GROUP_UNORDERED_OPEN;
          groupC = DObjectMap.GROUP_UNORDERED_CLOSE;
        }
        this.dataMap += " " + groupO;
        continue;
      }

      else if (type.equals("contains")) {
        this.addContainer_((Group)member[1]);
        continue;
      }

      else if (type.equals("group")) {
        this.dataMap += " " + DObjectMap.GROUP_OPEN;
        this.addContainer_((Group)member[1]);
        this.dataMap += " " + DObjectMap.GROUP_CLOSE;
        continue;
      }

      else {
        this.dataIndex++;
        s = Integer.toString(this.dataIndex);
        data = (String)member[1];
        this.dataObject.put(s, new String[] { type, data });
        this.dataMap += " " + s;
      }

    }

    if (groupC.length() != 0) {
      this.dataMap += " " + groupC;
    }

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  // 

  /**
   * The DObject#main method gives a simple demo of DObject method examples
   * <p>
   * Usage: <code>java -classpath DObject.jar yads.doi.lib.DObject</code>
   *
   */
  public static void main(String[] argv) {
  
    String s;
    List l;
    Iterator i_;

/*
    if (argv.length < 1) {
      System.err.println("Usage: java yads.doi.lib.DObject <doi>");
      System.exit(1);
    }

    String doi = argv[0];
*/

    DObject d = new DObject();
    d.fromXML(DObjectInstance.RDF);

    out.println("// Normal practice is to instantiate a named DObject,");
    out.println("");
    out.println("// e.g. DObject d = new DObject(\"10.1234/567\");");
    out.println("");
    out.println("// For this demo, however, we instantiate an anonymous DObject");
    out.println("");
    out.println("   DObject d = new DObject();");
    out.println("");
    out.println("// And populate its value set from the library instance");
    out.println("");
    out.println("   d.fromXML(DObjectInstance.RDF);");
    out.println("");
    out.println("// Method examples 1-4 follow.");

    out.println("\n// 1. Method example: DObject#getDataTypes()");
    out.println("");
    out.println("   List l = d.getDataTypes();");
    out.println("   for (Iterator i_ = l.iterator(); i_.hasNext(); ) {");
    out.println("     out.println(i_.next().toString());");
    out.println("   }");
    out.println("");

    l = d.getDataTypes();
    for (i_ = l.iterator(); i_.hasNext(); ) {
      out.println(i_.next().toString());
    }

    out.println("\n// 2. Method example: DObject#getDataValues()");
    out.println("");
    out.println("   List l = d.getDataValues();");
    out.println("   for (Iterator i_ = l.iterator(); i_.hasNext(); ) {");
    out.println("     out.println(i_.next().toString());");
    out.println("   }");
    out.println("");

    l = d.getDataValues();
    for (i_ = l.iterator(); i_.hasNext(); ) {
      out.println(i_.next().toString());
    }

    out.println("\n// 3. Method example: DObject#dumpGroups()");
    out.println("");
    out.println("   d.dumpGroups();");
    out.println("");

    d.dumpGroups();

    out.println("\n// 4. Method example: DObject#toString()");
    out.println("");
    out.println("   System.out.print(d);");
    out.println("");

    System.out.print(d);

  }

}

