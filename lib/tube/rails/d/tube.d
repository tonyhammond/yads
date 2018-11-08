#  
#   TubeTime
# 
#   TubeTime implements the YADS model to describe the "Tube"
#   - London's underground rail network - as an example of a
#   complex resource association
# 
(:
  #  TubeTime 
  resource => <doi:1014/tube>
  label => "TubeTime"
  detail => "TubeTime implements the YADS model to describe the "Tube" - London's underground rail network - as an example of a complex resource association"
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.tube>
      type => "doi:Profile"
      label => "The Tube"
      detail => "TubeTime - The Tube."
      {
        (
          resource => <doi:1014/tube/bakerloo_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/central_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/circle_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/district_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/east_london_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/hammersmith_&_city_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/jubilee_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/metropolitan_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/northern_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/piccadilly_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/victoria_line>
          type => "tube:Line"
        )
        (
          resource => <doi:1014/tube/waterloo_&_city_line>
          type => "tube:Line"
        )
      }
    :)
    (:
      #  Application Profile 
      resource => <doi:doi:1014/profile.dlr>
      label => "Docklands Light Railway"
      detail => "TubeTime - Docklands Light Railway."
      {
        (
          resource => <doi:1014/tube/docklands_light_railway>
          type => "dlr:Line"
        )
      }
    :)
  }
:)
