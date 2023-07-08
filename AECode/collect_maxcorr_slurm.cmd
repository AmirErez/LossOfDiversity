#!/bin/bash
##SBATCH --array=1-10
##SBATCH --array=1-7
#SBATCH --array=1-1
#SBATCH -o logs/collect__%A_%a.out
#SBATCH -N 1 # node count
#SBATCH -c 1
#SBATCH -t 3:59:00
##SBATCH -t 119:59:00
#SBATCH --mem=8000

OFFSET=-1
LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)

# c0=10^-2
#rundirs=('m_2__c0_-2__alpha_0.75' 'm_4__c0_-2__alpha_0.75' 'm_8__c0_-2__alpha_0.75' 'm_16__c0_-2__alpha_0.75' 'm_32__c0_-2__alpha_0.75' 'm_64__c0_-2__alpha_0.75' 'm_128__c0_-2__alpha_0.75' 'm_256__c0_-2__alpha_0.75' 'm_512__c0_-2__alpha_0.75' 'm_1024__c0_-2__alpha_0.75')
#rundirs=('m_2__c0_-2__alpha_0.75__grid_full' 'm_4__c0_-2__alpha_0.75__grid_full' 'm_8__c0_-2__alpha_0.75__grid_full' 'm_16__c0_-2__alpha_0.75__grid_full' 'm_32__c0_-2__alpha_0.75__grid_full' 'm_64__c0_-2__alpha_0.75__grid_full' 'm_128__c0_-2__alpha_0.75__grid_full' 'm_256__c0_-2__alpha_0.75__grid_full' 'm_512__c0_-2__alpha_0.75__grid_full' 'm_1024__c0_-2__alpha_0.75__grid_full')


# c0=10^1
#rundirs=('m_2__c0_1__alpha_0.75' 'm_4__c0_1__alpha_0.75' 'm_8__c0_1__alpha_0.75' 'm_16__c0_1__alpha_0.75' 'm_32__c0_1__alpha_0.75' 'm_64__c0_1__alpha_0.75' 'm_128__c0_1__alpha_0.75' 'm_256__c0_1__alpha_0.75' 'm_512__c0_1__alpha_0.75' 'm_1024__c0_1__alpha_0.75')

# Short, upto 128
#rundirs=('m_2__c0_0__alpha_0.75__grid_full' 'm_4__c0_0__alpha_0.75__grid_full' 'm_8__c0_0__alpha_0.75__grid_full' 'm_16__c0_0__alpha_0.75__grid_full' 'm_32__c0_0__alpha_0.75__grid_full' 'm_64__c0_0__alpha_0.75__grid_full' 'm_128__c0_0__alpha_0.75__grid_full')
#rundirs=('m_2__c0_2__alpha_0.75__grid_full' 'm_4__c0_2__alpha_0.75__grid_full' 'm_8__c0_2__alpha_0.75__grid_full' 'm_16__c0_2__alpha_0.75__grid_full' 'm_32__c0_2__alpha_0.75__grid_full' 'm_64__c0_2__alpha_0.75__grid_full' 'm_128__c0_2__alpha_0.75__grid_full')
#rundirs=('m_2__c0_2__alpha_1__grid_full' 'm_4__c0_2__alpha_1__grid_full' 'm_8__c0_2__alpha_1__grid_full' 'm_16__c0_2__alpha_1__grid_full' 'm_32__c0_2__alpha_1__grid_full' 'm_64__c0_2__alpha_1__grid_full' 'm_128__c0_2__alpha_1__grid_full')
#rundirs=('m_2__c0_2.5__alpha_0.9__grid_full' 'm_3__c0_2.5__alpha_0.9__grid_full' 'm_5__c0_2.5__alpha_0.9__grid_full' 'm_9__c0_2.5__alpha_0.9__grid_full' 'm_17__c0_2.5__alpha_0.9__grid_full' 'm_33__c0_2.5__alpha_0.9__grid_full' 'm_65__c0_2.5__alpha_0.9__grid_full' 'm_129__c0_2.5__alpha_0.9__grid_full')

# c0=10^3
#rundirs=('m_2__c0_3__alpha_0.75__grid_full' 'm_4__c0_3__alpha_0.75__grid_full' 'm_8__c0_3__alpha_0.75__grid_full' 'm_16__c0_3__alpha_0.75__grid_full' 'm_32__c0_3__alpha_0.75__grid_full' 'm_64__c0_3__alpha_0.75__grid_full' 'm_128__c0_3__alpha_0.75__grid_full' 'm_256__c0_3__alpha_0.75__grid_full' 'm_512__c0_3__alpha_0.75__grid_full' 'm_1024__c0_3__alpha_0.75__grid_full')
#rundirs=('m_2__c0_3__alpha_0.75__grid_full' 'm_8__c0_3__alpha_0.75__grid_full' 'm_32__c0_3__alpha_0.75__grid_full')

# New runs, more precise?
rundirs=('m_8__c0_2__alpha_0.75__crit_exact')

rundir=${rundirs[$LINE_NUM]}
datadir="../AEData/Raw/$rundir";
outfile="$datadir/collected_${rundir}.csv"
if ! matlab -batch "collect $datadir $outfile"; then
   echo "Failed matlab"
   exit 1
fi

echo "----------------------------------------------------"
echo "Finished matlab. Success."
exit 0
