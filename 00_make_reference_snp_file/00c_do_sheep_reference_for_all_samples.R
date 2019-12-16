### do sheep reference for all snps ###

# load data 

library(data.table)

setwd("/home/common/projects/ovine_selection/Data/ilumina_600K_forward_forward")

chip_data <- read.csv ("SNPchimp_result_3250871638.csv", sep=",", stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

all_sheeps_af <- fread("96_sheeps_freq.frq", head=T, stringsAsFactors=F)

# split alleles in chip data

library(stringr)

alleles_chip <- str_split_fixed(chip_data[,3], "/", 2)

chip_data <- cbind(chip_data[,c(2, 4:6)], alleles_chip)

colnames(chip_data)[5:6] <- c("A1", "A2")

# clear all_sheeps_af data

all_sheeps_af <- all_sheeps_af[!(grepl(pattern="-", x=all_sheeps_af$A1)),]
all_sheeps_af <- all_sheeps_af[!(grepl(pattern="-", x=all_sheeps_af$A2)),]
all_sheeps_af <- all_sheeps_af[!(grepl(pattern="0", x=all_sheeps_af$A1)),]


# compare plink and chip_data and cbind reference with maf

reference <- chip_data[(chip_data$SNP_name %in% all_sheeps_af$SNP),] 

reference <- reference[match(all_sheeps_af$SNP, reference$SNP_name),]


to_switch <- which(reference$A1 != all_sheeps_af$A1)

reference_s <- reference
reference_s[to_switch, "A1"] <- reference[to_switch, "A2"]
reference_s[to_switch, "A2"] <- reference[to_switch, "A1"]
reference <- reference_s


reference <- cbind(reference, all_sheeps_af$MAF)
colnames(reference)[7] <- "maf"

# make reference alleles in right order

fun_to_apply <- function(x){
 	alleles <- x[5:6]
 	
 	l <- order(alleles)
 	
 	if (l[1]==2){
  		out=1
 		} else {
  		out=0
 			}

 	return(out)
}

to_switch <- apply(reference,MAR=1,FUN=fun_to_apply)

reference[to_switch==1,"maf"] <- 1-reference[to_switch==1,"maf"]


tmp <- reference[to_switch==1,"A1"]
reference[to_switch==1,"A1"] <- reference[to_switch==1,"A2"]
reference[to_switch==1,"A2"] <- tmp

colnames(reference)[5:7]=c("EA","RA", "eaf")

# save result

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/sheep_reference")

fwrite(reference, "sheep_reference.txt", col.names=T, row.names=F, quote=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/results")

write.table(reference$SNP_name, "sheep_reference_snp_list_to_clear_plink.txt", col.names=F, row.names=F, quote=F)


