if command -v fzf &>/dev/null; then
  # Try to find and source fzf completion based on common installation locations
  FZF_COMPLETION_PATHS=(
    "/usr/share/bash-completion/completions/fzf"
    "/usr/local/share/bash-completion/completions/fzf"
    "/opt/homebrew/share/bash-completion/completions/fzf"
    "$HOME/.fzf/shell/completion.bash"
  )
  
  for path in "${FZF_COMPLETION_PATHS[@]}"; do
    if [[ -f "$path" ]]; then
      source "$path"
      break
    fi
  done
  
  # Try to find and source fzf key bindings
  FZF_KEYBINDING_PATHS=(
    "/usr/share/doc/fzf/examples/key-bindings.bash"
    "/usr/share/fzf/key-bindings.bash"
    "/usr/local/share/fzf/key-bindings.bash"
    "/opt/homebrew/share/fzf/key-bindings.bash"
    "$HOME/.fzf/shell/key-bindings.bash"
  )
  
  for path in "${FZF_KEYBINDING_PATHS[@]}"; do
    if [[ -f "$path" ]]; then
      source "$path"
      break
    fi
  done
  
  # For zsh, try zsh-specific paths
  if [ -n "$ZSH_VERSION" ]; then
    FZF_ZSH_COMPLETION_PATHS=(
      "/usr/share/zsh/site-functions/_fzf"
      "/usr/local/share/zsh/site-functions/_fzf"
      "/opt/homebrew/share/zsh/site-functions/_fzf"
      "$HOME/.fzf/shell/completion.zsh"
    )
    
    for path in "${FZF_ZSH_COMPLETION_PATHS[@]}"; do
      if [[ -f "$path" ]]; then
        source "$path"
        break
      fi
    done
    
    FZF_ZSH_KEYBINDING_PATHS=(
      "/usr/share/fzf/key-bindings.zsh"
      "/usr/local/share/fzf/key-bindings.zsh"
      "/opt/homebrew/share/fzf/key-bindings.zsh"
      "$HOME/.fzf/shell/key-bindings.zsh"
    )
    
    for path in "${FZF_ZSH_KEYBINDING_PATHS[@]}"; do
      if [[ -f "$path" ]]; then
        source "$path"
        break
      fi
    done
  fi
fi
