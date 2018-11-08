# 
#    DOI use case: Article/Erratum
# 
#    Here an article is (forward) linked to an erratum.
# 
(:
  #  Article/Erratum 
  resource => <doi:10.1006/geno.2001.6453>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Article 
          resource => <http://www.idealibrary.com/links/doi/10.1006/geno.2001.6453>
          label => "Genomics (2001) 73: p. 223"
          type => "xref:Article"
          access => ":default"
        )
        (
          #  Erratum 
          resource => <doi:10.1006/geno.2002.6726>
          type => "xref:Erratum"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
