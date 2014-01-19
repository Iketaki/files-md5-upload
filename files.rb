#!/usr/bin/env ruby
#
# % sudo ruby files.rb /
#

require 'digest/md5'
require 'find'
require 'sdbm'
require 'ruby-progressbar'

root = ARGV.shift
root = "/" unless root

puts root
puts "Start processing"
puts "Counting number of files..."

md5_file = "md5.txt"

db = SDBM.open('db',0644)
# 対象dirのすべてのファイル数をあらかじめ取得
filecount = `find #{root} -type f|wc -l`.to_i
p filecount
#プログレスバーを作成
pb = ProgressBar.create(:starting_at => 0, :total => filecount, :format => "%a |%b>>%i|%c/%C")

File.open(md5_file,"w"){ |md5file|
  Find.find(root) do |path|
    if path.start_with?("/dev") || path.start_with?("/Volumes")
      Find.prune
    end

    if FileTest.file?(path)
      # puts path
      begin
        md5 = Digest::MD5.file(path).hexdigest()
        md5file.puts md5
        db[md5] = path
      rescue
      end
    # プログレスバーをすすめる
    pb.increment
    end
  end
}

db.close
