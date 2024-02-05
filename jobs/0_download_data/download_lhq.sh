#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=Download_LHQ
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:40:00
#SBATCH --output=slurm_output_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/FACT

# Activate your environment
source activate iti_gen

# Download the dataset using gdown
gdown --id 1_ypk4ouxQptBevUTcWSp0ZbxvqSZGiKg -O data/dataset.zip

# Unzip the downloaded file
unzip data/dataset.zip -d data

# Remove the downloaded zip file if you don't need it anymore
rm data/dataset.zip
