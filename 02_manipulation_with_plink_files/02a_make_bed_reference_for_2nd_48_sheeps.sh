#!/usr/bin/bash 

cp /home/common/projects/ovine_selection/GWAS_on_russian_population_of_ovines/data/plink_files/ped_3m/ped_3m_1_trait.ped /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files/plink_for_2nd_48_sheeps.ped
cp /home/common/projects/ovine_selection/GWAS_on_russian_population_of_ovines/data/plink_files/ped_3m/ped_3m_1_trait.map /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files/plink_for_2nd_48_sheeps.map

cd /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --file plink_for_2nd_48_sheeps --extract /home/common/projects/ovine_selection/ovines_gwas_map/Data/Filtered_snp_list_from_reference.txt --make-bed --out plink_for_2nd_48_sheep_reference
