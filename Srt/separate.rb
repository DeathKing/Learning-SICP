#!/usr/bin/env ruby

if ARGV.empty?
    puts "Separate - Seprate Duo-Language into Two Single File"
    puts "Usage: separate srt_file"
    puts "Writen by DeathKing"
    exit
end

eng = []
chn = []
cont = []

open(ARGV[0]).each_line { |line|
    puts line.inspect
    if line == "\r\n"
        puts  "i am a block"
        # a block is full
        eng << cont[0] << cont[1]
        chn << cont[0] << cont[1]
        if cont.size != 4
            for i in 2...cont.size
                chn << cont[i]
            end
            chn << "\r\n"
            eng << "-- Remain to be recheck  --\r\n"
        else
            chn << cont[2] << "\r\n";
            eng << cont[3] << "\r\n";
        end
        cont.clear
    else
        cont << line
    end
}

puts eng
puts "hi~"

filename = ARGV[0].split(".")[0]
eng_file = "#{filename}-eng.srt"
chn_file = "#{filename}-chn.srt" 

open(eng_file, "w").puts(eng.join)
open(chn_file, "w").puts(chn.join)
