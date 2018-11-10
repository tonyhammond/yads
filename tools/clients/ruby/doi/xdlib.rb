########################################################################
#
# dlib_may.rb - A Ruby program to build the (pseudo) DOI DataObject
#               '10.1045/may2001-contents' using the prototype DOI Service API  
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
########################################################################

require 'dataObject.rb'

# Create a new DataObject

d = DataObject.new("1014/10.1045/july2001-contents")

dg = DataGroup.new \

dg01 = DataGroup.new \
       .addContainer \
         (Container.new \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:title_string") \
             .addData("label", "Generalizing the OpenURL Framework beyond References to Scholarly Works: The Bison-Fute Model") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:author_string") \
             .addData("label", "Herbert Van de Sompel, Cornell University and Oren Beit-Arie, Ex Libris (USA) Inc.") \
           )
         )

dg02 = DataGroup.new \
       .addContainer \
         (Container.new \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:title_string") \
             .addData("label", "Digital Libraries and Education:Trends and Opportunities") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:author_string") \
             .addData("label", "Hans Roes, Tilburg University Library")
           )
         )

dg03 = DataGroup.new \
       .addContainer \
         (Container.new \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:title_string") \
             .addData("label", "E-Books and Their Future in Academic Libraries: An Overview") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:author_string") \
             .addData("label", "Lucia Snowhill, University of California, Santa Barbara")
           )
         )

dg04 = DataGroup.new \
       .addContainer \
         (Container.new \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:title_string") \
             .addData("label", "Penn State Visual Image User Study") \
           ) \
           .addDataGroup(DataGroup.new \
             .addData("type", "dlib:author_string") \
             .addData("label", "Henry Pisciotta, Roger Brisson, Eric Ferrin, Michael Dooris, and Amanda Spink, Pennsylvania State University")
           )
         )

toc = Container.new("seq") \
      .addDataGroup(dg01) \
      .addDataGroup(dg02) \
      .addDataGroup(dg03) \
      .addDataGroup(dg04) \

# Create the originating site

dg0 = DataGroup.new \
      .addData("resource", "http://www.dlib.org/dlib/may01/05contents.html") \
      .addData("label", "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A.") \
      .addData("detail", "Originating site - USA.") 

# Create the mirror sites

dg1 = DataGroup.new \
      .addData("resource", "http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/may01/05contents.html") \
      .addData("label", "UKOLN: The UK Office for Library and Information Networking, Bath, England") \
      .addData("detail", "Mirror site - UK.") 

dg2 = DataGroup.new \
      .addData("resource", "http://sunsite.anu.edu.au/mirrors/dlib/dlib/may01/05contents.html") \
      .addData("label", "The Australian National University Sunsite, Canberra, Australia") \
      .addData("detail", "Mirror site - Australia.") 

dg3 = DataGroup.new \
      .addData("resource", "http://webdoc.sub.gwdg.de/edoc/aw/d-lib/dlib/may01/05contents.html") \
      .addData("label", "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany") \
      .addData("detail", "Mirror site - Germany.") 

dg4 = DataGroup.new \
      .addData("resource", "http://www.dlib.org.ar/dlib/may01/05contents.html") \
      .addData("label", "Universidad de Belgrano, Buenos Aires, Argentina") \
      .addData("detail", "Mirror site - Argentina.") 

# Add the DataGroups to the Container

mirrorSites = Container.new("alt") \
    .addDataGroup(dg0) \
    .addDataGroup(dg1) \
    .addDataGroup(dg2) \
    .addDataGroup(dg3) \
    .addDataGroup(dg4)


c = Container.new("bag") \
      .addDataGroup(DataGroup.new \
        .addData("detail", "Table of Contents for July 2001 issue of D-Lib magazine.") \
        .addContainer(toc)) \
      .addDataGroup(DataGroup.new \
        .addData("detail", "Original and mirror websites.") \
        .addContainer(mirrorSites))

# Add the Container to the DataObject

p c
d.addContainer(c, "doi:10.system/profile.dlib_magazine")

# And now create the DataStore

# d.dump
# d.createDataStore
# print d

