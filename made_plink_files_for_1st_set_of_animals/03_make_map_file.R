### make map file ###

# load data

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data/Rdata")

load("raw_data_pre_processed_for_1st_48_sheeps.Rdata")

# do map file

map <- data.frame(
  CHR = raw_data_list[[1]]$Chr,
  SNP = raw_data_list[[1]]$SNP,
  CM = 0,
  BP = raw_data_list[[1]]$Pos)

# save .map file

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files")

library (data.table)

fwrite(map, "map_for_1st_48_sheeps.map", quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")