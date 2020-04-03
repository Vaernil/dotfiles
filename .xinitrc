#!/bin/sh
#!/usr/bin/env dash

#!/bin/dash
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
for errfile in "${HOME}/.log/bspwm-${USER}-$_getdate" "${TMPDIR-/tmp}/bspwm-${USER}-$_getdate" "/tmp/bspwm-${USER}-$_getdate"
do
	if ( cp /dev/null "$errfile" 2>/dev/null )
	then
		chmod 600 "$errfile"
		# redirect error to descriptor STDIN
		exec > "$errfile" 2>&1
		break
	fi
done

# there is no default
userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
userxkbmap="$HOME/.Xkbmap"
sysresources="/etc/X11/xinit/Xresources"
sysmodmap="/etc/X11/xinit/Xmodmap"
sysxkbmap="/etc/X11/Xkbmap"

# doesn't exist at the moment
# merge in defaults
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

# merge in keymaps
if [ -f "$sysxkbmap" ]; then
	setxkbmap "$(cat "$sysxkbmap")"
	XKB_IN_USE=yes
fi

if [ -f "$userxkbmap" ]; then
	setxkbmap "$(cat "$sysxkbmap")"
	XKB_IN_USE=yes
fi


setxkbmap pl,us
# run all system xinitrc shell scripts.

# what is ?
# if [ -d /etc/X11/xinit/xinitrc.d ]; then
#     for f in /etc/X11/xinit/xinitrc.d/?* ; do
#         if [ -x "$f" ]; then
#		source "$f"
#         fi
#     done
#     unset f
# fi
# form /etc/X11
#source "$ZDOTDIR/zsh/.zshrc"
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
dunst >> "${HOME}/.log/dunstlog.log" 2>&1 &
# hotkey daemon
# set SXHKD_EXTRA_CONFIGS to empty for DE/WMs with their own keybinding config
# if [[ ! -v $SXHKD_EXTRA_CONFIGS ]]; then
#     SXHKD_EXTRA_CONFIGS="(${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc"
#     SXHKD_EXTRA_CONFIGS=+"(${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc_extra"
# fi
# table of configs then pipe to error
# sxhkd "${SXHKD_EXTRA_CONFIGS[@]}" &>> /tmp/sxhkd_"$DISPLAY".log &
sxhkd -c "${XDG_CONFIG_HOME}/wm/sxhkd/sxhkdrc" &

# daemon that disables mousepad when typing
# i- disable for x second(s) after last keypress
# k- ignore modifier keys (i.e. control left click)
# t- only disable scrolling and clicking
syndaemon -k -i 2 -d


# lockscreen script as screen saver
# pixelizes the display
# extreme as autostart
# i3lock &
# move this to some function that calls the theme so I can have theme specific wallpapers
# redshift -c ~/.config/redshift.conf &
# wallpaper
fehbg &
numlockx &
# notifications
# launch urxvt as daemon
# export imtheonruning='1'
# source /etc/zsh/zprofile
# should i use dbus lanuch in this manners?
# while true
# start WM/DE
exec dbus-launch --sh-syntax --exit-with-session bspwm -c "${XDG_CONFIG_HOME}/wm/bspwm/bspwmrc"
