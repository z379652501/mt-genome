#!/usr/bin/env perl
# Perl script for rename the raw reads from Illumina, where "1" refers to forward and "2" refers to reverse. 
# rename_pair_read_header.pl
# Usage: perl rename_pair_read_header.pl 01_MI_PE_500_F.fasta 1 > 01_MI_PE_500_F_nh.fasta
# Yi-Jyun Luo | 2014.11.13

use strict;
use warnings;

open (IN, $ARGV[0]);

while (<IN>) {
	if (/>/) {
	chomp;
	print $_ . '/' . $ARGV[1] . "\n";
	} else {
	print $_;
	}
}
