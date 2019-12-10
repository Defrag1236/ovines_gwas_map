#!/usr/bin/bash

cd /home/common/projects/ovine_selection/ovines_gwas_map/Data/plink_files

plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/argali_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/argali_freq
plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/f1_kat_rom_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/f1_kat_rom_freq
plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/f1_arg_rom_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/f1_arg_rom_freq
plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/katahdin_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/katahdin_freq
plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/romanovka_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/romanovka_freq
plink --bfile plink_96_sheeps_reference_excluded --keep /home/common/projects/ovine_selection/ovines_gwas_map/Data/backcross_id.txt --freq --out /home/common/projects/ovine_selection/ovines_gwas_map/results/backcross_freq