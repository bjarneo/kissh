# Completion
# Auto Completion
# macOS
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
# Linux
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

if [ -n "$BASH_VERSION" ]; then
  # History control
  shopt -s histappend
  HISTCONTROL=ignoreboth
  HISTSIZE=32768
  HISTFILESIZE="${HISTSIZE}"
fi

if [ -n "$ZSH_VERSION" ]; then
  # History control for zsh
  setopt HIST_APPEND
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE
  setopt SHARE_HISTORY
  HISTSIZE=32768
  SAVEHIST=32768
  
  # Key bindings for history search
  bindkey '^R' history-incremental-search-backward
  bindkey '^S' history-incremental-search-forward
fi
