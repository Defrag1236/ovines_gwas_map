#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_for_1st_48_sheep_reference --bmerge   plink_for_2nd_48_sheep_reference --make-bed --autosome-num 26 --out plink_96_sheeps_reference 

plink --bfile plink_for_1st_48_sheep_reference --exclude plink_96_sheeps_reference-merge.missnp --make-bed --autosome-num 26 --out plink_for_1st_48_sheep_reference_excluded
plink --bfile plink_for_2nd_48_sheep_reference --exclude plink_96_sheeps_reference-merge.missnp --make-bed --autosome-num 26 --out plink_for_2nd_48_sheep_reference_excluded

plink --bfile plink_for_1st_48_sheep_reference_excluded --bmerge   plink_for_2nd_48_sheep_reference_excluded --make-bed --autosome-num 26 --out plink_96_sheeps_reference_excluded 