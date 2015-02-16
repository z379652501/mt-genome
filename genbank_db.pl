#!/usr/bin/env perl
# Perl script for getting mt genome(s) in GenBank format
########################################################
# Usage: perl genbank_db.pl species_list
#
# Example of species_list
# Acanthaster planci NC_007788
# Acropora tenuis NC_003522
# Anacropora matthai NC_006898
# Antedon mediterranea AM404181
# Asterias amurensis NC_006665
#
# Input file format:
# Scientific name of the species: $field[0] $field[1]
# NCBI accession ID: $field[2]
########################################################
# The output file name will be: Strongylocentrotus_purpuratus.gb (in GenBank format)
# ps01: genbank_db.pl
# Yi-Jyun Luo | 2014.03.09

use strict;
use warnings;
use Bio::SeqIO;
use Bio::DB::GenBank;

# Open the list from argument
open (IN, '<', $ARGV[0]) or die "Can't open the file $!\n";
while (my $line = <IN>) {

# Get the id and name (change the name format from "A b" to "A_b")
    my @fields = split (" ", $line);
    my $id = $fields[2];
    my $name = "$fields[0] $fields[1]";
    $name =~ s/\s/_/;
    my $file = $name."."."gb";

# Get the genebank file according to the id and save output to the corresponded name
    my $db = Bio::DB::GenBank->new;
    my $seq = $db->get_Seq_by_acc($id);
    my $seq_out = Bio::SeqIO->new(-file => ">$file", -format => "genbank");
    $seq_out->write_seq($seq);
}
close (IN);

#--//
