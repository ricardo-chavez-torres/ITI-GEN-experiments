#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Figure_9_evaluation
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=01:30:00
#SBATCH --output=EVALUATION_Figure_9_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used 
refer_sizes=(5 10 15 20 25 50 100)

# Loop through different refer_size_per_category values
for refer_size in "${refer_sizes[@]}"
do
    outdir="ckpts_figure_9/refer_size_${refer_size}/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results"
    directories=("$outdir"/*)
    for directory in "${directories[@]}"; do
        if [ -d "$directory" ]; then
            images="$directory"/*.png
            for archivo in $images; do
                dir_name=$(dirname "$archivo")
                file_name=$(basename "$archivo")
                # Remove leading slash from directory name
                dir_name="${dir_name#/}"
                # Replace slashes in directory name with underscores
                dir_name="${dir_name//\//_}"
                cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
            done
        fi
    done
    echo "Evaluation Male with $refer_size reference images"
    python evaluation.py \
        --img-folder $outdir \
        --class-list 'a headshot of a man' 'a headshot of a woman' \
        --device 0
    rm "$outdir"/*.png
done

#echo 'Male, young, eyeglasses, smiling'
#python evaluation.py \
#    --img-folder 'ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses_Smiling/original_prompt_embedding/sample_results/Male_positive_Young_positive_Eyeglasses_positive_Smiling_positive' \
#    --class-list 'a headshot of a young male smiling with eyeglasses' \
#    --device 0
#    - `--img_folder`: the image folder that you want to evaluate.
#    - `--class_list`: the class prompts used for evaluation, separated by a space. The length of the list depends on the number of category combinations for different attributes. In terms of writing evaluation prompts for CelebA attributes, please refer (but not limited) to Table A3 in the supplementary materials.