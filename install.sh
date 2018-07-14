#!/bin/bash

CWD=$(pwd)

# Add my junky zsh run commands
ln -sf ${CWD}/zshrc ~/.zshrc
ln -sf ${CWD}/vimrc ~/.vimrc
ln -sf ${CWD}/tmux.conf ~/.tmux.conf
ln -sf ${CWD}/chunkwmrc ~/.chunkwmrc
ln -sf ${CWD}/kitty.conf ~/.config/kitty/kitty.conf
