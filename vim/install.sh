#!/usr/bin/env bash

# Link run commands
ln -s vimrc $HOME/.vimrc

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
vim -E -c PlugInstall -c q
