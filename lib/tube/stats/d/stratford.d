#  
#   TubeTime - Stratford Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Stratford Station 
  resource => <doi:1014/tube/stratford>
  label => "Stratford"
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
              resource => <data:,Zone%203>
              type => "tube:Zone"
            )
            (
              resource => <data:,C8>
              type => "tube:Grid"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/central_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/mile_end>
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
                  resource => <doi:1014/tube/leyton>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,3>
                      type => "tube:Mins"
                    )
                  }
                :)
              }
            :)
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/jubilee_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,3>
                      type => "tube:Mins"
                    )
                  }
                :)
              }
            :)
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/docklands_light_railway_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/pudding_mill_lane>
                  type => "tube:PrevStation"
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
