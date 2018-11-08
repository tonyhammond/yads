require 'dataObject.rb'

###
doi = '10.system/registry.global'
###

d = DataObject.new("1014/#{doi}")
p = 'doi:10.system/profile.system'

c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("label", "DOI global registry") \
         .addData("detail", "Global registry for DOI system registries") \
         .addData('contains', Container.new \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:10.system/type.null") \
             .addData("role", "parent") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:10.system/registry.agents") \
             .addData("role", "child") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:10.system/registry.resolvers") \
             .addData("role", "child") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:10.system/registry.profiles") \
             .addData("role", "child") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("relation", "doi:10.system/registry.types") \
             .addData("role", "child") \
           ) \
         ) \
      )


d.addContainer(c, p)
d.dumpDataGroups

# puts "\nRDF for doi:#{d.doi}\n\n#{d}"

d.createDataStore
