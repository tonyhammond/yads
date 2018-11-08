# 
#   TubeTime - Piccadilly Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Piccadilly Line 
  resource => <doi:1014/tube/piccadilly_line>
  type => "tube:Line"
  label => "Piccadilly Line"
  detail => "TubeTime - Piccadilly Line."
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
              resource => <doi:1014/tube/uxbridge>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/cockfosters>
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
                  resource => <doi:1014/tube/uxbridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hillingdon>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ickenham>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ruislip>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ruislip_manor>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/eastcote>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/rayners_lane>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_harrow>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/sudbury_hill>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/sudbury_town>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/alperton>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/park_royal>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/north_ealing>
                  type => "tube:Station"
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
                  resource => <doi:1014/tube/turnham_green>
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
                  resource => <doi:1014/tube/knightsbridge>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hyde_park_corner>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/piccadilly_circus>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/leicester_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/covent_garden>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/holborn>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/russell_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/caledonian_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/holloway_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/arsenal>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/finsbury_park>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/manor_house>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/turnpike_lane>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/wood_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/bounds_green>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/arnos_grove>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/southgate>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/oakwood>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/cockfosters>
                  type => "tube:Station"
                )
              ]
            )
            (
              #  Branch Stations 
              detail => "Branch stations."
              [
                (
                  resource => <doi:1014/tube/heathrow_terminals_1,2,3>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/heathrow_terminal_4>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hatton_cross>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hounslow_west>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hounslow_central>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/hounslow_east>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/osterley>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/boston_manor>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/northfields>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/south_ealing>
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
              resource => <doi:1014/tube/bakerloo_line>
              <
                (
                  resource => <doi:1014/tube/piccadilly_circus>
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
                  resource => <doi:1014/tube/king's_cross_st._pancras>
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
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/leicester_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/jubilee_line>
              <
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/uxbridge>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/hillingdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ickenham>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ruislip>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/ruislip_manor>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/eastcote>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/rayners_lane>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/green_park>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/finsbury_park>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
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
              >
            :)
            (:
              resource => <doi:1014/tube/central_line>
              type => "tube:LineChange"
              <
                (
                  resource => <doi:1014/tube/holborn>
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
