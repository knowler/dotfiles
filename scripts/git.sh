#!/usr/bin/env bash

# Quickly change to a sub-directory within the git project
gd() {
  cd `
    fd --type d --hidden --follow --exclude .git \
    | fzf --preview "exa -T -L1 --git-ignore --group-directories-first {}"
  `
}

# Jump to git root
gr() {
  cd `git rev-parse --show-toplevel`
}

alias gg="gr && gd && clear"
