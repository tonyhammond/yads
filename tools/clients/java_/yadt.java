/**
  ########################################################################
  #
  # yadt.java - Yet Another DOI Tool (this version for Java)
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

import java.io.*;
import java.util.*;
import doi.DataObject;
import doi.DataGroup;

public class yadt {

  public static final String YADT_VERSION = "0.1";

  static PrintStream out = System.out;

  Map opts;
  List args;

  yadt (String[] argv) {

    this.opts = new HashMap();
    this.args = new ArrayList();

    for (int i = 0; i < argv.length; i++) { 

      if ("-r".equalsIgnoreCase(argv[i]))
        this.opts.put("-r", null);             // Random DOI
      else if ("-x".equalsIgnoreCase(argv[i]))
        this.opts.put("-x", null);             // Print XML
      else if ("-d".equalsIgnoreCase(argv[i]))
        this.opts.put("-d", null);             // Dump
      else if ("-t".equalsIgnoreCase(argv[i]))
        this.opts.put("-t", null);             // Types
      else if ("-v".equals(argv[i]))
        this.opts.put("-v", null);             // Values
      else if ("-k".equalsIgnoreCase(argv[i]))
        this.opts.put("-k", null);             // Kernel Metadata
      else if ("-m".equalsIgnoreCase(argv[i]))
        this.opts.put("-m", null);             // Profile Metadata
      else if ("-u".equalsIgnoreCase(argv[i]))
        this.opts.put("-u", argv[i+1]);        // Authorized Username
      else if ("-p".equalsIgnoreCase(argv[i]))
        this.opts.put("-p", argv[i+1]);        // Authorized Password
      else if ("-h".equalsIgnoreCase(argv[i]))
        this.opts.put("-h", null);             // Help
      else if ("-V".equals(argv[i]))
        this.opts.put("-V", null);             // Version
      else if (argv[i].startsWith("doi:"))
        this.args.add(argv[i]);                // DOI argument
      else if (argv[i].startsWith("10"))
        this.args.add(argv[i]);                // DOI argument
      
    }
    
  }


  static void _version () {
  
    out.println("This is yadt (Yet Another DOI Tool, Java version " + YADT_VERSION + ")");
    out.println();
    out.println("Copyright 2001, Academic Press, Harcourt, Inc.");
    out.println();
    out.println("This program is free software you can redistribute it and/or");
    out.println("modify it under the same terms as Java itself.");
  
    System.exit(1);

  }
  
  
  static void _usage () {
  
    out.println("Usage: java yadt [options] <doi> ...");
    out.println();
    out.println("  -r          : get random DOI");
    out.println("  -x          : print DataObject as XML");
    out.println();
    out.println("  -d          : print dump of the DataGroups");
    out.println("  -t          : print the DataObject data types");
    out.println("  -v          : print the DataObject values");
    out.println();
    out.println("  -k          : print DOI Kernel Metadata");
    out.println("  -m          : print DOI Application Profile Metadata");
    out.println("  -u username : authorized username");
    out.println("  -p password : authorized password");
    out.println();
    out.println("  -h          : print this help message");
    out.println("  -V          : print the version number of yadt");
  
    System.exit(1);

  }
  
  public static void main (String[] argv) {

    String doi;
    String key, val;

    yadt y = new yadt(argv);
  
    if (y.opts.containsKey("-h"))
      yadt._usage();
    else if (y.opts.containsKey("-V"))
      yadt._version();
    
    if (y.opts.containsKey("-r"))
      y.args.add("?");

    for (Iterator i_ = y.args.iterator(); i_.hasNext(); ) {

      doi = (String)i_.next();
    
      if (doi.startsWith("doi:"))
        doi = doi.substring(4);        // Remove possible URI scheme
    
      DataObject d = new DataObject(doi);
      d.readDataStore();
  
      if (y.opts.containsKey("-u"))
        d.setUsername((String)y.opts.get("-u"));

      if (y.opts.containsKey("-p"))
        d.setPassword((String)y.opts.get("-p"));
  
      for (Iterator j_ = y.opts.entrySet().iterator(); j_.hasNext(); ) {

        Map.Entry e = (Map.Entry)j_.next();
        key = e.getKey().toString();

        if (key.equals("-x"))
          out.print(d);

        else if (key.equals("-d"))
          d.dumpDataGroups();

        else if (key.equals("-t"))
          for (Iterator k_ = d.getDataTypes().iterator(); k_.hasNext(); ) {
            out.println(k_.next());
          }

        else if (key.equals("-v"))
          for (Iterator k_ = d.getDataValues().iterator(); k_.hasNext(); ) {
            out.println(k_.next());
          }
    
        else if (key.equals("-k"))
          out.print(d.getKernelMetadata());

        else if (key.equals("-m"))
          out.print(d.getProfileMetadata());
    
      }
    
    }

  }

} 
