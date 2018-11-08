########################################################################
#
# dlib_may.rb - A Ruby program to build the (pseudo) DOI DataObject
#               '10.1045/may2001-contents' using the prototype DOI Service API  
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
#
########################################################################

require 'dataObject.rb'

# Create a new DataObject

d = DataObject.new("1014/10.1045/june2001-contents")

d.deleteDataStore

dg = DataGroup.new \

# Create the originating site

dg0 = DataGroup.new \
      .addData("resource", "http://www.dlib.org/dlib/may01/05contents.html") \
      .addData("role", "default") \
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
        .addData("detail", "Original and mirror websites.") \
        .addContainer(mirrorSites))

# Add the Container to the DataObject

d.addContainer(c, "doi:10.1000/system.profile.dlib_magazine")

# And now create the DataStore

# d.dumpDataGroups
d.createDataStore

