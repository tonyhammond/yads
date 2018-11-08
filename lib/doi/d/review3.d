# 
#    DOI use case: Book Review List (Next)
# 
#    Here a list of resources is managed. This is a list member
#    and identifies the previous and next members in the chain.
# 
(:
  #  Book Review 
  resource => <doi:10.1006/anbo.2001.1475>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          #  Review 
          resource => <http://www.idealibrary.com/links/doi/10.1006/anbo.2001.1475>
          label => "Ann. Bot. (2001) 88: p. 518"
          type => "xref:Review"
          access => ":default"
        )
        (
          #  Prev Review 
          resource => <doi:10.1006/anbo.2001.1474>
          role => "doi:preceding_sibling"
        )
        (
          #  Next Review 
          resource => <doi:10.1006/anbo.2001.1476>
          role => "doi:following_sibling"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
