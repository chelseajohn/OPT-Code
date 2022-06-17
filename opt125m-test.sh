#!/bin/bash
#SBATCH --account=opengptx-elm
#SBATCH --partition=booster
#SBATCH --job-name=opt-125
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4          # crucial - only 1 task per dist per node!
#SBATCH --cpus-per-task=1           # number of cores per tasks
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --gres=gpu:4                 # number of gpus
#SBATCH --time=00:10:00              # maximum execution time (HH:MM:SS)
#SBATCH --output=slurmLog/%x-%j.out           # output file name
#SBATCH --error=slurmLog/%x-%j.err            # error file name

set -x -e

echo "START TIME: $(date)"

source activate.bash

CHECKPOINT_PATH=$ROOT_OUTPUT_DIR/checkpoints/
TENSORBOARD_PATH=$ROOT_OUTPUT_DIR/tensorboard/


MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST"| head -n 1)"
# IFS='
# '
# for addr in $MASTER_ADDR
# do

#   MASTER_ADDR+="${addr}i " 
# done

# Allow communication over InfiniBand cells.
MASTER_ADDR="${MASTER_ADDR}i"
MASTER_PORT=6000

export CUDA_VISIBLE_DEVICES=0,1,2,3

# srun --jobid="$SLURM_JOB_ID" \

opt-baselines -n 4 -g 4  \
    --account opengptx-elm \
    --partition booster \
    --prefix opt125m_3 \
    --model-size 125m \
    --juwelsbooster \
    --data "$DATA_PATH" \
    --ntasks-per-node 4 \
    --cpus-per-task 1 \
    --checkpoints-dir  "$CHECKPOINT_PATH" \
    --tensorboard-logdir "$TENSORBOARD_PATH" \
    --no-save-dir \
    --snapshot-root "$ROOT_OUTPUT_DIR" \
    --time 10  \
    --no-wandb


echo "END TIME: $(date)"

#
