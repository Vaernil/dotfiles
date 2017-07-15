source /etc/profile
source /usr/share/powerline/bash/powerline.sh
#source /etc/profile.d/bash_completion.sh
#DO NOT USE RAW ESCAPES, USE TPUT
bold=$(tput bold)
reset=$(tput sgr0)
red=$(tput setaf 1)
blue=$(tput setaf 4)
green=$(tput setaf 2)
PS1='${bold}\[$green\]\u@\[$reset\]${bold}\[$green\]\h\[$reset\] ${bold}\[$blue\]\w \$\[$reset\] '
PS1='\[${bold}\]\[${green}\]\u@\h\[${reset}\] \[${bold}\]\[${blue}\]\w \$\[${reset}\] '
# export PATH="/home/vaernil/.dotfiles"
export PATH="/usr/non-portage/bin:${PATH}"
export PANEL_FIFO="/tmp/panel-fifo"
export PATH="$PATH:/home/vaernil/.config/bspwm/panel"
#nie tak, bo za kazdym otworzeniem urxvt sie odpala
#if [ -f /usr/bin/screenfetch ]; then screenfetch; fi
[[ $(tty) = "/dev/tty1" ]] && exec startx
