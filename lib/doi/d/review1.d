# 
#    DOI use case: Book Review List (First)
# 
#    Here a list of resources is managed. This is the first list member
#    and identifies the next in the chain.
# 
(:
  #  Book Review 
  resource => <doi:10.1006/anbo.2001.1478>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Review 
          resource => <http://www.idealibrary.com/links/doi/10.1006/anbo.2001.1478>
          label => "Ann. Bot. (2001) 88: p. 517"
          type => "xref:Review"
          access => ":default"
        )
        (
          #  Next Review 
          resource => <doi:10.1006/anbo.2001.1474>
          role => "doi:following_sibling"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
