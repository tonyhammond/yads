# 
# 
#   YADS - EBNF
# 
#   This document describes YADS - A Description Service
#   in an Extended BNF.
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
# 
#   ==
# 
#   (*
#      In the following, EBNF ISO/IEC 14977 : 1996(E) (for a draft
#      see eg &lt;http://www.cl.cam.ac.uk/~mgk25/iso-14977.pdf&gt;) is
#      used to define a YADS resource description.
#   
#      Note that this EBNF is an abstract rule set and applies only
#      to the actual content of the resource description and not to
#      any markup or serialization used to convey that description.
#   
#      For example, in the generic XML serialization of YADS, this
#      EBNF applies only to the element content without markup tags.
#   
#      In EBNF ISO/IEC 14977 : 1996(E)
#   
#        [ ] means zero or one
#   
#        { } means zero or more
#   *)
#   
#   (* Structural elements for aggregating resources and properties. *)
#   
#   yads = { ( item | nest ) } ;
#   
#   item = {property}, ( resource | collection ), {property} ;
#   
#   nest = ( {property}, resource, {property}, collection, {property} )
#          | ( {property}, collection, {property}, resource, {property} ) ;
#   
#   (* Structural element for aggregating structural elements. *)
#   
#   collection = group, {group} ;
#   
#   group = item | nest ;
#   
#   (* Resource element as per RFC 2396. *)
#   
#   resource = any-uri ;
#   
#   (* Property elements attributing metadata to resources. Note that
#      only one property element of each type can be meaningfully applied
#      to a nest or to an item.  *)
#   
#   property = access | detail | directive | label | role | service | type ;
#   
#   (* An access point in the resource hierarchy. *)
#   access = string ;
#   
#   (* A human readable description. *)
#   detail = string ;
#   
#   (* A directive for a service component. *)
#   directive = string ;
#   
#   (* A presentational element for a display service. *)
#   label = string ;
#   
#   (* A relationship role to another resource. *)
#   role = string ;
#   
#   (* A service component. *)
#   service = string ;
#   
#   (* An application-specific type. *)
#   type = string ;
#   
#   (* Legitimate values for URI must comply to the syntax
#      defined in &lt;http://www.ietf.org/rfc/rfc2396.txt?number=2396&gt;. *)
#   
#   (* Productions for "any-uri" and "string" terminals need to be added. *)
# 
# 
