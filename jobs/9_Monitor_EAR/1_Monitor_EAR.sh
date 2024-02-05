#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Monitor_pipeline
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=02:00:00
#SBATCH --output=Monitor_pipeline%A.out

#SBATCH --ear=on
#SBATCH --ear-policy=monitoring
#SBATCH --ear-verbose=1
#SBATCH --ear-user-db=monitoring_output
module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "Monitor binary training"
srun python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male' \
    --epochs=30 \
    --save-ckpt-per-epochs=30 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

echo "**Monitor Binary Generation**"
srun python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male' \
    --outdir='./ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/basis_final_embed_29.pt' \
    --n_iter=200 \
    --n_rows=5 \
    --n_samples=1

outdir='ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results'
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

echo 'male'
python evaluation.py \
    --img-folder $outdir \
    --class-list 'a headshot of a man' 'a headshot of a woman' \
    --device 0
rm "$outdir"/*.png
