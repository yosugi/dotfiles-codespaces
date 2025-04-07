# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

LANG="en_US.UTF-8"
# LANG=ja_JP.UTF-8

PATH=$HOME/.local/bin:$HOME/bin:$PATH
export PATH

export PS1="[\u@\h \W]\$ "
# export PS1="[\u@hostname \W]\$ "

alias g='git'
