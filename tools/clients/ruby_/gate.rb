require 'dataObject.rb'

###
doi = '10.1006/jmbi.2001.6014'
label = 'J. Mol. Biol. 213(2), 2001: 312-344'
artref = '10.1006/jmbi.2000.3912'
###

d = DataObject.new("1014/#{doi}")
p = 'doi:1014/10.1000/system.profile.crossref'

c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("resource", "http://www.idealibrary.com/links/doi/#{doi}") \
             .addData("role", "default") \
           ) \
         ) \
         .addData("label", label) \
      )

unless artref.empty?
  c.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/#{artref}") \
     .addData("type", "xref:Erratum") \
  )  
end

d.addContainer(c, p)
d.dumpDataGroups

# puts "\nRDF for doi:#{d.doi}\n\n#{d}"

# d.createDataStore
