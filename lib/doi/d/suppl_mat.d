# 
#    DOI use case: Suppl. Material/Article
# 
#    Here an article supplement is linked to the article.
# 
(:
  #  Suppl. Material/Article 
  resource => <doi:10.1006/asle.2000.0016.s001>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Suppl. Material 
          resource => <http://www.idealibrary.com/links/doi/10.1006/asle.2000.0016/dat/0016s01.ppt>
          label => "ASL (2000) 1: p. 156"
          type => "xref:Supplement"
          access => ":default"
        )
        (
          #  Article 
          resource => <doi:10.1006/asle.2000.0016>
          type => "xref:Article"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
