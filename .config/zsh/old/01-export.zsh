# export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nu rnu noma' -\""
#TEMPORARY FOR TESTS

# source "$HOME/.zshenv"
# source "/etc/zsh/zprofile"
# source "$HOME/80-xdg-respect"

# export DOTFILE="$HOME/_dotfiles"
	# noidea
# export ERL_AFLAGS="-kernel shell_history enabled"

# Better transition for changing of vim mode in terminal
# export KEYTIMEOUT=1
# export FAST_ALIAS_TIPS_PREFIX="\x1b[33;40m ﯦ  \x1b[0m $(tput bold)"
# }}}

# vim: foldmethod=marker
######## █▓▒░ Respect XDG ░▒▓█ {{{

# do i need shebang?
# ShellCheck
# export SHELLCHECK_OPTS="--shell=zsh --exclude=SC2016"
# export SHELLCHECK_OPTS=""
# unset SHELLCHECK_OPTS
# zsh
# export ZSH_CACHE_DIR="${CACHE_DIR}"

# zinit

# super important, sets the XDG_CONFIG_HOME so the files in xdg-respect can
# follow, previously in .zshrc

# if [[ -z "$XDG_CONFIG_HOME" ]]
# then
#     export XDG_CONFIG_HOME="$HOME/.config"
# fi

# if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
# then
#     export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# fi

# not sure if needed, move somewhere else


#if zsh
#export XDG_CONFIG_HOME="$HOME/.config"
#
## ZSH
#export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
#
##??!?
## not sure if unset
## ZINIT
#unset ZINIT
#declare -A ZINIT
#export ZINIT[BIN_DIR]="$HOME/.local/bin/zinit"
#export ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
#export ZINIT[PLUGINS_DIR]="$XDG_DATA_HOME/zinit/plugins"
#export ZINIT[SNIPPETS_DIR]="$XDG_DATA_HOME/zinit/snippets"
#export ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zcompdump"
# unset ZINIT

# z.lua
#export _ZL_DATA="$XDG_DATA_HOME/zsh/z.lua"

# history should it be here? at least do shell check
export HISTSIZE=9999999999
# savehist is bash thing
export SAVEHIST="${HISTSIZE}"
export HISTORY_IGNORE="(ls|exa|cd|pwd|exit|cd|\ls --color=tty -la|\ls --color=tty|nvim|gitk)"
# no duplicate entries
export HISTCONTROL="ignoredups:erasedups"
export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"

# .dotfiles
export DOTFILE="$HOME/_dotfiles"

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/rg.conf"


# ncurses something wrong with urxvt
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# THEMES
# GTK
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# setting qt5 variables and shit
# export QT_QPA_PLATFORMTHEME="qt5ct"
# export QT_PLATFORMTHEME="qt5ct"
# export QT_PLATFORM_PLUGIN="qt5ct"
# export QT_STYLE_OVERRIDE="adwaita-dark"
# bspwm panel
export PANEL_FIFO="/tmp/panel-fifo"

# BINARIES AND MANAGERS
# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
# runtime, careful
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"
export NODE_PATH="$NPM_CONFIG_CACHE/node_modules"
export NODE_REPL_HISTORY="$NPM_CONFIG_CACHE/node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"

# Go
export GOPATH="$XDG_CONFIG_HOME/go"

# PROGRAMS
# vim
export MYVIMRC="$XDG_CONFIG_HOME/vim/.vimrc"
export VIMINIT="source $MYVIMRC"
# VS?
# export VIMINIT="source ${MYVIMRC}"

# pqiv
export PQIVRC_PATH="$XDG_CONFIG_HOME/pqiv/pqivrc"

# }}}

# vim: foldmethod=marker
# just source
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# sems that i misunderstood rg
# FZF_DEFAULT_OPTS="--height 20% --border --layout=reverse --inline-info --preview='bat --color=always {}' "
# fzf colors:
# - fg      Text
# - bg      Background
# - hl      Highlighted substrings
# - fg+     Text (current line)
# - bg+     Background (current line)
# - gutter  Gutter on the left (defaults to bg+)
# - hl+     Highlighted substrings (current line)
# - info    Info
# - border  Border of the preview window and horizontal separators (--border)
# - prompt  Prompt
# - pointer Pointer to the current line
# - marker  Multi-select marker
# - spinner Streaming input indicator
# - header  Header
FZF_DEFAULT_OPTS="--height 50% --border --layout=reverse --inline-info "
FZF_DEFAULT_OPTS+="--preview 'bat --style=numbers --color=always {} | head -400' "
FZF_DEFAULT_OPTS+="--color=fg:14,bg:0,hl:7,fg+:#ffffff,bg+:8,hl+:2,info:11,prompt:14,spinner:2,pointer:#ffffff,marker:4 "
FZF_DEFAULT_OPTS+="--bind=ctrl-i:up "
FZF_DEFAULT_OPTS+="--bind=ctrl-k:down "
FZF_DEFAULT_OPTS+="--bind 'ctrl-o:execute(nvim {})' "
FZF_DEFAULT_OPTS+="--bind 'ctrl-O:execute(mpv {})+abort' "
FZF_DEFAULT_OPTS+="--bind=ctrl-t:toggle-preview "
FZF_DEFAULT_OPTS+="--bind 'ctrl-r:execute(open -R {})+abort' "
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500' "
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS"
export FZF_ALT_C_OPTS="--preview 'exa -ah --git --tree -L2 --icons --color=always {} | head -400' "
# completion trigger from **
export FZF_COMPLETION_TRIGGER="**"
# bat doesnt work always redo
