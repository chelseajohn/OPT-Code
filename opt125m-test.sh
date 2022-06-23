#!/bin/bash
#SBATCH --account=opengptx-elm
#SBATCH --partition=develbooster
#SBATCH --job-name=opt125m
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4          
#SBATCH --cpus-per-task=1           # number of cores per tasks
#SBATCH --gres=gpu:4                 # number of gpus
#SBATCH --time=00:10:00              # maximum execution time (HH:MM:SS)
#SBATCH --output=slurmLog/%x-%j.out           # output file name
#SBATCH --error=slurmLog/%x-%j.err            # error file name

set -xe

echo "START TIME: $(date)"

source activate.bash

CHECKPOINT_PATH=$ROOT_OUTPUT_DIR/checkpoints/
TENSORBOARD_PATH=$ROOT_OUTPUT_DIR/tensorboard/


# MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST"| head -n 1)"
# # Allow communication over InfiniBand cells.
# MASTER_ADDR="${MASTER_ADDR}i"
# export MASTER_ADDR="$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')"
# export MASTER_PORT=6000
# export NCCL_SOCKET_IFNAME=lo

export CUDA_VISIBLE_DEVICES=0,1,2,3


opt-baselines -n 2 -g 4  \
    --account opengptx-elm \
    --partition develbooster \
    --prefix opt125m_9 \
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
    --no-wandb \
    --cpu-bind none \
    --salloc


echo "END TIME: $(date)"

#
