# 
# 
#   YADS - DTD
# 
#   This document describes YADS - A Description Service
#   in an XML DTD.
# 
#   ==
# 
#   // From RDF Schema for YADS
# 
#   Resource:     doi:1014/yads-schema-2002-04-03
#   Comment:      RDF Schema for YADS - A Description Service
#   Author:       Tony Hammond <tony_hammond@harcourt.com>
#   Revision:     April 3, 2002 - Tony Hammond
# 
#   Copyright (c) 2002 Elsevier Science Ltd. All rights reserved. 
# 
#   ==
# 
#   <!DOCTYPE yads [
# 
#   <!ELEMENT yads (item|nest)*>
# 
#   <!ELEMENT item (property*, (collection | resource), property*)>
#   <!ELEMENT nest ((property*, collection, property*, resource, property*)
#                  | (property*, resource, property*, collection, property*))>
# 
#   <!ELEMENT collection (item | nest)+>
#   <!ATTLIST collection
#     order (choice | sequenced | unordered) "unordered"
#   >
# 
#   <!ELEMENT resource (#PCDATA)> 
# 
#   <!ELEMENT property (#PCDATA)> 
#   <!ATTLIST property
#     access CDATA #IMPLIED
#     detail CDATA #IMPLIED
#     directive CDATA #IMPLIED
#     label CDATA #IMPLIED
#     role CDATA #IMPLIED
#     service CDATA #IMPLIED
#     type CDATA #IMPLIED
#   >
# 
#   ]>
# 
# 
