#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:18:00
#SBATCH --output=EVALUATION_table1%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Evaluation Table 1

# outdir='ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'male'
# python evaluation.py \
#     --img-folder $outdir \
#     --class-list 'a headshot of a man' 'a headshot of a woman' \
#     --device 0
# rm "$outdir"/*.png


# outdir='ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'young'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a young person' 'a headshot of an old person' \
#     --device 0
# rm "$outdir"/*.png


# outdir='ckpts/a_headshot_of_a_person_Pale_Skin/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done
# rm "$outdir"/*.png


# echo 'pale skin'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Pale_Skin/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person with pale skin' 'a headshot of a person with dark skin' \
#     --device 0
# rm "$outdir"/*.png

# outdir='ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'eyeglasses'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person with eye glasses' 'a headshot of a person with normal vision' \
#     --device 0

# echo 'eyeglasses **normal class list**'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person with eye glasses' 'a headshot of a person' \
#     --device 0
# rm "$outdir"/*.png



# outdir='ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'mustache **normal class list**'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person with mustache' 'a headshot of a person with clean-shaven' \
#     --device 0

# echo 'mustache'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person with mustache' 'a headshot of a person' \
#     --device 0

# rm "$outdir"/*.png


# outdir='ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'smiling'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a person smiling' 'a headshot of a person with no/without smiling'  \
#     --device 0
# rm "$outdir"/*.png

# outdir='ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'male, young'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a young man' 'a headshot of a young woman' 'a headshot of an old man' 'a headshot of an old woman' \
#     --device 0
# rm "$outdir"/*.png

# outdir='ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/sample_results'
# directories=("$outdir"/*)
# for directory in "${directories[@]}"; do
#     if [ -d "$directory" ]; then
#         images="$directory"/*.png
#         for archivo in $images; do
#             dir_name=$(dirname "$archivo")
#             file_name=$(basename "$archivo")
#             # Remove leading slash from directory name
#             dir_name="${dir_name#/}"
#             # Replace slashes in directory name with underscores
#             dir_name="${dir_name//\//_}"
#             cp "$archivo" "$outdir"/"${dir_name}_${file_name}"
#         done
#     fi
# done

# echo 'male, young, eyeglasses'
# python evaluation.py \
#     --img-folder 'ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/sample_results' \
#     --class-list 'a headshot of a young man with normal vision' 'a headshot of an old man with normal vision' 'a headshot of a young woman with normal vision' 'a headshot of an old woman with normal vision' 'a headshot of a young man with eyeglasses' 'a headshot of an old man with eyeglasses' 'a headshot of a young woman with eyeglasses' 'a headshot of an old woman with eyeglasses' \
#     --device 0
# rm "$outdir"/*.png


outdir='ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses_Smiling/original_prompt_embedding/sample_results'
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

echo 'Male, young, eyeglasses, smiling'
python evaluation.py \
   --img-folder 'ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses_Smiling/original_prompt_embedding/sample_results' \
   --class-list 'a headshot of a young man serious with contact lens' 'a headshot of a young man smiling with contact lens' 'a headshot of a young man serious with eyeglasses' 'a headshot of a young man smiling with eyeglasses' 'a headshot of an old man serious with contact lens' 'a headshot of an old man smiling with contact lens' 'a headshot of an old man serious with eyeglasses' 'a headshot of an old man smiling with eyeglasses' 'a headshot of a young woman serious with contact lens' 'a headshot of a young woman smiling with contact lens' 'a headshot of a young woman serious with eyeglasses' 'a headshot of a young woman smiling with eyeglasses' 'a headshot of an old woman serious with contact lens' 'a headshot of an old woman smiling with contact lens' 'a headshot of an old woman serious with eyeglasses' 'a headshot of an old woman smiling with eyeglasses' \
   --device 0 
#    - `--img_folder`: the image folder that you want to evaluate.
#    - `--class_list`: the class prompts used for evaluation, separated by a space. The length of the list depends on the number of category combinations for different attributes. In terms of writing evaluation prompts for CelebA attributes, please refer (but not limited) to Table A3 in the supplementary materials.
rm "$outdir"/*.png