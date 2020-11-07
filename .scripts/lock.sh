#!/usr/bin/env bash

# Stolen from/inspired by https://github.com/rbnis/dotfiles/blob/57612f42471574d368d155ea46c9de88f4f25240/.local/bin/scripts/lock.sh

image=$(mktemp --suffix=.png)

# Capture screenshot
grim $image
# Tint + darken + blur image
convert -background 0f1117 -gamma 0.8 -blur 0x8 $image $image
# Corrupt image
corrupter $image $image

# Preview image for testing with --test otherwise lock
if [[ "$1" == "--test" ]]; then
  feh $image
else
  swaylock -i $image -s center
fi
