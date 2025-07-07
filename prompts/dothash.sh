#!/bin/bash

# ===================================================================
# A "FANCY" THEME WITH A DEFINED COLOR SCHEME AND GIT INTEGRATION
# ===================================================================

# -------------------------------------------------------------------
# 1. DEFINE THE COLOR SCHEME
# -------------------------------------------------------------------
# Define our color variables. This makes the PS1 string below
# much more readable and easy to customize.

# Check if we're in Bash or Zsh and set colors accordingly
if [ -n "$BASH_VERSION" ]; then
  # Bash format: \[\033[...m\]
  # The \[ and \] are important to prevent line-wrapping issues.
  
  # Bold Colors
  PROMPT_BLUE='\[\033[01;34m\]'
  PROMPT_YELLOW='\[\033[01;33m\]'
  PROMPT_GREEN='\[\033[01;32m\]'
  PROMPT_RED='\[\033[01;31m\]'
  
  # Regular Colors
  PROMPT_WHITE='\[\033[0;37m\]'
  
  # Reset to default terminal color
  PROMPT_RESET='\[\033[00m\]'
  
elif [ -n "$ZSH_VERSION" ]; then
  # Zsh format: %{...%}
  
  # Bold Colors
  PROMPT_BLUE='%{%F{blue}%B%}'
  PROMPT_YELLOW='%{%F{yellow}%B%}'
  PROMPT_GREEN='%{%F{green}%B%}'
  PROMPT_RED='%{%F{red}%B%}'
  
  # Regular Colors
  PROMPT_WHITE='%{%F{white}%}'
  
  # Reset to default terminal color
  PROMPT_RESET='%{%f%b%}'
fi

# -------------------------------------------------------------------
# 2. DEFINE DYNAMIC PROMPT ELEMENTS
# -------------------------------------------------------------------

# A function to get the current Git branch name using existing git functions
function set_git_branch() {
  # Use the existing git_branch function from functions/git.sh
  if command -v git_branch &>/dev/null; then
    local branch=$(git_branch)
    local dirty=""
    
    # Use the existing git_dirty function to check for changes
    if command -v git_dirty &>/dev/null; then
      dirty=$(git_dirty)
    fi
    
    # Set the GIT_BRANCH variable, or clear it if we're not in a git repo
    if [[ -n "$branch" ]]; then
      GIT_BRANCH="${PROMPT_YELLOW}${branch}${dirty}" # Apply yellow color here
    else
      GIT_BRANCH=""
    fi
  else
    GIT_BRANCH=""
  fi
}

# A function to get the exit code of the last command and show a symbol
function set_exit_status_symbol() {
  local exit_code=$? # Get the exit code of the last command

  if [ $exit_code -eq 0 ]; then
    # Success (exit code 0) - show a green checkmark
    EXIT_STATUS_SYMBOL="${PROMPT_GREEN}✔"
  else
    # Failure (any other exit code) - show a red cross
    EXIT_STATUS_SYMBOL="${PROMPT_RED}✖"
  fi
}

# -------------------------------------------------------------------
# 3. BUILD THE PROMPT
# -------------------------------------------------------------------

# This is the main function that builds the prompt string (PS1).
# It's called by PROMPT_COMMAND just before the prompt is displayed.
function set_prompt() {
  # Update our dynamic elements
  set_exit_status_symbol
  set_git_branch

  if [ -n "$BASH_VERSION" ]; then
    # Bash prompt
    PS1="\n"                                 # Start with a newline for a clean look
    PS1+="${EXIT_STATUS_SYMBOL} "            # Add the success/failure symbol
    PS1+="${PROMPT_BLUE}\w${PROMPT_RESET}"   # Add the current directory in blue
    PS1+="${GIT_BRANCH}"                     # Add the git branch (already has color)
    PS1+="\n"                                # Newline for the input
    PS1+="${PROMPT_WHITE}\$ ${PROMPT_RESET}" # The '$' symbol and reset
  elif [ -n "$ZSH_VERSION" ]; then
    # Zsh prompt
    PS1=$'\n'                                # Start with a newline for a clean look
    PS1+="${EXIT_STATUS_SYMBOL} "            # Add the success/failure symbol
    PS1+="${PROMPT_BLUE}%~${PROMPT_RESET}"   # Add the current directory in blue (zsh format)
    PS1+="${GIT_BRANCH}"                     # Add the git branch (already has color)
    PS1+=$'\n'                               # Newline for the input
    PS1+="${PROMPT_WHITE}%# ${PROMPT_RESET}" # The '%' symbol and reset (zsh format)
  fi
}

# -------------------------------------------------------------------
# 4. SET THE PROMPT_COMMAND
# -------------------------------------------------------------------
# This is the magic that makes it all work.
if [ -n "$BASH_VERSION" ]; then
  # Bash executes this command right before it displays each new prompt
  PROMPT_COMMAND="set_prompt"
elif [ -n "$ZSH_VERSION" ]; then
  # Zsh uses precmd hook
  autoload -U add-zsh-hook
  add-zsh-hook precmd set_prompt
fi
