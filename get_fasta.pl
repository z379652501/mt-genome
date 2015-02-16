#!/usr/bin/env perl
# Script used to get the sequence from fasta file using header name.
# get_fasta.pl
# Usage: perl get_fasta.pl <head name> <fasta file>
# Yi-Jyun Luo | 2014.03.14 

use strict;
use warnings;

my $n_args = @ARGV;
if ($n_args < 1)
{
	die "Usage: ./perl get_fasta.pl <head name> <fasta file> \n";
}

open (FILE, $ARGV[1]) || die " WARNING: There is no header name for searching. \n $!";

my %fasta_table = ();
local $/ = '>';
while (<FILE>)
{
	if (/$ARGV[0]/)
	{	
		chomp;
		print '>';
		print $_;
	}
}

#--//
