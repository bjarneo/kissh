# Enable color output for common commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ag='ag --color'

# Check if the dircolors command is available
if command -v dircolors >/dev/null; then
  # Check if the user has a custom ~/.dircolors file
  if [[ -f "$HOME/.dircolors" ]]; then
    # Load the custom file
    eval "$(dircolors "$HOME/.dircolors")"
  else
    # Load the terminal's built-in color database
    eval "$(dircolors -b)"
  fi
fi
