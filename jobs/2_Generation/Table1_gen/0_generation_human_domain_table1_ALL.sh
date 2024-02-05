#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=18:20:00
#SBATCH --output=GENERATED_humandomain_table1_results_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

echo "Word embeddings for Male*Young*Eyeglass*smile"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young,Eyeglasses,Smiling' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

## Training ITI-GEN

# 1. Train for male attribute
echo "**1. Generation for Male attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Skin_tone,Age' \
    --outdir='./ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200

#   - `--config`: config file for Stable Diffusion.
#   - `--ckpt`: path to the pre-trained Stable Diffusion checkpoint.
#   - `--plms`: whether to use the plms sampling.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_lis$
#   - `--outdir`: output directory of the generated images.
#   - `--prompt_path`: path to the learnt prompt embeddings with ITI-GEN.
#   - `--n_iter`: number of iterations for the diffusion sampling.
#   - `--n_rows`: number of rows in the output image grid.
#   - `--n_samples`: number of samples per row.

# 2. Train for young attribute 
echo "**2. Generation for Young attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Young' \
    --outdir='./ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200

# 3. Train for Pale_skin attribute 
echo "**3. Generation for Pale_skin attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Pale_skin' \
    --outdir='./ckpts/a_headshot_of_a_person_Pale_skin/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Pale_skin/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200

# 4. Train for Eyeglasses attribute 
echo "**4. Generation for Eyeglasses attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Eyeglasses' \
    --outdir='./ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200


# 5. Train for Mustache attribute 
echo "**5. Generation for Mustache attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Mustache' \
    --outdir='./ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200


# 6. Train for Smiling attribute 
echo "**6. Generation for Smiling attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Smiling' \
    --outdir='./ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200

echo "********************"
echo "**Generation for combination of attributes**"
echo "********************"


# 7. Train for Male,Young attribute 
echo "**7. Generation for Male,Young attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Young' \
    --outdir='./ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200


# 8. Train for Male,Young,Eyeglasses attribute 
echo "**8. Generation for Male,Young,Eyeglasses attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Young,Eyeglasses' \
    --outdir='./ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200

# 9. Train for Eyeglasses attribute 
echo "**9. Generation for Male,Young,Eyeglasses,Smiling attribute**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Young,Eyeglasses,Smiling' \
    --outdir='./ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses_Smiling/original_prompt_embedding/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses_Smiling/original_prompt_embedding/basis_final_embed_19.pt' \
    --n_iter=5 \
    --skip_grid \
    --n_samples=200