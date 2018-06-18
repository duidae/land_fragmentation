#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

my $filename = "data.txt";
open(my $FILE, '<:encoding(UTF-8)', $filename) or die "Cant open file $filename";

my %hash = ();

while(my $line = <$FILE>) {
	chomp($line);

	my @values = split('	', $line);

	push @{$hash{$values[1]}}, $values[0];
	#print "$values[0] $values[1]\n";
}
close($FILE);

# traverse hash
my $counter = 0;
foreach my $group (keys %hash) {
	$counter++;
	my $A = 0;
	my $suma2 = 0;
	my $sumroot2 = 0;
	
	foreach my $a (@{$hash{$group}}) {
		$A += $a;
		$suma2 += ($a*$a);
		$sumroot2 += sqrt($a);

		#print "$counter $group $a\n";
	}
	
	my $simpson = 1 - $suma2/($A*$A);
	my $JI = sqrt($A)/$sumroot2;

	print "$counter $group A=$A simpson=$simpson JI=$JI\n";
}
