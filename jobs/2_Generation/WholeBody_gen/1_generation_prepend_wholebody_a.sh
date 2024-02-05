#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=8:20:00
#SBATCH --output=GENERATED_wholebody_a_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "**1. Generation Figure 6a for whole body**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Age,Male' \
    --outdir='./ckpts/a_headshot_of_a_person_Age_Male/prepend_prompt_embedding_whole_body_shot_of_a_person/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Age_Male/prepend_prompt_embedding_whole_body_shot_of_a_person/basis_final_embed_29.pt' \
    --n_iter=200 \
    --skip_grid \
    --n_samples=1