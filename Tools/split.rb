#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'util'

def help
  doc = <<-HELP

  HELP
end


filename = ARGV.first

backup_file(filename)

puts File.open(filename).each_line.map do |line|
  line.gsub! "\n", ""
  line.gsub! ". ", ".\n"
  line.strip!
  line
end.join