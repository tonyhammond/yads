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

public class yadsDispatcher extends HttpServlet implements java.io.Serializable {
  
  private int counter = 0;
  
  // private String className = this.getClass().getName();

  private static final String BASE_URL
    = "http://www2.harcourt-international.com/ap/servlet/";

  // Method init - 

  public void init(ServletConfig config) throws ServletException {

    super.init(config);

  }

  // Method destroy - 

  public void destroy() {

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

    PrintWriter out;
    out = new PrintWriter(res.getOutputStream(), true);

    try {
      counter++;

      String doi = req.getParameter("id");

      // remove URI scheme
      if (doi.startsWith("doi:")) {
        doi = doi.substring(4);
      }

      URL url = new URL(BASE_URL + "yads?rtnType=graph&graphFormat=GIF&doi=" + doi);
      URLConnection connection = url.openConnection();

      BufferedReader postBack = new BufferedReader(new InputStreamReader(
                              connection.getInputStream()));

      String inputLine;

      while ((inputLine = postBack.readLine()) != null) {
        out.println(inputLine);
      }
    
      postBack.close();

    } catch (Throwable e) { }

    try {
      if (counter % 5 == 0) {
        counter = 0;
        System.gc();
        System.runFinalization();
      }
    } catch (Throwable e) { }
  }

}
