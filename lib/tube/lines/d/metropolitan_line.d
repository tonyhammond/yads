# 
#   TubeTime - Metropolitan Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Metropolitan Line 
  resource => <doi:1014/tube/metropolitan_line>
  type => "tube:Line"
  label => "Metropolitan Line"
  detail => "TubeTime - Metropolitan Line."
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
              resource => <doi:1014/tube/amersham>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/aldgate>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/chesham>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/watford>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/uxbridge>
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
                  resource => <doi:1014/tube/amersham>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/chalfont_&_latimer>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/chorleywood>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/rickmansworth>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/moor_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/northwood>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/northwood_hills>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/pinner>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_harrow>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/harrow-on-the-hill>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/northwick_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/preston_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wembley_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/finchley_road>
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
              }
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/chesham>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/chalfont_&_latimer>
                  type => "tube:Station"
                )
              }
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/watford>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/croxley>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/moor_park>
                  type => "tube:Station"
                )
              }
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              {
                (
                  resource => <doi:1014/tube/uxbridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hillingdon>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ickenham>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ruislip>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ruislip_manor>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/eastcote>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/rayners_lane>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_harrow>
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
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/uxbridge>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/hillingdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ickenham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ruislip>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ruislip_manor>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/eastcote>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/rayners_lane>
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
              >
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
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
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/circle_line>
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
              >
              type => "tube:LineChange"
            :)
          }
        )
      }
    :)
  }
:)
