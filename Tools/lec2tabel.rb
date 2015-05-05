#!/usr/bin/env ruby
# *encoding: UTF-8*

require 'json'

AUTHORS = {
  "ChingfanTsou"   => "https://github.com/ChingfanTsou",
  "DeathKing"      => "https://github.com/DeathKing",
  "endyul"         => "https://github.com/endyul",
  "Michael Savior" => "https://github.com/mut0u"
}

FORMAT = "| %-6s | %-30s | %-4s | %-7s | %-8s | %-20s |" 

def render_authors(authors)
  puts authors
  res = []
  authors.each do |a|
    res << (AUTHORS.has_key?(a) ? render_as_mdlink(a, AUTHORS[a]) : a)
  end
  res.join(", ")
end

def render_as_mdlink(text, link)
  "[#{text}](#{link})"
end

def itemize(row)
  FORMAT % [
    row["id"],
    "《" + row["title"] + "》",
    render_as_mdlink("优酷", row["youku"]),
    render_as_mdlink("YouTube", row["youtube"]),
    render_as_mdlink("百度网盘", row["baidu"]),
    render_authors(row["translator"])
  ]
end

def table_head
  FORMAT % [
    "编号",
    "标题",
    "优酷",
    "YouTube",
    "下载地址",
    "译者"
  ]
end

def divider
  FORMAT % %w{- - - - - -}
end

content = File.open('lec.json').read

db = JSON.parse(content)

puts table_head
puts divider

db.each do |row|
  puts itemize(row)
end

