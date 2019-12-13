### make scatter plots for af ###

# load_data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

romanovka_af <- fread("romanovka_freq.frq", head=T, stringsAsFactors=F)
argali_af <- fread("argali_freq.frq", head=T, stringsAsFactors=F)
katahdin_af <- fread("katahdin_freq.frq", head=T, stringsAsFactors=F)
f1_kat_rom_af <- fread("f1_kat_rom_freq.frq", head=T, stringsAsFactors=F)
f1_rom_arg_af <- fread("backcross_freq.frq", head=T, stringsAsFactors=F)
all_sheeps_af <- fread("96_sheeps_freq.frq", head=T, stringsAsFactors=F)

# make plots 

##1

to_change <- which(romanovka_af$A1 != argali_af$A1)

romanovka_af_for_plot <- romanovka_af
romanovka_af_for_plot[to_change,"A1"] <- romanovka_af_for_plot[to_change, "A2"]
romanovka_af_for_plot[to_change,"A2"] <- romanovka_af[to_change,"A1"]

romanovka_af_for_plot[to_change,"MAF"] <- 1-romanovka_af[to_change,"MAF"]

png("romanovka_af_vs_argali_af.png")

plot(romanovka_af_for_plot$MAF, argali_af$MAF)

dev.off()

##2

to_change <- which(romanovka_af$A1 != katahdin_af$A1)

romanovka_af_for_plot <- romanovka_af
romanovka_af_for_plot[to_change,"A1"] <- romanovka_af_for_plot[to_change, "A2"]
romanovka_af_for_plot[to_change,"A2"] <- romanovka_af[to_change,"A1"]

romanovka_af_for_plot[to_change,"MAF"] <- 1-romanovka_af[to_change,"MAF"]

png("romanovka_af_vs_katahdin_af.png")

plot(romanovka_af_for_plot$MAF, katahdin_af$MAF)

dev.off()

##3 

to_change <- which(romanovka_af$A1 != all_sheeps_af$A1)

romanovka_af_for_plot <- romanovka_af
romanovka_af_for_plot[to_change,"A1"] <- romanovka_af_for_plot[to_change, "A2"]
romanovka_af_for_plot[to_change,"A2"] <- romanovka_af[to_change,"A1"]

romanovka_af_for_plot[to_change,"MAF"] <- 1-romanovka_af[to_change,"MAF"]

png("romanovka_af_vs_all_sheeps_af.png")

plot(romanovka_af_for_plot$MAF, all_sheeps_af$MAF)

dev.off()
