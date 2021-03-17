 # Download the comprehensive transcriptomes to each spp/raw, unzip to working folder


 
  ### SPONGE (HALISARCA CAERULEA) ###
  url=https://ndownloader.figshare.com/files/8826841
  wget -P sponge/raw "$url"
  gunzip -ck sponge/raw/Halisarca_REF_trinity.fasta.zip > sponge/sponge_transcriptome.fa
  
  ### ANEMONE (NEMATOSTELLA VECTENSIS) ###
  url=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/209/225/GCF_000209225.1_ASM20922v1/GCF_000209225.1_ASM20922v1_rna.fna.gz
  wget -P anemone/raw "$url"
  gunzip -ck anemone/raw/GCF_000209225.1_ASM20922v1_rna.fna.gz > anemone/anemone_transcriptome.fa
  
  ### PLANARIA (SCHMIDTEA MEDITERRANEA) ###
  url=http://smedgd.stowers.org/files/SmedSxl_genome_v4.0.all.maker.transcripts.fasta.gz
  wget -P planaria/raw "$url"
  gunzip -ck planaria/raw/SmedSxl_genome_v4.0.all.maker.transcripts.fasta.gz > planaria/planaria_transcriptome.fa
 
  ### CUCUMBER (APOSTICHOPUS JAPONICUS) ###
  url=ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE44nnn/GSE44995/suppl/GSE44995_Reference_assembled_isotig_seq.fna.gz
  wget -P cucumber/raw "$url"
  gunzip -ck cucumber/raw/GSE44995_Reference_assembled_isotig_seq.fna.gz > cucumber/cucumber_transcriptome.fa
 
  ### ZEBRAFISH (DANIO RERIO ###
  url=http://ftp.ensembl.org/pub/release-89/fasta/danio_rerio/cdna/Danio_rerio.GRCz10.cdna.all.fa.gz
  wget -P zebrafish/raw "$url"
  gunzip -ck zebrafish/raw/GRCz10.cdna.all.fa > zebrafish/zebrafish_transcriptome.fa
  
  ### AXOLOTL (AMBYSTOMA MEXICANUM) ###
  url=https://data.broadinstitute.org/Trinity/SalamanderWeb/Axolotl.Trinity.CellReports2017.fasta.gz
  wget -P axolotl/raw "$url"
  gunzip -ck axolotl/raw/Axolotl.Trinity.CellReports2017.fasta.gz > axolotl/axolotl_transcriptome.fa
