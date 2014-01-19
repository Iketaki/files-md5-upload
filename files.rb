require 'digest/md5'
require 'find'

root = ARGV.shift
root = "/" unless root

puts root
puts "Start processing"

md5_file = "md5.txt"

File.open(md5_file,"w") { |md5file|
  Find.find(root) do |path|
    if path.start_with?("/dev") || path.start_with?("/Volumes")
      Find.prune
    end

    if FileTest.file?(path)
      puts path
      begin
        md5file.puts Digest::MD5.file(path).hexdigest()
      rescue
      end
    end
  end
}
