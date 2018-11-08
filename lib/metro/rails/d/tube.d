DObject <doi:1014/tube> =>
{
  (
    profile => <doi:1014/10.system/profile.tube>
    {
      (
        resource => <>
        label => "The Tube"
        detail => "TubeLand - The Tube."
        {
          (
            resource => <1014/tube/bakerloo_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/central_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/circle_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/district_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/east_london_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/hammersmith_&_city_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/jubilee_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/metropolitan_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/northern_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/piccadilly_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/victoria_line>
            type => "tube:line"
          )
          (
            resource => <1014/tube/waterloo_&_city_line>
            type => "tube:line"
          )
        }
      )
    }
  )
  (
    profile => <doi:1014/10.system/profile.dlr>
    {
      (
        resource => <>
        label => "Docklands Light Railway"
        detail => "TubeLand - Docklands Light Railway."
        {
          (
            resource => <1014/tube/docklands_light_railway>
            type => "dlr:network"
          )
        }
      )
    }
  )
}
