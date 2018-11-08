# 
#   TubeTime - East London Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  East London Line 
  resource => <doi:1014/tube/east_london_line>
  type => "tube:Line"
  label => "East London Line"
  detail => "TubeTime - East London Line."
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
              resource => <doi:1014/tube/shoreditch>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/new_cross>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/new_cross_gate>
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
              [
                (
                  resource => <doi:1014/tube/shoreditch>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/whitechapel>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/shadwell>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wapping>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/rotherhithe>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/canada_water>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/surrey_quays>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/new_cross>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/surrey_quays>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/new_cross_gate>
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
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/canada_water>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/whitechapel>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/whitechapel>
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
