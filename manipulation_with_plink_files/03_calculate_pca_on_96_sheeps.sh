#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_96_sheeps_reference_excluded --pca --out pca_96_sheeps