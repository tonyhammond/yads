# 
#    DOI use case: Co-Hosting
# 
#    Here the IDEAL and BioMedNet platforms are managed by this DOI.
#    The IDEAL platform is marked as the default resource, and the
#    BioMedNet platform indicates that it accepts CrossRef parameters.
# 
(:
  #  Co-Hosted Article 
  resource => <doi:10.1006/jmbi.2001.5337>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.crossref>
      {
        (
          <
            (
              #  IDEAL 
              resource => <http://www.idealibrary.com/links/doi/10.1006/jmbi.2001.5337>
              type => "xref:Host"
              label => "IDEAL"
              access => ":default"
            )
            (
              #  BioMedNet 
              resource => <http://journals.bmn.com/journals/list/latest?uid=JMB.etd01126_10976868_v0316i02_00005337&node=TOC%40%40JMB%40316%4002%40316_02>
              type => "xref:Host"
              label => "BioMedNet"
              directive => "xref:params"
            )
          >
          label => "J. Mol. Biol. (2002) 316: p. 217"
          type => "xref:Article"
        )
      }
      type => "doi:Profile"
    :)
  }
:)
