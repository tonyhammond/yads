#  
#   TubeTime - Roding Valley Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Roding Valley Station 
  resource => <doi:1014/tube/roding_valley>
  label => "Roding Valley"
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
              resource => <data:,A8>
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
              detail => "Woodford-Hainault until 2000 hours only."
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/chigwell>
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
                  resource => <doi:1014/tube/woodford>
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
          }
        )
      }
    :)
  }
:)
