/*
  ########################################################################
  #
  # yads - Yet Another DOI Service
  #
  # (A servlet used to get/put DOI handle values and to expose the DOI
  #  DataObjects as RDF/XML serializations within SOAP envelopes.)
  #
  # 2001.08.11
  #
  # Author - Tony Hammond <mailto:tony_hammond@harcourt.com>
  #
  # Copyright 2001  - Academic Press, a Harcourt Science and Technology Company.
  #
  ########################################################################
*/

// Standard Java library classes
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;

// Java servlet classes
import javax.servlet.*;
import javax.servlet.http.*;

// Classes for the DataStore - Handle and Virtual
import net.handle.hdllib.*;	// Handle client library
import DataObjectBatch;		// Class to write to handle
import DataObjectTypes;		// DataObject types
// import Virtuality;

// Utility classes
import CrossRef;	// Determine membership of CrossRef DOI Application
import Randoms;		// Return a random DOI

// Classes for regular expression handling
import org.apache.oro.text.perl.*;
import org.apache.oro.text.regex.*;


public class yyads extends HttpServlet implements java.io.Serializable {
  
  private PrintWriter out;
  private FileWriter log;

  private boolean isOutputCode;
  private boolean isOutputDump;
  private boolean isOutputGraph;
  private boolean isOutputMenus;
  private boolean isOutputXML;

  private boolean isOutputDefault;
  private boolean isOutputTerm;

  private String HandleResponse;
  private String dateTime;
  private String serviceRequest;

  private int codeFormat;
  private static final int JAVA = 1;
  private static final int PERL = 2;
  private static final int PYTHON = 3;
  private static final int RUBY = 4;

  private int graphFormat;
  private static final int GIF = 1;
  private static final int PNG = 2;
  private static final int SVG = 3;
  private static final int POSTSCRIPT = 4;

  private int counter = 0;
  
  private Perl5Util re = new Perl5Util();
  private MatchResult match;

  private Enumeration e;

  private String s = new String();
  private String sType = new String();
  private String sData = new String();

  private Hashtable dataObject = new Hashtable();
  private Hashtable dataObjectLibrary = new Hashtable();
  private String dataMap = new String();
  private boolean hasDataObject = true;

  private String className = this.getClass().getName();

  private static final String MENU_WRITER
    = "http://www2.harcourt-international.com/~tony/ruby/ruby/zmenu.cgi";

  private static final String BASE_URL
    = "http://www2.harcourt-international.com/ap/servlet/";

  private static final String SERVLET_DATA = "/opt/HARCap/servlet_data/";
  private static final String SERVLET_LOGS = "/opt/HARCap/servlet_logs/";

  // Method init - 

  public void init(ServletConfig config) throws ServletException {
    super.init(config);

    ObjectRead or = new ObjectRead(); 
    dataObjectLibrary = or.objectRead(); 
  }

  // Method destroy - 

  public void destroy() {

    ObjectWrite ow = new ObjectWrite(); 
    ow.objectWrite(dataObjectLibrary); 

    super.destroy();
  }

  // Method getServletInfo - 

  public String getServletInfo() {
    return "This servlet is used to get DOI handle values and return as DataObjects.";
  }

  // Method doGet - 

  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException
  {
    doPost(req, res);
  }
  
  // Method doPost - 

  public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException
  {

    // PrintWriter out;

    try {
      counter++;

      dateTime = _dateTime(true);
      serviceRequest = "fetchDataStore";  // default service request is read values
      HandleResponse = null;

      res.setContentType("text/html");

      out = new PrintWriter(res.getOutputStream(), true);

      String doi = req.getParameter("doi");

      if (doi != null) {
        if (doi.equals("?")) {
          doi = Randoms.getNext();
        }
        doi = doi.trim();
        if (re.match("/^(doi:)(.*)/i", doi)) {
          match = re.getMatch();
          doi = match.group(2);
        }
      }

      String addr = req.getRemoteAddr();
      String sDataObject = req.getParameter("data");

      isOutputDefault = true;
      isOutputCode = isOutputDump = isOutputGraph = isOutputMenus = isOutputXML = false;

      if (req.getParameter("rtnType") != null) {
        if (req.getParameter("rtnType").equals("menus")) {
          isOutputMenus = true; isOutputDefault = false;
        }
        else if (req.getParameter("rtnType").equals("dump")) {
          isOutputDump = true; isOutputDefault = false;
        }
        else if (req.getParameter("rtnType").equals("graph")) {
          isOutputGraph = true; isOutputDefault = false;
        }
        else if (req.getParameter("rtnType").equals("data")) {
          isOutputDefault = true;
        }
        else if (req.getParameter("rtnType").equals("xml")) {
          isOutputXML = true; isOutputDefault = false;
        }
        else if (req.getParameter("rtnType").equals("code")) {
          isOutputCode = true; isOutputDefault = false;
        }
      }
      isOutputTerm = (req.getParameter("form") != null) ? false : true;

      if (isOutputCode) {
        if (req.getParameter("codeFormat").equals("Java")) {
          codeFormat = JAVA;
        }
        else if (req.getParameter("codeFormat").equals("Perl")) {
          codeFormat = PERL;
        }
        else if (req.getParameter("codeFormat").equals("Python")) {
          codeFormat = PYTHON;
        }
        else if (req.getParameter("codeFormat").equals("Ruby")) {
          codeFormat = RUBY;
        }
      }

      if (isOutputGraph) {
        if (req.getParameter("graphFormat").equals("GIF")) {
          graphFormat = GIF;
        }
        else if (req.getParameter("graphFormat").equals("PNG")) {
          graphFormat = PNG;
        }
        else if (req.getParameter("graphFormat").equals("SVG")) {
          graphFormat = SVG;
        }
        else if (req.getParameter("graphFormat").equals("PostScript")) {
          graphFormat = POSTSCRIPT;
        }
      }


      if (sDataObject != null) {
        isOutputXML = true; isOutputDefault = false; isOutputTerm = true;

        doi = writeDataStore(sDataObject);
        writeDataClient(out, doi, false);
      }
      else if (doi != null) {
        readDataStore(doi);
        if (hasDataObject) {
          writeDataClient(out, doi, true);
        }
        else {
          out.println("<html>");

          _printHeader(out);
          _printBodyHead(out);

          out.println("<hr>");
          out.println("<pre>\n! No DOI \"" + doi + "\" found in the DataStore (" + HandleResponse + ")\n</pre>");

          _printBodyTail(out);

          out.println("</html>");
        }
      }
      else {

        doi = Randoms.getNext();
        while (!doi.startsWith("1014/")) {
          doi = Randoms.getNext();
        }  
        out.println("<html>");

        _printHeader(out);

        _printBodyHead(out);
        _printForm(out, doi);
        _printBodyTail(out);

        out.println("</html>");

      }

      log = new FileWriter(SERVLET_LOGS + className + ".log", true);
      if (HandleResponse != null) {
        log.write(addr + " " + dateTime + " " + doi + " (" + HandleResponse + ")" + "\n");
      }
      else {
        log.write(addr + " " + dateTime + " " + doi + "\n");
      }
      log.close();

    } catch (Throwable e) { }

    try { out.flush(); } catch (Exception x) {}
    try { out.close(); } catch (Exception x) {}

    try {
      if (counter % 5 == 0) {
        counter = 0;
        System.gc();
        System.runFinalization();
      }
    } catch (Throwable e) { }
  }


  // Method readDataStore - 

  private void readDataStore(String doi)
    throws ServletException, IOException, Exception
  {
    s = sType = sData = null;

    dataObject.clear();
    dataMap = null;

    if (isOutputDefault && !isOutputTerm) { 
      out.println("<html>");

      _printHeader(out);
      _printBodyHead(out);

    }

    readHandle(doi);

/*
      if (dataObjectLibrary.containsKey(doi)) {
        // out.println("<pre>readLibrary");
        readLibrary(doi);
      }
      else {
        // out.println("<pre>readHandle");
        readHandle(doi);
      } 
*/

  }

  // Method writeDataStore - 

  private String writeDataStore(String sDataObject)
    throws ServletException, IOException, Exception
  {
    s = sType = sData = null;

    dataObject.clear();
    dataMap = null;

    return writeHandle(sDataObject);

  }

  // Method addHandleMap -

  private void addHandleMap()
    throws ServletException, IOException, Exception
  {
    StringBuffer sMap = new StringBuffer();	// All system DOI values are in one DataGroup
    String sProfileIndex = "-1";

    // Iterate over data elements to find index value of
    // a profile
    for (e = dataObject.keys(); e.hasMoreElements(); ) {
      s = (String)e.nextElement();
      sType = ((String [])dataObject.get(s))[0];
       if (sType.equals(DataObjectTypes.DOI_TYPE_PROFILE)) {
        sProfileIndex = s;
        sData = ((String [])dataObject.get(s))[1];
        break;
      }
    }

    // Iterate over data elements and add index values
    // of non-profile elements to map
    sMap.append("{ ( " + sProfileIndex + " {");
    for (e = dataObject.keys(); e.hasMoreElements(); ) {
      s = (String)e.nextElement();
      sType = ((String [])dataObject.get(s))[0];
      sData = ((String [])dataObject.get(s))[1];
      if (!sType.equals(DataObjectTypes.DOI_TYPE_PROFILE)) {
        sMap.append(" ( " + s + " ) ");
      }
    }
    sMap.append(" } ) }");
    s = "0";
    sType = DataObjectTypes.DOI_TYPE_MAP; 
    sData = sMap.toString().trim();
    dataObject.put(s, new String[] { sType, sData });
    dataMap = sData; 

  }


  // Method readVirtual -

  private void readVirtual(String doi)
    throws ServletException, IOException, Exception
  {
    StringBuffer sMap = new StringBuffer();	// All system DOI values are in one DataGroup
    int i = -1;
    Vector v = new Vector();

    if (Virtuality.isVirtual(doi)) {
      v = (Vector)Virtuality.getVirtual(doi);

      // Set the system profile for Virtuals

      s = "-1";
      sType = DataObjectTypes.DOI_TYPE_PROFILE;
      sData = "doi:1014/10.1000/system.profile.system";
      sMap.append("{ ( " + s + " { ( ");
      dataObject.put(s, new String[] { sType, sData });
     
      for (e = v.elements(); e.hasMoreElements(); ) {
        String[] Data = (String[])e.nextElement();
        if (Data[0] != DataObjectTypes.DOI_TYPE_PROFILE) {
          s = Integer.toString(--i); 
          sMap.append(" " + s);
          dataObject.put(s, new String[] { Data[0], Data[1] });
        }
      }
      sMap.append(" ) } ) }");
      // Now add in the map
      // s = Integer.toString(--i); 
      s = "0";
      sType = DataObjectTypes.DOI_TYPE_MAP;
      sData = sMap.toString().trim();
      dataObject.put(s, new String[] { sType, sData });
      dataMap = sData;

      hasDataObject = true;
    }
    else {
      hasDataObject = false;
    }

  }

  // Method readLibrary -

  private void readLibrary(String doi)
    throws ServletException, IOException, Exception
  {
    if (isOutputDefault) { 

      for (e = dataObjectLibrary.keys(); e.hasMoreElements(); ) {
        s = (String)e.nextElement();
        out.println("Library doi:" + s);
      }

      out.println("In Library - doi:" + doi);
      out.println();

    }

    // No! - dataObject = (Hashtable)dataObjectLibrary.get(doi);

    Hashtable _dataObject = new Hashtable();
    _dataObject = (Hashtable)dataObjectLibrary.get(doi);
    for (e = _dataObject.keys(); e.hasMoreElements(); ) {
      s = (String)e.nextElement();
      sType = ((String [])_dataObject.get(s))[0];
      sData = ((String [])_dataObject.get(s))[1];
      dataObject.put(s, new String[] { sType, sData });
    }

    for (e = dataObject.keys(); e.hasMoreElements(); ) {
      s = (String)e.nextElement();
      sType = ((String [])dataObject.get(s))[0];
      sData = ((String [])dataObject.get(s))[1];
      if (sType.equals(DataObjectTypes.DOI_TYPE_MAP)) {
        dataMap = sData;
        break;
      }

    }

    hasDataObject = true;

  }

  // Method readHandle -

  private void readHandle(String doi)
    throws ServletException, IOException, Exception
  {
    s = sType = sData = null;

    dataObject.clear();
    dataMap = null;
    boolean hasProfile = false;
    Hashtable hProfiles = new Hashtable();

    HandleResolver resolver = new HandleResolver();
    resolver.traceMessages = false;
    
    ResolutionRequest hReq = new ResolutionRequest(net.handle.hdllib.Util.encodeString(doi), 
                                                  null, null, null);
    hReq.ignoreRestrictedValues = true;
    //hReq.certify = true;

    try {
      
      AbstractResponse response = resolver.processRequest(hReq);

      HandleResponse = response.getResponseCodeMessage(response.responseCode);
      
      if (response.responseCode == AbstractMessage.RC_SUCCESS) {

        HandleValue values[] = ((ResolutionResponse)response).getHandleValues();

        // Iterate over the handle values and save type/data pairs into the 
        // hash "dataObject" keyed on index
        //
        // Only save values or type within the "DOI_" namespace (or values
        // of legacy type "URL" which are mapped to "DOI_RESOURCE")

        for (int i=0; values!=null && i<values.length; i++) {

          HandleValue val = values[i];

          // Handle value index
          s = String.valueOf(val.index);

          // Handle value type
          sType = net.handle.hdllib.Util.decodeString(val.type);

          // Quietly map legacy "URL" handle types
          if (sType.equals(DataObjectTypes.HDL_TYPE_URL))
            { sType = DataObjectTypes.HDL_DOI_TYPE_RESOURCE; }

          // Handle value data
          if(net.handle.hdllib.Util.looksLikeBinary(val.data))
            sData = net.handle.hdllib.Util.decodeHexString(val.data,false);
          else
            sData = net.handle.hdllib.Util.decodeString(val.data);

          // Now save the "DOI_" namespace types 
          if (sType.startsWith(DataObjectTypes.HDL_DOI_PREFIX)) {
            dataObject.put(s, new String[] { DataObjectTypes.getDataObjectType(sType), sData });
          }

          // And save any "DOI_MAP" data element
          if (sType.equals(DataObjectTypes.HDL_DOI_TYPE_MAP)) {
            dataMap = sData;
          }

        }

        // Scan the indexed values and hash the profile types
        // in hProfiles for lookup
        
        hasProfile = false;
        for (e = dataObject.keys(); e.hasMoreElements(); ) {
          s = (String)e.nextElement();
          sType = ((String [])dataObject.get(s))[0];
          sData = ((String [])dataObject.get(s))[1];
          if (sType.equals(DataObjectTypes.DOI_TYPE_PROFILE)) {
            hasProfile = true;
            hProfiles.put(s, sData);
          }
        }
        if (!hasProfile && !dataObject.isEmpty()) {
          s = "-1";
          sType = DataObjectTypes.DOI_TYPE_PROFILE;

          sData = "doi:1014/10.1000/system.profile.zero";
          if (CrossRef.hasCrossRefProfile(doi)) {
            sData = "doi:1014/10.1000/system.profile.crossref";
          }
          else {
            sData = "doi:1014/10.1000/system.profile.zero";
          }
          dataObject.put(s, new String[] { sType, sData });
          hProfiles.put(s, sData);
        }
  
        // If no map then synthesize one
        if (dataMap == null) { addHandleMap(); }

        hasDataObject = true;
      }
      else {
        hasDataObject = false;
      }

    } catch (Exception x) { }

  }


  // Method writeHandle -

  private String writeHandle(String sDataObject)
    // throws IOException, Exception, Throwable
    throws IOException, Exception
  {
    StringBuffer sMap = new StringBuffer();	// All system DOI values are in one DataGroup
    StringBuffer handleBuffer = new StringBuffer();

    DataObjectBatch batch;

    String doi = new String();

    String sLine = new String();
    Vector sLines = new Vector();

    String s = new String();
    String sData = new String();
    String sType = new String();
    Hashtable dataProfiles = new Hashtable();
    int nHandleIndex = 0;

    try {
      
      re.split(sLines, "/\\n/", sDataObject);
      
      for (e = sLines.elements(); e.hasMoreElements(); ) {
       
        sLine = (String)e.nextElement();
  
        if (sLine.startsWith("<DOI-SERVICE:")) {
           serviceRequest = sLine.substring(13).trim();
        }

        // RE match problem with "/" character
        //
        // if (re.match("/<DOI-SERVICE:(\\w+)/", sLine)) {
        //   serviceRequest = match.group(1);
        // }

        // On an RDF doi:Object typed node

        if (sLine.startsWith("<doi:Object")) {
          StringTokenizer st = new StringTokenizer(sLine, "\"");

          s = (String)st.nextToken();
          doi = ((String)st.nextToken()).substring(4);
        }

        // RE match problem with "/" character
        //
        // if (re.match("/<doi:Object rdf:about=\"doi:(.*?)\"", sLine)) {
        //   doi = match.group(1);
        // }

        // On an RDF Bag container open tag
  
        else if (re.match("/<rdf:Bag>/", sLine)) {
          sMap.append(" {");
        }

        // On an RDF Bag container close tag
  
        else if (re.match("/<\\/rdf:Bag>/", sLine)) {
          sMap.append(" }");
        }
  
        // On an RDF Seq container open tag
  
        else if (re.match("/<rdf:Seq>/", sLine)) {
          sMap.append(" [");
        }

        // On an RDF Seq container close tag
  
        else if (re.match("/<\\/rdf:Seq>/", sLine)) {
          sMap.append(" ]");
        }
  
        // On an RDF Alt container open tag
  
        else if (re.match("/<rdf:Alt>/", sLine)) {
          sMap.append(" <");
        }

        // On an RDF Alt close container tag
  
        else if (re.match("/<\\/rdf:Alt>/", sLine)) {
          sMap.append(" >");
        }
  
        // On an RDF anonymous resource open tag
  
        else if (re.match("/<rdf:li rdf:parseType=\"Resource\">/", sLine)) {
          sMap.append(" (");
        }

        // On an RDF anonymous resource close tag
  
        else if (re.match("/<\\/rdf:li>/", sLine)) {
          sMap.append(" )");
        }
  
        // Skip the DOI container property open/close tags
  
        else if (re.match("/<\\/?doi:contains>/", sLine)) {
        }
  
        //  The only other lines for parsing are the data elements
  
        else if (re.match("/<doi:/", sLine)) {

          if (re.match("/<doi:(\\w+)>(.*?)<\\/doi:\\w+>/", sLine)) {
            
            match = re.getMatch();
            sType = match.group(1); sData = match.group(2);

          }
          else if (re.match("/<doi:(\\w+) rdf:resource=\"(.*?)\"\\/>/", sLine)) {
            
            match = re.getMatch();
            sType = match.group(1); sData = match.group(2);

          }

          // Only save single copy of each profile

          if (dataProfiles.containsKey(sData)) {
            // sMap.append(" " + dataProfiles.get(sData));
          }
          else {
            ++nHandleIndex;
            s = Integer.toString(nHandleIndex);
            sMap.append(" " + s);
 
            dataObject.put(s, new String[] { sType, sData });
  
            if (sType.equals("profile")) {
              dataProfiles.put(sData, s);
            }
          }

        }
  
      }

      s = "0";
      sType = DataObjectTypes.DOI_TYPE_MAP; 
      sData = sMap.toString().trim();
      dataObject.put(s, new String[] { sType, sData });
      dataMap = sData; 

      if (doi.startsWith("1014/")) {
      
        // Persist the dataObject in local handle service

        handleBuffer.append("AUTHENTICATE SECKEY:301:0.NA/1014\n");
        handleBuffer.append("tony\n");
        handleBuffer.append("\n");
        handleBuffer.append(serviceRequest + " " + doi + "\n");

        if (!serviceRequest.equals("deleteDataStore")) {
          for (e = dataObject.keys(); e.hasMoreElements(); ) {
            s = (String)e.nextElement();
            sType = ((String [])dataObject.get(s))[0];
            sData = ((String [])dataObject.get(s))[1];
    
            handleBuffer.append(s + " " + DataObjectTypes.getHandleType(sType) + " 86400 1110 UTF8 " + sData + "\n");

          }
          handleBuffer.append("100 HS_ADMIN 86400 1110 ADMIN 200:11111111111:0.NA/1014\n");
        }

        String log_file = "/tmp/" + className + "@" + dateTime + ".log";
        String err_file = "/tmp/" + className + "@" + dateTime + ".err";
        batch = new DataObjectBatch(handleBuffer.toString(), log_file, err_file, null, null);
        batch.processBatch();

        out.println(handleBuffer.toString());

      }
      else {

        // Persist the dataObject in the servlet instance

        Hashtable _dataObject = new Hashtable();
        for (e = dataObject.keys(); e.hasMoreElements(); ) {
          s = (String)e.nextElement();
          sType = ((String [])dataObject.get(s))[0];
          sData = ((String [])dataObject.get(s))[1];
          _dataObject.put(s, new String[] { sType, sData });
        }
        dataObjectLibrary.put(doi, _dataObject);

      }

    }
    catch (MalformedPerl5PatternException x) { out.println("Problem with re: " + x.getMessage()); }
    catch (Exception x) { }
    catch (Throwable t) { }

    return doi;

  }


  // Method writeDataClient -

  private void writeDataClient(PrintWriter out, String doi, boolean isReadDataStore)
    throws IOException, Exception
  {
    StringBuffer handleBuffer = new StringBuffer();
    StringBuffer dataObjectBuffer = new StringBuffer();
    StringBuffer SOAPEnvelopeBuffer = new StringBuffer();
    int indent = 2;

    try {

      if (isOutputCode) {

        _printCode(out, doi);

      }
      else if (isOutputDump) {

        _printDump(out, doi);

      }
      else if (isOutputMenus) {

        _printMenus(out, doi);

      }
      else {

        // We're either generating a graph or writing raw XML or to the default output

        // Handle Values (only data values are considered)

        if (isOutputDefault) {

          if (!isOutputTerm) {
            out.println("This output from <font color=slateblue><b><i>yads</i></b></font>");
            out.println("shows how multiple resources are maintained");
            out.println("in a DataStore and how they are interrelated by the use of the DOI_MAP field.");
            out.println("The DOI Service talks directly to DOI Client applications using XML.");
            out.println("A DataObject is assembled as an RDF resource description which is then");
            out.println("wrapped within a SOAP (Simple Object Access Protocol) envelope.");
            out.println("<p>");
            out.println("The whole Client/Service exchange is completely transparent to the end user.");
            out.println("<hr>");
            out.println("<p>");
            out.println("This is <a href=\"http://dx.doi.org/" + doi + "\">doi:" + doi + "</a>");
            out.println("with default resolution.");
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
            out.println("<table width=100% border=0>");
            out.println("<tr>");
            out.println("<td>");
            out.println("<pre>");
            out.println("<p>");
            // out.println(counter + " <i>yads</i> accesses\n");

            handleBuffer.append("<font color=black>");
          }
          handleBuffer.append("DOI DataStore:\n\n");
          if (!isOutputTerm) {
            handleBuffer.append("</font>");
          }
  
          for (e = dataObject.keys(); e.hasMoreElements(); ) {
            s = (String)e.nextElement();
            sType = ((String [])dataObject.get(s))[0];
            sData = ((String [])dataObject.get(s))[1];
  
            handleBuffer.append("[" + s + ", " + DataObjectTypes.getHandleType(sType) + "] => " + sData + "\n");
          }
        }
  
        // DataObject Values
  
        String sTagO = "<"; String sTagC = ">";
  
        if (isOutputDefault) {
          if (!isOutputTerm) {
            SOAPEnvelopeBuffer.append("<font color=black>");
          }
          SOAPEnvelopeBuffer.append("DOI DataObject:\n\n");
          if (!isOutputTerm) {
            SOAPEnvelopeBuffer.append("</font>");
          }
          if (!isOutputTerm) {
            sTagO = "&lt;"; sTagC = "&gt;";
          }
        }
  
        SOAPEnvelopeBuffer.append(sTagO + "?xml version=\"1.0\" encoding=\"UTF-8\"?" + sTagC + "\n");
        SOAPEnvelopeBuffer.append(sTagO + "!--\n");
        SOAPEnvelopeBuffer.append("  yads - Yet Another DOI Service\n");
        SOAPEnvelopeBuffer.append("  " + dateTime + " - " + sTagO + "mailto:tony_hammond@harcourt.com" + sTagC + "\n");
        SOAPEnvelopeBuffer.append("--"  + sTagC + "\n");
        String success = dataObject.isEmpty() ? "fail" : "success";
  
        String sDOI = doi;
        sDOI = re.substitute("s/\\&/&amp;/g", sDOI);
        sDOI = re.substitute("s/\\</&lt;/g", sDOI);
        sDOI = re.substitute("s/\\>/&gt;/g", sDOI);
    
        SOAPEnvelopeBuffer.append(sTagO + "SOAP-ENV:Envelope\n");
        if (!isOutputXML && !isOutputTerm) {
          SOAPEnvelopeBuffer.append("  xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\n");
          SOAPEnvelopeBuffer.append("  SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"\n");
        } else {
          SOAPEnvelopeBuffer.append("  xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\n");
          SOAPEnvelopeBuffer.append("  SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"\n");
        }
        SOAPEnvelopeBuffer.append(sTagC + "\n");
        SOAPEnvelopeBuffer.append(sTagO + "SOAP-ENV:Body" + sTagC + "\n");
        SOAPEnvelopeBuffer.append("  " + sTagO + "DOI-SERVICE:" + serviceRequest + "Response\n");
        SOAPEnvelopeBuffer.append("    xmlns:DOI-SERVICE=\"http://dx.doi.org/1014/doi.service\"\n");
        SOAPEnvelopeBuffer.append("  " + sTagC + "\n");
  
        if (isOutputDefault && !isOutputTerm) {
          SOAPEnvelopeBuffer.append("<font color=red>");
        }
  
        dataObjectBuffer.append("    " + sTagO + "rdf:RDF" + "\n");
        dataObjectBuffer.append("      xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n");
        dataObjectBuffer.append("      xmlns:doi=\"doi:1014/10.1000/system.schema.2001-07-26#\"\n");
        dataObjectBuffer.append("    " + sTagC + "\n");
        dataObjectBuffer.append("      " + sTagO + "doi:Object rdf:about=\"doi:" + sDOI + "\"" + sTagC + "\n");
  
        indent++;
  
        // Now run though the DOI handle map
  
        StringTokenizer st = new StringTokenizer(dataMap);
  
        while (st.hasMoreTokens()) {
          s = (String)st.nextToken();
  
          if (s.equals("{")) {
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "doi:contains" + sTagC + "\n");
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "rdf:Bag" + sTagC + "\n");
          }
          else if (s.equals("}")) {
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/rdf:Bag" + sTagC + "\n");
            indent--;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/doi:contains" + sTagC + "\n");
            indent--;
          }
          else if (s.equals("[")) {
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "doi:contains" + sTagC + "\n");
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "rdf:Seq" + sTagC + "\n");
          }
          else if (s.equals("]")) {
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/rdf:Seq" + sTagC + "\n");
            indent--;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/doi:contains" + sTagC + "\n");
            indent--;
          }
          else if (s.equals("<")) {
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "doi:contains" + sTagC + "\n");
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "rdf:Alt" + sTagC + "\n");
          }
          else if (s.equals(">")) {
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/rdf:Alt" + sTagC + "\n");
            indent--;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/doi:contains" + sTagC + "\n");
            indent--;
          }
          else if (s.equals("(")) {
            indent++;
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "rdf:li rdf:parseType=\"Resource\"" + sTagC + "\n");
          }
          else if (s.equals(")")) {
            for (int i = 0; i < indent; i++) {
              dataObjectBuffer.append("  ");
            }
            dataObjectBuffer.append(sTagO + "/rdf:li" + sTagC + "\n");
            indent--;
          }
          else {
            sType = ((String [])dataObject.get(s))[0];
            sData = ((String [])dataObject.get(s))[1];
  
            sData = re.substitute("s/\\</&lt;/g", sData);
            sData = re.substitute("s/\\>/&gt;/g", sData);
            sData = re.substitute("s/\\&/&amp;/g", sData);
    
            for (int i = 0; i <= indent; i++) {
              dataObjectBuffer.append("  ");
            }
            if (DataObjectTypes.isRDFLiteral(sType)) {
              dataObjectBuffer.append(sTagO + "doi:" + sType + sTagC);
            }
            else {
              dataObjectBuffer.append(sTagO + "doi:" + sType + " rdf:resource=\"");
            }
  
            if (isOutputDefault && !isOutputTerm) {
              if (re.match("/^http:/i", sData)) {
                dataObjectBuffer.append("<a href=\"" + sData + "\">");
                dataObjectBuffer.append(sData);
                dataObjectBuffer.append("</a>");
              }
              else if (re.match("/^(doi:)(.*)/i", sData)) {
  
                match = re.getMatch();
                sData = match.group(2);
  
                dataObjectBuffer.append("<a href=\"" + BASE_URL + className);
                dataObjectBuffer.append("?doi=" + sData + "\">doi:");
                dataObjectBuffer.append(sData);
                dataObjectBuffer.append("</a>");
              }
              else {
                dataObjectBuffer.append("<font color=purple>");
                dataObjectBuffer.append(sData);
                dataObjectBuffer.append("</font>");
              }
            }
            else {
              dataObjectBuffer.append(sData);
            }
  
            if (DataObjectTypes.isRDFLiteral(sType)) {
              dataObjectBuffer.append(sTagO + "/doi:" + sType + sTagC + "\n");
            }
            else {
              dataObjectBuffer.append("\"/" + sTagC + "\n");
            }
   
          }
        }
        dataObjectBuffer.append("      " + sTagO + "/doi:Object" + sTagC + "\n");
        dataObjectBuffer.append("    " + sTagO + "/rdf:RDF" + sTagC + "\n");
  
        SOAPEnvelopeBuffer.append(dataObjectBuffer.toString());
  
        if (isOutputDefault && !isOutputTerm) {
          SOAPEnvelopeBuffer.append("</font>");
        }
        SOAPEnvelopeBuffer.append("  " + sTagO + "/DOI-SERVICE:" + serviceRequest + "Response" + sTagC + "\n");
        SOAPEnvelopeBuffer.append(sTagO + "/SOAP-ENV:Body" + sTagC + "\n");
        SOAPEnvelopeBuffer.append(sTagO + "/SOAP-ENV:Envelope" + sTagC + "\n");

        // Now let's get it written out in the right order 

        if (isOutputGraph) {

          _printGraph(out, doi, dataObjectBuffer);

        }
        else {
          if (isReadDataStore) {
            if (!isOutputXML && !isOutputTerm) {
              out.print("<font color=\"#999999\">");
            }
            out.print(handleBuffer.toString());
          }
          else {
            if (!isOutputXML && !isOutputTerm) {
              out.print("<font color=\"blue\">");
            }
            out.print(SOAPEnvelopeBuffer.toString());
          }
          if (!isOutputXML && !isOutputTerm) {
            out.println();
          }
          if (isReadDataStore) {
            if (!isOutputXML && !isOutputTerm) {
              out.print("<font color=\"brown\">");
            }
            out.print(SOAPEnvelopeBuffer.toString());
          }
          else {
            if (!isOutputXML && !isOutputTerm) {
              out.print("<font color=\"#999999\">");
            }
            out.print(handleBuffer.toString());
          }
          if (!isOutputXML && !isOutputTerm) {
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
          }
        }
      }

    } catch (Exception x) { }

  }

  // Method _printCode -

  private void _printCode(PrintWriter out, String doi)
    throws IOException, Exception
  {
    try {

      out.println("<html>");

      _printHeader(out);
      _printBodyHead(out);

      out.println("The following");
      switch (codeFormat) {
        case JAVA: out.println("Java"); break;
        case PERL: out.println("Perl"); break;
        case PYTHON: out.println("Python"); break;
        case RUBY: out.println("Ruby"); break;
      }
      out.println("code shows how this DOI DataObject can be built using the");
      out.println("<a href=\"http://dx.doi.org/1014/data\">DOI Services API</a>.");
      out.println("<hr>");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("<table width=100% border=0>");
      out.println("<tr>");
      out.println("<td>");
      out.println("<pre>");
      out.print(writeCodeObject(doi));
      out.println("</pre>");

      _printBodyTail(out);
 
      out.println("</html>");

    } catch (Exception x) { }
  }

  // Method _printDump -

  private void _printDump(PrintWriter out, String doi)
    throws IOException, Exception
  {
    try {

      out.println("<html>");

      _printHeader(out);
      _printBodyHead(out);

      out.println("The following text dump of the DataObject shows how the DataMap construct");
      out.println("is used to organize the resources into a hierarchy of resource groups.");
      out.println("Resources are grouped by the \"( )\" delimiters, while");
      out.println("the grouping delimiters \"{ }\", \"[ ]\", and \"< >\" imply that the groups are");
      out.println("unordered, sequential, and alternatives, respectively.");
      out.println("<hr>");
      out.println("<p>");
      out.println("This is <a href=\"http://dx.doi.org/" + doi + "\">doi:" + doi + "</a>");
      out.println("with default resolution.");
      out.println("<p>");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("<table width=100% border=0>");
      out.println("<tr>");
      out.println("<td>");
      out.println("<pre>");
      out.print(writeDumpObject(doi));
      out.println("</pre>");

      _printBodyTail(out);
 
      out.println("</html>");

    } catch (Exception x) { }
  }


  // Method _printGraph -

  private void _printGraph(PrintWriter out, String doi, StringBuffer dataObjectBuffer)
    throws IOException, Exception
  {
    try {

      String dataPost = "RDF=" + URLEncoder.encode(dataObjectBuffer.toString());
      switch (graphFormat) {
        case GIF: dataPost += "&FORMAT=GIF_LINK"; break;
        case PNG: dataPost += "&FORMAT=PNG_LINK"; break;
        case SVG: dataPost += "&FORMAT=SVG_LINK"; break;
        case POSTSCRIPT: dataPost += "&FORMAT=PS_LINK"; break;
      }
      dataPost += "&ORIENTATION=TB";
      dataPost += "&NODE_COLOR=Black";
      dataPost += "&NODE_TEXT_COLOR=Blue";
      dataPost += "&EDGE_COLOR=Darkgreen";
      dataPost += "&EDGE_TEXT_COLOR=Red";
      dataPost += "&Submit=Parse+RDF";

      URL url = new URL("http://www.w3.org/RDF/Validator/ARPServlet");
      URLConnection connection = url.openConnection();
      connection.setDoOutput(true);
      connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); 
      connection.setRequestProperty("Content-Length", String.valueOf(dataPost.length())); 

      PrintWriter post = new PrintWriter(connection.getOutputStream());
      post.print(dataPost);
      post.close();

      BufferedReader postBack = new BufferedReader(new InputStreamReader(
                              connection.getInputStream()));

      out.println("<html>");

      _printHeader(out);
      _printBodyHead(out);

      out.println("The");
      switch (graphFormat) {
        case GIF: out.println("GIF"); break;
        case PNG: out.println("PNG"); break;
        case SVG: out.println("SVG"); break;
        case POSTSCRIPT: out.println("PostScript"); break;
      }
      out.println("graph was generated by validating the RDF resource description of the DOI");
      out.println("DataObject against the W3C's new online validation sevice");
      out.println("<a href=\"http://www.w3.org/RDF/Valiadator\">RDF Validator</a>,");
      out.println("which is based on <a href=\"http://www-uk.hpl.hp.com/people/jjc/arp/\">Another");
      out.println("RDF Parser (ARP)</a> from HP Labs.");
      out.println("(This service makes use of AT&T Labs' GraphViz open source graph drawing software.)");
      out.println("<p>");
      out.println("Note: You may need to use the scrollbars to locate the graph.");
      out.println("<hr>");
      out.println("<p>");
      //out.println("dataPost=" + dataPost);

      String inputLine;

      while ((inputLine = postBack.readLine()) != null) {

        // RE match problem with "/" character
        //
        // if (re.match("|(\\/servlet\\d+.\\w+)|i", inputLine)) {
        //   match = re.getMatch();
        //   out.print("This is <a href=\"http://www.w3.org/RDF/Validator/ARPServlet.tmp/");
        //   out.println(match.group(1) + "\">doi:" + doi + "</a>");
        // }

        if (inputLine.startsWith("<a href=\"ARPServlet.tmp/")) {
          inputLine = inputLine.substring(24).trim();
          StringTokenizer st = new StringTokenizer(inputLine, ">");

          s = (String)st.nextToken();
          out.print("This is <a href=\"http://www.w3.org/RDF/Validator/ARPServlet.tmp/");
          out.println(s + ">doi:" + doi + "</a>");
        }
      }
      out.println("as a");
      switch (graphFormat) {
        case GIF: out.println("GIF"); break;
        case PNG: out.println("PNG"); break;
        case SVG: out.println("SVG"); break;
        case POSTSCRIPT: out.println("PostScript"); break;
      }
      out.println("graph.");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("<table width=100%>");
      out.println("<tr>");
      out.println("<td>");
      out.print("<img src=\"http://www.w3.org/RDF/Validator/ARPServlet.tmp/");
      out.println(s + ">");
      postBack.close();

      _printBodyTail(out);

      out.println("</html>");

    } catch (Exception x) { }
  }

  // Method _printMenus -

  private void _printMenus(PrintWriter out, String doi)
    throws IOException, Exception
  {
    try {

      out.println("<html>");

      _printHeader(out);
      _printBodyHead(out);

      out.println("<table width=100%>");
      out.println("<tr>");
      out.println("<td>");
      out.println("The JavaScript menu popup was simply generated by a call to the \"<i>to_menus</i>\" method");
      out.println("of the <a href=\"http://dx.doi.org/1014/data\">DOI Services API</a>.");
      out.println("<hr>");
      out.println("<p>");

      URL url = new URL(MENU_WRITER + "?doi=" + doi);
      URLConnection connection = url.openConnection();

      BufferedReader postBack = new BufferedReader(new InputStreamReader(
                              connection.getInputStream()));

      String inputLine;

      while ((inputLine = postBack.readLine()) != null) {
        out.println(inputLine);
      }
    
      postBack.close();
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");

      _printBodyTail(out);
      out.println("</html>");

    } catch (Exception x) { }
  }

  // Method writeCodeObject -

  private String writeCodeObject(String doi) {

    StringBuffer codeBuffer = new StringBuffer();
    int indent = 1;

    switch (codeFormat) {
      case JAVA:
        codeBuffer.append("/*\n");
        codeBuffer.append("  ########################################################################\n");
        codeBuffer.append("  #\n");
        codeBuffer.append("  # Java code to build the DOI DataObject for\n");
        codeBuffer.append("  #\n");
        codeBuffer.append("  # 'doi:" + doi + "'\n");
        codeBuffer.append("  #\n");
        codeBuffer.append("  # Author - Tony Hammond &lt;mailto:tony_hammond@harcourt.com&gt;\n");
        codeBuffer.append("  #\n");
        codeBuffer.append("  ########################################################################\n");
        codeBuffer.append("*/\n\n");
        codeBuffer.append("import doi.DataObject;\n\n");
        codeBuffer.append("d = new DataObject(\"" + doi + "\");\n");
        // codeBuffer.append("d \\\n");
        codeBuffer.append("\n");
        break;
      case PERL:
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Perl code to build the DOI DataObject for\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# 'doi:" + doi + "'\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Author - Tony Hammond &lt;mailto:tony_hammond@harcourt.com&gt;\n");
        codeBuffer.append("#\n");
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("\n");
        codeBuffer.append("use DOI::DataObject;\n\n");
        codeBuffer.append("$d = new DOI::DataObject(\"" + doi + "\");\n");
        // codeBuffer.append("$d \\\n");
        codeBuffer.append("\n");
        break;
      case PYTHON:
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Python code to build the DOI DataObject for\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# 'doi:" + doi + "'\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Author - Tony Hammond &lt;mailto:tony_hammond@harcourt.com&gt;\n");
        codeBuffer.append("#\n");
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("\n");
        codeBuffer.append("import dataObject\n\n");
        codeBuffer.append("d = dataObject.DataObject(\"" + doi + "\")\n");
        // codeBuffer.append("d \\\n");
        codeBuffer.append("\n");
        break;
      case RUBY:
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Ruby code to build the DOI DataObject for\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# 'doi:" + doi + "'\n");
        codeBuffer.append("#\n");
        codeBuffer.append("# Author - Tony Hammond &lt;mailto:tony_hammond@harcourt.com&gt;\n");
        codeBuffer.append("#\n");
        codeBuffer.append("########################################################################\n");
        codeBuffer.append("\n");
        codeBuffer.append("require 'dataObject'\n\n");
        codeBuffer.append("d = DataObject.new(\"" + doi + "\")\n");
        // codeBuffer.append("d \\\n");
        codeBuffer.append("\n");
        break;
    }

    // Now run though the DOI handle map

    StringTokenizer st = new StringTokenizer(dataMap);

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();

      if (s.equals("{")) {
        if (indent == 1) {
          switch (codeFormat) {
            case JAVA: codeBuffer.append("d"); break;
            case PERL: codeBuffer.append("$d"); break;
            case PYTHON: codeBuffer.append("d"); break;
            case RUBY: codeBuffer.append("d"); break;
          }
        }
        else {
          for (int i = 0; i < indent; i++) {
            codeBuffer.append("  ");
          }
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(".addContainer(new Container(\"bag\")\n"); break;
          case PERL: codeBuffer.append("->addContainer(new Container(\"bag\")\n"); break;
          case PYTHON: codeBuffer.append(".addContainer(new Container(\"bag\")\n"); break;
          case RUBY: codeBuffer.append(".addContainer(Container.new(\"bag\") \\\n"); break;
        }
        indent++;
      }
      else if (s.equals("}")) {
        indent--;
        if (indent == 1) {
          switch (codeFormat) {
            case JAVA: codeBuffer.append("  );\n"); break;
            case PERL: codeBuffer.append("  );\n"); break;
            case PYTHON: codeBuffer.append("  )\n"); break;
            case RUBY: codeBuffer.append("  )\n"); break;
          }
        }
        else {
          for (int i = 0; i < indent; i++) {
            codeBuffer.append("  ");
          }
          switch (codeFormat) {
            case JAVA: codeBuffer.append(")\n"); break;
            case PERL: codeBuffer.append(")\n"); break;
            case PYTHON: codeBuffer.append(")\n"); break;
            case RUBY: codeBuffer.append(") \\\n"); break;
          }
        }
      }
      else if (s.equals("[")) {
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(".addContainer(new Container(\"seq\")\n"); break;
          case PERL: codeBuffer.append("->addContainer(new Container(\"seq\")\n"); break;
          case PYTHON: codeBuffer.append(".addContainer(new Container(\"seq\")\n"); break;
          case RUBY: codeBuffer.append(".addContainer(Container.new(\"seq\") \\\n"); break;
        }
        indent++;
      }
      else if (s.equals("]")) {
        indent--;
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(")\n"); break;
          case PERL: codeBuffer.append(")\n"); break;
          case PYTHON: codeBuffer.append(")\n"); break;
          case RUBY: codeBuffer.append(") \\\n"); break;
        }
      }
      else if (s.equals("<")) {
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(".addContainer(new Container(\"alt\")\n"); break;
          case PERL: codeBuffer.append("->addContainer(new Container(\"alt\")\n"); break;
          case PYTHON: codeBuffer.append(".addContainer(new Container(\"alt\")\n"); break;
          case RUBY: codeBuffer.append(".addContainer(Container.new(\"alt\") \\\n"); break;
        }
        indent++;
      }
      else if (s.equals(">")) {
        indent--;
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(")\n"); break;
          case PERL: codeBuffer.append(")\n"); break;
          case PYTHON: codeBuffer.append(")\n"); break;
          case RUBY: codeBuffer.append(") \\\n"); break;
        }
      }
      else if (s.equals("(")) {
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(".addDataGroup(new DataGroup()\n"); break;
          case PERL: codeBuffer.append("->addDataGroup(new DOI::DataGroup()\n"); break;
          case PYTHON: codeBuffer.append(".addDataGroup(new DataGroup()\n"); break;
          case RUBY: codeBuffer.append(".addDataGroup(DataGroup.new \\\n"); break;
        }
        indent++;
      }
      else if (s.equals(")")) {
        indent--;
        for (int i = 0; i < indent; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(")\n"); break;
          case PERL: codeBuffer.append(")\n"); break;
          case PYTHON: codeBuffer.append(")\n"); break;
          case RUBY: codeBuffer.append(") \\\n"); break;
        }
      }
      else {
        sType = ((String [])dataObject.get(s))[0];
        sData = ((String [])dataObject.get(s))[1];

        sData = re.substitute("s/\\</&lt;/g", sData);
        sData = re.substitute("s/\\>/&gt;/g", sData);
        sData = re.substitute("s/\\&/&amp;/g", sData);

        for (int i = 0; i <= indent - 1; i++) {
          codeBuffer.append("  ");
        }
        switch (codeFormat) {
          case JAVA: codeBuffer.append(".addData(\"" + sType + "\", \"" + sData + "\")\n"); break;
          case PERL: codeBuffer.append("->addData(\"" + sType + "\", \"" + sData + "\")\n"); break;
          case PYTHON: codeBuffer.append(".addData(\"" + sType + "\", \"" + sData + "\")\n"); break;
          case RUBY: codeBuffer.append(".addData(\"" + sType + "\", \"" + sData + "\") \\\n"); break;
        }
 
      }
    }

    switch (codeFormat) {
      case JAVA:
        codeBuffer.append("\n\n// d.dump();\n\n// d.createDataStore();\n");
        break;
      case PERL:
        codeBuffer.append("\n\n# $d->dump();\n\n# $d->createDataStore();\n");
        break;
      case PYTHON:
        codeBuffer.append("\n\n# d.dump()\n\n# d.createDataStore()\n");
        break;
      case RUBY:
        codeBuffer.append("\n\n# d.dump\n\n# d.createDataStore\n");
        break;
     }

    return codeBuffer.toString();

  }

  // Method writeDumpObject -

  private String writeDumpObject(String doi) {

    StringBuffer dumpBuffer = new StringBuffer();

    String s;
    String type, data;

    int nDataGroups = 0;
    int indent = -1;

    Perl5Util re = new Perl5Util();

    dumpBuffer.append("DataMap = " + this.dataMap + "\n\n");

    StringTokenizer st = new StringTokenizer(this.dataMap);

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();
      if (s.equals("(")) { nDataGroups++; }
    }
    s = Integer.toString(nDataGroups);
   
    dumpBuffer.append("DataGroups (" + s + ") =" + "\n");

    // Now run though the DOI handle map

    st = new StringTokenizer(this.dataMap);

    while (st.hasMoreTokens()) {
      s = (String)st.nextToken();

      if (s.equals("{") || s.equals("[") || s.equals("<") || s.equals("(")) {
        indent++;
        for (int i = 1; i <= indent; i++) { dumpBuffer.append("  "); }
        dumpBuffer.append(s + "\n");
      }
      else if (s.equals("}") || s.equals("]") || s.equals(">") || s.equals(")")) {
        for (int i = 1; i <= indent; i++) { dumpBuffer.append("  "); }
        dumpBuffer.append(s + "\n");
        indent--;
      }
      else {
        type = ((String [])dataObject.get(s))[0];
        data = ((String [])dataObject.get(s))[1];

        data = re.substitute("s/&lt;/\\</g", data);
        data = re.substitute("s/&gt;/\\>/g", data);
        data = re.substitute("s/&amp;/\\&/g", data);

        for (int i = 1; i <= indent; i++) { dumpBuffer.append("  "); }
        dumpBuffer.append("  " + type + " => " + data + "\n");
      }
    }

    return dumpBuffer.toString();

  }

  // Method _printHeader -

  private void _printHeader(PrintWriter out)
    throws Exception
  {
    try {

      out.println("<head>");
      out.println("<title>" + className + "</title>");
      out.println("<style type='text/css'>");
      out.println("<!--");
      out.println("  body { background-color: white }");
      out.println("  body { color: black }");
      out.println("  body { font-family: arial, helvetica, sans-serif }");
      out.println("  body { font-size: 12pt }");
      out.println("  h1 { color: slateblue }");
      out.println("  h1 { font-size: 22pt }");
      out.println("  h3 { color: slateblue }");
      out.println("  h1 { font-family: arial, helvetica, sans-serif }");
      // out.println("  p { font-family: arial, helvetica, sans-serif }");
      // out.println("  td { font-family: arial, helvetica, sans-serif }");
      // out.println("  hr { font-family: arial, helvetica, sans-serif }");
      // out.println("  pre { font-family: courier }");
      out.println("-->");
      out.println("</style>");
      // out.println("<base href='" + BASE_URL + "'>");
      out.println("</head>");

    } catch (Exception x) { }
  }

  // Method _printBodyHead -

  private void _printBodyHead(PrintWriter out)
    throws Exception
  {
    try {

      out.println("<body>");
      out.println("<center>");
      out.println("<table width=90% border=0>");
      out.println("<tr>");
      out.println("<td>");
      out.println("<table width=100% border=0>");
      out.println("<tr align=bottom>");
      out.println("<td align=left valign=bottom>");
      out.println("<h1><i>yads</i></h1>");
      out.println("</td>");
      out.println("<td align=right valign=bottom>");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");

    } catch (Exception x) { }
  }


  // Method _printBodyTail -

  private void _printBodyTail(PrintWriter out)
    throws Exception
  {
    try {

      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("</center>");
      out.println("</body>");

    } catch (Exception x) { }
  }


  // Method _printForm -

  private void _printForm(PrintWriter out, String doi)
    throws Exception
  {
    try {

      out.println("<table width=100% border=0>");
      out.println("<tr>");
      out.println("<td>");
      out.println("This is <font color=slateblue><b><i>yads</i></b></font> - <i>Yet Another DOI Service</i>,");
      out.println("a tool which has been developed");
      out.println("for the <a href=\"http://www.doi.org/announce.html#maillist\">DOI-SDI</a>");
      out.println("(or DOI Services Definition Interface) project.");
      out.println("It shows how DOIs can be simply resolved to multiple resources");
      out.println("and crucially how those resources are themselves interrelated.");
      out.println("The project aims to provide a framework for content providers to deploy strategic links over the Internet.");
      out.println("(Some general design principles are noted");
      out.println("<a href=\"http://www2.harcourt-international.com/~tony/doi/yads/yads.html\">here</a>.)");
      out.println("<p>");
      out.println("What is a DOI? A DOI is a managed identifier");
      out.println("of an intellectual property entity which enables the network retrieval of a set of");
      out.println("related services.");
      out.println("(For further information see <a href=\"http://dx.doi.org/10.1000/1\">doi:10.1000/1</a>.)");
      out.println("<p>");
      out.println("The goal of the current work is to facilitate new and extended");
      out.println("DOI Services built upon a common");
      out.println("<a href=\"http://dx.doi.org/1014/data\">DOI Services API</a>.");
      out.println("The scope is multiple resolution.");
      out.println("(Make");
      out.println("<font color=slateblue><b><i>yads</i></b></font>");
      out.println("your default DOI resolver:");
      out.println("<a href=\"http://www.doi.org/cgi-bin/pushcookie.cgi?BASE-URL=http%3A//www2.harcourt-international.com/ap/servlet/yadsDispatcher&Redirect=http%3A//www2.harcourt-international.com/ap/servlet/" + className + "\">Set default</a>");
      out.println("|");
      out.println("<a href=\"http://www.doi.org/cgi-bin/pullcookie.cgi?BASE-URL=http%3A//www2.harcourt-international.com/ap/servlet/yadsDispatcher&Redirect=http%3A//www2.harcourt-international.com/ap/servlet/" + className + "\">Unset default</a>");
      out.println(")");
      out.println("</td>");
      out.println("</tr>");
      out.println("<tr>");
      out.println("<td>");
      out.println("<hr>");
      out.println("<p>");
      out.println("Enter a DOI in the box below or enter \"?\" for a random DOI");
      // out.println("<br>");
      // out.println("(<i>Note: Refreshing this page returns a new random DOI</i>):");
      out.println("<form method=post action=" + className + ">");
      out.println("<input type=hidden name=form value=1>");
      out.println("<input type=text name=doi value=\"doi:" + doi + "\" size=60>&nbsp;&nbsp;&nbsp;&nbsp;<input");
      out.println(" type=submit value=\"Resolve DOI\">&nbsp;&nbsp;&nbsp;&nbsp;<input");
      out.println(" type=reset value=\"Reset\">");
      out.println("<p>");
      out.println("<table width=100%>");
      out.println("<tr>");
      out.println("<td width=50%>");
      out.println("<br>");
      out.println("<i>Visualizations</i>");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"menus\">Show me as a menu popup");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"dump\" checked>Show me in simple text form");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"graph\">Show me in graph form as&nbsp;&nbsp;");
      out.println("<select name=\"graphFormat\">");
      out.println("<option value=\"GIF\">GIF</option>");
      out.println("<option value=\"PNG\">PNG</option>");
      out.println("<option value=\"SVG\">SVG</option>");
      out.println("<option value=\"PostScript\">PostScript</option>");
      out.println("</select>");
      out.println("</td>");
      out.println("<td width=50%>");
      out.println("<br>");
      out.println("<i>Technical Details</i>");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"data\">Show me the raw resources");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"xml\">Show me the raw XML");
      out.println("<p>");
      out.println("&nbsp;&nbsp;&nbsp;&nbsp;<input type=radio name=rtnType value=\"code\">Show me how to code this in&nbsp;&nbsp;");
      out.println("<select name=\"codeFormat\">");
      out.println("<option value=\"Java\">Java</option>");
      out.println("<option value=\"Perl\">Perl</option>");
      out.println("<option value=\"Python\">Python</option>");
      out.println("<option value=\"Ruby\">Ruby</option>");
      out.println("</select>");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("</form>");
      out.println("<hr>");
      out.println("<a href=\"mailto:tony_hammond@harcourt.com\">Mailto</a>");
      out.println("<br>");
      out.println("Copyright &copy; 2001 by");
      out.println("Academic Press, a Harcourt Science and Technology Company.");
      out.println("</td>");
      out.println("</tr>");
      out.println("</table>");

    } catch (Exception x) { }
  }


  /**
   * 
   * 
   */

  // Method _dateTime -

  private String _dateTime(boolean longForm) {

    StringBuffer date = new StringBuffer();
    Calendar cal = Calendar.getInstance();

    int month = cal.get(Calendar.MONTH);
    int day = cal.get(Calendar.DAY_OF_MONTH);
    int hour = cal.get(Calendar.HOUR);
    int minute = cal.get(Calendar.MINUTE);
    int second = cal.get(Calendar.SECOND);
    int millisecond = cal.get(Calendar.MILLISECOND);

    date.append(cal.get(Calendar.YEAR) + "-");
    if (++month < 10) { date.append("0"); }
    date.append(month + "-");
    if (day < 10) { date.append("0"); }
    date.append(cal.get(Calendar.DAY_OF_MONTH));
    date.append("T");
    if (hour < 10) { date.append("0"); }
    date.append(cal.get(Calendar.HOUR) + ":");
    if (minute < 10) { date.append("0"); }
    date.append(cal.get(Calendar.MINUTE) + ":");
    if (second < 10) { date.append("0"); }
    date.append(cal.get(Calendar.SECOND));
    if (longForm) {
      date.append(".");
      if (millisecond < 10) { date.append("00"); }
      else if (millisecond < 100) { date.append("0"); }
      date.append(cal.get(Calendar.MILLISECOND));
    }
    else {
      date.append(".000");
    }

    return date.toString();
      
  }


  /**
   * Decodes the special characters in a URL encoded string *except* for
   * the + to space conversion.
   */

  // Method _decodeURLIgnorePlus -

  public static String _decodeURLIgnorePlus(String str)
    throws UTFDataFormatException
  {
    byte utf8Buf[] = new byte[str.length()];
    int utf8Loc = 0;
    int strLoc = 0;
    int strLen = str.length();
    while(strLoc < strLen) {
      char ch = str.charAt(strLoc++);
      if(ch=='%' && strLoc+2<=strLen) {
        utf8Buf[utf8Loc++] = _decodeHexByte(str.charAt(strLoc++),
                                            str.charAt(strLoc++));
      } else {
        utf8Buf[utf8Loc++] = (byte)ch;
      }
    }

    // if(!Util.isValidString(utf8Buf, 0, utf8Loc)) {
    //   throw new UTFDataFormatException("Invalid UTF-8 encoding: "+str);
    // }

    try {
      return new String(utf8Buf, 0, utf8Loc, "UTF8");
    } catch (Exception e) {
      return new String(utf8Buf, 0, utf8Loc);
    }
  }
  
  // Method _decodeHexByte -

  public static final byte _decodeHexByte(char ch1, char ch2) {
    ch1 = (char) ((ch1>='0' && ch1<='9') ? ch1-'0' : ((ch1>='a' && ch1<='z') ? ch1-'a'+10 : ch1-'A'+10));
    ch2 = (char) ((ch2>='0' && ch2<='9') ? ch2-'0' : ((ch2>='a' && ch2<='z') ? ch2-'a'+10 : ch2-'A'+10));
    return (byte)(ch1<<4 | ch2);
  }

  
}

// Defining a class for writing the object to a file 

class ObjectWrite { 

  public void objectWrite(Hashtable dataObjectLibaray) { 

    try { 
      // String sFile = SERVLET_DATA + "dataObjects.out"; 
      // FileOutputStream fos =  new FileOutputStream(sFile); 
      FileOutputStream fos =  new FileOutputStream("/opt/HARCap/servlet_data/dataObjects.out"); 
      ObjectOutputStream objOs = new ObjectOutputStream(fos); 
      objOs.writeObject(dataObjectLibaray); 
      objOs.flush(); 
      fos.close(); 
    }  catch (NotSerializableException sx) { 
      System.err.println(sx); 
    }  catch (FileNotFoundException fx) { 
      System.err.println(fx); 
    }  catch (IOException sx) { 
      System.err.println(sx); 
    } 
  } 
} 

// Defining a class for reading object from a file 
  
class ObjectRead {  

  public Hashtable objectRead() { 

    Hashtable dataObjectLibrary = new Hashtable();

    try { 
      // String sFile = SERVLET_DATA + "dataObjects.out"; 
      // FileInputStream fis = new FileInputStream(sFile); 
      FileInputStream fis = new FileInputStream("/opt/HARCap/servlet_data/dataObjects.out");
      ObjectInputStream objIs = new ObjectInputStream(fis); 
      dataObjectLibrary = (Hashtable)objIs.readObject(); 
      fis.close(); 
    }   catch (NotSerializableException sx) { 
      System.err.println(sx); 
    }  catch (FileNotFoundException fx) { 
      System.err.println(fx); 
    }  catch (IOException sx) { 
      System.err.println(sx); 
    }  catch (ClassNotFoundException cx) { 
      System.err.println(cx); 
    } 
    return dataObjectLibrary;
  } 
} 
 
