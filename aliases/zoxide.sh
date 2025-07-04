if command -v z &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  else
    eval "$(zoxide init bash)"
  fi

  alias cd='z'
  alias cdi='zi'
fi
