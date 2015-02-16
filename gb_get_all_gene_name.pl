#!/usr/bin/env perl
# Perl script for getting gene names from protein-coding and rna genes from GenBank files
###############################################################
# Usage: perl gb_get_all_gene_name.pl Homo_sapiens.gb > Homo_sapiens_all.txt
###############################################################
# gb_get_all_gene_name.pl
# Yi-Jyun Luo | 2014.03.18

use strict;
use warnings;
use List::Uniq ':all';

open (GB_FILE, $ARGV[0]) || die "cannot open the file for reading: $!";

while (<GB_FILE>)
{
   s/product/gene/g;
   s/"(NADH)(.*.)(\d)/"ND$3/g;
   s/"(NADH)(.*.)4L/"ND4L/g;
   s/"(nad)(.*.)(\d)/"ND$3/g;
   s/"(nad)(.*.)4l/"ND4L/g;
   s/"cytoch.*.subunit\sI"/"COX1"/g;
   s/"cytoch.*.subunit\sII"/"COX2"/g;
   s/"cytoch.*.subunit\sIII"/"COX3"/g;
   s/"cytoch.*.subunit\s1"/"COX1"/g;
   s/"cytoch.*.subunit\s2"/"COX2"/g;
   s/"cytoch.*.subunit\s3"/"COX3"/g;
   s/"cytoch.*.(\s)b/"COB/g;
   s/"apocytochome(\s)b/"COB/g;
   s/(\s)apoenzyme//g; 
   s/"cytb/"COB/g;
   s/"Cyt\sb/"COB/g; 
   s/"Cytb/"COB/g; 
   s/"CYTB/"COB/g;
   s/"atp.*.6/"ATP6/g;
   s/"atp.*.8/"ATP8/g;
   s/"ATP.*.6/"ATP6/g;
   s/"ATP.*.8/"ATP8/g;
   s/"ATP.*.9/"ATP9/g;
   s/"DNA mismatch repair protein"/"MUTS"/g;
   s/"replication helicase subunit"/"dnaB"/g;
   s/"CO1"/"COX1"/g;
   s/"COX{0,1}I"/"COX1"/g;
   s/"COX{0,1}II"/"COX2"/g;
   s/"COX{0,1}III"/"COX3"/g; # for format transforming (annotation is wrong in some animal like Branchiostoma lanceolatum, in which spelling cytochrome as "cytochome".)
   s/"tRNA-(\w+).*"/"tRNA-$1"/g;
   s/"trn(\w).*"/"trn$1"/g;
   s/"TRN(\w)(\d)"/"TRN$1"/g;
   s/tRNA-Ala/trnA/g;
   s/tRNA-Arg/trnR/g;
   s/tRNA-Asn/trnN/g;
   s/tRNA-Asp/trnD/g;
   s/tRNA-Cys/trnC/g;
   s/tRNA-Gln/trnQ/g;
   s/tRNA-Glu/trnE/g;
   s/tRNA-Gly/trnG/g;
   s/tRNA-His/trnH/g;
   s/tRNA-Ile/trnI/g;
   s/tRNA-Leu/trnL/g;
   s/tRNA-Lys/trnK/g;
   s/tRNA-Met/trnM/g;
   s/tRNA-Phe/trnF/g;
   s/tRNA-Pro/trnP/g;
   s/tRNA-Ser/trnS/g;
   s/tRNA-Thr/trnT/g;
   s/tRNA-Trp/trnW/g;
   s/tRNA-Tyr/trnY/g;
   s/tRNA-Val/trnV/g;
   s/"12S ribosomal RNA"/"S-RRNA"/g;
   s/"16S ribosomal RNA"/"L-RRNA"/g;   
   s/"12S rRNA"/"S-RRNA"/g;
   s/"16S rRNA"/"L-RRNA"/g;
   s/"[Ss]mall subunit ribosomal RNA"/"S-RRNA"/g;
   s/"[Ll]arge subunit ribosomal RNA"/"L-RRNA"/g; 
   s/"[Ss]mall ribosomal RNA"/"S-RRNA"/g;
   s/"[Ll]arge ribosomal RNA"/"L-RRNA"/g;
   s/"[Ss]mall subunit of 12S ribosomal RNA"/"S-RRNA"/g;
   s/"[Ll]arge subunit of 16S ribosomal RNA"/"L-RRNA"/g;
   s/"rrnS"/"S-RRNA"/g;
   s/"rrnL"/"L-RRNA"/g;
   s/"RNR1"/"S-RRNA"/g;
   s/"RNR2"/"L-RRNA"/g;
   s/"srRNA"/"S-RRNA"/g;   
   s/"lrRNA"/"L-RRNA"/g;      # for RNA format transforming
   
   if (/(\/gene=")(.*.)(")/)
   {
   		$uppercase= uc $2;   # uppercase conversion
   		push (@gene_name, ">$uppercase");
   }
}

@uniq_gene_name = uniq(@gene_name);
@uniq_gene_name = grep {!/NAD/} @uniq_gene_name; # remove NAD genes
@uniq_gene_name = grep {!/HYPOTHETICAL/} @uniq_gene_name; # remove hypothetical proteins

$ARGV[0] =~ s/.gb//g;
print '>' . $ARGV[0] . "\n"; 
my @gene_list_1 = ();
while (my $line_1 = <@uniq_gene_name>)
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
