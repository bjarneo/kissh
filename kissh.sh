#!/bin/bash

# Path to your custom bash framework
export KISSH=~/.kissh

# Load all enabled plugins
for plugin in ~/.kissh/plugins/*.sh; do
  if [ -f "$plugin" ]; then
    source "$plugin"
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

# Source environment variables if the file exists
if [ -f ~/.env_vars.sh ]; then
  source ~/.env_vars.sh
fi

# Allow scroll in terminal
tput rmcup

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"


source "$KISSH/aliases.sh"
source "$KISSH/shell.sh"
