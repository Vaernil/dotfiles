################################
###				PROMPT - powerlevel9k
################################
ZLE_RPROMPT_INDENT=0											# fixes gap terminal - rprompt
# cant expand this way

#typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=( prompt_char )
#
typeset -g POWERLEVEL9K_MODE="nerdfont-complete"
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true								# double prompt line
typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false							# same line right prompt
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false							# new line after prompt
# segments
# theme - colors & icons
typeset -g POWERLEVEL9K_CONTEXT_PREFIX=''
typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='1'
typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='8'
#POWERLEVEL9K_CONTEXT_TEMPLATE='%B%n%b@%m'
# dir - colors
typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND='8'
typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND='1'
typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='8'
typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='1'
typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='8'
typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='7'
# dir - icons
typeset -g POWERLEVEL9K_DIR_BACKGROUND='8'
typeset -g POWERLEVEL9K_DIR_FOREGROUND='14'
typeset -g POWERLEVEL9K_HOME_ICON=' \uf015 '								#    #
typeset -g POWERLEVEL9K_HOME_SUB_ICON=' \ue5fe '							#    #
typeset -g POWERLEVEL9K_FOLDER_ICON=' \ue5ff '								#    #
# rbenv
# vcs
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='15'
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='7'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='1'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='8'
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='2'
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='9'
# vcs - icon
typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=' \uf408 '						#    #
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue0a0 '							#    #
#POWERLEVEL9K_VCS_UNSTAGED_ICON='\uf06a' 									#    #
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf059'						#    #
# status debating between 237 and 15
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='6'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='0'
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND='237'
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='1'
# root indicator - colors
typeset -g POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND='14'
typeset -g POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND='0'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='0'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND='1'
# root indicator - icon
typeset -g POWERLEVEL9K_ROOT_ICON=' \uf292 '								#    #
# time - colors
typeset -g POWERLEVEL9K_TIME_BACKGROUND='8'
typeset -g POWERLEVEL9K_TIME_FOREGROUND='1'
typeset -g POWERLEVEL9K_TIME_PREFIX=''
#COMPLETION_WAITING_DOTS="true"
# separator - icons
#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\ue0b8'
#POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\ue0bd'
#PSEP=$'\u2772'
PSEP=$'\u3012'
PSL=$'\uff62'
PSR=$'\uff63'
P1LEFT=$'\ue0ba '															#    #
P2LEFT=$'\ue0bc '															#    #
P1RIGHT=$'\ue0b8 '															#    #
P2RIGHT=$'\ue0be '															#    #
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_BACKGROUND="1"
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="8"
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_BACKGROUND="8"
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="6"
  # Default prompt symbol.
#POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION=$'\u262c'
#POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_BACKGROUND=3
#POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND=white
#typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND="7"
#typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION=$'\u2756'
#typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION=$'\u2756'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION=$'\u2756'
#POWERLEVEL9K_PROMPT_CHAR_ERROR}_VIINS_CONTENT_EXPANSION='I'
  # Prompt symbol in command vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='C'
#  # Prompt symbol in visual vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
#  #typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
#  # Prompt symbol in overwrite vi mode.
####**** PROMPT ELEMENENTS ****
#POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
#function prompt_p1left() {
	#p10k segment -b 0 -f 1 -i '' -t ''
#}
#function prompt_p2left() {
	#p10k segment -b 0 -f 1 -i '' -t ''
#}
# User-defined prompt segments can be customized the same way as built-in segments.
# typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=3
# typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
# only prrompt whitespace. meaning the first thing
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=' '
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{1}%K{}$P1LEFT%f%k"
#typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{1}%K{black}$P2LEFT%f%k%F{11}%K{black}$PSR%f%k "
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX="%F{1}%K{black}$P1RIGHT%f%k"
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX="%F{1}%K{black}$P2RIGHT%f%k"
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=8
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(p1left prompt_char context dir rbenv vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(timewarrior taskwarrior todo status root_indicator background_jobs aws aws_eb_env time)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs aws aws_eb_env time newline core)
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
