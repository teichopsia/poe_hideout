#!/bin/bash

t=${1:-index.html}
cat $t|
perl -ne '
	if(/<tr id="([^"]+)"/){
		print "$1\n";
	}'|
perl -e '
	$/=undef;
	my @div=split(/\n/,<STDIN>);
	my @xf=(map{$_}(a..z));
	my $qin={};
	my $qout={};
	for(my $i=0;$i<=$#div;$i++){
		$qin->{$xf[$i]}=$div[$i];
		$qout->{$div[$i]}=$xf[$i];
	}
	print "var xlat={";
	sub pj{
		my($x)=@_;
		foreach my $k (keys %$x) {
			print $k,q@:"@,$x->{$k},q@",@;
		}
	}
	pj($qin);pj($qout);
	print "};";
'
