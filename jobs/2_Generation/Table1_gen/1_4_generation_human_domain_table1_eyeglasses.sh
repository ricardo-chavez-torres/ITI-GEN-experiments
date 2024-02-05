#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=1:40:00
#SBATCH --output=GENERATED_humandomain_table1_results_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen


## Training ITI-GEN

# 4. Train for Eyeglasses attribute 
echo "**4. Generation for Eyeglasses attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Eyeglasses' \
    --outdir='./ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=200 \
    --n_rows=200 \
    --skip_grid \
    --n_samples=1