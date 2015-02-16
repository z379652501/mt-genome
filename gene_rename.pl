#!/usr/bin/env perl
# Perl script for converting mitochondrial gene names into consistent naming system.
# Usage: perl gene_rename.pl Himantolophus_groenlandicus_aa.fasta
# gene_rename.pl
# Yi-Jyun Luo | 2015.01.29

use strict;
use warnings;

open (FILE, $ARGV[0]) || die "cannot open the file for reading: $!";

while (<FILE>) {
 	if (/\>/) {
	$_ =~ s/nad/ND/g;
	$_ =~ s/NADH/ND/g;
	$_ =~ s/NAD/ND/g;
	$_ =~ s/ND4l/ND4L/g;
	$_ =~ s/COIII/COX3/g;
	$_ =~ s/COII/COX2/g;
	$_ =~ s/COI/COX1/g;
	$_ =~ s/COXIII/COX3/g;
	$_ =~ s/COXII/COX2/g;
	$_ =~ s/COXI/COX1/g;
	$_ =~ s/cox3/COX3/g;
	$_ =~ s/cox2/COX2/g;
	$_ =~ s/cox1/COX1/g;
	$_ =~ s/(Cyt b)/COB/g;
	$_ =~ s/Cytb/COB/g;
	$_ =~ s/cytb/COB/g;
	$_ =~ s/cob/COB/g;
	$_ =~ s/CYTB/COB/g;
	$_ =~ s/(ATPase )/ATP/g;
	$_ =~ s/atpase/ATP/g;
	$_ =~ s/atp/ATP/g;
	}
	print $_;
}

#--//
