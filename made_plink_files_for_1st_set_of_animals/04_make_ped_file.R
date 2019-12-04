### make ped file ###

# load pedAB matrix

setwd ("/home/common/projects/ovine_selection/ovines_gwas_map/Data/Rdata")

load("pedAB_for_1st_48_sheep.Rdata")

setwd ("/home/common/projects/ovine_selection/ovines_gwas_map/Data")

sex_id_info <- read.csv("sex_for_1st_48_sheeps.csv", head=T, stringsAsFactors=F, sep=";", fileEncoding="latin1")

# correct small mistake

sex_id_info[26,1] <- "FZ463"


# make first 6 columns ped

ped6 <- data.frame(
  	FID = 0,
  	IID = sex_id_info$ID,
  	FatherID = 0,
  	MotherID = 0,
  	Sex = sex_id_info$sex,
  	Phenotype = -9)


# make match matrix

match_matrix <- matrix(ncol=2, nrow=48)
match_matrix [,1] <- seq(1:48) 
match_matrix [,2] <- sex_id_info$ID

to_match <- match(rownames(pedAB), match_matrix[,2])

# make ped file

ped <- cbind(ped6, pedAB)

# save ped

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files")

library (data.table)

fwrite(ped, "ped_for_1st_48_sheeps.map", quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")