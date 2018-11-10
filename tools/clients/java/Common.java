/*
  ########################################################################
  #
  # yads.doi.lib.Common - A Java class for listing library constants
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  ########################################################################
*/

package yads.doi.lib;

/**
 * Class for common library constants.
 *
 * @author	Tony Hammond
 * @version	0.1.5
 */
public abstract class Common {

  public static final String DOI_PROFILE_ZERO = "1014/10.system/profile.zero";
  public static final String DOI_PROFILE_BASE = "1014/10.system/profile.base";
  public static final String DOI_PROFILE_XREF = "1014/10.system/profile.crossref";

  public static final String DOI_PROFILE_DEFAULT = DOI_PROFILE_ZERO;

  // public static final String DOI_SERVICE_HOST = "www2.harcourt-international.com";

  public static final String DOI_SERVICE_HOST = "193.122.198.4";
  public static final String DOI_SERVICE_PATH   = "/ap/servlet/YADS";

  public static final String RDF_SYNTAX_SCHEMA = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
  public static final String DOI_OBJECT_SCHEMA = "doi:1014/10.system/schema.2001-07-26#";

  public static final String DATA_STORE_CALL_CREATE = "createDataStore";
  public static final String DATA_STORE_CALL_DELETE = "deleteDataStore";
  public static final String DATA_STORE_CALL_READ   = "readDataStore";
  public static final String DATA_STORE_CALL_WRITE  = "writeDataStore";

}
