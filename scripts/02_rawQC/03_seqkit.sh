#!/bin/bash
#SBATCH --job-name=HiCCoverage
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=16G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# Directory with HiFi FASTQ files
INDIR=/scratch/rnguyen/genome_assembly/rawdata
OUTDIR=/scratch/rnguyen/genome_assembly/results/02_qc
mkdir -p ${OUTDIR}

# Estimated genome size (Gb)
GENOME_SIZE_GB=1.2

# Calculate total bases (lightweight)
TOTAL_BASES=$(zcat ${INDIR}/bAgePho1_S5_R*.fastq.gz | awk 'NR%4==2 {sum += length($0)} END {print sum}')

# Convert genome size to bp
GENOME_SIZE_BP=$(echo "${GENOME_SIZE_GB} * 1000000000" | bc)

# Calculate coverage
COVERAGE=$(echo "scale=2; ${TOTAL_BASES} / ${GENOME_SIZE_BP}" | bc)

echo "Total bases in HiFi reads: ${TOTAL_BASES}"
echo "Genome size (bp): ${GENOME_SIZE_BP}"
echo "Estimated HiFi coverage (X): ${COVERAGE}"
