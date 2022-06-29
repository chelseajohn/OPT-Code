# OpenGPT-X with META OPT

This repository contains set-up code for working on JSC JUWELS with
the forked [Meta OPT codebase](https://github.com/chelseajohn/metaseq.git).

## Getting Started 

### Set up
Assuming you have already set up your environment on the
supercomputer. If you have not, please see the ["Getting started at
JSC"](https://gitlab.jsc.fz-juelich.de/opengptx/infos-public/-/blob/main/documentation/getting_started_at_JSC.md)
guide. Then 

- Clone this repository
- make required changes in `variables.bash`
- execute 
```
nice bash setup.bash
source activate.bash
```

### Start Training 
Make required changes in the `jobscript.sh` like adjusting the `#SBATCH` variables as desired and execute :
```
sbatch jobscript.sh
```
**WARNING** : PyTorch >= 1.11 will complain about not being able to handle some address families and tell you that sockets are invalid. This does **not** hinder the code from scaling according to the number of total GPUs.

### Launch tensorboard for the run 

`tensorboard serve --logdir="INSERT_TENSORBOARD_LOGDIR" --bind_all `

## Additional Resource

 A modified [preprocessing script](https://github.com/chelseajohn/metaseq/blob/45063a41984dabc28a4812ae961cd829e6e6a406/preprocess_data.py) from the [BigScience/Megatron-DeepSeed](https://github.com/bigscience-workshop/Megatron-DeepSpeed/blob/3ab0ad1869c49a11b802e61c45ea1ecfc621e8d0/tools/preprocess_data.py) repository can be used to process data for pre-training. 
 The preprocessing can be executed by running :
 
 `sbatch preprocess_data.sh`


## Interactive Usage

To work interactively, please activate the environment like this:

```
source activate.bash
```

This will load the required modules, activate the Python virtual
environment, and set the variables specified in `variables.bash`.


## Supported Machines

- JUWELS Cluster
- JUWELS Booster

Supported means tested and the correct CUDA compute architecture will
be selected. Other machines can easily be supported by adjusting
`activate.bash`.

