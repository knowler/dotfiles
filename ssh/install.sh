#!/usr/bin/env bash

# Add base config if one doesn’t already exist
[ -s "$HOME/.ssh/config" ] && cp config $HOME/.ssh/config
