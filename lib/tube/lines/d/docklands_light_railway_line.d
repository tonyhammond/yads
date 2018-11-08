# 
#   TubeTime - Docklands Light Railway Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Docklands Light Railway Line 
  resource => <doi:1014/tube/docklands_light_railway>
  type => "dlr:Line"
  label => "East London Line"
  detail => "TubeTime - East London Line."
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.dlr>
      type => "doi:Profile"
      {
        (
          #  Terminus Stations 
          detail => "Terminus stations."
          {
            (
              resource => <doi:1014/tube/bank>
              type => "dlr:Terminus"
            )
            (
              resource => <doi:1014/tube/beckton>
              type => "dlr:Terminus"
            )
            (
              resource => <doi:1014/tube/tower_gateway>
              type => "dlr:Terminus"
            )
            (
              resource => <doi:1014/tube/lewisham>
              type => "dlr:Terminus"
            )
            (
              resource => <doi:1014/tube/stratford>
              type => "dlr:Terminus"
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
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/shadwell>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/limehouse>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/westferry>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/poplar>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/blackwall>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/east_india>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/canning_town>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/royal_victoria>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/custom_house_for_excel>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/prince_regent>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/royal_albert>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/beckton_park>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/cyprus>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/gallions_reach>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/beckton>
                  type => "dlr:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/tower_gateway>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/shadwell>
                  type => "dlr:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/westferry>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/west_india_quay>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/canary_month>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/heron_quays>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/south_quay>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/crossharbour_and_london_arena>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/mudchute>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/island_gardens>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/cutty_sark_for_maritime_greenwich>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/greenwich>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/deptford_bridge>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/elverson_road>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/lewisham>
                  type => "dlr:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/west_india_quay>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/poplar>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/all_saints>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/devons_road>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/bow_church>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/pudding_mill_lane>
                  type => "dlr:Station"
                )
                (
                  resource => <doi:1014/tube/stratford>
                  type => "dlr:Station"
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
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/stratford>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/circle_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/tower_gateway>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/bow_church>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/tower_gateway>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/east_london_line>
              <
                (
                  resource => <doi:1014/tube/shadwell>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/bow_church>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/canary_wharf>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/canning_town>
                  type => "dlr:Interchange"
                )
                (
                  resource => <doi:1014/tube/stratford>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "dlr:Interchange"
                )
              >
              type => "dlr:LineChange"
            :)
          }
        )
      }
    :)
  }
:)
