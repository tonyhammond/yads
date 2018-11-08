# 
#    DOI use case: Formats (Info)
# 
#    Here two manifestations of a journal article are managed. Information
#    about format availability is recorded.
# 
(:
  #  Article (Format Metadata) 
  resource => <doi:10.1006/jmbi.2002.5438>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Article 
          resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.2002.5438>
          label => "J. Mol. Biol. (2002) 317: p. 375"
          type => "xref:Article"
          access => ":default"
        )
        (
          <
            (
              #  HTML Format 
              resource => <data:,HTML>
            )
            (
              #  PDF Format 
              resource => <data:,PDF>
            )
          >
          type => "xref:Format"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
