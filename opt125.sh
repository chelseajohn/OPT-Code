#!/bin/bash

set -xe

echo "START TIME: $(date)"

source activate.bash

CHECKPOINT_PATH=$ROOT_OUTPUT_DIR/checkpoints/
TENSORBOARD_PATH=$ROOT_OUTPUT_DIR/tensorboard/


# MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST"| head -n 1)"
# MASTER_ADDR="${MASTER_ADDR}i"
# export MASTER_ADDR="$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')"
# export MASTER_PORT=6000
# export NCCL_SOCKET_IFNAME=lo

export CUDA_VISIBLE_DEVICES=0,1,2,3


opt-baselines -n 4 -g 4  \
    --account opengptx-elm \
    --partition booster \
    --prefix opt125m_6 \
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
    --salloc \
    --cpu-bind socket


echo "END TIME: $(date)"

#
