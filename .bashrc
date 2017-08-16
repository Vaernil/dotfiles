if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi
[ -f /etc/profile ] && source /etc/profile
[ -f /etc/profile.d/bash-eix-completion.sh ] && source /etc/profile.d/bash-eix-completion.sh
[ -f ~/.scripts/shell_prompt.sh ] && source ~/.scripts/shell_prompt.sh
# fuzzy completion
[ -f ~/.scripts/fzf.bash ] && source ~/.scripts/fzf.bash
[ -f ~/.scripts/shell_ext_fzf ] && source ~/.scripts/shell_ext_fzf
HISTCONTROL=ignoredups:erasedups  # no duplicate entries
################
# EXPORTS
################
export EDITOR="/usr/bin/vim"
# pipes ag-silver searcher so the can fzf shows hidden files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-k:down,ctrl-i:up"
export PANEL_FIFO="/tmp/panel-fifo"
export PATH="${PATH}:/usr/non-portage/bin:~/.bin/bin"
export QT_QPA_PLATFORMTHEME="qt5ct"
export XAUTHORITY="/home/vaernil/.Xauthority"
################
# ALIASES
################
edn="nano -w"
ed2lrn="vim"
ednvim="nvim"
por="/etc/portage"
pcfg="~/.config"
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
alias nsxhkd="nano -w ${pcfg}/sxhkd/sxhkdrc"
alias nbspwm="nano -w ${pcfg}/bspwm/bspwmrc"
alias npanel="nano -w ${pcfg}/bspwm/panel/panel"
alias nxinit="${edn} ~/.xinitrc"
alias ntop="${edn} ${pcfg}/bspwm/panel/top"
#PORTAGE
alias nmkconf="sudo nano -w /etc/portage/make.conf"
alias vmkconf="sudo ${ed2lrn} /etc/portage/make.conf"
alias vpuse="sudo ${ed2lrn} /etc/portage/package.use"
alias vpmask="sudo ${ed2lrn} /etc/portage/package.mask"
# GIT
# maintaining dotfiles
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
#finding out the name of a window for bspwm rules
alias brulez="xprop |awk '/WM_CLASS/{print $4}'"
alias xmrg="xrdb -merge ~/.Xresources"
# substitue man with vim plugin
alias man=vim_man
# change some of those aliases to functions

# I also have it in bash_profile, but I don't think it works properly
# start keychain (ssh-agent) so I don't go full Tetsuo having to type passphrase bazilion times a day
# make it if hostname or grep linux distro, cuz it's different on my arch server
eval `keychain -Q -q --eval --agents ssh id_rsa`
