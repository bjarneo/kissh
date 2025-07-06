# directory
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# docker
alias d='docker'

# eza replacement for ls
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# git
alias gco='git checkout'

# kubectl
alias k='kubectl'

# xclip
alias xclip='xclip -selection clipboard'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# zoxide
if command -v zoxide &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  else
    eval "$(zoxide init bash)"
  fi

  alias cd='z'
  alias cdi='zi'
fi
