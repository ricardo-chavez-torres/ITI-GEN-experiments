#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=EVALUATION_Plumber_b
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:18:00
#SBATCH --output=EVALUATION_Plumber_b%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used 
outdir='ckpts/a_headshot_of_a_person_Age_Male/prepend_prompt_embedding_a_headshot_of_a_plumber/sample_results'
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

echo 'male, skin_tone'
python evaluation.py \
    --img-folder $outdir \
    --class-list 'a headshot of a man with Skin tone 1' 'a headshot of a man with Skin tone 2' 'a headshot of a man with Skin tone 3' 'a headshot of a man with Skin tone 4' 'a headshot of a man with Skin tone 5' 'a headshot of a man with Skin tone 6' 'a headshot of a woman with Skin tone 1' 'a headshot of a woman with Skin tone 2' 'a headshot of a woman with Skin tone 3' 'a headshot of a woman with Skin tone 4' 'a headshot of a woman with Skin tone 5' 'a headshot of a woman with Skin tone 6'  \
    --device 0
rm "$outdir"/*.png









## Evaluation Figure 6b
echo 'male, skin_tone'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Age_Male/prepend_prompt_embedding_a_headshot_of_a_plumber/sample_results' \
    --class-list 'a headshot of a man with Skin tone 1' 'a headshot of a man with Skin tone 2' 'a headshot of a man with Skin tone 3' 'a headshot of a man with Skin tone 4' 'a headshot of a man with Skin tone 5' 'a headshot of a man with Skin tone 6' 'a headshot of a woman with Skin tone 1' 'a headshot of a woman with Skin tone 2' 'a headshot of a woman with Skin tone 3' 'a headshot of a woman with Skin tone 4' 'a headshot of a woman with Skin tone 5' 'a headshot of a woman with Skin tone 6'  \
    --device 0
echo 'male, skin_tone'

