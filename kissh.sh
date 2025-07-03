#!/bin/bash

# Path to your custom bash framework
export KISSH=~/.kissh

# Load all enabled plugins
for plugin in ~/.kissh/plugins/*.plugin.sh; do
  if [ -f "$plugin" ]; then
    source "$plugin"
  fi
done

# Load the selected theme
if [ -n "$KISSH_THEME" ] && [ -f "$KISSH/themes/$KISSH_THEME.theme.sh" ]; then
  source "$KISSH/themes/$KISSH_THEME.theme.sh"
fi

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
