#!/bin/bash 

# set number of nodes
#SBATCH -N 1
#SBATCH --ntasks-per-node=1 
#SBATCH --mem=2000MB 
#SBATCH --time=50
# set nice descriptive name 
#SBATCH -J mayer
# queue name
#SBATCH -p bioth
# run as an array job (change number of tasks here)
#SBATCH --array=1-24
#SBATCH --output=test.out

echo $SLURM_ARRAY_TASK_ID $HOSTNAME 
python test.py $SLURM_ARRAY_TASK_ID
