#!/bin/bash
#SBATCH --job-name=nucmer
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=40G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err

hostname
date

module load MUMmer/4.0.2

# in/out dirs
OUTDIR=/scratch/rnguyen/genome_assembly/results/05_assemblyQC/nucmer
mkdir -p ${OUTDIR}

# Fdiaph genome
APHOEN=/scratch/rnguyen/genome_assembly/results/04_assembly/scaffoldedAssemblies/hap1_scaffolds_final.fa

# download Fhet genome
wget -P ${OUTDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/020/745/825/GCF_020745825.1_Agelaius_phoeniceus_1.1/GCF_020745825.1_Agelaius_phoeniceus_1.1_genomic.fna.gz
gunzip ${OUTDIR}/GCF_020745825.1_Agelaius_phoeniceus_1.1_genomic.fna.gz

APH=${OUTDIR}/GCF_020745825.1_Agelaius_phoeniceus_1.1_genomic.fna

# run nucmer to generate the alignment
nucmer --prefix=${OUTDIR}/aph_vs_ref -t 16 ${APHOEN} ${APH}

