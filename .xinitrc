sh ~/.fehbg &
[[ -f ~/.Xresources ]] && xrdb -merge ${HOME}/.Xresources
numlockx &
xbindkeys &
exec bspwm "$PANEL_FIFO" -p W -c ${HOME}/.config/bspwm/bspwmrc
