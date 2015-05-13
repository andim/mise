# Example submit script for a cluster running the pbs engine
# We use what is called an arrayjob, i.e. we run the same script multiple independent times

# Remarks:
# - use `qsub arrayjob.sh` for submitting the array of jobs
# - create a `logs` directory inside the working directory to get independent
#   log files for every run

#!/bin/bash 

# set nice descriptive name 
#PBS -N test 
# use current working directory 
#PBS -d .
# load current environment variables to context of the job
#PBS -V 
# combine error and normal output into a single file 
#PBS -j oe
# output in specified dir 
##PBS -e logs 
#PBS -o logs 
# declare the job to be not rerunable 
#PBS -r n 
# run as an array job (change number of tasks here)
#PBS -t 1-50

# uncomment line below to sleep different amount of time before
# executing the different tasks, which can be useful e.g. to avoid
# concurrency issues in file creation
#sleep $PBS_ARRAYID
echo $PBS_ARRAYID $HOSTNAME 
# call the script with the task id as a command line argument
# use command line argument inside the script to run for different parameters
python run.py $PBS_ARRAYID

# sometimes you don't want to run all jobs in the array
# but only a specific selection (e.g. for rerunning of failed jobs)
# see below for an example of how to transform job number into task number
#tasks=(1 3 9)
#taskid=${tasks[$PBS_ARRAYID-1]}
#echo $taskid $HOSTNAME 
#python run.py $taskid
