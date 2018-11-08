#  
#   MetroRail
# 
#   MetroRail implements the YADS model to describe "Metro Rail"
#   - Los Angeles' underground rail network - as an example of a
#   complex resource association
# 
(:
  #  MetroRail 
  resource => <doi:1014/metro>
  label => "MetroRail"
  detail => "MetroRail implements the YADS model to describe "Metro Rail" - Los Angeles' underground rail network - as an example of a complex resource association"
  {
    (:
      #  Application Profile 
      resource => <doi:1014/profile.metro>
      type => "doi:Profile"
      label => "MetroRail"
      detail => "MetroRail - The LA Metro Rail."
      {
        (
          resource => <doi:1014/metro/blue_line>
          type => "metro:Line"
        )
        (
          resource => <doi:1014/metro/green_line>
          type => "metro:Line"
        )
        (
          resource => <doi:1014/metro/red_line>
          type => "metro:Line"
        )
      }
    :)
  }
:)
