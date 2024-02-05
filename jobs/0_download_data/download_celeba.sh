#!/bin/bash

#SBATCH --partition=gpu_mig
#SBATCH --gpus=1
#SBATCH --job-name=Download_celeba
#SBATCH --ntasks=18
#SBATCH --cpus-per-task=2
#SBATCH --time=00:05:00
#SBATCH --output=slurm_output_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

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