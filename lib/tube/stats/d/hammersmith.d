#  
#   TubeTime - Hammersmith Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Hammersmith Station 
  resource => <doi:1014/tube/hammersmith>
  label => "Hammersmith"
  type => "tube:Station"
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.tube>
      type => "doi:Profile"
      {
        (
          #  Location 
          {
            (
              resource => <data:,Zone%202>
              type => "tube:Zone"
            )
            (
              resource => <data:,D3>
              type => "tube:Grid"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/district_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/ravenscourt_park>
                  type => "tube:PrevStation"
                  {
                    (
                      resource => <data:,2>
                      type => "tube:Mins"
                    )
                  }
                :)
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/barons_court>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,1>
                      type => "tube:Mins"
                    )
                  }
                :)
              }
            :)
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/hammersmith_&_city_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/goldhawk_road>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,2>
                      type => "tube:Mins"
                    )
                  }
                :)
              }
            :)
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/piccadilly_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/turnham_green>
                  type => "tube:PrevStation"
                  {
                    (
                      resource => <data:,4>
                      type => "tube:Mins"
                    )
                  }
                :)
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/barons_court>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,2>
                      type => "tube:Mins"
                    )
                  }
                :)
              }
            :)
          }
        )
      }
    :)
  }
:)
