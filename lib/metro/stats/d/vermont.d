# 
#   MetroRail - Vermont Station
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Vermont Station 
  resource => <doi:1014/metro/vermont>
  type => "metro:Station"
  label => "Vermont"
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.metro>
      type => "doi:Profile"
      {
        (
          #  Location 
          {
            (
              resource => <data:,11603%20S.%20Vermont%20Av.,%20Los%20Angeles%2090048>
              type => "metro:Address"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/metro/green_line>
              type => "metro:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/metro/crenshaw>
                  type => "metro:PrevStation"
                  {
                    (
                      resource => <data:,0>
                      type => "metro:Mins"
                    )
                  }
                :)
                (:
                  #  Next Stop 
                  resource => <doi:1014/metro/harbor_freeway>
                  type => "metro:NextStation"
                  {
                    (
                      resource => <data:,0>
                      type => "metro:Mins"
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
