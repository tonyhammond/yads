# 
#   MetroRail - Compton Station
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Compton Station 
  resource => <doi:1014/metro/compton>
  type => "metro:Station"
  label => "Compton"
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
              resource => <data:,275%20Willowbrook%20Av.,%20%20Compton%2090220>
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
                  resource => <doi:1014/metro/imperial,wilmington,rosa_parks>
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
                  resource => <doi:1014/metro/artesia>
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
