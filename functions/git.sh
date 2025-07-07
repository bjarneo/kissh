# A function to show the current git branch in the prompt
function git_branch() {
  if ! command -v git &>/dev/null; then
    return 1
  fi

  # Check if we're in a git repository
  if ! git rev-parse --git-dir &>/dev/null; then
    return 1
  fi

  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# A function to show a '*' if the working directory is dirty
function git_dirty() {
  if ! command -v git &>/dev/null; then
    return 1
  fi

  # Check if we're in a git repository
  if ! git rev-parse --git-dir &>/dev/null; then
    return 1
  fi

  if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "*"
  fi
}
