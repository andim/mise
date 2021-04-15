# Install Anaconda

wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
bash Anaconda3-2020.11-Linux-x86_64.sh 

install snakemake environment (see https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)
conda install -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
