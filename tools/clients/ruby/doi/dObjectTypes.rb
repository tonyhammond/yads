########################################################################
#
# DObjectTypes - A Ruby class for DObject Types
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company 
#
########################################################################

class DObjectTypes

  DOI_TYPE_MAP      = "map"

  # General properties - DOI
  DOI_TYPE_ACCESS   = "access"
  DOI_TYPE_DETAIL   = "detail"
  DOI_TYPE_LABEL    = "label"
  DOI_TYPE_RESOLVE  = "resolve"
  DOI_TYPE_RESOURCE = "resource"
  DOI_TYPE_ROLE     = "role"
  DOI_TYPE_TYPE     = "type"

  # System properties - DOI
  DOI_TYPE_AGENT    = "agent"
  DOI_TYPE_NULL     = "null"
  DOI_TYPE_PROFILE  = "profile"
  DOI_TYPE_SCHEMA   = "schema"
  DOI_TYPE_SERVICE  = "service"

  HDL_DOI_SYSTEM_PREFIX = "1014/10.system"

  HDL_DOI_PREFIX        = "X-DOI_"
  HDL_DOI_TYPE_MAP      = "X-DOI_MAP"

  # General properties - Handle
  HDL_DOI_TYPE_ACCESS   = "X-DOI_ACCESS"
  HDL_DOI_TYPE_DETAIL   = "X-DOI_DETAIL"
  HDL_DOI_TYPE_LABEL    = "X-DOI_LABEL"
  HDL_DOI_TYPE_RESOLVE  = "X-DOI_RESOLVE"
  HDL_DOI_TYPE_RESOURCE = "X-DOI_RESOURCE"
  HDL_DOI_TYPE_ROLE     = "X-DOI_ROLE"
  HDL_DOI_TYPE_TYPE     = "X-DOI_TYPE"

  # System properties - Handle
  HDL_DOI_TYPE_AGENT    = "X-DOI_AGENT"
  HDL_DOI_TYPE_NULL     = "X-DOI_NULL"
  HDL_DOI_TYPE_PROFILE  = "X-DOI_PROFILE"
  HDL_DOI_TYPE_SCHEMA   = "X-DOI_SCHEMA"
  HDL_DOI_TYPE_SERVICE  = "X-DOI_SERVICE"

  # Legacy property - Handle
  HDL_TYPE_URL          = "URL"

  # RDF property type
  RDF_TYPE_LITERAL      = "literal"
  RDF_TYPE_RESOURCE     = "resource"

  # Type (aka property) hashes

  @@dataObjectType = {

    HDL_DOI_TYPE_MAP => DOI_TYPE_MAP,

    HDL_DOI_TYPE_ACCESS =>   DOI_TYPE_ACCESS,
    HDL_DOI_TYPE_DETAIL =>   DOI_TYPE_DETAIL,
    HDL_DOI_TYPE_LABEL =>    DOI_TYPE_LABEL,
    HDL_DOI_TYPE_RESOLVE =>  DOI_TYPE_RESOLVE,
    HDL_DOI_TYPE_RESOURCE => DOI_TYPE_RESOURCE,
    HDL_DOI_TYPE_ROLE =>     DOI_TYPE_ROLE,
    HDL_DOI_TYPE_TYPE =>     DOI_TYPE_TYPE,

    HDL_DOI_TYPE_AGENT =>    DOI_TYPE_AGENT,
    HDL_DOI_TYPE_NULL =>     DOI_TYPE_NULL,
    HDL_DOI_TYPE_PROFILE =>  DOI_TYPE_PROFILE,
    HDL_DOI_TYPE_SCHEMA =>   DOI_TYPE_SCHEMA,
    HDL_DOI_TYPE_SERVICE =>  DOI_TYPE_SERVICE,
   
  }

  @@handleServType = {

    DOI_TYPE_MAP =>      HDL_DOI_TYPE_MAP,

    DOI_TYPE_ACCESS =>   HDL_DOI_TYPE_ACCESS,
    DOI_TYPE_DETAIL =>   HDL_DOI_TYPE_DETAIL,
    DOI_TYPE_LABEL =>    HDL_DOI_TYPE_LABEL,
    DOI_TYPE_RESOLVE =>  HDL_DOI_TYPE_RESOLVE,
    DOI_TYPE_RESOURCE => HDL_DOI_TYPE_RESOURCE,
    DOI_TYPE_ROLE =>     HDL_DOI_TYPE_ROLE,
    DOI_TYPE_TYPE =>     HDL_DOI_TYPE_TYPE,

    DOI_TYPE_AGENT =>    HDL_DOI_TYPE_AGENT,
    DOI_TYPE_NULL =>     HDL_DOI_TYPE_NULL,
    DOI_TYPE_PROFILE =>  HDL_DOI_TYPE_PROFILE,
    DOI_TYPE_SCHEMA =>   HDL_DOI_TYPE_SCHEMA,
    DOI_TYPE_SERVICE =>  HDL_DOI_TYPE_SERVICE,

  }

  @@RDFType = {

    DOI_TYPE_ACCESS =>   RDF_TYPE_LITERAL,
    DOI_TYPE_DETAIL =>   RDF_TYPE_LITERAL,
    DOI_TYPE_LABEL =>    RDF_TYPE_LITERAL,
    DOI_TYPE_RESOLVE =>  RDF_TYPE_LITERAL,
    DOI_TYPE_RESOURCE => RDF_TYPE_RESOURCE,
    DOI_TYPE_ROLE =>     RDF_TYPE_LITERAL,
    DOI_TYPE_TYPE =>     RDF_TYPE_LITERAL,

    DOI_TYPE_AGENT =>    RDF_TYPE_RESOURCE,
    DOI_TYPE_NULL =>     RDF_TYPE_RESOURCE,
    DOI_TYPE_PROFILE =>  RDF_TYPE_RESOURCE,
    DOI_TYPE_SCHEMA =>   RDF_TYPE_RESOURCE,
    DOI_TYPE_SERVICE =>  RDF_TYPE_RESOURCE,

  }

  def DObjectTypes.is_dObject_type?(s)

    return @@handleServType.has_key?(s)

  end

  def DObjectTypes.is_handle_type?(s)

    return @@dataObjectType.has_key?(s)

  end

  def DObjectTypes.get_dObject_type(s)

    return @@dataObjectType[s]

  end

  def DObjectTypes.get_handle_type(s)

    return @@handleServType[s]

  end

  def DObjectTypes.is_rdf_literal?(s)

    if @@RDFType.has_key?(s)
      return @@RDFType[s] == RDF_TYPE_LITERAL
    else
      return false
    end

  end

  def DObjectTypes.is_rdf_resource?(s)

    if @@RDFType.has_key?(s)
      return @@RDFType[s] == RDF_TYPE_RESOURCE
    else
      return false
    end

  end

end
