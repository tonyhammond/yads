# 
#   TubeTime - Northern Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Northern Line 
  resource => <doi:1014/tube/northern_line>
  type => "tube:Line"
  label => "Northern Line"
  detail => "TubeTime - Northern Line."
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.tube>
      type => "doi:Profile"
      {
        (
          #  Terminus Stations 
          detail => "Terminus stations."
          {
            (
              resource => <doi:1014/tube/high_barnet>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/morden>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/edgware>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/mill_hill_east>
              type => "tube:Terminus"
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
                  resource => <doi:1014/tube/high_barnet>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/totteridge_&_whetstone>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/woodside_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_finchley>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/finchley_central>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/east_finchley>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/highgate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/archway>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tufnell_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/kentish_town>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/camden_town>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/angel>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/old_street>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/london_bridge>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/borough>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/elephant_&_castle>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/kennington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/oval>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stockwell>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/clapham_north>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/clapham_common>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/clapham_south>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/balham>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/tooting_bec>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tooting_broadway>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/colliers_wood>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_wimbledon>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/morden>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/edgware>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/burnt_oak>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/colindale>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hendon_central>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/brent_cross>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/golders_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hampstead>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/belsize_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/chalk_farm>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/camden_town>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/mornington_crescent>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/warren_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/goodge_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tottenham_court_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/leicester_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/charing_cross>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/kennington>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/mill_hill_east>
                  type => "tube:Station"
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
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/leicester_square>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/circle_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/london_bridge>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/stockwell>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/warren_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/bank>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/tottenham_court_road>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo/line>
              <
                (
                  resource => <doi:1014/tube/elephant_&_castle>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
          }
        )
      }
    :)
  }
:)
