#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
alias reload="exec $SHELL -l"
alias vi=nvim
alias ls="exa -l --group-directories-first"
alias la="exa -la --group-directories-first"
# Replace tree with exa
# --git-ignore only works if ignore pattern doesn't have slashes
# See: https://github.com/ogham/exa/commit/827aa8bfc32eadf353f72b0ce41c88dc4ad411c1
alias tree='exa -T --group-directories-first --git-ignore'

if [[ $OSTYPE =~ "linux" ]]; then
  alias open="detach xdg-open"
fi

alias o="open"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dots=dotfiles

# Quickly change to a sub-directory within the git project
gd() {
  _dirs=$(fd --type d --hidden --follow --exclude .git)
  _dirs_with_base=".\n$_dirs"
  _cmd=$(echo "$_dirs_with_base" | fzf --preview "exa -T -L1 --git-ignore --group-directories-first {}")

  cd "${_cmd:-.}"
}

# Jump to git root
gr() {
  cd `git rev-parse --show-toplevel`
}

alias gg="gr && gd && clear"

killPort() {
  sudo kill $(lsof -t -i:"$1")
}

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

eval "$(starship init zsh)"
eval "$(trellis shell-init zsh)"