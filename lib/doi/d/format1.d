# 
#    DOI use case: Formats (Links)
# 
#    Here two manifestations of a journal article are managed. Links
#    are made to each resource.
# 
(:
  #  Article (Format Links) 
  resource => <doi:10.1006/jmbi.2002.5438>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          {
            (
              #  Article 
              resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.2002.5438>
              access => ":default"
            )
            (
              <
                (
                  #  HTML Format 
                  resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.2002.5438/full>
                  type => "xref:Format-HTML"
                )
                (
                  #  PDF Format 
                  resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.2002.5438/pdf>
                  type => "xref:Format-PDF"
                )
              >
            )
          }
          label => "J. Mol. Biol. (2002) 317: p. 375"
          type => "xref:Article"
        )
      }
    :)
  }
:)
