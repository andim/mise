# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# use vim as default editor
export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set the bash prompt to dir
export PS1="\w:\\$ \[\e[0m\]"

# If this is an xterm set the title to dir (used in tab title)
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\w\a\]$PS1"
        ;;
    *)
        ;;
esac

export PATH=$PATH:$HOME/.local/bin/:/usr/local/bin/

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# sync remote folder of same name from feynman cluster
# usage:
# sync `pwd`
# sync `pwd` csv
sync () {
   if [ -d $1 ] ; then
       echo $1;
       tmp=${1/home/biotheory};
       echo $tmp;
       remotepath=${tmp/amayer/andreas};
       echo $remotepath;
       rsync -P feynman:/mnt/$remotepath/*$2 $1;
   else
       echo "'$1' is not a valid path!"
   fi
}

# as suggested by Mendel Cooper in "Advanced Bash Scripting Guide"
extract () {
   if [ -f $1 ] ; then
       case $1 in
        *.tar.bz2)      tar xvjf $1 ;;
        *.tar.gz)       tar xvzf $1 ;;
        *.tar.xz)       tar Jxvf $1 ;;
        *.bz2)          bunzip2 $1 ;;
        *.rar)          unrar x $1 ;;
        *.gz)           gunzip $1 ;;
        *.tar)          tar xvf $1 ;;
        *.tbz2)         tar xvjf $1 ;;
        *.tgz)          tar xvzf $1 ;;
        *.zip)          unzip $1 ;;
        *.Z)            uncompress $1 ;;
        *.7z)           7z x $1 ;;
        *)              echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

ipynbtopy () {
	jupyter nbconvert --to python $1 --stdout --template=~/repos/mise/python/cleanpython.tpl | grep -Ev 'get_ipython' > "`basename $1 .ipynb`.py"
}


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# append custom modules to python search path
export PYTHONPATH=${PYTHONPATH}:/home/andreas/repos/clones/pyprind/:/home/andreas/repos/andima-personal/python/

# added by Anaconda3 installer
export PATH="/home/amayer/anaconda3/bin:$PATH"
