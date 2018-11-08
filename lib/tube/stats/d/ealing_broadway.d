#  
#   TubeTime - Ealing Broadway Station 
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Ealing Broadway Station 
  resource => <doi:1014/tube/ealing_broadway>
  label => "Ealing Broadway"
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
              resource => <data:,C1>
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
                  #  Next Stop 
                  resource => <doi:1014/tube/west_acton>
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
              resource => <doi:1014/tube/district_line>
              type => "tube:LineChange"
              {
                (:
                  #  Next Stop 
                  resource => <doi:1014/tube/ealing_common>
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
