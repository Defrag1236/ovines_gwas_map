### qc for romanovka af ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

reference <- fread("clear_reference_for_sheeps_with_eaf_for_a1_17_romanovskaya_female_sheeps.txt", head=T, stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

romanovka_af <- fread("romanovka_freq.frq", head=T, stringsAsFactors=F)

# compare snps set, doesnt work

reference_clear <- reference[(reference$SNP_name %in% romanovka_af_clear$SNP),]

reference_clear <- reference_clear[!duplicated(reference_clear$SNP_name),]
reference_clear <- reference_clear[!is.na(reference_clear$SNP_name),]

rownames(reference_clear) <- reference_clear$SNP_name

romanovka_af_clear <- romanovka_af[!duplicated(romanovka_af$SNP),]
romanovka_af_clear <- romanovka_af_clear[!is.na(romanovka_af_clear$SNP),]

rownames(romanovka_af_clear) <- romanovka_af_clear$SNP

reference_clear <- reference_clear[order(rownames(reference_clear), rownames(romanovka_af_clear)),]