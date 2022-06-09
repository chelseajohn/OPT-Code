# OpenGPT-X with BigScience

This repository contains set-up code for working on JSC machines with
the [BigScience
codebase](https://github.com/bigscience-workshop/Megatron-DeepSpeed).

## Aims

We aim to support a set-up for your own, specialized working
environment. This means we do not fix versions or commits; this would
have to be done on an individual/subgroup level.

## Getting Started

### Setting Up

We assume you have already set up your environment on the
supercomputer. If you have not, [please see the "Getting started at
JSC" guide](https://gitlab.jsc.fz-juelich.de/opengptx/infos-public/-/blob/main/documentation/getting_started_at_JSC.md).
guide.

First off, clone this repository to a destination of your choice.
Adjust variables in `./run_scripts/variables.bash` and execute:

```shell
cd run_scripts
nice bash set_up.bash
```

For weird reasons, sometimes Bash parses incorrectly and the script
breaks. Please just try again in that case.

### Starting Training

In `./run_scripts/tr1-13B-round1_juwels_pipe.sbatch`, adjust the
`#SBATCH` variables on top as desired (most interesting is the number
of `--nodes`) and execute:

```shell
cd run_scripts
sbatch tr1-13B-round1_juwels_pipe.sbatch
```

Please always run the scripts from the `run_scripts` directory. We
have not yet made them execution-location-independent.

Care needs to be taken when changing the number of GPUs per node. You
also need to change the `GPUS_PER_NODE` variable accordingly, as we do
not yet bother with parsing the `SLURM_GRES` value.

The script we currently work with,
`./run_scripts/tr1-13B-round1_juwels_pipe.sbatch`, is the oldest
training sbatch script from the [BigScience documentation
repository](https://github.com/bigscience-workshop/bigscience). This
matches the current data structure we use for testing; a newer version
that assumes later PyTorch versions has different data structure
requirements due to the many different corpora BigScience is training
on.

PyTorch >= 1.11 will complain about not being able to handle some
address families and tell you that sockets are invalid. This does
**not** hinder the code from scaling according to the number of total
GPUs.

### Interactive Usage

We use a certain environment setup to handle our software stack. To
work interactively, please activate the environment like this:

```
cd run_scripts
source activate.bash
```

This will load the modules we use, activate the Python virtual
environment, and set the variables you specified in `variables.bash`.

## Supported Machines

- JUWELS Cluster
- JUWELS Booster

Supported means tested and the correct CUDA compute architecture will
be selected. Other machines can easily be supported by adjusting
`./run_scripts/activate.bash`.
