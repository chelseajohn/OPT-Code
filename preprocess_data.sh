#!/usr/bin/env bash

#SBATCH --account=opengptx-elm
#SBATCH --partition=develbooster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00


source activate.bash

INPUT_PATH=/p/scratch/opengptx-elm/john2/opengpt/data/oscar-1GB.jsonl
OUTPUT_PREFIX="$ROOT_OUTPUT_DIR"/oscar

export CUDA_VISIBLE_DEVICES=0
cd "$METASEQ_REPO" || exit

srun python ./preprocess_data.py \
    --input "$INPUT_PATH" \
    --output-prefix "$OUTPUT_PREFIX" \
    --vocab "$VOCAB_FILE" \
    --dataset-impl mmap \
    --tokenizer-type GPT2BPETokenizer \
    --merge-file "$MERGE_FILE" \
    --append-eod \
    --workers 8

echo 'Done!'
