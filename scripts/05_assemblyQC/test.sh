#!/bin/bash
#SBATCH --job-name=merqury_plot
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=8G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=YOUR_EMAIL_HERE
#SBATCH --mail-type=ALL
#SBATCH --array=0-2
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err

# Print info
hostname
date

# -----------------------------
# Activate your Conda environment
# -----------------------------
source ~/miniconda3/etc/profile.d/conda.sh
conda activate merqury_env

# -----------------------------
# Load Merqury module
# -----------------------------
module load merqury/1.3
module load meryl/1.4.1

# -----------------------------
# Path to Merqury install (plotting script lives here)
# -----------------------------
MERQURY_HOME=/isg/shared/apps/merqury/1.3

# -----------------------------
# Define assemblies
# -----------------------------
ASSEMBLYDIR=/scratch/rnguyen/genome_assembly/results/04_assembly/hifiasm_fastas/
ASSEMBLIES=($(find ${ASSEMBLYDIR} -name "*fa"))
GEN=${ASSEMBLIES[$SLURM_ARRAY_TASK_ID]}
BASE=$(basename ${GEN} ".fa")

# -----------------------------
# Go to the existing Merqury output folder
# -----------------------------
OUTDIR=/scratch/rnguyen/genome_assembly/results/05_assemblyQC/merqury/${BASE}
mkdir -p ${OUTDIR}
cd ${OUTDIR}

# -----------------------------
# Run Merqury plotting only
# -----------------------------
Rscript /isg/shared/apps/merqury/1.3/plot/plot_spectra_cn.R \
  -f ${BASE}.${BASE}.spectra-cn.hist \
  -o ${OUTDIR}/${BASE}


# -----------------------------
# Done
# -----------------------------
date
echo "Merqury plotting finished for ${BASE}"
