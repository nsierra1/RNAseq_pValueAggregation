# Gunzip all raw fastq files currently stored in species/raw into species/ using condition-informative names
cd ~/projects/HSR/data/

### SPONGE (HALICLONA TUBIFERA) ###
 	# Three conditions, two replicates each, collected paired end
 	cd sponge/
 	gunzip -ck raw/SRR1793375_1.fastq.gz 29C_C_1.fastq # C for control (0h)
	gunzip -ck raw/SRR1793376_1.fastq.gz 29C_C_2.fastq
	
	gunzip -ck raw/SRR2012626_1.fastq.gz 34C_4h_1.fastq
	gunzip -ck raw/SRR2012673_1.fastq.gz 34C_4h_2.fastq
	
	gunzip -ck raw/SRR2012675_1.fastq.gz 34C_12h_1.fastq
	gunzip -ck raw/SRR2012676_1.fastq.gz 34C_12h_2.fastq
	cd..
	
	### SALMON (SALMO SALAR) ###
	# Three conditions, three replicates each, collected paired end
	cd salmon
	gunzip -ck raw/SRR6432693_1.fastq.gz > 23C_6h_1.fastq
  	gunzip -ck raw/SRR6432700_1.fastq.gz > 23C_6h_2.fastq
  	gunzip -ck raw/SRR6432699_1.fastq.gz > 23C_6h_3.fastq

  	gunzip -ck raw/SRR6432698_1.fastq.gz > 23C_24h_1.fastq
  	gunzip -ck raw/SRR6432697_1.fastq.gz > 23C_24h_2.fastq
  	gunzip -ck raw/SRR6432701_1.fastq.gz > 23C_24h_3.fastq

  	gunzip -ck raw/SRR6432696_1.fastq.gz > 13C_0h_1.fastq
  	gunzip -ck raw/SRR6432695_1.fastq.gz > 13C_0h_2.fastq
  	gunzip -ck raw/SRR6432694_1.fastq.gz > 13C_0h_3.fastq
  	cd ..
  	
  	### ANT (CATAGLYPHIS BOMBYCINA) ###
  	# Two conditions, four replicates each, collected paired end
  	cd ant
  	gunzip -ck raw/SRR6309587_1.fastq.gz > 25C_3h_1.fastq
	gunzip -ck raw/SRR6309582_1.fastq.gz > 25C_3h_2.fastq
	gunzip -ck raw/SRR6309583_1.fastq.gz > 25C_3h_3.fastq
	gunzip -ck raw/SRR6309589_1.fastq.gz > 25C_3h_4.fastq
	
	gunzip -ck raw/SRR6309584_1.fastq.gz > 45C_3h_1.fastq
	gunzip -ck raw/SRR6309585_1.fastq.gz > 45C_3h_2.fastq
	gunzip -ck raw/SRR6309588_1.fastq.gz > 45C_3h_3.fastq
	gunzip -ck raw/SRR6309586_1.fastq.gz > 45C_3h_4.fastq
	cd ..
	
	### OYSTER (MAGALLANAS GIGAS) ###
	# Four conditions, two replicates each, collected single end
	cd oyster
	gunzip -ck raw/SRR1068589.fastq.gz > 4C_0h_1.fastq # unclear what temp this sampled was collected at
  	gunzip -ck raw/SRR1068588.fastq.gz > 4C_0h_2.fastq

  	gunzip -ck raw/SRR1068591.fastq.gz > 25C_6h_1.fastq
  	gunzip -ck raw/SRR1068590.fastq.gz > 25C_6h_2.fastq

  	gunzip -ck raw/SRR1068593.fastq.gz > 25C_12h_1.fastq
  	gunzip -ck raw/SRR1068592.fastq.gz > 25C_12h_2.fastq

  	gunzip -ck raw/SRR1068595.fastq.gz > 25C_24h_1.fastq
  	gunzip -ck raw/SRR1068594.fastq.gz > 25C_24h_2.fastq
  	cd ..
  	
  	### CHICKEN (GALLUS GALLUS) ###
  	# Three strains, two conditions each, four replicates per condition collected single end
  	cd chicken
	gunzip -ck raw/ERR1328509.fastq.gz > 25C_AIL_1.fastq
	gunzip -ck raw/ERR1328510.fastq.gz > 25C_AIL_2.fastq
	gunzip -ck raw/ERR1328511.fastq.gz > 25C_AIL_3.fastq
	gunzip -ck raw/ERR1328512.fastq.gz > 25C_AIL_4.fastq

	gunzip -ck raw/ERR1328513.fastq.gz > 35C_AIL_1.fastq
	gunzip -ck raw/ERR1328514.fastq.gz > 35C_AIL_2.fastq
	gunzip -ck raw/ERR1328515.fastq.gz > 35C_AIL_3.fastq
	gunzip -ck raw/ERR1328516.fastq.gz > 35C_AIL_4.fastq

	gunzip -ck raw/ERR1328525.fastq.gz > 25C_BRI_1.fastq
	gunzip -ck raw/ERR1328526.fastq.gz > 25C_BRI_2.fastq
	gunzip -ck raw/ERR1328527.fastq.gz > 25C_BRI_3.fastq
	gunzip -ck raw/ERR1328528.fastq.gz > 25C_BRI_4.fastq

	gunzip -ck raw/ERR1328529.fastq.gz > 35C_BRI_1.fastq
	gunzip -ck raw/ERR1328530.fastq.gz > 35C_BRI_2.fastq
	gunzip -ck raw/ERR1328531.fastq.gz > 35C_BRI_3.fastq
	gunzip -ck raw/ERR1328532.fastq.gz > 35C_BRI_4.fastq

	gunzip -ck raw/ERR1328541.fastq.gz > 25C_FAY_1.fastq
	gunzip -ck raw/ERR1328542.fastq.gz > 25C_FAY_2.fastq
	gunzip -ck raw/ERR1328543.fastq.gz > 25C_FAY_3.fastq
	gunzip -ck raw/ERR1328544.fastq.gz > 25C_FAY_4.fastq

	gunzip -ck raw/ERR1328545.fastq.gz > 35C_FAY_1.fastq
	gunzip -ck raw/ERR1328546.fastq.gz > 35C_FAY_2.fastq
	gunzip -ck raw/ERR1328547.fastq.gz > 35C_FAY_3.fastq
	gunzip -ck raw/ERR1328548.fastq.gz > 35C_FAY_4.fastq

cd ~/projects/HSR/data/