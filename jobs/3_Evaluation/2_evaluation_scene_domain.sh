#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=02:20:00
#SBATCH --output=EVALUATION_scenedomain%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Evaluation Natural Scenes

python evaluation.py \
    --img-folder 'ckpts/a_natural_scene_Colorful/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person wearing eyeglasses' 'a headshot of a person' 'a forest in the winter' \
    --device 0

#    - `--img_folder`: the image folder that you want to evaluate.
#    - `--class_list`: the class prompts used for evaluation, separated by a space. The length of the list depends on the number of category combinations for different attributes. In terms of writing evaluation prompts for CelebA attributes, please refer (but not limited) to Table A3 in the supplementary materials.