/*
  ########################################################################
  #
  # yads.doi.lib.Container - A Java class for manipulating DObject Containers
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  # Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
  # Company 
  #
  ########################################################################
*/

package yads.doi.lib;

import java.io.*;
import java.util.*;

/**
 * Class for aggregating groups into containers.
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
public class Container extends Group {

  /**
   * Constructor for an unordered container.
   */
  public Container() {
  
    this.members = new ArrayList();
    this.members.add(new Object[] { "order", DObjectMap.GROUP_UNORDERED });

  }

  /**
   * Constructor for an ordered container.
   *
   * @param order  container ordering, one of DObjectMap.GROUP_ALTERNATE,
   * DObjectMap.GROUP_SEQUENCED, DObjectMap.GROUP_UNORDERED
   *
   * @see            DObjectMap
   */
  public Container(String order) {
  
    this.members = new ArrayList();
    this.members.add(new Object[] { "order", order });
      
  }

  /**
   * Attach a group to a container.
   */
  public Container addGroup(Group group) {

    this.members.add(new Object[] { "group", group });
    return this;
      
  }

  /**
   * Attach a resource (ie group) to a container.
   */
  public Container addResource(Resource resource) {

    this.members.add(new Object[] { "group", resource });
    return this;
      
  }

}
