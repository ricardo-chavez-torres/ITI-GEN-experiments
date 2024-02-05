#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=01:10:00
#SBATCH --output=so_Training_ITI_GEN_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

echo "Word embeddings for FairFace"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

echo "Word embeddings CelebA and FAIR"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
