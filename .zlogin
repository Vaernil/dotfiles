_getdate="$(date +%Y.%m.%d-%H:%M:%S.%6N)"
_name="$(lsof -nPp $$ 2>/dev/null | awk '{print $9}' | tail --lines=1)"
unset JN__zdlogi
JN__zdlogi="::: ${_getdate} :: d0=$0 : #=$# :: pwd=$(pwd) : PWD=${PWD} :: name=${_name} :::"
export JN__zdlogi
unset _getdate _name
# is only sourced if we are a login shell
# should this be = l?
# isn't zshenv sourced before this? and because of that it should be in the
# correct ZDOTDIR folder which is .config/zsh/
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return

	# not sure about those sources
	source ${HOME}/.zpath
	source ${ZDOTDIR}/.zshrc
	[[ -t 0 && $(tty) == /dev/tty1 && ! ${DISPLAY} ]] && exec startx
fi

#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.
#if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
#    source ${HOME}/.zpath
#fi


# if [[ -o rcs ]]; then
#     export ZDOTDIR="$HOME/.config/zsh"
# fi

# vim: ft=sh
