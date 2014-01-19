#!/usr/bin/env ruby
#
# % sudo ruby files.rb /
#

require 'digest/md5'
require 'find'
require 'sdbm'

root = ARGV.shift
root = "/" unless root

puts root
puts "Start processing"

md5_file = "md5.txt"

db = SDBM.open('db',0644)

File.open(md5_file,"w"){ |md5file|
  Find.find(root) do |path|
    if path.start_with?("/dev") || path.start_with?("/Volumes")
      Find.prune
    end

    if FileTest.file?(path)
      puts path
      begin
        md5 = Digest::MD5.file(path).hexdigest()
        md5file.puts md5
        db[md5] = path
      rescue
      end
    end
  end
}

db.close
