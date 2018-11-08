/*
  ########################################################################
  #
  # yads.doi.lib.Group - A Java class for manipulating DObject Groups
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
 * Class for aggregating data elements into groups.
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
  public class Group {

    List members;

    public Group() {
  
      this.members = new ArrayList();
      
    }

    public Group addContainer(Group container) {

      this.members.add(new Object[] { "contains", container });
      return this;
      
    }

    public Group addMember(String type, String data) {

      // For now, add legitimate types and silently discard
      // non-legitimate types
      if (DObjectTypes.isDObjectType(type)) {
        this.members.add(new Object[] { type, data });
      }
      return this;
      
    }

    public List getMembers() {

      return this.members;

    }

    // 

    public void clear() {

      this.members.clear();

    }

  }
