# 
#    DOI use case: Erratum/Article
# 
#    Here an erratum is (backward) linked to the article it revises.
# 
(:
  #  Erratum/Article 
  resource => <doi:10.1006/geno.2002.6726>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Erratum 
          resource => <http://www.idealibrary.com/links/doi/10.1006/geno.2002.6726>
          label => "Genomics (2002) 79: p. 462"
          type => "xref:Erratum"
          access => ":default"
        )
        (
          #  Article 
          resource => <doi:10.1006/geno.2001.6453>
          type => "xref:Article"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
