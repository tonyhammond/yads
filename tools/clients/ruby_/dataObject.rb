#######################################################################
#
# doi/dataObject - A Ruby class for manipulating DOI DataObjects
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
#
########################################################################

require 'net/http'
require 'cgi'

########################################################################

class DataObject

  attr_writer :doi, :authUsername, :authPassword
  attr_reader :doi, :authUsername, :authPassword,
              :accesses, :agents, :aliases, :details, :labels,
              :nulls, :profiles, :relations, :roles, :resources, :schemas,
              :services, :types

  # DOI_SERVICE_HOST = "www2.harcourt-international.com"
  DOI_SERVICE_HOST = "193.122.198.4"
  DOI_SERVICE_PATH   = "/ap/servlet/yads"

  RDF_SYNTAX_SCHEMA = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  DOI_OBJECT_SCHEMA = "doi:1014/10.1000/system.schema.2001-07-26#"

  DATA_STORE_CALL_FETCH  = "fetchDataStore"
  DATA_STORE_CALL_ADD    = "addDataStore"
  DATA_STORE_CALL_CREATE = "createDataStore"
  DATA_STORE_CALL_DELETE = "deleteDataStore"
  DATA_STORE_CALL_MODIFY = "modifyDataStore"
  DATA_STORE_CALL_REMOVE = "removeDataStore"

  @@dataObjectTypes = [
        "accesses", "agents", "aliases", "details", "labels",
        "nulls", "profiles", "relations", "roles", "resources", "schemas",
        "services", "types" ]
  
  @@nDataObjects = 0

  # DataObject constructor

  def initialize(doi)

    @@nDataObjects += 1 
    @nDataObject = @@nDataObjects

    @doi = doi		# DOI for this DataObject
    @doi.sub!(/^doi:/, '') # Remove any URI scheme prefix

    @dataObject = {}	# Data element type/value pairs keyed on index
    @dataTypes = {}	# Hash keyed on data type with list of data values

    @dataIndex = 0	# Next available index for dataObject hash
    @dataMap = ""	# Map of indexes within DataGroups
 
    @authUsername = ""
    @authPassword = ""

    self

  end

  # Convenience constructor - Initializes DataObject with DataStore values

  def DataObject.get(*doi)

    # doi = '?' unless doi
    d = DataObject.new(doi[0])
    d.readDataStore

  end

  # Wrapper for fetch from DataStore

  def readDataStore(*types)

    _getDataFromStore(@doi, *types)
    return self

  end

  # Wrapper for put to DataStore

  def writeDataStore(request)

    _putDataToStore(request)
    return self

  end

  # Convenience wrappers for specific writeDataStore methods

  def addDataStore 

    writeDataStore(DATA_STORE_CALL_ADD) 

  end

  def createDataStore

    writeDataStore(DATA_STORE_CALL_CREATE)

  end

  def deleteDataStore

    writeDataStore(DATA_STORE_CALL_DELETE);

  end

  def modifyDataStore

    writeDataStore(DATA_STORE_CALL_MODIFY)

  end

  def removeDataStore

    writeDataStore(DATA_STORE_CALL_REMOVE)

  end


########################################################################


  # Class method returning allowed types

  def DataObject.types

    @@dataObjectTypes

  end


  # Accessor method for all @dataTypes

  def dataTypes

    return @dataTypes.keys

  end


  # Accessor method for all @dataValues

  def dataValues(*types)

    a = []

    @dataTypes.keys.each do |type|
      if types.length > 0
        a << @dataTypes[type] if types.include?(type)
      else
        a << @dataTypes[type]
      end
    end

    return a

  end


  # Set accessor methods for individual types

  def _setDataValuesByType

    @accesses = @dataTypes['access']
    @agents = @dataTypes['agent']
    @aliases = @dataTypes['alias']
    @details = @dataTypes['detail']
    @labels = @dataTypes['label']
    @nulls = @dataTypes['null']
    @profiles = @dataTypes['profile']
    @relations = @dataTypes['relation']
    @resources = @dataTypes['resource']
    @roles = @dataTypes['role']
    @schemas = @dataTypes['schema']
    @services = @dataTypes['service']
    @types = @dataTypes['type']

  end
  private :_setDataValuesByType

  # Define a set of type test methods

  def access?(s) @dataTypes['access'].include?(s) end
  def agent?(s) @dataTypes['agent'].include?(s) end
  def alias?(s) @dataTypes['alias'].include?(s) end
  def detail?(s) @dataTypes['detail'].include?(s) end
  def label?(s) @dataTypes['label'].include?(s) end
  def null?(s) @dataTypes['null'].include?(s) end
  def profile?(s) @dataTypes['profile'].include?(s) end
  def relation?(s) @dataTypes['relation'].include?(s) end
  def resource?(s) @dataTypes['resource'].include?(s) end
  def role?(s) @dataTypes['role'].include?(s) end
  def schema?(s) @dataTypes['schema'].include?(s) end
  def service?(s) @dataTypes['service'].include?(s) end
  def type?(s) @dataTypes['type'].include?(s) end


########################################################################


  def dataGroups

    a = []
    level = 0
   
    @dataMap.scan(/\S+/).each do |s|

      case s

        when "("
          # if block_given? yield end
          level += 1
          

        when ")"
          level -= 1

        else

          (type, data) = @dataObject[s.to_i]
          a << [ level, type, data ]
      
      end
  
    end

    return a

  end


  def dumpDataMap

    print "DataMap = #{@dataMap}\n"

  end


  def dumpDataGroups

    nDataGroups = 0
    indent = -1

    print "Dump for #{@doi}\n\n"
    print "DataMap = #{@dataMap}\n\n"

    @dataMap.scan(/\(/).each { |n| nDataGroups += 1 }

    print "DataGroups (#{nDataGroups}) =\n"
    @dataMap.scan(/\S+/).each do |s|

      case s

        when /[({[<]/
          indent += 1
          print "  " * indent, "#{s}\n"

        when /[)}\]>]/
          print "  " * indent, "#{s}\n"
          indent -= 1

        else
         (type, data) = @dataObject[s.to_i]
         data.gsub!(/&lt;/, "<") 
         data.gsub!(/&gt;/, ">") 
         data.gsub!(/&amp;/, "&") 
         print "  " * indent, "  #{type} => #{data}\n"

      end

    end
 
  end

  alias dump dumpDataGroups


########################################################################

  def from_s(str)

    @dataObject = {}
    @dataTypes = {}
    @dataMap = ""
    @dataIndex = 0

    str.each do |line|

      # On the dataObject open tag 

      if line[/<doi:Object rdf:about=['"](.*?)['"]>/]

        @doi = $1
        next

      end

      # On RDF container and anonymous resource open tags

      @dataMap << " {" if line[/<rdf:Bag>/]
      @dataMap << " [" if line[/<rdf:Seq>/]
      @dataMap << " <" if line[/<rdf:Alt>/]
      @dataMap << " (" if line[/<rdf:li rdf:parseType="Resource">/]

      # On RDF container and anonymous resource close tags

      @dataMap << " }" if line[/<\/rdf:Bag>/]
      @dataMap << " ]" if line[/<\/rdf:Seq>/]
      @dataMap << " >" if line[/<\/rdf:Alt>/]
      @dataMap << " )" if line[/<\/rdf:li>/]

      # Skip the DOI container properties

      next if line[/<doi:contains>/]
      next unless line[/<doi:/]

      # The only other lines for parsing are the data elements

      line.gsub!(/&lt;/, '<')
      line.gsub!(/&gt;/, '>')
      line.gsub!(/&amp;/, '&')

      if line[/<doi:(\w+)>(.*?)<\/doi:\w+>/]
          
        type = $1; data = $2

      end

      if line[/<doi:(\w+) rdf:resource=['"](.*?)['"]\/>/]
          
        type = $1; data = $2

      end

      # Add the element type/data pair to the @dataObject hash

      a = [ type, data ]
      @dataObject[@dataIndex] = a
      @dataMap << " #{@dataIndex}"
      @dataIndex +=1
 
      # Push the data onto the @dataTypes hash

      a = @dataTypes[type] ? @dataTypes[type] : []
      a << data 
      @dataTypes[type] = a

    end

    @dataMap.strip!

    _setDataValuesByType

    self

  end

  alias from_str from_s

  def to_s

    indent = 0
    sData = ""

    sData << "<rdf:RDF\n"
    sData << "  xmlns:rdf=\"" + RDF_SYNTAX_SCHEMA + "\"\n"
    sData << "  xmlns:doi=\"" + DOI_OBJECT_SCHEMA + "\"\n"
    sData << ">\n"

    sData << "<doi:Object rdf:about=\"doi:#{@doi}\">\n"

    @dataMap.scan(/\S+/).each do |s|

      case s

        when "{"
          indent += 1
          sData << "  " * indent << "<doi:contains>\n"
          indent += 1
          sData << "  " * indent << "<rdf:Bag>\n"

        when "}"
          sData << "  " * indent << "</rdf:Bag>\n"
          indent -= 1
          sData << "  " * indent << "</doi:contains>\n"
          indent -= 1

        when "["
          indent += 1
          sData << "  " * indent << "<doi:contains>\n"
          indent += 1
          sData << "  " * indent << "<rdf:Seq>\n"

        when "]"
          sData << "  " * indent << "</rdf:Seq>\n"
          indent -= 1
          sData << "  " * indent << "</doi:contains>\n"
          indent -= 1

        when "<"
          indent += 1
          sData << "  " * indent << "<doi:contains>\n"
          indent += 1
          sData << "  " * indent << "<rdf:Alt>\n"

        when ">"
          sData << "  " * indent << "</rdf:Alt>\n"
          indent -= 1
          sData << "  " * indent << "</doi:contains>\n"
          indent -= 1

        when "("
          indent += 1
          sData << "  " * indent << "<rdf:li rdf:parseType=\"Resource\">\n"

        when ")"
          sData << "  " * indent << "</rdf:li>\n"
          indent -= 1

        else
          (type, data) = @dataObject[s.to_i]

          data.gsub!(/</, '&lt;')
          data.gsub!(/>/, '&gt;')
          data.gsub!(/&/, '&amp;')

          case type
            when /access|detail|label|role|type/
              sData << "  " * indent << "  <doi:#{type}>#{data}</doi:#{type}>\n"
            else
              sData << "  " * indent << "  <doi:#{type} rdf:resource=\"#{data}\"/>\n"
          end

      end

    end

    sData << "</doi:Object>\n"
    sData << "</rdf:RDF>\n"

  end


########################################################################


  def _getDataFromStore(doi, *types)

    self.from_s(_getDataValues(doi))
    
  end
  private :_getDataFromStore


########################################################################


  def _putDataToStore(request)

    sData = ""

    sData << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    sData << "<SOAP-ENV:Envelope\n"
    sData << "  xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
    sData << "  SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"\n"
    sData << ">\n"
    sData << "<SOAP-ENV:Body>\n"
    sData << "<DOI-SERVICE:#{request}\n"
    sData << "  xmlns:DOI-SERVICE=\"http://dx.doi.org/1014/doi.service\"\n"
    sData << ">\n"
    sData << self.to_s
    sData << "</DOI-SERVICE:#{request}>\n"
    sData << "</SOAP-ENV:Body>\n"
    sData << "</SOAP-ENV:Envelope>\n"

    # print sData

    print _setDataValues(sData)

  end
  private :_putDataToStore


########################################################################


  def _metadata(profile, pid, action)

    doiProfile = profile.sub(/^doi:/, '')
    d = DataObject.get(doiProfile)

    return nil if d.resolvers == []
    d.resolvers[0] =~ /^http:\/\/(.*?)(\/.*?)$/
    host = $1
    path = "#{$2}?id=" + @doi.sub(/^1014\//, "") + "&pid=#{pid}&sid=null:null"

    if action
      _getMetaData(host, path)
    else
      "http://#{host}#{path}"
    end

  end
  private :_metadata


  def kernelMetadata(*profile)
  
    profile = @profiles[0] if profile == []
    auth = "guest:guest"

    _metadata(profile, auth, true)

  end

  def kernelMetadataService(*profile)
  
    profile = @profiles[0] if profile == []

    _metadata(profile, nil, false)

  end

  def profileMetadata(*profile)
  
    profile = @profiles[0] if profile == []
    auth = @authUsername + ':' + @authPassword

    _metadata(profile, auth, true)

  end

  def profileMetadataService(*profile)
  
    profile = @profiles[0] if profile == []
    _metadata(profile, nil, false)

  end


########################################################################  


  def _getDataValues(doi)

    host = DOI_SERVICE_HOST
    path = DOI_SERVICE_PATH + "?doi=#{doi}&xml=true"
    
    _getXMLFromService(host, path)

  end
  private :_getDataValues


  def _setDataValues(sData)

    host = DOI_SERVICE_HOST
    path = DOI_SERVICE_PATH
    data = "data=" + CGI.escape(sData)
    
    _getXMLFromService(host, path, data)
  end

  private :_setDataValues


  def _getMetaData(host, path)

    _getXMLFromService(host, path)
    
  end
  private :_getMetaData


  def _getXMLFromService(host, path, *post_data)

    s = Net::HTTP.new(host, 80)
    post = post_data[0]
    if post_data.empty?
      resp, data = s.get(path, nil)
    else
      headers = {}
      headers["Content-Type"] = "application/x-www-form-urlencoded"
      resp, data = s.post(path, post, headers)
    end

    return data if resp.message == "OK"
    
  end
  private :_getXMLFromService


########################################################################


  def addContainer(dataGroup, *profile)

    indexProfile = 0

    profile = profile.empty? ? 'doi:1014/10.1000/system.profile.zero' \
                              : profile[0]

    # See whether we need to add in a value for the profile

    unless @dataTypes.key?('profile') \
           and @dataTypes['profile'].include?(profile)

      # Husk: Make check that profile is legitimate

      @dataObject[@dataIndex] = [ 'profile', profile ]
      indexProfile = @dataIndex 
      @dataIndex += 1

      @dataTypes['profile'] = profile
      @profiles = @dataTypes['profile']

    else

      @dataObject.keys.each do |index|
        (type, data) = @dataObject[index]
        if type == 'profile' and data == profile
          indexProfile = index 
          break
        end
      end

    end

    #

    @dataMap << " { ( #{indexProfile} "

    _addContainer(dataGroup)

    @dataMap << " ) }"
  end

  def _addContainer(dataGroup)

    o_delim = c_delim = ""

    dataGroup.getData.each do |dataElement|

      (type, data) = dataElement
      if type == 'ordering'
        case data

          when "alt"
            o_delim = '<'; c_delim = '>'

          when "bag"
            o_delim = '{'; c_delim = '}'

          when "seq"
            o_delim = '['; c_delim = ']'

        end
        @dataMap << " #{o_delim}"
        next
      end

      if type == 'contains'
        _addContainer(data)
        next
      end

      if type == 'dataGroup'
        @dataMap << " ("
        _addContainer(data)
        @dataMap << ")"
        next
      end

      @dataObject[@dataIndex] = dataElement
      @dataMap << " #{@dataIndex}"
      @dataIndex += 1

    end

    @dataMap << " #{c_delim}"

    self

  end

########################################################################

  def DataObject.methods

# =begin
#     print public_class_method
#     DataObject.public_class_method.each do |method|
#       print "#{method} (class)\n"
#     end
# =end
 
    print <<EOT
Class Methods:

  DataObject.get
  DataObject.methods
  DataObject.new
  DataObject.types

Instance Methods:

EOT

    public_instance_methods.sort.each do |method|
      print "  DataObject##{method}\n"
    end
 
  end


end

########################################################################


# Minor class for aggregating data into data groups

class DataGroup

  def initialize 

    @dataGroup = []
    self

  end


  def addContainer(container)

    @dataGroup << [ 'contains', container ]
    self

  end

  def addData(type, data)

    @dataGroup << [ type, data ]
    self

  end

  def getData

    @dataGroup

  end

 alias readData getData

  def clearData

    @dataGroup.clear

  end

 alias clear clearData

end


########################################################################


# Minor class for aggregating data into data groups

class Container < DataGroup

  def initialize(*ordering)

    super()
    ordering = ordering.empty? ? 'bag' : ordering[0]

    @dataGroup << [ 'ordering', ordering ]
        
    self

  end

  def addDataGroup(dataGroup)

    @dataGroup << [ 'dataGroup', dataGroup ]
    self

  end

end


__END__
########################################################################
=begin

= DataObject Class

= Synopsis

  require "doi"

  d = DataObject.new("10.1006/jmbi.2000.4282")
  d.readDataStore
  puts d.resources

= Description

The DataObject Class is a Ruby class for managing (({DataObject})) objects.
These DataObjects are transient computational structures with persistent network
identifiers which manage data elements relating to intellectual property
entities. These data elements are organized into DataGroups which are bound 
through an application profile to applications that can service (or otherwise
meaningfully interpret) them.

= Class Methods

--- DataObject.get( doi )
    Constructs a new DataObject with identifier ((|doi|)) and populates
    it with DataGroups fetched from a DataObject copy within the DataStore.
    Equivalent to the following call sequence:

    (({d = DataObject.new( doi ).readDataStore}))

--- DataObject.new( doi )
    Constructs a new DataObject with identifier ((|doi|)).

--- DataObject.methods
    Prints list of DataObject class and instance methods.

--- DataObject.types
    Returns list of known DataObject class data types.

= Instance Methods

--- DataObject#addDataGroup( dataGroup, profiles*)
    Adds ((|dataGroup|)) to this DataObject instance with an optional
    DOI application profile ((|profile|)). If no ((|profile|)) is specified
    the default application profile will be assigned.

--- DataObject#addDataStore
    Adds the DataGroups present in the current DataObject instance to the
    persisted DataObject copy within the DataStore.
     
--- DataObject#access?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'access',
    otherwise false.
 
--- DataObject#accesses
    Returns list of data values of DataObject type 'access' for the current
    DataObject instance.

--- DataObject#agent?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'agent',
    otherwise false.
 
--- DataObject#agents
    Returns list of data values of DataObject type 'agent' for the current
    DataObject instance.

--- DataObject#alias?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'alias',
    otherwise false.

--- DataObject#aliases
    Returns list of data values of DataObject type 'alias' for the current
    DataObject instance.

--- DataObject#createDataStore
    Creates a persisted instance of the current DataObject within the DataStore.

--- DataObject#dataGroups
    Returns the DataGroups within the current DataObject instance.

--- DataObject#dataTypes
    Returns the DataObject types within the current DataObject instance.

--- DataObject#dataValues( *types )
    Returns the DataObject values within the current DataObject instance. If an
    optional ((|types|)) list is provided then restrict the DataObject values 
    to those of specified type(s).

--- DataObject#deleteDataStore
    Deletes the persisted copy of the current DataObject instance within the DataStore.

--- DataObject#detail?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'detail',
    otherwise false.

--- DataObject#details
    Returns list of data values of DataObject type 'detail' for the current
    DataObject instance.

--- DataObject#doi
    Returns the ((|doi|)) identifier for this DataObject instance.

--- DataObject#dump
    Alias for ((|#dumpDataGroups|)).

--- DataObject#dumpDataGroups
    Prints dump of the current DataObject instance DataGroups.

--- DataObject#kernelMetadata
    Return kernel metadata in XML format for the current DataObject instance.

--- DataObject#kernelMetadataService
    Return the kernel metadata service for the current DataoObject instance.

--- DataObject#label?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'label',
    otherwise false.

--- DataObject#labels
    Returns list of data values of DataObject type 'label' for the current
    DataObject instance.

--- DataObject#modifyDataStore
    Replaces DataGroups in the persisted DataObject copy within the DataStore
    with the DataGroups present within the current DataObject instance.
 
--- DataObject#null?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'null',
    otherwise false.

--- DataObject#nulls
    Returns list of data values of DataObject type 'null' for the current
    DataObject instance.

--- DataObject#profile?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'agent',
    otherwise false.

--- DataObject#profileMetadata
    Return application profile metadata in XML format for the current DataObject
    instance.

--- DataObject#profileMetadataService
    Return the application profile metadata service for the current DataoObject
    instance.

--- DataObject#profiles
    Returns list of data values of DataObject type 'profile' for the current
    DataObject instance.

--- DataObject#readDataStore( doi )
    Retrieves DataGroups from the persisted DataObject within the DataStore
    identified by ((|doi|)) and use them to populate the current DataObject
    instance.

--- DataObject#removeDataStore
    Removes from the persisted DataObject copy within the DataStore the DataGroups
    present within the current DataObject instance.

--- DataObject#relation?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'relation',
    otherwise false.

--- DataObject#relations
    Returns list of data values of DataObject type 'relation' for the current
    DataObject instance.

--- DataObject#resource?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'resource',
    otherwise false.

--- DataObject#resources
    Returns list of data values of DataObject type 'resource' for the current
    DataObject instance.

--- DataObject#role?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'role',
    otherwise false.

--- DataObject#roles
    Returns list of data values of DataObject type 'role' for the current
    DataObject instance.

--- DataObject#schema?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'schema',
    otherwise false.

--- DataObject#schemas
    Returns list of data values of DataObject type 'schema' for the current
    DataObject instance.

--- DataObject#service?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'service',
    otherwise false.

--- DataObject#services
    Returns list of data values of DataObject type 'service' for the current
    DataObject instance.

--- DataObject#type?( string )
    Returns ((|true|)) if ((|string|)) is of DataObject type 'type',
    otherwise false.

--- DataObject#types
    Returns list of data values of DataObject type 'type' for the current
    DataObject instance.

--- DataObject#writeDataStore( request )
    Generic method for modifying a DataObject copy within the DataStore with the
    DataGroups present within the current DataObject instance. The ((|request|)) argument 
    specifies the type of operation. Convenience methods are provided, see also
    ((|#addDataStore|)), ((|#createDataStore|)), ((|#deleteDataStore|)), ((|#modifyDataStore|)),
    and ((|#removeDatatore|)).

=end
