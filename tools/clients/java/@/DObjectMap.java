/*
  ########################################################################
  #
  # yads.doi.lib.Map - A Java class for listing map constants
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package yads.doi.lib;

/**
 * Class listing DObject map constants.
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
public abstract class DObjectMap {

  public static final String GROUP_OPEN = "(";
  public static final String GROUP_CLOSE = ")";

  public static final String GROUP_ALTERNATE = "alt";
  public static final String GROUP_ALTERNATE_OPEN = "<";
  public static final String GROUP_ALTERNATE_CLOSE = ">";

  public static final String GROUP_SEQUENCED = "seq";
  public static final String GROUP_SEQUENCED_OPEN = "[";
  public static final String GROUP_SEQUENCED_CLOSE = "]";

  public static final String GROUP_UNORDERED = "bag";
  public static final String GROUP_UNORDERED_OPEN = "{";
  public static final String GROUP_UNORDERED_CLOSE = "}";

}
