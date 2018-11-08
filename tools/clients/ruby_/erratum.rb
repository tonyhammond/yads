require 'dataObject.rb'

###
doi = '10.1006/abio.2000.4984'
label = 'Anal. Biochem. 2000; 290(2): 260-271'
artref = '10.1006/abio.2001.5293'
###

p = 'doi:1014/10.1000/system.profile.crossref'

d2 = DataObject.new("1014/#{doi}")

d2.deleteDataStore

c2 = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("resource", "http://www.idealibrary.com/links/doi/#{doi}") \
         .addData("access", "default") \
         .addData("label", label) \
      )

unless artref.empty?
  c2.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/#{artref}") \
     .addData("role", "relative") \
     .addData("type", "xref:Erratum") \
  )  
end

d2.addContainer(c2, p)
d2.dumpDataGroups

d2.createDataStore
exit
###
doi = '10.1006/abio.2001.5293'
label = 'Anal. Biochem. 2001; 295(1): 127-127'
artref = '10.1006/abio.2000.4984'
###

p = 'doi:1014/10.1000/system.profile.crossref'

d1 = DataObject.new("1014/#{doi}")
d1.deleteDataStore

c1 = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("resource", "http://www.idealibrary.com/links/doi/#{doi}") \
         .addData("access", "default") \
         .addData("label", label) \
      )

unless artref.empty?
  c1.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/#{artref}") \
     .addData("role", "relative") \
     .addData("type", "xref:Original") \
  )  
end

d1.addContainer(c1, p)
d1.dumpDataGroups

d1.createDataStore
exit
###
doi = '10.1006/abio.2000.4984'
label = 'Anal. Biochem. 2000; 290(2): 260-271'
artref = '10.1006/abio.2001.5293'
###

p = 'doi:1014/10.1000/system.profile.crossref'

d2 = DataObject.new("1014/#{doi}")
p d2; exit
d2.deleteDataStore

c2 = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new \
           .addDataGroup(DataGroup.new \
             .addData("resource", "http://www.idealibrary.com/links/doi/#{doi}") \
             .addData("access", "default") \
           ) \
         ) \
         .addData("label", label) \
      )

unless artref.empty?
  c2.addDataGroup(DataGroup.new \
     .addData("relation", "doi:1014/#{artref}") \
     .addData("role", "relative") \
     .addData("type", "xref:Erratum") \
  )  
end

d2.addContainer(c2, p)
d2.dumpDataGroups

d2.createDataStore
