#!/usr/bin/env perl
# Script for getting the whole mt genomic sequence.
# Reference: http://oreilly.com/catalog/begperlbio/chapter/ch10.html
# Usage: perl get_gb_seq.pl  Homo_sapiens.gb >  Homo_sapiens.fa
# get_gb_seq.pl
# Yi-Jyun Luo | 2014.03.15

use strict;
use warnings;

open (GB_FILE, $ARGV[0]) || die "cannot open the file for reading: $!";
$ARGV[0] =~ s/.gb//g;

my $in_sequence = 0; 
while (<GB_FILE>)
{
	foreach ($_) 
	{
        if(/^\/\/\n/ )  # If $line is end-of-record line //\n, break out of the foreach loop.
        {
        	last;
        } 
        elsif ($in_sequence) # If we know we're in a sequence,
        { 
            $dna .= $_;	# add the current line to $dna.
        }
        elsif (/^ORIGIN/)	# If $line begins a sequence, set the $in_sequence flag.
		{
            $in_sequence = 1;
        }
	}
}

# remove whitespace and line numbers from DNA sequence
$dna =~ s/[\s0-9]//g;
print '>' . $ARGV[0] . "\n"; 
print $dna . "\n";

#--//
