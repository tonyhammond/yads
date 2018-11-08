#  
#   TubeTime - Leicester Square Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Leicester Square Station 
  resource => <doi:1014/tube/leicester_square>
  label => "Leicester Square"
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
              resource => <data:,Zone%201>
              type => "tube:Zone"
            )
            (
              resource => <data:,D5>
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
                  #  Next Stop Back 
                  resource => <doi:1014/tube/tottenham_court_road>
                  type => "tube:PrevStation"
                  {
                    (
                      resource => <data:,1>
                      type => "tube:Mins"
                    )
                  }
                :)
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/charing_cross>
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
                  resource => <doi:1014/tube/piccadilly_circus>
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
                  resource => <doi:1014/tube/covent_garden>
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
          }
        )
      }
    :)
  }
:)
