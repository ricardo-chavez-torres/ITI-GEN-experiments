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
professions_path=("prepend_prompt_embedding_a_headshot_of_a_cheerleader" "prepend_prompt_embedding_a_headshot_of_a_construction_worker" "prepend_prompt_embedding_a_headshot_of_a_driver" "prepend_prompt_embedding_a_headshot_of_a_elementary_school_teacher" "prepend_prompt_embedding_a_headshot_of_a_fashion_designer" "prepend_prompt_embedding_a_headshot_of_a_mechanic" "prepend_prompt_embedding_a_headshot_of_a_nanny" "prepend_prompt_embedding_a_headshot_of_a_plumber" "prepend_prompt_embedding_a_headshot_of_a_soldier")

# Loop through different refer_size_per_category values
for path in "${professions_path[@]}"
do
    outdir="./ckpts/a_headshot_of_a_person_Male/$path/sample_results"
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
    echo "Evaluation $path"
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
