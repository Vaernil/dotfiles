HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '/home/vaernil/.zshrc'
autoload -Uz compinit
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# sh completions
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
# cache for completion
zstyle ':completion::complete:*' use-cache 1
source ~/dev/powerlevel9k/powerlevel9k.zsh-theme
################
# powerlevel9k
################
POWERLEVEL9K_PROMPT_ON_NEWLINE=true							# double prompt line
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true						# new line after prompt
POWERLEVEL9K_COLOR_SCHEME='dark'
# theme/colors
POWERLEVEL9K_TIME_BACKGROUND='8'
POWERLEVEL9K_TIME_FOREGROUND='1'
# vcs
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'

