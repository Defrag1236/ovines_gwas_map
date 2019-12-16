### filter and prepare sheep reference ###

# load data

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

library(data.table)

reference <- fread("reference_for_sheeps_with_eaf_for_18_romanovskaya_female_sheeps.txt", head=T, stringsAsFactors=F)

# make alleles in lexicographical order

alleles <- paste(reference$A1, reference$A2, sep="")

reference <- cbind(reference, alleles) 

reference <- reference[order(reference$alleles),]

reference_to_order <- rbind(reference[grepl(pattern="TA", x=reference$alleles),], reference[grepl(pattern="TC", x=reference$alleles),], reference[grepl(pattern="TG", x=reference$alleles),])

reference_to_order <- reference_to_order[,c(1:4, 6,5,7:8)]
colnames(reference_to_order)[5:6] <- c("A1", "A2")
reference_to_order$alleles <- paste(reference_to_order$A1, reference_to_order$A2, sep="")  

reference_order <- reference[!(reference$rs %in% reference_to_order$rs),]
reference_order$eaf <- 1-reference_order$eaf

reference_order <- rbind(reference_order, reference_to_order)

reference_order <- reference_order[order(reference_order$alleles),]

# clear from duplicates

## delete duplicated rs

bad_rs <- reference_order[duplicated(reference_order$rs),]

for (n in (1:nrow(bad_rs))) {

	reference_order <- reference_order[!grepl(pattern=paste(bad_rs$rs[n]), x=reference_order$rs),]

	}

## delete duplicated chr_pos

chr_pos <- paste(reference_order$chromosome, reference_order$position, sep="_")
bad_chr_pos <- chr_pos[duplicated(chr_pos)]

to_delete <- which(chr_pos %in% bad_chr_pos)

reference_order <- reference_order[-to_delete,]

## delete duplicated SNP_name

bad_snp_name <- reference_order[duplicated(reference_order$SNP_name),]

to_delete <- which(reference_order$SNP_name %in% bad_snp_name)

reference_order <- reference_order[-to_delete,]

# delete x chromosme

reference_order <- reference_order[!grepl(pattern="X", x=reference_order$chromosome),]

# save result

reference_order_clear <- reference_order[,-c(8:9)]

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

fwrite(reference_order_clear, "clear_reference_for_sheeps_with_eaf_for_a1_18_romanovskaya_female_sheeps.txt", col.names=T, row.names=F, quote=F)
