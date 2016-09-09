#!/usr/bin/env ruby
# encoding: utf-8

if ARGV.empty?
    puts "Separate - 分割单个双语字幕为两个字幕。"
    puts "用法: separate srt_file"
    puts "说明：如果出错了，尝试调整一下newline。"
    puts "Writen by DeathKing"
    exit
end

eng = []
chn = []
cont = []

# 换行符，由于文件比较混乱，有时需要自行调整
# 如有问题，可以尝试调整为 \n、\r、\r\n中的其它值
newline = "\n" 

open(ARGV[0]).each_line do |line|
    if line == newline
        # 一个块 
        eng << cont[0] << cont[1]
        chn << cont[0] << cont[1]
        # 非字幕块，即为制作信息时的处理
        # 把内容全拷贝到中文字幕文件中
        # 英文字幕用newline占位
        if cont.size != 4
            for i in 2...cont.size
                chn << cont[i]
            end
            chn << newline
            eng << newline << newline
        else
            # 拷贝到对应文件中去
            chn << cont[2] << newline
            eng << cont[3] << newline
        end
        cont.clear
    else
        cont << line
    end
end

filename = ARGV[0].split(".")[0]
eng_file = "#{filename}_eng.srt"
chn_file = "#{filename}_chn.srt" 

open(eng_file, "w").puts(eng.join)
open(chn_file, "w").puts(chn.join)
