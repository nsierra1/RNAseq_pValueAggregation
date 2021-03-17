# Gunzip all raw fastq files currently stored in species/raw into species/ using condition-informative names
cd ~/projects/REGEN/data/

	### SPONGE (HALISARCA CAERULEA) ###
 	# Three time points, 1 replicate each, collected paired end
 	cd sponge/
	gunzip -ck raw/SRR5863988_1.fastq.gz 0h_1
	gunzip -ck raw/SRR5863987_1.fastq.gz 2h_1
	gunzip -ck raw/SRR5234759_1.fastq.gz 12h_1
	cd ..
	
	### ANEMONE (NEMATOSTELLA VECTENSIS) ###
	# Four time points, two replicates each, collected single end
	cd anemone/
	gunzip -ck raw/SRR3938303.fastq.gz 72h_AB_1
	gunzip -ck raw/SRR3938304.fastq.gz 72h_AB_2

	gunzip -ck raw/SRR3938299.fastq.gz 24h_AB_1
	gunzip -ck raw/SRR3938300.fastq.gz 24h_AB_2

	gunzip -ck raw/SRR3938297.fastq.gz 8h_AB_1
	gunzip -ck raw/SRR3938298.fastq.gz 8h_AB_2
	
	gunzip -ck raw/SRR3938293.fastq.gz 0h_AB_1
	gunzip -ck raw/SRR3938294.fastq.gz 0h_AB_2

	gunzip -ck raw/SRR3938290.fastq.gz 72h_OR_1
	gunzip -ck raw/SRR3938291.fastq.gz 72h_OR_2
	
	gunzip -ck raw/SRR3938288.fastq.gz 24h_OR_1
	gunzip -ck raw/SRR3938289.fastq.gz 24h_OR_2
	
	gunzip -ck raw/SRR3938286.fastq.gz 8h_OR_1
	gunzip -ck raw/SRR3938287.fastq.gz 8h_OR_2
	
	gunzip -ck raw/SRR3938202.fastq.gz 0h_OR_1
	gunzip -ck raw/SRR3938203.fastq.gz 0h_OR_2
	cd ..
	
	### PLANARIA (SCHMIDTEA MEDITERRANEA) ###
	# 16 time points pooled into 5 sample groups. Multiple individuals pooled into different samples, collected paired end.
	cd planaria/
	gunzip -ck raw/ERR032071_1.fastq.gz 0h_1
	gunzip -ck raw/ERR032071_2.fastq.gz 0h_2
	
	gunzip -ck raw/ERR032066_1.fastq.gz 0.5-1h_1
	gunzip -ck raw/ERR032066_2.fastq.gz 0.5-1h_2
	
	gunzip -ck raw/ERR032067_1.fastq.gz 2-3h_1 
	gunzip -ck raw/ERR032067_2.fastq.gz 2-3h_2 
	
	gunzip -ck raw/ERR032068_1.fastq.gz 4-8h_1  
	gunzip -ck raw/ERR032068_2.fastq.gz 4-8h_2  
	
	gunzip -ck raw/ERR032069_1.fastq.gz 10-18h_1  
	gunzip -ck raw/ERR032069_2.fastq.gz 10-18h_2  
	
	gunzip -ck raw/ERR032070_1.fastq.gz 24-72h_1 
	gunzip -ck raw/ERR032070_2.fastq.gz 24-72h_2 
	cd ..
	
	### CUCUMBER (APOSTICHOPUS JAPONICUS) ###
	# 5 time points, 1 replicate each, collected single end
	cd cucumber/
	gunzip -ck raw/SRR771602.fastq.gz 0d_1
	gunzip -ck raw/SRR771603.fastq.gz 3d_1
	gunzip -ck raw/SRR771604.fastq.gz 7d_1
	gunzip -ck raw/SRR771605.fastq.gz 14d_1
	gunzip -ck raw/SRR771606.fastq.gz 21d_1
	cd ..
	
	### ZEBRAFISH (DANIO RERIO ###
	# 4 time points, 3 replicates each, collected single end
	cd zebrafish/
	gunzip -ck	raw/SRR1205171.fastq.gz 5h_3
	gunzip -ck	raw/SRR1205170.fastq.gz 5h_2
	gunzip -ck	raw/SRR1205169.fastq.gz 5h_1
	
	gunzip -ck	raw/SRR1205165.fastq.gz 3h_3
	gunzip -ck	raw/SRR1205164.fastq.gz 3h_2
	gunzip -ck	raw/SRR1205163.fastq.gz 3h_1
	
	gunzip -ck	raw/SRR1205159.fastq.gz 1h_3
	gunzip -ck	raw/SRR1205157.fastq.gz 1h_2
	gunzip -ck	raw/SRR1205158.fastq.gz 1h_1
		
	gunzip -ck	raw/SRR1205162.fastq.gz C_3
	gunzip -ck	raw/SRR1205161.fastq.gz C_2
	gunzip -ck	raw/SRR1205160.fastq.gz C_1
	cd ..
	
	### AXOLOTL (AMBYSTOMA MEXICANUM) ###
	# collected paired end
	cd axolotl
	gunzip -ck raw/100309-lane1.fastq.gz 
	gunzip -ck raw/100309-lane2.fastq.gz 
	gunzip -ck raw/100309-lane3.fastq.gz 
	gunzip -ck raw/100309-lane4.fastq.gz 
	gunzip -ck raw/100309-lane5.fastq.gz 
	gunzip -ck raw/100309-lane6.fastq.gz 
	gunzip -ck raw/100309-lane7.fastq.gz 

cd ~/projects/REGEN/data/