/***********************************************************************
 *
 * doi.DataObject - A Java class for manipulating DOI DataObjects
 *
 * Author - Tony Hammond <tony_hammond@harcourt.com>
 *
 * Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
 * Company
 * 
 ***********************************************************************/

package doi;

import java.io.*;
import java.util.*;

/***********************************************************************
 * This class 
 * 
 ***********************************************************************/

  // Class for aggregating data into data groups

  public class DataGroup extends ArrayList {

    ArrayList dataGroup;

    public DataGroup() {
  
      this.dataGroup = new ArrayList();
      
    }

    public DataGroup addDataGroup(ArrayList dataGroup) {

      dataGroup.add(new String[] { "dataGroup", dataGroup.toString() });
      return this;
      
    }

    public DataGroup addData(String type, String data) {

      this.add(new String[] { type, data });
      return this;
      
    }

    public DataGroup getData() {

      return this;

    }

    // Alias for getData()

    public DataGroup readData() {

      return this;

    }

    public void clearData() {

      dataGroup.clear();

    }

    // Alias for clearData()

    public void clear() {

      dataGroup.clear();

    }

  }

