# Git Aliases
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gst='git status'
alias gs='git status -s'
alias gp='git pull'
alias gpush='git push'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gm='git merge'
alias gr='git rebase'
alias gl='git log --oneline --graph --decorate'
alias gf='git fetch'
alias gd='git diff'
alias gds='git diff --staged'


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
