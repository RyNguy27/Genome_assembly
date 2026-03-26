#!/bin/bash 
#SBATCH --job-name=hifiasm
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 24
#SBATCH --mem=150G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --constraint=AVX2

hostname
date

module load Hifiasm/0.24.0

INDIR=/scratch/rnguyen/genome_assembly/rawdata
OUTDIR=/scratch/rnguyen/genome_assembly/results/04_assembly/hifiasm
mkdir -p ${OUTDIR}

# Assemble with HiFi reads
# Also do Hi-C phasing with paired-end short reads in two FASTQ files
hifiasm \
    -t 24 \
    -o ${OUTDIR}/Aphoeniceus.asm \
    --h1 ${INDIR}/bAgePho1_S5_R1_001.fastq.gz \
    --h2 ${INDIR}/bAgePho1_S5_R2_001.fastq.gz \
    ${INDIR}/m64330e_221114_184840.hifi_reads.fastq.gz \
    ${INDIR}/m64330e_221116_140955.bc1009--bc1009.hifi_reads.fastq.gz
