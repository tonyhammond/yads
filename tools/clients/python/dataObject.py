########################################################################
#
# doi.dataObject.py - A Python class for manipulating DOI DataObjects
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
#
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
# 
########################################################################


import re
import os, sys, traceback
import string
import httplib
import urllib


class DataObject:

    """
The DataObject Class is a Python class for managing DataObject objects.
These DataObjects are transient computational structures with persistent network
identifiers which manage data elements relating to intellectual property
entities. These data elements are organized into DataGroups which are bound 
through an application profile to applications that can service (or otherwise
meaningfully interpret) them.

Usage:

    import doi.dataObject

    d = DataObject("10.1006/jmbi.2000.4282")
    d.readDataStore()
    for resource in d.resources():
        print resource

    """

    # DOI_SERVICE_SERVER = "www2.harcourt-international.com"
    DOI_SERVICE_SERVER = "193.122.198.4"
    DOI_SERVICE_PATH   = "/ap/servlet/yads"

    DATA_STORE_CALL_ADD    = "add"
    DATA_STORE_CALL_CREATE = "create"
    DATA_STORE_CALL_DELETE = "delete"
    DATA_STORE_CALL_MODIFY = "modify"
    DATA_STORE_CALL_REMOVE = "remove"

    dataObjectTypes = [
        "agents", "aliases", "children", "details", "genres", "labels",
        "parents", "profiles", "resources", "schemas", "servers",
        "services", "types" ]
    
    #__nDataObjects = 0

    # DataObject constructor

    def __init__(self, doi):

        """Constructs a new DataObject with identifier doi."""

        #__nDataObjects = __nDataObjects + 1
        #self.nDataObject = __nDataObjects

        self.doi = doi          # DOI for this DataObject
        self.dataObject = {}    # Data element type/value pairs keyed on index
        self.dataTypes = {}     # Hash keyed on data type with list of data values

        self.dataIndex = 0      # Next available index for dataObject hash
        self.dataMap = ""       # Map of indexes within DataGroups

        self.authUsername = ""  # Authorized username for service
        self.authPassword = ""  # Authorized password for service

    
    def get(self, doi):

        """Constructs a new DataObject with identifier doi and populates
        it with DataGroups fetched from a DataObject copy within the DataStore.
        Equivalent to the following call sequence:
            d = DataObject.new( doi ).readDataStore"""

        d = self.__init__(doi)
        d.readDataStore()
        return d


    def readDataStore(self):

        """Retrieves DataGroups from the persisted DataObject within the DataStore
        identified by doi and use them to populate the current DataObject
        instance."""

        self._getDataFromStore()
        return self

    
    def writeDataStore(self, request):

        """Generic method for modifying a DataObject copy within the DataStore with the
        DataGroups present within the current DataObject instance. The request argument 
        specifies the type of operation. Convenience methods are provided, see also
        addDataStore, createDataStore, deleteDataStore, modifyDataStore,
        and removeDatatore."""

        self._putDataToStore(request)
        return self


    # Convenience wrappers for specific writeDataStore methods

    def addDataStore(self):

        """Adds the DataGroups present in the current DataObject instance to the
        persisted DataObject copy within the DataStore."""

        self.writeDataStore(self.DATA_STORE_CALL_ADD) 


    def createDataStore(self):

        """Creates a persisted instance of the current DataObject within the DataStore."""

        self.writeDataStore(self.DATA_STORE_CALL_CREATE)


    def deleteDataStore(self):

        """Deletes the persisted copy of the current DataObject instance within the DataStore."""

        self.writeDataStore(self.DATA_STORE_CALL_DELETE)


    def modifyDataStore(self):

        """Replaces DataGroups in the persisted DataObject copy within the DataStore
        with the DataGroups present within the current DataObject instance."""

        self.writeDataStore(self.DATA_STORE_CALL_MODIFY)


    def removeDataStore(self):

        """Removes from the persisted DataObject copy within the DataStore the DataGroups
        present within the current DataObject instance."""

        self.writeDataStore(self.DATA_STORE_CALL_REMOVE)


########################################################################

    # Method to list allowed DataObject types

    def types(self):

        """Returns list of known DataObject class data types."""

        return self.dataObjectTypes


    # Accessor method for all dataTypes

    def dataTypes(self):

        """Returns the DataObject types within the current DataObject instance."""

        return self.dataTypes.keys()


    # Accessor method for all dataValues

    def dataValues(self, *types):

        """Returns the DataObject values within the current DataObject instance. If an
        optional types list is provided then restrict the DataObject values 
        to those of specified type(s)."""

        a = []

        for type in self.dataTypes.keys():

            if types:
                if type in types:
                    a = a + self.dataTypes[type]
            else:
                a = a + self.dataTypes[type]

        return a


    # Set accessor methods for individual types

    def agents(self):

        """Returns list of data values of DataObject type 'agent' for the current
        DataObject instance."""

        return self.dataTypes['agent']

    def aliases(self):

        """Returns list of data values of DataObject type 'alias' for the current
        DataObject instance."""

        return self.dataTypes['alias']

    def children(self):

        """Returns list of data values of DataObject type 'child' for the current
        DataObject instance."""

        return self.dataTypes['child']

    def details(self):

        """Returns list of data values of DataObject type 'detail' for the current
        DataObject instance."""

        return self.dataTypes['detail']

    def genres(self):

        """Returns list of data values of DataObject type 'genre' for the current
        DataObject instance."""

        return self.dataTypes['genre']

    def labels(self):

        """Returns list of data values of DataObject type 'label' for the current
        DataObject instance."""

        return self.dataTypes['label']

    def parents(self):

        """Returns list of data values of DataObject type 'parent' for the current
        DataObject instance."""

        return self.dataTypes['parent']

    def profiles(self):

        """Returns list of data values of DataObject type 'profile' for the current
        DataObject instance."""

        return self.dataTypes['profile']

    def resources(self):

        """Returns list of data values of DataObject type 'resource' for the current
        DataObject instance."""

        return self.dataTypes['resource']

    def schemas(self):

        """Returns list of data values of DataObject type 'schema' for the current
        DataObject instance."""

        return self.dataTypes['schema']

    def servers(self):

        """Returns list of data values of DataObject type 'server' for the current
        DataObject instance."""

        return self.dataTypes['server']

    def services(self):

        """Returns list of data values of DataObject type 'service' for the current
        DataObject instance."""

        return self.dataTypes['service']

    def types(self):

        """Returns list of data values of DataObject type 'type' for the current
        DataObject instance."""

        return self.dataTypes['type']

    # Define a set of type test methods

    def _is_type(self, type, s):

        for type in self.dataTypes[type]:
            if re.match(s, type): return 1
        return 0

    def has_agent(self, s):

        """Returns 1 if s is of DataObject type 'agent', otherwise 0."""

        return self._is_type('agent', s)

    def has_alias(self, s):

        """Returns 1 if s is of DataObject type 'alias', otherwise 0."""

        return self._is_type('alias', s)

    def has_child(self, s):

        """Returns 1 if s is of DataObject type 'child', otherwise 0."""

        return self._is_type('child', s)

    def has_detail(self, s):

        """Returns 1 if s is of DataObject type 'detail', otherwise 0."""

        return self._is_type('detail', s)

    def has_genre(self, s):

        """Returns 1 if s is of DataObject type 'genre', otherwise 0."""

        return self._is_type('genre', s)

    def has_label(self, s):

        """Returns 1 if s is of DataObject type 'label', otherwise 0."""

        return self._is_type('label', s)

    def has_parent(self, s):

        """Returns 1 if s is of DataObject type 'parent', otherwise 0."""

        return self._is_type('parent', s)

    def has_profile(self, s):

        """Returns 1 if s is of DataObject type 'profile', otherwise 0."""

        return self._is_type('profile', s)

    def has_resource(self, s):

        """Returns 1 if s is of DataObject type 'resource', otherwise 0."""

        return self._is_type('resource', s)

    def has_schema(self, s):

        """Returns 1 if s is of DataObject type 'schema', otherwise 0."""

        return self._is_type('schema', s)

    def has_server(self, s):

        """Returns 1 if s is of DataObject type 'server', otherwise 0."""

        return self._is_type('server', s)

    def has_service(self, s):

        """Returns 1 if s is of DataObject type 'service', otherwise 0."""

        return self._is_type('service', s)

    def has_type(self, s):

        """Returns 1 if s is of DataObject type 'type', otherwise 0."""

        return self._is_type('type', s)


########################################################################


    def dumpDataGroups(self):

        """Prints dump of the current DataObject instance DataGroups."""

        nDataGroups = 0
        indent = 0

        print "Dump for DataObject doi:" + self.doi + "\n"
        print "DataMap = " + self.dataMap

        nDataGroups = len(re.findall(r'\(', self.dataMap))

        print "DataGroups (" + str(nDataGroups) + ") =\n("
        for s in re.findall(r'\S+', self.dataMap):
    
            if s == "(":
                indent = indent + 1
                print "  " * indent +  "("

            elif s == ")":
                print "  " * indent + ")"
                indent = indent - 1

            else:
                a = self.dataObject[int(s)]
                print "  " * indent + "  " + a[0] + " => " + a[1]

        print ")\n"
 


########################################################################


    def _getDataFromStore(self):

        # sData = self._getDataValues()
        # print sData

        self._getDataValues()
        sData = self.data

        self.dataObject = {}
        self.dataTypes = {}
        self.dataMap = ""
        self.dataIndex = 0

        for line in string.split(sData, "\n"):

            # On a dataGroup open tag 

            if re.match(r'<dataGroup>', line):
                self.dataMap = self.dataMap + " ("

            # On a dataGroup close tag 

            if re.match(r'</dataGroup>', line):
                self.dataMap = self.dataMap + " )"

            # The only other lines for parsing are the data elements

            # Note - these substitutions should be global
            line = re.sub(r'&lt;', '<', line)
            line = re.sub(r'&gt;', '>', line)
            line = re.sub(r'&amp;', '&', line)
            match = re.match(r'<data type=.(\w+).>(.*?)<\/data>', line)
            if match:

                # Add the element type/data pair to the self.dataObject hash

                (type, data) = match.group(1, 2)

                a = [ type, data ]
                self.dataObject[self.dataIndex] = a
                self.dataMap = self.dataMap + " " + str(self.dataIndex)
                self.dataIndex = self.dataIndex + 1
 
                # Push the data onto the self.dataTypes hash
                if self.dataTypes.has_key(type):
                    a = self.dataTypes[type]
                else:
                    a = []
                a.append(data)
                self.dataTypes[type] = a

                self.dataMap = string.strip(self.dataMap)

                # _setDataValuesByType


########################################################################


    def _putDataToStore(self, request):

        sData = ""

        sData = sData + "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n"
        sData = sData + "<dataObject doi=\"" + self.doi + "\" request=\"" + request + "\">\n"

        for s in re.findall(r'\S+', self.dataMap):
    
            if s == "(":
                sData = sData + "<dataGroup>\n"

            elif s == ")":
                sData = sData + "</dataGroup>\n"

            else:
                (type, data) = self.dataObject[int(s)]
                sData = sData + "<data type=\"" + type + "\">" + data + "</data>\n"

        sData = sData + "</dataObject>\n"
 
        self._setDataValues(sData)

        print self.data




########################################################################


    def _metadata(self, profile, auth, action):

        doiProfile = re.sub(r'^doi:', '', profile)
        d = DataObject(doiProfile)
        d.readDataStore()

        match = re.match(r'^http:\/\/(.*?)(\/.*?)$', d.services()[0])
        server = match.group(1)
        path = match.group(2) + "?id=" + self.doi + "&pid=" + auth + "&sid=null:null"

        if action:
            self._getMetaData(server, path)
        else:
            return "http://" + server + path


    def getUsername(self):

        return self.authUsername


    def setUsername(self, username):

        self.authUsername = username


    def getPassword(self):

        return self.authPassword


    def setPassword(self, password):

        self.authPassword = password


    def kernelMetadata(self, *profile):
    
        """Return kernel metadata in XML format for the current DataObject
        instance."""

        if profile:
            profile = profile[0]
        else:
            profile = self.profiles()[0]
        auth = "guest:guest"

        self._metadata(profile, auth, 1)
        return self.data


    def kernelMetadataService(self, *profile):
    
        """Return the kernel metadata service for the current DataoObject
        instance."""

        if profile:
            profile = profile[0]
        else:
            profile = self.profiles()[0]
        self._metadata(profile, None, 0)


    def profileMetadata(self, *profile):
    
        """Return application profile metadata in XML format for the current DataObject
        instance."""

        if profile:
            profile = profile[0]
        else:
            profile = self.profiles()[0]
        auth = self.authUsername + ':' + self.authPassword
        self._metadata(profile, auth, 1)
        return self.data


    def profileMetadataService(self, *profile):
    
        """Return the application profile metadata service for the current DataoObject
        instance."""

        if profile:
            profile = profile[0]
        else:
            profile = self.profiles()[0]
        self._metadata(profile, None, 0)


########################################################################  


    def _getDataValues(self):

        server = self.DOI_SERVICE_SERVER
        path = self.DOI_SERVICE_PATH + "?doi=" + self.doi + "&xml=true"
        
        self._getXMLFromService(server, path)

    
    def _setDataValues(self, data):

        server = self.DOI_SERVICE_SERVER
        path = self.DOI_SERVICE_PATH + "?data="
        path = path + urllib.quote_plus(data)

        self._getXMLFromService(server, path)


    def _getMetaData(self, server, path):

        self._getXMLFromService(server, path)

    def _getXMLFromService(self, server, path):

        h = httplib.HTTP(server)
        h.putrequest('GET', path)
        h.putheader('Accept', 'text/html')
        h.putheader('Accept', 'text/plain')
        h.endheaders()
        errcode, errmsg, headers = h.getreply()
        f = h.getfile()
        data = f.read()
        f.close

        if errmsg == "OK":
            self.data = data
            # return data
        

########################################################################


    def addDataGroup(self, dataGroup, *profiles):

        """Adds dataGroup to this DataObject instance with an optional
        DOI application profile profile. If no profile is specified
        the default application profile will be assigned."""

        indexProfile = 0

        if profiles:
            profile = profiles[0]
        else:
            profile = 'doi:10.system/profile.zero'

        # See whether we need to add in a value for the profile

        if not ( self.dataTypes.has_key('profile') \
               and profile in self.dataTypes['profile'] ):

            # Husk: Make check that profile is legitimate

            self.dataObject[self.dataIndex] = [ 'profile', profile ]
            indexProfile = self.dataIndex 
            self.dataIndex = self.dataIndex + 1

            self.dataTypes['profile'] = profile
            self.profiles = self.dataTypes['profile']

        else:
            for index in self.dataObject.keys():
                (type, data) = self.dataObject[index]
                if type == 'profile' and data == profile:
                    indexProfile = index 
                    break

        #

        self.dataMap = self.dataMap +  " ( " + str(indexProfile)

        for dataElement in self.dataGroup.getData:

            (type, data) = dataElement
            if type == 'dataGroup':
                self.addDataGroup(data)
                continue

            self.dataObject[self.dataIndex] = dataElement
            self.dataMap = self.dataMap +  " ( " + str(self.dataIndex)
            self.dataIndex = self.dataIndex + 1


        self.dataMap = self.dataMap +  " )"


########################################################################

# Minor class for aggregating data into data groups

class DataGroup:

    def __init__(self):

      self.dataGroup = []


    def addDataGroup(self, dataGroup):

      self.dataGroup  = self.dataGroup + [ 'dataGroup', dataGroup ]


    def addData(self, type, data):

      self.dataGroup  = self.dataGroup + [ type, data ]


    def getData(self):

      self.dataGroup


    # alias readData getData

    def clearData(self):

      self.dataGroup.clear()


   # alias clear clearData


########################################################################


def _test():

    print "dataObject.py"
    d = DataObject("10.1006/jmbi.2000.4282")
    print d.__doc__
    d.readDataStore()
    
    # d.dumpDataGroups()
    print d.profileMetadata()
    
    # d.dumpDataGroups()
    # d.createDataStore()

if __name__ == '__main__':
    _test()
