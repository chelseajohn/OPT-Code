#!/usr/bin/env bash

# Please prefer starting like `nice bash set_up.bash`.

set -euo pipefail


[ -x "$(command -v deactivate)" ] && deactivate


module purge
module load Stages/2020 GCC CMake Ninja git Python libaio 
# With PyTorch 1.11 need CUDA/11.3 and NCCL
module load cuDNN NCCL

source variables.bash

mkdir -p slurmLog
mkdir -p "$ROOT_DIR"
mkdir -p "$(dirname "$VENV_DIR")"
mkdir -p "$(dirname "$METASEQ_REPO")"
mkdir -p "$(dirname "$APEX_REPO")"
mkdir -p "$(dirname "$MEGATRON_LM_REPO")"
mkdir -p "$(dirname "$FAIRSCALE_REPO")"
mkdir -p "$ROOT_OUTPUT_DIR"

export CUDA_VISIBLE_DEVICES=0

[ -d "$VENV_DIR" ] || python -m venv --prompt opt_env --system-site-packages "$VENV_DIR"


source activate.bash

python -m pip install --upgrade pip

#Installing PyTorch 1.10.1 version with cuda 11.3 used by metaseq
# python -m pip install torch==1.10.1+cu113 torchvision==0.11.2+cu113 torchaudio==0.10.1+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

# Installing PyTorch 1.11 version with cuda 11.3
python -m pip install torch==1.11.0+cu113 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# Following from here on the metaseq setup instructions at
# https://github.com/facebookresearch/metaseq/blob/main/docs/setup.md


# Install Apex
[ -d "$APEX_REPO" ] \
    || git clone \
    https://github.com/NVIDIA/apex \
    "$APEX_REPO"
    
cd "$APEX_REPO"
python -m pip install \
       --no-cache-dir \
       -v \
       --disable-pip-version-check \
       --global-option="--cpp_ext" \
       --global-option="--cuda_ext" \
       --global-option="--deprecated_fused_adam" \
       --global-option="--xentropy" \
       --global-option="--fast_multihead_attn" \
       ./ \
    | tee build.log
cd ..

echo 'APEX Installation Complete!'

#Install Megatron
[ -d "$MEGATRON_LM_REPO" ] \
    || git clone \
        --branch fairseq_v2 https://github.com/ngoyal2707/Megatron-LM.git \
        "$MEGATRON_LM_REPO"

cd "$MEGATRON_LM_REPO"
python -m pip install six regex
python -m pip install -e . | tee build.log
cd ..

echo 'MEGATRON_LM Installation Complete!'

#Install fairscale
[ -d "$FAIRSCALE_REPO" ] \
    || git clone \
        https://github.com/facebookresearch/fairscale.git \
        "$FAIRSCALE_REPO"

cd "$FAIRSCALE_REPO"
git checkout prefetch_fsdp_params_simple
python -m pip install -e . | tee build.log
cd ..

echo 'FAIRSCALE_REPO Installation Complete!'

#Install metaseq ( forked repo compatible with juwels booster)
[ -d "$METASEQ_REPO" ] \
    || git clone \
           https://github.com/chelseajohn/metaseq.git \
           "$METASEQ_REPO"

cd "$METASEQ_REPO"
python -m pip install -e . | tee build.log
cd ..

echo 'Installation Complete!'
