#  
#   TubeTime - Newbury Park Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Newbury Park Station 
  resource => <doi:1014/tube/newbury_park>
  label => "Newbury Park"
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
              resource => <data:,Zone%204>
              type => "tube:Zone"
            )
            (
              resource => <data:,B9>
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
                  resource => <doi:1014/tube/gants_hill>
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
                  resource => <doi:1014/tube/barkingside>
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
