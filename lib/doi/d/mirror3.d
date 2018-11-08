# 
#    DOI use case: Mirror Sites (Extended Issue)
# 
#    Here a DLib issue is managed across five mirror sites. The origin
#    site - CNRI - is marked as the default. A table of contents for
#    this issue is also managed.
# 
(:
  #  DLib Issue (Mirror Sites and TOC) 
  resource => <doi:10.1045/july2001-contents>
  {
    (:
      #  DOI Profile 
      resource => <doi:10.0/profile.dlib>
      {
        (
          #  Description 
          resource => <>
          detail => "Resources for DLib Article <doi:10.1045/july2001-contents>"
        )
        (
          #  TOC 
          [
            (
              {
                (
                  resource => <data:,Generalizing%20the%20OpenURL%20Framework%20beyond%20References%20to%20Scholarly%20Works:%20The%20Bison-Fute%20Model>
                  type => "dlib:Title-String"
                )
                (
                  resource => <data:,Herbert%20Van%20de%20Sompel,%20Cornell%20University%20and%20Oren%20Beit-Arie,%20Ex%20Libris%20(USA)%20Inc.>
                  type => "dlib:Author-String"
                )
              }
            )
            (
              {
                (
                  resource => <data:,Digital%20Libraries%20and%20Education:%20Trends%20and%20Opportunities>
                  type => "dlib:Title-String"
                )
                (
                  resource => <data:,Hans%20Roes,%20Tilburg%20University%20Library>
                  type => "dlib:Author-String"
                )
              }
            )
            (
              {
                (
                  resource => <data:,E-Books%20and%20Their%20Future%20in%20Academic%20Libraries:%20An%20Overview>
                  type => "dlib:Title-String"
                )
                (
                  resource => <data:,Lucia%20Snowhill,%20University%20of%20California,%20Santa%20Barbara>
                  type => "dlib:Author-String"
                )
              }
            )
            (
              {
                (
                  resource => <data:,Penn%20State%20Visual%20Image%20User%20Study>
                  type => "dlib:Title-String"
                )
                (
                  resource => <data:,Henry%20Pisciotta,%20Roger%20Brisson,%20Eric%20Ferrin,%20Michael%20Dooris,%20and%20Amanda%20Spink,%20Pennsylvania%20State%20University>
                  type => "dlib:Author-String"
                )
              }
            )
          ]
          detail => "Table of Contents for July 2001 issue of D-Lib magazine."
        )
        (
          #  Mirror Sites 
          <
            (
              #  US Origin 
              resource => <http://www.dlib.org/dlib/july01/07contents.html>
              type => "dlib:Mirror"
              label => "Origin site - USA."
              detail => "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A."
              access => ":default"
            )
            (
              #  UK Mirror 
              resource => <http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/july01/07contents.html>
              type => "dlib:Mirror"
              label => "Mirror site - UK."
              detail => "UKOLN: The UK Office for Library and Information Networking, Bath, England"
            )
            (
              #  Australian Mirror 
              resource => <http://sunsite.anu.edu.au/mirrors/dlib/dlib/july01/07contents.html>
              type => "dlib:Mirror"
              label => "Mirror site - Australia."
              detail => "The Australian National University Sunsite, Canberra, Australia"
            )
            (
              #  German Mirror 
              resource => <http://webdoc.sub.gwdg.de/edoc/aw/d-lib/dlib/july01/07contents.html>
              type => "dlib:Mirror"
              label => "Mirror site - Germany."
              detail => "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany"
            )
            (
              #  Argentine Mirror 
              resource => <http://www.dlib.org.ar/dlib/july01/07contents.html>
              type => "dlib:Mirror"
              label => "Mirror site - Argentina."
              detail => "Universidad de Belgrano, Buenos Aires, Argentina"
            )
          >
          detail => "Origin and mirror websites."
        )
      }
      type => "doi:Profile"
    :)
  }
:)
