#!/usr/bin/bash 

cd /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --file plink_for_1st_48_sheeps --extract /home/common/projects/ovine_selection/ovines_gwas_map/Data/Filtered_snp_list_from_reference.txt --make-bed --autosome-num 26 --out plink_for_1st_48_sheep_reference
