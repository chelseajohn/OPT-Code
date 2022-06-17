srun --jobid="$SLURM_JOBID" opt-baselines \
--account opengptx-elm \
--partition booster \
-n 4 -g 4 \
--cpus-per-task 1  \
--ntasks-per-node 1 \
--prefix test125m \
--model-size 125m \
--juwelsbooster \
--checkpoints-dir "$ROOT_OUTPUT_DIR"/checkpoints/ \
--tensorboard-logdir "$ROOT_OUTPUT_DIR"/tensorboard/ \
--data "$DATA_PATH" \
--no-save-dir \
--snapshot-root "$ROOT_OUTPUT_DIR" \
--time 15 \
--salloc  

opt-baselines -n 4 -g 4  \
    --account opengptx-elm \
    --partition booster \
    --prefix opt125m_3 \
    --model-size 125m \
    --juwelsbooster \
    --data "$DATA_PATH" \
    --ntasks-per-node 4 \
    --cpus-per-task 1 \
    --checkpoints-dir  "$ROOT_OUTPUT_DIR"/checkpoints/  \
    --tensorboard-logdir "$ROOT_OUTPUT_DIR"/tensorboard/ \
    --no-save-dir \
    --snapshot-root "$ROOT_OUTPUT_DIR" \
    --time 10  \
    --no-wandb


--dataset-impl mmap \
--log-file "$ROOT_OUTPUT_DIR"/metric_log \
--final-vocab-size 50257 


 

sbatch --job-name test125m_v0.zero2.adam 
--gpus-per-node 4 
--nodes 1 
--ntasks-per-node 4 
--cpus-per-task 12 
--output CHECKPOINT_PATH/test125m_v0.zero2.adam.ngpu4/train.log 
--error CHECKPOINT_PATH/test125m_v0.zero2.adam.ngpu4/train.stderr.%j 
--open-mode append 
--signal B:USR1@180 
--partition booster 
--comment 'OSS Code Location: ./slurm_snapshot_code_oss/2022-05-11T16_21_55.842561' 
--time 4320 --mem 0 --wrap 



srun --job-name test125m_v0.zero2.adam 
--output CHECKPOINT_PATH/test125m_v0.zero2.adam.ngpu4/train.log 
--error CHECKPOINT_PATH/test125m_v0.zero2.adam.ngpu4/train.stderr.%j 
--open-mode append --unbuffered 
--cpu-bind=none 
python ./slurm_snapshot_code_oss/2022-05-11T16_21_55.842561/metaseq_cli/train.py 
--distributed-world-size 4 
--distributed-port 11803 
/p/scratch/opengptx/ebert1/opengpt/bigscience/oscar/oscar_text_document 
--save-dir CHECKPOINT_PATH/test125m_v0.zero2.adam.ngpu4 
--tensorboard-logdir TENSORBOARD_PATH/test125m_v0.zero2.adam.ngpu4 
--cluster-env juwelsbooster 
--task streaming_language_modeling 
--sample-break-mode none 
--vocab-filename tokenizers/gpt2-vocab.json 
--merges-filename tokenizers/gpt2-merges.txt 
--train-subset train 
--valid-subset valid/BookCorpusFair,valid/CommonCrawl,valid/DM_Mathematics,valid/Gutenberg_PG-19,valid/HackerNews,valid/OpenSubtitles,valid/OpenWebText2,valid/USPTO,valid/Wikipedia_en,valid/redditflattened,valid/stories 
--ignore-unused-valid-subsets 
--num-workers 8 
--num-workers-valid 1 
--validate-interval-updates 2000 
--save-interval-updates 2000 
--no-epoch-checkpoints 
--no-best-checkpoints 
--memory-efficient-fp16 
--fp16-init-scale 4 
--ddp-backend fully_sharded 
--no-reshard-after-forward 
--use-sharded-state 
--checkpoint-activations 
--model-parallel-size 2 
--criterion vocab_parallel_cross_entropy 
--distribute-checkpointed-activations
--tensor-parallel-init-model-on-gpu 
--full-megatron-init 
--megatron-init-sigma 0.006
--activation-fn relu 
--arch transformer_lm_megatron 
--share-decoder-input-output-embed
--decoder-layers 12 
--decoder-embed-dim 768 
--decoder-ffn-embed-dim 3072 
--decoder-attention-heads 12 
--decoder-learned-pos
--no-scale-embedding 
--tokens-per-sample 2048 
--optimizer adam 
--adam-betas '"'"'(0.9, 0.95)'"'"' 
--adam-eps 1e-08 
--clip-norm 1.0 
--clip-norm-type l2 
--lr-scheduler polynomial_decay 
--lr 0.0006 
--end-learning-rate 5.9999999999999995e-05 
--warmup-updates 715 
--total-num-update 572204 
--dropout 0.1 
--attention-dropout 0.1 
--no-emb-dropout 
--weight-decay 0.1 
--batch-size 128 
--update-freq 1 
--max-update 572204 
--seed 1 
--log-format json 
--log-interval 1 
--required-batch-size-multiple 1 




opt-baselines --account opengptx-elm --partition booster -n 4 -g 4 --cpus-per-task 1  --ntasks-per-node 1 --prefix test125m_1 --cpu-bind=none,v --model-size 125m --juwelsbooster --checkpoints-dir "$ROOT_OUTPUT_DIR"/checkpoints/ --tensorboard-logdir "$ROOT_OUTPUT_DIR"/tensorboard/ --data "$DATA_PATH" --no-save-dir --snapshot-root "$ROOT_OUTPUT_DIR" --time 15 
No CUDA runtime is found, using CUDA_HOME='/p/software/juwelsbooster/stages/2022/software/CUDA/11.5'
running command: sbatch --job-name test125m_1.zero2.adam --gpus-per-node 4 --nodes 4 --ntasks-per-node 1 --cpus-per-task 1 --output /p/scratch/opengptx-elm/john2/opengpt/OPT/checkpoints/test125m_1.zero2.adam.ngpu16/train.log --error /p/scratch/opengptx-elm/john2/opengpt/OPT/checkpoints/test125m_1.zero2.adam.ngpu16/train.stderr.%j --open-mode append --signal B:USR1@180 --account opengptx-elm --gres=gpu:4 --partition booster --comment 'OSS Code Location: /p/scratch/opengptx-elm/john2/opengpt/OPT/slurm_snapshot_code_oss/2022-06-09T15_21_43.417786' --time 15 --mem 0 --wrap '

srun --job-name test125m_1.zero2.adam 
--output /p/scratch/opengptx-elm/john2/opengpt/OPT/checkpoints/test125m_1.zero2.adam.ngpu16/train.log 
--error /p/scratch/opengptx-elm/john2/opengpt/OPT/checkpoints/test125m_1.zero2.adam.ngpu16/train.stderr.%j 
--open-mode append --unbuffered --cpu-bind=none,v --account=opengptx-elm --gres=gpu:4 
python /p/scratch/opengptx-elm/john2/opengpt/OPT/slurm_snapshot_code_oss/2022-06-09T15_21_43.417786/metaseq_cli/train.py
--distributed-world-size 16 --distributed-port 19996 
/p/scratch/opengptx-elm/john2/opengpt/data/oscar/oscar_text_document 
--save-dir /p/scratch/opengptx-elm/john2/opengpt/OPT/checkpoints/test125m_1.zero2.adam.ngpu16 
--tensorboard-logdir /p/scratch/opengptx-elm/john2/opengpt/OPT/tensorboard/test125m_1.zero2.adam.ngpu16 
--cluster-env juwelsbooster --task language_modeling --sample-break-mode none 
--vocab-filename /p/scratch/opengptx-elm/john2/opengptx-elm/data/tokenizers/gpt2-vocab.json 
--merges-filename /p/scratch/opengptx-elm/john2/opengptx-elm/data/tokenizers/gpt2-merges.txt 
--train-subset train --valid-subset valid/epubtxt,valid/BookCorpusFair,valid/CommonCrawl,valid/DM_Mathematics,valid/Gutenberg_PG-19,valid/HackerNews,valid/OpenSubtitles,valid/OpenWebText2,valid/USPTO,valid/Wikipedia_en,valid/redditflattened,valid/stories,valid/oscar 
--ignore-unused-valid-subsets --num-workers 1 --num-workers-valid 1 
--validate-interval-updates 2000 --save-interval-updates 2000 
--no-epoch-checkpoints --no-best-checkpoints --memory-efficient-fp16 
--fp16-init-scale 4 --ddp-backend fully_sharded 
--no-reshard-after-forward --use-sharded-state 
--checkpoint-activations --model-parallel-size 2 
--criterion vocab_parallel_cross_entropy --distribute-checkpointed-activations 
--tensor-parallel-init-model-on-gpu --full-megatron-init 
--megatron-init-sigma 0.006 --activation-fn relu --arch transformer_lm_megatron 
--share-decoder-input-output-embed --decoder-layers 12 --decoder-embed-dim 768 
--decoder-ffn-embed-dim 3072 --decoder-attention-heads 12 
--decoder-learned-pos --no-scale-embedding --tokens-per-sample 2048 
--optimizer adam --adam-betas '"'"'(0.9, 0.95)'"'"' --adam-eps 1e-08 
--clip-norm 1.0 --clip-norm-type l2 --lr-scheduler polynomial_decay --lr 0.0006 
--end-learning-rate 5.9999999999999995e-05 --warmup-updates 715 --total-num-update 572204 
--dropout 0.1 --attention-dropout 0.1 --no-emb-dropout --weight-decay 0.1 --batch-size 32 
--update-freq 1 --max-update 572204 --seed 1 --log-format json --log-interval 1 
--required-batch-size-multiple 1


