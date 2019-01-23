# Setup fzf
# ---------
if [[ ! "$PATH" == */home/duckonomy/.fzf/bin* ]]; then
  export PATH="$PATH:/home/duckonomy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/duckonomy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/duckonomy/.fzf/shell/key-bindings.zsh"
