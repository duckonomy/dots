# Setup fzf
# ---------
if [[ ! "$PATH" == */home/duckwho/.fzf/bin* ]]; then
  export PATH="$PATH:/home/duckwho/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/duckwho/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/duckwho/.fzf/shell/key-bindings.bash"

