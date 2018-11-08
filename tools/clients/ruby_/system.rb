require 'dataObject.rb'

p = 'doi:1014/10.1000/system.profile.system'

d = DataObject.new("doi:1014/10.1000/system.registry.profiles")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Profile Registry") \
         .addData("detail", "Registry for DOI Application Profiles.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.profile.system") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.profile.zero") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.profile.base") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.profile.crossref") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.profile.system")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "System Profile") \
         .addData("detail", "System profile - The DOI system profile for system DOIs.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.profiles") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("label", "Void") \
             .addData("role", "genre") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("agent", "doi:1014/10.1000/system.agent.default") \
             .addData("contains", Container.new \
               .addDataGroup(DataGroup.new \
                 .addData("service", "doi:1014/10.1000/system.type.null") \
                 .addData("role", "metadata") \
               ) \
             ) \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.profile.zero")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "Zero Profile") \
         .addData("detail", "Zero profile - A DOI Application Profile for legacy DOIs with no kernel metadata.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.profiles") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("label", "Any") \
             .addData("role", "genre") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("agent", "doi:1014/10.1000/system.agent.default") \
             .addData("contains", Container.new \
               .addDataGroup(DataGroup.new \
                 .addData("service", "doi:1014/10.1000/system.type.null") \
                 .addData("role", "metadata") \
               ) \
             ) \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.profile.base")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "Base Profile") \
         .addData("detail", "Base profile - A DOI Application Profile for DOIs with only kernel metadata.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.profiles") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("label", "Any") \
             .addData("role", "genre") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("agent", "doi:10.1014/1000/system.agent.default") \
             .addData("contains", Container.new \
               .addDataGroup(DataGroup.new \
                 .addData("service", "doi:1014/10.1000/system.type.null") \
                 .addData("role", "metadata") \
               ) \
             ) \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.profile.crossref")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "CrossRef Profile") \
         .addData("detail", "CrossRef profile - A DOI Application Profile for the CrossRef application which resolves journal article DOIs from bibliographic metadata queries.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.profiles") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("label", "Scholarly journal article") \
             .addData("role", "genre") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("agent", "doi:1014/10.1000/system.agent.pila") \
             .addData("contains", Container.new \
               .addDataGroup(DataGroup.new \
                 .addData("service", "http://query.crossref.org/tony/xref.cgi") \
                 .addData("schema", "http://www.crossref.org/docs/doi_batch.dtd") \
                 .addData("role", "metadata") \
               ) \
             ) \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

exit

d = DataObject.new("doi:1014/10.1000/system.registry.global")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Global Registry") \
         .addData("detail", "Global registry for DOI system registries.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.agents") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.profiles") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.resolvers") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.schemas") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.registry.agents")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Agent Registry") \
         .addData("detail", "Registry for DOI Registration Agents.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.default") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.pila") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.registry.default")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "Default RA") \
         .addData("detail", "Default DOI Registration Agent - the International DOI Foundation.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.agents") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "http://www.doi.org") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.registry.default")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "PILA") \
         .addData("detail", "Publishers International Linking Association.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.agents") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "http://www.crossref.org") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.registry.types")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Type Registry") \
         .addData("detail", "Registry for registered DOI system handle types.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.access") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.agent") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.alias") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.detail") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.label") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.null") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.profile") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.relation") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.resource") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.role") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.schema") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.service") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.type.type") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.access")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_ACCESS") \
         .addData("detail", "Handle type 'X-DOI_ACCESS' - value is string literal giving resource access point.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_ACCESS") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.agent")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_AGENT") \
         .addData("detail", "Handle type 'X-DOI_AGENT' - value is URI for a DOI Registration Agent.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_AGENT") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.alias")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_ALIAS") \
         .addData("detail", "Handle type 'X-DOI_ALIAS' - value is URI for a DOI alias (equivalent to 'HS_ALIAS').") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_ALIAS") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.detail")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_DETAIL") \
         .addData("detail", "Handle type 'X-DOI_DETAIL' - value is string literal giving a description.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_DETAIL") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.label")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_LABEL") \
         .addData("detail", "Handle type 'X-DOI_LABEL' - value is string literal with descriptive label.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_LABEL") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.null")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_NULL") \
         .addData("detail", "Handle type 'X-DOI_NULL' - value is empty string literal.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_NULL") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.profile")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_PROFILE") \
         .addData("detail", "Handle type 'X-DOI_PROFILE' - value is URI for DOI Application Profile.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_PROFILE") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.relation")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_RELATION") \
         .addData("detail", "Handle type 'X-DOI_RELATION' - value is URI for related object.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_RELATION") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.resource")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_RESOURCE") \
         .addData("detail", "Handle type 'X-DOI_RESOURCE' - value is URI for related resource.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_RESOURCE") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.role")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_ROLE") \
         .addData("detail", "Handle type 'X-DOI_ROLE' - value is string literal for DOI type role.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_ROLE") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.schema")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_SCHEMA") \
         .addData("detail", "Handle type 'X-DOI_SCHEMA' - value is URI for DOI Application schema.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_SCHEMA") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.service")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_SERVICE") \
         .addData("detail", "Handle type 'X-DOI_SERVICE' - value is URI for a DOI service.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_SERVICE") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.type.type")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "X-DOI_TYPE") \
         .addData("detail", "Handle type 'X-DOI_TYPE' - value is string literal for DOI type extension.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.types") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "hdl:0.type/X-DOI_TYPE") \
       ), p)

# d.dump
d.createDataStore

exit
=begin

d = DataObject.new("doi:1014/10.1000/system.registry.schemas")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Schema Registry") \
         .addData("detail", "Registry for DOI Application schemas.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.schema.2001-07-26") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.schema.2001-07-26")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI System Schema") \
         .addData("detail", "Schema for DOI System.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.schemas") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "") \
       ), p)

# d.dump
d.createDataStore

# Resolver Registry

d = DataObject.new("doi:1014/10.1000/system.registry.resolvers")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Resolver Registry") \
         .addData("detail", "Registry for DOI resolvers.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.resolver.dx") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.resolver.yads") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.resolver.dx")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Proxy") \
         .addData("detail", "Default DOI resolver - the 'DOI Proxy Server'.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.resolvers") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "http://dx.doi.org") \
       ), p)

# d.dump
d.createDataStore

d = DataObject.new("doi:1014/10.1000/system.resolver.yads")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "YADS") \
         .addData("detail", "Yet Another DOI Service") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.resolvers") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("resource", "http://dx.doi.org/1014/yads") \
         .addData("schema", "http://dx.doi.org/1014/yads.xsd") \
       ), p)

# d.dump
d.createDataStore

