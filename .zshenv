#!/bin/sh
       # Commands	 are  first  read from /etc/zshenv; this cannot be overridden.
       # Subsequent behaviour is modified by the RCS and GLOBAL_RCS options; the
       # former  affects all startup files, while the second only affects global
       # startup files (those shown here with an path starting with  a  /).   If
       # one  of	the  options  is  unset	 at  any point, any subsequent startup
       # file(s) of the corresponding type will not be read.  It is also	possi‐
       # ble  for	 a  file  in  $ZDOTDIR	to  re-enable GLOBAL_RCS. Both RCS and
       # GLOBAL_RCS are set by default.

       # Commands are then read from $ZDOTDIR/.zshenv.  If the shell is a	 login
       # shell,  commands	 are  read from /etc/zprofile and then $ZDOTDIR/.zpro‐
       # file.  Then, if the  shell  is  interactive,  commands  are  read  from
       # /etc/zshrc  and then $ZDOTDIR/.zshrc.  Finally, if the shell is a login
       # shell, /etc/zlogin and $ZDOTDIR/.zlogin are read.

       # When  a	login  shell  exits,  the  files  $ZDOTDIR/.zlogout  and  then
       # /etc/zlogout  are  read.	 This happens with either an explicit exit via
       # the exit or logout commands, or an implicit exit by reading end-of-file
       # from  the  terminal.   However, if the shell terminates due to exec'ing
       # another process, the  logout  files  are	 not  read.   These  are  also
       # affected	 by  the  RCS  and GLOBAL_RCS options.	Note also that the RCS
       # option affects the saving of history files, i.e. if RCS is  unset  when
       # the shell exits, no history file will be saved.

       # If ZDOTDIR is unset, HOME is used instead.  Files listed above as being
       # in /etc may be in another directory, depending on the installation.

       # As /etc/zshenv is run for all instances of zsh, it is important that it
       # be  kept as small as possible.  In particular, it is a good idea to put
       # code that does not need to be run for every single shell behind a  test
       # of the form `if [[ -o rcs ]]; then ...' so that it will not be executed
       # when zsh is invoked with the `-f' option.

       # Any of these files may be pre-compiled with the zcompile	 builtin  com‐
       # mand  (see  zshbuiltins(1)).   If a compiled file exists (named for the
       # original file plus the .zwc extension) and it is newer than the	origi‐
       # nal file, the compiled file will be used instead.


#
# Generic .zshenv file for zsh
#
# .zshenv is sourced on ALL invocations of the shell, unless the -f option is
# set.  It should NOT normally contain commands to set the command search path,
# or other common environment variables unless you really know what you're
# doing.  E.g. running "PATH=/custom/path gdb program" sources this file (when
# gdb runs the program via $SHELL), so you want to be sure not to override a
# custom environment in such cases.  Note also that .zshenv should not contain
# commands that produce output or assume the shell is attached to a tty.
#

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshenv, NOR WITHOUT EDITING
# return 0	# Remove this line after editing this file as appropriate

# This kludge can be used to override some installations that put aliases for
# rm, mv, etc. into the system profiles.  Just be sure to put "unalias alias"
# in your own rc file(s) if you use this.
# alias alias=:

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
#
#
# is only sourced if we are a login shell).
# from bashrc
# if [[ $- != *i* ]] ; then
#     # Shell is non-interactive.  Be done now!
#     return
# fi
# if not login
#

#if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
if [[ $SHLVL == 1 ]]; then
    source ${HOME}/.zpath
fi


# if [[ -o rcs ]]; then
#     export ZDOTDIR="$HOME/.config/zsh"
# fi
