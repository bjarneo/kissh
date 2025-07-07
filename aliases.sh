# directory navigation
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
else
  # Fallback to regular ls with color
  alias ls='ls --color=auto'
  alias lsa='ls -a'
fi

# git
alias gco='git checkout'

# kubectl
alias k='kubectl'

# xclip (Linux clipboard)
alias xclip='xclip -selection clipboard'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
