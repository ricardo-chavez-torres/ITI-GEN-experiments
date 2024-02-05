#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=ExampleArrayJob
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=04:00:00
#SBATCH --array=1-16%8
#SBATCH --output=slurm_array_testing_%A_%a.out

module purge
module load 2022
module load Anaconda3/2022.05

# Your job starts in the directory where you call sbatch
cd $HOME/...
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
