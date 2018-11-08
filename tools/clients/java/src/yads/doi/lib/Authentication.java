/*
  ########################################################################
  #
  # yads.doi.lib.Authenticate - A Java class for authentication objects
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
 * Class for manipulating authentication objects.
 *
 * @author	Tony Hammond
 * @version	0.1.5
 */
public class Authentication {

  String username;
  String password;

  /**
   * Constructor for an authentication object.
   *
   * @param username	Username as string
   * @param password	Password as string
   */
  public Authentication(String username, String password) {
  
    this.username = username;
    this.password = password;
      
  }

  /**
   * Accessor method for the authentication object username string.
   *
   * @return username	Username as string
   */
  public String getUsername() {
  
    return username;
      
  }

  /**
    * Accessor method for the authentication object password string.
   *
   * @return password	Password as string
   */
  public String getPassword() {
  
    return password;
      
  }

}
