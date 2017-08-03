if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi
#source /etc/profile.d/bash-completion.sh
. /etc/profile
#powerline is super slow
#. /usr/share/powerline/bash/powerline.sh
# use promptline instead
source ~/.shell_prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#----------------
# EXPORTS
#----------------
export PATH="/usr/non-portage/bin:${PATH}"
export PANEL_FIFO="/tmp/panel-fifo"
export PATH="$PATH:/home/vaernil/.config/bspwm/panel"
export EDITOR="/usr/bin/vim"
export QT_QPA_PLATFORMTHEME="qt5ct"
HISTCONTROL=ignoredups:erasedups  # no duplicate entries
#ALIASY
edn="nano -w"
ed2lrn="vim"
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
alias valias="${ed2lrn} ~/.bashrc; . ~/.bashrc"
alias vres="${ed2lrn} ~/.Xresources; xrdb -merge ~/.Xresources"
#EMERGE
alias e="sudo emerge"
#.CONFIGS
alias nxres="nano -w ~/.Xresources"
alias nsxhkd="nano -w ${cfg}/sxhkd/sxhkdrc"
alias nbspwm="nano -w ${cfg}/bspwm/bspwmrc"
alias npanel="nano -w ${cfg}/bspwm/panel/panel"
alias nxinit="${edn} ~/.xinitrc"
alias ntop="${edn} ${cfg}/bspwm/panel/top"
#PORTAGE
alias nmkconf="sudo nano -w /etc/portage/make.conf"
alias vmkconf="sudo ${ed2lrn} /etc/portage/make.conf"
alias vpuse="sudo ${ed2lrn} /etc/portage/package.use"
alias vpmask="sudo ${ed2lrn} /etc/portage/package.mask"
#GIT
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
#finding out the name of a window for bspwm rules
alias brulez="xprop |awk '/WM_CLASS/{print $4}'"
alias xmrg="xrdb -merge ~/.Xresources"
