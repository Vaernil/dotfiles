#!/bin/bash

#!/bin/sh
# debug
set -x
# not POSIX because of variable expansion for now
# it might never be posix
################################################################################
# bspwm: external_rules_command
#
# Absolute path to the command used to retrieve rule consequences.
# The command will receive the following arguments: window ID, class
# name, instance name, and intermediate consequences. The output of
# that command must have the following format: key1=value1
# key2=value2 ...  (the valid key/value pairs are given in the
# description of the rule command).
#
# Rule
#    General Syntax
# 	   rule COMMANDS
#
#    Commands
# 	   -a, --add (<class_name>|*)[:(<instance_name>|*)] [-o|--one-shot]
# 	   [monitor=MONITOR_SEL|desktop=DESKTOP_SEL|node=NODE_SEL]
# 	   [state=STATE] [layer=LAYER] [split_dir=DIR] [split_ratio=RATIO]
# 	   [(hidden|sticky|private|locked|marked|center|follow|manage|focus|border)=(on|off)]
# 	   [rectangle=WxH+X+Y]
# 		   Create a new rule.
#
# 	   -r, --remove
# 	   ^<n>|head|tail|(<class_name>|*)[:(<instance_name>|*)]...
# 		   Remove the given rules.
#
# 	   -l, --list
# 		   List the rules.
################################################################################
#  $1, $2, $3, ... are the positional parameters.
# "$@" is an array-like construct of all positional parameters, {$1, $2, $3 ...}.
# "$*" is the IFS expansion of all positional parameters, $1 $2 $3 ....
#  $# is the number of positional parameters.
#  $- current options set for the shell.
#  $$ pid of the current shell (not subshell).
#  $_ most recent parameter (or the abs path of the command to start the current shell immediately after startup).
#  $IFS is the (input) field separator.
#  $? is the most recent foreground pipeline exit status.
#  $! is the PID of the most recent background command.
################################################################################
{
# dALL="${@}"
dALL=( "$@" )
dALLa="$*"
dNO="$#"
dOPTS="$-"
dPIDs="$$"
dDASH_="$_"
dIFS="${IFS}"
dPIPE="$?"
dPIDb="$!"
################################################################################
# bspwm variables
# those are local variables that i change later
# im emptying them here
# seems fucked, i could probably iterate over them and shift
border=""
center=""
class="$2"
desktop=""
focus=""
follow=""
hidden=""
id="$1"
instance="$3"
layer=""
locked=""
manage=""
marked=""
monitor=""
node=""
private=""
rectangle=""
split_dir=""
split_ratio=""
state=""
sticky=""
urgent=""
# unset border center desktop focus follow hidden layer locked manage marked \
#     monitor node private rectangle split_dir split_ratio state sticky urgent
# always name of this scripts
# _testd0="$0"
_testd1="$1"
_testd2="$2"
_testd3="$3"
_testd4="$4"
# _testd5="$5"
# so $4 is a string containing all the flags and variables
# $5 doesn't exists and never will
}
# } >"${HOME}/.log/brules_param.log" 2>&1

# xwininfo -all or -wm to get type, or xprop not xdotool


# TODO consolidate, group by category, don't split it down to per app
# if no window ID and options are give, it apples to the focused window
# if called in dunst, does it print dunst's id?
# make it outisde function and global script later
# do daemons subproccesses dont have pids?

wmhelp() {
	# copy id
	# they stay the same
	# would they ever differ?
	_id="${id}"

	# this doesnt seems to work, is it because its background only?
	_pidlast="$!"
	# it doesnt record the bashpid since it wasnt run at the time of this, hmm
	# also its equal to $$
	# _bashpid="${BASHPID}"
	_wmid="$(xdo id)"
	_wmid2="$(xdo id "${id}")"
	# if called from dunst they show pid of what that notification si for, ie
	# term
	_wmpid="$(xdo pid)"
	_wmpid2="$(xdo pid "${id}")"
	# _wmpid3="$(xdo pid "${_id}")"
	# arguments
	case "$1" in
		(--echo)
			echo "x.id    = ${_wmid} | x.pid    =  ${_wmpid}"
			echo "x.id.id = ${_wmid2} | x.pid.id = ${_wmpid2}"
		;;
		# returns value
		(--pid1)
			_cmd="$(xdo pid)"
		;;
		(--pid2)
			_cmd="$(xdo pid "${id}")"
		;;
		(--pid3)
			_cmd="$(xdo pid "${_id}")"
		;;
	esac
		echo "${_cmd}"
	# so basically if called without option it prints it for the notification
	# window itself and with option it prints it for the function its
	# referencing, so like the just spawned app
	# xdo close _id should close the app that i just tried to spawn, right?
	# and it does

	# close the focued window, in tests it closed terminal, maybe because
	# notification doesnt steal the focus
	# xdo close
	# can i add timer to that?
	# wait 2s
	# xdo close "${id}"
	# echo "${_wmpid}"
	# _wmid="$(xdo id)"
}

# dunst default urgency
_send_notification="1"
d_urgency="normal"
# d_urgency="critical"

_get_hints() {
	case "$1" in
		(--icon)
			_result="$(xprop -id "${id}" | awk '/^WINDOW_ICON_NAME/{print $3}')"
		;;
		(--name)
			_result="$(xprop -id "${id}" | awk '/^WM_NAME/{print $3}')"
		;;
		(--role)
			_result="$(xprop -id "${id}" | awk '/^WM_WINDOW_ROLE/{print $3}')"
		;;
# _NET_WM_WINDOW_TYPE(ATOM) = _NET_WM_WINDOW_TYPE_DIALOG
		(--type)
			_result="$(xprop -id "${id}" | awk '/^_NET_WM_WINDOW_TYPE/{print $3}')"
		;;
		(*)
			return
		;;
	esac
	# i'm getting double quotes either remove with tr -d "
	# or better remove using shell
	# remove quotes
	echo "${_result//\"}"
}
## apps {{{
# maybe set once and forget? its just init thats important in browser cases

	## browser
	firefox() {
		# worked first try, nice
		# though i feel like dialog is more universal so type, not role
		# _role="$(_get_hints --role)"
		_type="$(_get_hints --type)"
		case "${_type}" in
			# (GtkFileChooserDialog|Popup)
			(_NET_WM_WINDOW_TYPE_DIALOG)
				desktop=""
				# follow="on"
				focus="on"
			;;
			(*)
				desktop="^9"
			;;
		esac
	}

	chrome() {
		desktop="^2"
		follow="off"
	}

	chromium() {
		desktop="^2"
	}

	qutebrowser() {
		desktop="^0"
	}

	# games
	# todo make friend window floating, whole desktop fullscreen?
	steam() {
		desktop="^3"
	}

	# text
	libreoffice() {
		state="tiled"
		layer="normal"
	}

	# media
	mpv() {
		state="floating"
		layer="normal"
		# wm_cardinal="NE"
		# wmhelp
		# desktop=^10;
		# state="tiled"
		# state="pseudo_tiled"
	}

	spotify() {
		desktop="^4"
	}

	# image
	feh() {
		desktop="^10"
		state="tiled"
		layer="normal"
	}

	pqiv() {
		# desktop=^10;
		rectangle="800x800+0+20"
		state="floating"
		# state="pseudo_tiled"
		# state="tiled"
		# layer=normal
		layer="above"
	}

	gimp() {
		# mixed floating and tiled
		state="floating"
		follow="on"
	}

	# file manager
	nemo() {
		desktop="^10"
		state="tiled"
	}

	ranger() {
# rename for the sake of notifications
# remember it doesn't really set it for WM it's just internal notification
# variable atm
# and $instance.$class = ${3}.${2}
# will show you the truth, right side is actual instance.class
		# class="ranger"
		# instance="ranger"
		# i could like capture active windows pwd or something, so many
		# possibilites
		# i could also control dunst via its arguments , no need for _send_notification
		# if i can just disable it altogether
		# to rething
		d_urgency="normal"
	}

_rect() {
	# rectangle="300x200+10+21"
	# shellcheck disable=SC1072,SC1073,SC1090,SC2154
	. "${HOME}/.config/wm/themes/wm_numixlike"
	# shellcheck disable=SC1072,SC1073,SC1090,SC2154
	_bd="${brd_w}"
	_x="$((1920-_bd*2))"
	_y="$((1080-_bd*2))"
	_xset="0"
	# equal to panel height
	_yset="20"
	_full="${_x}x${_y}+${_xset}+${_yset}"
	# value
	# default 100%
	_p="100"
	if [ -z "$2" ]; then
		# %
		_p="$2"
	fi
	# round up
	_x="$(( (_p*_x+99) / 100 ))"
	_y="$(( (_p*_y+99) / 100 ))"
	# offset, position
	# NW|NN|NE
	# WW|CC|EE
	# SW|SS|SE
	case "${1}" in
		([Nn])
			_yset=20
		;;
		([Ss])
			_yset=20
		;;
		([Ww])
		;;
		([Ee])
		;;
	esac

	echo "${_result}"
	# return gives it back to shell not the function that called it
	# return "${_full}"
	echo "${_full}"
	_result="{}"
	# echo "${x}x${y}+${xset}+${yset}"
}
	# audio
	pavucontrol() {
		rectangle="$(_rect)"
		# desktop=^1;
		state="floating"
		# hidden="on"
	}

	# utility
	keepassxc() {
		# tdrop
		# tdrop -am -n q50south --class=quake50Skp keepassxc
		# desktop="^9"
		state="floating"
		# hidden="on"
		# sticky="on"
	}

	# chat
	discord() {
		desktop="^4"
		state="tiled"
		follow="off"
	}

	# terminals
	alacritty() {
		_send_notification="$1"
		# desktop="^4";
		# follow=off;
		# change it to tile, consolidate and make it sane
		# seems that without it it sometimes inherits flaoting for some reason
		# to investigate
		# state="floating"
	}

	kitty() {
		state="floating"
		# state="$instance"
	}
# }}}

########
term() {
	_send_notification="$1"
	_state="$2"
	case "${_state}" in
		-[Ff]|--float|--floating)
			state="floating"
		;;
		-[Pp]|--psuedo*)
			state="pseudo_tiled"
		;;
		-[Tt]|--tiled*)
			state="tiled"
		;;
		# every other case default to null because tdrop interferes with it
		(*)
			state=""
		;;
	esac
}

term_f() {
	state="floating"
}
# is there better way than rectangle?
quakeNWtest() {
	rectangle="300x200+10+21"
	state="floating"
	# -g, --rectangle WxH+X+Y
	#     Set the rectangle of the selected monitor.
}

floatNW() {
	# make external function that gathers monitor information
	rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
	state="floating"
}

# i can set my own properties
# xprop -format MY_ATOM_NAME 8s -set MY_ATOM_NAME "my_value7"
# or wmctrl
# maybe pass it through a few functions? reuse code and simplify
quake50S() {
	rectangle="$((1920-2))x$((1080/2-20-2))+0+$((1080/2+20))"
	state="floating"
}

# hardcoded for now, turn into function or script
quake() {
	# unset rectangle
	case $1 in
		(-[Nn][Ww])
			rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
			;;
		(*)
			rectangle=""
			;;
	esac
	state="floating"
}
#####
# just testing how to collect other function variables and information?

# utilize TRAP and make error function
# use unset or something for _NET_WM
# bspc subscribe reports state of bspwm
# debug doesnt work with app name
#
# you can name instance via tdrop with -n
# ranger gets class from terminal
# notify-send appname
# call function in case of class eq to
# order matters, it executes first found match
# dunst is called, libnotify works, how would i use my wrapper? from inside
# dunstrc? or could i call it here?

# stupid debug function, its stupid
_wm_notify_debug() {
	wm_notify -a "${class}" -i "${d_icon}" "[summary]" "[body]"
	wm_notify "$@"
	exit 0
}
# or instead of some contrieved if logic to control gtkfilechooser you could
# just remove the rule either by uptime so it only works on those spawning
# windows
# {{{
case "${instance}.${class}" in
	# (*.Dunst) _wm_notify_debug "$@" ;;
	# (*.[Dd]unst*) _wm_notify_debug "$@" ;;
	(quakenvim.*) term 1 -f ;;
	(*.qsouth) term 1 -f ;;
	# position flags
	(NW_f_quake.*) quake -NW "$@" ;;
	(quake50S.*) quake50S ;;
	# (term_f.*) term_f ;;
	(term_f.*) term 1 -f ;;
	(*.[Rr]anger) ranger ;;
	(instancetest.*) quakeNWtest ;;
	# should set the position as parameters to function or call external
	# program,
	# (*.[Kk]ee[Pp]ass[Xx][Cc]) quake50S ;;
	(*.[Kk]ee[Pp]ass[Xx][Cc]) keepassxc;;
	# apps
	(*.Chromium) chromium ;;
	(*.Google-chrome) chrome ;;
	(*.[Ff]irefox) firefox ;;
	# (*.[Ff]irefox) firefox; _wm_notify_debug "$@" ;;
	(*.[Ss]team) steam ;;
	([lL]ibre[oO]ffice*) libreoffice ;;
	(*.Nemo) nemo ;;
	(*.mpv) mpv ;;
	(*.Spotify) spotify ;;
	# somehow here it doubles notificiation and kitty goes through, how?
	# unless i return after the function
	# media
	# seems that because of passing the arguments it gets doubled in logs
	(*.[Pp]qiv) floatNW "$@" ;;
	(*.feh) feh ;;
	(*.Gimp) gimp ;;
	(*.discord) discord ;;
	# (*.[Pp]avucontrol) pavucontrol ;;
	# terminals
	# whoa, because im calling it with $@ im sending the scripts parameters to
	# the function, i didnt realize it works like that so i can see window id
	# and class
	# but that just gave me more questions than answers
	# (*.[Aa]lacritty) _wm_notify_debug "$@" ;;
	# (*.[Aa]lacritty) alacritty 1 ;;
	# (*.[Aa]lacritty) _wm_notify_debug ;;
	(*.[Aa]lacritty) term 0 -t ;;
	(*.[Kk]itty) kitty ;;
	(*.[Ss]t-256color) term 0 ;;
	# other cases and then use ps to search for pid
	# use ps -p to select by pid that you get by running xdo pid and id command
	# -o comm= are formatting options, in ths case it prints only the name
	# (cmd) of that
	# pid
	(.)
		case $(ps -p "$(xdo pid "$id")" -o comm= 2>/dev/null) in
			(spotify) spotify ;;
		esac;;
	*)
		# debugging
		# check if it came through this case
		_inrules="NO"
		# _wm_notify_debug "$@"
		# _send_notification=0
		# state=$instance
	;;
esac
# esac >"${HOME}/.log/brules_case.log" 2>&1
# so how the fuck does it work since im stealing stdout??

# seems like if i don't set it its null, because of the earlier set? how to
# show current?
# }}}
# _send_notification="0"
_main() {
	# copy them for debuggin sake
	# why $0 equals script name and not function name?
	# _d0="$0"
	# _td0="${_testd0}"
	_td1_I="${_testd1}"
	_td2_c="${_testd2}"
	_td3_i="${_testd3}"
	_td4_A="${_testd4}"
	# _td5_0="${_testd5}"
	# params
	# location
	# program functions
	# case
	# notif

	# ${parameter:+word}
	# Use Alternate Value. If 'parameter' is null or unset, nothing is substituted, otherwise 'word' (which may be an expansion) is substituted.
	echo \
		${border:+"border=$border"} \
		${center:+"center=$center"} \
		${desktop:+"desktop=$desktop"} \
		${focus:+"focus=$focus"} \
		${follow:+"follow=$follow"} \
		${hidden:+"hidden=$hidden"} \
		${layer:+"layer=$layer"} \
		${locked:+"locked=$locked"} \
		${manage:+"manage=$manage"} \
		${marked:+"marked=$marked"} \
		${monitor:+"monitor=$monitor"} \
		${node:+"node=$node"} \
		${private:+"private=$private"} \
		${rectangle:+"rectangle=$rectangle"} \
		${split_dir:+"split_dir=$split_dir"} \
		${split_ratio:+"split_ratio=$split_ratio"} \
		${state:+"state=$state"} \
		${sticky:+"sticky=$sticky"} \
		${urgent:+"urgent=$urgent"}

	# exit script, dont send notification if set but still allow bspwm to change
	# rules
	if [ "${_send_notification}" = 0 ]; then
		unset _send_notification
		exit 0;
	fi
}
# } 1> "${HOME}/.log/brules_main.log"
# } 2>&1 | tee "${HOME}/.log/brules_main.log"
# 2>&1 | tee outfile
# } >"${HOME}/.log/brules_main.log" 2>&1
# ok, so im stealing stdout by redirecting it, that is why the rules dont work
# i want to just copy it
# exit codes
# https://shapeshed.com/unix-exit-codes/


# {{{
# _main
# i could call it twice, but then i wuld double pid wouldnt i, seems weak
# use fd3 which right now is empty and redirect it to log
# target>&source
_main 2> "${HOME}/.log/brules_main.log"
# 1> equals >
# _main 1>"${HOME}/.log/brules_main.log" 2>&1
# }}}

# https://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs

# Dunstify

# Dunstify is an alternative to the notify-send command which is completely
# compatible to notify-send and can be used alongside it, but offers some more
# features. Dunstify works only with the Dunst notification daemon.

# d_urgency="critical"
# -a seems to do nothing
# or is it only for the icon?
# tracking only this function
# you can add literal newlines with enter and escape by \
# so in order to use markup i need to remember that first i send summary and
# then body so i need 2 arguments, not one
# in body newline also works and all the other stuff
# wm_notify -u "${d_urgency}" -a "${class}" "\
# _why the fuck _dunst_dNO is empty when first called?
# here is 6 arguments for some reason -u is 1 urgency is 2
# but it can only be read if i call the function again
# so it sets it the first time function is called and can be only retrieved the
# second time, but it shows previous number of arguments, so its fucked
# wm_notify -a "${_dunst_dNO}" "_\$#: ${_dunst_dNO} $#"
# wm_notify -u "${d_urgency}" "_\$#: ${_dunst_dNO} ${_wm_notify_dNO}"
# wm_notify -u "${d_urgency}" "_\$#: ${_dunst_dNO} ${_wm_notify_dNO}" exec >"${HOME}/.log/brules_wm_notify" 2>&1
# i will solve the $# thing later, i suspect that its just set at the wrong
# time
# by writing newline and escaping \n\ i can indent the message here however i
# want
# nvermind
# wm_notify -u "${d_urgency}" A "\
# ""\
#             B
# ""\
# C
# "

# d_urgency="low"
d_urgency="normal"
# d_urgency="critical"
# -i is for full path
d_icon=""
# d_icon="qt"
# d_icon="/home/vaernil/Pictures/satimg.jpg"
# icon and icon_id is the same, why?
# wm_notify "$@"
wm_notify -a "${class}" -i "${d_icon}" "[summary]" "[body]"
exit 0
# wm_notify -t 0 -a "${class}" -i "${d_icon}" "[summary]" "[body]"
# wm_notify -h "string:bgcolor:#c8c8c8" -a "${class}" -i "${d_icon}" "[summary]" "[body]"
# wm_notify -h "byte:urgency:0" -a "${class}" -i "${d_icon}" "[summary]" "[body]"
# wm_notify -h "int:x:500" -h "byte:urgency:0 string:desktop-entry:Alacritty int:x:500 int:y:500" -a "${class}" -i "${d_icon}" "[summary]" "[body]"
# wm_notify -u "${d_urgency}" -a "${class}" -I "${d_icon}" "\
# exit 0
# ok, so appname worked with discord and using class, it shows messager avatar
# is the urgency overwritten here?

# becuase this script is called everytime an app is launched i basically
# hijacked dunst so it spawns with my wrapper, i thought some dbus instance is
# the main one, doesnt work like i thought, to investiagte
# so urgency isnt set here, the rules just dont work
wm_notify -u "${d_urgency}" -a "${class}" -i "${d_icon}" "\
|${_inrules}|
[instance.class]: ||
${instance}.${class} ||
*********************************" "\
<u>[bspwm.id]</u>: ${id} ||\n\
--------------------------------\n\
<u>[urgency]</u>: ${d_urgency} ||\n\
---------------ONE--------------\
" 2> "${HOME}/.log/brules_wm_notify"

# wm_notify -u "${d_urgency}" "_\$#: ${_dunst_dNO} ${_wm_notify_dNO}" 2>"${HOME}/.log/brules_wm_notify"
exit 0
wm_notify -u "${d_urgency}" -a "ignore" "\
|${_inrules}|" "\n
	<b>bold</b>\n
<i>%a</i>
_\$#: ${_dunst_dNO} $__DNO
--------------------------------
[instance.class]: ||
${instance}.${class} ||
--------------------------------
	[bspwm.id]: ${id} ||
--------------------------------
[urgency]: ${d_urgency} ||
---------------ONE--------------\
"
# " >>"${HOME}/.log/brules.log" 2>&1
# " >>"${HOME}/.log/brules.log" 2>&1

# debugging
# {{{
_ddebug="0"
# _ddebug="1"
# _ddebug="2"
# _ddebug="3"
# _ddebug="4"
# _ddebug="5"
# so the issue with this approach is that it copies whitespace and everything
# is fucked
if [ "${_ddebug}" -gt "0" ]; then
{
	d_urgency="critical"
	wm_notify -u "${d_urgency}" "\
	debug LEVEL: ${_ddebug}
	_\$#: ${_dunst_dNO}
	_:| _local |:_ ||| _:| STORED |:_
	\$*: _:| ${_dALLa} |:_ ||| _:| ${dALLa} |:_
	\$4: _:| $4 |:_
	------------DEBUG 1------------\
	"

	if [ "${_ddebug}" -gt "1" ]; then
	{
		wm_notify -u "${d_urgency}" "\
		_local = STORED = \$X\
		------------------------------------------\
		${dOPTS} = $-\
		${_dNO} = ${dNO} = $#
		${dPIDs} = $$
		${dPIDb} = $!
		${dPIPE} = $?
		--------------
		${instance}.${class} = $3.$2
		------------DEBUG 2------------\
		"

		if [ "${_ddebug}" -gt "2" ]; then
		{
			wm_notify -u "${d_urgency}" "
			_\$!= ${_pidlast}
			\$!= $!
			_\$\$= ${_dpid}
			\$\$=$$
			------------------------------------------
			$(wmhelp --echo)
			------------DEBUG 3------------\
			"

			if [ "${_ddebug}" -gt "3" ]; then
			{
				wm_notify -u "${d_urgency}" "
				_\$!= ${_pidlast}
				\$!= $!
				_\$\$= ${_dpid}
				\$\$=$$
				------------------------------------------
				$(wmhelp --pid1)
				$(wmhelp --pid2)
				$(wmhelp --pid3)
				------------DEBUG 4------------\
				"

				if [ "${_ddebug}" -gt "4" ]; then
				{
					# flags debug
					wm_notify -u "${d_urgency}" "
					\$state=${state}
					\$*=${_newflags}
					------------DEBUG 5------------\
					"
				}
				fi
			}
			fi
		}
		fi
	}
	fi
} >>"${HOME}/.log/debug-rules-dunst.log" 2>&1
fi
# }}}
exit 0
# function debugger
# vim: set ft=sh
