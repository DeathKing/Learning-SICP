#!/usr/bin/env ruby
# --* encoding: utf-8 *--
require 'fileutils'

cont = []
block = []
counter, flag = 1, false
newline = "\n"
template = "%d#{newline}00:00:00,000 --> 00:00:00,000#{newline}"

if ARGV.empty?
    puts "Timeline - 为字幕添加初始化时间轴。"
    puts "用法： timeline /path/to/your/file.srt"
    puts "说明：本地会备份一个文件。如果使用出现了问题，请尝试调整newline。"
    puts "\nWriten by DeathKing"
    exit
end

FileUtils.cp ARGV[0], ARGV[0] + ".backup"
open(ARGV[0]).each_line do |line|
    if line == newline and !flag
        cont << sprintf(template, counter) << block.clone << newline
        flag = true
        counter += 1
        block.clear
    else
        block << line
        flag = false
    end
end

open(ARGV[0], "w").puts(cont.join)
