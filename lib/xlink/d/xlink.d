# 
# 
#   An XLink extended link modelled using YADS.
# 
#   This example is taken from section 5.1 of the XLink spec,
#   "XML Linking Language (XLink) Version 1.0", see
# 
#   http://www.w3.org/TR/2001/REC-xlink-20010627/
# 
# 
(:
  #  XLink extended link 
  resource => <>
  {
    (
      #  XLink title element 
      resource => <data:,Course%20Load%20for%20Pat%20Jones>
      type => "tooltip"
    )
    (
      #  XLink locator element 
      resource => <href:students/patjones62.xml>
      type => "person"
      access => "student62"
      role => "http://www.example.com/linkprops/student"
      label => "Pat Jones"
    )
    (
      #  XLink locator element 
      resource => <href:profs/jaysmith7.xml>
      type => "person"
      access => "prof7"
      role => "http://www.example.com/linkprops/professor"
      label => "Dr. Jay Smith"
    )
    (
      #  XLink locator element 
      resource => <href:courses/cs101.xml>
      type => "course"
      access => "CS-101"
      role => "http://www.example.com/linkprops/professor"
      label => "Computer Science 101"
    )
    (
      #  XLink resource element 
      resource => <data:,3.5>
      type => "gpa"
      access => "PatJonesGPA"
    )
    (
      #  XLink arc element 
      {
        (
          #  XLink arc tail 
          resource => <data:,student62>
          directive => "xlink:from"
        )
        (
          #  XLink arc head 
          resource => <data:,PatJonesGPA>
          directive => "xlink:to"
        )
      }
      type => "go"
      label => "Pat Jones's GPA"
      directive => "xlink:show='new';actuate='onRequest'"
    )
    (
      #  XLink arc element 
      {
        (
          #  XLink arc tail 
          resource => <data:,CS-101>
          directive => "xlink:from"
        )
        (
          #  XLink arc head 
          resource => <data:,student62>
          directive => "xlink:to"
        )
      }
      type => "go"
      label => "Pat Jones, auditing the course"
      directive => "xlink:show='replace';actuate='onRequest'"
      role => "http://www.example.com/linkprops/auditor"
    )
    (
      #  XLink arc element 
      {
        (
          #  XLink arc tail 
          resource => <data:,student62>
          directive => "xlink:from"
        )
        (
          #  XLink arc head 
          resource => <data:,prof7>
          directive => "xlink:to"
        )
      }
      type => "go"
      label => "Dr. Jay Smith, advisor"
      directive => "xlink:show='replace';actuate='onRequest'"
      role => "http://www.example.com/linkprops/advisor"
    )
  }
  type => "courseload"
:)
