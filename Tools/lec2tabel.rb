#!/usr/bin/env ruby
# *encoding: UTF-8*

require 'json'

AUTHORS = {
  "ChingfanTsou"   => "https://github.com/ChingfanTsou",
  "DeathKing"      => "https://github.com/DeathKing",
  "endyul"         => "https://github.com/endyul",
  "Michael Savior" => "https://github.com/mut0u",
  "rtmagic"        => "https://github.com/rtmagic"
}

FORMAT = "| %-s | %-s | %-s | %-s | %-s | %-s |"

ICON = {
  "youtube" => "https://cloud.githubusercontent.com/assets/895809/7487454/7bcde098-f3ea-11e4-85be-d267459c4974.png",
  "youku"   => "https://cloud.githubusercontent.com/assets/895809/7487453/7ad84a02-f3ea-11e4-9af4-2f8c4dc8679d.png",
  "baidu"   => "https://cloud.githubusercontent.com/assets/895809/7487452/7aca0af0-f3ea-11e4-97a2-9ad4af3c6e2e.png"
}

def render_authors(authors)
  res = []
  authors.each do |a|
    res << (AUTHORS.has_key?(a) ? render_as_mdlink(a, AUTHORS[a]) : a)
  end
  res.join(", ")
end

def render_as_mdlink(text, link)
  "[#{text}](#{link})"
end

def render_as_mdpic(alt, link)
  "![#{alt}](#{link})"
end

def render_as_mdpiclink(picurl, text, link)
  render_as_mdlink render_as_mdpic(text, picurl), link
end

def itemize(row)
  FORMAT % [
    row["id"],
    "《" + row["title"] + "》",
    render_as_mdpiclink(ICON["youku"],      "优酷", row["youku"]),
    render_as_mdpiclink(ICON["youtube"], "YouTube", row["youtube"]),
    render_as_mdpiclink(ICON["baidu"],   "百度网盘", row["baidu"]),
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
  "| ---- | ---- |:----:|:-------:|:--------:| ---- |"
end

content = File.open('lec.json').read

db = JSON.parse(content)

puts table_head
puts divider

db.each do |row|
  puts itemize(row)
end




