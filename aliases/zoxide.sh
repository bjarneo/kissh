if command -v z &>/dev/null; then
  eval "$(zoxide init bash)"

  alias cd='z'
  alias cdi='zi'
fi
