#!/bin/sh
#
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

# $1, $2, $3, ... are the positional parameters.
# "$@" is an array-like construct of all positional parameters, {$1, $2, $3 ...}.
# "$*" is the IFS expansion of all positional parameters, $1 $2 $3 ....
# $# is the number of positional parameters.
# $- current options set for the shell.
# $$ pid of the current shell (not subshell).
# $_ most recent parameter (or the abs path of the command to start the current shell immediately after startup).
# $IFS is the (input) field separator.
# $? is the most recent foreground pipeline exit status.
# $! is the PID of the most recent background command.
numberparam="$#"

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

# you can make this prettier
# eval — construct command by concatenating arguments
#     The eval utility shall construct a command by  concatenating  arguments
#     together,  separating  each  with a <space> character.  The constructed
#     command shall be read and executed by the shell.
# eee=$(eval "$4")
# lol3=""$@ \
# ldesk=`ls` \
# almpst there but not quite, how to get current window id?
# loldesk=`xprop -id \$1 | awk '/WM_DESKTOP/{print \$3}'` \
# this shit works, captures spawned object variables
# loldesk=`xprop -id \$id` \
# loldesk=`xprop -id \$id | awk '/WM_DESKTOP/{print \$3}'` \
# loldesk=`xprop |awk '/WM_DESKTOP/{print \$3}'` \
# running command works!

# WM_WINDOW_ROLE(STRING) = "GtkFileChooserDialog"

_wm_helper() {
	_wmid="$(xdo id)"
}
discord() {
	desktop="^4"
	state="tiled"
	follow="off"
}

firefox() {
	desktop="^6"
}

gimp() {
	follow="on"
}

mplayer() {
	state="floating"
	layer="normal"
}

spotify() {
	desktop="^4"
}

steam() {
	desktop="^3"
}

chromium() {
	desktop="^2"
}

chrome() {
	desktop="^2"
	follow="off"
}

libreoffice() {
	state="tiled"
	layer="normal"
}

mpv() {
	state="floating"
	layer="normal"
	wm_cardinal="NE"
	# desktop=^10;
	# state="tiled"
	# state="pseudo_tiled"
}

feh() {
	desktop="^10"
	state="tiled"
	layer="normal"
}

pqiv() {
	# desktop=^10;
	rectangle="800x800+0+20"
	# state="floating"
	# state="pseudo_tiled"
	state="tiled"
	# layer=normal;
	# layer=above;
}

nemo() {
	desktop="^10"
}

pavucontrol() {
	# desktop=^1;
	state="floating"
	# works but not sure if right approach
	#notify-send --app-name=$class "'$class' spawned | id : $id | instance : $instance | misc : $4 "
	# hidden="on"
}

keepassxc() {
	desktop="^9"
	# hidden="on"
	# sticky="on"
}

discord() {
	desktop="^4"
	follow=off
}

alacritty() {
	_sendstop="$1"
	# desktop=^4;
	# follow=off;
	# FUNCNAME is builtin that shows the name of the
	# function it was called in
	# func="${FUNCNAME}"
	# dollar1="$1"
	# test2="LOL2"
	# loldesk=`xprop -id \$id`;
	# alltest+=$0
	# desktop=^9;
}

kitty() {
	# state="floating"
	# state="$instance"
	desktop="^5"
}

ranger() {
# rename for the sake of notifications
	class="ranger"
}
# source "${XDG_CONFIG_HOME}/wm/themes/wm_numixlike"
# top_padding="$t_pad"
# borderw="$brd_w"
########
quakeNWtest() {
	rectangle="300x200+10+21"
	state="floating"
	# -g, --rectangle WxH+X+Y
	#     Set the rectangle of the selected monitor.
}
fterm() {
	state="floating"
}

floatNW() {
	rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
	state="floating"
	#state=floating
	# state="tiled"
	# state="pseudo_tiled"
	# 1920
	# rectangle="$((1920/2-4))x1058+0+20"
	numberparam="$#"
	# id="$1"
	# class="$2"
	# instance="$3"

}

# maybe pass it through a few functions? reuse code and simplify

NW_f_quake() {
	rectangle="$((1920/2-4))x$((1080-20-2))+0+20"
	state="floating"
	#state=floating
	# state="tiled"
	# state="pseudo_tiled"
	# 1920
	# rectangle="$((1920/2-4))x1058+0+20"
	numberparam="$#"
	# id="$1"
	# class="$2"
	# instance="$3"

}
#####
# learn about positional parameters
# doubles spaces?
# wrapper for notify-send
sendnotif() {
	# ff="$FUNCNAME"
	# notify-send "$@"
	notify-send "$@"
}

# use unset or something for _NET_WM
# bspc subscribe reports state of bspwm
# debug doesnt work with app name
#
# notify-send --app-name="$class" asd
# notify-send asdf $*;
# notify-send "$@" --app-name="$class"
# notify-send --app-name="$class" "$@"
# notify-send --app-name="Pavucontrol" "$@"
# notify-send --app-name="$class" "$*"
# sendnotif --app-name="$class" "$*"
# sendnotif --app-name="$class" "'$class' spawned | id : $id | instance : $instance state:$state | test : $test test2 : $test2 d : $desktop | func:$func d1:$dollar1 ";
# you can name instance via tdrop with -n
# ranger gets class from terminal
# notify-send appname
# call function in case of class eq to
case "$instance.$class" in
	# position flags
	(NW_f_quake.*)NW_f_quake "$@";;
	(fterm.*) fterm;;
	(instancetest.*) quakeNWtest;;
	(quake50.*) ;;
	# apps
	(*.Chromium) chromium;;
	(*.Google-chrome) chrome;;
	(*.[Ff]irefox) firefox;;
	(*.[Ss]team) steam;;
	(*.Gimp) gimp;;
	(*.Spotify) spotify;;
	([lL]ibre[oO]ffice*) libreoffice;;
	(*.Nemo) nemo;;
	(*.mpv) mpv;;
	(*.feh) feh;;
	# (*.[Pp]qiv) pqiv;;
	# (*.[Pp]qiv) fNW "$*";;
	# somehow here it doubles notificiation and kitty goes through, how?
	# unless i return after the function
	#
	(*.[Pp]qiv) floatNW "$@";;
	(*.discord) discord;;
	(*.[Pp]avucontrol) pavucontrol;;
	(*.[Kk]ee[Pp]ass[Xx][Cc]) keepassxc;;
	(*.[Kk]itty) kitty ;;
	(*.[Aa]lacritty) alacritty 0;;
	# terms
	# (*.[Aa]lacritty) alacritty "f0"; test="LOL" ;;
	# (*.[Aa]lacritty) alacritty "$@" ;;
	# you can copy scripts parameters to function with $@
	# https://github.com/koalaman/shellcheck/wiki/SC2120
	# so commands and variables work both from inside function and case
	# also works but also not sure about approach
	#(*.[Pp]avucontrol) pavucontrol;notify-send --app-name=$class "'$class' spawned | id : $id | instance : $instance | misc : $4 ";;
	# other cases and then use ps to search for pid
	(.)
		case $(ps -p "$(xdo pid "$id")" -o comm= 2>/dev/null) in
			(spotify) spotify;;
		esac;;
	*)
		# _sendstop=0
		# state=$instance
	;; #notify-send --app-name=$class "'$class' spawned | id : $id | instance : $instance | misc : $4 ";;
esac
# sendnotif --app-name="$class" "'$class' spawned | id : $id | instance : $instance state:$state | test : $test test2 : $test2 d : $desktop | func:$func d1:$dollar1 $*" "asfsfa class:$class i:$instance";
# notify-send --app-name="$class" "'$class' spawned | id : $id | instance : $instance state:$state | test : $test test2 : $test2 d : $desktop | func:$func d1:$dollar1 $*" "asfsfa class:$class i:$instance";
# shows notifications always
# notify-send --app-name=$class "'$class' spawned | id : $pavucontrol.$id | instance : $instance | misc : $4 ";
# notify-send --app-name=$class "'$class' spawned | id : $id | instance : $instance | misc : $4 test : $test test2 : $test2 d : $desktop ";
# dunno why it doesnt print desktop for example here
# seems like if i don't set it its null, because of the earlier set? how to
# show current?

# _sendstop=false
# exit codes
# https://shapeshed.com/unix-exit-codes/
# if [ _sendstop ]; then
#     exit 1
# fi
# sendnotif "SUMMARY i:$instance c:$class " "BODY f:$ff ALL: $* evaltest: echo $eee" --app-name="mpv.png" --icon="/usr/share/icons/hicolor/16x16/apps/mpv.png";
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
	${urgent:+"urgent=$urgent"};
	# ${urgent:+"urgent=$urgent"};

# https://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
# exit script, dont send notification if set but still allow bspwm to change
# rule
# find a way to put it in a function
if [ "$_sendstop" = 0 ]; then
	exit 1;
fi
# sendnotif "SUMMARY i:$instance c:$class " "BODY all:$* $_sendstop"
sendnotif "number=$numberparam SUMMARY i:$instance c:$class " "BODY id:$id $_sendstop";
# notify-send "	number=$number SUMMARY i:$instance c:$class " "BODY id:$id $_sendstop";
exit 0
# sendnotif "SUMMARY i:$instance c:$class " "BODY id:$id $_sendstop $(printf "$id")"
# wait
# sendnotif -h int:value:50 "SUMMARY i:$instance c:$class " "BODY id:$id $_sendstop $(print "$id")"
# could I overwrite things with echo or printf?
# notify-send [OPTION…] <SUMMARY> [BODY] - create a notification

# vim: set ft=sh :
