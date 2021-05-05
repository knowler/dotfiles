# Executes commands at the start of an interactive session.
 
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${ZDOTDIR:-$HOME}/.fzf.zsh"

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice atload"zpcdreplay" atclone'./zplug.zsh'
zinit light g-plane/zsh-yarn-autocompletions
zinit load wfxr/forgit

# Autoload scripts
source "${XDG_DATA_HOME:-$HOME/.local/share}/scripts/autoload.sh"

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
