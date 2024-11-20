# Browser
if [[ $OSTYPE =~ "darwin" ]]; then
  export BROWSER='/Applications/Zen\ Browser.app/Contents/MacOS/zen'
fi
if [[ $OSTYPE =~ "linux" ]]; then
  export BROWSER='firefox'
fi

# Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Paths

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.{local,volta,cargo,deno,composer/vendor}/bin
  $HOME/go/bin
  /usr/local/{bin,sbin}
  $path
)

# Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Bat
export BAT_THEME=$(if [[ -x $(command -v dark-mode) && $(dark-mode status) == "on" ]]; then echo "Nord"; else echo "OneHalfLight"; fi)

# fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPS="--ansi"

# Volta
export VOLTA_HOME="$HOME/.volta"

# Do not show hints from Homebrew
export HOMEBREW_NO_ENV_HINTS=true
