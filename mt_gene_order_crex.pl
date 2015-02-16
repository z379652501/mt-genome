#!/usr/bin/env perl
# Read the mitochondrial gene order, reorient it with COX1 as the first gene.
# Read fasta file with correct gene order as input.
###########################################
# Usage: perl mt_gene_order_crex.pl Homo_sapiens.fa > Homo_sapiens.txt
###########################################
# This is the version for CREx. The output is in fasta format. 
# CREx website: http://pacosy.informatik.uni-leipzig.de/crex
# ps03: mt_gene_order_crex.pl
# Yi-Jyun Luo | 2013.03.13

use strict;
use warnings;

open (FILE, $ARGV[0]) or die "cannot open the file for reading: $!";
$ARGV[0] =~ s/.fa//g;

print '>' . $ARGV[0] . "\n"; 

my @gene_list_1 = ();
while (my $line_1 = <FILE>)
{
	if ($line_1 =~ /^>/)
	{
		$line_1 =~ s/>//g;
		push (@gene_list_1, "$line_1");
	}
}

my %gene_order = ();
my @gene_list_2 = ();
my $i = 0;
for $i (0..$#gene_list_1)
{
	$gene_order{$i+1} = $gene_list_1[$i];
	my $line_1 = 'N' . ($i+1) . "_" . $gene_order{$i+1};
	push (@gene_list_2, "$line_1");
}

my $initial_number;
my @gene_list_3 = ();
while (my $line_2 = <@gene_list_2>)
{
	if ($line_2 =~ /COX1/)
	{
		chomp $line_2;
		my @fields_1 = split ("_", $line_2);
		$fields_1[0] =~ s/N//g;
		$initial_number = $fields_1[0];
		my $final_number = $#gene_list_1 + 1;
		for my $k ($initial_number..$final_number)
		{
			push (@gene_list_3, $gene_order{$k})
		}
	}
}

while (my $line_2 = <@gene_list_2>)
{
	if ($line_2 =~ /N1_/ && $line_2 =~ !/COX1/) 
	{
		my $end_number = $initial_number - 1;
		for my $j (1..$end_number)
		{
			push (@gene_list_3, $gene_order{$j});
		}
	}
}

while (<@gene_list_3>)
{
	print "$_" . " ";
}

print "\n";

#--//
