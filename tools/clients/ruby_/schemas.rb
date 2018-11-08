require 'dataObject.rb'

p = 'doi:1014/10.1000/system.profile.system'

d = DataObject.new("doi:1014/10.1000/system.registry.schemas")
d.deleteDataStore
d.addContainer(Container.new \
       .addDataGroup(DataGroup.new \
         .addData("label", "DOI Schema Registry") \
         .addData("detail", "Registry for DOI Application Schemas.") \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.registry.global") \
             .addData("role", "parent") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-07-26") \
             .addData("role", "child") \
             .addData("access", "default") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-03-26") \
             .addData("role", "child") \
           ) \
         ) \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-01-12") \
             .addData("role", "child") \
           ) \
         ) \
       ), p)

d.createDataStore
exit

schema = 'doi-schema-2001-07-26'
d = DataObject.new("doi:1014/10.1000/system.schema.#{schema}")
d.deleteDataStore
c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("resource", "http://www2.harcourt-international.com/~tony/schemas/#{schema}.rdfs") \
             .addData("role", "default") \
           ) \
         ) \
      )

  c.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-03-26") \
     .addData("role", "preceding-sibling") \
  )  

d.addContainer(c, p)
d.createDataStore

schema = 'doi-schema-2001-03-26'
d = DataObject.new("doi:1014/10.1000/system.schema.#{schema}")
d.deleteDataStore
c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("resource", "http://www2.harcourt-international.com/~tony/schemas/#{schema}.rdfs") \
             .addData("role", "default") \
           ) \
         ) \
      )

  c.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-07-26") \
     .addData("role", "following-sibling") \
  )  
  c.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-01-12") \
     .addData("role", "preceding-sibling") \
  )  

d.addContainer(c, p)
d.createDataStore

schema = 'doi-schema-2001-01-12'
d = DataObject.new("doi:1014/10.1000/system.schema.#{schema}")
d.deleteDataStore
c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("resource", "http://www2.harcourt-international.com/~tony/schemas/#{schema}.rdfs") \
             .addData("role", "default") \
           ) \
         ) \
      )

  c.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/10.1000/system.schema.doi-schema-2001-03-26") \
     .addData("role", "following-sibling") \
  )  

d.addContainer(c, p)
d.createDataStore
