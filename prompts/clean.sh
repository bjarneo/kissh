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
    # Example: Different color for other terminals (e.g., standard green)
    # Using tput for more robust color codes if available, otherwise direct ANSI
    if command -v tput >/dev/null; then
        COLOR_ICON="$(tput setaf 2)" # Green foreground
        COLOR_RESET="$(tput sgr0)"   # Reset attributes
    else
        COLOR_ICON='\033[32m' # Standard green ANSI
        COLOR_RESET='\033[0m'
    fi

    # Set PS1 for other terminals
    export PS1="$COLOR_ICON❯$COLOR_RESET "
fi