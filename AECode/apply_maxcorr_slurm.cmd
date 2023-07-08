#!/usr/bin/bash
##SBATCH --array=1-10
##SBATCH --array=1-1
#SBATCH --array=1-300
#SBATCH -o logs/maxcorr__%A_%a.out
#SBATCH -N 1 # node count
#SBATCH -c 1
#SBATCH -t 119:59:00
#SBATCH --mem=8000

OFFSET=-1
#LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)
LINE_NUM=0

#ms=(2 4 8 16 32 64 128 256 512 1024)
ms=(8)
alpha=0.75
log10c0=2
#dirname="m_${ms[$LINE_NUM]}__c0_${log10c0}__alpha_${alpha}"
#dirname="m_${ms[$LINE_NUM]}__c0_${log10c0}__alpha_${alpha}__grid_full"
dirname="m_${ms[$LINE_NUM]}__c0_${log10c0}__alpha_${alpha}__crit_exact"
datadir="../AEData/Raw/$dirname"

echo "Running $datadir"
export MCR_CACHE_ROOT=/tmp/$SLURM_JOB_ID
str="run_exec_maximize_corrlen.sh /usr/local/matlab/default $datadir 1000"
echo $str
$str
exit $?
