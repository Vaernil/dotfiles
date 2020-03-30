#!/usr/bin/env dash

_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
_name="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1)"
_namedot="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1 | tr '/ .' '_')"
unset JN__zdlogi
JN__zdlogi="::: ${_getdate} :: d0=${0} : #=${#} :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
export JN__zdlogi
unset _getdate _name _namedot
# is only sourced if we are a login shell
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return

	source ${HOME}/.zpath
	source ${ZDOTDIR}/.zshrc
	[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
fi

#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.
#if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
#    source ${HOME}/.zpath
#fi


# if [[ -o rcs ]]; then
#     export ZDOTDIR="$HOME/.config/zsh"
# fi
