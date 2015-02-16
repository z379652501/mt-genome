Perls scripts for large-scale analyses of mitochondrial genomes.


> Luo YJ, Endo K, Satoh N (2015) The variable mitochondrial genome of the brachiopod Lingula anatina and its implication for mitochondrial evolution in lophotrochozoans. (in preparation)

* ps01. genbank_db.pl
Description: Get mt genome(s) in GenBank format.
Usage example: perl genbank_db.pl Homo sapiens J01415

* ps02. gb_get_cds.pl
Description: Get gene names and their protein sequences from GenBank file. (with original name as in GenBank file)
Usage example: perl gb_get_cds.pl Homo_sapiens.gb > Homo_sapiens.fa

* ps03. mt_gene_order_crex.pl
Description: Read the mt gene order, reorient it with COX1 as the first gene.
Usage example: perl mt_gene_order_crex.pl Homo_sapiens.fa > Homo_sapiens.txt

* ps04. gb_get_all_gene_name.pl
Description: Get gene names from protein-coding and rna genes from GenBank file.
Usage example: perl gb_get_all_gene_name.pl Homo_sapiens.gb > Homo_sapiens_all.txt

* ps05. get_genbank_CDS_aa.pl
Description: Get protein sequences in fasta format from the GenBank file with species name in the header.
Usage example: perl get_genbank_CDS_aa.pl gene Homo_sapiens.gb > Homo_sapiens_aa.fasta

* ps06. get_genbank_cds_seq_nucl.pl
Description: Get nucleotide sequences in fasta format from the GenBank file with species name in the header.
Usage example: perl get_genbank_cds_seq_nucl.pl gene Homo_sapiens.gb > Homo_sapiens_nucl.fasta

* ps07. gene_rename.pl
Description: Convert mitochondrial gene names into consistent naming system.
Usage example: perl gene_rename.pl all_aa.fasta > all_aa.renamed.fasta

* ps08. get_list_fasta.pl
Description: Get the sequences from a fasta file corresponding to gene names within a list.
Usage example: perl get_list_fasta.pl

* ps09. get_fasta.pl
Description: Get the sequence from fasta file using header name.
Usage example: perl get_fasta.pl

* ps10. get_gb_seq.pl
Description: Get the whole mt genomic sequence.
Usage example: perl get_gb_seq.pl Homo_sapiens.gb > Homo_sapiens.fa
