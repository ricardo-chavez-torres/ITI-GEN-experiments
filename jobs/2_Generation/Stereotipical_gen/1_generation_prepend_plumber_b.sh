#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=8:20:00
#SBATCH --output=GENERATED_plumber_b_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "**1. Generation Figure 6a**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Skin_tone' \
    --outdir='./ckpts/a_headshot_of_a_person_Male_Skin_tone/prepend_prompt_embedding_a_headshot_of_a_plumber/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Skin_tone/prepend_prompt_embedding_a_headshot_of_a_plumber/basis_final_embed_29.pt' \
    --n_iter=200 \
    --n_samples=1
