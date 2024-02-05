#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Figure_9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=02:20:00
#SBATCH --output=so_Training_Figure_9_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**

# Define the refer_sizes per category used for training array
refer_sizes=(5 10 15)
# refer_sizes=(20 25 50 100)
# Loop through different refer_size_per_category values
for refer_size in "${refer_sizes[@]}"
do
    echo "Training ITI-GEN with refer_size_per_category=$refer_size"

    python train_iti_gen.py \
        --prompt='a headshot of a person' \
        --attr-list='Male' \
        --epochs=30 \
        --save-ckpt-per-epochs=30 \
        --device=0 \
        --ckpt-path="./ckpts_figure_9/refer_size_${refer_size}" \
        --refer-size-per-category=$refer_size
done



#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

