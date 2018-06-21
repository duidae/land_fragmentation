#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

my $filename = "0620.csv";
open(my $FILE, '<:encoding(UTF-8)', $filename) or die "Cant open file $filename";

my %hash_area = ();
my %hash_other = ();

while(my $line = <$FILE>) {
	chomp($line);

	my @values = split(' ', $line);

	push @{$hash_area{$values[3]}}, $values[4];
	push @{$hash_other{$values[3]}}, ("$values[0]", "$values[1]", "$values[2]" , "$values[3]", "$values[4]\n");

	#print "$values[0] $values[1]\n";
}
close($FILE);

# traverse hash
my $counter = 0;
foreach my $group (keys %hash_area) {
	$counter++;
	my $A = 0;
	my $suma2 = 0;
	my $sumroot2 = 0;
	
	foreach my $a (@{$hash_area{$group}}) {
		$A += $a;
		$suma2 += ($a*$a);
		$sumroot2 += sqrt($a);

		#print "$counter $group $a\n";
	}
	
	#foreach my $a (@{$hash_other{$group}}) {
	#	print "$a";
	#}

	print "$hash_other{$group}[0]-$hash_other{$group}[1]-$hash_other{$group}[2]-$hash_other{$group}[4]";

	my $simpson = 1 - $suma2/($A*$A);
	my $JI = sqrt($A)/$sumroot2;

	print "= = = $group A=$A simpson=$simpson JI=$JI\n";
}
