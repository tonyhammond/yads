require 'dObject.rb'

d = DObject.new.from_rdf(DObjectInstance.new.rdf)
# d = DObject.new.from_rdf(File.new("extended.rdf").readlines.join("\n"))

puts d.to_n3, "\n", d.to_dump
d.dump
__END__
