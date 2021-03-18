#!/usr/bin/env bash

# yabai on Big Sur requires elevated privileges for loading the script addition.
# In order to make this easier, we can create a sudoers entry for it.
echo "$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa" | sudo tee -a /private/etc/sudoers.d/yabai > /dev/null
