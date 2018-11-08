require 'dataObject.rb'

baseURL = 'http://www.doi.org/ebooks/CDI-BEA-Demo-Offline/'

d = DataObject.new("1014/cdi.demo")
d.deleteDataStore
p = 'doi:1014/10.1000/system.profile.ebooks'

c = Container.new \
      .addDataGroup(DataGroup.new \
         .addData("contains", Container.new("seq") \
           .addDataGroup(DataGroup.new \
             .addData("label", "Publisher's Catalog Page") \
             .addData("resource", "#{baseURL}2A-CATALOGPAGE.htm") \
             .addData("access", "default") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("label", "Read a Free Excerpt") \
             .addData("resource", "#{baseURL}2B-EXCERPTPAGE.htm") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("label", "Get Bibliographic Info") \
             .addData("resource", "#{baseURL}2C-METADATAPAGE.htm") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("label", "Read Reviews") \
             .addData("contains", Container.new("seq") \
               .addDataGroup(DataGroup.new \
                 .addData("label", "Business Week") \
                 .addData("resource", "#{baseURL}2-BWREVIEW.htm") \
               ) \
               .addDataGroup(DataGroup.new \
                 .addData("label", "The New York Times") \
                 .addData("resource", "#{baseURL}3-NYTREVIEW.htm") \
               ) \
             ) \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("label", "Buy This Book") \
             .addData("contains", Container.new("seq") \
               .addDataGroup(DataGroup.new \
                 .addData("label", "Microsft Reader") \
                 .addData("contains", Container.new("seq") \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "Contentville.com") \
                     .addData("resource", "#{baseURL}4A-BUYLIT-CONTENTVILLE.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "Amazon.com") \
                     .addData("resource", "#{baseURL}4B-BUYLIT-AMAZON.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                 ) \
               ) \
               .addDataGroup(DataGroup.new \
                 .addData("label", "Adobe eBook Reader") \
                 .addData("contains", Container.new("seq") \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "Barnes & Noble") \
                     .addData("resource", "#{baseURL}4D-BUYPDF-B&N.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "McGraw-Hill eBookstore") \
                     .addData("resource", "#{baseURL}4E-BUYPDF-MCGRAWHILL.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                 ) \
               ) \
               .addDataGroup(DataGroup.new \
                 .addData("label", "RocketBook/GemStar") \
                 .addData("contains", Container.new("seq") \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "Barnes & Noble") \
                     .addData("resource", "#{baseURL}4F-BUYGEM-B&N.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                 ) \
               ) \
               .addDataGroup(DataGroup.new \
                 .addData("label", "Palm Reader") \
                 .addData("contains", Container.new("seq") \
                   .addDataGroup(DataGroup.new \
                     .addData("label", "Peanut Press") \
                     .addData("resource", "#{baseURL}4G-BUYPALM-PEANUTPRESS.htm") \
                     .addData("type", "cdi:ebook_format") \
                   ) \
                 ) \
               ) \
             ) \
           ) \
         ) \
      )

d.addContainer(c, p)
# d.dumpDataGroups

d.createDataStore
exit
