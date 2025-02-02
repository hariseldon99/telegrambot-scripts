#!/bin/bash

#---------------------------------------------------
#SBATCH --job-name=retinal-gamess
# This sets the job name. Change if needed

#SBATCH --ntasks=1
# This sets the number of openmp threads. Change if needed

#SBATCH --cpus-per-task=4
# This sets the number of processes. Change if needed

#SBATCH --qos=normal 
# This sets the quality of service to 'normal'

#SBATCH --time=00:05:00 
# This allocates the walltime to 5 minutes. 
# The program will not run for longer.

export infile="retinal.inp"
export outfile="retinal_sockets_4.log"

# There should be no need to edit below this line
#---------------------------------------------------

export ver=00

#Semaphore removal will now be done in rungms-dev script
export GMS_PATH=/usr/local/gamess
mkdir -p $HOME/bin
cp $GMS_PATH/bin/my_ipcrm $HOME/bin/

echo '---------------------------------------------------'
echo "Beginning GAMESS RUN WITH:"
echo "NPROCS = " `expr ${SLURM_NTASKS} \* ${SLURM_CPUS_PER_TASK}`
echo '---------------------------------------------------'

#Start time
start=`date +%s.%N`

export OMP_NUM_THREADS=${SLURM_NTASKS}
rungms-dev ${infile} ${ver} ${SLURM_CPUS_PER_TASK} >& ${outfile}

#End time
end=`date +%s.%N`

RUNTIME=$( echo "$end - $start" | bc -l )
echo '---------------------------------------------------'
echo "Runtime: "$RUNTIME" sec"
echo '---------------------------------------------------'
