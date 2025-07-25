# PATH Configuration
# Add Homebrew paths for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Apple Silicon Macs (M1/M2)
  if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  fi
  
  # Intel Macs
  if [[ -d "/usr/local/bin" ]]; then
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  fi
fi

# Shell completion
# Auto completion for different systems
if [ -n "$BASH_VERSION" ]; then
  # macOS (Homebrew)
  if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
  # macOS (MacPorts)
  elif [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    source /opt/local/etc/profile.d/bash_completion.sh
  # macOS (older installations)
  elif [ -f /usr/local/etc/bash_completion ]; then
    source /usr/local/etc/bash_completion
  # Linux
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  # Fallback for other systems
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# History configuration
if [ -n "$BASH_VERSION" ]; then
  # Bash history control
  shopt -s histappend
  HISTCONTROL=ignoreboth
  HISTSIZE=32768
  HISTFILESIZE="${HISTSIZE}"
  
  # Additional useful bash options
  shopt -s checkwinsize  # Update window size after each command
  shopt -s cdspell       # Correct minor spelling errors in cd
  shopt -s dirspell      # Correct minor spelling errors in directory names
elif [ -n "$ZSH_VERSION" ]; then
  # Zsh history control
  setopt HIST_APPEND
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE
  setopt SHARE_HISTORY
  setopt HIST_VERIFY
  HISTSIZE=32768
  SAVEHIST=32768
  
  # Key bindings for history search
  bindkey '^R' history-incremental-search-backward
  bindkey '^S' history-incremental-search-forward
  
  # Additional useful zsh options
  setopt AUTO_CD        # cd to directory without typing cd
fi
