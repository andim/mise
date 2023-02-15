# Install Packages
sudo apt install $(cat packagelist.txt)

# Install vim package manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy .dotfiles to ~

# Generate ssh key
ssh-keygen -t rsa -b 4096 -C "andimscience@gmail.com"
>> Add to github account

# Clone git repositories
git clone git@github.com:andim/self.git
git clone git@github.com:andim/andim.githubo.io

# Install Mamba

wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh

install snakemake environment (see https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)
conda install -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
