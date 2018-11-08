# 
#   TubeTime - District Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  District Line 
  resource => <doi:1014/tube/district_line>
  type => "tube:Line"
  label => "District Line"
  detail => "TubeTime - District Line."
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
              resource => <doi:1014/tube/ealing_broadway>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/upminster>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/richmond>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/wimbledon>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/kensington_(olympia)>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/edgware_road>
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
                  resource => <doi:1014/tube/ealing_broadway>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/ealing_common>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/acton_town>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/chiswick_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/turnham_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stamford_brook>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ravenscourt_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hammersmith>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/barons_court>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_kensington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/gloucester_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/sloane_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/st._james's_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/temple>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/blackfriars>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/mansion_house>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/cannon_street>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/tower_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/aldgate_east>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/whitechapel>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/stepney_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bow_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bromley-by-bow>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/plaistow>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/upton_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/east_ham>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/barking>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/upney>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/becontree>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/dagenham_heathway>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/dagenham_east>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/elm_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hornchurch>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/upminster_bridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/upminster>
                  type => "tube:Station"
                  access => "Rail Link"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/richmond>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/kew_gardens>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/gunnersbury>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/turnham_green>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/wimbledon>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/wimbledon_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/southfields>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/east_putney>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/putney_bridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/parsons_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/fulham_broadway>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/west_brompton>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/kensington_(olympia)>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/high_street_kensington>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bayswater>
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
              ]
            )
          }
        )
        (
          #  Interchange Stations 
          detail => "Interchange stations."
          {
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/whitechapel>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/stepney_green>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bow_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bromley-by-bow>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/plaistow>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/upton_park>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/east_ham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barking>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/piccadilly_line>
              <
                (
                  resource => <doi:1014/tube/ealing_common>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/acton_town>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/hammersmith>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barons_court>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/earl's_court>
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
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/waterloo_&_city_line>
              <
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/circle_line>
              <
                (
                  resource => <doi:1014/tube/gloucester_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/south_kensington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/sloane_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/st_james's_park>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/embankment>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/temple>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/blackfriars>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/mansion_house>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/cannon_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/tower_hill>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/high_street_kensington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/bayswater>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/paddington>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/hammersmith_&_city_line>
              <
                (
                  resource => <doi:1014/tube/hammersmith>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/aldgate_east>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/edgware_road>
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
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/east_london_line>
              <
                (
                  resource => <doi:1014/tube/whitechapel>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/westminster>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/west_ham>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/victoria>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/ealing_broadway>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/monument>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/notting_hill_gate>
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
