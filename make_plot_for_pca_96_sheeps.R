### make plot for pca 96 sheeps ###

# load pca data and breed data 

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files")

pca_eigenval <- read.table("pca_96_sheeps.eigenval", head=F, stringsAsFactors=F)
pca_eigenvec <- read.table("pca_96_sheeps.eigenvec", head=F, stringsAsFactors=F)

setwd("/home/common/projects/ovine_selection/ovines_gwas_map/Data")

breed_info <- read.csv("sex_for_1st_48_sheeps.csv", head=T, stringsAsFactors=F, sep=";", fileEncoding="latin1")

# make plot

for_plot <- cbind(pca_eigenvec$V3, pca_eigenvec$V4, breed_info$breed)


for_plot[c(1:48),3] <- "F1-Arg/Rom"
for_plot[c(49:96),3] <- breed_info$breed

setwd("/home/common/projects/ovine_selection/ovines_gwas_map")

pdf(filename="pca_96_sheeps.pdf")

plot(for_plot[,1], for_plot[,2])
points(for_plot[grepl(pattern="Argali", x=for_plot[,3]),1],for_plot[grepl(pattern="Argali", x=for_plot[,3]),2], col="red")
points(for_plot[grepl(pattern="F1- KAT/ROM", x=for_plot[,3]),1],for_plot[grepl(pattern="F1- KAT/ROM", x=for_plot[,3]),2], col="green")
points(for_plot[grepl(pattern="F1-Arg/Rom", x=for_plot[,3]),1],for_plot[grepl(pattern="F1-Arg/Rom", x=for_plot[,3]),2], col="blue")
points(for_plot[grepl(pattern="Katahdin", x=for_plot[,3]),1],for_plot[grepl(pattern="Katahdin", x=for_plot[,3]),2], col="yellow")
points(for_plot[grepl(pattern="Romanov", x=for_plot[,3]),1],for_plot[grepl(pattern="Romanov", x=for_plot[,3]),2], col="black")

dev.off()

