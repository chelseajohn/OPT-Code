#!/usr/bin/env bash

# Script to allocate the main directories and data paths

# Root directory
ROOT_DIR=/p/project/opengptx-elm/"$USER"/opengpt/OPT

# Python virtual env directory 
VENV_DIR="$ROOT_DIR"/env
# OPT code base directory
METASEQ_REPO="$ROOT_DIR"/metaseq
# Apex repository
APEX_REPO="$ROOT_DIR"/apex
# Megatron-LM repository branch fairseq_v2
MEGATRON_LM_REPO="$ROOT_DIR"/Megatron-LM
# Fairscale repository
FAIRSCALE_REPO="$ROOT_DIR"/fairscale


# Output data directory
ROOT_OUTPUT_DIR=/p/scratch/opengptx-elm/"$USER"/opengpt/OPT

# Input data
VOCAB_FILE=/p/scratch/opengptx-elm/john2/opengpt/data/tokenizers/gpt2-vocab.json
MERGE_FILE=/p/scratch/opengptx-elm/john2/opengpt/data/tokenizers/gpt2-merges.txt
# Path to a singular, preprocessed dataset.
DATA_PATH=/p/scratch/opengptx-elm/john2/opengpt/data/oscar/

# Checking whether variables are set.
[ "x$ROOT_DIR" = x ] && echo 'Please set `ROOT_DIR` in `variables.bash.' && exit
[ "x$VENV_DIR" = x ] && echo 'Please set `VENV_DIR` in `variables.bash.' && exit
[ "x$METASEQ_REPO" = x ] && echo 'Please set `METASEQ_REPO` in `variables.bash.' && exit
[ "x$APEX_REPO" = x ] && echo 'Please set `APEX_REPO` in `variables.bash.' && exit
[ "x$MEGATRON_LM_REPO" = x ] && echo 'Please set `MEGATRON_LM_REPO` in `variables.bash.' && exit
[ "x$FAIRSCALE_REPO" = x ] && echo 'Please set `FAIRSCALE_REPO` in `variables.bash.' && exit
[ "x$ROOT_OUTPUT_DIR" = x ] && echo 'Please set `ROOT_OUTPUT_DIR` in `variables.bash.' && exit
[ "x$VOCAB_FILE" = x ] && echo 'Please set `VOCAB_FILE` in `variables.bash.' && exit
[ "x$MERGE_FILE" = x ] && echo 'Please set `MERGE_FILE` in `variables.bash.' && exit
[ "x$DATA_PATH" = x ] && echo 'Please set `DATA_PATH` in `variables.bash.' && exit

:
