# Completion
# Auto Completion
# macOS
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
# Linux
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

if [ -n "$BASH_VERSION" ]; then
  # History control
  shopt -s histappend
  HISTCONTROL=ignoreboth
  HISTSIZE=32768
  HISTFILESIZE="${HISTSIZE}"
fi
