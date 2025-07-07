if command -v mise &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(mise activate zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(mise activate bash)"
  else
    # Fallback to bash for other POSIX shells
    eval "$(mise activate bash)"
  fi
fi
