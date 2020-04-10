#!/bin/bash

#!/bin/sh

# debug
set -x
# not sure if its POSIX because of variable expansion for now
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
# are the backslashes needed?
border="" \
center="" \
class="$2" \
desktop="" \
focus="" \
follow="" \
hidden="" \
id="${1?}" \
instance="$3" \
layer="" \
locked="" \
manage="" \
marked="" \
monitor="" \
node="" \
private="" \
rectangle="" \
split_dir="" \
split_ratio="" \
state="" \
sticky="" \
urgent=""
_testd4="$4"
_testd5="$5"
# so $4 is a string containing all the flags and variables
} >"${HOME}/.log/brules_param.log" 2>&1
# this is awesome, way better debugger
# truncated so it only shows last command
################################################################################
# you can make this prettier
# eval — construct command by concatenating arguments
#     The eval utility shall construct a command by  concatenating  arguments
#     together,  separating  each  with a <space> character.  The constructed
#     command shall be read and executed by the shell.
# eee=$(eval "$4")
# almpst there but not quite, how to get current window id?
# loldesk=`xprop -id \$1 | awk '/WM_DESKTOP/{print \$3}'` \
# this shit works, captures spawned object variables
# loldesk=`xprop -id \$id` \
# loldesk=`xprop -id \$id | awk '/WM_DESKTOP/{print \$3}'` \
# loldesk=`xprop |awk '/WM_DESKTOP/{print \$3}'` \

# WM_WINDOW_ROLE(STRING) = "GtkFileChooserDialog"
################################################################################
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
	_bashpid="${BASHPID}"
	_wmid="$(xdo id)"
	_wmid2="$(xdo id "${id}")"
	# if called from dunst they show pid of what that notification si for, ie
	# term
	_wmpid="$(xdo pid)"
	_wmpid2="$(xdo pid "${id}")"
	_wmpid3="$(xdo pid "${_id}")"
	# arguments
	case "${1}" in
		(--echo)
			echo "x.id   = ${_wmid} | x.pid   = ${_wmpid}"
			echo "x.id.id= ${_wmid2}| x.pid.id= ${_wmpid2}"
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
d_urgency="normal"
# d_urgency="critical"

## apps {{{
# maybe set once and forget? its just init thats important in browser cases
	discord() {
		desktop="^4"
		state="tiled"
		follow="off"
	}

	## browser
	firefox() {
		desktop="^9"
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
		# layer=normal;
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
		# i could also control dunst via its arguments , no need for _sendstop
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
	if [ -z "${2}" ]; then
		# %
		_p="${2}"
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
			_yset="20"
		;;
		([Ss])
			_yset="20"
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
		# works but not sure if right approach
		#notify-send --app-name=$class "'$class' spawned | id : $id | instance : $instance | misc : $4 "
		# hidden="on"
	}

	# utility
	keepassxc() {
		# desktop="^9"
		state="floating"
		# hidden="on"
		# sticky="on"
	}

	# chat
	discord() {
		desktop="^4"
		follow="off"
	}

	# terminals
	alacritty() {
		_sendstop="$1"
		# desktop="^4";
		# follow=off;
		# change it to tile, consolidate and make it sane
		# seems that without it it sometimes inherits flaoting for some reason
		# to investigate
		# state="floating"
		# FUNCNAME is builtin that shows the name of the
		# function it was called in
		# func="${FUNCNAME}"
		# dollar1="$1"
		# test2="LOL2"
		# loldesk=`xprop -id \$id`;
		# alltest+=$0
	}

	kitty() {
		state="floating"
		# state="$instance"
	}
# }}}

########
term() {
	_sendstop="$1"
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
		# every elese default to null because tdrop interferes with it
		(*)
			state=""
		;;
	esac
	# state="tiled"
	# state="pseudo_tiled"
}
	# tdrop -a rofi
	# tdrop -am -n q50keep --class=quake50Skp keepassxc

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
	_dno="$#"
	rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
	state="floating"
	#state=floating
	# state="tiled"
	# state="pseudo_tiled"
	# rectangle="$((1920/2-4))x1058+0+20"
	# id="$1"
	# class="$2"
	# instance="$3"
}

# maybe pass it through a few functions? reuse code and simplify
quake50S() {
	_dno="$#"
	rectangle="$((1920-2))x$((1080/2-20-2))+0+$((1080/2+20))"
	state="floating"
	# class="$1"
}

NW_f_quake() {
	_dno="$#"
	rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
	state="floating"
	#state=floating
	# state="tiled"
	# state="pseudo_tiled"
	# 1920
	# rectangle="$((1920/2-4))x1058+0+20"
	# id="$1"
	# class="$2"
	# instance="$3"

}
#####
# _notifsilent() {
#     case "${1}" in
#         1 | [Yy][Ee][Ss] | [Oo][Nn] | [Tt][Rr][Uu][Ee] )
#             _sendstop="1"
#         ;;

#         *)
#             _sendstop="0"
#         ;;
#     esac
# }

# just testing how to collect other function variables and information?

# dunst
# wrapper for notify-send / dunstify
_notif() {
# debug
	# _f="${FUNCNAME}"
	# _f="${FUNCNAME[1]}"
	# seems its consistent with $$
	# _dunst_pid="${$}"
	_dNO="$#"
	_d1="$1"
	# doesn't show, is it because of the scope or IFS or smth else?
	# _dALL="$@"
	_dALL=( "$@" )
	_dALLa="$*"
	dunstify "$@"
}

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
# {{{
case "${instance}.${class}" in
	# (quakenvim.*) term "$@" ;;
	(quakenvim.*) term 1 -f ;;
	# (quake50Skp.*) quake50S;;
	# (qsouth.*) term_f ;;
	(*.qsouth) term_f ;;
	# (*.quake50Skp) quake50S;;
	# position flags

	(NW_f_quake.*) NW_f_quake "$@" ;;
	(term_f.*) term_f ;;
	(*.[Rr]anger) ranger ;;
	(instancetest.*) quakeNWtest ;;
	# should set the position as parameters to function or call external
	# program,
	(*.classtest) quaketest NW 33 ;;
	(quake50.*) ;;
	(*.[Kk]ee[Pp]ass[Xx][Cc]) quake50S ;;
	# (*.[Kk]ee[Pp]ass[Xx][Cc]) keepassxc;;
	# (quake50Skp.*) quake50S "${@}" ;;
	# (quake_50S.*) quake_50S "${@}" ;;
	# (*.keepassxc) quake_50S;;
	# (quake_50S-keepass.*) keepassxc;;
	# (*.quake50S) quake50S "${@}" ;;
	# if called via shell then?
	# (*.[Kk]ee[Pp]ass[Xx][Cc]) quake_50S;;
	# (*.[Kk]ee[Pp]ass[Xx][Cc]) quake_50S "$@" ;;
	# apps
	(*.Chromium) chromium ;;
	(*.Google-chrome) chrome ;;
	(*.[Ff]irefox) firefox ;;
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
	(*.[Pp]avucontrol) pavucontrol ;;
	# terminals
	# (*.[Aa]lacritty) alacritty 1 ;;
	# (*.[Aa]lacritty) term "$@" ;;
	(*.[Aa]lacritty) term 1 -t ;;
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
		# _sendstop=0
		# state=$instance
	;;
esac >>"${HOME}/.log/brules_case.log" 2>&1

# seems like if i don't set it its null, because of the earlier set? how to
# show current?
# }}}

# exit codes
# https://shapeshed.com/unix-exit-codes/
# make it prettier? don't even echo if it's empty?

# ${parameter:+word}
# Use Alternate Value. If 'parameter' is null or unset,
# nothing is substituted, otherwise 'word' (which may be an expansion) is
# substituted.

# main echo make a function? or something?
# {{{
# it seems that putting it in a block breaks it
# using "" also breaks it
# so its extra whitespace problem
# it also need precisely the number of parameters it already has
# {
# echo "\
# _notif -u "critical" "
# _:| _local |:_ ||| _:| STORED |:_
# \$*: _:| ${_dALLa} |:_ ||| _:| ${dALLa} |:_
# "
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
# "
# I dont think ';' is needed
# } >"${HOME}/.log/brules_echo_final.log" 2>&1
# }}}

# how can i know catch changed flags? will $* suffice?
# it will not suffice
_newflags="$*"
# &>>"${HOME}/.log/brules_case.log"
# https://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs

# Dunstify

# Dunstify is an alternative to the notify-send command which is completely
# compatible to notify-send and can be used alongside it, but offers some more
# features. Dunstify works only with the Dunst notification daemon.

# exit script, dont send notification if set but still allow bspwm to change
# rules
# find a way to put it in a function
if [ "${_sendstop}" = 0 ]; then
	unset _sendstop
	exit 0;
fi

# d_urgency="critical"
# -a seems to do nothing
# or is it only for the icon?
# tracking only this function
# you can add literal newlines with enter and escape by \
_notif -u "${d_urgency}" -a "${class}" "\
|${_inrules}|
--------------------------------
instance.class: ||
${instance}.${class} ||
--------------------------------
bspwm.id: ||
${id} ||
--------------------------------
urgency: ${d_urgency} ||
--------------------------------\
" >>"${HOME}/.log/brules.log" 2>&1

# debugging
# {{{
_ddebug="0"
_ddebug="1"
# _ddebug="4"
if [ "${_ddebug}" -gt "0" ]; then
{
d_urgency="critical"
# seems that $_ sends last notification's arguments
# curious when it was split into 2 sets of strings it was sending only the last
# one
# what is pid in this context? current shell but why does it change ?

# _local means function arguments
# soted seems to be always equal to S*
# it seems that i lose the state and the other variables once it arrives here,
# why?
# kk, because thats inital state of flags
_notif -u "${d_urgency}" "
_:| _local |:_ ||| _:| STORED |:_
\$*: _:| ${_dALLa} |:_ ||| _:| ${dALLa} |:_
\$4: _:| $4 |:_
"
# _notif -u "${d_urgency}" "
# _:| _local |:_ ||| _:| STORED |:_ ||| _:| \$X |:_
# \$*: _:| ${_dALLa} |:_ ||| _:| ${dALLa} |:_ ||| _:| $* |:_
# "
# \$@: ${_dALL[1]} || ${dALL[1]} || ${[1]}
# so pid of this notification is saved value of $$?
# thought it seems that $$ also works


# _notif -u "${d_urgency}" -r "$_dpid" "
# _notif -u "${d_urgency}" -r "${$}" "
_notif -u "${d_urgency}" "
_local = STORED = \$X
------------------------------------------
${dOPTS} = $-
${_dNO} = ${dNO} = $#
${dPIDs} = $$
${dPIDb} = $!
${dPIPE} = $?
--------------
${instance}.${class} = $3.$2
"

# ${_d_} = ${_}
# dno=${_dno} d1=${_nd1} f:${_f} ||

# function debugger

# application Options:
#   -a, --appname=NAME          Name of your application
#   -u, --urgency=URG           The urgency of this notification
#   -h, --hints=HINT            User specified hints
#   -A, --action=ACTION         Actions the user can invoke
#   -t, --timeout=TIMEOUT       The time until the notification expires
#   -i, --icon=ICON             An Icon that should be displayed with the notification
#   -I, --raw_icon=RAW_ICON     Path to the icon to be sent as raw image data
#   -c, --capabilities          Print the server capabilities and exit
#   -s, --serverinfo            Print server information and exit
#   -p, --printid               Print id, which can be used to update/replace this notification
#   -r, --replace=ID            Set id of this notification.
#   -C, --close=ID              Close the notification with the specified ID
#   -b, --block                 Block until notification is closed and print close reason

# read up
# bg color works and overrides the ini values from dunstrc
# _notif -u "${d_urgency}" -h string:bgcolor:#ff4444 "
#--action="replyAction,reply" "Message received"
# _notif -u "${d_urgency}" -h string:bgcolor:#ffffff "
# _notif -u "${d_urgency}" --action="replyAction,reply" "Message received" "

# replace is super cool
#--replace="${_dpid}"
# i could be using apps pid, x id, or just a random number
# and replace previous notofication or do some more creative stuff
# like volume brightness indicators or i could close it with --close
# _notif -u "${d_urgency}" --replace="${_dpid}" "

_notif -u "${d_urgency}" "
_\$!= ${_pidlast}
\$!= $!
_\$\$= ${_dpid}
\$\$=$$
------------------------------------------
$(wmhelp --echo)
"

# ${_dunst_pid}
# _notif -u "${d_urgency}" --replace="${_dpid}" "
_notif -u "${d_urgency}" "
_\$!= ${_pidlast}
\$!= $!
_\$\$= ${_dpid}
\$\$=$$
------------------------------------------
$(wmhelp --pid1)
$(wmhelp --pid2)
$(wmhelp --pid3)
"
if [ "${_ddebug}" -gt "3" ]; then
{
	# flags debug
	_notif -u "${d_urgency}" "
	\$state=${state}
	\$*=${_newflags}
	"
}
fi
# --pid2 and 3 are identical and
# x.pid.id
# is the pid of the command that was spawned by external rules

# --pid1
# x.pid is the previous command that was spawned
# but im pretty sure its due to the fact that without arguments xdo prints
# focused window

# doesn't really show all, where is state? is it gone because it's assigned?
# hxB
# 6=4
# identical pid

} >>"${HOME}/.log/debug-rules-dunst.log" 2>&1
fi
# }}}
exit 0

# _test=true
# _test=false
# _test="1"
# _test="0"
# if [ "${_test}" = 1 ]; then sendnotif "BLALBALBA"; fi
# wait

# vim: set ft=sh
