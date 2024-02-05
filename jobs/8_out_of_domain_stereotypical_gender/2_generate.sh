#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Generation_appendix_stereotipical_professions
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=07:00:00
#SBATCH --output=Generation_appendix_stereotipical_professions%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

# professions_path=("prepend_prompt_embedding_a_headshot_of_a_ballet_dancer" "prepend_prompt_embedding_a_headshot_of_a_cheerleader" "prepend_prompt_embedding_a_headshot_of_a_construction_worker" "prepend_prompt_embedding_a_headshot_of_a_driver" "prepend_prompt_embedding_a_headshot_of_a_elementary_school_teacher" "prepend_prompt_embedding_a_headshot_of_a_fashion_designer" "prepend_prompt_embedding_a_headshot_of_a_mechanic" "prepend_prompt_embedding_a_headshot_of_a_nanny" "prepend_prompt_embedding_a_headshot_of_a_plumber" "prepend_prompt_embedding_a_headshot_of_a_soldier")
# professions_path=("prepend_prompt_embedding_a_headshot_of_a_cheerleader" "prepend_prompt_embedding_a_headshot_of_a_construction_worker" "prepend_prompt_embedding_a_headshot_of_a_driver" "prepend_prompt_embedding_a_headshot_of_a_elementary_school_teacher" "prepend_prompt_embedding_a_headshot_of_a_fashion_designer" "prepend_prompt_embedding_a_headshot_of_a_mechanic" "prepend_prompt_embedding_a_headshot_of_a_nanny" "prepend_prompt_embedding_a_headshot_of_a_plumber" "prepend_prompt_embedding_a_headshot_of_a_soldier")
professions_path=("prepend_prompt_embedding_a_headshot_of_a_nanny" "prepend_prompt_embedding_a_headshot_of_a_plumber" "prepend_prompt_embedding_a_headshot_of_a_soldier")
# Loop through different refer_size_per_category values

for path in "${professions_path[@]}"
do
    echo "**1. Generation of prompts with pretrained on the human domain on profession $path**"
    python generation.py \
        --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
        --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
        --plms \
        --attr-list='Male' \
        --outdir="./ckpts/a_headshot_of_a_person_Male/$path/sample_results" \
        --prompt-path="./ckpts/a_headshot_of_a_person_Male/$path/basis_final_embed_29.pt" \
        --n_iter=200 \
        --skip_grid \
        --n_samples=1
done

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
