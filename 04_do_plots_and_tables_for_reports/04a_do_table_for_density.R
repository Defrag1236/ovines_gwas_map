### table for density ###


# laod data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/sheep_reference")

reference <- fread("sheep_reference.txt", head=T, stringsAsFactors=F, data.table=F)

# make table with number of SNPs and density on 1 Mb for each chromosome

report_table <- matrix(ncol=3, nrow=26)
report_table[,1] <- seq(1:26)

colnames(report_table) <- c("Chr", "N_snps", "Average_N_snps_on_1Mb")

for (n in (1:26)) {

	s1 <- seq(0, max(reference[which(reference$chromosome==n),"position"]), by = 1000000)
	x <- Map(c, s1[-length(s1)], s1[-1])
	y <- reference[which(reference$chromosome==n),"position"]

	report_table[n,2] <- length(y)

	to_density <- c()

		for (i in (1:length(x))) {

		 	to_density[i] <- sum(y %in% seq(x[[i]][1], x[[i]][2]))

		 }

	report_table[n,3] <- mean(to_density)

}


write.table(report_table, "/home/common/projects/ovine_selection/ovines_gwas_map/results/for_reports/table_with_density_of_snps.txt", col.names=T, row.names=F, quote=F)


