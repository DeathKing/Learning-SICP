#!/usr/bin/env ruby

# MERGE.RB: merge two subtitles into one.
#
# usage: merge file1 file2 [output_file]
#
# options: -b   backup original file
require_relative 'util'

class IO

  def each_unit(lines)
    result = []
    each_line do |line|
      result << line
      if result.size == lines
        yield result
        result = []
      end
    end
    result << "" until result.size == lines
    yield result
  end

end

SubUnit = Struct.new(:number, :timeline, :content, :tag)

target = ARGV[2]

unless ARGV.size >= 3
  backup_file File.expand_path(ARGV[0])
  backup_file File.expand_path(ARGV[1])
  target = ARGV[0]
end

chn = []
eng = []

open(ARGV[0]).each_unit(4) do |u|
  number, timeline, content, _ = *u
  chn << SubUnit.new(number, timeline, content, 'chn')
end

open(ARGV[1]).each_unit(4) do |u|
  number, timeline, content, _ = *u
  eng << SubUnit.new(number, timeline, content, 'eng')
end

# actual_merge
merged = []
chn.zip(eng) do |p|
  chn, eng = *p
  if chn.timeline != eng.timeline
    puts "Some thing unmatched found:"
    puts "[CHN %4s %30s]%s" % [chn.number, chn.timeline, chn.content]
    puts "[ENG %4s %30s]%s" % [eng.number, eng.timeline, eng.content]
    puts "Aborted!"
    exit(0)
  end
  chn.content = "#{chn.content}#{eng.content}"
  merged << chn
end

open(target, "w") do |f|
  merged.each do |m|
    f.puts m.number
    f.puts m.timeline
    f.puts m.content
    f.puts "\n"
  end
end
