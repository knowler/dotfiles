#!/usr/bin/env bash

GIT_DIR=$HOME/.config/git

mkdir -p $GIT_DIR

ln -s git/config $HOME/.gitconfig
ln -s git/ignore $GIT_DIR/ignore
ln -s git/template $GIT_DIR/template
