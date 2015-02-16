#!/usr/bin/env perl
# Get protein sequences in fasta format from the GenBank file with species name in the header.
# Usage: perl get_genbank_CDS_aa.pl [gene|product] [genbank file]
# Example: perl get_genbank_CDS_aa.pl gene Homo_sapiens.gb > Homo_sapiens_aa.fasta
# This is used for Ka and Ks analyses, which requires having different protein IDs.
# get_genbank_CDS_aa.pl
# Yi-Jyun Luo | 2014.03.20

use strict;
use warnings;
use Bio::SeqIO;
 
my $n_args = @ARGV;
if ($n_args < 1)
{
	die "Usage: /.get_genbank_CDS_aa.pl [tag] [genbank file] \n";
}
 
my $seqio_object = Bio::SeqIO->new(-file => $ARGV[1]);
my $seq_object = $seqio_object->next_seq;

$ARGV[1] =~ /(\w+)_(\w+)/;
 
for my $feat_object ($seq_object->get_SeqFeatures)
{
	if ($feat_object->primary_tag eq "CDS")
	{
		if ($feat_object->has_tag($ARGV[0]))
		{ 
	    for my $gene_name ($feat_object->get_tag_values($ARGV[0]))
	    {
    	for my $val ($feat_object->get_tag_values('translation'))
    	{
    	print '>' . $1 . '_' . $2 . '_' . $gene_name . "\n";
		print $val . "\n";
     	}
     	}
     	}
     }
}

#--//
