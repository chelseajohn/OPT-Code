#!/usr/bin/env bash

[ -x "$(command -v deactivate)" ] && deactivate

module purge
module load Stages/2022 GCC CMake Ninja git Python PyTorch CUDA libaio cuDNN NCCL torchvision torchaudio

source variables.bash


if ! [ -d "$VENV_DIR" ]; then
     echo 'Please execute `nice bash set_up.bash` before continuing.'
     exit 1
fi

source "$VENV_DIR/bin/activate"
export PYTHONPATH="$(realpath "$VENV_DIR"/lib/python*/site-packages):$PYTHONPATH"

# Set `TORCH_CUDA_ARCH_LIST` according to GPU's compute capability.
if [ "$SYSTEMNAME" = juwelsbooster ]; then
    # A100
    export TORCH_CUDA_ARCH_LIST='8.0'
elif [ "$SYSTEMNAME" = juwels ]; then
    # V100
    export TORCH_CUDA_ARCH_LIST='7.0'
else
    echo "The machine \"$SYSTEMNAME\" is currently not supported."
    exit
fi

# Also allow generating PTX instructions (just because, we could also
# not add these).
export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST"+PTX
export CXX=g++
