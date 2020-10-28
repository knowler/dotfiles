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

  # Install packages
  pacman -S --needed - < ./system/manjaro/packages.txt
fi


# Install Volta (a Node version manager)
which volta &>/dev/null
if [[ $? == 1 ]]; then
  curl -fsSL https://get.volta.sh/ | bash

  # Install Node, NPM, and Yarn
  volta install node
  volta install yarn
fi
