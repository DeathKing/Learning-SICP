open(FILE, "lec1a.txt") || die "no such file:$!";
open(OUTPUT, ">lec1a.ttxt") || die "what:$!";

@filelist=<FILE>;
select OUTPUT;
foreach $eachline (@filelist) {
    chomp($eachline);
    @array = split(/[.?!;,]/, $eachline);
    for ($i = 0; $i < $#array; ++$i) {
	print $array[$i]."\n\n";
    }
    print pop(@array);
    $ch = substr($eachline, length($eachline)-1, 1);
    if ($ch eq ' ' || $ch == /\w/) {
	print " ";
    }
    else {
	print "\n\n";
    }
}
close FILE;
close OUTPUT;

