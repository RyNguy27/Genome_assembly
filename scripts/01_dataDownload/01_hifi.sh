#!/bin/bash 
#SBATCH --job-name=downloadHIFI
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

# HIFI data for Fundulus diaphanus from here: https://www.genomeark.org/vgp-curated-assembly/Agelaius_phoeniceus.html
    # HIFI reads, not subreads

OUTDIR=../../rawdata
mkdir -p ${OUTDIR}

wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Agelaius_phoeniceus/bAgePho1/genomic_data/pacbio_hifi/m64330e_221114_184840.hifi_reads.fastq.gz
wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Agelaius_phoeniceus/bAgePho1/genomic_data/pacbio_hifi/m64330e_221116_140955.bc1009--bc1009.hifi_reads.fastq.gz

