#  
#   TubeTime - Amersham Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Amersham Station 
  resource => <doi:1014/tube/amersham>
  label => "Amersham"
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
              resource => <data:,Zone%20D>
              type => "tube:Zone"
            )
            (
              resource => <data:,A1>
              type => "tube:Grid"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/tube/metropolitan_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/chalfont_&_latimer>
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
