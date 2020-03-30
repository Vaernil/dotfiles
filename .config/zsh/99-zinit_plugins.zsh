#!/usr/bin/env zsh
# https://github.com/zdharma/zinit#customizing-paths
# export
# function that logs zinit's loading time
typeset -ga mylogs
zflai-msg() { mylogs+=( "$1" ); }
zflai-assert() { mylogs+=( "$4"${${${1:#$2}:+FAIL}:-OK}": $3" ); }

# export EDITOR="vim" LESS="-iRFX" CVS_RSH="ssh"

# umask 022
# setopts
#
# bindkeys
zflai-assert "${+terminfo[kpp]}${+terminfo[knp]}${+terminfo[khome]}${+terminfo[kend]}" "1111" "terminfo test" "[zshrc] "

## Modules
# zmodload -i zsh/complist

## Autoloads
# autoload -Uz allopt zed zmv zcalc colors
# colors

# autoload -Uz edit-command-line
# zle -N edit-command-line
##bindkey -M vicmd v edit-command-line

# autoload -Uz select-word-style
# select-word-style shell

# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

#url_quote_commands=(links wget youtube-dl curl); zstyle -e :urlglobber url-other-schema '[[ $url_quote_commands[(i)$words[1]] -le ${#url_quote_commands} ]] && reply=("*") || reply=(http https ftp ssh)'

# Aliases

# fpath+=( $HOME/functions )
# autoload +X zman
# functions[zzman]="${functions[zman]}"

# initialize zinit, must be above compinit
# source "$HOME/.local/lib/zinit/zinit.zsh"
# [[ ! -f ~/.zinit/bin/zinit.zsh ]] && {
#     command mkdir -p ~/.zinit
#     command git clone https://github.com/zdharma/zinit ~/.zinit/bin
# }

source "$HOME/.local/lib/zinit/zinit.zsh"
# remove?
# unless you add
# what does autoload do
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# http://zdharma.org/zinit/wiki/INTRODUCTION/
# https://github.com/zdharma/zinit#ice-modifiers
# -F function rest dunno
typeset -F4 SECONDS=0
# https://github.com/zdharma/zinit/issues/287
# ice ise required
#
# #  annexes
	# zinit-zsh/z-a-test \
zinit light-mode for \
	zinit-zsh/z-a-man \
	zinit-zsh/z-a-patch-dl \
	zinit-zsh/z-a-submods \
	zinit-zsh/z-a-bin-gem-node \
	zinit-zsh/z-a-rust

# wait without number means wait 0
# Fast-syntax-highlighting & autosuggestions
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
		zdharma/fast-syntax-highlighting \
	atload"!_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions \
	blockf \
		zsh-users/zsh-completions

## For wait'!...', prompt is reset after load.
# loads prompt if env variable MYPROMPT is equal to
# Theme no. 8 - powerlevel10k
zinit load'![[ $MYPROMPT = 1 ]]' unload'![[ $MYPROMPT != 1 ]]' \
	atload'!source $ZDOTDIR/themes/p10k.zsh; _p9k_precmd' lucid nocd for \
		romkatv/powerlevel10k

# zsh-autopair
# fzf-marks, at slot 0, for quick Ctrl-G accessibility
zinit wait lucid for \
	hlissner/zsh-autopair \
	urbainvaes/fzf-marks

# A few wait"1 plugins
#
# TODO check whether I should use gentoos portage / vimplug or what
# exa and fd are being installed via portage
# fzf via vimplug
# ogham/exa, sharkdp/fd, fzf
# zinit wait"2" lucid as"null" from"gh-r" for \
#     mv"exa* -> exa" sbin  ogham/exa \
#     mv"fd* -> fd" sbin"fd/fd"  @sharkdp/fd \
#     sbin junegunn/fzf-bin
# previous
	# easier to use `find`
	# zinit ice cloneonly wait"2" lucid from"gh-r" mv"fd* -> fd" sbin"fd/fd"
	# zinit load sharkdp/fd

# A few wait'2' plugins
zinit wait"2" lucid for \
		zdharma/declare-zsh \
		zdharma/zflai \
	blockf \
		zdharma/zui \
		zinit-zsh/zinit-console


# A few wait'3' git extensions
# zinit as"null" wait"3" lucid for \
#     sbin Fakerr/git-recall \
#     sbin paulirish/git-open \
#     sbin paulirish/git-recent \
#     sbin davidosomething/git-my \
#     sbin atload"export _MENU_THEME=legacy" \
#         arzzen/git-quick-stats \
#     sbin iwata/git-now \
#     make"PREFIX=$ZPFX"         tj/git-extras \
#     sbin"bin/git-dsf;bin/diff-so-fancy" zdharma/zsh-diff-so-fancy \
#     sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" zdharma/git-url
# powerlevel10k
#
	# Keep this below, so that this can override plugins default
	# since those are my overrides, what about nameing scheme, 100-?
	# null is an emptry hook so you can call your shit
	# make an array and source or use builtint
	# zinit ice wait lucid atload"source $ZDOTDIR/keybinds.zsh; source $ZDOTDIR/aliasesNfunctions.zsh; source $ZDOTDIR/options.zsh;source /etc/zsh/zprofile"
	zinit ice wait lucid atload"source $ZDOTDIR/keybinds.zsh; source $ZDOTDIR/aliasesNfunctions.zsh; source $ZDOTDIR/options.zsh"
	zinit load zdharma/null

zflai-msg "[zshrc] Zplugin block took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

MYPROMPT=1
# Load within zshrc – for the instant prompt
# Themes p10k
zinit ice depth=1 atload"!source $ZDOTDIR/themes/p10k.zsh" lucid nocd
zinit load romkatv/powerlevel10k

zflai-msg "[zshrc] Finishing, loaded custom modules: ${(j:, :@)${(k)modules[@]}:#zsh/*}"
# touse
# https://github.com/dotiful/dotdrop/blob/21ba2a949e5140de81402a937bfa5500edfc793d/dotfiles/zsh/zinit.zsh
#
# used
# https://github.com/zdharma/zinit-configs/blob/3218f7f9c601d035a1ca732d2ae8b09aa72ffdb5/psprint/zshrc.zsh#L505
# # this one seems cool
# https://github.com/zdharma/zinit-configs/blob/master/NICHOLAS85/.zshrc
# vim: foldmethod=marker
