#!/usr/bin/env ruby
# *encoding: UTF-8*

require 'json'

def avatar(contributor)
  "![](#{contributor['avatar']})"
end

def name(contributor)
  "[#{contributor['name']}](https://github.com/#{contributor['name']})"
end

db = JSON.parse(File.open('contributor.json').read)

result = db.each_slice(5).map do |line|
  row = ""
  row << "|" + line.map {|contri| avatar(contri)}.join("|") + "|\n"
  row << "|" + line.map {|contri| name(contri)}.join("|") + "|" 
end.join("\n")

puts result