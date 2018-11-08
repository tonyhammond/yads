########################################################################
#
# DOI::DataObject.pm - A Perl module for manipulating DOI DataObjects
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
#
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
# 
########################################################################

package DOI::DataObject;

# use Data::Dumper;
# print Dumper($self);

use URI::Escape;

  $nDataObjects = 0;

  # use constant DOI_SERVICE_HOST => "www2.harcourt-international.com";
  use constant DOI_SERVICE_HOST => "193.122.198.4";
  use constant DOI_SERVICE_PATH   => "/ap/servlet/yads";

  use constant DATA_STORE_CALL_FETCH  => "fetchDataStore";
  use constant DATA_STORE_CALL_ADD    => "addDataStore";
  use constant DATA_STORE_CALL_CREATE => "createDataStore";
  use constant DATA_STORE_CALL_DELETE => "deleteDataStore";
  use constant DATA_STORE_CALL_MODIFY => "modifyDataStore";
  use constant DATA_STORE_CALL_REMOVE => "removeDataStore";

  use constant DOI_PROFILE_ZERO => "doi:1014/10.1000/system.profile.zero";
  use constant DOI_SYSTEM_SCHEMA => "doi:1014/10.1000/system.schema.2001-07-26";

  @dataObjectTypes = (
        "accesses", "agents", "aliases", "details", "labels",
        "nulls", "profiles", "relations", "resources", "roles", "schemas",
        "services", "types" );

##########################################################################
#
# First the DataObject constructor method 'new'
#
###########################################################################

  sub new {

   my $class = shift;
   my $doi = shift;

   my $self = {};

   $nDataObjects++;
   $$self{'nDataObject'} = $nDataObjects;
 
   $$self{'doi'} = $doi;	# DOI for this DataObject
   $$self{'dataObject'} = {};	# Data element type/value pairs keyed on index
   $$self{'dataTypes'} = {};	# Hash keyed on data type with list of data values

   $$self{'dataIndex'} = 0;	# Next available index for dataObject hash
   $$self{'dataMap'} = "";	# Map of indexes within DataGroups

   $$self{'authUsername'} = "";	# Authorized username
   $$self{'authPassword'} = "";	# Authorized password
  
   bless $self, ref $class || $class;
  
   return $self;
  
  }
  
  sub get {

    my $class = shift;
    my $doi = shift;

    my $d = new DOI::DataObject($doi);
    $d->readDataStore();
    return $d;

  }

  sub readDataStore {

    my $self = shift;
    my @types = @_;

    _getDataFromStore($self, @types);
    return $self;

  }

  sub writeDataStore {

    my $self = shift;
    my $request = shift;

    _putDataToStore($self, $request);
    return $self;

  }

  # Convenience wrappers for specific writeDataStore methods

  sub addDataStore {

    my $self = shift;

    writeDataStore($self, DATA_STORE_CALL_ADD);

  }

  sub createDataStore {

    my $self = shift;

    writeDataStore($self, DATA_STORE_CALL_CREATE);

  }

  sub deleteDataStore {

    my $self = shift;

    writeDataStore($self, DATA_STORE_CALL_DELETE);

  }

  sub modifyDataStore {

    my $self = shift;

    writeDataStore($self, DATA_STORE_CALL_MODIFY);

  }

  sub removeDataStore {

    my $self = shift;

    writeDataStore($self, DATA_STORE_CALL_REMOVE);

  }


########################################################################

  # Class method to list allowed DataObject types

  sub types {

    # @dataObjectTypes;

  }

  # Accessor method for all dataTypes

  sub dataTypes {

    my $self = shift;

    keys %{$$self{'dataTypes'}};

  }


  # Accessor method for all dataValues

  sub dataValues {

    my $self = shift;
    my @types = @_;

    @_ = ();

    for $type (keys %{$$self{'dataTypes'}}) {

      if (@types) {

        if (grep { /$type/ } @types) {
          push @_, @{$$self{'dataTypes'}{$type}};
        }

      }
      else {

        push @_, @{$$self{'dataTypes'}{$type}};

      }

    }

    return @_;
  }


  # Set accessor methods for individual types

  sub accesses { my $self = shift; @{$$self{'dataTypes'}{'access'}} }
  sub agents { my $self = shift; @{$$self{'dataTypes'}{'agent'}} }
  sub aliases { my $self = shift; @{$$self{'dataTypes'}{'alias'}} }
  sub details { my $self = shift; @{$$self{'dataTypes'}{'detail'}} }
  sub labels { my $self = shift; @{$$self{'dataTypes'}{'label'}} }
  sub nulls { my $self = shift; @{$$self{'dataTypes'}{'null'}} }
  sub profiles { my $self = shift; @{$$self{'dataTypes'}{'profile'}} }
  sub relatives { my $self = shift; @{$$self{'dataTypes'}{'relative'}} }
  sub resources { my $self = shift; @{$$self{'dataTypes'}{'resource'}} }
  sub roles { my $self = shift; @{$$self{'dataTypes'}{'role'}} }
  sub schemas { my $self = shift; @{$$self{'dataTypes'}{'schema'}} }
  sub services { my $self = shift; @{$$self{'dataTypes'}{'service'}} }
  sub types { my $self = shift; @{$$self{'dataTypes'}{'type'}} }


  # Define a set of type test methods

  sub _isOfType {

    my ($self, $type, $s) = @_;

    for (@{$$self{'dataTypes'}{$type}}) {
      return 1 if m|^$s|;
    }
    return 0;

  }

  sub hasAccess { my $self = shift; _isOfType($self, 'access', $_[0]); }
  sub hasAgent { my $self = shift; _isOfType($self, 'agent', $_[0]); }
  sub hasAlias { my $self = shift; _isOfType($self, 'alias', $_[0]); }
  sub hasDetail { my $self = shift; _isOfType($self, 'detail', $_[0]); }
  sub hasLabel { my $self = shift; _isOfType($self, 'label', $_[0]); }
  sub hasNull { my $self = shift; _isOfType($self, 'null', $_[0]); }
  sub hasProfile { my $self = shift; _isOfType($self, 'profile', $_[0]); }
  sub hasRelative { my $self = shift; _isOfType($self, 'relative', $_[0]); }
  sub hasResource { my $self = shift; _isOfType($self, 'resource', $_[0]); }
  sub hasRole { my $self = shift; _isOfType($self, 'role', $_[0]); }
  sub hasSchema { my $self = shift; _isOfType($self, 'schema', $_[0]); }
  sub hasService { my $self = shift; _isOfType($self, 'service', $_[0]); }
  sub hasType { my $self = shift; _isOfType($self, 'type', $_[0]); }


########################################################################

  sub dataGroups {

    my $self = shift;

    # @{$$self{'aDataGroups'}};

  }

  sub dumpDataMap {

    my $self = shift;

    print "DataMap = $$self{'dataMap'}\n";

  }


  sub dumpDataGroups {

    my $self = shift;

    my $nDataGroups = 0;
    my $indent = -1;

    print "Dump for doi:$$self{'doi'}\n\n";
    print "DataMap = $$self{'dataMap'}\n\n";

    $nDataGroups = $$self{'dataMap'} =~ y|(|(|;

    print "DataGroups ($nDataGroups) =\n";
    while ($$self{'dataMap'} =~ /(\S+)/g) {

      $s = $1;
      for ($s) {

        /[({[<]/ and do { $indent++; print "  " x $indent, "$s\n"; last; };

        /[)}\]<]/ and do { print "  " x $indent, "$s\n"; $indent--; last; };

         ($type, $data) = @{$$self{'dataObject'}{$s}};
         print "  " x $indent, "  $type => $data\n";

      }

    }

    return $self;

  }

  # Define alias

  *dump = \&dumpDataGroups;

########################################################################


  sub toString {

    my $self = shift;

    my $indent = 0;
    my $sData = "";
    my $schema = DOI_SYSTEM_SCHEMA;

    $sData .= "<rdf:RDF\n";
    $sData .= "  xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n";
    $sData .= "  xmlns:doi=\"$schema\"\n";
    $sData .= ">\n";

    $sData .= "<doi:Object rdf:about=\"doi:$$self{'doi'}\">\n";

    while ($$self{'dataMap'} =~ /(\S+)/g) {

      $s = $1;
      for ($s) {

        /\{/ and do {
          $indent++;
          $sData .= "  " x $indent; $sData .= "<doi:contains>\n";
          $indent++;
          $sData .= "  " x $indent; $sData .= "<rdf:Bag>\n";
          last;
        };

        /\}/ and do {
          $sData .= "  " x $indent; $sData .= "</rdf:Bag>\n";
          $indent--;
          $sData .= "  " x $indent; $sData .= "</doi:contains>\n";
          $indent--;
          last;
        };

        /\[/ and do {
          $indent++;
          $sData .= "  " x $indent; $sData .= "<doi:contains>\n";
          $indent++;
          $sData .= "  " x $indent; $sData .= "<rdf:Seq>\n";
          last;
        };

        /\]/ and do {
          $sData .= "  " x $indent; $sData .= "</rdf:Seq>\n";
          $indent--;
          $sData .= "  " x $indent; $sData .= "</doi:contains>\n";
          $indent--;
          last;
        };

        /\</ and do {
          $indent++;
          $sData .= "  " x $indent; $sData .= "<doi:contains>\n";
          $indent++;
          $sData .= "  " x $indent; $sData .= "<rdf:Alt>\n";
          last;
        };

        /\>/ and do {
          $sData .= "  " x $indent; $sData .= "</rdf:Alt>\n";
          $indent--;
          $sData .= "  " x $indent; $sData .= "</doi:contains>\n";
          $indent--;
          last;
        };

        /\(/ and do {
          $indent++;
          $sData .= "  " x $indent; $sData .= "<rdf:li rdf:parseType=\"Resource\">\n";
          last;
        };

        /\)/ and do {
          $sData .= "  " x $indent; $sData .= "</rdf:li>\n";
          $indent--;
          last;
        };

        ($type, $data) = @{$$self{'dataObject'}{$s}};

        $data =~ s/</&lt;/g;
        $data =~ s/>/&gt;/g;
        $data =~ s/&/&amp;/g;

        if ($type =~ /type|label|detail|genre/) {
          $sData .= "  " x $indent; $sData .= "  <doi:$type>$data</doi:$type>\n";
        }
        else {
          $sData .= "  " x $indent; $sData .= "  <doi:$type rdf:resource=\"$data\"/>\n";
        }

      }

    }

    $sData .= "</doi:Object>\n";
    $sData .= "</rdf:RDF>\n";

  }


########################################################################


  sub _getDataFromStore {

    my $self = shift;
    my $doi = $$self{'doi'};
    my @types = @_;

    $$self{'dataObject'} = {};
    $$self{'dataTypes'} = {};
    $$self{'dataMap'} = "";
    $$self{'dataIndex'} = 0;

    $sData = _getDataValues($doi);

    for $line (split /\n/, $sData) {

      # On the dataObject open tag 

      if ($line =~ /<doi:Object rdf:about=['"](.*?)['"]>/) {

        $$self{'doi'} = $1;
        next;

      }

      # On RDF container and anonymous resource open tags
      # On RDF container and anonymous resource open tags

      $$self{'dataMap'} .= " {" if $line =~ /<rdf:Bag>/;
      $$self{'dataMap'} .= " [" if $line =~ /<rdf:Seq>/;
      $$self{'dataMap'} .= " <" if $line =~ /<rdf:Alt>/;
      $$self{'dataMap'} .= " (" if $line =~ /<rdf:li rdf:parseType="Resource">/;

      # On RDF container and anonymous resource close tags

      $$self{'dataMap'} .= " }" if $line =~ /<\/rdf:Bag>/;
      $$self{'dataMap'} .= " ]" if $line =~ /<\/rdf:Seq>/;
      $$self{'dataMap'} .= " >" if $line =~ /<\/rdf:Alt>/;
      $$self{'dataMap'} .= " )" if $line =~ /<\/rdf:li>/;

      # Skip the DOI container properties

      next if $line =~ /<doi:contains>/;
      next unless $line =~ /<doi:/;

      # The only other lines for parsing are the data elements
     
      $line =~ s/&lt;/</g;
      $line =~ s/&gt;/>/g;
      $line =~ s/&amp;/&/g;

      if ($line =~ m|<doi:(\w+)>(.*?)<\/doi:\w+>|) {
      
        $type = $1; $data = $2;

      }
      if ($line =~ m|<doi:(\w+) rdf:resource=\"(.*?)\"/>|) {
      
        $type = $1; $data = $2;

      }
          
      # Add the element type/data pair to the dataObject hash

      $$self{'dataObject'}{$$self{'dataIndex'}} = [ $type, $data ];
      $$self{'dataMap'} .= " $$self{'dataIndex'}";
      $$self{'dataIndex'}++;
 
      # Push the data value onto the dataTypes hash

      @_ = @{$$self{'dataTypes'}{$type}};
      push @_, $data;
      $$self{'dataTypes'}{$type} = [ @_ ];

    }

    $$self{'dataMap'} =~ s|^\s*|$1|;
    $$self{'dataMap'} =~ s|\s*$|$1|;

  }


########################################################################


  sub _putDataToStore  {

    my $self = shift;
    my $request = shift;
     
    $sData = "";

    $sData .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    $sData .= "<SOAP-ENV:Envelope\n";
    $sData .= "  xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\n";
    $sData .= "  SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"\n";
    $sData .= ">\n";
    $sData .= "<SOAP-ENV:Body>\n";
    $sData .= "<DOI-SERVICE:$request\n";
    $sData .= "  xmlns:DOI-SERVICE=\"http://dx.doi.org/1014/doi.service\"\n";
    $sData .= ">\n";
    $sData .= $self->toString();
    $sData .= "</DOI-SERVICE:$request>\n";
    $sData .= "</SOAP-ENV:Body>\n";
    $sData .= "</SOAP-ENV:Envelope>\n";

    # print $sData;

    print _setDataValues($sData);

  }


########################################################################

  sub _metadata {

    my $self = shift;
    my $profile = shift;
    my $auth = shift;
    my $action = shift;
    my $doiProfile;

    my $doi = $$self{'doi'};
    $doi =~ s/^1014\///;

    ($doiProfile = $profile) =~ s|^doi:||;
    my $d = DOI::DataObject->get($doiProfile);

    # $d->services[0] =~ /^http:\/\/(.*?)(\/.*?)$/;
    @_ = $d->services;
    $_[0] =~ /^http:\/\/(.*?)(\/.*?)$/;
    my $host = $1;
    my $path = "$2?id=$doi&pid=$auth&sid=null:null";
    if ($action) {
      _getMetaData($host, $path);
    }
    else {
      "http://$host$path";
    }

  }

  sub getUsername {
  
    my $self = shift;

    return $$self{'authUsername'};

  }

  sub setUsername {
  
    my $self = shift;
    my $user = shift;

    $$self{'authUsername'} = $user;

  }

  sub getPassword {
  
    my $self = shift;

    return $$self{'authPassword'};

  }

  sub setPassword {
  
    my $self = shift;
    my $pass = shift;

    $$self{'authPassword'} = $pass;

  }

  sub kernelMetadata {
  
    my $self = shift;

    my @profile = @_ ? @_ : $self->profiles;
    my $profile = $profile[0];

    my $auth = "guest:guest";

    _metadata($self, $profile, $auth, 1);

  }

  sub kernelMetadataService {
  
    my $self = shift;

    my @profile = @_ ? @_ : $self->profiles;
    my $profile = $profile[0];

    _metadata($self, $profile, undef, 0);

  }

  sub profileMetadata {
  
    my $self = shift;

    my @profile = @_ ? @_ : $self->profiles;
    my $profile = $profile[0];

    my $auth = $self->getUsername . ":" . $self->getPassword;

    _metadata($self, $profile, $auth, 1);

  }

  sub profileMetadataService {
  
    my $self = shift;

    my @profile = @_ ? @_ : $self->profiles;
    my $profile = $profile[0];

    _metadata($self, $profile, undef, 0);

  }

########################################################################

  sub _getDataValues {

    my $doi = shift;

    my $host = DOI_SERVICE_HOST;
    my $path = DOI_SERVICE_PATH . "?doi=$doi&xml=true";
    
    _getXMLFromService($host, $path);

  }

  sub _setDataValues {

    my $data = shift;
    $data = uri_escape($data);

    my $host = DOI_SERVICE_HOST;
    my $path = DOI_SERVICE_PATH . "?data=$data";
    
    _getXMLFromService($host, $path);

  }

  sub _getMetaData {

    my ($host, $path) = @_;

    _getXMLFromService($host, $path)
    
  }

  sub _getXMLFromService {

    my ($host, $path) = @_;
 
    use LWP;
    use URI::URL;
  
    my ($ua, $url, $req, $res);
  
    # Create the user agent object

    $ua = new LWP::UserAgent;
    # $ua->timeout('300');
  
    # Set up a request

    $req = new HTTP::Request ('GET');
  
    # Create the URL object

    $url = new URI::URL ("http://$host$path", '');

    # Send the request and get a response back from the host

    $req->url($url);

    $res = $ua->request($req);
     
    return ($res->is_success) ? $res->content : undef;

  }

########################################################################


  sub addContainer {

    my $self = shift;
    my $dataGroup = shift;
    my @profiles = @_;

    my $indexProfile = 0;

    $profile = $#profiles == -1 ? DOI_PROFILE_ZERO : $profiles[0];

    # See whether we need to add in a value for the profile

    unless (exists $$self{'dataTypes'}{'profile'}) {
           # and $$self{'dataTypes'}{'profile'}.include?($profile)

      # Husk: Make check that profile is legitimate

      $$self{'dataObject'}{$$self{'dataIndex'}} = [ 'profile', $profile ];
      $indexProfile = $$self{'dataIndex'};
      $$self{'dataIndex'}++;

      $$self{'dataTypes'}{'profile'} = $profile;
      $$self{'profiles'} = $$self{'dataTypes'}{'profile'};

    }
    else {

      for $index (keys %{$$self{'dataObject'}}) {
        ($type, $data) = @{$$self{'dataObject'}{$index}};
        if (($type eq 'profile') and ($data eq $profile)) {
          $indexProfile = $index; 
          last;
        }
      }

    }

    #

    $$self{'dataMap'} .= " { ( $indexProfile";

    _addContainer ($self, $dataGroup);

    $$self{'dataMap'} .= " ) }";

  }

  sub _addContainer {

    my $self = shift;
    my $dataGroup = shift;
    my @profiles = @_;

    my ($o_delim, $c_delim);

    # return unless $dataGroup;
    for $dataElement ($dataGroup->getData) {

      ($type, $data) = @$dataElement;

      if ($type eq 'ordering') {
        for ($data) {

          /alt/ and do { $o_delim = '<'; $c_delim = '>'; };
          /bag/ and do { $o_delim = '{'; $c_delim = '}'; };
          /seq/ and do { $o_delim = '['; $c_delim = ']'; };

        }
        $$self{'dataMap'} .= " $o_delim";
        next;
      }

      if ($type eq 'container') {
        _addContainer($data);
        next;
      }

      if ($type eq 'dataGroup') {
        $$self{'dataMap'} .= " (";
        _addContainer($self, $data);
        $$self{'dataMap'} .= " )";
        next;
      }

      $$self{'dataObject'}{$$self{'dataIndex'}} = $dataElement;
      $$self{'dataMap'} .= " $$self{'dataIndex'}";
      $$self{'dataIndex'}++;

    }

    $$self{'dataMap'} .= " $c_delim";

    return $self;

  }


########################################################################


# Minor class for aggregating data into data groups

package DOI::DataGroup;

  sub new {

    my $class = shift;

    my $self = {};

    $$self{'dataGroup'} = [];   # DataGroup list

    bless $self, ref $class || $class;

    return $self;

  }


  sub addContainer {

    my $self = shift;
    my $container = shift;

    push @{$$self{'dataGroup'}}, [ 'container', $container ];
    return $self;

  }

  sub addData {

    my $self = shift;
    my $type = shift;
    my $data = shift;

    push @{$$self{'dataGroup'}}, [ $type, $data ];
    return $self;

  }


  sub getData {

    my $self = shift;
  
    return @{$$self{'dataGroup'}};

  }

  *readData = \&getData;

  sub clearData {

    $$self{'dataGroup'} = [];

  }

  *readData = \&getData;


########################################################################


# Minor class for aggregating data into data groups

package DOI::Container;

  sub new {

    my $class = shift;
    my $ordering = shift;
    
    my $self = {};

    $ordering = 'bag' unless $ordering;

    $$self{'dataGroup'} = [];   # DataGroup list
    push @{$$self{'dataGroup'}}, [ 'ordering', $ordering ];

    bless $self, ref $class || $class;

    return $self;

  }


  sub addDataGroup {

    my $self = shift;
    my $dataGroup = shift;

    push @{$$self{'dataGroup'}}, [ 'dataGroup', $dataGroup ];
    return $self;

  }

  sub addData {

    my $self = shift;
    my $type = shift;
    my $data = shift;

    push @{$$self{'dataGroup'}}, [ $type, $data ];
    return $self;

  }


  sub getData {

    my $self = shift;
  
    return @{$$self{'dataGroup'}};

  }

  *readData = \&getData;

  sub clearData {

    $$self{'dataGroup'} = [];

  }

  *readData = \&getData;



1;
__END__

########################################################################

=pod

=head1 NAME

DOI::DataObject.pm - provides methods to manipulate DOI DataObjects.

=head1 SYNOPSIS

  use DOI::DataObject;

  $d = DOI::DataObject->new("10.1006/jmbi.2000.4282");
  $d->readDataStore;

  # Or more simply: $d = DOI::DataObject->get("10.1006/jmbi.2000.4282");

  # Now print a list of the resources

  print "$_\n" for $d->resources;


=head1 DESCRIPTION

The DOI::DataObject module is a Perl package for managing DataObject objects.
These DataObjects are transient computational structures with persistent network
identifiers which manage data elements relating to intellectual property
entities. These data elements are organized into DataGroups which are bound 
through an application profile to applications that can service (or otherwise
meaningfully interpret) them.

=head1 CLASS METHODS

=over 4

=item DOI::DataObject->get( $doi )

Constructs a new DataObject with identifier $doi and populates it with DataGroups
fetched from the DataStore. Equivalent to the following call sequence:

    $d = DataObject->new($doi)->readDataStore

=item DOI::DataObject->new( $doi )

Constructs a new DataObject with identifier $doi.

=item DOI::DataObject->methods

Prints list of DataObject class and instance methods.

=item DOI::DataObject->types

Returns list of known DataObject class data types.

=back

=head1 INSTANCE METHODS

=over 4

=item $d->addDataGroup( $dataGroup, $profile )

Adds $dataGroup to this DataObject instance with an optional
DOI application profile $profile. If no $profile is specified
the default application profile will be assigned.

=item $d->addDataStore

Adds the DataGroups present in the current DataObject instance to the
persisted DataObject copy within the DataStore.

=item $d->hasAccess( $string )

Returns '1' if $string is of DataObject type 'access', otherwise '0'.

=item $d->accesses

Returns list of data values of DataObject type 'access' for the current
DataObject instance.

=item $d->hasAgent( $string )

Returns '1' if $string is of DataObject type 'agent', otherwise '0'.

=item $d->agents

Returns list of data values of DataObject type 'agent' for the current
DataObject instance.

=item $d->hasAlias( $string )

Returns '1' if $string is of DataObject type 'alias', otherwise '0'.

=item $d->aliases

Returns list of data values of DataObject type 'alias' for the current
DataObject instance.

=item $d->createDataStore

Creates a persisted instance of the current DataObject within the DataStore.

=item $d->dataGroups

Returns the DataGroups within the current DataObject instance.

=item $d->dataTypes

Returns the DataObject types within the current DataObject instance.

=item $d->dataValues( @types )

Returns the DataObject values within the current DataObject instance. If an
optional C<@types> list is provided then restrict the DataObject values 
to those of specified type(s).

=item $d->deleteDataStore

Deletes the persisted copy of the current DataObject instance within the DataStore.

=item $d->hasDetail( $string )

Returns '1' if $string is of DataObject type 'detail', otherwise '0'.

=item $d->details

Returns list of data values of DataObject type 'detail' for the current
DataObject instance.

=item $d->doi

Returns the $doi identifier for this DataObject instance.

=item $d->dump

Alias for $d->dumpDataGroups.

=item $d->dumpDataGroups

Prints dump of the current DataObject instance DataGroups.

=item $d->kernelMetadata

Return kernel metadata in XML format for the current DataObject instance.

=item $d->kernelMetadataService

Return the kernel metadata service for the current DataoObject instance.

=item $d->hasLabel( $string )

Returns '1' if $string is of DataObject type 'label', otherwise '0'.

=item $d->labels

Returns list of data values of DataObject type 'label' for the current
DataObject instance.

=item $d->modifyDataStore

Replaces DataGroups in the persisted DataObject copy within the DataStore
with the DataGroups present within the current DataObject instance.

=item $d->hasNull( $string )

Returns '1' if $string is of DataObject type 'null', otherwise '0'.

=item $d->nulls

Returns list of data values of DataObject type 'null' for the current
DataObject instance.

=item $d->hasProfile( $string )

Returns '1' if $string is of DataObject type 'profile', otherwise '0'.

=item $d->profileMetadata

Return application profile metadata in XML format for the current DataObject
instance.

=item $d->profileMetadataService

Return the application profile metadata service for the current DataoObject
instance.

=item $d->profiles

Returns list of data values of DataObject type 'profile' for the current
DataObject instance.

=item $d->readDataStore( $doi )

Retrieves DataGroups from the persisted DataObject within the DataStore
identified by $doi and use them to populate the current DataObject
instance.

=item $d->removeDataStore

Removes from the persisted DataObject copy within the DataStore the DataGroups
present within the current DataObject instance.

=item $d->hasRelation( $string )

Returns '1' if $string is of DataObject type 'relation', otherwise '0'.

=item $d->relations

Returns list of data values of DataObject type 'relation' for the current
DataObject instance.

=item $d->hasResource( $string )

Returns '1' if $string is of DataObject type 'resource', otherwise '0'.

=item $d->resources

Returns list of data values of DataObject type 'resource' for the current
DataObject instance.

=item $d->hasRole( $string )

Returns '1' if $string is of DataObject type 'role', otherwise '0'.

=item $d->roles

Returns list of data values of DataObject type 'role' for the current
DataObject instance.

=item $d->hasSchema( $string )

Returns '1' if $string is of DataObject type 'schema', otherwise '0'.

=item $d->schemas

Returns list of data values of DataObject type 'schema' for the current
DataObject instance.

=item $d->hasService( $string )

Returns '1' if $string is of DataObject type 'service', otherwise '0'.

=item $d->services

Returns list of data values of DataObject type 'service' for the current
DataObject instance.

=item $d->hasType( $string )

Returns '1' if $string is of DataObject type 'type', otherwise '0'.

=item $d->types

Returns list of data values of DataObject type 'type' for the current
DataObject instance.

=item $d->writeDataStore( $request )

Generic method for modifying a DataObject copy within the DataStore with the
DataGroups present within the current DataObject instance. The $request argument 
specifies the type of operation. Convenience methods are provided, see also
$d->addDataStore, $d->createDataStore, $d->deleteDataStore, $d->modifyDataStore,
and $d->removeDatatore.

=back

=head1 AUTHOR

Tony Hammond <F<tony_hammond@harcourt.com>>

=head1 COPYRIGHT

Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
Company

=cut
