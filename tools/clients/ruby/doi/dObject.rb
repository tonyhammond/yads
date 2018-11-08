#######################################################################
#
# doi/dObject - A Ruby class for manipulating DOI DObjects
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
#
########################################################################

require 'net/http'
require 'cgi'
require 'dObjectTypes'

########################################################################

class DObject

  attr_writer :doi
  attr_reader :doi,
              # General type accessors
              :accesses, :details, :labels,
              :resolves, :roles, :resources, :types,
              # System-specific type accessors
              :agents, :nulls, :profiles,
              :schemas, :services

  DOI_PROFILE_ZERO = "doi:1014/10.system/profile.zero"
  DOI_PROFILE_BASE = "doi:1014/10.system/profile.base"
  DOI_PROFILE_XREF = "doi:1014/10.system/profile.crossref"

  DOI_PROFILE_DEFAULT = DOI_PROFILE_ZERO

  # DOI_SERVICE_HOST = "www2.harcourt-international.com"
  DOI_SERVICE_HOST = "193.122.198.4"
  DOI_SERVICE_PATH = "/ap/servlet/yads"

  RDF_SYNTAX_SCHEMA = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  DOI_OBJECT_SCHEMA = "doi:1014/10.system/schema.2001-07-26#"

  DOI_SERVICE = "http://dx.doi.org/1014/doi.service"
  SOAP_ENV_SCHEMA = "http://schemas.xmlsoap.org/soap/envelope/"
  SOAP_ENC_SCHEMA = "http://schemas.xmlsoap.org/soap/encoding/"

  DOI_OBJECT_STORE_CREATE = "createDObjectStore"
  DOI_OBJECT_STORE_DELETE = "deleteDObjectStore"
  DOI_OBJECT_STORE_READ   = "readDObjectStore"
  DOI_OBJECT_STORE_WRITE  = "writeDObjectStore"

  @@dataObjectTypes = [
        "accesses", "agents", "details", "labels",
        "nulls", "profiles", "resolves", "resources", "roles", "schemas",
        "services", "types" ]
  
  @@nDObjects = 0

  # DObject constructor

  def initialize(*doi)

    @@nDObjects += 1 
    @nDObject = @@nDObjects

    @doi = doi[0]	# DOI for this DObject
    if @doi
      @doi.sub!(/^doi:/, "") # Remove any URI scheme prefix
    end

    @dataObject = {}	# Data element type/value pairs keyed on index
    @dataTypes = {}	# Hash keyed on data type with list of data values

    @dataIndex = 0	# Next available index for dataObject hash
    @dataMap = ""	# Map of indexes within Groups
 
    return self

  end

  # Convenience constructor - Initializes DObject with DObjectStore values

  def DObject.get(*doi)

    # doi = '?' unless doi
    d = DObject.new(doi[0])
    d.readDObjectStore

  end

  # Wrapper for read from DObjectStore

  def readDObjectStore

    _getDataFromStore(@doi)
    return self

  end

  # Wrapper for put to DObjectStore

  def _writeDObjectStore(request)

    _putDataToStore(request)
    return self

  end

  # Convenience wrappers for specific _writeDObjectStore methods

  def createDObjectStore

    _writeDObjectStore(DOI_OBJECT_STORE_CREATE)

  end

  def deleteDObjectStore

    _writeDObjectStore(DOI_OBJECT_STORE_DELETE);

  end

  def writeDObjectStore 

    _writeDObjectStore(DOI_OBJECT_STORE_WRITE) 

  end


########################################################################


  # Class method returning allowed types

  def DObject.types

    @@dataObjectTypes

  end


  # Accessor method for all @dataTypes

  def memberTypes

    return @dataTypes.keys

  end


  # Accessor method for all @dataValues

  def memberValues(*types)

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

    # Set general accessors

    @accesses = @dataTypes['access']
    @details = @dataTypes['detail']
    @labels = @dataTypes['label']
    @resolves = @dataTypes['resolve']
    @resources = @dataTypes['resource']
    @roles = @dataTypes['role']
    @types = @dataTypes['type']

    # Set system-specific accessors

    @agents = @dataTypes['agent']
    @nulls = @dataTypes['null']
    @profiles = @dataTypes['profile']
    @schemas = @dataTypes['schema']
    @services = @dataTypes['service']

  end
  private :_setDataValuesByType

  # Define general (ie application and system) type test methods

  def access?(s) @dataTypes['access'].include?(s) end
  def detail?(s) @dataTypes['detail'].include?(s) end
  def label?(s) @dataTypes['label'].include?(s) end
  def resolve?(s) @dataTypes['resolve'].include?(s) end
  def resource?(s) @dataTypes['resource'].include?(s) end
  def role?(s) @dataTypes['role'].include?(s) end
  def type?(s) @dataTypes['type'].include?(s) end

  # Define system-specific type test methods

  def agent?(s) @dataTypes['agent'].include?(s) end
  def null?(s) @dataTypes['null'].include?(s) end
  def profile?(s) @dataTypes['profile'].include?(s) end
  def schema?(s) @dataTypes['schema'].include?(s) end
  def service?(s) @dataTypes['service'].include?(s) end

########################################################################


  def Groups(*args)

    typeMatch = ""; dataMatch = ""
    if args.length > 1
      typeMatch = args[0]; dataMatch = args[1]
    elsif args.length > 0
      typeMatch = args[0]
    end
 
    i = 0
    groups = []; groups[0] = []
   
    @dataMap.scan(/\S+/).each do |s|

      case s

        when /[{\[<]/

        when /[}\]>]/

        when "("
          i += 1
          groups[i] = []

        when ")"

        else

          (type, data) = @dataObject[s.to_i]
          groups[i] << [ type, data ]
      
      end
  
    end

    a = []
    groups.each do |group|
      addGroup = false
      group.each do |type, data|
        if typeMatch.length > 0
          if type =~ /#{typeMatch}/
            if dataMatch.length > 0
              addGroup = true if data =~ /#{dataMatch}/
            else
              addGroup = true
            end
          end
        else
          addGroup = true
        end
      end
      a << group if addGroup
    end

    return a

  end

  def dumpMap

    print "DObject Map = #{@dataMap}\n"

  end


  def dumpGroups

    print "Dump for <doi:#{@doi}>\n\n"
    print "DObject Map = #{@dataMap}\n\n"

    puts self.to_s

  end

  alias dump dumpGroups

  def copy(d)
  
    self.from_xml(d.to_xml)

  end

  def to_s

    sData = "DObject <doi:#{@doi}> =>\n"
    indent = -1

    @dataMap.scan(/\S+/).each do |s|

      case s

        when /[({\[<]/
          indent += 1
          sData << "  " * indent << "#{s}\n"

        when /[)}\]>]/
          sData << "  " * indent << "#{s}\n"
          indent -= 1

        else
         (type, data) = @dataObject[s.to_i]

         data.gsub!(/&lt;/, "<") 
         data.gsub!(/&gt;/, ">") 
         data.gsub!(/&amp;/, "&") 

         if DObjectTypes.is_rdf_literal?(type)
           sData << "  " * indent << "  #{type} => \"#{data}\"\n"
         else
           sData << "  " * indent << "  #{type} => <#{data}>\n"
         end

      end

    end
 
    sData

  end


########################################################################

  def from_xml(str)

    @dataObject = {}
    @dataTypes = {}
    @dataMap = ""
    @dataIndex = 0

    str.each do |line|

      # On the dataObject open tag 

      if line =~ /<doi:DObject rdf:about=['"](.*?)['"]>/

        @doi = $1
        @doi.sub!(/^doi:/, "") # Remove any URI scheme prefix
        next

      end

      # On RDF container and anonymous resource open tags

      @dataMap << " {" if line =~ /<rdf:Bag>/
      @dataMap << " [" if line =~ /<rdf:Seq>/
      @dataMap << " <" if line =~ /<rdf:Alt>/
      @dataMap << " (" if line =~ /<rdf:li rdf:parseType="Resource">/

      # On RDF container and anonymous resource close tags

      @dataMap << " }" if line =~ /<\/rdf:Bag>/
      @dataMap << " ]" if line =~ /<\/rdf:Seq>/
      @dataMap << " >" if line =~ /<\/rdf:Alt>/
      @dataMap << " )" if line =~ /<\/rdf:li>/

      # Skip the DOI container properties

      next if line[/<doi:contains>/]
      next unless line[/<doi:/]

      # The only other lines for parsing are the data elements

      line.gsub!(/&lt;/, '<')
      line.gsub!(/&gt;/, '>')
      line.gsub!(/&amp;/, '&')

      if line =~ /<doi:(\w+)>(.*?)<\/doi:\w+>/
          
        type = $1; data = $2

      end

      if line =~ /<doi:(\w+) rdf:resource=['"](.*?)['"]\/>/
          
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

  alias from_rdf from_xml

  def to_xml

    indent = 0
    sData = ""

    sData << "<rdf:RDF\n"
    sData << "  xmlns:rdf=\"" + RDF_SYNTAX_SCHEMA + "\"\n"
    sData << "  xmlns:doi=\"" + DOI_OBJECT_SCHEMA + "\"\n"
    sData << ">\n"

    sData << "<doi:DObject rdf:about=\"doi:#{@doi}\">\n"

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

          if DObjectTypes.is_rdf_literal?(type)
            sData << "  " * indent << "  <doi:#{type}>#{data}</doi:#{type}>\n"
          else
            sData << "  " * indent << "  <doi:#{type} rdf:resource=\"#{data}\"/>\n"
          end

      end

    end

    sData << "</doi:DObject>\n"
    sData << "</rdf:RDF>\n"

  end

  alias to_rdf to_xml


  def to_n3

    indent = 0
    sData = ""

    sData << "@prefix doi: <" + DOI_OBJECT_SCHEMA + "> .\n"
    sData << "@prefix rdf: <" + RDF_SYNTAX_SCHEMA + "> .\n"
    sData << "\n"

    sData << "<doi:#{doi}> a DObject ;\n"

    @dataMap.scan(/\S+/).each do |s|

      case s

        when "{"
          indent += 1
          sData << "  " * indent << "doi:contains [\n"

        when "}"
          sData << "  " * indent << "a rdf:Bag ] ;\n"
          indent -= 1

        when "["
          indent += 1
          sData << "  " * indent << "doi:contains [\n"

        when "]"
          sData << "  " * indent << "a rdf:Seq ] ;\n"
          indent -= 1

        when "<"
          indent += 1
          sData << "  " * indent << "doi:contains [\n"

        when ">"
          sData << "  " * indent << "a rdf:Alt ] ;\n"
          indent -= 1

        when "("
          indent += 1
          sData << "  " * indent << "rdf:li [\n"

        when ")"
          sData.chomp!; sData.chop!; sData << "\n"
          sData << "  " * indent << "] ;\n"
          indent -= 1

        else
          (type, data) = @dataObject[s.to_i]

          data.gsub!(/</, '&lt;')
          data.gsub!(/>/, '&gt;')
          data.gsub!(/&/, '&amp;')

          if DObjectTypes.is_rdf_literal?(type)
            sData << "  " * indent << "  doi:#{type} \"#{data}\" ;\n"
          else
            sData << "  " * indent << "  doi:#{type} <#{data}> ;\n"
          end

      end

    end

    sData.chomp!; sData.chop!; sData << ".\n"

  end


########################################################################


  def _getDataFromStore(doi)

    self.from_s(_getDataValues(doi))
    
  end
  private :_getDataFromStore


########################################################################


  def _putDataToStore(request)

    sData = ""

    sData << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    sData << "<SOAP-ENV:Envelope\n"
    sData << "  xmlns:SOAP-ENV=\"#{SOAP_ENV_SCHEMA}\"\n"
    sData << "  SOAP-ENV:encodingStyle=\"#{SOAP_ENC_SCHEMA}\"\n"
    sData << ">\n"
    sData << "<SOAP-ENV:Body>\n"
    sData << "<DOI-SERVICE:#{request}\n"
    sData << "  xmlns:DOI-SERVICE=\"#{DOI_SERVICE}\"\n"
    sData << ">\n"
    sData << self.to_xml
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
    d = DObject.get(doiProfile)

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


  def forProfile (*profile)

    # @dataObject = {}
    # @dataTypes = {}
    @dataMap = ""
    @dataIndex = 0

    indexProfile = 0

    # Set zero profile if no profile sepcified

    profile = profile.empty? ? DOI_PROFILE_DEFAULT : profile[0]

    # See whether we need to add in a value for the profile

    unless @dataTypes.key?("profile") \
           and @dataTypes["profile"].include?(profile)

      # Husk: Make check that profile is legitimate

      # @dataIndex += 1
      @dataObject[@dataIndex] = [ "profile", profile ]
      indexProfile = @dataIndex 

      @dataTypes["profile"] = profile
      @profiles = @dataTypes["profile"]

    else

      @dataObject.keys.each do |index|
        (type, data) = @dataObject[index]
        if type == "profile" and data == profile
          indexProfile = index 
          break
        end
      end

    end

    @dataIndex = indexProfile
 
    self

  end

  def setHierarchy(group)

    @dataMap << "{ ( #{@dataIndex}"

    _addContainer(group)

    @dataMap << " ) }"

    self

  end


  def _addContainer(group)

    groupO = ""; groupC = ""

    group.members.each do |member|

      (type, data) = member
      if type == "order"
        case data
          when "alt" then groupO = "<"; groupC = ">"
          when "bag" then groupO = "{"; groupC = "}"
          when "seq" then groupO = "["; groupC = "]"
        end
        @dataMap << " #{groupO}"
        next
      end

      if type == "contains"
        _addContainer(data)
        next
      end

      if type == "group"
        @dataMap << " ("
        _addContainer(data)
        @dataMap << " )"
        next
      end

      @dataIndex += 1
      @dataObject[@dataIndex] = member
      @dataMap << " #{@dataIndex}"

    end

    @dataMap << " #{groupC}" unless groupC.empty?

  end

########################################################################

  def DObject.methods

# =begin
#     print public_class_method
#     DObject.public_class_method.each do |method|
#       print "#{method} (class)\n"
#     end
# =end
 
    print <<EOT
Class Methods:

  DObject.get
  DObject.methods
  DObject.new
  DObject.types

Instance Methods:

EOT

    public_instance_methods.sort.each do |method|
      print "  DObject##{method}\n"
    end
 
  end


end

########################################################################


# Class for aggregating data into data groups

class Group

  attr_reader :members

  def initialize 

    @members = []
    return self

  end


  def addContainer(container)

    @members << [ "contains", container ]
    return self

  end

  def addMember(type, data)

    @members << [ type, data ]
    return self

  end

  def clearGroup

    @members.clear

  end

 alias clear clearGroup

end


########################################################################


# Class for aggregating data into data groups

class Container < Group

  def initialize(*order)

    super()
    order = order.empty? ? "bag" : order[0]

    @members << [ "order", order ]
    return self

  end

  def addGroup(group)

    @members << [ "group", group ]
    return self

  end

end


########################################################################

# Class for aggregating data into data groups

class DObjectInstance

  attr_reader :rdf

  def initialize

    @rdf = <<EOT
<rdf:RDF
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:doi="doi:1014/10.system/schema.2001-07-26#"
>
  <doi:DObject rdf:about="doi:10.1234/567">
    <doi:contains>
      <rdf:Bag>
        <rdf:li rdf:parseType="Resource">
          <doi:profile rdf:resource="doi:1014/10.system/profile.zero"/>
          <doi:contains>
            <rdf:Bag>
              <rdf:li rdf:parseType="Resource">
                <doi:resource rdf:resource="http://www.doi.org"/>
                <doi:label>IDF</doi:label>
                <doi:detail>International DOI Foundation.</doi:detail>
                <doi:access>default</doi:access>
              </rdf:li>
              <rdf:li rdf:parseType="Resource">
                <doi:resource rdf:resource="http://www.cnri.reston.va.us"/>
                <doi:label>CNRI</doi:label>
                <doi:detail>Corporation for National Research Initiatives.</doi:detail>
              </rdf:li>
            </rdf:Bag>
          </doi:contains>
        </rdf:li>
      </rdf:Bag>
    </doi:contains>
  </doi:DObject>
</rdf:RDF>
EOT

  end

end


__END__
########################################################################
=begin

= DObject Class

= Synopsis

  require "doi/dObject"

  do = DObject.new("doi:10.1006/jmbi.2000.4282")
  # Alternatively: do = DObject.new("10.1006/jmbi.2000.4282")

  do.readDObjectStore
  puts do.resources

= Description

The DObject Class is a Ruby class for managing (({DObject})) objects.
These DObjects are transient computational structures with persistent network
identifiers which manage data elements relating to intellectual property
entities. These data elements are organized into Groups which are bound 
through an application profile to applications that can service (or otherwise
meaningfully interpret) them.

= Class Methods

--- DObject.get( doi )
    Constructs a new DObject with identifier ((|doi|)) and populates
    it with Groups fetched from a DObject copy within the DObjectStore.
    Equivalent to the following call sequence:

    (({do = DObject.new( doi ).readDObjectStore}))

--- DObject.new( doi )
    Constructs a new DObject with identifier ((|doi|)).

--- DObject.methods
    Prints list of DObject class and instance methods.

--- DObject.types
    Returns list of known DObject class data types.

= Instance Methods

--- DObject#addGroup( dataGroup, profiles*)
    Adds ((|dataGroup|)) to this DObject instance with an optional
    DOI application profile ((|profile|)). If no ((|profile|)) is specified
    the default application profile will be assigned.

--- DObject#addDObjectStore
    Adds the Groups present in the current DObject instance to the
    persisted DObject copy within the DObjectStore.
     
--- DObject#access?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'access',
    otherwise false.
 
--- DObject#accesses
    Returns list of data values of DObject type 'access' for the current
    DObject instance.

--- DObject#agent?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'agent',
    otherwise false.
 
--- DObject#agents
    Returns list of data values of DObject type 'agent' for the current
    DObject instance.

--- DObject#createDObjectStore
    Creates a persisted instance of the current DObject within the DObjectStore.

--- DObject#dataGroups
    Returns the Groups within the current DObject instance.

--- DObject#dataTypes
    Returns the DObject types within the current DObject instance.

--- DObject#dataValues( *types )
    Returns the DObject values within the current DObject instance. If an
    optional ((|types|)) list is provided then restrict the DObject values 
    to those of specified type(s).

--- DObject#deleteDObjectStore
    Deletes the persisted copy of the current DObject instance within the DObjectStore.

--- DObject#detail?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'detail',
    otherwise false.

--- DObject#details
    Returns list of data values of DObject type 'detail' for the current
    DObject instance.

--- DObject#doi
    Returns the ((|doi|)) identifier for this DObject instance.

--- DObject#dump
    Alias for ((|#dumpGroups|)).

--- DObject#dumpGroups
    Prints dump of the current DObject instance Groups.

--- DObject#kernelMetadata
    Return kernel metadata in XML format for the current DObject instance.

--- DObject#kernelMetadataService
    Return the kernel metadata service for the current DataoObject instance.

--- DObject#label?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'label',
    otherwise false.

--- DObject#labels
    Returns list of data values of DObject type 'label' for the current
    DObject instance.

--- DObject#modifyDObjectStore
    Replaces Groups in the persisted DObject copy within the DObjectStore
    with the Groups present within the current DObject instance.
 
--- DObject#null?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'null',
    otherwise false.

--- DObject#nulls
    Returns list of data values of DObject type 'null' for the current
    DObject instance.

--- DObject#profile?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'agent',
    otherwise false.

--- DObject#profileMetadata
    Return application profile metadata in XML format for the current DObject
    instance.

--- DObject#profileMetadataService
    Return the application profile metadata service for the current DataoObject
    instance.

--- DObject#profiles
    Returns list of data values of DObject type 'profile' for the current
    DObject instance.

--- DObject#readDObjectStore( doi )
    Retrieves Groups from the persisted DObject within the DObjectStore
    identified by ((|doi|)) and use them to populate the current DObject
    instance.

--- DObject#removeDObjectStore
    Removes from the persisted DObject copy within the DObjectStore the Groups
    present within the current DObject instance.

--- DObject#resolve?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'relation',
    otherwise false.

--- DObject#resolve
    Returns list of data values of DObject type 'relation' for the current
    DObject instance.

--- DObject#resource?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'resource',
    otherwise false.

--- DObject#resources
    Returns list of data values of DObject type 'resource' for the current
    DObject instance.

--- DObject#role?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'role',
    otherwise false.

--- DObject#roles
    Returns list of data values of DObject type 'role' for the current
    DObject instance.

--- DObject#schema?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'schema',
    otherwise false.

--- DObject#schemas
    Returns list of data values of DObject type 'schema' for the current
    DObject instance.

--- DObject#service?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'service',
    otherwise false.

--- DObject#services
    Returns list of data values of DObject type 'service' for the current
    DObject instance.

--- DObject#type?( string )
    Returns ((|true|)) if ((|string|)) is of DObject type 'type',
    otherwise false.

--- DObject#types
    Returns list of data values of DObject type 'type' for the current
    DObject instance.

--- DObject#writeDObjectStore( request )
    Generic method for modifying a DObject copy within the DObjectStore with the
    Groups present within the current DObject instance. The ((|request|)) argument 
    specifies the type of operation. Convenience methods are provided, see also
    ((|#addDObjectStore|)), ((|#createDObjectStore|)), ((|#deleteDObjectStore|)), ((|#modifyDObjectStore|)),
    and ((|#removeDatatore|)).

=end
