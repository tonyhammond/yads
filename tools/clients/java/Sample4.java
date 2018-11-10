/*
  ########################################################################
  #
  # yads.doi.sample.Sample4 - A Java test class for reading DOI DObjects
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  ########################################################################
*/

package yads.doi.sample;

import yads.doi.lib.*;
import java.io.*;
import java.util.*;

/**
 * The Sample4 class provides a {@link #main} method which gives
 * a demo of instantiating a new DObject 
 * from an RDF description stored in an external file.
 * <p>
 * Usage:
 * <p>
 * &nbsp;&nbsp;&nbsp;&nbsp;<code>java -classpath DObject.jar yads.doi.sample.Sample4 <file.rdf></code>
 * <p>
 * Here's the sample code:
<pre>
  private BufferedReader dObjectReader = null;
  private long lineNum = 0;

  public Sample4 (String inFile)
  &nbsp;&nbsp;throws Throwable
  {
  &nbsp;&nbsp;this(new File(inFile));
  }

  public Sample4 (File inFile)
  &nbsp;&nbsp;throws Throwable 
  { 
  &nbsp;&nbsp;if (inFile == null || !inFile.exists()
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|| !inFile.canRead() || !inFile.isFile()) {
  &nbsp;&nbsp;&nbsp;&nbsp;throw new Exception("! Bad File: " + inFile.getAbsolutePath() + "\n");
  &nbsp;&nbsp;}
  &nbsp;&nbsp;else
  &nbsp;&nbsp;&nbsp;&nbsp;dObjectReader = new BufferedReader(new InputStreamReader(
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;new FileInputStream(inFile)));
  }

  public void processRDF()
  &nbsp;&nbsp;throws Throwable
  {
  &nbsp;&nbsp;String line;
  &nbsp;&nbsp;StringBuffer dObjectBuffer = new StringBuffer();
  &nbsp;&nbsp;DObject d = new DObject();
 
  &nbsp;&nbsp;while ((line = readLine()) != null) {
  &nbsp;&nbsp;&nbsp;&nbsp;dObjectBuffer.append(line + "\n");
  &nbsp;&nbsp;}
  &nbsp;&nbsp;d.fromXML(dObjectBuffer.toString());
  &nbsp;&nbsp;dObjectReader.close();
  &nbsp;&nbsp;d.dump();

  }

  String readLine() {
  &nbsp;&nbsp;try {
  &nbsp;&nbsp;&nbsp;&nbsp;String line = dObjectReader.readLine();
  &nbsp;&nbsp;&nbsp;&nbsp;if (line ==null) return null;
  &nbsp;&nbsp;&nbsp;&nbsp;lineNum++;
  &nbsp;&nbsp;&nbsp;&nbsp;return line.trim();
  &nbsp;&nbsp;} catch (Exception e) {
  &nbsp;&nbsp;&nbsp;&nbsp;System.err.println("! Error at line " + lineNum);
  &nbsp;&nbsp;&nbsp;&nbsp;return null;
  &nbsp;&nbsp;}
  }
		     
  public static void printUsage() {

  &nbsp;&nbsp;System.err.println("Usage: java yads.doi.sample.Sample4 <file.rdf>");

  } 
    
  public static void main(String args[])
  &nbsp;&nbsp;throws Throwable
  {
  &nbsp;&nbsp;if (args.length != 1)
  &nbsp;&nbsp;&nbsp;&nbsp;printUsage();
  &nbsp;&nbsp;else {
  &nbsp;&nbsp;&nbsp;&nbsp;Sample4 rdf = new Sample4(args[0]);
  &nbsp;&nbsp;&nbsp;&nbsp;rdf.processRDF();
  &nbsp;&nbsp;}
  }
</pre>
 *
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class Sample4 {
        
  private BufferedReader dObjectReader = null;
  private long lineNum = 0;

  public Sample4 (String inFile)
    throws Throwable
  {
    this(new File(inFile));
  }

  public Sample4 (File inFile)
    throws Throwable 
  { 
    if (inFile == null || !inFile.exists()
        || !inFile.canRead() || !inFile.isFile()) {
      throw new Exception("! Bad File: " + inFile.getAbsolutePath() + "\n");
    }
    else
      dObjectReader = new BufferedReader(new InputStreamReader(
                        new FileInputStream(inFile)));
  }

  public void processRDF()
    throws Throwable
  {
    String line;
    StringBuffer dObjectBuffer = new StringBuffer();
    DObject d = new DObject();
 
    while ((line = readLine()) != null) {
      dObjectBuffer.append(line + "\n");
    }
    d.fromXML(dObjectBuffer.toString());
    dObjectReader.close();
    d.dump();

  }

  String readLine() {
    try {
      String line = dObjectReader.readLine();
      if (line ==null) return null;
      lineNum++;
      return line.trim();
    } catch (Exception e) {
      System.err.println("! Error at line " + lineNum);
      return null;
    }
  }
		     
  public static void printUsage() {

    System.err.println("Usage: java yads.doi.sample.Sample4 <file.rdf>");

  } 
    
  public static void main(String args[])
    throws Throwable
  {
    if (args.length != 1)
      printUsage();
    else {
      Sample4 rdf = new Sample4(args[0]);
      rdf.processRDF();
    }
  }

}
