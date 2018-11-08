# 
#   TubeTime - Victoria Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Victoria Line 
  resource => <doi:1014/tube/victoria_line>
  type => "tube:Line"
  label => "Victoria Line"
  detail => "TubeTime - Victoria Line."
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
              resource => <doi:1014/tube/walthamstow_central>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/brixton>
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
                  resource => <doi:1014/tube/walthamstow_central>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/blackhorse_road>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/tottenham_hale>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/seven_sisters>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/finsbury_park>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/highbury_&_islington>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/warren_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/pimlico>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/vauxhall>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/stockwell>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/brixton>
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
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/circle_line>
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
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/warren_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/stockwell>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/picadilly_line>
              <
                (
                  resource => <doi:1014/tube/finsbury_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/oxford_circus>
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
