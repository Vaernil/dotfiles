### TODO
# change some of those aliases to functions
# man zshbuiltins
# man zshmisc
# https://unix.stackexchange.com/questions/117331/in-zsh-how-can-i-dump-all-configuration/117344#117344
################################
####        ALIASES
################################
# ADMIN ROOT SUSHIT
alias sssx="sxhkd -c '${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc' &"
alias sudo='sudo '                        # aliases can be sudoed, so it works with root
alias s='sudo '                        # aliases can be sudoed, so it works with root
alias se="sudoedit"
alias sedit="sudoedit"
# alias se="sudo -e "
alias sE="sudo -E "
# sudo -E preserves environment
# 'su -' changes env because it behaves like the user just logged in
# but dont alias it
# alias su="su - "
# KERNEL
# working genkernel working using current config.gz and substituting gold
# kernel that is not working
alias gksafe="sudo genkernel --kernel-ld=/usr/bin/ld.bfd --utils-ld=/usr/bin/ld.bfd --kernel-config=/proc/config.gz --xconfig all"
### PROCESS
alias gpid="ps -A -e -l | rg"
### NAVIGATION
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
# add mouse shortcuts and stuff to sxhkd like alt+up
# alias -- -="cd-"
alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"
alias md="mkdir -p"
alias rd="rmdir"
alias d="cd ~/dev"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias t="tar -xzvf"                    # https://xkcd.com/1168/
alias -g vcf="/home/vaernil/.config/"
# git
# NOTE please rethink this and improve, add group, global aliases and shit
# exa -lH sm
### display options
# --icons show icons
# --group-directories show directories first
# -l long extended file metadata
# -G grid (default)
# -F, --classify     display type indicator by file names
### long view options
# -h header row to each column
# -H, --links list each file's number of hard links
# --git show git status if tracked or ignored
# -@, --extended list each file's extended attributes and sizes
# GRID disables -H because links wont fit
alias ll="exa --git --icons -lhF@ -H"
alias lla="exa --git --icons -lhF@ -H -aa"
##
alias l="exa --git --icons --group-directories-first -GlhF@"
alias lg="exa --git --icons --group-directories-first -GhF@"
alias lga="exa --git --icons --group-directories-first -GhF@ -aa"
alias ls="exa --git --icons --group-directories-first -GlhF@"
# tree view recurse 1
alias lt="exa --git --icons --group-directories-first -lhF@ -TL1"
alias lt1="exa --git --icons --group-directories-first -lhF@ -TL1"
# tree view recurse 2
alias lt2="exa --git --icons --group-directories-first -lhFH@ -TL2"
alias la="exa --git --icons --group-directories-first -GlhFH@ -aa"
# a means hidden also
alias lat="exa --git --icons --group-directories-first -lhFH@ -TL1"
alias lat1="exa --git --icons --group-directories-first -lhFH@ -TL1"
alias lat2="exa --git --icons --group-directories-first -lhFH@ -TL2"
# need to ignore group-directories first
alias li="exa --git --icons -GlhFH@ -aa"
# really all, no limits but recursive takes too long use with caution
alias lA="exa --git --icons -lhaaTRFH@"
alias -g sm="--sort=modified"
alias -g r2="--recurse -L2"
# utility
# alias grep="grep --color "
# .config/ripgrep/rg.conf
# repleace grep with ripgrep
# dunno about that this breaks shit
# alias grep="rg"
# alias grep="rg"
# alias sgrep="grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} "
# alias t="tail -f "
alias diff="nvim -d "
alias v="nvim "
alias nv="nvim "
alias vim="nvim "
### fzf
# https://github.com/junegunn/fzf#using-the-finder
alias fzfp="fzf --preview 'head -100 {}'"
alias fzfm="fzf -m"
# think about theme
# alias man2="man"
vman() { man $* | col -b | nvim -c 'set ft=man nomod nolist' -; }
# alias gset="typeset | grep"
alias gset="typeset | rg"
# alias man="vman"
# alias man=man $* | col -b | nvim -c 'set ft=man nomod nolist' -

# HARDWARE
# filesystems
alias df="df -hT" # human, show filesystem type; -a for all
alias dush="du -ah | sort -h"    # recursive travers and then sort
# disk labels and uuids
# tree /dev/disk
# lsblk -o +fstype,label,uuid,partuuid
# lspci to list devices
# spci -vvnn
### GIT
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotcfg="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"      # maintaining .dotfiles
alias dotcf="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"      # maintaining .dotfiles
alias .cfg="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"      # maintaining .dotfiles
alias .cf="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"      # maintaining .dotfiles
# make function?
dotfileinit() {
	[ -z "$DOTFILE" ];
	git init --bare $DOTFILE
	alias dotcfg="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"
	alias dotcf="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"
	alias .cfg="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"
	alias .cf="/usr/bin/git --git-dir=$DOTFILE --work-tree=$HOME"
	# branch="master"
	# branch="nb-N850"
	branch="$(hostname)"
	dotcfg config --local status.showUntrackedFiles no
	# dont add .ssh or share it to your own cloud
	# if hostname nb-850
	#     branch=laptop+hostname
	# fi
	# else
	#     branch=unkown
}

# git init --bare $HOME/.cfg
# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# config config --local status.showUntrackedFiles no
# echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
# make different branches
#
### EMERGE
alias e="sudo emerge"
alias e1="sudo emerge -1av"
# sync
alias es="sudo eix-sync"
alias erd="sudo emerge --update --newuse --deep --keep-going @world" # run before depclean
alias eupd="sudo emerge -uDU --with-bdeps=y --keep-going @world"
## monthly upgrade, backtracks trhough dep tree to make sure
alias eupd1k="sudo emerge -uDU --with-bdeps=y --keep-going --backtrack=1000 @world"
alias edep="sudo emerge -av --depclean"
alias ewrld="sudo emerge -av --noreplace"
# https://wiki.gentoo.org/wiki/Gentoo_Cheat_Sheet
# use deselect
# current use flags on the system
alias eAu="portageq envvar USE | xargs -n 1"
alias eAu2="euse -a" # super slow
# To check if a certain USE flag is activated and which packages use it, run:
alias eu1="euse -I"
alias eu2="euses"
alias eu3="quse"
function fukuse() {
	euse -I $1;
	euse -i $1;
	euses $1;
	# quse $1;
}
alias eu4="eix --installed-with-use"
# alias eu0=""
# to what package a file belongs
alias qb1="qfile"
alias eqa="equery a"   # all packages if h[a]s matching ENV data stored in /var/db/pkg
alias eqb="equery b"   # what packages FILES [b]elong to
alias eqc="equery c"   # [c]hangelog entries for ATOM
alias eqd="equery d"   # all packages directly [d]epending on ATOM
alias eqf="equery f"   # list all [f]iles installed by PKG
alias eqg="equery g"   # tree [g]raph of all dependencies for PKG
alias eqh="equery h"   # all packages that [h]ave USE flag
alias eqk="equery k"   # verify chec[k]sums and timestamps for PKG
alias eql="equery l"   # [l]ist package matchning PKG
alias eqm="equery m"   # [m]etadata about PKG
alias eqs="equery s"   # total [s]ize of all files owned by PKG
alias equ="equery u"   # [U]SE flags for PKG
alias eqw="equery w"   # [w]hich print full path to ebuild for PKG
alias eqy="equery y"   # ke[y]words for specified PKG
alias eAll="eix-installed -a | rg " # list all installed package
# check enviroment and grep, change to rg?
# env doesn't show all variables i also need shell variables
alias genv="env | rg "
# tip for me equ is the most useful, do somthing
# you can make backups wiyh symlinks
# VERSION_CONTROL
# k
# networkmanager nm-applet nm-editor
# ❖ nvim /etc/wpa_supplicant/wpa_supplicant.conf
# alias ln="ln -vi --backup=existing"
# p p10k.zsh{,~}
### .CONFIGS
# vim
alias vimrc="${EDITOR} ${MYVIMRC}"
# bash
alias bashrc="${EDITOR} ${HOME}/.bashrc; . ${HOME}/.bashrc"
# zsh
alias zshrc="${EDITOR} ${ZDOTDIR}/.zshrc; source ${ZDOTDIR}/.zshrc; echo 'reloaded'"
alias vexport="${EDITOR} ${ZDOTDIR}/01-export.zsh; source ${ZDOTDIR}/01-export.zsh"
alias valias="${EDITOR} ${ZDOTDIR}/aliasesNfunctions.zsh; . ${ZDOTDIR}/aliasesNfunctions.zsh; echo 'reloaded aliases'"
alias vfun="${EDITOR} ${ZDOTDIR}/aliasesNfunctions.zsh; . ${ZDOTDIR}/.zshrc; echo 'reloaded functions'"
alias vkey="${EDITOR} ${ZDOTDIR}/keybinds.zsh; source ${ZDOTDIR}/keybinds.zsh"
alias vp10="${EDITOR} ${ZDOTDIR}/themes/p10k.zsh"
alias vp10c="${EDITOR} ${ZDOTDIR}/themes/p10k-custom.zsh"
# env refresh
alias .envA="sudo env-update && source /etc/zsh/zprofile && source ${ZDOTDIR}/.zshrc && echo 'refreshed profile and rc'"
# test current xorg.conf generate new
# you need to use different tty
# sudo X :2 -configure
# always use su - because otherwise you keep the user env
# reload | source Xresources
# X
alias xmrg="xrdb -merge ~/.Xresources && printf 'reloaded .Xresources'"
alias vxinit="${EDITOR} ${HOME}/.xinitrc"
# alias vxorg="sudoedit /etc/X11/xorg.conf"
# theme
alias vres="${EDITOR} ~/.Xresources; xrdb -merge ~/.Xresources"
# WM
alias vbspwm="${EDITOR} ${XDG_CONFIG_HOME}/wm/bspwm/bspwmrc"
# alias -g wm="${EDITOR} ${XDG_CONFIG_HOME}/wm/bspwm/bspwmrc"
#alias vwm="${EDITOR} ${XDG_CONFIG_HOME}/wm/bspwm/bspwmrc"
alias vsxhkd="${EDITOR} ${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc"
alias vsx="${EDITOR} ${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc"
alias vpanel="${EDITOR} ${XDG_CONFIG_HOME}/wm/panel/limebar3"
alias vbrul="${EDITOR} ${XDG_CONFIG_HOME}/wm/scripts/visual/exrules.sh"
alias ncomn="${EDITOR} ${HOME}/text/commandsvim"

### .CONFIGS PORTAGE
alias vmkconf="sudo -e /etc/portage/make.conf"
alias vpuse="sudo -e /etc/portage/package.use"
alias vpmask="sudo -e /etc/portage/package.mask"
alias vpkey="sudo -e /etc/portage/package.accept_keywords"
alias vpmask2="sudo -e /usr/portage/profiles/arch/amd64/use.stable.mask"
alias vworld="sudo -e /var/lib/portage/world"
# move all to function
# WM
### bspwm helpers
# awk prints the lines that match the pattern
# $0 all arguments (passed to awk), print whole then in bspw format
# alias brl="xprop | awk '/WM_CLASS/{print \$0,\$4,\$3}'"               # name of a window for bspwm rules
# https://github.com/neeasade/dotfiles/blob/master/bin/bin/popup_window.sh
# get current layout WM
# TODO REDO
alias blayout="bspc query -T -m"

alias brl="xprop | awk '/WM_CLASS/{print \$0}'"               # name of a window for bspwm rules
# alias brl='xprop | awk "/WM_CLASS/{print "$0" "$4" "$3"}"'               # name of a window for bspwm rules
alias brl2="xprop | awk '/WM_NAME/{print \$0}'"               # instance name
alias brla="xprop"                    # all
#
### font shit
#alias fc-list="fcl"
#
### useful commands make into function later to echo it to the file
# thinkabout some note system
#####
# SUFFIX alias, allows to open the file by just typing the name
#
#alias -s
#alias -s [file-extension]=[name-of-app]
# alias -s txt=nvim
#alias -s md=typora
# zsh builtin aliases
# suffix
# alias -s
## the -g flag is present, define a global alias; global aliases are expanded even  if
## they do not occur in command position.
#http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
# GLOBAL
alias oo="xdg-open"
alias -g H="| head"
alias -g T="| tail"
alias -g GG="| grep"
alias -g G="| rg"
alias -g L="| less"
alias -g M="| more"
alias -g H="--help "
# pipe to nvim
alias -g V="| nvim"
# not sure how to make it work
alias -g VD="| nvim -d "
alias dmesg="dmesg -e --color=always" # human readable time, no-pager
# make some shortcut in sxhkd that spawn console in current pwd or something
# or copy to env variable current pwd
# mpv playlist change ctrl plus mouse for next item in playlist
# scroll right left laready does it
# *** Searching
# search
# content search
# also some functions double the functionality
alias rgs="rg --no-ignore --hidden --follow"
alias -g rgi="| rg --no-ignore --hidden --follow -timg"
alias fda="fd -HIL"
# number of files (not directories)
alias fcount="find . -type f | wc -l"
# --files? but that still searches contents but just pritns paths
# alias rgt="rg --no-ignore --hidden --follow -t"
#alias -g img=""
# ok, so ripgrep mainly searches contents if i want to find files i have to
# pipe it to ls or use fd or some other way
# https://www.reddit.com/r/vim/comments/7c8q7u/searching_with_fzfripgrep_by_filetypes/
# should i use fd?
# https://github.com/sharkdp/fd/blob/master/README.md
# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#manual-filtering-file-types

# tee outputs shit to file and output
# command | tee $file
# https://skorks.com/2009/09/using-bash-to-output-to-screen-and-file-at-the-same-time/
# # http://jeff.robbins.ws/reference/my-zshrc-file
# these require zsh
# files & directories modified in last day
alias ltd="ls *(m0)"
# # files (no directories) modified in last day
# alias lt='ls *(.m0)'
# # list three newest
# alias lnew='ls *(.om[1,3])'
# # most recent subdir
# alias lsrdir='ls -d *(/om[1])'
# also make something that watches filesystem with wendy ionide you know
# alias xclip xclip -sel clip < .ssh/github_rsa.pub
# # copy working directory to clipboard
alias cpwd="pwd | tr -d '\n' | xsel -ib"
# previous command
# fc -ln -1
# fc - command historny -l lists command -n supresses the number -1 is previous
# one
# change ranger pager or pager in general
# become friends with qtbrowser or that extension for firefox and learn how to
# search through open tabs
# either copy to clipboard on find or make some function that copies last
# output
# /home/vaernil/.config/qt5ct
# qt5ct: using qt5ct plugin
# Configuration path: "/home/vaernil/.config/qt5ct"
# Shared QSS paths: ("/home/vaernil/.local/share/qt5ct/qss", "/usr/local/share/qt5ct/qss", "/usr/share/qt5ct/qss")
# Shared color scheme paths: ("/home/vaernil/.local/share/qt5ct/colors", "/usr/local/share/qt5ct/colors", "/usr/share/qt5ct/colors")
# fonts
# <dir>/usr/share/fonts</dir>
# <dir>/usr/local/share/fonts</dir>
# <dir prefix="xdg">fonts</dir>
# <!-- the following element will be removed in the future -->
# <dir>~/.fonts</dir>
# understand fontconfig /etc/fonts/
#
# xrdb -query queries Xresources
# ### male alt-l which is movement to act as tab in nvim
# xrandr | grep -w connected
# fixing
# xserver-command=X -dpi 90
# simple arithmetic in terminal
# expr? but it only does integers bc basic calculator
# seems x sets incorrect dpi
# xdpyinfo | grep -B 2 resolution
# fc-list lists all the fonts
# grep /fonts ~/.local/share/xorg/Xorg.0.log
# also xset q
#Keep in mind that Xorg does not search recursively through the /usr/share/fonts/ directory like Fontconfig does. To add a path, the full path must be used:  grep -v inverts so does rg
# grep -v inverts
# known fonts Xorg uses xlsfonts
# https://wiki.archlinux.org/index.php/Font_configuration
# fc-scan
# bitmap fonts are used as fallbacks
# Subpixel rendering is a technique to improve sharpness of font rendering by effectively tripling the horizontal (or vertical) resolution through the use of subpixels. On Windows machines, this technique is called "ClearType".
# sudo eselect fontconfig list
# /etc/fonts/local.conf
# eature 	Description
# Anti-aliasing 	is enabled by default and makes fonts less blocky.
# Hinting 	is an attempt to cope with the low pixel count per unit of area of current displays. Correct hinting makes characters more crisp but since font metrics aren't changed (and arguably should not change) affects how overall the rendered text looks like.
# Sub-pixel rendering 	uses the fact that LCD matrix has three primaries to effectively triple the resolution of text but can make characters appear not entirely black. To combat that lcdfilter is to be used with sub-pixel rendering (available for newer fontconfig) but it can blur the characters too much. In the end this entirely depends on person how they like their text.
#
# enabled rgb and lcd
#
# Autohinter is not compatible with sub-pixel rendering, do not use the two together!
#
# do some shit with zsh history
# also automatically save fdupes to file and append directory name and date
# remember apropos
# disable mouse acceleration
# deal with network and restart this shit from cli
# eix --dump
# set env variable to .config/eix/eixrc or better /etc/eixrc
# eix -any -F -v
# verbose is too verbose
# also maybe search by categories
# also make somethin that prints all not 50 or omits installed or only checks
# installed for upates, you feel me
#eix -v -F -C x11-themes -s gnome
#without piping!
# xwininfo
# xprop -root
#| misc : $4 | misc : $4
alias bdesk="xprop | awk '/WM_DESKTOP/{print \$3}'"
#
# find -cmin -5
# add some ignore list like cache and firefox
# stat /bin/file
# check how many link it has inode etc
# find / -perm -0777 -a ! -type l -ls
# learn about exec
# https://unix.stackexchange.com/questions/345406/in-a-sudo-find-command-how-do-i-make-sure-that-exec-command-is-run-as-norm
# sudo find /path/ -print0 | xargs -r0 process_paths
# https://wiki.gentoo.org/wiki/Filesystem/Security
# https://wiki.gentoo.org/wiki/Complete_Handbook/Users_and_the_Linux_file_system
#
# zsh env
# /usr/share/zsh/5.8/Util
# source reporter
alias sourcerep="source /usr/share/zsh/5.8/Util/reporter variables"

# xdotool
# pushd
# directory stack
################################
####		FUNCTIONS
################################
##### SYSTEM AND KERNEL FUNCTIONS
# get options from current kernel
function grepkern() {     # grep kernel options of a running kernel
	zgrep -i "$1" /proc/config.gz
}

## FILE MANIPULATION
# using ag searches through content
function fag() {
	[ $# -eq 0  ] && return
	local out cols
	if out=$(ag --nogroup --color "$@" | fzf --ansi); then
		setopt sh_word_split
		cols=(${out//:/  })
		unsetopt sh_word_split
		nvim ${cols[1]} +"normal! ${cols[2]}zz"
	fi
}

# using ripgrep combined with fzf preview to search contents
# find-in-file - usage: fif <searchTerm>
fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

fifrga() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	local file
	file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
}

function extract() {      # Handy Extract Program
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)  tar xvjf "$1"	;;
			*.tar.gz)   tar xvzf "$1"	;;
			*.bz2)      bunzip2 "$1"	;;
			*.rar)		unrar x "$1"	;;
			*.gz)		gunzip "$1"		;;
			*.tar)		tar xvf "$1"	;;
			*.tbz2)		tar xvjf "$1"	;;
			*.tgz)		tar xvzf "$1"	;;
			*.zip)		unzip "$1"		;;
			*.Z)		uncompress "$1"	;;
			*.7z)		7z x "$1"		;;
			*.xz)		unxz "$1"		;;
			*)			echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

##### THEMES
# echo unicode symbol
# add function to test script performance
# function eun() {
#     echo -e '\u'$1''
# }

# print color map
# find better ones
prcolor() {
	for i in {0..255};
	do print -Pn "%K{$i} %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
	done
}
# BRUH
# debugging fonts and prompt
fdebug() {
	emulate -L zsh
	setopt err_return no_unset
	local text
	print -rl -- 'Select a part of your prompt from the terminal window and paste it below.' ''
	read -r '?Prompt: ' text
	local -i len=${(m)#text}
	local frame="+-${(pl.$len..-.):-}-+"
	print -lr -- $frame "| $text |" $frame
}

###TESTING
# function snotif() {       #send test notification
#     notify-send $1 $2 --icon=dialog-information
# }
#FZF FZFZFZ
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}

# https://stackoverflow.com/questions/4554718/how-to-use-patterns-in-a-case-statement
# edit configs, how to add to autocompletion?
# Edit Config File
ecf() {
	case $1 in
		# user notepad, rethink approach
		# append date? every few days?
		note)      $EDITOR $HOME/text/2020-notes ;;
		# wm
		bspwm)     $EDITOR $XDG_CONFIG_HOME/wm/bspwm/bspwmrc ;;
		brules)    $EDITOR $XDG_CONFIG_HOME/wm/scripts/visual/exrules.sh ;;
		sxhkd)     $EDITOR $XDG_CONFIG_HOME/wm/sxhkd/sxhkdrc ;;
		panel)     $EDITOR $XDG_CONFIG_HOME/wm/panel/limebar ;;
		tpicon)    $EDITOR $XDG_CONFIG_HOME/wm/panel/tools/icon ;;
		tpcolor)   $EDITOR $XDG_CONFIG_HOME/wm/themes/panel_colors ;;
		tpconf)    $EDITOR $XDG_CONFIG_HOME/wm/themes/panel_config ;;
		twmcolor)  $EDITOR $XDG_CONFIG_HOME/wm/themes/wm_numixlike ;;
		twmicon)   $EDITOR $XDG_CONFIG_HOME/wm/themes/unicode_icons ;;
		nvim|vim[rc]) $EDITOR $XDG_CONFIG_HOME/vim/.vimrc ;;
		wmscripts) $EDITOR $XDG_CONFIG_HOME/wm/scripts ;;
		# .config programs
		dunst)      $EDITOR $XDG_CONFIG_HOME/dunst/dunstrc ;;
		mpd)		$EDITOR $XDG_CONFIG_HOME/mpd/mpd.conf ;;
		mpvc)		$EDITOR $XDG_CONFIG_HOME/mpv/mpv.conf ;;
		mpvin)		$EDITOR $XDG_CONFIG_HOME/mpv/input.conf ;;
		neofetch)	$EDITOR $XDG_CONFIG_HOME/neofetch/config.conf ;;
		picom)      $EDITOR $XDG_CONFIG_HOME/picom.conf ;;
		pqiv)		$EDITOR $XDG_CONFIG_HOME/pqiv/pqivrc ;;
		ranger)		$EDITOR $XDG_CONFIG_HOME/ranger/rc.conf ;;
		rifle)		$EDITOR $XDG_CONFIG_HOME/ranger/rifle.conf ;;
		scope)		$EDITOR $XDG_CONFIG_HOME/ranger/scope.sh ;;
		rofi)		$EDITOR $XDG_CONFIG_HOME/rofi/config ;;
		term)       $EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml ;;
		zathura)	$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc ;;
		# env and shit
		# local
		bashrc)		$EDITOR $HOME/.bashrc ;;
		zshrc)		$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc && source $XDG_CONFIG_HOME/zsh/.zshrc ;;
		zexp)		$EDITOR $XDG_CONFIG_HOME/zsh/01-export.zsh && source $XDG_CONFIG_HOME/zsh/.zshrc ;;
		zali)		$EDITOR $XDG_CONFIG_HOME/zsh/aliasesNfunctions.zsh && source $XDG_CONFIG_HOME/zsh/.zshrc ;;
		xinitrc)		$EDITOR $HOME/.xinitrc ;;
		xres)     $EDITOR $HOME/.Xresources && xrdb $HOME/.Xresources ;;
		# global
		zgenv)		sudoedit /etc/zsh/zprofile ;;
		gxinitrc)		sudoedit /etc/X11/xinit/xinitrc ;;
		gxinitrcd)		cd /etc/X11/xinit/xinirc.d/ ;;
		x11)     cd /etc/X11/xorg.conf.d/ ;;
		pgenv)		cd /etc/profile.d/ ;;
		# portage shit
		pconf)   sudoedit /etc/portage/make.conf ;;
		puse)    sudoedit /etc/portage/package.use ;;
		pworld)  sudoedit /var/lib/portage/world ;;
		hosts)		sudoedit /etc/hosts ;;
		sudo)		sudoedit /etc/sudoers ;;
		*)			echo "Unknown application: $1" ;;
	esac
}

# man piped to less
mg() {
	man $1 | less +"/$2"
}

ranger-cd() {
	# from https://github.com/hut/ranger/blob/bdd6bf407ab22782f7ddb3a1dd24ffd9c3361a8d/examples/bash_automatic_cd.sh
	# with minor modifications
	# change the directory to the last visited one after ranger quits.
	# "-" to return to the original directory.
	local tempfile
	tempfile="/tmp/ranger/chosendir"
	mkdir -p /tmp/ranger
	ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	if [[ -f $tempfile ]] && \
		[[ $(< $tempfile) != $(pwd | tr -d '\n') ]]; then
		# ranger will put full path in tempfile  (-- not needed)
		cd "$(< $tempfile)"
	fi
	rm -f "$tempfile"
}

# Tell which installed package provides a command using equery:
# user $equery b `which vim`

# Tell which (not) installed package provides a command using e-file:
# user $e-file vim
# learn about marks
# redunant packages
# eix-test-obsolete
# https://wiki.gentoo.org/wiki/User:Tillschaefer/cleanup_package
#i xrandr
# xdyinfo
# zinit issues
# zinit --help
# zinit man
# zinit self-update
# zinit times
# zinit zstatus
# zinit ls
# zinit report --all
# zinit loaded
# zinit cd,s
# zinit edit
# zinit changes
# zinit clist
# zinit compinit
# zinit srv
# export prints env variables
# set also prints shell
# typset also print type annotation
#
#  parameters only names
#  tracking shell and env variables
#  (set -o posix; set)
#  lsof listopen files good ofr tracking
#  " whoami vaernil
#  number of files?
#  lsof -u `whoami` | wc -l
#
#kmod list
# z command lets you jump to most often directiories
#
# add revdep module and other to update script
# perl cleaner
# old dist files removal etc
# maybe delete rxvt
#
# haskell-updater
# function to delete backups
#
# improve with fd and choosing set paths like vim bakcup
rmbak()
{
    typeset _opt _OPTIND _OPTARG depth="-maxdepth 1" action="-delete"
    while getopts ":rn" _opt; do
        case "$_opt" in
            r) depth='' ;;
            n) action='' ;;
            "?")
                echo >&2 "Invalid option: -$_OPTARG"
                echo >&2 "USAGE: rmbak [-rn]"
                echo >&2 "  -r recursive"
                echo >&2 "  -n print files but don't delete"
                return 1
                ;;
        esac
    done
    find . $depth -name \*~ -type f -print $action
    unset _opt
}

# to use in scripts
debug_parms() {
	# Prints script parameters.
	# Call with `debug_parms $@`
	echo "Number of params: "$#
	echo "All params: "$@
	while [ "$#" != "0" ]; do
		shift
		echo "Param: "$@
	done
}

# this is for my debugging purposes, yes, its shit, i know
stupid_join() {
	## BEST http://mywiki.wooledge.org/BashFAQ/006#Indirection
	# understand evil eval
	# -z string
   # True if the length of string is zero.local _getdate _whoami _sep
	# if nontempty then sep, else default, how to do it?
	# https://stackoverflow.com/questions/16553089/dynamic-variable-names-in-bash
# 1 eval ${ref}=\"$value\" # WRONG!
# 2 eval "$ref='$value'"   # WRONG!
# 3 eval "${ref}=\$value"  # Correct (curly braced PE used for clarity)
# 4 eval "$ref"'=$value'   # Correct (equivalent)
	eval "${ref}=\$value"  # Correct (curly braced PE used for clarity)
	_sep="::"
	# if [ -z "$1" ]; then
	#     _sep="$1"
	# fi
	[ -z "$1" ] && _sep="$1"
	# _sepfallback=":f:"
	# _sep="$_sepfallback"
	_whoami="iam=$(whoami) ${_sep} USER=${USER}"
	_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
	# todo loop that join it by itself
	# print all params?
	while [ "$#" != "0"; do
		_join+="${_sep} $@ $_sep"
		shift
	done
	JOIN="::: ${_getdate} :: d0=$0 :: #=$# :: pwd=$(pwd) :: PWD=${PWD} :::"
	# check that name is a valid variable name:
	# note: this code does not support variable_name[index]
	shopt -s globasciiranges
	[[ "$name" == [a-zA-Z_]*([a-zA-Z_0-9]) ]] || exit
	# JOIN
	name="test"
	export JOIN_${name}
	# TODO TEST
	# https://www.unix.com/shell-programming-and-scripting/51577-get-script-name.html
	#
# export SCRIPT_NAME=$(basename $0)
# https://www.golinuxcloud.com/get-script-name-get-script-path-shell-script/
# https://unix.stackexchange.com/questions/4650/determining-path-to-sourced-shell-script
# $$ pid so lsof $$ lets you track from within
# but you need +p
# lsof +p $$ from terminal lets you track that terminal, neat
# lsof -p is the same?
}

getShellName() {
	[ -n "$BASH" ] && echo ${BASH##/*/} && return
	[ -n "$ZSH_NAME" ] && echo $ZSH_NAME && return
	echo ${0##/*/}
}

getCurrentScript() {
    local result
    case "$(getShellName)" in
        bash )  result=${BASH_SOURCE[0]}
                ;;
        zsh )   emulate -L zsh
                result=${funcfiletrace[1]%:*}
                ;;
        dash | sh )
                result=$(
                    lsof -p $$ -Fn  \
                    | tail --lines=1  \
                    | xargs --max-args=2  \
                    | cut --delimiter=' ' --fields=2
                )
                result=${result#n}
                ;;
        * )     result=$0
                ;;
    esac
    echo $(realpath $result)
    # https://stackoverflow.com/questions/29832037/how-to-get-script-directory-in-posix-sh
}
# https://unix.stackexchange.com/questions/299040/custom-lsof-output
#
#  ｣ lsof -nPp 3722 | awk '{print $9}'
# lsof your_dir | awk '{for(i=9;i<=NF;++i)print $i}'

# lsof -nPp $$ | awk '{print $9}' | tail --lines=1

