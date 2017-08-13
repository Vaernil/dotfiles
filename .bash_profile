# /etc/skel/.bash_profile

# enable keychain, usually ssh-agent only works for the current session, this reuses it, to test
keychain ~/.ssh/id_rsa
#eval `keychain --eval --agents ssh id_rsa`
#. ~/.keychain/${HOSTNAME}-sh
#. ~/.keychain/${HOSTNAME}-sh-gpg
#keychain id_rsa id_dsa 0123ABCD
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg
# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc
#unset -v HOME # Force bash to obtain its value for HOME from getpwent(3) on first use, so tilde-expansion is sane.
if shopt -q login_shell; then
    [[ -f ~/.bashrc ]] && source ~/.bashrc
    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
else
    exit 1 # Somehow this is a non-bash or non-login shell.
fi
