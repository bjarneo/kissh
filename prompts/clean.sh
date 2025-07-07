# Check if running in Bash
if [ -n "$BASH_VERSION" ]; then
  # Color for the prompt icon (a subtle, cool grey)
  COLOR_ICON='\[\033[38;5;244m\]'
  COLOR_RESET='\[\033[0m\]'

  # The prompt: A single icon followed by the prompt symbol
  export PS1="$COLOR_ICON❯$COLOR_RESET "
fi

# Check if running in Zsh
if [ -n "$ZSH_VERSION" ]; then
  # Use zsh's built-in color system for better compatibility
  autoload -U colors && colors
  
  # Set colors using zsh's color system
  COLOR_ICON="%{$fg[green]%}"
  COLOR_RESET="%{$reset_color%}"

  # Set PS1 for zsh
  export PS1="${COLOR_ICON}❯${COLOR_RESET} "
fi

