#!/bin/bash 
#SBATCH --job-name=downloadHiC
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


hostname
date

# arima Hi-C data from here: https://www.genomeark.org/vgp-curated-assembly/Agelaius_phoeniceus.html

OUTDIR=../../rawdata
mkdir -p ${OUTDIR}

wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Agelaius_phoeniceus/bAgePho1/genomic_data/arima/bAgePho1_S5_R1_001.fastq.gz
wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Agelaius_phoeniceus/bAgePho1/genomic_data/arima/bAgePho1_S5_R2_001.fastq.gz

