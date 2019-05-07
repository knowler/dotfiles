#!/usr/bin/env bash

GIT_DIR=$HOME/.config/git

mkdir -p $GIT_DIR

ln -s config $HOME/.gitconfig
ln -s ignore $GIT_DIR/ignore
ln -s template $GIT_DIR/template
