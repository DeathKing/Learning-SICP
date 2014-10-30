#! /usr/bin/perl
use 5.010;
use utf8;
use warnings;
use strict;

my $srt_file = shift(@ARGV);
open SRT, '<:encoding(UTF-8)', $srt_file;

my @text = <SRT>;

close SRT;

if (@ARGV) {
    $srt_file = shift(@ARGV);
}

open NEWSRT, '>:encoding(UTF-8)', $srt_file;

foreach my $line (@text) {
    chomp($line);
    $line =~ s/((?:[,.?!;:])|(?:-+))\s/$1\n\n\n\n/g;
    print NEWSRT $line;
}

close NEWSRT;
