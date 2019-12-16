#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_96_sheeps_reference_excluded --extract /home/common/projects/ovine_selection/ovines_gwas_map/results/sheep_reference_snp_list_to_clear_plink.txt  --make-bed --autosome-num 26 --out /home/common/projects/ovine_selection/ovines_gwas_map/sheep_reference/sheep_reference