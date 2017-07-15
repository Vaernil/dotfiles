# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi
# Put your fun stuff here.
#source /etc/profile.d/bash-completion.sh
EDITOR="/usr/bin/vim"
source /usr/share/powerline/bash/powerline.sh
edn='nano -w'

ed2lrn=vim
por="/etc/portage"
cfg="~/.config"
# NAVIGATION
#wczesniejsza lokacja
alias .-="cd -"
alias ..="cd .."
alias ...="cd ../.."

alias d="cd ~/Dev"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
#ls
# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

#dogs rule!
alias dog="pygmentize -g"
#ALIASY
alias nalias="${edn} ~/.bashrc; . ~/.bashrc"
#EMERGE
alias e="emerge"
#.CONFIGS
alias nxres="nano -w ~/.Xresources"
alias nsxhkd="nano -w ${cfg}/sxhkd/sxhkdrc"
alias nbspwm="nano -w ${cfg}/bspwm/bspwmrc"
alias npanel="nano -w ${cfg}/bspwm/panel/panel"
alias nxinit="${edn} ~/.xinitrc"
alias ntop="${edn} ${cfg}/bspwm/panel/top"

#PORTAGE
alias nmkconf="sudo nano -w /etc/portage/make.conf"

#WIFI
#narazie dziala, usunalem ethernetowe urzadzenie, widocznie ono powodowalo konflikt, prolbemem jest jeszcze smietnik w logach

#GIT
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
#finding out the name of a window for bspwm rules
alias brulez="xprop |awk '/WM_CLASS/{print $4}'"
