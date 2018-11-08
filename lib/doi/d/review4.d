# 
#    DOI use case: Book Review List (Last)
# 
#    Here a list of resources is managed. This is the last list member
#    and identifies the previous member in the chain.
# 
(:
  #  Book Review 
  resource => <doi:10.1006/anbo.2001.1476>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Review 
          resource => <http://www.idealibrary.com/links/doi/10.1006/anbo.2001.1476>
          label => "Ann. Bot. (2001) 88: p. 520"
          type => "xref:Review"
          access => ":default"
        )
        (
          #  Prev Review 
          resource => <doi:10.1006/anbo.2001.1475>
          role => "doi:preceding_sibling"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
