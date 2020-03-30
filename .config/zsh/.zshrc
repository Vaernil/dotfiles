#!/usr/bin/env zsh
#
_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
_name="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1)" 2>/dev/null
_namedot="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1 | tr '/ .' '_')" 2>/dev/null
unset JN__zdzshr
JN__zdzshr="::: ${_getdate} :: d0=${0} : #=${#} :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
export JN__zdzshr
unset _getdate _name _namedot

# unset ZINIT
declare -A ZINIT
export ZINIT[BIN_DIR]="$HOME/.local/bin/zinit"
export ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
export ZINIT[PLUGINS_DIR]="$XDG_DATA_HOME/zinit/plugins"
export ZINIT[SNIPPETS_DIR]="$XDG_DATA_HOME/zinit/snippets"
export ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zcompdump"
export ZINIT[COMPLETIONS_DIR]="$XDG_DATA_HOME/zinit/completions"
export _ZL_DATA="$XDG_DATA_HOME/zsh/z.lua"

# Flags {{{
# https://www.reddit.com/r/zsh/comments/877oty/how_to_improve_shell_loading_times/
# PERF=false
# }}}

#temp fix
# source /etc/zsh/zprofile
# include all files in .config/zsh folder
# loads only .zsh files with 00-99 prefix
# tho the other guy puts it in plugins
#shopts=$-
#setopt nullglob
#for sh in /etc/profile.d/*.sh ; do
#	[ -r "$sh" ] && . "$sh"
#done
#unsetopt nullglob
#set -$shopts
#unset sh shopts
#shopts=$-
#setopt nullglob
##if [[ -d "${ZDOTDIR}" ]]; then
#	for f in "${ZDOTDIR}/"<00-99>-*".zsh" ; do
#		[[ -r "$f" ]] && source "$f"
#		# count sourced later
#		# typeset -A _SOURCED_RC
#		# _SOURCED_RC+=
#	done
#	unset f
##fi
#
#unsetopt nullglob
#set -$shopts
##unset zsh shopts
#

source "${ZDOTDIR}/99-zinit_plugins.zsh"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#source "${HOME}/.zpath"
# add .zshenv and 80-xdg
# why is it set
# setopt autopushd

# maybe the other approach would be better? the one where you append it to array and then loop over it
#typeset -ga sources

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.

# diagnostic, change it later
# if [ $PERF = true ]; then
#     zmodload zsh/zprof
# fi
# seems that cache dir is set later so this shit doesnt work
# check zinit update once a day
# ZINIT_UPDATE_FILE="${CACHE_DIR}/.zinit_last_update"
#ZINIT_UPDATE_FILE="${XDG_CACHE_HOME}/.zinit_last_update"
#if [[ -n "${TMUX}" && ! -f "${ZINIT_UPDATE_FILE}"(#qN.mh-22) ]]; then
#	read answer"?Update zinit and plugins? [Y/n]: "
#	if [ "${answer}" = "" -o "${answer#[Yy]}" != "${answer}" ]; then
#		zinit self-update
#		zinit update
#		touch "${ZINIT_UPDATE_FILE}"
#	fi
#fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
