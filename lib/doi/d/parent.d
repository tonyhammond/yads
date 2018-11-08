# 
#    DOI use case: Journal
# 
#    Here a journal title is identified and key metadata elements
#    about the title are managed.
# 
(:
  #  Journal 
  resource => <doi:10.1006/jmbi>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          resource => <http://www.idealibrary.com/links/toc/jmbi>
          label => "J. Mol. Biol."
          type => "xref:Journal"
          access => ":default"
        )
        (
          resource => <data:,Journal%20of%20Molecular%20Biology>
          type => "xref:Journal-Title"
        )
        (
          resource => <data:,J.%20Mol.%20Biol.>
          type => "xref:Journal-Abbrev"
        )
        (
          resource => <data:,1089-8638>
          type => "xref:Online-ISSN"
        )
        (
          resource => <data:,0022-2836>
          type => "xref:Print-ISSN"
        )
        (
          resource => <data:,JMOBAK>
          type => "xref:CODEN"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
