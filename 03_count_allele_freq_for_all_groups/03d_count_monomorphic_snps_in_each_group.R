### count monomorphic snps in each group ###


# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

romanovka_af <- fread("romanovka_freq.frq", head=T, stringsAsFactors=F)
argali_af <- fread("argali_freq.frq", head=T, stringsAsFactors=F)
katahdin_af <- fread("katahdin_freq.frq", head=T, stringsAsFactors=F)
f1_kat_rom_af <- fread("f1_kat_rom_freq.frq", head=T, stringsAsFactors=F)
backcross_af <- fread("backcross_freq.frq", head=T, stringsAsFactors=F)
all_sheeps_af <- fread("96_sheeps_freq.frq", head=T, stringsAsFactors=F)

# count monomorhic snps

mono_snps <- matrix(ncol=1, nrow=6)

mono_snps[1,1] <- dim(subset(romanovka_af, romanovka_af$MAF==0, select=1))[1]
mono_snps[2,1] <- dim(subset(argali_af, argali_af$MAF==0, select=1))[1]
mono_snps[3,1] <- dim(subset(katahdin_af, katahdin_af$MAF==0, select=1))[1]
mono_snps[4,1] <- dim(subset(f1_kat_rom_af, f1_kat_rom_af$MAF==0, select=1))[1]
mono_snps[5,1] <- dim(subset(backcross_af, backcross_af$MAF==0, select=1))[1]
mono_snps[6,1] <- dim(subset(all_sheeps_af, all_sheeps_af$MAF==0, select=1))[1]

rownames(mono_snps) <- c("romanovka", "argali", "katahdin", "f1_kat_rom", "backcross", "all_sheeps")

# save result

write.table(mono_snps, "number_of_monomorphic_snps_for_each_group.txt", col.names=F, row.names=T, quote=F)