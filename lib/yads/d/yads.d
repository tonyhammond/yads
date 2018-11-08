# 
# 
#   YADS - Schema Library
# 
#   This document describes YADS - A Description Service.
#   Three schema library collections are managed: BNF, RDF, and XML.
# 
# 
(:
  #  Schema Library for YADS 
  resource => <http:yads.xml>
  {
    (:
      #  BNF Library 
      resource => <doi:1014/yads>
      {
        (
          #  ISO Schema 
          resource => <http:yads-ebnf.xml>
          label => "EBNF"
          type => "yads:EBNF"
        )
      }
      type => "yads:BNF Schemas"
    :)
    (:
      #  RDF Library 
      resource => <doi:1014/yads>
      {
        (
          #  W3C Schema 
          resource => <http:yads-rdfs.xml>
          label => "RDF/XML"
          type => "yads:RDF/XML"
          access => ":default"
        )
        (
          #  W3C Schema 
          resource => <http:yads-n3.xml>
          label => "RDF/N3"
          type => "yads:RDF/N3"
        )
        (
          #  W3C Schema 
          resource => <http:yads-daml.xml>
          label => "DAML+OIL"
          type => "yads:DAML+OIL"
        )
      }
      type => "yads:RDF Schemas"
    :)
    (:
      #  XML Library 
      resource => <doi:1014/yads>
      {
        (
          #  W3C Schema 
          resource => <http:yads-dtd.xml>
          label => "XML DTD"
          type => "yads:XML DTD"
        )
        (
          #  Oasis Schema 
          resource => <http:yads-rng.xml>
          label => "RELAX NG"
          type => "yads:RELAX NG"
        )
        (
          #  W3C Schema 
          resource => <http:yads-xsd.xml>
          label => "XML Schema"
          type => "yads:XML Schema"
        )
        (
          #  R. Jelliffe Schema 
          resource => <http:yads-sch.xml>
          label => "Schematron"
          type => "yads:Schematron"
        )
        (
          #  J. Ramalho Schema 
          resource => <http:yads-xcsl.xml>
          label => "XCSL"
          type => "yads:XCSL"
        )
        (
          #  OMG Schema 
          resource => <http:yads-xmi.xml>
          label => "MOF/XMI"
          type => "yads:MOF/XMI"
        )
      }
      type => "yads:XML Schemas"
    :)
  }
  label => "Schemas for YADS"
  type => "yads:Schemas"
:)
