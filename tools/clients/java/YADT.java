/*
  ########################################################################
  #
  # yads.doi.util.YADT - A Java application for querying DOI DObjects
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  ########################################################################
*/

package yads.doi.apps;

import yads.doi.lib.*;
import java.io.*;
import java.util.*;

/**
 * <b>This is YADT - Yet Another DOI Tool</b>.
 * <p>
 * The YADT class provides a {@link #main} method which implements
 * a simple command line tool for querying DObjects.
 * <p>
 * Usage: <code>java -classpath DObject.jar yads.doi.apps.YADT [options] &lt;doi&gt;</code>
 * <p>
 * <pre>  -r          : get random DOI</pre>
 * <pre>  -n          : print DObject as RDF/N3</pre>
 * <pre>  -x          : print DObject as RDF/XML</pre>
 * <p>
 * <pre>  -d          : print text dump of the DObject</pre>
 * <pre>  -t          : print the DObject data types</pre>
 * <pre>  -v          : print the DObject data values</pre>
 * <p>
 * <pre>  -h          : print this help message</pre>
 * <pre>  -V          : print the version number of YADT</pre>
 *
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class YADT {

  public static final String YADT_VERSION = "0.2";

  static PrintStream out = System.out;

  Map opts;
  List args;

  YADT (String[] argv) {

    this.opts = new HashMap();
    this.args = new ArrayList();

    for (int i = 0; i < argv.length; i++) { 

      if ("-r".equalsIgnoreCase(argv[i]))
        this.opts.put("-r", null);             // Random DOI
      else if ("-n".equalsIgnoreCase(argv[i]))
        this.opts.put("-n", null);             // Print RDF/N3
      else if ("-x".equalsIgnoreCase(argv[i]))
        this.opts.put("-x", null);             // Print RDF/XML
      else if ("-d".equalsIgnoreCase(argv[i]))
        this.opts.put("-d", null);             // Dump
      else if ("-t".equalsIgnoreCase(argv[i]))
        this.opts.put("-t", null);             // Types
      else if ("-v".equals(argv[i]))
        this.opts.put("-v", null);             // Values
      else if ("-h".equalsIgnoreCase(argv[i]))
        this.opts.put("-h", null);             // Help
      else if ("-V".equals(argv[i]))
        this.opts.put("-V", null);             // Version
      else if (argv[i].startsWith("doi:"))
        this.args.add(argv[i]);                // DOI argument
      else if (argv[i].startsWith("10"))
        this.args.add(argv[i]);                // DOI argument
      
    }
    
    // Print usage if no arguments are supplied
    if (this.args.isEmpty()) {
      this.opts.put("-h", null);             // Help
    }

  }


  static void _version () {
  
    out.println("This is YADT (Yet Another DOI Tool, Java version " + YADT_VERSION + ")");
    out.println();
  
    System.exit(1);

  }
  
  
  static void _usage () {
  
    out.println("This is YADT (Yet Another DOI Tool, Java version " + YADT_VERSION + ")");
    out.println();
    out.println("Usage: java -classpath DObject.jar yads.doi.apps.YADT [options] <doi> ...");
    out.println();
    out.println("  -r          : get random DOI");
    out.println("  -n          : print DObject as RDF/N3");
    out.println("  -x          : print DObject as RDF/XML");
    out.println();
    out.println("  -d          : print text dump of the DObject");
    out.println("  -t          : print the DObject data types");
    out.println("  -v          : print the DObject data values");
    out.println();
    out.println("  -h          : print this help message");
    out.println("  -V          : print the version number of YADT");
  
    System.exit(1);

  }
  
  public static void main (String[] argv) {

    String doi;
    String key, val;
/*
    BufferedReader in
      = new BufferedReader(new InputStreamReader(System.in));
    String input;

    try {
      while ((input = in.readLine()) != null) {
        input += input;
      }
    }
    catch {
    }
 
    if (input != null) {
      System.out.print(input);
    }
*/

    YADT y = new YADT(argv);
  
    if (y.opts.containsKey("-h"))
      YADT._usage();
    else if (y.opts.containsKey("-V"))
      YADT._version();
    
    if (y.opts.containsKey("-r"))
      y.args.add("?");

    for (Iterator i_ = y.args.iterator(); i_.hasNext(); ) {

      doi = (String)i_.next();
    
      if (doi.startsWith("doi:"))
        doi = doi.substring(4);        // Remove possible URI scheme
    
      DObject d = new DObject(doi);
      if (doi.equals("10.1234/567")) {
        d.fromXML(DObjectInstance.RDF);
      }
      else {
        d.readDataStore();
      }

      if (y.opts.isEmpty()) {
        System.out.print(d);
      }
      else {
        for (Iterator j_ = y.opts.entrySet().iterator(); j_.hasNext(); ) {
  
          Map.Entry e = (Map.Entry)j_.next();
          key = e.getKey().toString();
  
          if (key.equals("-n"))
            out.print(d.toNotation3());
  
          if (key.equals("-x"))
            out.print(d.toXML());
  
          else if (key.equals("-d"))
            d.dump(); 
  
          else if (key.equals("-t"))
            for (Iterator k_ = d.getMemberTypes().iterator(); k_.hasNext(); ) {
              out.println(k_.next());
            }
  
          else if (key.equals("-v"))
            for (Iterator k_ = d.getMemberValues().iterator(); k_.hasNext(); ) {
              out.println(k_.next());
            }
        }
      }
    }
  }

} 
