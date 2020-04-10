#!/bin/sh

# . /home/vaernil/supertest
# ./supertest
#
#add shell later

_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
_name="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1)" 2>/dev/null
_namedot="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1 | tr '/ .' '_')" 2>/dev/null
unset JN__zden0s
JN__zden0s="::: ${_getdate} :: d0=${0} : #=${#} :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
export JN__zden0s
unset _getdate _name _namedot

# only source if the SHLVL is 1 to avoid overwrtiting environment
if [[ $SHLVL == 1 ]]; then
	source ${HOME}/.zpath

	unset JN__zden1u
	JN__zden1u="::: ${_getdate} :: d0=${0} : #=${#} :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
	export JN__zden1u

	_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
	_name="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1)" 2>/dev/null
	_namedot="$(lsof -e /run/user/1000 -nPp $$ | awk '{print $9}' | tail --lines=1 | tr '/ .' '_')" 2>/dev/null
	unset JN__zden1s
	JN__zden1s="::: ${_getdate} :: d0=${0} : #=${#} :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
	export JN__zden1s
	unset _getdate _name _namedot
fi

#if [[ $SHLVL == 1 && ! -o LOGIN ]]; then

# if [[ -o rcs ]]; then
#     export ZDOTDIR="$HOME/.config/zsh"
# fi
