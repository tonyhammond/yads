#!/usr/local/bin/ruby

########################################################################
#
# yadt - Yet Another DOI Tool (this version for Ruby)
#
# Author - Tony Hammond <tony_hammond@harcourt.com>
#
# Copyright (c) 2001 by Academic Press, a Harcourt Science and Technology 
# Company
# 
########################################################################

require 'dataObject'
require 'getoptlong'

class YADT

  attr_reader :opts

  YADT_VERSION = '0.1'
  
  def initialize

    _options = GetoptLong.new(
      [ "-r", "--random",	GetoptLong::NO_ARGUMENT ],	# Random DOI
      [ "-x", "--xml",		GetoptLong::NO_ARGUMENT ],	# Print XML
      [ "-d", "--dump",		GetoptLong::NO_ARGUMENT ],	# Dump
      [ "-t", "--types",	GetoptLong::NO_ARGUMENT ],	# Types
      [ "-v", "--values",	GetoptLong::NO_ARGUMENT ],	# Values
      [ "-k", "--kernel",	GetoptLong::NO_ARGUMENT ],	# Kernel Metadata
      [ "-m", "--metadata",	GetoptLong::NO_ARGUMENT ],	# Profile Metadata
      [ "-u", "--username",	GetoptLong::REQUIRED_ARGUMENT ],# Authorized Username
      [ "-p", "--password",	GetoptLong::REQUIRED_ARGUMENT ],# Authorized Password
      [ "-h", "--help",		GetoptLong::NO_ARGUMENT ],	# Help
      [ "-V", "--version",	GetoptLong::NO_ARGUMENT ]	# Version
    )
    
    @opts = {}
    _options.each { |key, val| @opts[key] = val }
    _options.terminate
  
  end


  def YADT._version
  
     print <<EOT
This is YADT (Yet Another DOI Tool, Ruby version #{YADT_VERSION})
  
Copyright 2001, Academic Press, Harcourt, Inc.
  
This program is free software you can redistribute it and/or
modify it under the same terms as Ruby itself.
EOT
  
  exit

  end
  
  
  def YADT._usage
  
    print <<EOT
  
Usage: yadt [options] <doi> ...
  
  -r          : get random DOI
  -x          : print DataObject as XML

  -d          : print dump of the DataGroups
  -t          : print the DataObject data types
  -v          : print the DataObject values
  
  -k          : print DOI Kernel Metadata
  -m          : print DOI Application Profile Metadata
  -u username : authorized username
  -p password : authorized password
  
  -h          : print this help message
  -V          : print the version number of yadt
  
EOT
  
  exit

  end
  
end
  
  y = YADT.new

  if y.opts.key?('-h') then YADT._usage end
  if y.opts.key?('-V') then YADT._version end
  
  args = ARGV
  args << "?" if y.opts.key?('-r')

  while (doi = args.shift)
  
    doi.sub!(/^doi:/, "")	# Remove possible URI scheme
  
    d = DataObject.get(doi)

    if y.opts.key?('-u') then d.authUsername = y.opts['-u'] end
    if y.opts.key?('-p') then d.authPassword = y.opts['-p'] end

    y.opts.each do |key, val|
  
      case key
  
        when /^-+x/ then puts d

        when /^-+d/ then d.dumpDataGroups
        when /^-+t/ then puts d.dataTypes
        when /^-+v/ then puts d.dataValues
  
        when /^-+k/ then puts d.kernelMetadata
        when /^-+m/ then puts d.profileMetadata
  
      end
  
    end
  
  end
  

__END__
