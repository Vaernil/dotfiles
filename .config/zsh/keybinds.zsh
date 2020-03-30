#!/usr/bin/env zsh
# Enable Vi mode in terminal. (Default: bindkey -e)
# basicaly selecy keymap viins
bindkey -v
# make some bind to scroll terminal page
# http://zsh.sourceforge.net/Intro/intro_10.html#SEC10
# http://zsh.sourceforge.net/Intro/intro_11.html#SEC11
# https://unix.stackexchange.com/questions/116562/key-bindings-table
# emacs  EMACS emulation
# viins  vi emulation - insert mode
# vicmd  vi emulation - command mode
# viopp  vi emulation - operator pending
# visual vi emulation - selection active
# isearch
#    incremental search mode
# command
#    read a command name
# .safe  fallback keymap
#
#
# bindkey -rpM viins '^['

#              will remove all bindings in the vi-insert keymap beginning	 with  an  escape
#              character (probably cursor keys), but leave the binding for the escape char‐
#              acter itself (probably vi-cmd-mode).  This is incompatible with  the  option
#              -R.
# bindkey -l
# lists keymap names
# bindkey -lL main
# shows whats linked to main keymap
# bindkey -M <keymap> all bindings in a given keymap
# man zshzle
# In insert mode, type use <C-v> follow by a key to check the keycode
# Inherit some useful emac mode commands
# insert mode ctrl + shift
# in nvim its just ctrl, make it consistent
# in nvim im moving around with alt,
# alt+k and i is doubling ctrl n p functionality which is previous history
# reading the codes
# ^ ctrl  ^[ alt [UPPERCASE alt+shift rethink ctrl h so its backspace again
# ctrl w kills a word ctrl b is default i think
# movement
# it translates the codes?
# in string out string with -s ?
# CTRL V helps find the characters
# showkey -a is even better
# ESCAPE
# bindkey "hh" vi-cmd-mode

# just keep default C-h as <ESC>
# "^H" autopair-delete
# bindkey -r "^H"

bindkey -r "^J"
bindkey "^J" backward-word
# is it possible to just substitute it for arrow key code?
# bindkey -s "M-J" "^[[D"
# bindkey -s "^J" "^[OD"
bindkey -r "^B"
bindkey "^B" backward-word
bindkey -r "^L"
bindkey "^L" forward-word
bindkey -r "^F"
bindkey "^F" forward-word
# ###
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
### alt+j k
bindkey -r "^[j"
bindkey "^[j" backward-char
# bindkey "^[j" vi-backward-char
bindkey -r "^[l"
bindkey "^[l" forward-char
# bindkey "^[l" vi-forward-char

# replaced alt+/ to print \ and ctrl / to |
bindkey -s "^[/" "\\"
bindkey -s "^_" "|"
# bindkey -s '\/' '\\'
# bindkey -s '\=' '|'

# fzf
bindkey -r "^R"
bindkey "^R" fzf-history-widget


# fix issue of pressing keying shift+<cr> will output M
bindkey "^[OM" accept-line

# C-Z a toggle behaviour
fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
	fg
  else
	zle push-input
  fi
}

# shell function make into a widget
zle -N fg-bg
bindkey "^Z" fg-bg

jump_to_file_dir() {
	file_path="${LBUFFER}$(__fsel)"
	cd $(dirname $file_path)
	zle fzf-redraw-prompt
}
zle -N jump_to_file_dir
bindkey -r "^G"
bindkey "^G" jump_to_file_dir
# consider changing to escape

# cd.. Use fzf-tmux to cd into one of its parent/ancenstor dir
# cd..() {
#   local declare dirs=()
#   get_parent_dirs() {
#     if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
#     if [[ "${1}" == '/' ]]; then
#       for _dir in "${dirs[@]}"; do echo $_dir; done
#     else
#         get_parent_dirs $(dirname "$1")
#     fi
#   }
#     local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
#     cd "$DIR"
# }
# zle -N cd..
# change to something else later
# bindkey -r "^H"
# bindkey "^H" cd..
