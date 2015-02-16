#!/usr/bin/env perl
# Perl script for getting gene names and their protein sequences from GenBank files
# Main code for protein extraction is modified from https://gist.github.com/biocodershub/4170297
############################################################################
# Usage: perl gb_get_cds.pl Homo_sapiens.gb > Homo_sapiens.fa
############################################################################
# Output is in fasta format.
# ps02: gb_get_cds.pl
# Yi-Jyun Luo | 2014.03.10

use strict;
use warnings;
use List::Uniq ':all';

open (GB_FILE, $ARGV[0]) || die "cannot open the file for reading: $!";
$trans = 0;

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
   
   if (/(\/gene=")(.*.)(")/)
   {
      $uppercase= uc $2;   # uppercase conversion
      push (@gene_name, ">$uppercase");
   }
   elsif (/(\/translation=")(.*)/)   # where the protein product begins
   {
      $protein = $2;
      $continue = 1;
   }
   elsif ($continue)   # the translation is continuing
   {
      if (!/"/)   # if there is no terminal quote, then read translation continuely
      {
         $protein .= $_;
      }
      elsif (/(.*)(")/)   # if meet the terminal quote, that means that is the end of translation
      {
         $protein .= $1;
         $protein =~ s/\s*//g;
         push (@protein_seq, "$protein");
         $continue = 0;
      }
   }
}

@uniq_gene_name = uniq(@gene_name);
@uniq_gene_name = grep {!/trn/} @uniq_gene_name; # remove trn genes
@uniq_gene_name = grep {!/TRN/} @uniq_gene_name; # remove trn genes
@uniq_gene_name = grep {!/rrn/} @uniq_gene_name; # remove rrn genes
@uniq_gene_name = grep {!/RNA/} @uniq_gene_name; # remove RNA genes
@uniq_gene_name = grep {!/RNR/} @uniq_gene_name; # remove RNR genes
@uniq_gene_name = grep {!/RRN/} @uniq_gene_name; # remove RRN genes
@uniq_gene_name = grep {!/RNL/} @uniq_gene_name; # remove RNL genes
@uniq_gene_name = grep {!/RNS/} @uniq_gene_name; # remove RNS genes
@uniq_gene_name = grep {!/NAD/} @uniq_gene_name; # remove NAD genes
@uniq_gene_name = grep {!/HYPOTHETICAL/} @uniq_gene_name; # remove hypothetical proteins


for my $i (0..$#uniq_gene_name)
{
    print "$uniq_gene_name[$i]\n"."$protein_seq[$i]\n";
}

#--//
