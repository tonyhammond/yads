#!/home/tony/bin/ruby

require 'dataObject'

require 'cgi'

cgi = CGI.new
hParams = cgi.params		# CGI parameter hash

$debug = 0
# $debug += ARGV[1].to_i

if hParams.has_key?('doi')

  doi = hParams['doi'][0]

end
# doi = ARGV[0]

  print "content-type: text/html\n\n"

class DataObject

  def to_menus

    depth = 0
    props = []
    stack = [ [ depth, props ] ]
    offset = 1
    item = 0

    menus = Array.new(@dataMap.length, 0); menus[1] = 1
    menuKey = ""

    hMenus = {} 
    aMenu = []

    @dataMap.scan(/\S+/).each do |s|

      case s

        when "{", "[", "<"

          item = 0
	
          print "\"#{s}\": ", menus[1..16].join("_"), "\n" if $debug > 1
          print "\"#{s}\": ", menus[1..offset].join("_"), "\n" if $debug > 0

          menuKey = menus[1..offset].join("_")

#          (depth, props) = stack[-1]

#           hMenus[menuKey].each { |a| props << a } \
#             if hMenus.key?(menuKey) and not hMenus[menuKey].empty?

          props << ["contains", "<i>rdf:Bag</i>"] if s == "{"
          props << ["contains", "<i>rdf:Seq</i>"] if s == "["
          props << ["contains", "<i>rdf:Alt</i>"] if s == "<"
          hMenus[menuKey] = props

          offset += 1; depth += 1; props = []; stack << [ depth, props ]

          menuKey = menus[1..offset].join("_")
          hMenus[menuKey] = props

        when "}", "]", ">"

          offset -= 1; stack.pop; (depth, props) = stack[-1]
          
          print "\"#{s}\": ", menus[1..16].join("_"), "\n" if $debug > 1
          print "\"#{s}\": ", menus[1..offset].join("_"), "\n" if $debug > 0

        when "("

          item += 1

          menus[offset] = depth; props = []

          print "\"#{s}\": ", menus[1..16].join("_"), "\n" if $debug > 1
          print "\"#{s}\": ", menus[1..offset].join("_"), "\n" if $debug > 0

          menuKey = menus[1..offset].join("_")

          hMenus[menuKey].each { |a| props << a } \
            if hMenus.key?(menuKey) and not hMenus[menuKey].empty?

          props << ["dataGroup", "<i>rdf:_#{item}</i>"]
          hMenus[menuKey] = props

          offset += 1; menus[offset] += 1; depth = 0; props = []; stack << [ depth, props ]

          menuKey = menus[1..offset].join("_")
          hMenus[menuKey] = props

        when ")"
          
          print "\"#{s}\": ", menus[1..16].join("_"), "\n" if $debug > 1
          print "\"#{s}\": ", menus[1..offset].join("_"), "\n" if $debug > 0
          
          menuKey = menus[1..offset].join("_")
          hMenus[menuKey] = props

          offset -= 1; stack.pop; (depth, props) = stack[-1]

        else

          depth += 1

          print "\"#{s}\": ", menus[1..16].join("_"), "\n" if $debug > 1
          print "\"#{s}\": ", menus[1..offset].join("_"), "\n" if $debug > 0

          (type, data) = @dataObject[s.to_i]
          props << [type, data]

      end

    end

    hMenus.sort.each do |keyProps, valProps|

      next if valProps.empty?
      print "arMenu#{keyProps} = new Array("
      print "200,\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"," if keyProps == "1"
      print "\n"

      valProps.each do |key, val|

        case key

          when /resource/
            aMenu << "\"<b>[#{key}]</b> #{val}\", \"#{val}\", 0"

          when /relation|profile/
            bare_doi = val.sub(/^doi:/, "")
            aMenu << "\"<b>[#{key}]</b> #{val}\", \"http://www2.harcourt-international.com/ap/servlet/yads?rtnType=menus&doi=#{bare_doi}\", 0"

          when /contains|dataGroup/
            aMenu << "\"<b>[#{key}]</b> #{val}\", \"\", 1"

          else
            aMenu << "\"<b>[#{key}]</b> \\\"#{val}\\\"\", \"\", 0"

        end

      end

      print aMenu.join(",\n"); aMenu.clear
      print "\n)\n\n"

    end
 
  end

end

if $debug > 0

  d = DataObject.get(doi).to_menus
  exit

else

    aFile = File.new("/opt/HARCap/servlets/doi/doi_menus.js")
    aFile.each { |line|
      line.sub!(/(tri.gif)/, "http://www2.harcourt-international.com/~tony/ruby/ruby/tri.gif")
      print line
    }

    print <<EOT

<SCRIPT LANGUAGE="JavaScript1.2" TYPE="text/javascript">
<!--
if (isMenu) {
EOT
    
d = DataObject.get(doi).to_menus

    print <<EOT
}
//--> </SCRIPT>
EOT


sLine = "<body>\n"
        sLine << "This is <a href="
        sLine << "\"javascript:void(0)\" "
        sLine << "onMouseOver=\"popUp(\'elMenu1\',event)\" "
        sLine << "onMouseOut=\"popDown(\'elMenu1\')\" "
        sLine << "onClick=\"return false\""
        sLine << ">doi:#{doi}</a> as a menu popup."

print sLine

end
