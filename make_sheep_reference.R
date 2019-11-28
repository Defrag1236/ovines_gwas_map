### do reference data.table for sheep ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/Data/ilumina_600K_forward_forward")

chip_data <- read.csv ("SNPchimp_result_3250871638.csv", sep=",", stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/old/20181112/raw")

raw_data <- fread("Sheep_HD_1-48.txt", head=T, stringsAsFactors=F)

animal_id <- fread("Romanovskaya_id.txt", head=F, stringsAsFactors=F)

# pre-processed chip data 

## split alleles in chip data

library(stringr)

alleles_chip <- str_split_fixed(chip_data[,3], "/", 2)

chip_data <- cbind(chip_data[,4:6], alleles_chip)

colnames(chip_data)[4:5] <- c("A1", "A2")

## make SNPs in order

chip_data <- chip_data[order(chip_data$SNP_name),]

# pre-processed raw data 

## parse the full table for separate tables of samples

raw_data_list <- split(raw_data, rep(1:48, each=606006))

## rename matrix in list 

for (n in (1:48)) {

	names(raw_data_list)[n] <- raw_data_list[[n]][1,1]

	}

## extract romanoska samples

romanovka_list <- list()

for (n in (1:nrow(animal_id))) {

	x <- raw_data_list[[paste(animal_id[n,])]]
	
	romanovka_list[[n]] <- x

	}

 
## delete unused info 

for ( n in (1:17)) {

	romanovka_list[[n]] <- romanovka_list[[n]] [,c("SNP.Name", "Allele1...Forward", "Allele2...Forward", "Chr", "Position")] 
	colnames(romanovka_list[[n]]) <- c("SNP", "A1", "A2", "Chr", "Pos")
	
	}

# count maf 

A1_alt <- matrix(ncol=17, nrow=nrow(chip_data))
A2_alt <- matrix(ncol=17, nrow=nrow(chip_data))

for (n in (1:nrow(animal_id))) {

	A1_count <- matrix(ncol=1, nrow=nrow(chip_data))
	chip_data_A1_count <- cbind(chip_data, A1_count) 
	chip_data_A1_count[chip_data_A1_count$A2 == romanovka_list[[n]]$A1, "A1_count"] <- 1  
	A1_alt[,n] <- chip_data_A1_count$A1_count

	A2_count <- matrix(ncol=1, nrow=nrow(chip_data))
	chip_data_A2_count <- cbind(chip_data, A2_count) 
	chip_data_A2_count[chip_data_A2_count$A2 == romanovka_list[[n]]$A2, "A2_count"] <- 1  
	A2_alt[,n] <- chip_data_A2_count$A2_count

	}


A1_alt[is.na(A1_alt)] <- 0
A2_alt[is.na(A2_alt)] <- 0

maf <- matrix(ncol=1, nrow=nrow(chip_data))

for (n in (1:nrow(chip_data))) {

	maf[n,1] <- sum(A1_alt[n,]+A2_alt[n,])/34

	}


chip_data_with_maf <- cbind(chip_data, maf)


# save result

setwd("/home/common/projects/ovine_selection/Results")

fwrite(chip_data_with_maf, "reference_for_sheeps(maf_for_17_romanovskaya_sheeps).txt", col.names=T, row.names=F, quote=F)





