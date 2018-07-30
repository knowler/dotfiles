#!/bin/bash 

################################################################
# Git Helpers  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  # 
################################################################

# Quickly change to a sub-directory within the git project
#
gd() {
  fd --type d --hidden --follow --exclude .git | fzf | read result && cd $result
  clear
}

# Jump to git root
#
gr() { 
  cd $(git rev-parse --show-toplevel) 
  clear
}

# Add all files
#
ga() { 
  git add . 
}

# Commit
#
gc() {
  git commit
}

# Commit all
#
gca() {
  git commit -a
}

# Commit with one-line message
#
gcm() {
  git commit -m "$@"
}

# Commit all with one-line message
#
gcam() {
  git commit -am "$@"
}

# Checkout branch or list
#
gb() {
  if [ "$1" ]; then
    git checkout $1
  else
    git branch -v
  fi
}

# Ignore or open ignore
#
gi() {
  local gitroot=`git rev-parse --show-toplevel`

  if [ "$1" ]; then
    echo "$1" >> $gitroot/.gitignore
  else
    vi $gitroot/.gitignore
  fi
}

# Preview file + see changes
#
gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# fuzzy multi-select modified file
gfmod() {
  git ls-files -m | fzf -m
}

# stage files multi-selected modified files
gfadd() {
  git add $(gfmod)
}
