# 
#   TubeTime - Jubilee Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Jubilee Line 
  resource => <doi:1014/tube/jubilee_line>
  type => "tube:Line"
  label => "Jubilee Line"
  detail => "TubeTime - Jubilee Line."
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
              resource => <doi:1014/tube/stratford>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/stanmore>
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
              {
                (
                  resource => <doi:1014/tube/stratford>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/canning_town>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_greenwich>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/canary_wharf>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/canada_water>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bermondsey>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/london_bridge>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/southwark>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bond_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/st._john's_wood>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/swiss_cottage>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/finchley_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_hampstead>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/kilburn>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/willesden_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/dollis_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/neasden>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wembley_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/kingsbury>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/queensbury>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/canons_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stanmore>
                  type => "tube:Station"
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
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/waterloo>
                  type => "tube:Interchange"
                )
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
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Interchange"
                )
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
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
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
              resource => <doi:1014/tube/east_london_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/canada_water>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/finchley_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/wembley_park>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
              >
            :)
            (:
              resource => <doi:1014/tube/district_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/stratford>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bond_street>
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
