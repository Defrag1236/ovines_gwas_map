## do pedAB matrix ###

# load data

setwd ("/home/common/projects/ovine_selection/ovines_gwas_map/Data/Rdata")

load("raw_data_pre_processed_for_1st_48_sheeps.Rdata")

# make AB column for each individual

library(tidyr)

for (n in (1:48)) {

	raw_data_list[[n]] <- unite(data=raw_data_list[[n]], ...=2:3, col=AB, sep=" ")

	}

# make AB matrix for ped files 

pedAB <- matrix(ncol=nrow(raw_data_list[[1]]), nrow=48)
rownames(pedAB) <- names(raw_data_list)

for (n in (c(1:48))) {

	pedAB_n <- t(as.matrix((unlist(raw_data_list[[n]]$AB))))

	pedAB[n,] <- pedAB_n
	}


# save pedAB as .Rdata

save(pedAB, file="pedAB_for_1st_48_sheep.Rdata")