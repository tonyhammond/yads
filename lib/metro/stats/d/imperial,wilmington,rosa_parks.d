# 
#   MetroRail - Imperial / Wilmington / Rosa Parks Station
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Imperial / Wilmington / Rosa Parks Station 
  resource => <doi:1014/metro/imperial,wilmington,rosa_parks>
  type => "metro:Station"
  label => "Imperial / Wilmington / Rosa Parks"
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
              resource => <data:,11611%20Willowbrook%20Av.,%20Los%20Angeles%2090059>
              type => "metro:Address"
            )
            (
              resource => <data:,11651%20Wilmington%20Av.,%20Los%20Angeles%2090059>
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
                  resource => <doi:1014/metro/103rd_street,kenneth_hahn>
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
                  resource => <doi:1014/metro/compton>
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
            (:
              #  Line Interchange 
              resource => <doi:1014/metro/green_line>
              type => "metro:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/metro/avalon>
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
                  resource => <doi:1014/metro/long_beach>
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
