# Executes commands at the start of an interactive session.
 
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Autoload scripts
source "$HOME/.scripts/autoload.sh"

# Aliases
alias vi="nvim"
alias goyo="nvim +Goyo +'set ft=markdown'"
alias ls="exa -l --group-directories-first --icons"
alias la="exa -la --group-directories-first --icons"
alias o="open"
alias simctl="xcrun simctl"

eval "$(starship init zsh)"
eval "$(trellis shell-init zsh)"
eval "$(direnv hook zsh)"
eval "$(pyenv init -)"
