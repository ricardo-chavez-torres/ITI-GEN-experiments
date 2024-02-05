#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=02:20:00
#SBATCH --output=so_Training_ITI_GEN%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "Word embeddings for Male"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

echo "Word embeddings for Young"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Young' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for pale skin"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Pale_Skin' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for eye glass"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Eyeglasses' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for mustache"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Mustache' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for smile"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Smiling' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young*Eyeglass"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young,Eyeglasses' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young*Eyeglass*smile"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young,Eyeglasses,Smiling' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0