#!/bin/sh

# ~/.bashrc
#

_checkexec() {
	command -v "$1" > /dev/null
}

# General settings
# ================



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "/etc/bashrc" ] ; then
    source /etc/bashrc
elif [ -f "/etc/bash.bashrc" ]; then
    source /etc/bash.bashrc
fi

if [ -d "$HOME"/bin ]; then
    PATH=$PATH:"$HOME"/bin
fi

if [ -d "$HOME"/.local/bin ]; then
    PATH=$PATH:"$HOME"/.local/bin
fi

# May be needed for Jekyll…
if [ -d "$HOME"/.local/share/gems ]; then
    GEM_HOME="$HOME"/.local/share/gems
    PATH=$PATH:"$HOME"/.local/share/gems/bin
fi

###
####
#just call .profile if it exists, source it


if [ -e $HOME/.profile ]
then
    . $HOME/.profile
fi
