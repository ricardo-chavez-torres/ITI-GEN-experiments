#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=GENERATED_humandomain
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=03:00:00
#SBATCH --output=stereotipical_generated_b_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "**1. Generation of prompts with pretrained on the human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone' \
    --load-model-epoch=29 \
    --prepended-prompt='a headshot of a nanny' \
    --device 0


echo "**1. Generation of prompts with pretrained on the human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone' \
    --load-model-epoch=29 \
    --prepended-prompt='a headshot of a plumber' \
    --device 0
