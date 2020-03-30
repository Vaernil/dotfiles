# man zshall zshoptions
# http://zsh.sourceforge.net/Doc/Release/Options.html
# https://wiki.archlinux.org/index.php/zsh
#
# make it portable and global so root doesn't have bad options
#
# environment
DIRSTACKSIZE=20

# directories
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # removes slash when autocompleting
setopt chase_links              # resolve symlinks to their true value
setopt pushd_ignore_dups        # don't push multiple copies of the same dir
setopt pushd_to_home            # pushd with not arguments act like pushd $HOME
# setopt correct                  # try to correct spelling of commands
# setopt extended_glob            # activate complex pattern globbing
# setopt glob_dots                # include dotfiles in globbing
# unsetopt print_exit_value       # dont print return value if non-zero
# setopt prompt_subst

setopt no_beep                  # Disable sound
unsetopt beep                   # no bell on error
unsetopt hist_beep              # no bell on error in history
unsetopt list_beep              # no bell on ambiguous completion
# unsetopt bg_nice                # no lower prio for background jobs
# unsetopt clobber                # must use >| to truncate existing files
# unsetopt hup                    # no hup signal at shell exit
# unsetopt ignore_eof             # do not exit on end-of-file
# unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
# setopt notify                   # notify immediately about job status changes
# setopt monitor                  # enable shell job control

# unsetopt menu_complete          # On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately
# setopt glob_complete            # do not insert all the words resulting from the expansion but generate matches
# unsetopt flowcontrol            # ???

setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

setopt auto_pushd               # cd=push push directories of cd to the stack
setopt pushd_ignore_dups
setopt pushdminus               # invert + and - on pushd

# History should I split it into exports file or keep it here? export has env
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space        # prevent entries with space from being recorded
setopt hist_ignore_dups         # don't record duplicates
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show command with history expansion to user before running it
setopt inc_append_history       # HISTFILE is updated as soon as entered rather than waiting until the shell exits
setopt share_history

# Input/Output
# setopt correct_all              # Try to correct spelling of all arg
# setopt interactivecomments      # In interactive cli, it recognizes comments

# not sure its correct, seems the options are very local
