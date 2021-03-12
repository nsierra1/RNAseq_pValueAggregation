
#######################################################################
#######################################################################
### 							        							###
###  DIFFERENITIAL EXPRESSION AND ORTHOLOGUE DETECTION ANALYSIS  	###
### 							        							###
#######################################################################
#######################################################################

## The objective of this analysis is to search for potential homology in biological processes using existing RNAseq datasets, correcting for differences in experimental design.
## Noemie Sierra, Gold Lab. Completed Mar 12th, 2021.

## The analysis to identifying groups of orthologues involves in order: 
	# 1) RSEM-SE mapping to genomes/transcriptomes to find identities of reads in datasets
	# 2) Differential Gene Expression analysis with Trinity:edgeR to identify genes of interest in each experiment
		# run_DE_analysis.pl: identify differentially expressed transcripts
		# analyze_diff_expr.pl: extract the DE transcripts and cluster them according to their patterns across the conditions
		# -> output is clusters of genes expressed in similar patterns under heat shock for each animal
	# 3) Transdecoder translater the reads into protein sequences so orthology can be determined on the basis of protein structure (function) rather than nucleotide sequence
	# 4) OrthoFinder clusters transcripts by homology, performed on the files of condition-clustered transcript lists
		# performed in two steps: blast search on hpc, orthofinder on completed blast searches locally
		# -> output is orthologue groups for transcripts differentially expressed within the treatments across all species
	# 5) Generate the output file combining orthologue and differential expression data to be used with the Lancaster P-Value Aggregation.


## To run the following analysis you will need to have the following versions installed:
 	# sratoolkit-v2.10.2
 	# RSEM-v1.3.3
 	# bowtie2-v2.3.5.1
 	# trinityrnaseq-v2.10.0
 	# TransDecoder-v5.5.
 	# ncbi-blast-v2.10.0+
 	# OrthoFinder-v2.3.12
## To call programs from any directory, add to path using:
## PATH=$PATH:~/tools/PROGRAM/bin/location_of_executable

		
## The structure of this project folder can be found in the attached project_folder_structure.txt




##########################  	
## PROJECT FOLDER SETUP ##
##########################

## The first steps of this project (data download, rsem, transdecoder, trinity DGE) were run on the Peloton HPC at UC Davis. All output and error logs from job submission are stored in the slurm-logs folder. The remaining steps of this project (orthofinder) were run on a local computer running OSX Catalina 10.15.2.

 	mkdir ./HSR
 	proj=$(pwd)/HSR
 	cd $proj
	
 	#spp=(cataglyphis haliclona salmo gallus magallanas tegula galaxea acropora prenolepsis cryptolaemus melanotaenia nilaparvata sogatella laodelphax)
 	#spp=(tegula galaxea acropora prenolepsis cryptolaemus melanotaenia nilaparvata sogatella laodelphax)
 	spp=(tegula galaxea prenolepsis cryptolaemus melanotaenia)
	
 	# Set up directory structure
 	mkdir {data,edgeR,transdecoder,orthofinder,scripts,slurm-logs}
 	for s in "${spp[@]}"; do
 	  mkdir data/"$s"
 	  mkdir data/"$s"/raw
 	  mkdir data/"$s"/rsem_SE
 	done
	
 	# Download accession list into data/spp/raw folders
 	for s in "${spp[@]}"; do
 	  url=https://raw.githubusercontent.com/nsierra1/HSR_orthologues/master/download_info/accession_"$s".txt
 	  wget -P data/"$s"/raw "$url"
 	done
	
 	# Download unzipping instructions into data/
 	url=https://raw.githubusercontent.com/nsierra1/HSR_orthologues/master/download_info/gunzip_all.sh
 	wget -P data/ "$url"
	
 	# Download genome accession and unzipping instruction into data/
 	url=https://raw.githubusercontent.com/nsierra1/HSR_orthologues/master/download_info/genome_accessions_unzip.sh
 	wget -P data/ "$url"
 	
 	# Load programs to path
 	export PATH=$PATH:~/tools/sratoolkit.2.10.2/bin:\
 	~/tools/RSEM-1.3.3/bin:\
 	~/tools/etc
 		
 	

 
  	
################### 	
## DATA DOWNLOAD ##
###################

	cd ${proj}
	
	 # Download SRR files to each spp/raw folder
	 for s in "${spp[@]}"; do
	   while read f; do
	     fastq-dump --outdir "$s"/raw/ --gzip --split-files --readids --dumpbase --clip ${f}
	   done < data/"$s"/raw/accession_"$s".txt
	 done
	  
	 # Unzip fastq.gz files into working file with relevsilverant condition names
	 bash gunzip_all.sh
	 	
	 # Download the comprehensive and unpack transcriptomes to each spp/raw, unzip to working folder
	 bash genome_accessions_unzip.sh
   
   
   
   
   
###############################	
## RSEM - SINGLE END MAPPING ##
###############################
  	
 	cd ${proj}/data/
	
	
 	# Run RSEM to map all reads as single end onto genome (to improve mapping rate)
 	for s in "${spp[@]}"; do
		cd "$s"
		# Make samples file to reference in loops
		for f in *.fastq; do
		  echo ${f/.fastq} >> "$s"_samples.txt
		done
		
		# Prepare genome/transcriptome reference for each species
		rsem-prepare-reference --bowtie2 "$s"*ome.fa "$s"_ref
		
		# Map reads to genome/transcriptome using RSEM and bowtie2
		while read f; do
		  rsem-calculate-expression -p 8 --bowtie2 --estimate-rspd --append-names ${f}.fastq "$s"_ref rsem_SE/"$s"_${f}
		done < ~/projects/HSR/"$s"/"$s"_samples.txt
		
		# Cat logs for each sample into a species summary file stored in the 
		cat rsem_SE/*.log >> rsem_SE/summary-file_RSEM_"$s".txt
		cd ..
 	done


	 # Create a single mapping summary file
	 for s in "${spp[@]}"; do
	 	printf "$s\n\n" >> Summary-File-RSEM.txt
		cat "$s"/rsem_SE/summary-file_RSEM_"$s".txt >> Summary-File-RSEM.txt
		printf "\n\n"  >> Summary-File-RSEM.txt
	 done
		
	
	
	
	
############################################	
## TRINITY - DIFFERENTIAL GENE EXPRESSION ##
############################################

	 cd ${proj}
	
	 # Prepare outputs as a single file for Trinity DGE - all DGE info for a species is consolidated into a single file. The header must be replaced to match the values listed in spp_samples_file.txt for trinity.
	 for s in "${spp[@]}"; do
		# Make counts.matrix of all samples
	    rsem-generate-data-matrix data/"$s"/rsem_SE/*.genes.results >> edgeR/input/"$s".temp.matrix
	
	  	# Make samples file and counts.matrix replacement header
	  	cd data/"$s"
	  	header=()
	  	for f in *.fastq; do
		  printf "${s}_${f/_?.fastq}\t${s}_${f/.fastq}\n" >> ../../edgeR/input/"$s"_samples_file.txt
		  header+=("${s}_${f/.fastq}")
	  	done
	 	cd ../..
	 	  
	 	  # Create counts.matrix with a header matching the samples file
	 	  printf "${header[*]}\n" > edgeR/input/"$s".counts.matrix
	 	  (tail -n +2 edgeR/input/"$s".temp.matrix) >> edgeR/input/"$s".counts.matrix
	 	  
	 	  rm edgeR/input/*.temp.matrix
	 	  
	 	done
	 
	 # Tar and export to run local, use scp to download tar.gz, unpack
	 	tar -czvf HSR.tar.gz ${proj}/*
	 	scp handle@hpc:path/to/archive path/to/local/project/
	 	tar -xf HSR.tar.gz
	 	
	 ### Run Trinity DGE locally ###
	 
	 proj=$(pwd)/HSR
	 cd ${proj}
	 
	 #spp=(silverant sponge salmon chicken oyster) # recreate array in local
	 spp=()
		
		cd edgeR/
		for s in "${spp[@]}"; do
	  	  # Identify differentially expressed transcripts
	  	  run_DE_analysis.pl --matrix input/"$s".counts.matrix --method edgeR --output edgeR."$s".dir --samples_file input/"$s"_samples_file.txt
		  
		  # Cluster differentially expressed transcripts cluster them according to their patterns across the conditions
	      cd edgeR."$s".dir
	      analyze_diff_expr.pl --matrix *edgeR.DE_results --samples ../input/"$s"_samples_file.txt
	      
		done
	
	
	
	
	
##########################################
## TRANSDECODER - TRANSLATE TO PROTEINS ##
##########################################

 	cd ${proj}
	
 	for s in "${spp[@]}"; do 
 	  # Extract the long open reading frames
 	  TransDecoder.LongOrfs -t data/"$s"/"$s"*ome.fa -O transdecoder/"$s".transdecoder_dir
 	  # Predict the likely coding regions
 	  TransDecoder.Predict -t data/"$s"/"$s"*ome.fa -O transdecoder/"$s".transdecoder_dir
 	done
	




########################################	
## ORTHOFINDER - ORTHOLOGUE DETECTION ##
########################################
   
 	# The first step of OrthoFinder is to run an all-by-all blast search between species to identify potential homologues. This is best performed in parallel on an hpc, so OrthoFinder has an option to simply output the blast commands to be run separately.
 	# Once the blast searches are complete OrthoFinder can continue with the provided blast txt results.
	
 	
 	cd ${proj}
 	
 	# Copy TransDecoder pepfiles in Orthofinder folder
 	mkdir orthofinder/fasta_temp/ 
 	for s in "${spp[@]}"; do 
 	  cp transdecoder/"$s".transdecoder_dir/*.transdecoder.pep orthofinder/fasta_temp/
 	done
	
 	# Set up blast search - create databases and generate scripts
 		## PLEASE SET PATHS TO LOCAL ORTHOFINDER FOLDER
 	
 	# Create databases out of .pep files and save blast commmand output to an array	
 	mapfile -t -s 21 commands < <(orthofinder -S blast -op -f orthofinder/fasta_temp/)
 	cp -R orthofinder/fasta_temp/OrthoFinder/Results*/ orthofinder/blast
 	mkdir orthofinder/blast/commands
 	test="BLAST commands that must be run"
 	if [[ ${commands[0]} == $test ]]
 	then 
 	  for s in "${commands[@]:2:${#commands[@]}}"; do 
 	    # get comparison info:
 	    b=${s: -12}
 	    c=${b%.txt*}
 	    comp=${c#*t}
 	    q=${comp%_*};  db=${comp#*_}
 	   
 	    # make script
 	    printf "%s\n" '#!/bin/bash -l' "#SBATCH -D ${proj}" '#SBATCH -J orthofinder-blast' '#SBATCH -t 24:00:00' 'PATH=$PATH:~/tools/ncbi-blast-2.10.0+/bin/' "cd ${proj}" "blastp -outfmt 6 -evalue 0.001 -query orthofinder/blast/WorkingDirectory/Species"$q".fa -db orthofinder/blast/WorkingDirectory/BlastDBSpecies"$db" -out orthofinder/blast/Blast"$q"_"$db".txt" > orthofinder/blast/commands/Blast"$q"_"$db".sh
 	  done
 	else
 	  echo "output on your version of orthofinder may be of a different dimension. Please run <<orthofinder -S blast -op -f fasta_temp/>> directly and manually add output commands to individual bash scripts"
 	fi 
 	
 	
 	# Run all scripts in parallel by batch submitting to hpc queue (please adjust for your hpc's submission structure):
 	cd ${proj}/orthofinder/blast/commands/
 	for i in *.sh
 	do
 	sbatch -p high $i
 	done
 	cd ${proj}
 
 	# Create Orthologue clusters
 	orthofinder -b orthofinder/blast -f orthofinder/fasta_temp -n orthofinder 





#####################################	
## LANCASTER INPUT FILE GENERATION ##
#####################################

# The p-value aggregation script requires differential expression and orthologue assignment information for each gene in the analysis.

	# 1. Gene ID: EdgeR or Orthofinder
	# 2. Protein ID: Orthofinder
	# 3. Organism: 
	# 4. logCPM: EdgeR
	# 5. P-value (unadjusted): EdgeR
		# => For 4 & 5, only make time-course comparisons (ex: time 1 vs time 2, not time 1 vs time 3)
		
		
		
# Set up the DE comparisons input file
	
	# Because this analysis is comparing time course, we only use edgeR.DE_results files that compare adjacent time points.
	# The file name for the relevant DE_results output files should be placed into a text file titled spp_DEcomp.txt (where spp is the name of the dataset in your spp variable)
	# The text file should just contain a column of * in-order * time comparisons
	
	# For example, in the time comparison for salmon used in Shi et al 2019 (see experimental_designHSR.txt), the experimental design time course was:
		# time_0		time_1		time_2
		# 13C_0h_1		23C_6h_1	23C_24h_1
		# 13C_0h_2		23C_6h_2	23C_24h_2	
		# 13C_0h_3		23C_6h_3	23C_24h_3
		
	# so we will be using the DE_results files: 
		# salmon.counts.matrix.salmon_13C_0h_vs_salmon_23C_6h.edgeR.DE_results 
		# salmon.counts.matrix.salmon_23C_24h_vs_salmon_23C_6h.edgeR.DE_results
	# which compare time_0 to time_1, and time_1 to time_2 respectively. These filenames are saved to the file salmon_DEcomp.txt

	for s in "${spp[@]}"; do 
 	  ## run generate_output_edgeRorthofinder.sh with input spp_DEcomp.txt
 	done
	
	


	
 
 








  
