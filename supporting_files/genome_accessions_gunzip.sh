 # Download the comprehensive transcriptomes to each spp/raw, unzip to working folder
cd ~/projects/HSR/data/

 
  ### SALMON (SALMO SALAR) ###
  url=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/233/375/GCF_000233375.1_ICSASG_v2/GCF_000233375.1_ICSASG_v2_rna.fna.gz
  wget -P salmon/raw "$url"
  gunzip -ck salmon/raw/GCF_000233375.1_ICSASG_v2_rna.fna.gz > salmon/salmon_transcriptome.fa
  
  
  ### SPONGE (HALICLONA TUBIFERA) ###
  url=https://sra-download.ncbi.nlm.nih.gov/traces/wgs03/wgs_aux/GF/AV/GFAV01/GFAV01.1.fsa_nt.gz
  wget -P sponge/raw "$url"
  gunzip -ck sponge/raw/GFAV01.1.fsa_nt.gz > sponge/sponge_transcriptome.fa
  
  ### SILVERANT (CATAGLYPHIS BOMBYCINA) ###
  # Genome/comprehensive transcriptome not available for this species - downloaded genome of the related species Camponotus floridanus (florida carpenter) as described in the original paper
  url=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/227/725/GCF_003227725.1_Cflo_v7.5/GCF_003227725.1_Cflo_v7.5_rna.fna.gz
  wget -P silverant/raw "$url"
  gunzip -ck silverant/raw/GCF_003227725.1_Cflo_v7.5_rna.fna.gz > silverant/silverant_transcriptome.fa
 
  ### OYSTER (MAGALLANAS GIGAS) ###
  # Genome page on ncbi can be found under deprecated name Crassostrea gigas as of June 15, 2020
  url=ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/806/645/GCF_902806645.1_cgigas_uk_roslin_v1/GCF_902806645.1_cgigas_uk_roslin_v1_rna.fna.gz
  wget -P oyster/raw "$url"
  gunzip -ck oyster/raw/GCF_000297895.1_oyster_v9_rna.fna.gz > oyster/oyster_transcriptome.fa
 
  ### CHICKEN (GALLUS GALLUS) ###
  url=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/315/GCF_000002315.6_GRCg6a/GCF_000002315.6_GRCg6a_rna.fna.gz
  wget -P chicken/raw "$url"
  gunzip -ck chicken/raw/GCF_000002315.6_GRCg6a_rna.fna.gz/ > chicken/chicken_transcriptome.fa
 
