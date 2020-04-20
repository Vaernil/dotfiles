#!/bin/sh

#####!/bin/dash
# https://github.com/koalaman/shellcheck/wiki/SC2046
#change to bash?
# redirect errors to a file in user's home directory if we can
# works but captures too much i think
_logerror() {
	_getdate="$(date +%Y.%m.%d-%H:%M:%S)"
	true
}

_getdate="$(date +%Y.%m.%d-%H:%M:%S)"

# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
# redirect any error output from the session to, in order of preference file in
# what does -/tmp inside expansion mean?
#
# user home directory called bspwm-vaernil-date -> file in TMPDIR called
# bspwm-vaernil-date to /tmp/
#### DISABLE FOR NOW, write proper function and save in ram, feel like it
# breaks shit
# for errfile in "${HOME}/.log/bspwm-${USER}-$_getdate" "${TMPDIR-/tmp}/bspwm-${USER}-$_getdate" "/tmp/bspwm-${USER}-$_getdate"
# do
#     if ( cp /dev/null "$errfile" 2>/dev/null )
#     then
#         chmod 600 "$errfile"
#         # redirect error to descriptor STDIN
#         exec > "$errfile" 2>&1
#         break
#     fi
# done

# there is no default
user_Xresources="${HOME}/.Xresources"
user_Xkbmap="${HOME}/.Xkbmap"
user_Xmodmap="${HOME}/.Xmodmap"

# without this the DPI is all kind of fucked up
# so it's probably about Xresources
if [ -f "${user_Xresources}" ]; then
	# xrdb -merge "${user_Xresources}"
	# load not merge?
	xrdb -load "${user_Xresources}"
fi

if [ -f "${user_Xkbmap}" ]; then
	setxkbmap "$(cat "${user_Xkbmap}")"
	XKB_IN_USE=yes
fi

# i already do set it in xorg, dismiss?
# dont dismiss lack of polish diactrics
setxkbmap pl,us

# run all system xinitrc shell scripts from /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	# what is ?
	for f in /etc/X11/xinit/xinitrc.d/?* ; do
		# if executable
		if [ -x "${f}" ]; then
			. "${f}"
		fi
	done
	unset f
fi

# * Java Fixes
# https://wiki.archlinux.org/index.php/java#Non-reparenting_window_managers_/_Grey_window_/_Programs_not_drawing_properly
# intellij won't work otherwise with bspwk
export _JAVA_AWT_WM_NONREPARENTING=1

# https://wiki.archlinux.org/index.php/java#Impersonate_another_window_manager
# breaks keybindings and other stuff
# wmname LG3D

# * Bell
# die bell
xset -b

# * Keyboard/Input
# setup keyboard layout (~/bin/rldkbd)
# rldkbd

# faster key repeat rate and shorter delay (default is 660 25)
# https://github.com/39aldo39/klfc/issues/10
# should work for tty too
xset -r 25
xset r rate 400 35

# set cursor
xsetroot -cursor_name left_ptr &

# NVIDIA fixes
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# export SXHKD_SHELL="/bin/sh"
sxhkd -c "${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc" 2>> "${HOME}/.log/sxhkd_error.log" &
# should i use dbus lanuch in this manners?
# start WM/DE with dbus
exec dbus-launch --sh-syntax --exit-with-session bspwm -c "${XDG_CONFIG_HOME}/wm/bspwm/bspwmrc" 2>>"${HOME}/.log/bspwm_error.log"
