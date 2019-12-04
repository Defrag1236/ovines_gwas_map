### pre_processing_raw_data ###


# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/old/20181112/raw")

raw_data <- fread("Sheep_HD_1-48.txt", head=T, stringsAsFactors=F)

# parse the full table for separate tables of samples

raw_data_list <- split(raw_data, rep(1:48, each=606006))

# rename matrix in list  

names_of_samples <- c(1:48)

for (n in (1:48)) {

	names_of_samples[n] <- raw_data_list[[n]][1,1]

	}

names(raw_data_list) <- names_of_samples

# delete unused info

	for ( n in (1:48)) {

		raw_data_list [[n]] <- raw_data_list[[n]] [,c("SNP.Name", "Allele1...Forward", "Allele2...Forward", "Chr", "Position")] 
		colnames(raw_data_list[[n]]) <- c("SNP", "A1", "A2", "Chr", "Pos")
		
		}


# save data as .Rdata

setwd ("/home/common/projects/ovine_selection/ovines_gwas_map/Data/Rdata")

save(raw_data_list, file="raw_data_pre_processed_for_1st_48_sheeps.Rdata")