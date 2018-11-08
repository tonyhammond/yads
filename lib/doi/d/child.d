# 
#    DOI use case: Article/Journal
# 
#    Here an article is linked to its parent journal.
# 
(:
  #  Article/Journal 
  resource => <doi:10.1006/jmbi.1993.1460>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Article 
          resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.1993.1460>
          label => "J. Mol. Biol. (1993) 232: p.1060"
          type => "xref:Article"
          access => ":default"
        )
        (
          #  Journal 
          resource => <doi:10.1006/jmbi>
          type => "xref:Journal"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
