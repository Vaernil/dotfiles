sh ~/.scripts/fehbg &
# if Xresources exists then merge
[[ -f ~/.Xresources ]] && xrdb -merge ${HOME}/.Xresources
numlockx &
# xbindkeys &
#exec bspwm "$PANEL_FIFO" -p W -c ${HOME}/.config/bspwm/bspwmrc
# i dont get -p flag
exec bspwm -p W -c ${HOME}/.config/bspwm/bspwmrc
