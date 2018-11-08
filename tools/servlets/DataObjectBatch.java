/************************************************************************\
  COPYRIGHT© 2000 Corporation for National Research Initiatives (CNRI);
                         All rights reserved.
-----------------------------------------------------------------------
Revision 2.1  2001/07/23 10:35:00  tony
adapted from (My)GenericBatch.java to be
called from YADS servlet

Revision 2.0  2000/05/18 10:35:00  tony
adapted from GenericBatch.java to allow
client to query local handle service directly

Developer: Jing Shi <jshi@cnri.reston.va.us>
$Log: GenericBatch.java,v $
Revision 1.9  2000/04/11 22:14:08  jshi
add clearBuffers() for remove request

Revision 1.8  2000/03/13 22:07:30  jshi
minor modify for convert DB

Revision 1.7  2000/03/09 21:49:20  jshi
modify minor on batch help

Revision 1.6  2000/03/07 14:04:07  jshi
add batch format for HS_DSAPUBKEY, HS_SITE, HS_VLIST

Revision 1.5  2000/03/03 14:59:19  sreilly
changed 1999 to 2000 in copyright statement

Revision 1.4  2000/02/23 17:33:32  jshi
add HOME/UNHOME NA to batch file

Revision 1.3  2000/02/21 14:27:03  jshi
modify minor for the batch format

Revision 1.2  2000/02/18 19:26:56  jshi
complete batch load

Revision 1.1  2000/02/14 20:15:24  jshi
add new file Generic Batch loading file

\************************************************************************/

import net.handle.hdllib.*;
import net.handle.apps.gui.jutil.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.security.*;

public class DataObjectBatch{
        
    public static final String ENCODING ="UTF8";
    
    public static final String FETCH_STR = "FETCHDATASTORE";

    public static final String CREATE_STR = "CREATEDATASTORE";
    public static final String DELETE_STR = "DELETEDATASTORE";
    public static final String ADD_STR = "ADDDATASTORE";
    public static final String MODIFY_STR = "MODIFYDATASTORE";
    public static final String REMOVE_STR = "REMOVEDATASTORE";

    // public static final String CREATE_STR = "CREATE";
    // public static final String DELETE_STR = "DELETE";
    // public static final String ADD_STR = "ADD";
    // public static final String MODIFY_STR = "MODIFY";
    // public static final String REMOVE_STR = "REMOVE";

    public static final String AUTH_STR = "AUTHENTICATE";
    public static final String HOME_STR = "HOME";
    public static final String UNHOME_STR = "UNHOME";
    public static final String SECKEY_STR = "SECKEY";
    public static final String PUBKEY_STR = "PUBKEY";
    public static final String END_STR = "END";
    public static final String SEPA_STR = " ";
    public static final String NEW_LINE = "\n";
    public static final String ADMIN_STR ="ADMIN";
    public static final String BINARY_FILE_STR ="FILE";
    public static final String LIST_STR ="LIST";
   
    private AuthenticationInfo authInfo = null;
    // tony - 2001.07.23
    private BufferedReader batchReader = null;
    private String batchBuffer = null;
    private HandleResolver resolver;
    private long lineNum=0;
    private long totalAcc=0;
    private long errAcc=0;
    private long succAcc=0;
    private PrintWriter succWriter;
    private PrintWriter errWriter;
    private boolean succWriterFlag = true;
    private boolean errWriterFlag = true;
    private CreateHandleRequest createReq;
    private DeleteHandleRequest deleteReq;
    private AddValueRequest addReq;
    private RemoveValueRequest removeReq;
    private ModifyValueRequest modifyReq;
    private GenericRequest homeNAReq;

    private volatile boolean stopFlag = false;
    private Thread runThread;

    // tony - 2001.07.23
    public DataObjectBatch(String batchBuffer, String succLog, String errLog, 
			HandleResolver resolver, AuthenticationInfo authInfo)
	throws Throwable
    {
    // tony - 2001.07.23
	this(batchBuffer, new File(succLog), new File(errLog), resolver, authInfo);
    }

    // tony - 2001.07.23
    public DataObjectBatch(String batchBuffer, File succFile, File errFile, 
			HandleResolver resolver, AuthenticationInfo authInfo)
	throws Throwable 
    {
//	if(inputFile==null || !inputFile.exists() || !inputFile.canRead() || !inputFile.isFile()){
//        throw new Exception("Error: Invalid Batch File "+ inputFile.getAbsolutePath()+"\n");
//      }
// batchReader = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile),ENCODING));

    batchReader = new BufferedReader(new InputStreamReader(new StringBufferInputStream(batchBuffer),ENCODING));

	succWriterFlag = checkWriteFile(succFile);
	if(succWriterFlag)
	    succWriter = new PrintWriter(new OutputStreamWriter(new FileOutputStream(succFile),ENCODING),true);
	else{
	    System.err.println("Waring: invalid success log file name, using stderr print out");
	    succWriter = new PrintWriter(new OutputStreamWriter(System.err,ENCODING),true);
	}
	
	errWriterFlag = checkWriteFile(errFile);
	if(errWriterFlag)
	    errWriter = new PrintWriter(new OutputStreamWriter(new FileOutputStream(errFile),ENCODING),true);
	else{
	    System.err.println("Waring: invalid error log file name, using stderr print out");
	    errWriter = new PrintWriter(new OutputStreamWriter(System.err,ENCODING),true);
	}
	
        // 2000/05/18 - tony
        // Read the site info into 'site' from the
        // "siteinfo.bin" file on the local handle server 193.122.198.4

        // SiteInfo site = new SiteInfo();
        // File siteInfoFile = new File("/opt/HARChs/srv_1/siteinfo.bin");
        // byte siteInfoBuf[] = new byte[(int)siteInfoFile.length()];
        // new FileInputStream(siteInfoFile).read(siteInfoBuf);
        // Encoder.decodeSiteInfoRecord(siteInfoBuf, 0, site);

	if(resolver == null) this.resolver= new HandleResolver();
	else
	    this.resolver = resolver;

        // 2000/05/18 - tony
        // Now configure the resolver to use the local site info

        // this.resolver.getConfiguration().setCacheSites(new SiteInfo[]{ site });
        // this.resolver.getConfiguration().setResolutionMethod(Configuration.RM_WITH_CACHE);

	this.authInfo = authInfo;
	createReq = new CreateHandleRequest(null,null,null);
	deleteReq = new DeleteHandleRequest(null,null);
	addReq = new AddValueRequest(null,(HandleValue[])null,null);
	removeReq = new RemoveValueRequest(null,(int[])null,null);
	modifyReq = new ModifyValueRequest(null,(HandleValue[])null,null);
	homeNAReq = new GenericRequest((byte[])null, -1, null);
    }
       
/**
    // tony - 2001.07.23
    public DataObjectBatch(String batchBuffer, HandleResolver resolver, AuthenticationInfo authInfo)
	throws Throwable
    {
	this(batchBuffer, null,null,resolver, authInfo);
    }
*/

    public void stopProcessBatch(){
	stopFlag = true;
	if(runThread != null)
	    runThread.interrupt();
    }
	
    public void processBatch()
	throws Throwable
    {
	String line;
	int spaceIdx;
	lineNum = 0;
	
	runThread = Thread.currentThread();
	try{
	    while(!stopFlag) {
		line = readLine();
		if(line==null)
		    break;
		line = line.trim();
		if(line.length()<=0)
		    continue;
		processBlock(line);
		
	    }
	}catch(InterruptedException e){
	    System.err.println("Thread stops");
	    e.printStackTrace();
	    Thread.currentThread().interrupt();
	}finally{
	    batchReader.close();
	    succWriter.println("Success number/Total number: "+ succAcc+"/"+totalAcc);
	    succWriter.println("Process line number: " +lineNum);
	    succWriter.flush();
	    errWriter.flush();
	    if(succWriterFlag)
		succWriter.close();
	    errWriter.flush();
	    if(errWriterFlag)
		errWriter.close();
	}

	/*batchReader.close();
	succWriter.println("Success number/Total number: "+ succAcc+"/"+totalAcc);
	succWriter.println("Process line number: " +lineNum);
	succWriter.flush();
	errWriter.flush();
	if(succWriterFlag)
	  succWriter.close();
	errWriter.flush();
	if(errWriterFlag)
  	    errWriter.close();
	*/
    }

    public long getLineNum(){
	return lineNum;
    }
    
    String readLine(){
	try{
	    if(lineNum == 500) System.gc();

	    String line = batchReader.readLine();
	    if(line ==null) return null;
	    succWriter.println("> " + line);
	    lineNum++;
	    return line.trim();
	}catch(Exception e){
	    errWriter.println("=> Error readline:" + lineNum + NEW_LINE);
	    return null;
	}
    }
		     
    void processBlock(String line)
	throws Throwable
    {	   
	int spInd = line.indexOf(SEPA_STR);
	if(spInd<=1){  
	    errWriter.println("=> Error readline:invalid command at line: " + lineNum + NEW_LINE);
	    return;
	}
	String upperLine = line.substring(0,spInd).trim().toUpperCase();
	String handleline = line.substring(spInd+1,line.length()).trim();

	if(upperLine.equals(AUTH_STR)){
	    AuthenticationInfo tmpAuth = getAuthInfoFromBatch(handleline);
	    if(tmpAuth != null) 
		authInfo = tmpAuth;
	    return;
	}

	if(upperLine.equals(CREATE_STR)){
	    totalAcc++;
	    processCreate(handleline);
	    return;
	}
	
	if(upperLine.equals(DELETE_STR)){
	    totalAcc++;
	    processDelete(handleline);
	    return;
	}
	
	if(upperLine.equals(ADD_STR)){
	    totalAcc++;
	    processAdd(handleline);
	    return;
	}
	
	if(upperLine.equals(REMOVE_STR)){
	    totalAcc++;
	    processRemove(handleline);
	    return;
	}

	if(upperLine.equals(MODIFY_STR)){
	    totalAcc++;
	    processModify(handleline);
	    return;
	}
	
	if(upperLine.equals(HOME_STR)){
	    processHomeNA(handleline, true);
	    return;
	}
	
	if(upperLine.equals(UNHOME_STR)){
	    processHomeNA(handleline, false);
	    return;
	}
    }
	
    AuthenticationInfo getAuthInfoFromBatch(String line)
	throws Throwable
    {
	String substr;
	int index;
	String handle;

	if(line == null){
	    errWriter.println("=> Warning: empty authentication information at line:" + lineNum + NEW_LINE);
	    return null;
	}
	
	StringTokenizer token = new StringTokenizer(line, ":");
	substr = token.nextToken().trim().toUpperCase();

	if(substr.equals(SECKEY_STR)){
	    substr = token.nextToken().trim();
	    index = Integer.parseInt(substr);
	    handle = token.nextToken().trim();
	    
	    String passwd = readLine();
	    SecretKeyAuthenticationInfo
		seckeyAuthInfo = new SecretKeyAuthenticationInfo(net.handle.hdllib.Util.encodeString(handle), 
								 index,net.handle.hdllib.Util.encodeString(passwd));
	    succWriter.println("=> AUTHENTICATION");
	    succWriter.println(seckeyAuthInfo+NEW_LINE);
	    return seckeyAuthInfo;
	}
	else if(substr.equals(PUBKEY_STR)){
	    substr = token.nextToken().trim();
	    index = Integer.parseInt(substr);
	    handle = token.nextToken().trim();
	    
	    String keyStr = readLine();
	    String passPhrase = readLine();
	    File file = new File(keyStr);
	    if(file==null || !file.exists() || !file.canRead()){
		errWriter.println("=> Warning: invalid private key file at line: "+lineNum+NEW_LINE);
		return null;
	    }

	    InputStream in = null;
	    byte[] rawKey = new byte[(int)file.length()];
	    in = new FileInputStream(file);
	    int n =0; int r=0;
	    while(n<rawKey.length && (r=in.read(rawKey, n, rawKey.length-n))>0)
		n +=r;
	    in.close();
	    
	    byte keyBytes[] = Util.decrypt(rawKey, Util.encodeString(passPhrase));
	    PrivateKey privateKey = Util.getPrivateKeyFromBytes(keyBytes, 0);
	    PublicKeyAuthenticationInfo
		pubkeyAuthInfo = new PublicKeyAuthenticationInfo(net.handle.hdllib.Util.encodeString(handle), 
								 index,privateKey);
	    succWriter.println("=> AUTHENTICATION");
	    succWriter.println(pubkeyAuthInfo+NEW_LINE);
	    return pubkeyAuthInfo;
	}
	else{
	    errWriter.println("=> Error: invalid authentication information at line: "+lineNum +NEW_LINE);
	    return null;
	}
    }
    
    void processCreate(String line)
	throws Throwable
    {
	String handle;
	HandleValue[] values;
	AbstractResponse response;
	
	handle = line;
	if(handle ==null || handle.length()==0){
	    errWriter.println("=> Error:invalid handle name at line: " + lineNum+NEW_LINE);
	    return;
	}
	
	values= readHandleValueArray();
	if(values== null){
	    errWriter.println("=> Error: no handle data in " + handle+" at line:" + lineNum+NEW_LINE);
	    return;
	}
	    
	createReq.authInfo = this.authInfo;
	createReq.handle = Util.encodeString(handle);
	createReq.values = values;
	createReq.clearBuffers();
	response = null;

	try{
	    response = resolver.processRequest(createReq);
	    if(response.responseCode==AbstractMessage.RC_SUCCESS) {		    
		succWriter.println("=> CREATED: "+handle+NEW_LINE);
		succAcc++;
	    } else {
		errWriter.println("=> FAILURE: Create "+handle+": "+response+" at line: "+lineNum+NEW_LINE);
		
	    }
	}catch(HandleException e){
	    switch(e.getCode()){
	    case 0:
	    case 5: 
		errWriter.println("=> FAILURE: Create "+handle+": "+ e.toString()+" at line: "+lineNum+NEW_LINE);
		break;
	    default:
		errWriter.println("=> FAILURE: Create "+handle+": "+ e.toString()+" at line: "+lineNum+NEW_LINE);
		//throw e;
	    }
	}
    }
    
    
    void processDelete(String line)
	throws Throwable
    {
	String handle;
	AbstractResponse response;
	
	handle = line;
	if(handle ==null || handle.length()==0){
		errWriter.println("=> Error: invalid handle name at line: " + lineNum+NEW_LINE);
		return;
	    }
	deleteReq.authInfo = this.authInfo;
	deleteReq.handle = Util.encodeString(handle);
	deleteReq.clearBuffers();
	response = null;
	try{
	    response = resolver.processRequest(deleteReq);
	    if(response.responseCode==AbstractMessage.RC_SUCCESS) {		    
		succWriter.println("=> DELETED: "+handle+NEW_LINE);
		succAcc++;
	    } else {
		errWriter.println("=> FAILURE: Delete "+handle+": "+response+" at line: "+lineNum+NEW_LINE);
	    }
	}catch(HandleException e){
	    switch(e.getCode()){
	    case 0:
	    case 9: 
		errWriter.println("=> FAILURE: Delete "+handle+": "+ e.toString()+" at line: "+lineNum+NEW_LINE);
		break;
	    default:
		errWriter.println("=> FAILURE: Delete "+handle+": "+ e.toString()+" at line: "+lineNum+NEW_LINE);
		//throw e;
	    }
	}
    }
   	    
    void processAdd(String line)
	throws Throwable
    {
	String handle;
	HandleValue[] values;
	AbstractResponse response;
	handle = line;
	if(handle ==null || handle.length()==0){
	    errWriter.println("=> Error: invalid handle name at line: " + lineNum + NEW_LINE);
		return;
	    }

	values= readHandleValueArray();
	if(values== null){
	    errWriter.println("=> Error: no handle data in " +handle+" at line: " + lineNum+NEW_LINE);
	    return;
	}
	
	addReq.authInfo = this.authInfo;
	addReq.handle = Util.encodeString(handle);
	addReq.values = values;
	addReq.clearBuffers();
	response = null;
	try{
	    response = resolver.processRequest(addReq);
	    if(response.responseCode==AbstractMessage.RC_SUCCESS) {		    
		succWriter.println("=> ADDED VALUE: "+handle +NEW_LINE);
		succAcc++;
	    } else {
		errWriter.println("=> FAILURE: Add value "+handle+": "+response+" at line: "+lineNum+NEW_LINE);
		
	    }
	}catch(HandleException e){
	    switch(e.getCode()){
	    case 0:
	    case 9: 
		errWriter.println("=> FAILURE: Add Value "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		break;
	    default:
		errWriter.println("=> FAILURE: Add Value "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		//throw e;
	    }
	}	
    }
    
    void processRemove(String line)
	throws Throwable
    {
	String handle;
	AbstractResponse response;

	if(line==null || line.length()==0){
	    errWriter.println("=> Error: invalid remove line at line: " + lineNum + NEW_LINE);
	    return;
	}
	
	int ind = line.indexOf(":");
	String indexStr = line.substring(0,ind);
	int[] indexes = readIndexArray(indexStr);
	if(indexes == null) {
	    errWriter.println("=> Error: invalid remove value indexes at line: " + lineNum+NEW_LINE);
	    return;
	}
	
	handle = line.substring(ind+1, line.length()).trim();
	if(handle==null || handle.length()==0){
	    errWriter.println("=> Error: invalid handle name at line: " + lineNum + NEW_LINE);
	    return;
	} 
	
	removeReq.authInfo = this.authInfo;
	removeReq.handle = Util.encodeString(handle);
	removeReq.indexes = indexes;
	removeReq.clearBuffers();
	response = null;
	try{
	    response = resolver.processRequest(removeReq);
	    if(response.responseCode==AbstractMessage.RC_SUCCESS) {		    
		succWriter.println("=> REMOVED VALUE: "+handle+NEW_LINE);
		succAcc++;
	    } else {
		errWriter.println("=> FAILURE: Remove value "+handle+": "+response+" at line: "+lineNum+NEW_LINE);
	    }
	}catch(HandleException e){
	    switch(e.getCode()){
	    case 0:
	    case 9: 
		errWriter.println("=> FAILURE: Remove value "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		break;
	    default:
		errWriter.println("=> FAILURE: Remove value "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		//throw e;
	    }
	}
    }	    
  
    void processModify(String line)
	throws Throwable
    {
	String handle;
	HandleValue[] values;
	AbstractResponse response;

	handle = line;
	if(handle==null || handle.length()==0){
	    errWriter.println("=> Error: invalid handle name at line: "+ lineNum + NEW_LINE);
	    return;
	}
		    
	values= readHandleValueArray();
	if(values== null){
	    errWriter.println("=> Error: not handle data in "+handle+" at line: "+ lineNum+NEW_LINE);
	    return;
	}
	
	modifyReq.authInfo = this.authInfo;
	modifyReq.handle = Util.encodeString(handle);
	modifyReq.values = values;
	modifyReq.clearBuffers();
	response = null;
	try{
	    response = resolver.processRequest(modifyReq);
	    if(response.responseCode==AbstractMessage.RC_SUCCESS) {		    
		succWriter.println("=> MODIFIED VALUE: "+handle);
		succAcc++;
	    } else {
		errWriter.println("=> FAILURE(0): Modify value "+handle+": "+response+" at line: "+lineNum+NEW_LINE);
	    }
	}catch(HandleException e){
	    switch(e.getCode()){
	    case 0:
	    case 9: 
		errWriter.println("=> FAILURE(1): Modify value "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		break;
	    default:
		errWriter.println("=> FAILURE(2): Modify value  "+handle+": "+ e.toString()+" at line: "+lineNum + NEW_LINE);
		//throw e;
	    }
	}
    }
    //do home and unhome NA handle on servers 
    void processHomeNA(String line, boolean homeFlag)
	throws Throwable
    {
	String handle;
	String ipstr;
	int port;
	String protocol;
	AbstractResponse response;
	
	if(line==null || line.length()==0){
            errWriter.println("=> Error: invalid home line at line: " + lineNum+NEW_LINE);
            return;
        }
	
	StringTokenizer st = new StringTokenizer(line,":");
	ipstr= st.nextToken().trim();
	try{
	    port= Integer.parseInt(st.nextToken().trim());
	}catch(Exception e){
	    errWriter.println("=> Error: invalid home line at line: " + lineNum+NEW_LINE);
	    return;
	}   
	protocol = st.nextToken().trim();
		
	InetAddress svrAddr = InetAddress.getByName(ipstr);
	GenericRequest siReq = new GenericRequest(Common.BLANK_HANDLE,AbstractMessage.OC_GET_SITE_INFO,null);
	siReq.certify = true;
	response = null;
	if(protocol.toUpperCase().equals("TCP"))
	    response = resolver.sendHdlTcpRequest(siReq, svrAddr, port);
	else if(protocol.toUpperCase().equals("UDP"))
	    response = resolver.sendHdlUdpRequest(siReq, svrAddr, port);
	else if(protocol.toUpperCase().equals("HTTP"))
	    response = resolver.sendHttpRequest(siReq, svrAddr, port);
	else{
	    errWriter.println("=> Error: invalid Naming authority handle name at line: "+ lineNum + NEW_LINE);
	    return;
	}
	SiteInfo siteInfo = null;
	if(response !=null && response.responseCode==AbstractMessage.RC_SUCCESS) {
	    siteInfo = ((GetSiteInfoResponse)response).siteInfo;
	} else {
	    errWriter.println("=> Error: unable to retrieve site information from server at line: "+ lineNum + NEW_LINE );
	    return;
	}
	
	if(!siteInfo.isPrimary) {
	    errWriter.println("=> Error: not primary server at line: "+ lineNum + NEW_LINE );
	    return;
	}
	
	homeNAReq.authInfo = this.authInfo;
	if(homeFlag)
	    homeNAReq.opCode = AbstractMessage.OC_HOME_NA;
	else
	    homeNAReq.opCode = AbstractMessage.OC_UNHOME_NA;

	homeNAReq.certify = true;
	boolean flag;
	while(true){
	    handle = readLine();
	    if(handle==null || handle.length()==0) return;
	    byte[] naHandle = Util.encodeString(handle);
	    if(!Util.startsWithCI(naHandle, Common.NA_HANDLE_PREFIX)) {
		errWriter.println("=> Error: invalid Naming authority handle name at line: "+ lineNum+NEW_LINE);
		return;
	    }
	    homeNAReq.handle = naHandle;
	    homeNAReq.clearBuffers();
	    flag = true;
	    for(int i=0; i<siteInfo.servers.length; i++) {
		response = resolver.sendRequestToServer(homeNAReq, siteInfo.servers[i]);
		if(response.responseCode!=AbstractMessage.RC_SUCCESS) {
		    errWriter.println("=> FAILURE: home/unhome "+handle+": "+ response.toString()+" at line: "+lineNum + NEW_LINE);
		    flag = false;
		}
	    }
	    if(flag){
		succWriter.println("=> HOMED/UNHOMED: "+handle+NEW_LINE);
		succAcc++;
		totalAcc++;
	    }
        }
    }
    
    int[] readIndexArray(String line){
	String substr;
	try{
	    StringTokenizer st = new StringTokenizer(line,",");
	    int[] indexes = new int[st.countTokens()];
	    for(int i=0; i<indexes.length; i++)
		try{
		    indexes[i] = Integer.parseInt(st.nextToken().trim());
		}catch(Exception e){
		    return null;
		}
	    return indexes;
	}catch(Exception e){
	    errWriter.println("=> Error: invalid index array at line: " + lineNum);
	    return null;
	}
    }	    
	
  
    HandleValue[] readHandleValueArray()
    {
	Vector vt = new Vector();
	String line;
	try{
	    while(true){
		line = readLine();
		if(line == null || line.length()==0)
		    break;
		HandleValue hv = readHandleValue(line);
		if(hv == null) continue;
		else vt.addElement(hv);
	    }
	    
	    if(vt.size()<1) return null;
	    HandleValue[] values = new HandleValue[vt.size()];
	    for(int i=0; i<vt.size(); i++)
		values[i] = (HandleValue) vt.elementAt(i);

	    return values;
	}catch(Exception e){
	    errWriter.println("=> Error: invalid handle value array at line: " +lineNum);
	    return null;
	}
    }

    HandleValue readHandleValue(String line){
	String substr;
	try{
	    StringTokenizer st = new StringTokenizer(line, SEPA_STR);
	    HandleValue hv = new HandleValue();
	    //read index
	    substr = st.nextToken().trim();
	    try{
		hv.index = Integer.parseInt(substr);
	    }catch(Exception e){
		errWriter.println("=> Error: handle value index is not correct at line:"+ lineNum);
		return null;
	    }
	    
	    //read type
	    substr = st.nextToken().trim();
	    hv.type = Util.encodeString(substr);
	    
	
	    //read ttl
	    substr = st.nextToken().trim();
	    try{
		hv.ttl = Integer.parseInt(substr);
	    }catch(Exception e){
		errWriter.println("=> Error: handle value ttl is not correct at line:"+ lineNum);
		return null;
	    }
	    
	    //read permission
	    substr = st.nextToken().trim();
	    if(substr.length() <4) {
		errWriter.println("=> Error: handle value permission is not correct at line:" + lineNum);
		return null;
	    }
	    int i=0;
	    if(substr.charAt(i)=='1') hv.adminRead = true;
	    else hv.adminRead = false;
	    if(substr.charAt(++i)=='1') hv.adminWrite = true;
	    else hv.adminWrite = false;
	    if(substr.charAt(++i)=='1') hv.publicRead = true;
	    else hv.publicRead = false;
	    if(substr.charAt(++i)=='1') hv.publicWrite = true;
	    else hv.publicWrite = false;
	    
	    //read handle value data
	    substr = st.nextToken().trim().toUpperCase();
	    if(substr.equals(ENCODING)){
		substr = st.nextToken(NEW_LINE).trim();
		hv.data = Util.encodeString(substr);
	    }
	    else if(substr.equals(ADMIN_STR)){
		AdminRecord record = new AdminRecord();
		//read admin index
		substr = st.nextToken(":").trim();
		try{
		    record.adminIdIndex = Integer.parseInt(substr);
		}catch(Exception e){
		    errWriter.println("=> Error: admin index is not correct at line: " + lineNum);
		    return null;
		}
		//read admin permission
		substr = st.nextToken(":").trim();
		if(substr.length()<11){
		    errWriter.println("=> Error: administrate permission is not correct at line: "+ lineNum);
		    return null;
		}
		for(i=0; i<substr.length(); i++)
		    if(substr.charAt(i)=='1') 
			record.perms[i] = true;
		    else 
			record.perms[i] = false;
		//read admin handle
		substr = st.nextToken(NEW_LINE);
		record.adminId = Util.encodeString(substr.substring(1,substr.length()).trim());
		
		hv.data = Encoder.encodeAdminRecord(record);
	    }

	    else if(substr.equals(BINARY_FILE_STR)){
		substr =st.nextToken(NEW_LINE);
		String filename = substr.substring(1,substr.length()).trim();
       
		File file = new File(filename);
		if(file==null || !file.exists() || !file.canRead()){
		    errWriter.println("=> Warning: invalid public key file at line: "+lineNum+NEW_LINE);
		    return null;
		}
		
		InputStream in = null;
		byte[] rawKey = new byte[(int)file.length()];
		in = new FileInputStream(file);
		int n =0; int r=0;
		while(n<rawKey.length && (r=in.read(rawKey, n, rawKey.length-n))>0)
		    n +=r;
		in.close();
		hv.data = rawKey;
	    }
	    
	    else if(substr.equals(LIST_STR)){
		int index;
		String handle;
		
		Vector vt = new Vector();
	       	substr =st.nextToken(NEW_LINE).trim();
		StringTokenizer stt = new StringTokenizer(substr,":");
		while(stt.hasMoreTokens()){
		    try{
			String tt = stt.nextToken(":").trim();
			index = Integer.parseInt(tt);
		    }catch(Exception e){
			errWriter.println("=> Error: index is not correct at line: " + lineNum);
			e.printStackTrace();
			return null;
		    }
		    
		    handle= stt.nextToken(";");
		    handle = handle.substring(1, handle.length()).trim();
		    if(substr.length()<1){
			errWriter.println("=> Error: handle name is not correct at line: "+ lineNum);
			return null;
		    }
		    vt.addElement(new ValueReference(Util.encodeString(handle),index));
		}

		if(vt.size()<1) return null;
		ValueReference[] refs = new ValueReference[vt.size()];
		for(int j=0; j<refs.length; j++)
		    refs[j] = (ValueReference) vt.elementAt(j);
		hv.data = Encoder.encodeValueReferenceList(refs);
	    }

	    else{
		errWriter.println("=> Error: can not recognized handle value at line: " + lineNum);
		return null;
	    }
	    return hv;
	}catch(Exception e1){
	    errWriter.println("=> Error: invalid handle value at line: " +lineNum);
	    e1.printStackTrace();
	    return null;
	}
    }

    boolean checkWriteFile(File file){
	if(file==null) return false;
	if(file.exists()){
	    if(file.canWrite())
		return true;
	    else return false;
	}
	
	File parent = FileOpt.getParent(file);
	if(parent.canWrite())
	    return true;
	else return false;
    }
	
    // tony - 2001.07.23
    public static void printUsage() {
	System.err.println("Usage: DataObjectBatch"+
			   " <batchfile> [<successLogFile><errorLogFile>]");
    }
    
    // tony - 2001.07.23
    public static void main(String args[])
	throws Throwable
    {
	if(args.length <1)
	    printUsage();
/**
	else if(args.length ==1){
	    // DataObjectBatch batch = new DataObjectBatch(args[0], null,null);
	    DataObjectBatch batch = new DataObjectBatch(args[0], null, null, null,null);
	    batch.processBatch();
	}
*/
	else if(args.length <3)
	    printUsage();
	else{
	    DataObjectBatch batch = new DataObjectBatch(args[0], args[1], args[2],null,null);
	    batch.processBatch();
	}
    }
}
