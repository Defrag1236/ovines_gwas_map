### qc for romanovka af ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

reference <- fread("reference_for_sheeps_with_eaf_for_18_romanovskaya_female_sheeps.txt", head=T, stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

romanovka_af <- fread("romanovka_freq.frq", head=T, stringsAsFactors=F)

# filter data



reference_clear <- reference[!duplicated(reference$SNP_name),]
reference_clear <- reference_clear[!is.na(reference_clear$SNP_name),]
reference_clear$eaf <- round(reference_clear$eaf, digits=4)

romanovka_af_clear <- romanovka_af[!duplicated(romanovka_af$SNP),]
romanovka_af_clear <- romanovka_af_clear[!is.na(romanovka_af_clear$SNP),]
romanovka_af_clear <- romanovka_af_clear[!grepl(pattern="0", x=romanovka_af_clear$A1),]
romanovka_af_clear <- romanovka_af_clear[!grepl(pattern="-", x=romanovka_af_clear$A1),]
romanovka_af_clear <- romanovka_af_clear[!grepl(pattern="-", x=romanovka_af_clear$A2),]
romanovka_af_clear$MAF <- round(romanovka_af_clear$MAF, digits=4)

reference_clear <- reference_clear[(reference_clear$SNP_name %in% romanovka_af_clear$SNP),]

# prepare to plot 

reference_clear <- reference_clear[match(romanovka_af_clear$SNP, reference_clear$SNP_name),]

ind_to_switch=which(reference_clear$A2!=romanovka_af_clear$A1)
reference_clear$eaf[ind_to_switch]=1-reference_clear$eaf[ind_to_switch]

# make plot

png("romanovka_af_vs_reference.png")

plot(reference_clear$eaf, romanovka_af_clear$MAF)

dev.off()

