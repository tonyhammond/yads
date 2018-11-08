# 
#   MetroRail - Green Line
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Green Line 
  resource => <doi:1014/metro/green_line>
  type => "metro:Line"
  label => "Green Line"
  detail => "MetroRail - Green Line."
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
              resource => <doi:1014/metro/marine,redondo>
              type => "metro:Terminus"
            )
            (
              resource => <doi:1014/metro/i-605,i-105>
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
                  resource => <doi:1014/metro/marine,redondo>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/douglas,rosecrans>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/el_segundo,nash>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/mariposa,nash>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/aviation>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/hawthorne>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/crenshaw>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/vermont>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/harbor_freeway>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/avalon>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/imperial,wilmington,rosa_parks>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/long_beach>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/lakewood>
                  type => "metro:Station"
                )
                (
                  resource => <doi:1014/metro/i-605,i-105>
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
              resource => <doi:1014/metro/blue_line>
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
