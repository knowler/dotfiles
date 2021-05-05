#!/usr/bin/env zsh

# Quickly change to any tracked sub-directory within the git work tree from
# anywhere inside the work tree

_gd() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]]; then
    work_tree=$(git rev-parse --show-toplevel)

    directory=$(echo ".\n$(fd --type d --hidden --exclude .git --base-directory=$work_tree)" | fzf --ansi --query "$1" -1 --preview "exa -T -L1 --git-ignore --group-directories-first --icons --color=always {}")

    cd "$work_tree/${directory:-$PWD}"
  fi
}

alias gg="_gd && clear"
