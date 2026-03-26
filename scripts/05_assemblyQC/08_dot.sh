#!/bin/bash
#SBATCH --job-name=dotplot
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

module load python/3.8.1

# in/out dirs
OUTDIR=/scratch/rnguyen/genome_assembly/results/05_assemblyQC/nucmer
cd ${OUTDIR}

# clone Dot repository
if [ ! -d dot ]; then
    git clone https://github.com/MariaNattestad/dot.git
fi

# remove shebang line (it points to system python)
sed -i '1d' dot/DotPrep.py

# prep data for display:
python3 dot/DotPrep.py --delta aph_vs_ref.delta --out dotplot
