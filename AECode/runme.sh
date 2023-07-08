#!/usr/bin/bash

# !!! Make split needs to be refactored

# This code uses the split-apply-combine template. 
# The main matlab script is compiled to avoid license problems when running >10 jobs at once
# Amir Erez 2022-04-26
# amir.erez1@mail.huji.ac.il

# Compile
# To run, first export MCR_CACHE_ROOT=/tmp/$SLURM_JOB_ID ; Then matlab -batch “/path/to/matlab/script <args>"
module load matlab/2021a mcc
mcc -mv exec_SLURM_line.m

# Make splits. Primes directories with params.mat and to_run.csv
# !!! Need to refactor make_split to receive rundir input
if ! matlab -batch "make_split"; then
   echo "Failed MATLAB make_splits"
   exit 1
fi

# Only smaller systems, upto m=128
#rundirs=('m_2__c0_2__alpha_0.75' 'm_4__c0_2__alpha_0.75' 'm_8__c0_2__alpha_0.75' 'm_16__c0_2__alpha_0.75' 'm_32__c0_2__alpha_0.75' 'm_64__c0_2__alpha_0.75' 'm_128__c0_2__alpha_0.75')
#rundirs=('m_2__c0_0__alpha_0.75' 'm_4__c0_0__alpha_0.75' 'm_8__c0_0__alpha_0.75' 'm_16__c0_0__alpha_0.75' 'm_32__c0_0__alpha_0.75' 'm_64__c0_0__alpha_0.75' 'm_128__c0_0__alpha_0.75')
#rundirs=('m_2__c0_-1__alpha_0.75' 'm_4__c0_-1__alpha_0.75' 'm_8__c0_-1__alpha_0.75' 'm_16__c0_-1__alpha_0.75' 'm_32__c0_-1__alpha_0.75' 'm_64__c0_-1__alpha_0.75' 'm_128__c0_-1__alpha_0.75')

rundirs=('m_2__c0_2__alpha_1' 'm_4__c0_2__alpha_1' 'm_8__c0_2__alpha_1' 'm_16__c0_2__alpha_1' 'm_32__c0_2__alpha_1' 'm_64__c0_2__alpha_1' 'm_128__c0_2__alpha_1')

#rundirs=('m_2__c0_2.5__alpha_0.9' 'm_3__c0_2.5__alpha_0.9' 'm_5__c0_2.5__alpha_0.9' 'm_9__c0_2.5__alpha_0.9' 'm_17__c0_2.5__alpha_0.9' 'm_33__c0_2.5__alpha_0.9' 'm_65__c0_2.5__alpha_0.9' 'm_129__c0_2.5__alpha_0.9')


# With larger systems m=256,512,1024
#rundirs=('m_2__c0_1__alpha_0.75' 'm_4__c0_1__alpha_0.75' 'm_8__c0_1__alpha_0.75' 'm_16__c0_1__alpha_0.75' 'm_32__c0_1__alpha_0.75' 'm_64__c0_1__alpha_0.75' 'm_128__c0_1__alpha_0.75' 'm_256__c0_1__alpha_0.75' 'm_512__c0_1__alpha_0.75' 'm_1024__c0_1__alpha_0.75')
#rundirs=('m_2__c0_3__alpha_0.75' 'm_4__c0_3__alpha_0.75' 'm_8__c0_3__alpha_0.75' 'm_16__c0_3__alpha_0.75' 'm_32__c0_3__alpha_0.75' 'm_64__c0_3__alpha_0.75' 'm_128__c0_3__alpha_0.75' 'm_256__c0_3__alpha_0.75' 'm_512__c0_3__alpha_0.75' 'm_1024__c0_3__alpha_0.75')

# On hold until update - Apply - execute the correlation length biased random walk
#sbatch apply_maxcorr_slurm.cmd

# Apply - execute parallel jobs for grid calculation
for rundir in ${rundirs[@]}; do
   actualdir="${rundir}__grid_full"
#   actualdir="${rundir}__grid_true__part_2"
   echo "Running ${actualdir}"
   sbatch apply_serialdil_slurm.cmd $actualdir
done

# Copy runs from grid search to the corrlen optimizer directory for one collection
for rundir in ${rundirs[@]}; do
  echo "-------------------------------------------------------------"
  echo "echo Starting $rundir"
  ./merge_dirs.sh ../AEData/Raw/${rundir}__grid_true ../AEData/Raw/${rundir}
  echo "echo Done $rundir"
done

# Combine - to make collected tables with summary stats
sbatch collect_maxcorr_slurm.cmd
