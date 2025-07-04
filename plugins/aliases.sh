#!/bin/bash

# Function to list all available aliases
_list_aliases() {
  echo "Available aliases:"
  grep -h "alias " ~/.kissh/aliases/*.sh | sed 's/^[[:space:]]*//'
}

# Function to search for an alias
_search_alias() {
  if [ -z "$1" ]; then
    echo "Usage: aliases <search_term>"
    return 1
  fi
  echo "Searching for aliases matching '$1':"
  grep -h "alias " ~/.kissh/aliases/*.sh | grep "$1" | sed 's/^[[:space:]]*//'
}

# Main function
aliases() {
  if [ -z "$1" ]; then
    _list_aliases
  else
    _search_alias "$1"
  fi
}
