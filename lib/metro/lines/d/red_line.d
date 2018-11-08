# 
#   MetroRail - Red Line
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Red Line 
  resource => <doi:1014/metro/red_line>
  type => "metro:Line"
  label => "Red Line"
  detail => "MetroRail - Red Line."
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.metro>
      type => "doi:Profile"
      {
        (
          #  Terminus Stations 
          detail => "Terminus stations."
          {
            (
              resource => <doi:1014/metro/north_hollywood>
              type => "metro:Terminus"
            )
            (
              resource => <doi:1014/metro/union_station,gateway_transit_center>
              type => "metro:Terminus"
            )
            (
              resource => <doi:1014/metro/wilshire,western>
              type => "metro:Terminus"
            )
          }
        )
        (
          #  Line Stations 
          detail => "Line stations."
          {
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/metro/north_hollywood>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/universal_city>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/hollywood,highland>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/hollywood,vine>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/hollywood,western>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/vermont,sunset>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/vermont,santa_monica,la_city_college>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/vermont,beverly>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/wilshire,vermont>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/westlake,macarthur_park>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/7th_street,metro_center,julian_dixon>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/pershing_square>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/civic_center,tom_bradley>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/union_station,gateway_transit_center>
                  type => "metro:Station"
                )
              ]
            )
            (
              {
                (
                  resource => <doi:1014/metro/wilshire,western>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/wilshire,vermont>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/wilshire,normandie>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/westlake,macarthur_park>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/7th_street,metro_center,julian_dixon>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/pershing_square>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/civic_center,tom_bradley>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/union_station,gateway_transit_center>
                  type => "metro:Station"
                )
              }
            )
          }
        )
        (
          #  Interchange Stations 
          detail => "Interchange stations."
          {
            (:
              resource => <doi:1014/metro/blue_line>
              <
                (
                  resource => <doi:1014/metro/7th_street,metro_center>
                  type => "metro:Interchange"
                )
              >
              type => "metro:LineChange"
            :)
          }
        )
      }
    :)
  }
:)
