#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_for_1st_48_sheep_reference --bmerge   plink_for_2nd_48_sheep_reference --make-bed --out plink_96_sheeps_reference 

plink --bfile plink_for_1st_48_sheep_reference --flip plink_96_sheeps_reference-merge.missnp --make-bed --out plink_for_1st_48_sheep_reference_flip

plink --bfile plink_for_1st_48_sheep_reference_flip --bmerge   plink_for_2nd_48_sheep_reference --make-bed --out plink_96_sheeps_reference 