use DOI::DataObject;

###
$doi = '10.1006/jmbi.2001.1423';
$label = 'J. Mol. Biol. 213(2), 2001: 312-344';
$artref = '10.1006/jmbi.2000.3912';
###

$d = new DOI::DataObject("1014/$doi");
$p = 'doi:1014/10.system/profile.crossref';

$c = new DOI::Container()
      ->addDataGroup(new DOI::DataGroup()
         ->addData("resource", "http://www.idealibrary.com/links/doi/$doi")
         ->addData("label", $label)
      );

if ($artref) {
  $c->addDataGroup(new DOI::DataGroup()
     ->addData("relation", "doi:1014/$artref")
     ->addData("type", "xref:Erratum")
  );
}

$d->addContainer($c, $p);
$d->dumpDataGroups();

# print $d->toString();
# $d->createDataStore();
