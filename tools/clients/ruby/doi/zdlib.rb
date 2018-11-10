########################################################################
#
# dlib_may.rb - A Ruby program to build the (pseudo) DOI DataObject
#               '10.1045/may2001-contents' using the prototype DOI Service API  
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
########################################################################

require 'dObject.rb'

# Create a new DataObject

d = DObject.new("1014/10.1045/july2001-contents")

dg = Group.new \

dg01 = Group.new \
       .addContainer \
         (Container.new \
           .addGroup(Group.new \
             .addMember("type", "dlib:title_string") \
             .addMember("label", "Generalizing the OpenURL Framework beyond References to Scholarly Works: The Bison-Fute Model") \
           ) \
           .addGroup(Group.new \
             .addMember("type", "dlib:author_string") \
             .addMember("label", "Herbert Van de Sompel, Cornell University and Oren Beit-Arie, Ex Libris (USA) Inc.") \
           )
         )

dg02 = Group.new \
       .addContainer \
         (Container.new \
           .addGroup(Group.new \
             .addMember("type", "dlib:title_string") \
             .addMember("label", "Digital Libraries and Education:Trends and Opportunities") \
           ) \
           .addGroup(Group.new \
             .addMember("type", "dlib:author_string") \
             .addMember("label", "Hans Roes, Tilburg University Library")
           )
         )

dg03 = Group.new \
       .addContainer \
         (Container.new \
           .addGroup(Group.new \
             .addMember("type", "dlib:title_string") \
             .addMember("label", "E-Books and Their Future in Academic Libraries: An Overview") \
           ) \
           .addGroup(Group.new \
             .addMember("type", "dlib:author_string") \
             .addMember("label", "Lucia Snowhill, University of California, Santa Barbara")
           )
         )

dg04 = Group.new \
       .addContainer \
         (Container.new \
           .addGroup(Group.new \
             .addMember("type", "dlib:title_string") \
             .addMember("label", "Penn State Visual Image User Study") \
           ) \
           .addGroup(Group.new \
             .addMember("type", "dlib:author_string") \
             .addMember("label", "Henry Pisciotta, Roger Brisson, Eric Ferrin, Michael Dooris, and Amanda Spink, Pennsylvania State University")
           )
         )

toc = Container.new("seq") \
      .addGroup(dg01) \
      .addGroup(dg02) \
      .addGroup(dg03) \
      .addGroup(dg04) \

# Create the originating site

dg0 = Group.new \
      .addMember("resource", "http://www.dlib.org/dlib/may01/05contents.html") \
      .addMember("label", "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A.") \
      .addMember("detail", "Originating site - USA.") 

# Create the mirror sites

dg1 = Group.new \
      .addMember("resource", "http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/may01/05contents.html") \
      .addMember("label", "UKOLN: The UK Office for Library and Information Networking, Bath, England") \
      .addMember("detail", "Mirror site - UK.") 

dg2 = Group.new \
      .addMember("resource", "http://sunsite.anu.edu.au/mirrors/dlib/dlib/may01/05contents.html") \
      .addMember("label", "The Australian National University Sunsite, Canberra, Australia") \
      .addMember("detail", "Mirror site - Australia.") 

dg3 = Group.new \
      .addMember("resource", "http://webdoc.sub.gwdg.de/edoc/aw/d-lib/dlib/may01/05contents.html") \
      .addMember("label", "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany") \
      .addMember("detail", "Mirror site - Germany.") 

dg4 = Group.new \
      .addMember("resource", "http://www.dlib.org.ar/dlib/may01/05contents.html") \
      .addMember("label", "Universidad de Belgrano, Buenos Aires, Argentina") \
      .addMember("detail", "Mirror site - Argentina.") 

# Add the Groups to the Container

mirrorSites = Container.new("alt") \
    .addGroup(dg0) \
    .addGroup(dg1) \
    .addGroup(dg2) \
    .addGroup(dg3) \
    .addGroup(dg4)


c = Container.new("bag") \
      .addGroup(Group.new \
        .addMember("detail", "Table of Contents for July 2001 issue of D-Lib magazine.") \
        .addContainer(toc)) \
      .addGroup(Group.new \
        .addMember("detail", "Original and mirror websites.") \
        .addContainer(mirrorSites))

# Add the Container to the DataObject

d.forProfile("doi:10.system/profile.dlib_magazine")
d.setHierarchy(c)

# And now create the DataStore

# d.dump
# d.createDataStore
print d

