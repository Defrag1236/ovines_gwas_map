### make plot for eaf reference ###

# load data

library(data.table)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/sheep_reference")

reference <- fread("sheep_reference.txt", head=T, stringsAsFactors=F, data.table=F)

# make table for plot

for_plot <- matrix(ncol=4, nrow=6)

for_plot[1,1] <- 0
for_plot[2,1] <- 0.01
for_plot[3,1] <- 0.05
for_plot[4,1] <- 0.1
for_plot[5,1] <- 0.2
for_plot[6,1] <- 0.25

for_plot[1,2] <- 0.01
for_plot[2,2] <- 0.05
for_plot[3,2] <- 0.1
for_plot[4,2] <- 0.2
for_plot[5,2] <- 0.25
for_plot[6,2] <- 0.5

maf <- pmin(1-reference$eaf,reference$eaf)

for (n in (1:nrow(for_plot))) {

	for_plot[n,3] <- length(maf[maf > for_plot[n,1] & maf <= for_plot[n,2]])

	}

for_plot[,4] <- paste(for_plot[,1], for_plot[,2], sep="-")
colnames(for_plot) <- c("range1", "range2", "count", "range")

# make plot

library(ggplot2)
library(scales)

tiff("/home/common/projects/ovine_selection/ovines_gwas_map/results/for_reports/maf_distribution.tiff")

ggplot(as.data.frame(for_plot[,(3:4)]), aes(x=factor(range),  y=as.numeric(as.matrix(count)))) +
   
 	geom_bar(stat = "identity", fill="steelblue") +
 	xlab("Minor allele frequency") +
 	ylab("Number of SNPs") +
 	theme_classic() +
 	scale_y_continuous(label = comma) +
 	geom_text(aes(label = count),
        vjust = -0.25,
        color = "black", 
        position=position_dodge(width=1)
        ) +
    theme_classic()
   
dev.off()

