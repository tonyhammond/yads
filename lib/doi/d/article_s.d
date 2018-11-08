# 
#    DOI use case: Article/Suppl. Material
# 
#    Here an article is linked to an article supplement.
# 
(:
  #  Article/Suppl. Material 
  resource => <doi:10.1006/asle.2000.0016>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Article 
          resource => <http://www.idealibrary.com/links/doi/10.1006/asle.2000.0016>
          label => "ASL (2000) 1: p. 156"
          type => "xref:Article"
          access => ":default"
        )
        (
          #  Suppl. Material 
          resource => <doi:10.1006/asle.2000.0016.s001>
          type => "xref:Supplement"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
