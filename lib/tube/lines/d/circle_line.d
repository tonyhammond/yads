# 
#   TubeTime - Circle Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Circle Line 
  resource => <1014/tube/circle_line>
  type => "tube:Line"
  label => "Circle Line"
  detail => "TubeTime - Circle Line."
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
          }
        )
        (
          #  Line Stations 
          detail => "Line stations."
          {
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/barbican>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/aldgate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tower_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/cannon_street>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/mansion_house>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/blackfriars>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/temple>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/st._james's_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/sloane_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/gloucester_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/high_street_kensington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bayswater>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Station"
                  access => "Rail Link"
                )
              ]
            )
          }
        )
        (
          #  Interchange Stations 
          detail => "Interchange stations."
          {
            (:
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/gloucester_road>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barbican>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/aldgate>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barbican>
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
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/tower_hill>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/gloucester_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/high_street_kensington>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/monument>
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
              >
              type => "tube:Interchange"
            :)
            (:
              resource => <doi:1014/line/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
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
