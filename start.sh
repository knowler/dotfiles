#!/usr/bin/env bash
# Loosely based on https://github.com/lawsmith/dotfiles

if [[ $OSTYPE =~ "darwin" ]]; then

  # Ask for the administrator password upfront
  sudo -v

  # Install command line tools
  if ! type_exists 'gcc'; then
    xcode-select --install
  fi

  # Install homebrew
  if ! type_exists 'brew'; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install nvm
  if ! type_exists 'nvm'; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

    # Install latest Node
    nvm install node

    # Install LTS releases
    nvm install 'lts/*'

    # Alias latest LTS release as default
    nvm alias default 'lts/*'
  fi

  # Install Rust
  if ! type_exists 'rustc'; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi

  # Install CLIs + Applications
  brew update
  brew bundle

  # Install all settings
  find . -maxdepth 2 -type f -name 'install.sh' -exec {} \;

  # Set zsh to default terminal
  chsh -s $(which zsh)
fi
