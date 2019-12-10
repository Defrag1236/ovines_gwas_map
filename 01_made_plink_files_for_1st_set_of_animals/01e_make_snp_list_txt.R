### make snp filtered list in txt format ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

reference <- fread("clear_reference_for_sheeps_with_eaf_for_a1_17_romanovskaya_female_sheeps.txt", head=T, stringsAsFactors=F) 

# make snp list

snp_list <- as.vector(reference$SNP_name)

# save snp list

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data")

write.table(snp_list, "Filtered_snp_list_from_reference.txt", col.names=F, row.names=F, quote=F)