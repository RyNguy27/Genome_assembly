#!/bin/bash
#SBATCH --job-name=busco
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=20G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=0-2   # EDIT 1: Use standard SLURM array syntax

hostname
date

##########################################################
##              BUSCO                                   ##
##########################################################

module load busco/5.4.5

# Output directory
OUTDIR="../../results/05_assemblyQC/busco"
mkdir -p ${OUTDIR}

# Assembly files
ASSEMBLYDIR="/scratch/rnguyen/genome_assembly/results/04_assembly/hifiasm_fastas/"
ASSEMBLIES=($(find ${ASSEMBLYDIR} -name "*fa"))

GEN=${ASSEMBLIES[$SLURM_ARRAY_TASK_ID]}
BASE=$(basename ${GEN} ".fa")

# BUSCO dataset directory (shared location)
# EDIT 2: Use a fixed directory for the downloaded dataset
BUSCO_DB_DIR="/scratch/rnguyen/genome_assembly/busco_datasets"
mkdir -p ${BUSCO_DB_DIR}

DATABASE="passeriformes_odb10"

# EDIT 3: Only download/extract dataset if not already present
if [ ! -d "${BUSCO_DB_DIR}/${DATABASE}" ]; then
    echo "Downloading BUSCO dataset ${DATABASE}..."
    busco --download ${DATABASE} --out ${BUSCO_DB_DIR} --force
fi

# Run BUSCO
busco \
    -i ${GEN} \
    -o ${OUTDIR}/${BASE} \
    -l ${BUSCO_DB_DIR}/${DATABASE} \   # EDIT 4: point to shared dataset
    -m genome \
    -c 12 \
    -f
