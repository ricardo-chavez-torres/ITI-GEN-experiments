# Reproducibility Study of "ITI-GEN: Inclusive Text-to-Image Generation"

This repository is the official implementation of [Reproducibility Study of "ITI-GEN: Inclusive Text-to-Image Generation"](https://arxiv.org/abs/2030.12345). 

## Overview

This repository contains the code to reproduce the experiments in our study. Additionally, it contains the original code of [ITI-GEN implementation](https://arxiv.org/pdf/2309.05569.pdf). ITI-GEN allows the generation of inclusive images without explicitly asking to.

One of the advantages of ITI-GEN is the ability to be used with different generative models. It is worth noting that those models need to use CLIP to guide the image generation conditioned on text.

We recommend running the code in the order described in this document to avoid unexpected errors.

To install requirements:

```setup
pip install -r requirements.txt
```

>📋  Describe how to set up the environment, e.g. pip/conda/docker commands, download datasets, etc...

## outline

 - [Installation](#installation)
 - [Data Preparation](#data-preparation)
 - [Reproducibility](#reproducibility)
 - [Acknowledgements](#acknowledgements)
 - [Citation](#citation)
 - [License](#license)

## Installation

The reproducibility study was conducted using the environment of the original study:

```angular2html
git clone https://github.com/humansensinglab/ITI-GEN.git
cd ITI-GEN
conda env create --name iti-gen --file=environment.yml
source activate iti-gen
```

Install the Stable Diffusion model to generate the Images. In our work, we used Stable-Diffusion-v-1-4.

```shell

# Activate your environment
source activate iti_gen

### Stable Diffusion installation
cd models
git clone https://github.com/CompVis/stable-diffusion.git
# ITI-GEN has been tested with this version: https://huggingface.co/CompVis/stable-diffusion-v-1-4-original
# Due to licence issues, we cannot share the pre-trained checkpoints directly.
# Download it yourself and put the Stable Diffusion checkpoints at <path/to/sd-v1-4.ckpt>.
mv stable-diffusion sd
mkdir -p sd/models/ldm/stable-diffusion-v1/
# ln -s <path/to/sd-v1-4.ckpt> sd/models/ldm/stable-diffusion-v1/model.ckpt
wget "https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4.ckpt?download=true" -O sd/models/ldm/stable-diffusion-v1/models.ckpt

cd sd
pip install -e .
cd ../..
```
# Data Preparation

To generate the embeddings, we used the reference images of the original paper:

|   Dataset    |      Description      |       Attribute Used        |                                        Google Drive                                        |
|:------------:|:---------------------:|:---------------------------:|:------------------------------------------------------------------------------------------:|
|  [CelebA](https://mmlab.ie.cuhk.edu.hk/projects/CelebA.html)  |   Real face images    | 40 binary facial attributes | [Link](https://drive.google.com/file/d/1_wxcrzirofEge4i8LTyYBAL0SMQ_LwGO/view?usp=sharing) | 
| [FairFace](https://github.com/joojs/fairface) |   Real face images    |    Age with 9 categories    | [Link](https://drive.google.com/file/d/1_xtui0b0O52u38jbJzrxW8yRRiBHnZaA/view?usp=sharing) |
|   [FAIR](https://trust.is.tue.mpg.de/)   | Synthetic face images |   Skin tone with 6 categories    | [Link](https://drive.google.com/file/d/1_wiqq7FDByLp8Z4WQOeboSEXYsCzmV76/view?usp=sharing) |

To download the data, you can use the following code:

```shell

# Activate your environment
source activate ...

# Good practice: define your directory where to save the models, and copy the job file to it
JOB_FILE=$HOME/.../array_job.job
HPARAMS_FILE=$HOME/.../array_job_hyperparameters.txt
CHECKPOINTDIR=$HOME/.../checkpoints/array_job_${SLURM_ARRAY_JOB_ID}

mkdir $CHECKPOINTDIR
rsync $HPARAMS_FILE $CHECKPOINTDIR/
rsync $JOB_FILE $CHECKPOINTDIR/

# Run your code
srun python -u train.py \
               --checkpoint_path $CHECKPOINTDIR/experiment_${SLURM_ARRAY_TASK_ID} \
               $(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
```

Next, run the following code:

```shell

# Activate your environment
source activate iti_gen

# Download the dataset using gdown
gdown --id 1_ypk4ouxQptBevUTcWSp0ZbxvqSZGiKg -O data/dataset.zip

# Unzip the downloaded file
unzip data/dataset.zip -d data

# Remove the downloaded zip file if you don't need it anymore
rm data/dataset.zip

```
To download the celebA dataset use the following code:

```shell

# Activate your environment
source activate iti_gen

# # Download the dataset using gdown
# gdown --id 1_wxcrzirofEge4i8LTyYBAL0SMQ_LwGO -O data/dataset_celeba.zip

# # Unzip the downloaded file
# unzip data/dataset_celeba.zip -d data

# # Remove the downloaded zip file if you don't need it anymore
# rm data/dataset_celeba.zip


# Create the data folder if it doesn't exist
mkdir -p data

# Get the file ID from the Google Drive link
FILE_ID="1_wxcrzirofEge4i8LTyYBAL0SMQ_LwGO"

# Use curl to download the file
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" -o data/dataset.zip

# Remove the temporary cookie file
rm ./cookie

# Unzip the downloaded file
unzip data/dataset.zip -d data

# Remove the downloaded zip file if you don't need it anymore
rm data/dataset.zip
```

In the [original repository](https://github.com/humansensinglab/ITI-GEN/edit/main/README.md), they tried to generate inclusive images of nature scenes. In our study, we focused on the human face generation. You can find the dataset for training inclusive images of nature scenes at the following link.

|   Dataset    |      Description      |       Attribute Used        |                                        Google Drive                                        |
|:------------:|:---------------------:|:---------------------------:|:------------------------------------------------------------------------------------------:|
|   [LHQ](https://universome.github.io/alis)    |    Natural scenes     | 11 global scene attributes  | [Link](https://drive.google.com/file/d/1_ypk4ouxQptBevUTcWSp0ZbxvqSZGiKg/view?usp=sharing) |

In case you want to download the LHQ dataset, you can also employ the following code:

```shell

# Activate your environment
source activate iti_gen

# Download the dataset using gdown
gdown --id 1_ypk4ouxQptBevUTcWSp0ZbxvqSZGiKg -O data/dataset.zip

# Unzip the downloaded file
unzip data/dataset.zip -d data

# Remove the downloaded zip file if you don't need it anymore
rm data/dataset.zip
```


Save the `.zip` files and unzip the downloaded reference images under ```data/``` directory:
```angular2html
|-- data
|   |-- celeba
|   |   |-- 5_o_Clock_Shadow
|   |   |-- Bald
|   |   |-- ...

|   |-- FAIR_benchmark
|   |   |-- Skin_tone

|   |-- fairface
|   |   |-- Age

```

## Reproducibility
We provide the code to reproduce our main experiments:

## Code to replicate the results of Table 2.


**1. Training ITI-GEN on the human domain to generate the embedding to replicate the results of Table 2**
Jobs adapted from the [original repository](https://github.com/humansensinglab/ITI-GEN#training-iti-gen):

```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "Word embeddings for Male"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

echo "Word embeddings for Young"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Young' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for pale skin"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Pale_Skin' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for eye glass"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Eyeglasses' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for mustache"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Mustache' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for smile"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Smiling' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young*Eyeglass"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young,Eyeglasses' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0

echo "Word embeddings for Male*Young*Eyeglass*smile"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Young,Eyeglasses,Smiling' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
```
  - `--prompt`: prompt that you want to debias.
  - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of categories, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
  - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

**2. Image generation to replicate the results of Figure 1**

```shell

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
```

**3. Evaluation**

```shell

# Activate your environment
source activate iti_gen

## Evaluation Table 1

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

outdir='ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/sample_results'
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

echo 'young'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Young/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a young person' 'a headshot of an old person' \
    --device 0
rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Pale_Skin/original_prompt_embedding/sample_results'
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
rm "$outdir"/*.png

echo 'pale skin'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Pale_Skin/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person with pale skin' 'a headshot of a person with dark skin' \
    --device 0
rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results'
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

echo 'eyeglasses'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person with eye glasses' 'a headshot of a person with normal vision' \
    --device 0

echo 'eyeglasses **normal class list**'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Eyeglasses/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person with eye glasses' 'a headshot of a person' \
    --device 0
rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results'
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

echo 'mustache **normal class list**'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person with mustache' 'a headshot of a person with clean-shaven' \
    --device 0

echo 'mustache'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Mustache/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person with mustache' 'a headshot of a person' \
    --device 0

rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/sample_results'
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

echo 'smiling'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Smiling/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a person smiling' 'a headshot of a person with no/without smiling'  \
    --device 0
rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/sample_results'
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

echo 'male, young'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Male_Young/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a young man' 'a headshot of a young woman' 'a headshot of an old man' 'a headshot of an old woman' \
    --device 0
rm "$outdir"/*.png

outdir='ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/sample_results'
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

echo 'male, young, eyeglasses'
python evaluation.py \
    --img-folder 'ckpts/a_headshot_of_a_person_Male_Young_Eyeglasses/original_prompt_embedding/sample_results' \
    --class-list 'a headshot of a young man with normal vision' 'a headshot of an old man with normal vision' 'a headshot of a young woman with normal vision' 'a headshot of an old woman with normal vision' 'a headshot of a young man with eyeglasses' 'a headshot of an old man with eyeglasses' 'a headshot of a young woman with eyeglasses' 'a headshot of an old woman with eyeglasses' \
    --device 0
rm "$outdir"/*.png

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
```

## Code to replicate the results of Figure 1.

**1. Training ITI-GEN on the human domain to generate the embedding to replicate the results of Figure 1**

```shell
module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

## Training ITI-GEN

echo "Word embeddings for FairFace"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.

echo "Word embeddings CelebA and FAIR"

python train_iti_gen.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone' \
    --epochs=30 \
    --save-ckpt-per-epochs=10 \
    --device=0
```

**2. Image generation to replicate the results of Figure 1**

Code to generate the Figure 1(a). Perceived Gender × Age

```shell

# Activate your environment
source activate iti_gen
echo "**1. Generation Figure 6a**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Age' \
    --outdir='./ckpts/figure6a_results/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Age_Male/original_prompt_embedding/basis_final_embed_29.pt' \
    --n_iter=200 \
    --n_samples=1
```
Code to generate the Figure 1(b). Perceived Gender × Skin Tone

```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**

echo "**2. Generation Figure 6b**"
python generation.py \
    --config='models/sd/configs/stable-diffusion/v1-inference.yaml' \
    --ckpt='models/sd/models/ldm/stable-diffusion-v1/model.ckpt' \
    --plms \
    --attr-list='Male,Skin_tone' \
    --outdir='./ckpts/figure6b_results/sample_results' \
    --prompt-path='./ckpts/a_headshot_of_a_person_Male_Skin_tone/original_prompt_embedding/basis_final_embed_29.pt' \
    --n_iter=200 \
    --n_samples=1
```

**3. Evaluation**

Code to evaluate the generated images of Perceived Gender x Age & Perceived Gender x Skin Tone. The next code provides the proportion of generated images corresponding to each of the prompts. The proportions obtained in the evaluation are the ones used to generate Figure 1.

--Perceived Gender x Age--
```shell

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used 
outdir='ckpts/figure6a_results/sample_results'
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

echo 'age, male'
python evaluation.py \
    --img-folder $outdir \
    --class-list 'a headshot of a man with age between 0 and 2 years old' 'a headshot of a man with age between 3 and 9 years old' 'a headshot of a man with age between 10 and 19 years old' 'a headshot of a man with age between 20 and 29 years old' 'a headshot of a man with age between 30 and 39 years old'  'a headshot of a man with age between 40 and 49 years old'  'a headshot of a man with age between 50 and 59 years old'   'a headshot of a man with age between 60 and 69 years old'  'a headshot of a man with more than 70 years old' 'a headshot of a woman with age between 0 and 2 years old' 'a headshot of a woman with age between 3 and 9 years old' 'a headshot of a woman with age between 10 and 19 years old' 'a headshot of a woman with age between 20 and 29 years old' 'a headshot of a woman with age between 30 and 39 years old'  'a headshot of a woman with age between 40 and 49 years old'  'a headshot of a woman with age between 50 and 59 years old'   'a headshot of a woman with age between 60 and 69 years old'  'a headshot of a woman with more than 70 years old' \
    --device 0
rm "$outdir"/*.png
```

--Perceived Gender x Skin Tone--
```shell

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used 
outdir='ckpts/figure6b_results/sample_results'
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
```

## Code to replicate the results of Figure 2.

**1. Training ITI-GEN on the human domain to generate the embedding to replicate the results of Figure 2: Ablation on the quantity of reference images**

```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**

# Define the refer_sizes per category used for training array
refer_sizes=(5 10 15 20 25 50 100)

# Loop through different refer_size_per_category values
for refer_size in "${refer_sizes[@]}"
do
    echo "Training ITI-GEN with refer_size_per_category=$refer_size"

    python train_iti_gen.py \
        --prompt='a headshot of a person' \
        --attr-list='Male' \
        --epochs=30 \
        --save-ckpt-per-epochs=30 \
        --device=0 \
        --ckpt-path="./ckpts_figure_9/refer_size_${refer_size}" \
        --refer-size-per-category=$refer_size
done



#   - `--prompt`: prompt that you want to debias.
#   - `--attr_list`: attributes should be selected from `Dataset_name_attribute_list` in `util.py`, separated by commas. Empirically, attributes that are easier to train (less # of category, easier to tell the visual difference between categories) should be put in the front, eg. Male < Young < ... < Skin_Tone < Age.
#   - Checkpoints are saved every `save_ckpt_per_epochs`. However, it is NOT always the longer, the better. Better to check every ckpt.
```
**2. Generation of the images for Figure 2**

```shell

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
```
**3. Evaluation**

```shell

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
```

## Prompt Prepending to generate Figure 3: Perceived gender and age distribution for gender-stereotypical professions

**1. Prepend to generate images of nurses and plumbers**
```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN
#This embeddings will get saved in /ckpts/a_headhshot_of_a_person_Male/preprend_prompt_embedding_a_headshot_of_a_nurse
# 1. Train on human domain (only several minutes)**
echo "**1. Generation of prompts with pretrained on the human domain --nurse--**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --load-model-epoch=29 \
    --prepended-prompt='a headshot of a nurse' \
    --device 0

echo "**1. Generation of prompts with pretrained on the human domain --plumber--**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --load-model-epoch=29 \
    --prepended-prompt='a headshot of a plumber' \
    --device 0
```
  - `--prompt` and `--attr_list` should be aligned with those used in training ITI-GEN.
  - `--load_model_epoch` indicates the model's epoch you want to load.
  - `--prepended_prompt`: prepend the learned tokens after this prompt to implement Train-Once-For-All Generation. In the human domain, `prompt` and `prepended_prompt` should not differ a lot, better to change the occupation solely.

**2. Evaluation of Nurse images**
```shell

# Activate your environment
source activate iti_gen

# Define the refer_sizes per category used 
outdir='ckpts/a_headshot_of_a_person_Age_Male/prepend_prompt_embedding_a_headshot_of_a_nurse/sample_results'
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

echo 'age, male'
python evaluation.py \
    --img-folder $outdir \
    --class-list 'a headshot of a man with age between 0 and 2 years old' 'a headshot of a man with age between 3 and 9 years old' 'a headshot of a man with age between 10 and 19 years old' 'a headshot of a man with age between 20 and 29 years old' 'a headshot of a man with age between 30 and 39 years old'  'a headshot of a man with age between 40 and 49 years old'  'a headshot of a man with age between 50 and 59 years old'   'a headshot of a man with age between 60 and 69 years old'  'a headshot of a man with more than 70 years old' 'a headshot of a woman with age between 0 and 2 years old' 'a headshot of a woman with age between 3 and 9 years old' 'a headshot of a woman with age between 10 and 19 years old' 'a headshot of a woman with age between 20 and 29 years old' 'a headshot of a woman with age between 30 and 39 years old'  'a headshot of a woman with age between 40 and 49 years old'  'a headshot of a woman with age between 50 and 59 years old'   'a headshot of a woman with age between 60 and 69 years old'  'a headshot of a woman with more than 70 years old' \
    --device 0
rm "$outdir"/*.png
````

**3. Evaluation of Plumber images**
```shell

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

echo 'age, male'
python evaluation.py \
    --img-folder $outdir \
    --class-list 'a headshot of a man with age between 0 and 2 years old' 'a headshot of a man with age between 3 and 9 years old' 'a headshot of a man with age between 10 and 19 years old' 'a headshot of a man with age between 20 and 29 years old' 'a headshot of a man with age between 30 and 39 years old'  'a headshot of a man with age between 40 and 49 years old'  'a headshot of a man with age between 50 and 59 years old'   'a headshot of a man with age between 60 and 69 years old'  'a headshot of a man with more than 70 years old' 'a headshot of a woman with age between 0 and 2 years old' 'a headshot of a woman with age between 3 and 9 years old' 'a headshot of a woman with age between 10 and 19 years old' 'a headshot of a woman with age between 20 and 29 years old' 'a headshot of a woman with age between 30 and 39 years old'  'a headshot of a woman with age between 40 and 49 years old'  'a headshot of a woman with age between 50 and 59 years old'   'a headshot of a woman with age between 60 and 69 years old'  'a headshot of a woman with more than 70 years old' \
    --device 0
rm "$outdir"/*.png
```
## Prompt Prepending to generate Figure 5: Multi-category distribution trained with “a headshot of a person” and modified with the prompt: "A whole body shot of a person".

**1. Prepend to generate images of the whole body of a person with attributes Age and Male**

```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN
#This embeddings will get saved in /ckpts/a_headhshot_of_a_person_Male/preprend_prompt_embedding_a_bodyshot_of_a_person
# 1. Train on human domain (only several minutes)**
echo "**1. Generation of prompts with pretrained on the human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Age,Male' \
    --load-model-epoch=29 \
    --prepended-prompt='whole body shot of a person' \
    --device 0
```

**2. Prepend to generate images of the whole body of a person with attributes of Skin tone and Male**

```shell

# Activate your environment
source activate iti_gen

## Training ITI-GEN

# 1. Train on human domain (only several minutes)**
echo "**1. Generation of prompts with pretrained on the human domain**"
python prepend.py \
    --prompt='a headshot of a person' \
    --attr-list='Male,Skin_tone' \
    --load-model-epoch=29 \
    --prepended-prompt='whole body shot of a person' \
    --device 0
```

**3. Evaluation**
```shell
source activate iti_gen

# Define the refer_sizes per category used 
outdir='fact/prepend_prompt_embedding_whole_body_shot_of_a_person/sample_results'
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

echo 'age, male'
python3 evaluation.py \
    --img-folder $outdir \
    --class-list 'a whole body shot of a man with age between 0 and 2 years old' 'a whole body shot of a man with age between 3 and 9 years old' 'a whole body shot of a man with age between 10 and 19 years old' 'a whole body shot of a man with age between 20 and 29 years old' 'a whole body shot of a man with age between 30 and 39 years old'  'a whole body shot of a man with age between 40 and 49 years old'  'a whole body shot of a man with age between 50 and 59 years old'   'a whole body shot of a man with age between 60 and 69 years old'  'a whole body shot of a man with more than 70 years old' 'a whole body shot of a woman with age between 0 and 2 years old' 'a whole body shot of a woman with age between 3 and 9 years old' 'a whole body shot of a woman with age between 10 and 19 years old' 'a whole body shot of a woman with age between 20 and 29 years old' 'a whole body shot of a woman with age between 30 and 39 years old'  'a whole body shot of a woman with age between 40 and 49 years old'  'a whole body shot of a woman with age between 50 and 59 years old'   'a whole body shot of a woman with age between 60 and 69 years old'  'a whole body shot of a woman with more than 70 years old' \
    --device 0
rm "$outdir"/*.png
```
