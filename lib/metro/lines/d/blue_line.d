# 
#   MetroRail - Blue Line
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Blue Line 
  resource => <doi:1014/metro/blue_line>
  type => "metro:Line"
  label => "Blue Line"
  detail => "MetroRail - Blue Line."
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
              resource => <doi:1014/metro/7th_street,metro_center,julian_dixon>
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
                  resource => <doi:1014/metro/7th_street,metro_center,julian_dixon>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/pico>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/grand>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/san_pedro>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/washington>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/vernon>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/slauson>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/florence>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/firestone>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/103rd_street,kenneth_hahn>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/imperial,wilmington,rosa_parks>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/compton>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/artesia>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/del_amo>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/wardlow>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/willow>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/pacific_coast_highway>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/anaheim>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/5th_street>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/1st_street>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/transit_mall>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/pacific>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/anaheim>
                  type => "metro:Station"
                )
              ]
            )
          }
        )
        (
          #  Interchange Stations 
          detail => "Interchange stations."
          {
            (:
              resource => <doi:1014/metro/red_line>
              <
                (
                  resource => <doi:1014/metro/7th_street,metro_center,julian_dixon>
                  type => "metro:Interchange"
                )
              >
              type => "metro:LineChange"
            :)
            (:
              resource => <doi:1014/metro/green_line>
              <
                (
                  resource => <doi:1014/metro/imperial,wilmington,rosa_parks>
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
