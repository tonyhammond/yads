# 
#   TubeTime - Waterloo & City Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Waterloo & City Line 
  resource => <doi:1014/tube/waterloo_&_city_line>
  type => "tube:Line"
  label => "Waterloo & City Line"
  detail => "TubeTime - Waterloo & City Line."
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
              resource => <doi:1014/tube/waterloo>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/bank>
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
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Station"
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
              #  Line Change 
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              #  Line Change 
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              #  Line Change 
              resource => <doi:1014/tube/circle_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              #  Line Change 
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              #  Line Change 
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              #  Line Change 
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/waterloo>
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
