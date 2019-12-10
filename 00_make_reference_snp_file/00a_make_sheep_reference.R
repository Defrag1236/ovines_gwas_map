### do reference data.table for sheep ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/Data/ilumina_600K_forward_forward")

chip_data <- read.csv ("SNPchimp_result_3250871638.csv", sep=",", stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/old/20181112/raw")

raw_data <- fread("Sheep_HD_1-48.txt", head=T, stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data")

breed_info <- read.csv("sex_for_1st_48_sheeps.csv", head=T, stringsAsFactors=F, sep=";", fileEncoding="latin1")
breed_info[26,1] <- "FZ463"

animal_id <- breed_info[grepl(pattern="Romanov", x=breed_info$breed),1]

# pre-processed chip data 

## split alleles in chip data

library(stringr)

alleles_chip <- str_split_fixed(chip_data[,3], "/", 2)

chip_data <- cbind(chip_data[,c(2, 4:6)], alleles_chip)

colnames(chip_data)[5:6] <- c("A1", "A2")

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

for (n in (1:length(animal_id))) {

	x <- raw_data_list[[paste(animal_id[n])]]
	
	romanovka_list[[n]] <- x

	}

 
## delete unused info 

for ( n in (1:18)) {

	romanovka_list[[n]] <- romanovka_list[[n]] [,c("SNP.Name", "Allele1...Forward", "Allele2...Forward", "Chr", "Position")] 
	colnames(romanovka_list[[n]]) <- c("SNP", "A1", "A2", "Chr", "Pos")
	
	}

# count maf 

allele_count <- matrix(ncol=18, nrow=nrow(chip_data))


for (n in (1:length(animal_id))) {

 A1_count <- rep(0, nrow(chip_data))
 A1_count[chip_data[,"A2"]==romanovka_list[[n]]$A1]=1
 
 A2_count <- rep(0, nrow(chip_data))
 A2_count[chip_data[,"A2"]==romanovka_list[[n]]$A2]=1

 allele_count[,n] <- A1_count+A2_count

}

eaf <- apply(allele_count,MAR=1,mean)/2

chip_data_with_eaf <- cbind(chip_data, eaf)


# delete bad info


chip_data_with_eaf_clear <- chip_data_with_eaf[!grepl(pattern=99,x= chip_data_with_eaf$chromosome),]
chip_data_with_eaf_clear <- chip_data_with_eaf_clear[!grepl(pattern="IN",x= chip_data_with_eaf_clear$A1),]
chip_data_with_eaf_clear <- chip_data_with_eaf_clear[!grepl(pattern="DE",x= chip_data_with_eaf_clear$A2),]

# save result

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

fwrite(chip_data_with_eaf_clear, "reference_for_sheeps_with_eaf_for_17_romanovskaya_female_sheeps.txt", col.names=T, row.names=F, quote=F)





