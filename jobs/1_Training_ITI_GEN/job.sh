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
echo "1. Train on human domain (only several minutes)**"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone,Age' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

# **2. Train on scene domain (only several minutes)**
echo "2. Train on scene domain (only several minutes)**"
python train_iti_gen.py \
    --prompt='a natural scene' \
    --attr-list='Colorful' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0


## (Optional) Prompt Prepending
echo "(Optional) Prompt Prepending"
# **1. Prepend on human domain**
echo "**1. Prepend on human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone,Age' \
    --load-model-epoch=19 \
    --prepended-prompt='a headshot of a doctor' \
    --device=0

# **2. Prepend on scene domain**
echo "2. Prepend on scene domain**"
python prepend.py \
    --prompt='a natural scene' \
    --attr-list='Colorful' \
    --load-model-epoch=19 \
    --prepended-prompt='an alien pyramid landscape, art station, landscape, concept art, illustration, highly detailed artwork cinematic' \
    --device=0
