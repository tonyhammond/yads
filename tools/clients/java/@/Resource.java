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
 * Convenience class for aggregating data elements into groups.
 *
 * @author	Tony Hammond
 * @version	0.1.4
 */
  public class Resource extends Group {

    List members;

    public Resource(String data) {
  
      this.members = new ArrayList();
      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_RESOURCE, data });
      
    }

/*
    public Resource addContainer(Group container) {

      this.members.add(new Object[] { "contains", container });
      return this;
      
    }
*/
    /**
     * Convenience method to add a DOI_TYPE_ACCESS member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_ACCESS type
     * @return	Resource
     */
    public Resource addAccess(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_ACCESS, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_DETAIL member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_DETAIL type
     * @return	Resource
     */
    public Resource addDetail(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_DETAIL, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_LABEL member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_LABEL type
     * @return	Resource
     */
    public Resource addLabel(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_LABEL, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_RESOLVE member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_RESOLVE type
     * @return	Resource
     */
    public Resource addResolve(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_RESOLVE, data });
      return this;
      
    }

    // public Resource addResource(String data) {
    //
    // this.members.add(new Object[]
    //                   { DObjectTypes.DOI_TYPE_RESOURCE, data });
    // return this;
    // 
    // }

    /**
     * Convenience method to add a DOI_TYPE_ROLE member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_ROLE type
     * @return	Resource
     */
    public Resource addRole(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_ROLE, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_TYPE member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_TYPE type
     * @return	Resource
     */
    public Resource addType(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_TYPE, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_AGENT member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_AGENT type
     * @return	Resource
     */
    public Resource addAgent(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_AGENT, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_NULL member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_NULL type
     * @return	Resource
     */
    public Resource addNull(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_NULL, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_PROFILE member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_PROFILE type
     * @return	Resource
     */
    public Resource addProfile(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_PROFILE, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_SCHEMA member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_SCHEMA type
     * @return	Resource
     */
    public Resource addSchema(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_SCHEMA, data });
      return this;
      
    }

    /**
     * Convenience method to add a DOI_TYPE_SERVICE member (see {@link DObjectTypes}).
     *
     * @param	String value for a DOI_TYPE_SERVICE type
     * @return	Resource
     */
    public Resource addService(String data) {

      this.members.add(new Object[]
                       { DObjectTypes.DOI_TYPE_SERVICE, data });
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
