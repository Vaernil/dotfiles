#setting fonts, even though i already did it in xorg conf.d
#xset +fp /usr/share/fonts/Hasklig
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec bspwm
