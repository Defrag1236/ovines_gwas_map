#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_96_sheeps_reference_excluded --pca --out pca_96_sheeps

plink --bfile plink_96_sheeps_reference_excluded --maf 0.1 --geno 0.05 --pca --out pca_96_sheeps_filtered