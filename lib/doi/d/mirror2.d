# 
#    DOI use case: Mirror Sites (Issue)
# 
#    Here a DLib issue is managed across five mirror sites. The origin
#    site - CNRI - is marked as the default.
# 
(:
  #  DLib Issue (Mirror Sites) 
  resource => <doi:10.1045/july2001-contents>
  {
    (:
      #  Profile 
      resource => <doi:10.0/profile.crossref>
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
      type => "doi:Profile"
    :)
  }
:)
