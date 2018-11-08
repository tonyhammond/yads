require 'dObject.rb'

# d = DObject.new.from_rdf(DObjectInstance.new.rdf)
d = DObject.new.from_rdf(File.new("rdf/extended.rdf").readlines.join("\n"))

# d.dumpMap; exit
# d.dump

d.Groups(".*", "Mirror").each do |group|
  print "(\n"
  group.each do |type, data|
    print "  #{type} => #{data}\n"
  end
  print ")\n"
end


