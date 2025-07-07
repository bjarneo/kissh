# zoxide - A smarter cd command
if command -v zoxide &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  else
    # Fallback to bash for other POSIX shells
    eval "$(zoxide init bash)"
  fi

  alias cd='z'
  alias cdi='zi'
fi 