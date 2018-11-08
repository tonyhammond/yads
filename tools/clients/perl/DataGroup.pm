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
  
    return $$self{'dataGroup'};

  }

  *readData = \&getData;

  sub clearData {

    $$self{'dataGroup'} = [];

  }

  *readData = \&getData;

__END__
