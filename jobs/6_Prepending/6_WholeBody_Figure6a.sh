#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=GENERATED_humandomain
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=03:00:00
#SBATCH --output=whole_body_generated_a%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN
#This embeddings will get saved in /ckpts/a_headhshot_of_a_person_Male/preprend_prompt_embedding_a_bodyshot_of_a_person
# 1. Train on human domain (only several minutes)**
echo "**1. Generation of prompts with pretrained on the human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --load-model-epoch=29 \
    --prepended-prompt='whole body shot of a person' \
    --device 0

