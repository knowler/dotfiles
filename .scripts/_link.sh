#!/usr/bin/env bash

_link() {
  local _source=$(readlink -f $1)
  local _dest=$2

  echo "Linking $1 -> $_dest"

  # Create destination parent directories
  mkdir -p $(dirname $_dest)

  # Remove destination file if it already exists
  [ -e $_dest ] && unlink $_dest

  # Forcibly, symbolically link file
  ln -sf "$_source" "$_dest"
}
