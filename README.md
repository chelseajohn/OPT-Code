# OpenGPT-X with META OPT

This repository contains set-up code for working on JSC Juwles Booster with
the forked [Meta OPT codebase](https://github.com/chelseajohn/metaseq.git).


# Set up
- make required changes in `variables.bash`
- Clone this repository
- execute 
```
nice bash setup.bash
source activate.bash
```
# Start Training 

```
sbatch opt125m-test.sh
```
