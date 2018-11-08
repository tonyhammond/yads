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

