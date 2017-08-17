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
HISTCONTROL=ignoredups:erasedups								# no duplicate entries
################################
####		EXPORTS
################################
export EDITOR="/usr/bin/nvim"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'	# pipes ag-silver searcher so the can fzf shows hidden files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"				# apply the command to CTRL-T as well
export FZF_DEFAULT_OPTS="--bind ctrl-k:down,ctrl-i:up"
export PANEL_FIFO="/tmp/panel-fifo"
export PATH="${PATH}:/usr/non-portage/bin:~/.bin/bin"
export QT_QPA_PLATFORMTHEME="qt5ct"
export VISUAL="/usr/bin/nvim"
export XAUTHORITY="/home/vaernil/.Xauthority"
################################
####		ALIASES
################################
edn="nano -w"
ed2lrn="nvim"
por="/etc/portage"
pcfg="~/.config"
colorflag="--color"
alias sudo='sudo '												# aliases can be sudoed, is that good approach?
# NAVIGATION
alias .-="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias d="cd ~/dev"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
# https://xkcd.com/1168/
alias t="tar -xzvf"
# EMERGE
alias e="sudo emerge -av"
alias e1="sudo emerge -1av"
alias es="sudo eix-sync"
alias erd="sudo emerge --update --newuse --deep --keep-going @world" # run before depclean
alias eupd="sudo emerge -uDU --with-bdeps=y --keep-going @world"
alias edep="sudo emerge -av --depclean"
alias ewrld="sudo emerge -av --noreplace "
# compiling kernel, oldconfigs and stuff
# empty trash
# .CONFIGS
alias vsxhkd="${ed2lrn} ${pcfg}/sxhkd/sxhkdrc"
alias vbspwm="${ed2lrn} ${pcfg}/bspwm/bspwmrc"
alias vpanel="${ed2lrn}nano -w ${pcfg}/bspwm/panel/panel"
alias vxinit="${ed2lrn} ~/.xinitrc"
# .CONFIGS PORTAGE
alias vmkconf="sudo ${ed2lrn} /etc/portage/make.conf"
alias vpuse="sudo ${ed2lrn} /etc/portage/package.use"
alias vpmask="sudo ${ed2lrn} /etc/portage/package.mask"
alias vpkey="sudo ${ed2lrn} /etc/portage/package.accept_keywords"
alias vworld="sudo ${ed2lrn} /var/lib/portage/world"
# GIT
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"	# maintaining dotfiles
# ls
alias l="ls -lF ${colorflag}"								# ls colorized, in long format
alias la="ls -laF ${colorflag}"								# ls colorized, in long format + dotfiles
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'" 	# ls only directories
alias dog="pygmentize -g"									# dogs rule!
alias vbsh="${ed2lrn} ~/.bashrc; . ~/.bashrc"
alias vres="${ed2lrn} ~/.Xresources; xrdb -merge ~/.Xresources"
alias xmrg="xrdb -merge ~/.Xresources"
alias man=vim_man											# substitute man with vim plugin
# finding out the name of a window for bspwm rules
alias brulez="xprop |awk '/WM_CLASS/{print $4}'"
# change some of those aliases to functions
# I also have it in bash_profile, but I don't think it works properly
# start keychain (ssh-agent) so I don't go full Tetsuo having to type passphrase bazilion times a day
# make it if hostname or grep linux distro, cuz it's different on my arch server
# SSH
eval `keychain -Q -q --eval --agents ssh id_rsa`

