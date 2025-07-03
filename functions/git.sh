# A function to show the current git branch in the prompt
function git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# A function to show a '*' if the working directory is dirty
function git_dirty() {
  if ! git diff-index --quiet HEAD --; then
    echo "*"
  fi
}
