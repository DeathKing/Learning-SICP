#!/usr/bin/env ruby

if ARGV.empty?
    puts "Separate - Seprate Duo-Language into Two Single File"
    puts "Usage: separate srt_file"
    puts "Writen by DeathKing"
    exit
end

newline = case RUBY_PLATFORM
when /linux|bsd|solaris/
    "\n"
when /darwin|mac os/
    "\r"
when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    "\r\n"
end

eng = []
chn = []
cont = []

open(ARGV[0]).each_line { |line|
    puts line.inspect
    if line == newline
        # a block is full
        eng << cont[0] << cont[1]
        chn << cont[0] << cont[1]
        if cont.size != 4
            for i in 2...cont.size
                chn << cont[i]
            end
            chn << "newline"
            eng << "-- Remain to be recheck  -- #{newline}"
        else
            chn << cont[2] << newline;
            eng << cont[3] << newline;
        end
        cont.clear
    else
        cont << line
    end
}

filename = ARGV[0].split(".")[0]
eng_file = "#{filename}-eng.srt"
chn_file = "#{filename}-chn.srt" 

open(eng_file, "w").puts(eng.join)
open(chn_file, "w").puts(chn.join)
