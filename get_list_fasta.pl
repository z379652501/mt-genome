#!/usr/bin/env perl
# Script used to get the sequences from a fasta file corresponding to gene names within a list (the gene name list can be either with or without '>' mark).
# Usage: perl get_list_fasta.pl <list file> <fasta file>
# get_list_fasta.pl
# Yi-Jyun Luo | 2014.03.11

use strict;
use warnings;

my $n_args = @ARGV;
if ($n_args < 1)
{
	die "Usage: ./perl get_list_fasta.pl <list file> <fasta file> \n";
}

open (LIST, $ARGV[0]) || die "cannot open the gene list for reading: $!";
open (FILE, $ARGV[1]) || die "cannot open the fasta file for reading: $!";
$ARGV[1] =~ s/\.fa//g;

my @list_array = ();
while (my $list_line = <LIST>)
{
	chomp $list_line;
	$list_line =~ s/>//g;
	push (@list_array, "$list_line");
}

my %fasta_table = ();
local $/ = '>';
while (my $file_line = <FILE>)
{
	chomp $file_line;
	if ($file_line =~ /(\w+)(\n)(.+)/)
	{
		$fasta_table{$1} = $3;
	}
}

for my $i (0..$#list_array)
{
	chomp $list_array[$i];
	my $output_file_name = "$list_array[$i]\.fasta";
	my $protein = "$fasta_table{$list_array[$i]}";
	my $species = $ARGV[1];
	open (OUT, ">>$output_file_name");
	print OUT ">$species\n"."$protein\n";
}

#--//
