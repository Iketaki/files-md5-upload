#!/usr/bin/env ruby
require 'digest/md5'
require 'find'

root = ARGV.shift || "/"

File.open("md5.txt", "w") do |md5file|
  Find.find(root) do |path|

    if path.start_with?("/dev") || path.start_with?("/Volumes")
      Find.prune
    end

    if FileTest.file?(path)
      puts path
      begin
        md5 = Digest::MD5.file(path).hexdigest()
        md5file.puts "#{md5}\t#{path}"
      rescue => e
        STDERR.puts e
      end
    end

  end
end
