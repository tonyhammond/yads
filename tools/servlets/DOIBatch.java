/**********************************************************************\
  COPYRIGHT© 2000 Corporation for National Research Initiatives (CNRI);
                         All rights reserved.
-----------------------------------------------------------------------
Developer: Sean Reilly <sreilly@cnri.reston.va.us>
$Date: 2000/11/03 17:37:19 $
$Revision: 1.12 $
\***********************************************************************/

package net.handle.apps.batch;

import net.handle.hdllib.*;
import java.io.*;
import java.util.*;

public abstract class DOIBatch {
  private AuthenticationInfo authInfo = null;
  public static final String DOI_ADMIN_NA = "10.admin";
  public static final int SEC_KEY_IDX = 300;
  private static HandleResolver resolver = new HandleResolver();
  private static Writer log;

  static {
    resolver.setTcpTimeout(15000);
  }
  
  public static void printUsage() {
    System.err.println("Usage: java net.handle.apps.batch.DOIBatch"+
                       " CREATE|DELETE|UPDATE|ALIAS|UNALIAS <batchfile> <username> <password> <logfile>");
  }

  public static void main(String argv[])
    throws Exception
  {
    if(argv.length != 5) {
      printUsage();
      System.exit(-1);
      return;
    }
    
    String action = argv[0].toUpperCase().trim();
    String username = argv[2];
    String passwd = argv[3];

    log = new FileWriter(argv[4]);
    
    byte idHandle[] = Util.encodeString(DOI_ADMIN_NA+'/'+username);
    SecretKeyAuthenticationInfo auth =
      new SecretKeyAuthenticationInfo(idHandle, SEC_KEY_IDX, Util.encodeString(passwd));
    
    try {
      if(action.equals("CREATE")) {
        processBatchCreate(auth, new BufferedReader(new FileReader(new File(argv[1]))),
                           new PrintWriter(System.out));
      } else if(action.equals("DELETE")) {
        processBatchDelete(auth, new BufferedReader(new FileReader(new File(argv[1]))),
                           new PrintWriter(System.out));
      } else if(action.equals("ALIAS")) {
        processBatchAlias(auth, new BufferedReader(new FileReader(new File(argv[1]))),
                          new PrintWriter(System.out));
      } else if(action.equals("UNALIAS")) {
        processBatchUnalias(auth, new BufferedReader(new FileReader(new File(argv[1]))),
                            new PrintWriter(System.out));
      } else if(action.equals("UPDATE")) {
        processBatchUpdate(auth, new BufferedReader(new FileReader(new File(argv[1]))),
                           new PrintWriter(System.out));
      } else {
        printUsage();
        System.exit(-1);
      }
    } catch (Exception e) {
      System.err.println("Error processing batch: "+e);
      e.printStackTrace(System.err);
      log.write("Error processing batch: "+e);
      log.close();
      System.exit(-1);
    } finally {
      try { log.close(); } catch (Exception e) {}
    }
  }

  static void processBatchCreate(AuthenticationInfo auth,
                                 BufferedReader in,
                                 PrintWriter out)
    throws Exception
  {
    String line;
    int spaceIdx;
    int lineNum = 0;

    log.write("Operation: create\n");
    HandleValue values[] = new HandleValue[2];
    values[0] = new HandleValue();
    values[0].index = 1;
    values[0].type = Common.STD_TYPE_URL;
    values[0].data = null;

    values[1] = new HandleValue();
    values[1].index = 100;
    values[1].type = Common.STD_TYPE_HSADMIN;
    values[1].data = null;

    log.write("Operation: create\n");
    CreateHandleRequest chReq = new CreateHandleRequest(null, values, auth);

    int successes = 0;
    int records = 0;
    
    while(true) {
      line = in.readLine();
      lineNum++;
      if(line==null)
        break;
      line = line.trim();
      if(line.length()<=0)
        continue;
      spaceIdx = line.indexOf(' ');
      if(spaceIdx<=0) {
        log.write("Invalid line ("+lineNum+"): "+line+"\n");
        continue;
      }
      
      String handle = line.substring(0, spaceIdx);
      String url = line.substring(spaceIdx + 1).trim();
      
      chReq.handle = Util.encodeString(handle);
      chReq.values[0].data = Util.encodeString(url);

      AdminRecord admin =
        new AdminRecord(Util.encodeString("0.na/"+Util.decodeString(Util.getNAPart(chReq.handle))),
                        200, false, true, false, false, true,
                        true, true, true, true, true, true, true);
      chReq.values[1].data = Encoder.encodeAdminRecord(admin);
      
      records++;
      chReq.clearBuffers();
      AbstractResponse response = null;
      try {
        response = resolver.processRequest(chReq);
        if(response.responseCode==AbstractMessage.RC_SUCCESS) {
          successes++;
          log.write("SUCCESS:"+(lineNum-1)+":ADD:"+handle+"\n");
        } else {
          log.write("ERROR: "+response.responseCode+" "+
                    AbstractMessage.getResponseCodeMessage(response.responseCode)+
                    ": line "+(lineNum-1)+" "+line+"\n");
        }
      } catch (HandleException e) {
        log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
      }
      try { log.flush(); } catch (Throwable t) {}
    }

    log.write("SUMMARY:CREATE: "+
              successes+'/'+records+" successes "+
              (records-successes)+'/'+records+" errors\n");
  }

  
  static void processBatchUpdate(AuthenticationInfo auth,
                                 BufferedReader in,
                                 PrintWriter out)
    throws Exception
  {
    String line;
    int spaceIdx;
    int lineNum = 0;

    log.write("Operation: update\n");
    HandleValue values[] = new HandleValue[1];
    values[0] = new HandleValue();
    values[0].index = 1;
    values[0].type = Common.STD_TYPE_URL;
    values[0].data = null;

    ModifyValueRequest mvReq = new ModifyValueRequest(null, values, auth);

    int successes = 0;
    int records = 0;
    
    while(true) {
      line = in.readLine();
      lineNum++;
      if(line==null)
        break;
      line = line.trim();
      if(line.length()<=0)
        continue;
      spaceIdx = line.indexOf(' ');
      if(spaceIdx<=0) {
        log.write("Invalid line ("+lineNum+"): "+line+"\n");
        continue;
      }
      
      String handle = line.substring(0, spaceIdx);
      String url = line.substring(spaceIdx + 1).trim();
      
      mvReq.handle = Util.encodeString(handle);
      mvReq.values[0].data = Util.encodeString(url);

      records++;
      mvReq.clearBuffers();
      AbstractResponse response = null;
      try {
        response = resolver.processRequest(mvReq);
        if(response.responseCode==AbstractMessage.RC_SUCCESS) {
          successes++;
          log.write("SUCCESS:"+(lineNum-1)+":UPDATE:"+handle+"\n");
        } else {
          log.write("ERROR: "+response.responseCode+" "+
                    AbstractMessage.getResponseCodeMessage(response.responseCode)+
                    ": line "+(lineNum-1)+" "+line+"\n");
        }
      } catch (HandleException e) {
        log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
      }
      try { log.flush(); } catch (Throwable t) {}
    }

    log.write("SUMMARY:UPDATE: "+
              successes+'/'+records+" successes "+
              (records-successes)+'/'+records+" errors\n");
  }

  static void processBatchAlias(AuthenticationInfo auth,
                                BufferedReader in,
                                PrintWriter out)
    throws Exception
  {
    String line;
    int spaceIdx;
    int lineNum = 0;

    log.write("Operation: alias\n");
    HandleValue values[] = new HandleValue[1];
    values[0] = new HandleValue();
    values[0].index = 0;
    values[0].type = Common.STD_TYPE_HSALIAS;
    values[0].data = null;

    HandleValue addValues[] = new HandleValue[1];
    addValues[0] = new HandleValue();
    addValues[0].index = 0;
    addValues[0].type = Common.STD_TYPE_HSALIAS;
    addValues[0].data = null;

    HandleValue newValues[] = new HandleValue[2];
    newValues[0] = new HandleValue();
    newValues[0].index = 0;
    newValues[0].type = Common.STD_TYPE_HSALIAS;
    newValues[0].data = null;
    newValues[1] = new HandleValue();
    newValues[1].index = 0;
    newValues[1].type = Common.STD_TYPE_HSADMIN;
    newValues[1].data = null;

    ResolutionRequest rReq = new ResolutionRequest(null, null, null, auth);
    rReq.authoritative = true;
    ModifyValueRequest mvReq = new ModifyValueRequest(null, values, auth);
    AddValueRequest avReq = new AddValueRequest(null, addValues, auth);
    RemoveValueRequest rmReq = new RemoveValueRequest(null, null, auth);
    CreateHandleRequest chReq = new CreateHandleRequest(null, newValues, auth);

    int successes = 0;
    int records = 0;

    HandleValue currentValues[];
    AbstractResponse response;
    while(true) {
      try { log.flush(); } catch (Throwable t) {}

      line = in.readLine();
      lineNum++;
      if(line==null)
        break;
      line = line.trim();
      if(line.length()<=0)
        continue;
      spaceIdx = line.indexOf(' ');
      if(spaceIdx<=0) {
        log.write("Invalid line ("+lineNum+"): "+line+"\n");
        continue;
      }
      
      String handleStr = line.substring(0, spaceIdx);
      byte handle[] = Util.encodeString(handleStr);
      String aliasHdlStr = line.substring(spaceIdx + 1).trim();
      byte aliasHdl[] = Util.encodeString(aliasHdlStr);
      
      records++;
      rReq.handle = handle;
      rReq.clearBuffers();
      currentValues = null;
      response = null;
      
      try {
        response = resolver.processRequest(rReq);
        if(response.responseCode==AbstractMessage.RC_SUCCESS) {
          currentValues = ((ResolutionResponse)response).getHandleValues();
        } else if(response.responseCode==AbstractMessage.RC_HANDLE_NOT_FOUND) {
          currentValues = null;
        } else {
          log.write("ERROR: "+response.responseCode+" "+
                    AbstractMessage.getResponseCodeMessage(response.responseCode)+
                    ": trying to retrieve handle, line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      } catch (HandleException e) {
        log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+
                  ": trying to retrieve handle, line "+(lineNum-1)+" "+line+"\n");
        continue;
      }


      // see if the current values have any aliases that we can just update
      HandleValue updateValue = null;
      Vector deleteValues = null;
      for(int i=0; currentValues!=null && i<currentValues.length; i++) {
        if(Util.equalsCI(currentValues[i].type, Common.STD_TYPE_HSALIAS)) {
          if(updateValue==null) {
            updateValue = currentValues[i];
          } else {
            if(deleteValues==null) deleteValues = new Vector();
            deleteValues.addElement(currentValues[i]);
          }
        }
      }

      // remove extra values...
      if(deleteValues!=null) {
        rmReq.handle = handle;
        int indexesToDelete[] = new int[deleteValues.size()];
        for(int i=0; i<indexesToDelete.length; i++) {
          indexesToDelete[i] = ((HandleValue)deleteValues.elementAt(i)).index;
        }
        rmReq.indexes = indexesToDelete;
        rmReq.clearBuffers();
        try {
          response = resolver.processRequest(rmReq);
          if(response.responseCode==AbstractMessage.RC_SUCCESS ||
             response.responseCode==AbstractMessage.RC_VALUES_NOT_FOUND) {
            // we're ok.
          } else {
            log.write("ERROR: "+response.responseCode+" "+
                      AbstractMessage.getResponseCodeMessage(response.responseCode)+
                      ": removing old aliases, line "+(lineNum-1)+" "+line+"\n");
            continue;
          }
        } catch (HandleException e) {
          log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+
                    ": removing old aliases, line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      }
      
      if(updateValue!=null) { // we will update an already existing alias...
        mvReq.handle = handle;
        mvReq.values[0].data = aliasHdl;
        mvReq.values[0].index = updateValue.index;
        mvReq.values[0].type = Common.STD_TYPE_HSALIAS;
        mvReq.clearBuffers();
        
        try {
          response = resolver.processRequest(mvReq);
          if(response.responseCode==AbstractMessage.RC_SUCCESS) {
            successes++;
            log.write("SUCCESS:"+(lineNum-1)+":ALIAS:"+handleStr+"\n");
          } else {
            log.write("ERROR: "+response.responseCode+" "+
                      AbstractMessage.getResponseCodeMessage(response.responseCode)+
                      ": line "+(lineNum-1)+" "+line+"\n");
            continue;
          }
        } catch (HandleException e) {
          log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      } else if(currentValues==null) { // we will create a new handle
        chReq.handle = handle;
        chReq.values[0].data = aliasHdl;
        
        AdminRecord admin =
          new AdminRecord(Util.encodeString("0.na/"+Util.decodeString(Util.getNAPart(chReq.handle))),
                          200, false, true, false, false, true,
                          true, true, true, true, true, true, true);
        chReq.values[1].data = Encoder.encodeAdminRecord(admin);
        chReq.clearBuffers();
        try {
          response = resolver.processRequest(chReq);
          if(response.responseCode==AbstractMessage.RC_SUCCESS) {
            successes++;
            log.write("SUCCESS:"+(lineNum-1)+":ADD:"+handle+"\n");
          } else {
            log.write("ERROR: "+response.responseCode+" "+
                      AbstractMessage.getResponseCodeMessage(response.responseCode)+
                      ": trying to create handle, line "+(lineNum-1)+" "+line+"\n");
          }
        } catch (HandleException e) {
          log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
        }
      } else { // we will create a new HS_ALIAS handle value
        avReq.handle = handle;
        avReq.values[0].data = aliasHdl;
        avReq.values[0].type = Common.STD_TYPE_HSALIAS;
        avReq.values[0].index = getUnusedIndex(currentValues);
        avReq.clearBuffers();
        
        try {
          response = resolver.processRequest(avReq);
          if(response.responseCode==AbstractMessage.RC_SUCCESS) {
            successes++;
            log.write("SUCCESS:"+(lineNum-1)+":ALIAS:"+handleStr+"\n");
          } else {
            log.write("ERROR: "+response.responseCode+" "+
                      AbstractMessage.getResponseCodeMessage(response.responseCode)+
                      ": line "+(lineNum-1)+" "+line+"\n");
            continue;
          }
        } catch (HandleException e) {
          log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      }
    }

    log.write("SUMMARY:ALIAS: "+
              successes+'/'+records+" successes "+
              (records-successes)+'/'+records+" errors\n");
  }


  static void processBatchUnalias(AuthenticationInfo auth,
                                  BufferedReader in,
                                  PrintWriter out)
    throws Exception
  {
    String line;
    int spaceIdx;
    int lineNum = 0;

    log.write("Operation: unalias\n");

    ResolutionRequest rReq = new ResolutionRequest(null, null, null, auth);
    rReq.authoritative = true;
    RemoveValueRequest rmReq = new RemoveValueRequest(null, null, auth);

    int successes = 0;
    int records = 0;

    HandleValue currentValues[];
    AbstractResponse response;
    while(true) {
      try { log.flush(); } catch (Throwable t) {}

      line = in.readLine();
      lineNum++;
      if(line==null)
        break;
      line = line.trim();
      if(line.length()<=0)
        continue;
      
      String handleStr = line.trim();
      byte handle[] = Util.encodeString(handleStr);
      
      records++;
      rReq.handle = handle;
      rReq.clearBuffers();
      currentValues = null;
      response = null;
      
      try {
        response = resolver.processRequest(rReq);
        if(response.responseCode==AbstractMessage.RC_SUCCESS) {
          currentValues = ((ResolutionResponse)response).getHandleValues();
        } else {
          log.write("ERROR: "+response.responseCode+" "+
                    AbstractMessage.getResponseCodeMessage(response.responseCode)+
                    ": trying to retrieve handle, line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      } catch (HandleException e) {
        log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+
                  ": trying to retrieve handle, line "+(lineNum-1)+" "+line+"\n");
        continue;
      }

      // count how many aliases there are so that we can delete them.
      HandleValue updateValue = null;
      Vector deleteValues = null;
      for(int i=0; currentValues!=null && i<currentValues.length; i++) {
        if(Util.equalsCI(currentValues[i].type, Common.STD_TYPE_HSALIAS)) {
          if(deleteValues==null) deleteValues = new Vector();
          deleteValues.addElement(currentValues[i]);
        }
      }

      // remove all existing aliases.
      if(deleteValues!=null) {
        rmReq.handle = handle;
        int indexesToDelete[] = new int[deleteValues.size()];
        for(int i=0; i<indexesToDelete.length; i++) {
          indexesToDelete[i] = ((HandleValue)deleteValues.elementAt(i)).index;
        }
        rmReq.indexes = indexesToDelete;
        rmReq.clearBuffers();
        try {
          response = resolver.processRequest(rmReq);
          if(response.responseCode==AbstractMessage.RC_SUCCESS ||
             response.responseCode==AbstractMessage.RC_VALUES_NOT_FOUND) {
            // we're ok.
          } else {
            log.write("ERROR: "+response.responseCode+" "+
                      AbstractMessage.getResponseCodeMessage(response.responseCode)+
                      ": removing old aliases, line "+(lineNum-1)+" "+line+"\n");
            continue;
          }
        } catch (HandleException e) {
          log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+
                    ": removing old aliases, line "+(lineNum-1)+" "+line+"\n");
          continue;
        }
      }

      successes++;
    }

    log.write("SUMMARY:ALIAS: "+
              successes+'/'+records+" successes "+
              (records-successes)+'/'+records+" errors\n");
  }

  private static final int getUnusedIndex(HandleValue values[]) {
    int nextIdx = 2;
    for(int i=0; values!=null && i<values.length; i++) {
      if(values[i]!=null && values[i].index==nextIdx) {
        nextIdx++;
        i=-1;
      }
    }
    return nextIdx;
  }
  
  static void processBatchDelete(AuthenticationInfo auth,
                                 BufferedReader in,
                                 PrintWriter out)
    throws Exception
  {
    String line;
    int spaceIdx;
    int lineNum = 0;

    log.write("Operation: delete\n");
    DeleteHandleRequest dhReq = new DeleteHandleRequest(null, auth);

    int successes = 0;
    int records = 0;
    String handle;
    
    while(true) {
      line = in.readLine();
      lineNum++;
      if(line==null)
        break;
      line = line.trim();
      if(line.length()<=0)
        continue;
      spaceIdx = line.indexOf(' ');
      if(spaceIdx>0) {
        handle = line.substring(0, spaceIdx).trim();
      } else {
        handle = line;
      }

      dhReq.handle = Util.encodeString(handle);
      
      records++;
      dhReq.clearBuffers();
      AbstractResponse response = null;
      try {
        response = resolver.processRequest(dhReq);
        if(response.responseCode==AbstractMessage.RC_SUCCESS) {
          successes++;
          log.write("SUCCESS:"+(lineNum-1)+":DELETE:"+handle+"\n");
        } else {
          log.write("ERROR: "+response.responseCode+" "+
                    AbstractMessage.getResponseCodeMessage(response.responseCode)+
                    ": line "+(lineNum-1)+" "+line+"\n");
        }
      } catch (HandleException e) {
        log.write("ERROR: "+e.getCode()+" "+HandleException.getCodeStr(e.getCode())+": line "+(lineNum-1)+" "+line+"\n");
      }
      try { log.flush(); } catch (Throwable t) {}
    }

    log.write("SUMMARY:DELETE: "+
              successes+'/'+records+" successes "+
              (records-successes)+'/'+records+" errors\n");
  }

}



