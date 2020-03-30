#!/usr/bin/env zsh
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

# source "/etc/zsh/zprofile"
# https://github.com/zinit-zsh/z-a-bin-gem-node#z-a-bin-gem-node
#
# make a file with most of your configs zsh, zinit, themes, file manager, vim,
# the works, put it in your cf function and also list it in rofi to enumerete
# and run
# cd .local/share/zinit/
# think about location for zinit
# easy way for ls colors
# TODO understand zplugin and ruby gem node and shit
# also ZPFX and that other thing
# # Load a few important annexes, without Turbo
# (this is currently required for annexes)
# https://zdharma.github.io/2019-10-27/Installing-Gems-And-Node-Modules-With-Zinit
zinit light-mode for \
	zinit-zsh/z-a-patch-dl \
	zinit-zsh/z-a-as-monitor \
	zinit-zsh/z-a-bin-gem-node
# clean this file
# ???
zinit snippet OMZ::lib/theme-and-appearance.zsh
# zplugin load zdharma/zui
# Themes p10k
zinit ice depth=1 atload"!source $ZDOTDIR/themes/p10k.zsh" lucid nocd
zinit load romkatv/powerlevel10k

# zinit extensions shimmy and shit is it installed by gentoo?
# shouldnt it be the very first?
zinit load zinit-zsh/z-a-bin-gem-node

# Turbo MODE {{{

# turbo and for syntax
# https://github.com/zinit-zsh/zinit-console
zinit wait lucid for zinit-zsh/zinit-console
zinit load zdharma/zui
	# Used by OMZ vi-mode
	zinit wait lucid for OMZ::lib/clipboard.zsh

	# TODO: waiting for PR to be merge. https://github.com/ohmyzsh/ohmyzsh/pull/8004
	zinit ice wait lucid
	zinit snippet "https://github.com/erydo/oh-my-zsh/blob/vi-mode/plugins/vi-mode/vi-mode.plugin.zsh"

	# yank to clipboard in vim mode
	zinit ice wait lucid
	zinit snippet "https://github.com/kutsan/zsh-system-clipboard/blob/master/zsh-system-clipboard.zsh"

	# add widgets
	# not sure if needed
	zinit wait lucid
	zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"

	# expand alias
	zinit wait lucid for OMZ::plugins/globalias/globalias.plugin.zsh

	# install additional completions
	zinit ice wait lucid blockf atpull"zinit creinstall -q ."
	zinit load zsh-users/zsh-completions

	zinit ice wait as"completion" lucid
	zinit snippet OMZ::plugins/docker/_docker

	zinit wait lucid for atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

	# TODO: ?????????????
	# z most frequent places
	zinit ice wait lucid
	zinit snippet OMZ::plugins/z/z.sh
	if [[ -z $(which lua) ]]; then
		echo "lua executable missing"
	else
		zinit ice as"null" atload'eval "$(lua z.lua --init zsh enhanced once fzf)"'
		zinit load https://github.com/skywind3000/z.lua
	fi

	# add ending brackets
	zinit wait lucid for hlissner/zsh-autopair

	# ????
	zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
	zinit load zdharma/fast-syntax-highlighting

	# Keep this below, so that this can override plugins default
	# since those are my overrides, what about nameing scheme, 100-?
	# null is an emptry hook so you can call your shit
	# make an array and source or use builtint
	# zinit ice wait lucid atload"source $ZDOTDIR/keybinds.zsh; source $ZDOTDIR/aliasesNfunctions.zsh; source $ZDOTDIR/options.zsh;source /etc/zsh/zprofile"
	zinit ice wait lucid atload"source $ZDOTDIR/keybinds.zsh; source $ZDOTDIR/aliasesNfunctions.zsh; source $ZDOTDIR/options.zsh"
	zinit load zdharma/null
			# }}}

# Command {{{
# prettier git diff, use `git dsf` to trigger
zinit ice as"null" wait"2" lucid sbin"bin/git-dsf;bin/diff-so-fancy"
zinit load zdharma/zsh-diff-so-fancy

	# already have it?
	# easier to use `find`
	zinit ice cloneonly wait"2" lucid from"gh-r" mv"fd* -> fd" sbin"fd/fd"
	zinit load sharkdp/fd

	# what does it do?
	# activate later
	# zinit ice cloneonly wait"2" lucid from"gh-r" mv"cheat* -> cheat" sbin"cheat"
	# zinit load cheat/cheat

	# for raspberry, fzf need bpick *arm8*
	# zinit ice cloneonly bpick"*arm8*" from"gh-r" sbin"g:fzf -> fzf"

	# should it be here and in vimrc? does it share binary?
	zinit ice cloneonly from"gh-r" sbin"g:fzf -> fzf"
	zinit load junegunn/fzf-bin

	# shows aliases of a command
	## seems its super useless as zsh expands my aliases so it always shows ,
	#lol
	# zinit wait"2" lucid for \
	#     from'gh-r' sbin"def-matcher" sei40kr/fast-alias-tips-bin \
	#     sei40kr/zsh-fast-alias-tips
			# }}}

# Loaded on-demand {{{
# Least frequently used
zinit trigger-load'!extract' for OMZ::plugins/extract/extract.plugin.zsh
# }}}

# zplugin ice as"program" pick"$ZPFX/sdkman/bin/sdk" id-as'sdkman' run-atpull \
#   atclone"wget https://get.sdkman.io -O scr.sh; SDKMAN_DIR=$ZPFX/sdkman bash scr.sh" \
#   atpull"SDKMAN_DIR=$ZPFX/sdkman sdk selfupdate" \
#   atinit"export SDKMAN_DIR=$ZPFX/sdkman; source $ZPFX/sdkman/bin/sdkman-init.sh"
# zplugin light zdharma/null
#
# vim: foldmethod=marker
