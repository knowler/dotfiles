#!/bin/bash

CWD=$(pwd)

# Add my junky zsh run commands
ln -sf ${CWD}/zshrc $HOME/.zshrc
ln -sf ${CWD}/vimrc $HOME/.vimrc
ln -sf ${CWD}/tmux.conf $HOME/.tmux.conf
ln -sf ${CWD}/chunkwmrc $HOME/.chunkwmrc
ln -sf ${CWD}/kitty.conf $HOME/.config/kitty/kitty.conf
ln -sf ${CWD}/scripts $HOME
