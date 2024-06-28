#!/bin/bash

set -e

# (note that SLURM reproduces the environment at submission irrespective of ~/.bashrc):
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
#module load rhel7/default-peta4            # REQUIRED - loads the basic environment

# custom modules
module load use.own
source activate renv

PROJECT_DIR=/home/user/scratch/workspace_directory
cd $PROJECT_DIR
mkdir -p logs/subread

sbatch \
    --mail-type=END \
    --chdir=${PROJECT_DIR} \
    --ntasks=32 \
    --mem=12030 \
    --time=4:00:00 \
    --partition=htc \
    --account=scw2124 \
    --job-name rsub \
    --output $PROJECT_DIR/logs/subread/subread_%A_%a.out \
    --error $PROJECT_DIR/logs/subread/subread_%A_%a.err \
    --export=PROJECT_DIR=$PROJECT_DIR \
    R CMD BATCH --no-restore --no-save ./scripts/subread.R ./logs/subread/subread.Rout

echo "Job submitted"
