# 
#   TubeTime - Central Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Central Line 
  resource => <doi:1014/tube/central_line>
  type => "tube:Line"
  label => "Central Line"
  detail => "TubeTime - Central Line."
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.tube>
      type => "doi:Profile"
      {
        (
          #  Terminus Stations 
          detail => "Terminus stations."
          {
            (
              resource => <doi:1014/tube/west_ruislip>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/epping>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/ealing_broadway>
              type => "tube:Terminus"
            )
          }
        )
        (
          #  Line Stations 
          detail => "Line stations."
          {
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/west_ruislip>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/ruislip_gardens>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_ruislip>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/northolt>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/greenford>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/perivale>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hanger_lane>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_acton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/east_acton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/white_city>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/shepherd's_bush>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/holland_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/queensway>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/lancaster_gate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/marble_arch>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bond_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tottenham_court_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/holborn>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/chancery_lane>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/st._paul's>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/bethnal_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stratford>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/leyton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/leytonstone>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/snaresbrook>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_woodford>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/woodford>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/buckhurst_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/loughton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/debden>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/theydon_bois>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/epping>
                  type => "tube:Station"
                )
              }
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/ealing_broadway>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/west_acton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_acton>
                  type => "tube:Station"
                )
              }
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/leytonstone>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wanstead>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/redbridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/gants_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/newbury_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/barkingside>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/fairlop>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hainault>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/grange_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/chigwell>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/roding_valley>
                  type => "tube:Station"
                )
              }
            )
          }
        )
        (
          #  Interchange Stations 
          detail => "Interchange stations."
          {
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/stratford>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/holborn>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/circle_line>
              <
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ealing_broadway>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/bond_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/tottenham_court_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
          }
        )
      }
    :)
  }
:)
