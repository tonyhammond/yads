# 
# 
#   Description of Echo example using YADS.
# 
# 
(
  #  Deliverables 
  type => "Deliverables\n2003"
  {
    (
      #  Identifiers 
      type => "Identifiers"
      detail => "IETF"
      {
        (
          type => "RFC\ndoi:"
        )
        (
          type => "RFC\nniso:"
        )
      }
    )
    (
      #  Metadata 
      type => "Metadata"
      detail => "Lists: rss_dev, rdf-interest"
      {
        (
          type => "PRISM"
          {
            (
              type => "RSS 1.0\nprism:"
            )
            (
              type => "RDF\nSchema"
            )
          }
        )
        (
          type => "OpenURL"
          {
            (
              type => "RSS 1.0\nopen:"
            )
            (
              type => "RDF\nSchema"
            )
          }
        )
        (
          type => "CrossRef"
          {
            (
              type => "RSS 1.0\nxref:"
            )
            (
              type => "RDF\nSchema"
            )
          }
        )
      }
    )
    (
      #  OpenURL 
      type => "OpenURL"
      detail => "NISO"
      {
        (
          type => "Z39.88-2003"
        )
        (
          type => "DC Format"
        )
        (
          type => "PRISM Format"
        )
      }
    )
    (
      #  Publications 
      type => "Publications"
      detail => "XML, DLib, W3C"
      {
        (
          type => "XML.com"
          label => "What's the Point of RSS?\nCreating Applications through Extensibility"
        )
        (
          type => "DLib"
          label => "Using OpenURL ... Differently"
        )
        (
          type => "W3C Note"
          label => "OpenURL Framework Primer"
        )
        (
          type => "Elsevier"
          label => "DOI White Paper"
        )
      }
    )
  }
)
