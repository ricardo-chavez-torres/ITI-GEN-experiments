#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=02:20:00
#SBATCH --output=GENERATED_humandomain%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "**1. Generation on the human domain**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Skin_tone,Age' \
    --outdir='./ckpts/a_headshot_of_a_person_Male_Skin_tone_Age/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Skin_tone_Age/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --n_rows=5 \
    --n_samples=1

#   - `--config`: config file for Stable Diffusion.
#   - `--ckpt`: path to the pre-trained Stable Diffusion checkpoint.
#   - `--plms`: whether to use the plms sampling.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_lis$
#   - `--outdir`: output directory of the generated images.
#   - `--prompt_path`: path to the learnt prompt embeddings with ITI-GEN.
#   - `--n_iter`: number of iterations for the diffusion sampling.
#   - `--n_rows`: number of rows in the output image grid.
#   - `--n_samples`: number of samples per row.