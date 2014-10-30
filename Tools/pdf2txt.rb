#!/usr/bin/env ruby

# Gist from: https://gist.github.com/blazeeboy/9722831

#begin
  require 'pdf/reader'
  require 'fileutils'
#ensure
 # puts "Oops! Must something went wrong."
#  puts "I think you should try `gem install pdf-reader` before excute this."
#  exit
#end

# credits to :
#   https://github.com/yob/pdf-reader/blob/master/examples/text.rb
# usage example: 
#   ruby pdf2txt.rb /path-to-file/file1.pdf [/path-to-file/file2.pdf..]

Dir.foreach(ARGV.first) do |filename|
  next if [".", ".."].include? filename
  PDF::Reader.open(filename) do |reader|
 
    puts "Converting : #{filename}"
    pageno = 0
    txt = reader.pages.map do |page| 
 
      pageno += 1
      begin
        print "Converting Page #{pageno}/#{reader.page_count}\r"
        page.text 
      rescue
        puts "Page #{pageno}/#{reader.page_count} Failed to convert"
        ''
      end
 
    end # pages map
 
    puts "\nWriting text to disk"
    File.write filename+'.txt', txt.join("\n")
 
  end # reader
 
end # each