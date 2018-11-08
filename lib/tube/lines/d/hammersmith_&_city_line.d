# 
#   TubeTime - Hammersmith & City Line
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  Hammersmith & City Line 
  resource => <doi:1014/tube/hammersmith_&_city_line>
  type => "tube:Line"
  label => "Hammersmith & City Line"
  detail => "TubeTime - Hammersmith & City Line."
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
              resource => <doi:1014/tube/hammersmith>
              type => "tube:Terminus"
            )
            (
              resource => <doi:1014/tube/barking>
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
                  resource => <doi:1014/tube/hammersmith>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/goldhawk_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/shepherd's_bush>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/latimer_road>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/ladbroke_grove>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/westbourne_park>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/royal_oak>
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
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/barbican>
                  type => "tube:Station"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Station"
                  access => "Rail Link"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Station"
                  access => "Rail Link"
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
              resource => <doi:1014/tube/bakerloo_line>
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
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barbican>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/northern_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
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
                  resource => <doi:1014/tube/baker_street>
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
              resource => <doi:1014/tube/metropolitan_line>
              <
                (
                  resource => <doi:1014/tube/baker_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/great_portland_street>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/euston_square>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/farringdon>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/barbican>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/moorgate>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/liverpool_street>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/victoria_line>
              <
                (
                  resource => <doi:1014/tube/king's_cross_st._pancras>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/central_line>
              <
                (
                  resource => <doi:1014/tube/mile_end>
                  type => "tube:Interchange"
                )
              >
              type => "tube:LineChange"
            :)
            (:
              resource => <doi:1014/tube/district_line>
              <
                (
                  resource => <doi:1014/tube/hammersmith>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/edgware_road>
                  type => "tube:Interchange"
                )
                (
                  resource => <doi:1014/tube/aldgate_east>
                  type => "tube:Interchange"
                )
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
              resource => <doi:1014/tube/central_line>
              <
                (
                  resource => <doi:1014/tube/liverpool_street>
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
