########################################################################
#
# dlib_apr.rb - A Perl program to build the (pseudo) DOI DataObject
#               '10.1045/april2001-contents' using the prototype DOI Service API  
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
# 
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
#
########################################################################

use DOI::DataObject;

# Create a new DataObject

$d = new DOI::DataObject("10.1045/april2001-contents");

# Create the originating site

$dg0 = new DOI::DataGroup
       ->addData("resource", "http://www.dlib.org/dlib/april01/04contents.html")
       ->addData("label", "The Corporation for National Research Initiatives, Reston, Virginia, U.S.A. (originating site)");

# Create the mirror sites

$dg1 = new DOI::DataGroup
       ->addData("resource", "http://mirrored.ukoln.ac.uk/lis-journals/dlib/dlib/dlib/april01/04contents.html")
       ->addData("label", "UKOLN: The UK Office for Library and Information Networking, Bath, England (mirror site)");

$dg2 = new DOI::DataGroup
       ->addData("resource", "http://sunsite.anu.edu.au/mirrors/dlib/dlib/april01/04contents.html")
       ->addData("label", "The Australian National University Sunsite, Canberra, Australia (mirror site)");

$dg3 = new DOI::DataGroup
       ->addData("resource", "http://webdoc.sub.gwdg.de/edoc/aw/d-lib/dlib/april01/04contents.html")
       ->addData("label", "State Library of Lower Saxony and the University Library of Goettingen, Goettingen, Germany (mirror site)");

$dg4 = new DOI::DataGroup
       ->addData("resource", "http://www.dlib.org.ar/dlib/april01/04contents.html")
       ->addData("label", "Universidad de Belgrano, Buenos Aires, Argentina (mirror site)");

# Add the DataGroups to the DataObject

$d->addDataGroup($dg0)
  ->addDataGroup($dg1)
  ->addDataGroup($dg2)
  ->addDataGroup($dg3)
  ->addDataGroup($dg4);

# And now create the DataStore

$d->dumpDataGroups;
# $d->createDataStore;



