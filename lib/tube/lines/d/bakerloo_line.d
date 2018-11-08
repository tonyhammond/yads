# 
#   TubeTime - Bakerloo Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Bakerloo Line 
  resource => <doi:1014/tube/bakerloo_line>
  type => "tube:Line"
  label => "Bakerloo Line"
  detail => "TubeTime - Bakerloo Line."
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
              resource => <doi:1014/tube/harrow_&_wealdstone>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/elephant_&_castle>
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
                  resource => <doi:1014/tube/harrow_&_wealdstone>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/kenton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_kenton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_wembley>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wembley_central>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stonebridge_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/harlesden>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/willesden_junction>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/kensal_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/queen's_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/kilburn_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/maida_vale>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/warwick_avenue>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/marylebone>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/regent's_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/piccadilly_circus>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/charing_cross>
                  type => "tube:Station"
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
                  resource => <doi:1014/tube/lambeth_north>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/elephant_&_castle>
                  type => "tube:Station"
                  access => "Rail Link"
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
                  resource => <doi:1014/tube/piccadilly_circus>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/baker_street>
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
                  resource => <doi:1014/tube/oxford_circus>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
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
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/circle_line>
              <
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/baker_street>
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
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/paddington>
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
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/elephant_&_castle>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/oxford_circus>
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
