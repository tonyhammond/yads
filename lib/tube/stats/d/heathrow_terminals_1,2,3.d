#  
#   TubeTime - Heathrow Terminals 1,2,3 Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Heathrow Terminals 1,2,3 Station 
  resource => <doi:1014/tube/heathrow_terminals_1,2,3>
  label => "Heathrow Terminals 1,2,3"
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
              resource => <data:,Zone%206>
              type => "tube:Zone"
            )
            (
              resource => <data:,E1>
              type => "tube:Grid"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/piccadilly_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/heathrow_terminal_4>
                  type => "tube:NextStation"
                  {
                    (
                      resource => <data:,5>
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
