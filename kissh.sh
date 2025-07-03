#!/bin/bash

# Path to your custom bash framework
export KISSH=~/.kissh

# Load all enabled plugins
for plugin in ~/.kissh/plugins/*.plugin.sh; do
  if [ -f "$plugin" ]; then
    source "$plugin"
  fi
done

# Load all aliases
for alias in ~/.kissh/aliases/*.sh; do
  if [ -f "$alias" ]; then
    source "$alias"
  fi
done

# Load all functions
for func in ~/.kissh/functions/*.sh; do
  if [ -f "$func" ]; then
    source "$func"
  fi
done

# Load the selected prompt
if [ -n "$KISSH_PROMPT" ] && [ -f "$KISSH/prompts/$KISSH_PROMPT.sh" ]; then
  source "$KISSH/prompts/$KISSH_PROMPT.sh"
fi

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Autocompletion
source /usr/share/bash-completion/bash_completion
