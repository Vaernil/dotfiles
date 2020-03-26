#!/usr/bin/env bash

# basic panel for bspwm

# it has to be bash or it won't die

#TODO understand some of this code
# change spaces to tabs
# split charge symbol and change its sleep time to something faster
# work on popups
# not sure what name to set here
# export PANEL_WM_NAME="border-panel"
# not used, $$ is process id in bash, supposedly very unsafe and mktemp is better
# barpid="$$"
# error logging
error() {
	local sourcefile=$1
	local lineno=$2
	echo err: "$sourcefile $lineno"
}
trap 'error "${BASH_SOURCE}" "${LINENO}"' ERR

export -f error

# only one instance running
#PANEL_WM_NAME_MINE="$2"
#PANEL_WM_NAME_MINE="limebar.sh"
#export PANEL_WM_NAME_MINE="border-panel"
# export PANEL_WM_NAME_MINE1="$1"
# export PANEL_WM_NAME_MINE2="$2"
# export PANEL_WM_NAME_MINE3="$3"
#PANEL_WM_NAME_MINE="panelvaer"
# if [ "$(pgrep -cx $PANEL_WM_NAME_MINE2)" -gt 1 ] ; then
#     printf "%s\n" "The panel is already running." >&2
#     exit 1
# fi

# FIFO
FIFO="/tmp/panel_fifo"
[ -e "$FIFO" ] && rm "$FIFO"
mkfifo "$FIFO"

# EXPORTS IMPORTS
# overkill because of POSIX in case it failes its piped into a command so it's safer
PANEL_COLOR="${XDG_CONFIG_HOME}/wm/themes/panel_colors"
PANEL_CONF="${XDG_CONFIG_HOME}/wm/themes/panel_config"
#|| is the opposite: it will evaluate the right side only if the left side exit status is non-zero (i.e. false).
# so if it doesn't exist
[ ! -e "$PANEL_COLOR" ] || command . "$PANEL_COLOR"
[ ! -e "$PANEL_CONF" ] || command . "$PANEL_CONF"
# something like this for the future
#. "$NVM_DIR/nvm.sh" || echo "Sourcing $NVM_DIR/nvm.sh failed" >&2


p_workspaces() {
	desktop="1"
	ws=""
	IFS=":" read -r -a array <<< "$(bspc wm --get-status)"
	for item in "${array[@]}"
	do
		name="${item#?}"
		#if [ "$item" == "LT" ]
		if [ "$item" = "LT" ]
		then
			ws="${ws}%{S+}"
		else
			desk=""
			# ok, bspc wm --get-status produces WMLVDS:O:o:o:oo:oo:fo:fo:fo:LT:TT:G so
			# first O means occupied, then icon, so i could manipulate it to change both icons and colors
			# now knowing that i could make it look up icons and stuff, maybe?
			# R swaps background and foreground
			case $item in
				O*) # focused occupied
					desk="%{R} ${name} %{R}"
					;;
				F*) # focused free
					desk="%{R} ${name} %{R}"
					;;
				U*) # focused urgent
					desk="%{R} ${name} %{R}"
					;;
				o*) # occupied
					desk=" ${name} "
					;;
				f*) # free
					desk=" ${name} "
					;;
				u*) # urgent
					desk=" ${name} "
					;;
			esac
			shift
			if [ "$desk" != "" ]
			then
				# A is clickable area, that calls bspc to switch to desktop ^number
				ws="${ws}%{A:bspc desktop -f ^$desktop:}${desk}%{A}"
				desktop="$((desktop+1))"
			fi
		fi
	done
	# dont understand what S0 is, is it some bash parameter? cant find anything in documentation
	ws="${ws}${S0}"
	echo "${ws}"
}

p_title() {
	title=""
	#ID
	#case "$(bspc query -M -m focused)" in
	#name instead of ID
	case "$(bspc query --names -M -m focused)" in
		# gets the title from focused window, altough now it has different format, it outputs ids
		# so i either go by id or pass it through json table which has those ids
	DVI-I-1)
		# temp variable?
		title="%{S1}"
		;;
	LVDS)
		title="%{S0}"
		;;
esac
# instead of passing the output to variable just pipe it to wc -m
# command between `` executes instead of passing the string to variable
lentitle=$(xtitle | wc -m)
# I still dont know good amount, for now it's 120
if [ "$lentitle" -ge 120 ]; then
	output="%{F$c3}$(xtitle | cut -c 1-120) (...)${S0}%{F-}"
else
	output="%{F$c3}${title}$(xtitle)${S0}%{F-}"
fi
echo "$output"
# use cut -c to shorten xtitle if its longer than X characters and if it is then concatenate "(...)"
# xtitle -t NUMBER has the same effect, truncates the title, but i disliked output format
}

p_sound() {
	volume="$(amixer -q | grep -A5 Master | grep '%' | cut -d'[' -f2 | cut -d'%' -f1)"
	if [ "$volume" = 0 ]; then
		icon="🔇" #Mute
	elif [ 0 -lt "$volume" ] && [  "$volume" -lt 33 ]; then
		icon="🔈" #No Soundbar
	elif [ 33 -lt "$volume" ] && [  "$volume" -lt 66 ]; then
		icon="🔉" #One Soundbar
	else
		icon="🔊" #Three Soundbars
	fi
	echo "%{A4:amixer set Master 10%+ > /dev/null:}%{A5:amixer set Master 10%- > /dev/null:}%{A:${HOME}/.config/panel/popup_sound &:}%{B$VOL_BG}%{F$VOL_FG} $icon $volume%{F-}%{B-}%{A}%{A}%{A}"
}

p_hostname() {
	echo "%{A:${HOME}/.config/panel/notifications/pop_power &:}%{B$HOST_BG}%{F$HOST_FG}$(hostname)%{F-}%{B-}%{A}"
}

p_clock() {
	echo "%{A:${HOME}/.config/panel/popup_cal &:}%{B$CLOCK_BG}%{F$CLOCK_FG} $(date +'%d-%m-%y')%{A}%{F-}%{B-}%{B$DATE_BG}%{F$DATE_FG} $(date +'%a %H:%M') %{F-}%{B-}"
}

p_temp() {
	itemp04=""
	itemp14=""
	itemp24=""
	itemp34=""
	itemp44=""
	valtemp="$(sensors | grep "Package id 0" | cut -d'+' -f2 | head -c2)"
	if [[ 105 -gt "$valtemp" && "$valtemp" -ge 90 ]]; then
		icon="$itemp44"
	elif [[ 90 -gt "$valtemp" && "$valtemp" -ge 70 ]]; then
		icon="$itemp34"
	elif [[ 70 -gt "$valtemp" && "$valtemp" -ge 50 ]]; then
		icon="$itemp24"
	elif [[ 50 -gt "$valtemp" && "$valtemp" -ge 30 ]]; then
		icon="$itemp14"
	elif [[ 30 -gt "$valtemp" && "$valtemp" -ge 0 ]]; then
		icon="$itemp04"
	else
		icon="superdanger"
	fi
	output="%{F$c3}$icon%{F-} $valtemp°"
	echo " $output "
}

p_battery() {
	# for future: make the icon changing between states depending whether its charging or discharging, ya feel me
	icap04=""
	icap14=""
	icap24=""
	icap34=""
	icap44=""
	batcap="/sys/class/power_supply/BAT0/capacity"
	batstat="/sys/class/power_supply/BAT0/status"
	#outputs value of command to the variable
	valcap="$(cat $batcap)"
	if [[ 100 -ge "$valcap" && "$valcap" -ge 80 ]]; then
		icon="$icap44"
	elif [[ 80 -gt "$valcap" && "$valcap" -ge 50 ]]; then
		icon="$icap34"
	elif [[ 50 -gt "$valcap" && "$valcap" -ge 25 ]]; then
		icon="$icap24"
	elif [[ 25 -gt "$valcap" && "$valcap" -ge 10 ]]; then
		icon="$icap14"
	elif [[ 10 -gt "$valcap" && "$valcap" -ge 0 ]]; then
		icon="$icap04"
	else
		icon="error"
	fi
	# prepend percentage with a '+' if charging, '-' otherwise, discharging works, charging shows unknown
	#test "`cat $batstat`" = "Discharging" && echo -n '-' || echo -n '+'
	# command substitution `` does the same as $()
	# later add calulation as popup of time remaining given current draw
	test "$(cat $batstat)" = "Discharging" && symbol="-" || symbol="+"
	# print out the content (forced myself to use `sed` :P) `` makes echo execute the command $ is value of variable
	#out=`sed -n p $batcap`
	output="%{A:${HOME}/.config/panel/notifications/popitup $symbol$valcap &:}%{F$c3}$icon%{F-}%{A} $symbol$valcap "
	echo " $output "
}

# loops, they output to fifo, echo the name and contents of the function, sleep for some time to save cpu
while :; do echo "Workspaces" "$(p_workspaces)"; sleep 0.2s; done > "$FIFO" &
while :; do echo "Title" "$(p_title)"; sleep 0.5s; done > "$FIFO" &
while :; do echo "Clock" "$(p_clock)"; sleep 60s; done > "$FIFO" &
while :; do echo "Temperature" "$(p_temp)"; sleep 60s; done > "$FIFO" &
while :; do echo "Battery" "$(p_battery)"; sleep 60s; done > "$FIFO" &
while :; do echo "Hostname" "$(p_hostname)"; sleep 180s; done > "$FIFO" &
# maybe update it only if you use ssh or something?
# add pwd of focused window to the panel?
#while :; do echo "Mixer" "$(p_sound)"; sleep 30s; done > "$fifo" &

# loop that reads line looking for names set in the previous part and outputing the value to variable, so that it can be read by echo and lemonbar
# it trims the name+space, that we echoed before, so it doesnt show up as well messing up the syntax, need to think about line:# solution
while read -r line ; do
	case $line in
		Workspaces*)
			wp="${line:11}"
			;;
		Clock*)
			cl="${line:6}"
			;;
		Battery*)
			bt="${line:8}"
			;;
		Temperature*)
			tp="${line:12}"
			;;
		Title*)
			tl="${line:6}"
			;;
		Hostname*)
			hn="${line:9}"
			;;
   #     Mixer*)
   #         mx="${line:9}"
   #         ;;
	esac
echo "%{1}$wp%{c}$tl%{r}$hn$tp$bt$cl"
	#echo "%{1}$wp%{c}$tl%{r}$hn$tp$bt$cl "

#pipe fifo to lemonbar and set flags, dont understand why we're piping to sh
# i could also put above in a script and pipe from it, instead of done statement
#done < "$fifo" | lemonbar -p \

done < "$FIFO" | bar-border -n "$PANEL_WM_NAME" -p \
	-R "$panel_fg" \
	-r 0 \
	-a 20 \
	-g "$panel_geometry" \
	-o -0 -f "$panel_font1" \
	-o -1 -f "$panel_font2" \
	-o -1 -f "$panel_font3" \
	-B "$panel_bg" \
	-F "$panel_fg" | sh &

# fix, so panel isn't above fullscreen windows
# TODO UNDERSTAND
# make it less hardcoded, more modular
# xdo performs operation on windows
# -a window given name WM_NAME

# identifies on which windows is the panel running so then it ca nbe elvated
wid="$(xdo id -a "$PANEL_WM_NAME_MINE2")"
tries_left="20"
while [ -z "$wid" ] && [ "$tries_left" -gt 0 ] ; do
	sleep 0.05
	wid="$(xdo id -a "$PANEL_WM_NAME")"
	tries_left="$((tries_left - 1))"
done

if [ -n "$wid" ]; then
	xdo lower -N "$wid"
	xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"
	xdo lower -N "$wid"
fi
wait
