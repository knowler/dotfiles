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
 
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH

alias xargs=gxargs
alias sed=gsed
export LC_ALL=en_US.UTF-8

source $HOME/scripts/old.sh
source $HOME/scripts/wp.sh
source $HOME/scripts/roots.sh
source $HOME/scripts/av.sh
source $HOME/scripts/img.sh
source $HOME/scripts/git.sh

es() {
  fd --type f . $HOME/scripts | fzf | read result && vi $result
}
