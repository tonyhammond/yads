#  
#   TubeTime - High Barnet Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  High Barnet Station 
  resource => <doi:1014/tube/high_barnet>
  label => "High Barnet"
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
              resource => <data:,Zone%205>
              type => "tube:Zone"
            )
            (
              resource => <data:,A5>
              type => "tube:Grid"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/northern_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/totteridge_&_whetstone>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,4>
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
