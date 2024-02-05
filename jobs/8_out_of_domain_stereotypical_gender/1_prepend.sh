#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=PREPENDING_stereotipical_professions
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:15:00
#SBATCH --output=stereotipical_professions%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN
#This embeddings will get saved in /ckpts/a_headhshot_of_a_person_Male/preprend_prompt_embedding_a_headshot_of_a_nanny
# 1. Train on human domain (only several minutes)**
professions=("cheerleader" "ballet dancer" "fashion designer" "elementary school teacher" "driver" "mechanic" "construction worker" "soldier")
# Loop through different refer_size_per_category values

for profession in "${professions[@]}"
do
    echo "**1. Generation of prompts with pretrained on the human domain on profession $profession**"

    python prepend.py \
        --prompt='a headshot of a person' \
        --attr-list='Male' \
        --load-model-epoch=29 \
        --prepended-prompt="a headshot of a $profession" \
        --device 0

done

