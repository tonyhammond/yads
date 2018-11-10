/*
  ########################################################################
  #
  # sdi.doi.lib.Metadata - A Java class for manipulating DObject Metadata
  #
  # Author - Tony Hammond <tony_hammond@harcourt.com>
  # 
  ########################################################################
*/

package sdi.doi.lib;

import java.io.*;
import java.util.*;

  // Class for aggregating data into data groups

  public class Metadata {

    // 
    private String _metadata(String profile, String auth, boolean action) {
  
      String doiProfile;
      String host;
      String path;
  
      Perl5Util re = new Perl5Util();
      MatchResult match;
  
      if (profile != null) {
        doiProfile = re.substitute("s/^doi://", profile);
      }
      else {
        doiProfile = Common.DOI_PROFILE_ZERO;
      }
      DObject d = new DObject(doiProfile);
      d.readDataStore();
  
      List l = d.getServices();
  
      // If no service associated with this profile then return null
      if (l == null) {
        return null;
      }
  
      re.match("/^http:\\/\\/(.*?)(\\/.*?)$/", (String)l.get(0));
      match = re.getMatch();
      host = match.group(1);
  
      path = match.group(2) + "?id=" + doi + "&pid=" + auth + "&sid=null:null";
  
      if (action) {
        return _getMetaData(host, path);
      }
      else {
        return "http://" + host + path;
      }
  
    }
  
    public String getUsername() {
    
      return this.authUsername;
  
    }
  
    public void setUsername(String user) {
    
      this.authUsername = user;
  
    }
  
    public String getPassword() {
    
      return this.authPassword;
  
    }
  
    public void setPassword(String pass) {
    
      this.authPassword = pass;
  
    }
  
    /**
     * Return kernel metadata in XML format for the current DObject instance.
     *
     * @return          kernel metadata in XML
     */
    public String getKernelMetadata() {
    
      String profile = (String)this.getProfiles().get(0);
      String auth = "guest:guest";
  
      return _metadata(profile, auth, true);
  
    }
  
    public String getKernelMetadata(String profile) {
    
      String auth = "guest:guest";
  
      return _metadata(profile, auth, true);
  
    }
  
    /**
     * Return the kernel metadata service for the current DObject instance.
     *
     * @return          service for kernel metadata
     */
    public String getKernelMetadataService() {
    
      String profile = (String)this.getProfiles().get(0);
  
      return _metadata(profile, null, false);
  
    }
  
    public String getKernelMetadataService(String profile) {
    
      return _metadata(profile, null, false);
  
    }
  
    /**
     * Return application profile metadata in XML format for the current DObject instance.
     *
     * @return          application profile metadata in XML
     */
    public String getProfileMetadata() {
    
      String profile = (String)this.getProfiles().get(0);
      String auth = this.authUsername + ":" + this.authPassword;
  
      return _metadata(profile, auth, true);
  
    }
  
    public String getProfileMetadata(String profile) {
    
      String auth = this.authUsername + ":" + this.authPassword;
  
      return _metadata(profile, auth, true);
  
    }
  
    /**
     * Return application profile metadata service for the current DObject instance.
     *
     * @return          service for application profile metadata
     */
    public String getProfileMetadataService() {
    
      String profile = (String)this.getProfiles().get(0);
  
      return _metadata(null, null, false);
  
    }
  
    public String getProfileMetadataService(String profile) {
    
      return _metadata(profile, null, false);
  
    }
  
 } 
