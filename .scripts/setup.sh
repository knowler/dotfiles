#!/usr/bin/env bash

# Work in progress...

# macOS install
if [[ $OSTYPE =~ "darwin" ]]; then
  echo "Install for macOS"

  # Install Homebrew (also installs Xcode CLT)
  which brew &>/dev/null
  if [[ $? == 1 ]]; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
  fi

  # Install Homebrew bottles and casks
  brew bundle install --global --cleanup
fi 


# Linux install
if [[ $OSTYPE =~ "linux" ]]; then
  echo "Install for Linux"

  # For Manjaro
  if [[ $(uname -r) =~ "MANJARO" ]]; then
    # Install packages
    pacman -S --needed - < $HOME/.pkglist.txt
  fi
fi

# Install Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | sh

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

# Install Node, NPM, and Yarn
which volta &>/dev/null
if [[ $? == 1 ]]; then
  volta install node@latest
  volta fetch node@lts
  volta install yarn
fi
