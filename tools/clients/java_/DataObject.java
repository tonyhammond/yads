/*
  ########################################################################
  #
  # doi.DataObject - A Java class for manipulating DOI DataObjects
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package doi;

import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;

import org.apache.oro.text.perl.*;
import org.apache.oro.text.regex.*;

// import doi.DataObjectTypes;

public class DataObject {

  // static final String DOI_SERVICE_HOST = "www2.harcourt-international.com";
  static final String DOI_SERVICE_HOST = "193.122.198.4";
  static final String DOI_SERVICE_PATH   = "/ap/servlet/yads";

  static final String RDF_SYNTAX_SCHEMA = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
  static final String DOI_OBJECT_SCHEMA = "doi:1014/10.1000/system.schema.2001-07-26#";

  static final String DATA_STORE_CALL_FETCH  = "fetchDataStore";
  static final String DATA_STORE_CALL_ADD    = "addDataStore";
  static final String DATA_STORE_CALL_CREATE = "createDataStore";
  static final String DATA_STORE_CALL_DELETE = "deleteDataStore";
  static final String DATA_STORE_CALL_MODIFY = "modifyDataStore";
  static final String DATA_STORE_CALL_REMOVE = "removeDataStore";

  static PrintStream out = System.out;

  static int nDataObjects = 0;	// Class DataObject number

  int nDataObject;		// Number of this DataObject within class
  String doi;			// DOI for this DataObject
  Map dataObject;		// Data element type/value pairs keyed on index
  Map dataTypes;		// Hash keyed on data type with list of data values
  int dataIndex;		// Next available index for dataObject hash
  String dataMap;		// Map of indexes within DataGroups
  String authUsername;		// Authorized username
  String authPassword;		// Authorized password

  public DataObject(String doi) {
  
    nDataObjects++;
    this.nDataObject = nDataObjects;

    this.doi = doi;
    this.dataObject = new HashMap();
    this.dataTypes = new HashMap();
 
    this.dataIndex = 0;
    this.dataMap = new String();

    this.authUsername = new String();
    this.authPassword = new String();

  } 

  // Wrapper for fetch from DataStore

  /**
   * Retrieves DataGroups from the persisted DataObject within the DataStore
   * identified by <code>doi</code> and use them to populate the current
   * DataObject instance.
   */
  public void readDataStore() {

    _getDataFromStore();

  }

  // Wrapper for put to DataStore

  /**
   * Generic method for modifying a DataObject copy within the DataStore with 
   * the DataGroups present within the current DataObject instance.
   *
   * @param request  specifies the type of operation
   *
   * @see            DataObject#addDataStore
   * @see            DataObject#createDataStore
   * @see            DataObject#deleteDataStore
   * @see            DataObject#modifyDataStore
   * @see            DataObject#removeDataStore
   */
  public void writeDataStore(String request) {

    _putDataToStore(request);

  }

  // Convenience wrappers for specific writeDataStore methods

  /**
   * Adds the DataGroups present in the current DataObject instance to the
   * persisted DataObject copy within the DataStore.
   */
  public void addDataStore() {

    writeDataStore(DATA_STORE_CALL_ADD);

  }

  /**
   * Creates a persisted copy of the current DataObject instance within the DataStore.
   */
  public void createDataStore() {

    writeDataStore(DATA_STORE_CALL_CREATE);

  }

  /**
   * Deletes the persisted copy of the current DataObject instance within the DataStore.
   */
  public void deleteDataStore() {

    writeDataStore(DATA_STORE_CALL_DELETE);

  }

  /**
   * Replaces DataGroups in the persisted DataObject copy within the DataStore
   * with the DataGroups present within the current DataObject instance.
   */
  public void modifyDataStore() {

    writeDataStore(DATA_STORE_CALL_MODIFY);

  }

  /**
   * Removes from the persisted DataObject copy within the DataStore the DataGroups
   * present within the current DataObject instance.
   */
  public void removeDataStore() {

    writeDataStore(DATA_STORE_CALL_REMOVE);

  }

/*
  ########################################################################
  #
  ########################################################################
*/

  // Class method returning allowed types

  public static void getClasstypes() {

  }
    
  /**
   * Returns the DataObject types within the current DataObject instance.
   *
   * @return          list of string values of DataObject data types
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
   * Returns the DataObject values within the current DataObject instance.
   *
   * @return          list of string values of DataObject data values
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

  // Set accessor methods for individual types

  /**
   * Returns data values of DataObject type 'access' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'access'
   */
  public ArrayList getAccesses() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_ACCESS);
  }

  /**
   * Returns data values of DataObject type 'agent' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'agent'
   */
  public ArrayList getAgents() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_AGENT);
  }

  /**
   * Returns data values of DataObject type 'alias' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'alias'
   */
  public ArrayList getAliases() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_ALIAS);
  }

  /**
   * Returns data values of DataObject type 'detail' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'detail'
   */
  public ArrayList getDetails() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_DETAIL);
  }

  /**
   * Returns data values of DataObject type 'label' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'label'
   */
  public ArrayList getLabels() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_LABEL);
  }

  /**
   * Returns data values of DataObject type 'label' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'label'
   */
  public ArrayList getLiterals() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_LITERAL);
  }

  /**
   * Returns data values of DataObject type 'null' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'null'
   */
  public ArrayList getNulls() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_NULL);
  }

  /**
   * Returns data values of DataObject type 'profile' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'profile'
   */
  public ArrayList getProfiles() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_PROFILE);
  }

  /**
   * Returns data values of DataObject type 'relation' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'relation'
   */
  public ArrayList getRelations() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_RELATION);
  }

  /**
   * Returns data values of DataObject type 'resource' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'resource'
   */
  public ArrayList getResources() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_RESOURCE);
  }

  /**
   * Returns data values of DataObject type 'role' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'role'
   */
  public ArrayList getRoles() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_ROLE);
  }

  /**
   * Returns data values of DataObject type 'schema' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'schema'
   */
  public ArrayList getSchemas() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_SCHEMA);
  }

  /**
   * Returns data values of DataObject type 'service' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'service'
   */
  public ArrayList getServices() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_SERVICE);
  }

  /**
   * Returns data values of DataObject type 'type' for the current DataObject
   * instance.
   *
   * @return          list of string values of DataObject type 'type'
   */
  public ArrayList getTypes() {
    return (ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_TYPE);
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
   * Tests a string to determine if of DataObject type 'access'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'access', <code>false</code> otherwise.
   */
  public boolean hasAccess(String s) {
    return _isOfType(DataObjectTypes.DOI_TYPE_ACCESS, s);
  }
  
  /**
   * Tests a string to determine if of DataObject type 'agent'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'agent', <code>false</code> otherwise.
   */
  public boolean hasAgent(String s) {
    return _isOfType(DataObjectTypes.DOI_TYPE_AGENT, s);
  }
  
  /**
   * Tests a string to determine if of DataObject type 'alias'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'alias', <code>false</code> otherwise.
   */
   public boolean hasAlias(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_ALIAS, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'detail'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'detail', <code>false</code> otherwise.
   */
   public boolean hasDetail(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_DETAIL, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'label'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'label', <code>false</code> otherwise.
   */
  public boolean hasLabel(String s) {
    return _isOfType(DataObjectTypes.DOI_TYPE_LABEL, s);
  }
  
  /**
   * Tests a string to determine if of DataObject type 'literal'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'literal', <code>false</code> otherwise.
   */
   public boolean hasLiteral(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_LITERAL, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'null'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'null', <code>false</code> otherwise.
   */
   public boolean hasNull(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_NULL, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'profile'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'profile', <code>false</code> otherwise.
   */
   public boolean hasProfile(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_PROFILE, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'relation'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'relation', <code>false</code> otherwise.
   */
   public boolean hasRelation(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_RELATION, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'resource'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'resource', <code>false</code> otherwise.
   */
   public boolean hasResource(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_RESOURCE, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'role'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'role', <code>false</code> otherwise.
   */
   public boolean hasRole(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_ROLE, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'schema'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'schema', <code>false</code> otherwise.
   */
  public boolean hasSchema(String s) {
    return _isOfType(DataObjectTypes.DOI_TYPE_SCHEMA, s);
  }
  
  /**
   * Tests a string to determine if of DataObject type 'service'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'service', <code>false</code> otherwise.
   */
   public boolean hasService(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_SERVICE, s);
   }
  
  /**
   * Tests a string to determine if of DataObject type 'type'.
   *
   * @param s         the string to be tested
   *
   * @return          <code>true</code> if <code>s</code> is of DataObject type
   *                  'type', <code>false</code> otherwise.
   */
   public boolean hastype(String s) {
     return _isOfType(DataObjectTypes.DOI_TYPE_TYPE, s);
   }
  

/*
  ########################################################################
  #
  ########################################################################
*/


  // public ArrayList getDataGroups() {
  public void getDataGroups() {

    // return this.aDataGroups;

  }

  /** 
   * Prints dump of the current DataObject instance DataGroups.
   */
  public void dumpDataGroups() {

    String s;
    String type, data;

    int nDataGroups = 0;
    int indent = -1;

    Perl5Util re = new Perl5Util();

    out.println("Dump for doi:" + this.doi + "\n");
    out.println("DataMap = " + this.dataMap);

    StringTokenizer st = new StringTokenizer(this.dataMap);

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();
      if (s.equals("(")) { nDataGroups++; }
    }
    s = Integer.toString(nDataGroups);
   
    out.println("DataGroups (" + s + ") =");

    // Now run though the DOI handle map

    st = new StringTokenizer(this.dataMap);

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();

      if (s.equals("{") || s.equals("[") || s.equals("<") || s.equals("(")) {
        indent++;
        for (int i = 1; i <= indent; i++) { out.print("  "); }
        out.println(s);
      }
      else if (s.equals("}") || s.equals("]") || s.equals(">") || s.equals(")")) {
        for (int i = 1; i <= indent; i++) { out.print("  "); }
        out.println(s);
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];

        data = re.substitute("s/&lt;/\\</g", data);
        data = re.substitute("s/&gt;/\\>/g", data);
        data = re.substitute("s/&amp;/\\&/g", data);

        for (int i = 1; i <= indent; i++) { out.print("  "); }
        out.println("  " + type + " => " + data);
      }
    }

  }

/*
  ########################################################################
  #
  ########################################################################
*/

  /** 
   * Prints a string representation of the curent DataObject instance.
   */
  public String toString() {

    String s = new String();
    String type = new String();
    String data = new String();
    int indent = 0;

    StringBuffer dataBuffer = new StringBuffer();

    Perl5Util re = new Perl5Util();

    dataBuffer.append("<rdf:RDF\n");
    dataBuffer.append("  xmlns:rdf=\"" + RDF_SYNTAX_SCHEMA + "\"\n");
    dataBuffer.append("  xmlns:doi=\"" + DOI_OBJECT_SCHEMA + "\"\n");
    dataBuffer.append(">\n");
    dataBuffer.append("  <doi:Object rdf:about=\"doi:" + this.doi + "\">\n");
  
    indent++;
  
    // Now run though the DOI handle map
  
    StringTokenizer st = new StringTokenizer(dataMap);
  
    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();
  
      if (s.equals("{")) {
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<rdf:Bag>\n");
      }
      else if (s.equals("}")) {
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</rdf:Bag>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals("[")) {
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<rdf:Seq>\n");
      }
      else if (s.equals("]")) {
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</rdf:Seq>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals("<")) {
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<doi:contains>\n");
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<rdf:Alt>\n");
      }
      else if (s.equals(">")) {
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</rdf:Alt>\n");
        indent--;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</doi:contains>\n");
        indent--;
      }
      else if (s.equals("(")) {
        indent++;
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("<rdf:li rdf:parseType=\"Resource\">\n");
      }
      else if (s.equals(")")) {
        for (int i = 0; i < indent; i++) {
          dataBuffer.append("  ");
        }
        dataBuffer.append("</rdf:li>\n");
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];
  
        data = re.substitute("s/\\</&lt;/g", data);
        data = re.substitute("s/\\>/&gt;/g", data);
        data = re.substitute("s/\\&/&amp;/g", data);

        for (int i = 0; i <= indent; i++) {
          dataBuffer.append("  ");
        }
        if (DataObjectTypes.isRDFLiteral(type)) {
          dataBuffer.append("<doi:" + type + ">");
        }
        else if (DataObjectTypes.isRDFResource(type)) {
          dataBuffer.append("<doi:" + type + " rdf:resource=\"");
        }
        else {
          // What? - Just ignore?
        }
  
        dataBuffer.append(data);
  
        if (DataObjectTypes.isRDFLiteral(type)) {
          dataBuffer.append("</doi:" + type + ">\n");
        }
        else if (DataObjectTypes.isRDFResource(type)) {
          dataBuffer.append("\"/>\n");
        }
        else {
          // What? - Just ignore?
        }
   
      }
    }
    dataBuffer.append("  </doi:Object>\n");
    dataBuffer.append("</rdf:RDF>\n");
  
    return dataBuffer.toString();

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  /**
  */

  private void _getDataFromStore() {

    String line;
    List lines = new ArrayList();

    String s = null;
    String type, data = null;
    
    StringBuffer dataMapBuffer = new StringBuffer();

    Perl5Util re = new Perl5Util();
    MatchResult match;

    // Reset instance variables - this method will clobber any existing variables

    dataObject.clear();
    dataTypes.clear();
    dataMap = null;
    dataIndex = 0;
 
    try {
      re.split(lines, "/\\n/", _getDataValues(this.doi));
    }
    catch (MalformedPerl5PatternException x) { out.println("Problem with re: " + x.getMessage()); }
    
    for (Iterator i_ = lines.iterator(); i_.hasNext(); ) {

      line = ((String)i_.next()).trim();

      // On an RDF doi:Object typed node

      if (line.startsWith("<doi:Object")) {
        StringTokenizer st = new StringTokenizer(line, "\"");

        s = (String)st.nextToken();
        doi = ((String)st.nextToken()).substring(4);
      }

      // RE match problem with "/" character
      //
      // if (re.match("/<doi:Object rdf:about=\"doi:(.*?)\"", line)) {
      //   doi = match.group(1);
      // }

      // On an RDF Bag container open tag

      else if (re.match("/<rdf:Bag>/", line)) {
        dataMapBuffer.append(" {");
      }

      // On an RDF Bag container close tag

      else if (re.match("/<\\/rdf:Bag>/", line)) {
        dataMapBuffer.append(" }");
      }

      // On an RDF Seq container open tag

      else if (re.match("/<rdf:Seq>/", line)) {
        dataMapBuffer.append(" [");
      }

      // On an RDF Seq container close tag

      else if (re.match("/<\\/rdf:Seq>/", line)) {
        dataMapBuffer.append(" ]");
      }

      // On an RDF Alt container open tag

      else if (re.match("/<rdf:Alt>/", line)) {
        dataMapBuffer.append(" <");
      }

      // On an RDF Alt close container tag

      else if (re.match("/<\\/rdf:Alt>/", line)) {
        dataMapBuffer.append(" >");
      }

      // On an RDF anonymous resource open tag

      else if (re.match("/<rdf:li rdf:parseType=\"Resource\">/", line)) {
        dataMapBuffer.append(" (");
      }

      // On an RDF anonymous resource close tag

      else if (re.match("/<\\/rdf:li>/", line)) {
        dataMapBuffer.append(" )");
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

        // Add the element type/data pair to the dataObject hash

        s = Integer.toString(this.dataIndex);
        dataObject.put(s, new String[] { type, data });
        dataMapBuffer.append(" " + s);
        dataIndex++;

        // Push the data onto the dataTypes hash

        List l = (ArrayList)(dataTypes.get(type));
        if  (l == null) {
          l = new ArrayList();
        }
        l.add(data);
        dataTypes.put(type, l);
        
      }

    }

    // Set the dataMap

    dataMap = dataMapBuffer.toString().trim();

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  /**
  */

  private void _putDataToStore(String request) {

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
    dataBuffer.append("<DOI-SERVICE:" + request + "\n");
    dataBuffer.append("  xmlns:DOI-SERVICE=\"http://dx.doi.org/1014/doi.service\"\n");
    dataBuffer.append(">\n");
    dataBuffer.append(this.toString());
    dataBuffer.append("</DOI-SERVICE:" + request + ">\n");
    dataBuffer.append("</SOAP-ENV:Body>\n");
    dataBuffer.append("</SOAP-ENV:Envelope>\n");

    // out.println(dataBuffer.toString());

    out.print(_setDataValues(dataBuffer.toString()));

  }


/*
  ########################################################################
  #
  # This group of methods returns DOI kernel and application profile metadata.
  #
  ########################################################################
*/


  // 
  private String _metadata(String profile, String auth, boolean action) {

    String doiProfile;
    String host;
    String path;

    Perl5Util re = new Perl5Util();
    MatchResult match;

    if (profile != null) {
      doiProfile = re.substitute("s/^doi://", profile);
    }
    else {
      doiProfile = "10.system/profile.zero";
    }
    DataObject d = new DataObject(doiProfile);
    d.readDataStore();

    List l = d.getServices();

    // If no service associated with this profile then return null
    if (l == null) {
      return null;
    }

    re.match("/^http:\\/\\/(.*?)(\\/.*?)$/", (String)l.get(0));
    match = re.getMatch();
    host = match.group(1);

    path = match.group(2) + "?id=" + doi + "&pid=" + auth + "&sid=null:null";

    if (action) {
      return _getMetaData(host, path);
    }
    else {
      return "http://" + host + path;
    }

  }

  public String getUsername() {
  
    return this.authUsername;

  }

  public void setUsername(String user) {
  
    this.authUsername = user;

  }

  public String getPassword() {
  
    return this.authPassword;

  }

  public void setPassword(String pass) {
  
    this.authPassword = pass;

  }

  /**
   * Return kernel metadata in XML format for the current DataObject instance.
   *
   * @return          kernel metadata in XML
   */
  public String getKernelMetadata() {
  
    String profile = (String)this.getProfiles().get(0);
    String auth = "guest:guest";

    return _metadata(profile, auth, true);

  }

  public String getKernelMetadata(String profile) {
  
    String auth = "guest:guest";

    return _metadata(profile, auth, true);

  }

  /**
   * Return the kernel metadata service for the current DataObject instance.
   *
   * @return          service for kernel metadata
   */
  public String getKernelMetadataService() {
  
    String profile = (String)this.getProfiles().get(0);

    return _metadata(profile, null, false);

  }

  public String getKernelMetadataService(String profile) {
  
    return _metadata(profile, null, false);

  }

  /**
   * Return application profile metadata in XML format for the current DataObject instance.
   *
   * @return          application profile metadata in XML
   */
  public String getProfileMetadata() {
  
    String profile = (String)this.getProfiles().get(0);
    String auth = this.authUsername + ":" + this.authPassword;

    return _metadata(profile, auth, true);

  }

  public String getProfileMetadata(String profile) {
  
    String auth = this.authUsername + ":" + this.authPassword;

    return _metadata(profile, auth, true);

  }

  /**
   * Return application profile metadata service for the current DataObject instance.
   *
   * @return          service for application profile metadata
   */
  public String getProfileMetadataService() {
  
    String profile = (String)this.getProfiles().get(0);

    return _metadata(null, null, false);

  }

  public String getProfileMetadataService(String profile) {
  
    return _metadata(profile, null, false);

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

    String host = DOI_SERVICE_HOST;
    String path = DOI_SERVICE_PATH + "?xml=true&doi=" + doi;
    
    return _getXMLFromService(host, path);

  }

  private String _setDataValues(String data) {

    String host = DOI_SERVICE_HOST;
    String path =  DOI_SERVICE_PATH + "?data=" + URLEncoder.encode(data);
    
    return _getXMLFromService(host, path);

  }

  private String _getMetaData(String host, String path) {

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
  public DataObject addDataGroup(List dataGroup, String profile) {

    List l;
    Iterator i_;

    String s = new String();
    String type = new String();
    String data = new String();
    
    int indexProfile = 0;

    // profile = profiles.empty? ? 'doi:10.system/profile.zero' \
    //                           : profiles[0]

    // See whether we need to add in a value for the profile

    if (!(dataTypes.containsKey(DataObjectTypes.DOI_TYPE_PROFILE)
          && ((ArrayList)dataTypes.get(DataObjectTypes.DOI_TYPE_PROFILE)).contains(profile))) {

      // Husk: Make check that profile is legitimate

      s = Integer.toString(dataIndex);
      type = DataObjectTypes.DOI_TYPE_PROFILE;
      data = profile;
      dataObject.put(s, new String[] { type, data });
      indexProfile = dataIndex;
      dataIndex++;

      l = new ArrayList();
      l.add(data);
      dataTypes.put(type, l);

    }
    else {

      for (i_ = dataObject.entrySet().iterator(); i_.hasNext(); ) {
        Map.Entry e = (Map.Entry)i_.next();
        s = (String)e.getKey();
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];
        if (type.equals(DataObjectTypes.DOI_TYPE_PROFILE)
            && data.equals(profile)) {
          indexProfile = Integer.parseInt(s);
          break;
        }
      }

    }

    // Set the dataMap

    StringBuffer dataMapBuffer = new StringBuffer();

    dataMapBuffer.append(dataMap);

    dataMapBuffer.append(" ( " + Integer.toString(indexProfile));

    // List l1 = (ArrayList)dataGroup.getData();
    List l1 = (ArrayList)dataGroup;
    String [] dataElement;
    for (i_ = l1.iterator(); i_.hasNext(); ) {

      dataElement = (String [])i_.next();
      type = dataElement[0];
      data = dataElement[1];
      if (type.equals("dataGroup")) {
        // this.addDataGroup(data, "doi:10.system/profile.zero");
      }
      else {
        s = Integer.toString(dataIndex);
        dataObject.put(s, new String[] { type, data });
        dataMapBuffer.append(" " + s);
        dataIndex++;
      }

    }

    dataMapBuffer.append(" )");
    dataMap = dataMapBuffer.toString();

    return this;

  }

/*
  ########################################################################
  #
  ########################################################################
*/


  // 

  public static void main(String[] argv) {
  
    String s;
    List l;
    Iterator i_;

    if (argv.length < 1) {
      System.err.println("usage: java doi.DataObject <doi>");
      System.exit(1);
    }
    
    String doi = argv[0];

    DataObject d = new DataObject(doi);
    d.readDataStore();

    out.println("//");
    out.println("// DataObject d = new DataObject(\"" + doi + "\");");
    out.println("// d.readDataStore();");
    out.println("//");

    out.println("\n// 1. Example of Method: getDataTypes()");
    out.println("//");
    out.println("// l = d.getDataTypes();");
    out.println("// for (i_ = l.iterator(); i_.hasNext(); ) {");
    out.println("//   out.println(\"  \" + i_.next().toString());");
    out.println("// }");
    out.println("//\n");

    l = d.getDataTypes();
    for (i_ = l.iterator(); i_.hasNext(); ) {
      out.println("  " + i_.next().toString());
    }

    out.println("\n// 2. Example of Method: getDataValues()");
    out.println("//");
    out.println("// l = d.getDataValues();");
    out.println("// for (i_ = l.iterator(); i_.hasNext(); ) {");
    out.println("//   out.println(\"  \" + i_.next().toString());");
    out.println("// }");
    out.println("//\n");

    l = d.getDataValues();
    for (i_ = l.iterator(); i_.hasNext(); ) {
      out.println("  " + i_.next().toString());
    }

    out.println("\n// 3. Example of Method: dumpDataGroups()");
    out.println("//");
    out.println("// d.dumpDataGroups();");
    out.println("//\n");

    d.dumpDataGroups();

/*
    out.println("\n// 4. Example of Method: getKernelMetadata()");
    out.println("//");
    out.println("// l = d.getProfiles();");
    out.println("// for (i_ = l.iterator(); i_.hasNext(); ) {");
    out.println("//   s = i_.next().toString();");
    out.println("//   if (s.equals(\"doi:10.system/profile.crossref\")) {");
    out.println("//     out.print(d.getKernelMetadata(s));");
    out.println("//   }");
    out.println("// }");
    out.println("//\n");
    
    l = d.getProfiles();
    for (i_ = l.iterator(); i_.hasNext(); ) {
      s = i_.next().toString();
      if (s.equals("doi:10.system/profile.crossref")) {
        out.print(d.getKernelMetadata(s));
      }
    }

    out.println("\n// 5. Example of Method: createDataStore()");
    out.println("//");
    out.println("// DataGroup dg = new DataGroup()");
    out.println("//   .addData(\"resource\", \"http://www.academicpress.com\")");
    out.println("//   .addData(\"detail\", \"DataGroup added by the DataObject class method \\\"main\\\")");
    out.println("//");
    out.println("// d.addDataGroup(dg, \"doi:10.system/profile.zero\");");
    out.println("// d.createDataStore();");
    out.println("//\n");

    DataGroup dg = new DataGroup()
      .addData("resource", "http://www.academicpress.com")
      .addData("detail", "DataGroup added by the DataObject class method \"main\"");

    d.addDataGroup(dg, "doi:10.system/profile.zero");
    d.createDataStore();
*/

  }

}

