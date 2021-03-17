#!/bin/bash


		
##########################  	
## GENERATE OUTPUT FILE ##
##########################
		
		
		# 1.1) Remove headers from DE files
		cat salmon.counts.matrix.salmon_13C_0h_vs_salmon_23C_6h.edgeR.DE_results | sed 1d > test/salmon.counts.matrix.salmon_13C_0h_vs_salmon_23C_6h.edgeR.DE_results.tmp
		cat salmon.counts.matrix.salmon_23C_24h_vs_salmon_23C_6h.edgeR.DE_results | sed 1d > test/salmon.counts.matrix.salmon_23C_24h_vs_salmon_23C_6h.edgeR.DE_results.tmp
		
		# 1.2) get just the first field (genes) for all genes in all relevant files
		cat test/salmon.counts.matrix.salmon_13C_0h_vs_salmon_23C_6h.edgeR.DE_results.tmp test/salmon.counts.matrix.salmon_23C_24h_vs_salmon_23C_6h.edgeR.DE_results.tmp | cut -f 1 > test/salmon_genes.tmp
		sort test/salmon_genes.tmp | uniq > test/salmon_genes.txt
		
		# output: salmon_genes.txt
		
		# 2.1) get Gene_ID Prot_ID association 
		while read g; do
		  line="$(grep -o $g.p[0-9]* ../../orthofinder_results/Orthogroups.txt)"
		  printf "$g\t$line\n" >> test/salmon_gene_prot.tmp
		done < test/salmon_genes.txt
		
		### Output of prot_spp.txt 
	
		
				# 2.2) Open in bbedit and use:
					
				search: ^([A-Z]{2}_[0-9]+.\d)(.p[0-9])$ # find any line that starts with a prot_id, set gene_id and prot code as separate fields
				replace: \1\t\1\2 # copy the gene_id and a tab in front of the prot_id
				 #where any field 3 (new line) ends in .p?, make it tab sep on the prev line 

				
				# 2.3) Remove genes with no p_id from salmon_gene_prot.tmp (no p_id means no OG assignment, not useful)
				search: ^([A-Z]{2}_[0-9]+.\d)$
				replace: 
	
				# then run:
				grep . test/salmon_gene_prot.tmp > test/salmon_gene_prot.txt # to remove the blank lines
				
		
		# 2.4) Make protein list
		
		cut -f 2 < test/salmon_gene_prot.txt > test/salmon_prot.txt
		
		# 3.1) Use the protein list to search for orthogroups
		
		while read p; do
		  line="$(grep $p ../../orthofinder_results/Orthogroups.txt)" # find protein in the Orthogroups.txt file
		  var=`echo "$line" | grep -o OG.*:` # Print only the matched (OG group) parts of matching lines to $var
		  printf "$p\t${var//:}\n" >> test/salmon_prot_OG.txt # print pid, OG group without the ":" to ortho_species
		done < test/salmon_prot.txt
	
				# 3.2) Add the organism as a third column in bbedit:
				search: \n
				replace: \tSalmon\n
		
				# 3.3) Add header in manually
		
				Prot_ID	OG	Organism
			
		# 4.1) Make separate query files for logCPM and Pvalue
		
		# First add "Gene_ID\t" manually to the .DEresults files so the headers match the data
			
		cut -f 1,5,6 < salmon.counts.matrix.salmon_13C_0h_vs_salmon_23C_6h.edgeR.DE_results > test/salmonT0_edgeR.tmp
		cut -f 1,5,6 < salmon.counts.matrix.salmon_23C_24h_vs_salmon_23C_6h.edgeR.DE_results > test/salmonT1_edgeR.tmp
		
		
		# 4.2) Query the logCPM and Pvalue based on the protein id list
			
		for i in {0..1}; do
		
		  FILE="test/salmonT"$i"_edgeR_prot.tmp"
		  [ -f /etc/resolv.conf ] && rm $FILE
		
		  while read p; do
		   line="$(grep ${p//.p*} test/salmonT${i}_edgeR.tmp)"
		   printf "$p\t$line\n" >> test/salmonT"$i"_edgeR_prot.tmp
		  done < test/salmon_prot.txt
		done
		 
		
		# Replace the headers: 
		
		Protein_ID	Gene_ID	T0_vs_T1_logCPM	T0_vs_T1_Pvalue
		
		Protein_ID	Gene_ID	T1_vs_T2_logCPM	T1_vs_T2_Pvalue
		
		### output has the logCPM and Pvalue repeated for all prot models of a gene that are found in a particular comparison (t0-t1 or t1-t2)
		
		### some lines where there is no gene model or logCPM/pvalue data - there was no assoc prot model (no sec col in spp_gene_prot.txt)
	
	
	
		## CURRENT OUTPUTS: 
			
			# salmon_genes.txt  		Gene_ID
			# salmon_gene_prot.txt		Gene_ID	Prot_ID
			# salmon_prot.txt 	 		Prot_ID
			# salmon_prot_OG.txt		Prot_ID	OG	Organism
			
			# Need: 		Gene_ID	Prot_ID	Organism	OG
				# so join salmon_gene_prot.txt and salmon_prot_OG.txt on Prot_ID, save to salmon_OG.tmp
		
		# 5.1) Join the gene_id, p_id, organism and protein		
			join -1 2 -2 1 -o 1.1,1.2,1.3,1.4,2.2,2.3 test/salmon_gene_prot.txt test/salmon_prot_OG.txt > test/salmon_OG.tmp
	
		# 5.2) Append the DE data to each line in time course order
		
		
			join -1 2 -2 1 -o 1.1,1.2,1.3,1.4,2.3,2.4 salmon_OG.tmp test/salmonT0_edgeR_prot.tmp > test/join1.tmp
			join -1 2 -2 1 -o 1.1,1.2,1.3,1.4,1.5,1.6,2.3,2.4 test/join1.tmp test/salmonT1_edgeR.cut.tmp > test/salmon_out.txt
		
		
		
		## SALMON_OUT.TXT NOW HAS THE FOLLOWING:
		#Gene_ID		Prot_ID		Organism	OG		T0_vs_T1_logCPM		T0_vs_T1_Pvalue		T1_vs_T2_logCPM		T1_vs_T2_Pvalue	
	
	