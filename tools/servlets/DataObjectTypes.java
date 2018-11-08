import java.util.*;

public class DataObjectTypes {

  public static final String DOI_TYPE_MAP      = "map";

  public static final String DOI_TYPE_ACCESS   = "access";
  public static final String DOI_TYPE_ALIAS    = "alias";
  public static final String DOI_TYPE_AGENT    = "agent";
  public static final String DOI_TYPE_DETAIL   = "detail";
  public static final String DOI_TYPE_LABEL    = "label";
  public static final String DOI_TYPE_LITERAL  = "literal";
  public static final String DOI_TYPE_NULL     = "null";
  public static final String DOI_TYPE_PROFILE  = "profile";
  public static final String DOI_TYPE_ROLE     = "role";
  public static final String DOI_TYPE_RELATION = "relation";
  public static final String DOI_TYPE_RESOURCE = "resource";
  public static final String DOI_TYPE_SCHEMA   = "schema";
  public static final String DOI_TYPE_SERVICE  = "service";
  public static final String DOI_TYPE_TYPE     = "type";


  public static final String HDL_DOI_SYSTEM_PREFIX = "1014/10.1000/system";

  public static final String HDL_TYPE_URL          = "URL";

  public static final String HDL_DOI_PREFIX        = "X-DOI_";
  public static final String HDL_DOI_TYPE_MAP      = "X-DOI_MAP";

  public static final String HDL_DOI_TYPE_ACCESS   = "X-DOI_ACCESS";
  public static final String HDL_DOI_TYPE_AGENT    = "X-DOI_AGENT";
  public static final String HDL_DOI_TYPE_ALIAS    = "X-DOI_ALIAS";
  public static final String HDL_DOI_TYPE_DETAIL   = "X-DOI_DETAIL";
  public static final String HDL_DOI_TYPE_LABEL    = "X-DOI_LABEL";
  public static final String HDL_DOI_TYPE_LITERAL  = "X-DOI_LITERAL";
  public static final String HDL_DOI_TYPE_NULL     = "X-DOI_NULL";
  public static final String HDL_DOI_TYPE_PROFILE  = "X-DOI_PROFILE";
  public static final String HDL_DOI_TYPE_RELATION = "X-DOI_RELATION";
  public static final String HDL_DOI_TYPE_RESOURCE = "X-DOI_RESOURCE";
  public static final String HDL_DOI_TYPE_ROLE     = "X-DOI_ROLE";
  public static final String HDL_DOI_TYPE_SCHEMA   = "X-DOI_SCHEMA";
  public static final String HDL_DOI_TYPE_SERVICE  = "X-DOI_SERVICE";
  public static final String HDL_DOI_TYPE_TYPE     = "X-DOI_TYPE";

/*
  public static final String HDL_DOI_PREFIX        = "DOI_";
  public static final String HDL_DOI_TYPE_MAP      = "DOI_MAP";

  public static final String HDL_DOI_TYPE_ACCESS   = "DOI_ACCESS";
  public static final String HDL_DOI_TYPE_AGENT    = "DOI_AGENT";
  public static final String HDL_DOI_TYPE_ALIAS    = "DOI_ALIAS";
  public static final String HDL_DOI_TYPE_DETAIL   = "DOI_DETAIL";
  public static final String HDL_DOI_TYPE_LABEL    = "DOI_LABEL";
  public static final String HDL_DOI_TYPE_LITERAL  = "DOI_LITERAL";
  public static final String HDL_DOI_TYPE_NULL     = "DOI_NULL";
  public static final String HDL_DOI_TYPE_PROFILE  = "DOI_PROFILE";
  public static final String HDL_DOI_TYPE_RELATION = "DOI_RELATION";
  public static final String HDL_DOI_TYPE_RESOURCE = "DOI_RESOURCE";
  public static final String HDL_DOI_TYPE_ROLE     = "DOI_ROLE";
  public static final String HDL_DOI_TYPE_SCHEMA   = "DOI_SCHEMA";
  public static final String HDL_DOI_TYPE_SERVICE  = "DOI_SERVICE";
  public static final String HDL_DOI_TYPE_TYPE     = "DOI_TYPE";


  // Also need to support the legacy experimental types (X-)

  public static final String X_HDL_DOI_PREFIX        = "X-DOI_";
  public static final String X_HDL_DOI_TYPE_MAP      = "X-DOI_MAP";

  public static final String X_HDL_DOI_TYPE_ACCESS   = "X-DOI_ACCESS";
  public static final String X_HDL_DOI_TYPE_AGENT    = "X-DOI_AGENT";
  public static final String X_HDL_DOI_TYPE_ALIAS    = "X-DOI_ALIAS";
  public static final String X_HDL_DOI_TYPE_DETAIL   = "X-DOI_DETAIL";
  public static final String X_HDL_DOI_TYPE_LABEL    = "X-DOI_LABEL";
  public static final String X_HDL_DOI_TYPE_LITERAL  = "X-DOI_LITERAL";
  public static final String X_HDL_DOI_TYPE_NULL     = "X-DOI_NULL";
  public static final String X_HDL_DOI_TYPE_PROFILE  = "X-DOI_PROFILE";
  public static final String X_HDL_DOI_TYPE_RELATION = "X-DOI_RELATION";
  public static final String X_HDL_DOI_TYPE_RESOURCE = "X-DOI_RESOURCE";
  public static final String X_HDL_DOI_TYPE_ROLE     = "X-DOI_ROLE";
  public static final String X_HDL_DOI_TYPE_SCHEMA   = "X-DOI_SCHEMA";
  public static final String X_HDL_DOI_TYPE_SERVICE  = "X-DOI_SERVICE";
  public static final String X_HDL_DOI_TYPE_TYPE     = "X-DOI_TYPE";
*/

  public static final String RDF_TYPE_LITERAL      = "literal";
  public static final String RDF_TYPE_RESOURCE     = "resource";


  static private Hashtable dataObjectType = new Hashtable();
  static private Hashtable handleServType = new Hashtable();
  static private Hashtable RDFType        = new Hashtable();

  static {

    dataObjectType.put(HDL_DOI_TYPE_MAP,      DOI_TYPE_MAP);

    dataObjectType.put(HDL_DOI_TYPE_ACCESS,   DOI_TYPE_ACCESS);
    dataObjectType.put(HDL_DOI_TYPE_AGENT,    DOI_TYPE_AGENT);
    dataObjectType.put(HDL_DOI_TYPE_ALIAS,    DOI_TYPE_ALIAS);
    dataObjectType.put(HDL_DOI_TYPE_DETAIL,   DOI_TYPE_DETAIL);
    dataObjectType.put(HDL_DOI_TYPE_LABEL,    DOI_TYPE_LABEL);
    dataObjectType.put(HDL_DOI_TYPE_LITERAL,  DOI_TYPE_LITERAL);
    dataObjectType.put(HDL_DOI_TYPE_NULL,     DOI_TYPE_NULL);
    dataObjectType.put(HDL_DOI_TYPE_PROFILE,  DOI_TYPE_PROFILE);
    dataObjectType.put(HDL_DOI_TYPE_RELATION, DOI_TYPE_RELATION);
    dataObjectType.put(HDL_DOI_TYPE_RESOURCE, DOI_TYPE_RESOURCE);
    dataObjectType.put(HDL_DOI_TYPE_ROLE,     DOI_TYPE_ROLE);
    dataObjectType.put(HDL_DOI_TYPE_SCHEMA,   DOI_TYPE_SCHEMA);
    dataObjectType.put(HDL_DOI_TYPE_SERVICE,  DOI_TYPE_SERVICE);
    dataObjectType.put(HDL_DOI_TYPE_TYPE,     DOI_TYPE_TYPE);

/*
    dataObjectType.put(X_HDL_DOI_TYPE_MAP,      DOI_TYPE_MAP);

    dataObjectType.put(X_HDL_DOI_TYPE_ACCESS,   DOI_TYPE_ACCESS);
    dataObjectType.put(X_HDL_DOI_TYPE_AGENT,    DOI_TYPE_AGENT);
    dataObjectType.put(X_HDL_DOI_TYPE_ALIAS,    DOI_TYPE_ALIAS);
    dataObjectType.put(X_HDL_DOI_TYPE_DETAIL,   DOI_TYPE_DETAIL);
    dataObjectType.put(X_HDL_DOI_TYPE_LABEL,    DOI_TYPE_LABEL);
    dataObjectType.put(X_HDL_DOI_TYPE_LITERAL,  DOI_TYPE_LITERAL);
    dataObjectType.put(X_HDL_DOI_TYPE_NULL,     DOI_TYPE_NULL);
    dataObjectType.put(X_HDL_DOI_TYPE_PROFILE,  DOI_TYPE_PROFILE);
    dataObjectType.put(X_HDL_DOI_TYPE_RELATION, DOI_TYPE_RELATION);
    dataObjectType.put(X_HDL_DOI_TYPE_RESOURCE, DOI_TYPE_RESOURCE);
    dataObjectType.put(X_HDL_DOI_TYPE_ROLE,     DOI_TYPE_ROLE);
    dataObjectType.put(X_HDL_DOI_TYPE_SCHEMA,   DOI_TYPE_SCHEMA);
    dataObjectType.put(X_HDL_DOI_TYPE_SERVICE,  DOI_TYPE_SERVICE);
    dataObjectType.put(X_HDL_DOI_TYPE_TYPE,     DOI_TYPE_TYPE);
*/

    handleServType.put(DOI_TYPE_MAP,      HDL_DOI_TYPE_MAP);

    handleServType.put(DOI_TYPE_ACCESS,   HDL_DOI_TYPE_ACCESS);
    handleServType.put(DOI_TYPE_AGENT,    HDL_DOI_TYPE_AGENT);
    handleServType.put(DOI_TYPE_ALIAS,    HDL_DOI_TYPE_ALIAS);
    handleServType.put(DOI_TYPE_DETAIL,   HDL_DOI_TYPE_DETAIL);
    handleServType.put(DOI_TYPE_LABEL,    HDL_DOI_TYPE_LABEL);
    handleServType.put(DOI_TYPE_LITERAL,  HDL_DOI_TYPE_LITERAL);
    handleServType.put(DOI_TYPE_NULL,     HDL_DOI_TYPE_NULL);
    handleServType.put(DOI_TYPE_PROFILE,  HDL_DOI_TYPE_PROFILE);
    handleServType.put(DOI_TYPE_RELATION, HDL_DOI_TYPE_RELATION);
    handleServType.put(DOI_TYPE_RESOURCE, HDL_DOI_TYPE_RESOURCE);
    handleServType.put(DOI_TYPE_ROLE,     HDL_DOI_TYPE_ROLE);
    handleServType.put(DOI_TYPE_SCHEMA,   HDL_DOI_TYPE_SCHEMA);
    handleServType.put(DOI_TYPE_SERVICE,  HDL_DOI_TYPE_SERVICE);
    handleServType.put(DOI_TYPE_TYPE,     HDL_DOI_TYPE_TYPE);

    RDFType.put(DOI_TYPE_ACCESS,   RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_AGENT,    RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_ALIAS,    RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_DETAIL,   RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_LABEL,    RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_LITERAL,  RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_NULL,     RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_PROFILE,  RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_RELATION, RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_RESOURCE, RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_ROLE,     RDF_TYPE_LITERAL);
    RDFType.put(DOI_TYPE_SCHEMA,   RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_SERVICE,  RDF_TYPE_RESOURCE);
    RDFType.put(DOI_TYPE_TYPE,     RDF_TYPE_LITERAL);

  }

  public static String getDataObjectType (String s) {

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
