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

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPS="--ansi"

export VOLTA_HOME="$HOME/.volta"

# Path exports
export PATH="$VOLTA_HOME/bin:$HOME/.local/bin:$PATH"

# Autoload scripts
source "$HOME/.scripts/autoload.sh"

# Aliases
alias vi="nvim"
alias ls="exa -l --group-directories-first --icons"
alias la="exa -la --group-directories-first --icons"
alias o="open"

eval "$(starship init zsh)"
eval "$(trellis shell-init zsh)"
