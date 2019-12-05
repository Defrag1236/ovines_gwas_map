#!/usr/bin/bash 

cd  /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --file plink_for_1st_48_sheeps --merge  /home/common/projects/ovine_selection/GWAS_on_russian_population_of_ovines/data/plink_files/ped_3m/ped_3m_1_trait.ped /home/common/projects/ovine_selection/GWAS_on_russian_population_of_ovines/data/plink_files/ped_3m/ped_3m_1_trait.map --recode --out 96_sheeps 