# 
#   MetroRail - Firestone Station
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Firestone Station 
  resource => <doi:1014/metro/firestone>
  type => "metro:Station"
  label => "Firestone"
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
              resource => <data:,8615%20Graham%20Av.,%20Los%20Angeles%2090002>
              type => "metro:Address"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/metro/blue_line>
              type => "metro:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/metro/florence>
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
                  resource => <doi:1014/metro/103rd_street,kenneth_hahn>
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
