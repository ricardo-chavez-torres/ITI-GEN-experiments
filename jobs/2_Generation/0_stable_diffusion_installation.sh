#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Training_ITI_GEN
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:40:00
#SBATCH --output=so_Training_ITI_GEN%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

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
ln -s <path/to/sd-v1-4.ckpt> sd/models/ldm/stable-diffusion-v1/model.ckpt
cd sd
pip install -e .
cd ../..
