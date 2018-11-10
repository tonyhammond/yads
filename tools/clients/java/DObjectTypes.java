/*
  ########################################################################
  #
  # yads.doi.lib.DObjectTypes - A Java class for DObject Types
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  ########################################################################
*/

package yads.doi.lib;

import java.util.*;

/**
 * Allowed DObject types and corresponding Handle types.
 *
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class DObjectTypes {

  public static final String DOI_TYPE_MAP      = "map";

  // General properties - DOI
  /** DObject type "access" - a Literal marking an access point into the resource hierarchy. */
  public static final String DOI_TYPE_ACCESS   = "access";
  /** DObject type "detail" - a Literal describing a resource. */
  public static final String DOI_TYPE_DETAIL   = "detail";
  /** DObject type "label" - a Literal conferring a presentational label for a resource for use in display contexts. */
  public static final String DOI_TYPE_LABEL    = "label";
  /** DObject type "resolve" - a Literal conferring a link resolution behaviour. */
  public static final String DOI_TYPE_RESOLVE  = "resolve";
  /** DObject type "resource" -  a Resource conferring a general web resource. */
  public static final String DOI_TYPE_RESOURCE = "resource";
  /** DObject type "role" - a Literal describing the relationship of another DObject. */
  public static final String DOI_TYPE_ROLE     = "role";
  /** DObject type "type" - a Literal typing a resource which can be resolved by consulting a DOI Application Schema. */
  public static final String DOI_TYPE_TYPE     = "type";

  // System properties - DOI
  /** DObject type "agent" - a DObject for a DOI registered Registration Agent. */
  public static final String DOI_TYPE_AGENT    = "agent";
  /** DObject type "null" - a DObject denoting the absence of value. */
  public static final String DOI_TYPE_NULL     = "null";
  /** DObject type "profile" - a DObject for a registered DOI Application Profile. */
  public static final String DOI_TYPE_PROFILE  = "profile";
  /** DObject type "schema" - a DObject for a registered DOI Application Schema. */
  public static final String DOI_TYPE_SCHEMA   = "schema";
  /** DObject type "service" - a DObject for a registered DOI Application Service. */
  public static final String DOI_TYPE_SERVICE  = "service";

  public static final String HDL_DOI_SYSTEM_PREFIX = "1014/10.system";

  public static final String HDL_DOI_PREFIX        = "X-DOI_";
  public static final String HDL_DOI_TYPE_MAP      = "X-DOI_MAP";

  // General properties - Handle
  public static final String HDL_DOI_TYPE_ACCESS   = "X-DOI_ACCESS";
  public static final String HDL_DOI_TYPE_DETAIL   = "X-DOI_DETAIL";
  public static final String HDL_DOI_TYPE_LABEL    = "X-DOI_LABEL";
  public static final String HDL_DOI_TYPE_RESOLVE  = "X-DOI_RESOLVE";
  public static final String HDL_DOI_TYPE_RESOURCE = "X-DOI_RESOURCE";
  public static final String HDL_DOI_TYPE_ROLE     = "X-DOI_ROLE";
  public static final String HDL_DOI_TYPE_TYPE     = "X-DOI_TYPE";

  // System properties - Handle
  public static final String HDL_DOI_TYPE_AGENT    = "X-DOI_AGENT";
  public static final String HDL_DOI_TYPE_NULL     = "X-DOI_NULL";
  public static final String HDL_DOI_TYPE_PROFILE  = "X-DOI_PROFILE";
  public static final String HDL_DOI_TYPE_SCHEMA   = "X-DOI_SCHEMA";
  public static final String HDL_DOI_TYPE_SERVICE  = "X-DOI_SERVICE";

  // Legacy property - Handle
  public static final String HDL_TYPE_URL          = "URL";

  // RDF property type
  public static final String RDF_TYPE_LITERAL      = "literal";
  public static final String RDF_TYPE_RESOURCE     = "resource";

  // Type (aka property) hashes
  static private Hashtable dataObjectType = new Hashtable();
  static private Hashtable handleServType = new Hashtable();
  static private Hashtable RDFType        = new Hashtable();

  // Initialization block for type hashes
  static {

    dataObjectType.put(HDL_DOI_TYPE_MAP,      DOI_TYPE_MAP);

    dataObjectType.put(HDL_DOI_TYPE_ACCESS,   DOI_TYPE_ACCESS);
    dataObjectType.put(HDL_DOI_TYPE_DETAIL,   DOI_TYPE_DETAIL);
    dataObjectType.put(HDL_DOI_TYPE_LABEL,    DOI_TYPE_LABEL);
    dataObjectType.put(HDL_DOI_TYPE_RESOLVE,  DOI_TYPE_RESOLVE);
    dataObjectType.put(HDL_DOI_TYPE_RESOURCE, DOI_TYPE_RESOURCE);
    dataObjectType.put(HDL_DOI_TYPE_ROLE,     DOI_TYPE_ROLE);
    dataObjectType.put(HDL_DOI_TYPE_TYPE,     DOI_TYPE_TYPE);

    dataObjectType.put(HDL_DOI_TYPE_AGENT,    DOI_TYPE_AGENT);
    dataObjectType.put(HDL_DOI_TYPE_NULL,     DOI_TYPE_NULL);
    dataObjectType.put(HDL_DOI_TYPE_PROFILE,  DOI_TYPE_PROFILE);
    dataObjectType.put(HDL_DOI_TYPE_SCHEMA,   DOI_TYPE_SCHEMA);
    dataObjectType.put(HDL_DOI_TYPE_SERVICE,  DOI_TYPE_SERVICE);


    handleServType.put(DOI_TYPE_MAP,      HDL_DOI_TYPE_MAP);

    handleServType.put(DOI_TYPE_ACCESS,   HDL_DOI_TYPE_ACCESS);
    handleServType.put(DOI_TYPE_DETAIL,   HDL_DOI_TYPE_DETAIL);
    handleServType.put(DOI_TYPE_LABEL,    HDL_DOI_TYPE_LABEL);
    handleServType.put(DOI_TYPE_RESOLVE,  HDL_DOI_TYPE_RESOLVE);
    handleServType.put(DOI_TYPE_RESOURCE, HDL_DOI_TYPE_RESOURCE);
    handleServType.put(DOI_TYPE_ROLE,     HDL_DOI_TYPE_ROLE);
    handleServType.put(DOI_TYPE_TYPE,     HDL_DOI_TYPE_TYPE);

    handleServType.put(DOI_TYPE_AGENT,    HDL_DOI_TYPE_AGENT);
    handleServType.put(DOI_TYPE_NULL,     HDL_DOI_TYPE_NULL);
    handleServType.put(DOI_TYPE_PROFILE,  HDL_DOI_TYPE_PROFILE);
    handleServType.put(DOI_TYPE_SCHEMA,   HDL_DOI_TYPE_SCHEMA);
    handleServType.put(DOI_TYPE_SERVICE,  HDL_DOI_TYPE_SERVICE);

    RDFType.put(DOI_TYPE_ACCESS,   RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_DETAIL,   RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_LABEL,    RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_RESOLVE,  RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_RESOURCE, RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_ROLE,     RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_TYPE,     RDF_TYPE_LITERAL);

    RDFType.put(DOI_TYPE_AGENT,    RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_NULL,     RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_PROFILE,  RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_SCHEMA,   RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_SERVICE,  RDF_TYPE_RESOURCE);

  }

  public static boolean isDObjectType (String s) {

    return handleServType.containsKey(s);

  }

  public static boolean isHandleType (String s) {

    return dataObjectType.containsKey(s);

  }

  public static String getDObjectType (String s) {

    return (String)dataObjectType.get(s);

  }

  public static String getHandleType (String s) {

    return (String)handleServType.get(s);

  }

  public static boolean isRDFLiteral (String s) {

    if (RDFType.containsKey(s)) {
      return ((String)RDFType.get(s) == RDF_TYPE_LITERAL);
    }
    else {
      return false;
    }

  }

  public static boolean isRDFResource (String s) {

    if (RDFType.containsKey(s)) {
      return ((String)RDFType.get(s) == RDF_TYPE_RESOURCE);
    }
    else {
      return false;
    }

  }

}
