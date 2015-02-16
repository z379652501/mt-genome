#!/usr/bin/env perl
# Count GC content of the mitochondrial genomes.
# Usage: perl scaffold_gc_counter.pl Laqueus_rubellus.fa > Laqueus_rubellus.gc
# mt_gc_counter.pl
# 'Header_ID' . ' ' . 'GC_content' . ' ' . 'Number of nucleotide' . ' ' . 'Number of gap' . ' ' . 'Sequence length' . ' ' . 'Gap%'
# Yi-Jyun Luo | 2014.12.15

use strict;
use warnings;
use Math::Round;

open (FILE, $ARGV[0]) or die "There is no fasta file! \n $!";

local $/ = '>';
while (<FILE>) {
	if (/[Ss]c/ || /\_/ || /[0-9]/) {
		my @fields = split (" ", $_);
		my $header_ID = $fields[0];
		my @countA = ($_ =~ /[Aa]/g);
		my @countC = ($_ =~ /[Cc]/g);
		my @countT = ($_ =~ /[Tt]/g);
		my @countG = ($_ =~ /[Gg]/g);
		my @countN = ($_ =~ /[Nn]/g);
		my @countX = ($_ =~ !/[ACTGNactgn]/g);
		my @length = ($_ =~ /[ACTGactg]/g);
		my $GC_content = (@countG+@countC)/(@countA+@countT+@countG+@countC);
		my $gap = (@countN+@countX);
		my $total_length =  @length + $gap;
		my $gap_percentage = $gap/$total_length;
		print $header_ID . ' ' . $GC_content . ' ' . @length . ' ' . $gap . ' ' . $total_length . ' ' .  nearest(.01, $gap_percentage) . "\n";
	}
}

