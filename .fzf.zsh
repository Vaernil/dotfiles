# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vaernil/soft/fzf/bin* ]]; then
  export PATH="$PATH:/home/vaernil/soft/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/vaernil/soft/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/vaernil/soft/fzf/shell/key-bindings.zsh"

