#  
#   TubeTime - Finsbury Park Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Finsbury Park Station 
  resource => <doi:1014/tube/finsbury_park>
  label => "Finsbury Park"
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
              resource => <data:,B6>
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
                  #  Next Stop Back 
                  resource => <doi:1014/tube/arsenal>
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
                  resource => <doi:1014/tube/manor_house>
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
              resource => <doi:1014/tube/victoria_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/tube/seven_sisters>
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
                  resource => <doi:1014/tube/highbury_&_islington>
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
