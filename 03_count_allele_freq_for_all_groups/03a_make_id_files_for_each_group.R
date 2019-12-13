### make id files for each group ###

# load data

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data")
breed_info <- read.csv("sex_for_1st_48_sheeps.csv", head=T, stringsAsFactors=F, sep=";", fileEncoding="latin1")
breed_info[26,1] <- "FZ463"

# make id files 

argali <- matrix(ncol=2, nrow=nrow(breed_info[grepl(pattern="Argali", x=breed_info$breed),]))
argali[,1] <- 0
argali[,2] <- breed_info[grepl(pattern="Argali", x=breed_info$breed),1]

f1_kat_rom <- matrix(ncol=2, nrow=nrow(breed_info[grepl(pattern="F1- KAT/ROM", x=breed_info$breed),]))
f1_kat_rom[,1] <- 0
f1_kat_rom[,2] <- breed_info[grepl(pattern="F1- KAT/ROM", x=breed_info$breed),1]

katahdin <- matrix(ncol=2, nrow=nrow(breed_info[grepl(pattern="Katahdin", x=breed_info$breed),]))
katahdin[,1] <- 0
katahdin[,2] <- breed_info[grepl(pattern="Katahdin", x=breed_info$breed),1]

romanovka <- matrix(ncol=2, nrow=nrow(breed_info[grepl(pattern="Romanov", x=breed_info$breed),]))
romanovka[,1] <- 0
romanovka[,2] <- breed_info[grepl(pattern="Romanov", x=breed_info$breed),1]

backcross <- matrix(ncol=2, nrow=48)
backcross[,1] <- 0
backcross[,2] <- seq(1:48)

# save id files

write.table(argali, "argali_id.txt", col.names=F, row.names=F, quote=F, sep="\t")
write.table(f1_kat_rom, "f1_kat_rom_id.txt", col.names=F, row.names=F, quote=F, sep="\t")
write.table(katahdin, "katahdin_id.txt", col.names=F, row.names=F, quote=F, sep="\t")
write.table(romanovka, "romanovka_id.txt", col.names=F, row.names=F, quote=F, sep="\t")
write.table(backcross, "backcross_id.txt", col.names=F, row.names=F, quote=F, sep="\t")