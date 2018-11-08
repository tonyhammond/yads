# 
#   MetroRail - Union Station / Gateway Transit Center Station
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Union Station / Gateway Transit Center Station 
  resource => <doi:1014/metro/union_station,gateway_transit_center>
  type => "metro:Station"
  label => "Union Station / Gateway Transit Center"
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
              resource => <data:,801%20Vignes%20St.,%20Los%20Angeles%2090012>
              type => "metro:Address"
            )
          }
        )
        (
          #  Line Interchanges 
          {
            (:
              #  Line Interchange 
              resource => <doi:1014/metro/red_line>
              type => "metro:LineChange"
              {
                (:
                  #  Next Stop Back 
                  resource => <doi:1014/metro/civic_center,tom_bradley>
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
                  resource => <doi:1014/metro/null>
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
