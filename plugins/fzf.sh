if command -v fzf &>/dev/null; then
  if [[ -f /usr/share/bash-completion/completions/fzf ]]; then
    source /usr/share/bash-completion/completions/fzf
  fi
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
  fi
fi
