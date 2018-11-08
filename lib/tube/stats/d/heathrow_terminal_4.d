#  
#   TubeTime - Heathrow Terminal 4 Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Heathrow Terminal 4 Station 
  resource => <doi:1014/tube/heathrow_terminal_4>
  label => "Heathrow Terminal 4"
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
              detail => "Until 2345 Mondays to Saturdays and 2315 Sundays."
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/heathrow_terminals_1,2,3>
                  type => "tube:PrevStation"
                  {
                    (
                      resource => <data:,5>
                      type => "tube:Mins"
                    )
                  }
                :)
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/hatton_cross>
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
