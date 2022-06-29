#!/bin/bash
#SBATCH --account=opengptx-elm
#SBATCH --partition=booster
#SBATCH --job-name=opt30b
#SBATCH --nodes=128
#SBATCH --hint=nomultithread         
#SBATCH --ntasks-per-node=4          
#SBATCH --cpus-per-task=12           # number of cores per tasks
#SBATCH --gres=gpu:4                 # number of gpus
#SBATCH --time=00:10:00              # maximum execution time (HH:MM:SS)
#SBATCH --output=slurmLog/%x-%j.out  # output file name
#SBATCH --error=slurmLog/%x-%j.err   # error file name

set -xe

echo "START TIME: $(date)"

source activate.bash

CHECKPOINT_PATH=$ROOT_OUTPUT_DIR/checkpoints/
TENSORBOARD_PATH=$ROOT_OUTPUT_DIR/tensorboard/
export CUDA_VISIBLE_DEVICES=0,1,2,3


opt-baselines -n "$SLURM_NNODES" -g 4  \
    --account opengptx-elm \
    --partition booster \
    --prefix "$SLURM_JOB_NAME" \
    --model-size 30b \
    --juwelsbooster \
    --data "$DATA_PATH" \
    --ntasks-per-node 4 \
    --cpus-per-task "$SLURM_CPUS_PER_TASK" \
    --checkpoints-dir  "$CHECKPOINT_PATH" \
    --tensorboard-logdir "$TENSORBOARD_PATH" \
    --no-save-dir \
    --snapshot-root "$ROOT_OUTPUT_DIR" \
    --time 10  \
    --no-wandb \
    --cpu-bind socket \
    --salloc


echo "END TIME: $(date)"

#
