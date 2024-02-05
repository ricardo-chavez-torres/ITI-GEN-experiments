#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=GFigure_9_Generation
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=4:10:00
#SBATCH --output=GENERATED_Figure_9_20_25_50_100_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used for training array
# refer_sizes=(5 10 15)
refer_sizes=(20 25 50 100)
# Loop through different refer_size_per_category values
for refer_size in "${refer_sizes[@]}"
do
    echo "**1. Generation for Male attribute**"
    python generation.py \
        --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
        --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
        --plms \
        --attr-list='Male' \
        --outdir="./ckpts_figure_9/refer_size_${refer_size}/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results" \
        --prompt-path="./ckpts_figure_9/refer_size_${refer_size}/a_headshot_of_a_person_Male/original_prompt_embedding/basis_final_embed_29.pt" \
        --n_iter=200 \
        --skip_grid \
        --n_samples=1
done
#   - `--config`: config file for Stable Diffusion.
#   - `--ckpt`: path to the pre-trained Stable Diffusion checkpoint.
#   - `--plms`: whether to use the plms sampling.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_lis$
#   - `--outdir`: output directory of the generated images.
#   - `--prompt_path`: path to the learnt prompt embeddings with ITI-GEN.
#   - `--n_iter`: number of iterations for the diffusion sampling.
#   - `--n_rows`: number of rows in the output image grid.
#   - `--n_samples`: number of samples per row.