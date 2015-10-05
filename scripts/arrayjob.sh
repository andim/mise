# Example submit script for a cluster running a script engine
# We use what is called an arrayjob, i.e. we run the same script multiple independent times

# Remarks:
# - use `qsub arrayjob.sh` for submitting the array of jobs
# - create a `logs` directory inside the working directory to get independent
#   log files for every run

#!/bin/bash 

# set nice descriptive name 
#$ -N test 
# use current working directory 
#$ -cwd 
# load current environment variables to context of the job
#$ -V 
# combine error and normal output into a single file 
#$ -j y 
# output in specified dir 
#$ -e logs 
#$ -o logs 
# declare the job to be not rerunable 
#$ -r n 
# run as an array job (change number of tasks here)
#$ -t 1-50
# specify queue to which to submit
#$ -q queuename
# limit number of concurrent jobs
#$ -tc 50
# job priority in [-1023, 1024] (default = 0)
#$ -p -1


# uncomment line below to sleep different amount of time before
# executing the different tasks, which can be useful e.g. to avoid
# concurrency issues in file creation
#sleep $SGE_TASK_ID
echo $SGE_TASK_ID $HOSTNAME 
# call the script with the task id as a command line argument
# use command line argument inside the script to run for different parameters
python run.py $SGE_TASK_ID

# sometimes you don't want to run all jobs in the array
# but only a specific selection (e.g. for rerunning of failed jobs)
# see below for an example of how to transform job number into task number
#tasks=(1 3 9)
#taskid=${tasks[$SGE_TASK_ID-1]}
#echo $taskid $HOSTNAME 
#python run.py $taskid
